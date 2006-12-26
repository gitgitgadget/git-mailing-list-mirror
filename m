From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 25 Dec 2006 23:59:33 -0500
Message-ID: <20061226045933.GB28084@spearce.org>
References: <7vmz5bfidj.fsf@assigned-by-dhcp.cox.net> <20061226042110.GA28084@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 05:59:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz4Pc-0002EI-LH
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 05:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWLZE7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 23:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWLZE7h
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 23:59:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59032 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbWLZE7h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 23:59:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gz4PK-0001xK-I7; Mon, 25 Dec 2006 23:59:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D97E720FB65; Mon, 25 Dec 2006 23:59:33 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20061226042110.GA28084@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35411>

Shawn Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > * sp/mmap (Sun Dec 24 00:47:23 2006 -0500) 20 commits
> >
> > I wanted to have this in 'next' but it appears that this makes
> > git-push with a non-trivial amount of data to fail.  v1.5.0 does
> > not have to wait for this because this should not change any UI.
> 
> Really?  Not good.  Do you have some sort of test case that has
> caused this?  I'll try to reproduce it here on my own.

I've pushed all of git.git into an empty repository, and then
pushed another 1639 objects on top of that, without any errors.
So I can't seem to reproduce the problem here in my Mac OS X system.

BTW, I do agree that sp/mmap should not be in v1.5.0.

-- 
Shawn.
