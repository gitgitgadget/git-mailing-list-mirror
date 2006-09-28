From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 23:52:38 -0400
Message-ID: <20060928035238.GC22897@spearce.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com> <20060927173335.GC2807@coredump.intra.peff.net> <451B45D6.1010006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 05:52:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSmx6-0006ij-64
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 05:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWI1Dwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 23:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWI1Dwp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 23:52:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:24549 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751307AbWI1Dwo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 23:52:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSmwm-0002Rl-Cf; Wed, 27 Sep 2006 23:52:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A29D720FB28; Wed, 27 Sep 2006 23:52:38 -0400 (EDT)
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <451B45D6.1010006@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27979>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> Jeff King wrote:
> [...]
> >One thing that I believe some people have requested for subprojects is
> >to avoid downloading files/history for subprojects you're not interested
> >in.  I think this could be faciliated in this scheme by only cloning the
> >heads of the subprojects you're interested in (there would need to be
> >special machinery to handle this at the root level if we want to allow
> >making root commits without necessarily having all of the subprojects).
> 
> In what I'm suggesting, commits are local to a project's working 
> directory repository and are pushed somewhere else to be recorded long 
> term. Since projects are stand alone, possibly with dependencies, 
> working on a (sub)project without having other associated (sub)projects 
> is accomplished by checking it out.
> 
> >A first step to this would be an argument to git-clone to allow cloning
> >only a subset of refs.
> 
> Something like this?
> 
> 	git-init-db
> 	git-fetch <repository> <refspecs>

More like:

 	git-init-db
 	git-fetch --keep <repository> <refspecs>

but yes.  :-)

-- 
Shawn.
