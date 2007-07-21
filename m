From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Sat, 21 Jul 2007 04:03:38 -0400
Message-ID: <20070721080338.GT32566@spearce.org>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <20070720105602.7dcm241ts0k0ww88@webmail.tu-harburg.de> <20070721021717.GS32566@spearce.org> <200707210951.00210.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 10:04:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC9wa-0007zr-VV
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 10:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760338AbXGUIDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 04:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760259AbXGUIDs
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 04:03:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37490 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbXGUIDq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 04:03:46 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IC9wD-0001Sz-Fh; Sat, 21 Jul 2007 04:03:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9923720FBAE; Sat, 21 Jul 2007 04:03:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707210951.00210.stimming@tuhh.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53152>

Christian Stimming <stimming@tuhh.de> wrote:
> Thanks for the detailed feedback.

Thanks for working on this!  Its something I knew we need to do,
but hadn't brought myself to do, because I speak English, and pretty
much only English.  Unless Tcl counts.  ;-)
 
> Am Samstag, 21. Juli 2007 04:17 schrieb Shawn O. Pearce:
> >
> > Please send one patch per email message, inline and not attached.
> > This way they are easy to review, respond to and comment on.
> 
> I'll try to do that, but at the workplace where I work on this issue I'm 
> forced to use a webmailer and I have to check whether this leaves the patches 
> intact.

Can you push to the mob branch on repo.or.cz?  Or setup your own
git-gui fork repository there?  Or someplace?  If so you can still
copy and paste the message into email for quick review and comment,
but I can actually pull the Git objects from a repository, and I
know Git won't corrupt things.
 
> > Dscho recently created a fork of git-gui.git here:
> >
> >   http://repo.or.cz/w/git-gui/git-gui-i18n.git
> >
> > and added your patch series into it.  But I'd like to see some
> > cleanups before it merges in, and I want to hold off on actually
> > applying it into git-gui 0.8.0 is released, 
> 
> Was this meant to say "hold off until git-gui 0.8.0 is released"? Sure, no 
> problem.

More or less.  I'm interested in this series, so I'm happy to get the
patches.  But I won't put them into 0.8.0, as I think it is too late
in the development period.  Especially for a build system change.
I've had too many bugs because of changes to the Makefile in prior
versions of git-gui.  But I am hoping that they will be among the
very first things applied after I tag 0.8.0 and start the 0.9.0
development cycle.  :-)
 
> I'll submit an updated set of patches by beginning of next week. Thank you 
> very much for the feedback.

Thanks.

-- 
Shawn.
