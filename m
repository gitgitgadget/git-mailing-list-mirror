From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui problem with version number.
Date: Fri, 27 Jul 2007 01:36:27 -0400
Message-ID: <20070727053627.GI20052@spearce.org>
References: <86odhzpg2l.fsf@lola.quinscape.zz> <20070727044634.GG20052@spearce.org> <85y7h25sg6.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIV9-0003iI-O6
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219AbXG0Fgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757146AbXG0Fgc
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:36:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53376 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894AbXG0Fgb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 01:36:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IEIV2-00074r-Ur; Fri, 27 Jul 2007 01:36:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 30BE920FBAE; Fri, 27 Jul 2007 01:36:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <85y7h25sg6.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53892>

David Kastrup <dak@gnu.org> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > David Kastrup <dak@gnu.org> wrote:
> >> Hi, git-gui does not get along with the creativeness in git
> >> versioning:
> >
> > What version of git-gui?  gitgui-0.7.5-67-g91464df and later have
> > fixes to handle all of the fun cases in git versioning.  Like the
> > one you have here.
> >  
> >> git-gui
> >> Error in startup script: expected version number but got "1.5.3.rc2.4.g726f9-dirty"
> >>     while executing
> >> "package vcompare $_git_version $vr"
> 
> The one coming with the mentioned version number.  I suspect that this
> may be a matter of the Perl libraries being used: I experience this on
> an Ubuntu Dapper, but not on other (newer) systems compiled from the
> same source.

Ah.  Junio hasn't pulled those version numbering fixes from me yet.
Because I haven't asked him to pull in a while.  That explains that.

There's no Perl involved in git-gui, except for the Perl in an
underlying Git command it might invoke.  So perhaps you were
talking about Tcl above?

Anyway, you can setup a build with the most recent 'stable
development' version of git-gui:

  git checkout -b with-new-gitgui
  git pull -s subtree git://repo.or.cz/git-gui.git

That's really all Junio does.  Although I think he does actually try
to test it briefly before pushing a final release out to the public.
Just to make sure Git hasn't broken anything really obvious in
git-gui.  ;-)

-- 
Shawn.
