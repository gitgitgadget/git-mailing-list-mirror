From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (preview) Renaming push.
Date: Thu, 04 Aug 2005 01:09:10 -0700
Message-ID: <7vvf2m2kex.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
	<Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
	<200508031908.22562.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
	<7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508031641270.3258@g5.osdl.org>
	<7vy87i46il.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508032236470.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 04 10:10:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0an3-0002ba-MI
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 10:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVHDIJN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 04:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVHDIJN
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 04:09:13 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44491 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261969AbVHDIJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 04:09:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804080910.HXYX8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 04:09:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508032236470.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 22:42:06 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Now, for extra bonus points, maybe you should make "git-rev-list" also 
> understand the "rev..rev" format (which you can't do with just the 
> get_sha1() interface, since it expands into more).

Hmph.  That makes sense.

What I set out to do when I started ripping extended_sha1 out of
rev-parse was actually something else.

Remember I was stupidly wondering why "git log master..gitk" did
not do what I wanted to?

The reason I started looking at git-rev-parse was because I
wanted to add "git log master...gitk" (three dots) which is
equivalent to "git log $(git-merge-base master gitk)..gitk".
That was what I wanted to have when I asked that stupid
question.

But unfortunately my GIT day this week is over, so the rest is
for the weekend.
