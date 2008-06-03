From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Tue, 3 Jun 2008 18:54:18 -0400
Message-ID: <20080603225418.GP12896@spearce.org>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com> <200806031856.11060.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imran M Yousuf <imyousuf@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:55:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3fPQ-0007Ni-0k
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 00:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbYFCWyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 18:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbYFCWyX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 18:54:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57540 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbYFCWyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 18:54:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K3fOM-0001U4-NI; Tue, 03 Jun 2008 18:54:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C26EE20FBAE; Tue,  3 Jun 2008 18:54:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200806031856.11060.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83725>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> tisdagen den 3 juni 2008 16.42.33 skrev Imran M Yousuf:
> > I have successfully Mavenized JGit (at least partially :)) to make it
> > independent of IDE to develop on. I will also add a code-file format
> > checker soon. Please have a look at it and let me know what you think
> > and how it can be improved. If its helpful I will surely send out a
> > patch in this regard. The one thing that I did not configure is the
> > external test (exttst), doing that and the code format checker is my
> > next step.
> > The 'jgit-mavenize' branch of my fork of egit contains it.
> > (http://repo.or.cz/w/egit/imyousuf.git?a=shortlog;h=refs/heads/jgit-mavenize).
> 
> An abvious problem is that JGit does not handle symbolic links and those do
> not work well (if at all) under git on windows either. Cygwin will not do here,
> unless you accompany it with a cygwin java build (if such a thing exists). Mingw
> also does not support them.

I'm all for a change that widens the group of applications and
users that can use jgit (heck, that's one reason we moved to it to
a BSD license).  But we really cannot abandon Windows users in that
process, so yea, anything that tries to use symlinks is bad.

I don't think there is a Cygwin based version of the JVM.  That would
be a very interesting beast.

-- 
Shawn.
