From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Many gits are offline this week
Date: Sun, 7 Oct 2007 19:09:53 -0400
Message-ID: <20071007230953.GC2137@spearce.org>
References: <20071005010448.GQ2137@spearce.org> <863awq5p1y.fsf@blue.stonehenge.com> <4d8e3fd30710050214j135260cn842ee7396a3d63c7@mail.gmail.com> <86tzp54sez.fsf@blue.stonehenge.com> <20071007170153.GX2137@spearce.org> <Pine.LNX.4.64.0710071457580.23070@iabervon.org> <Pine.LNX.4.64.0710072331050.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:10:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefGi-0002Xo-6j
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbXJGXJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755076AbXJGXJ7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:09:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58320 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbXJGXJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:09:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IefFp-0005n1-Qp; Sun, 07 Oct 2007 19:09:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ECBD820FBAE; Sun,  7 Oct 2007 19:09:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710072331050.4174@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60236>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 7 Oct 2007, Daniel Barkalow wrote:
> 
> > For that matter, gitweb is essentially a limited porcelain. And this 
> > points out that all VCSes have alternative porcelains, but git is 
> > unusual in having convenient plumbing to support and encourage this.
> 
> I do not consider viewers "porcelain".  And gitweb is essentially just a 
> viewer.

So you don't consider gitk to be porcelain?  I do.  The plumbing
output of git-rev-list is uh, ugly.  gitk may still not be the best
looking application on the internet but it sure beats looking at
rev-list output by eye.

Porcelain is really anything that calls plumbing to make the task
of invoking or processing the output of plumbing easier on the
human using it.  That's it.  Obviously you can work Git by just the
plumbing.  Just like you can compute SHA-1 by hand.  You just choose
not to as the time it would take is more than you want to invest.
Or have left in this mortal existance...

I almost always forget about the web interfaces.  There's a number
of them and I don't use them often enough to really think about it.
I don't know why I always forget about them.  I never forget about
StGit or qgit, and yet I never use those either...

-- 
Shawn.
