From: Junio C Hamano <junkio@cox.net>
Subject: Re: Approxidate licensing
Date: Wed, 11 Oct 2006 00:55:01 -0700
Message-ID: <7viriruw16.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610101246241.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, dwmw2@infradead.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 09:55:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXYvs-0002IU-9O
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 09:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030677AbWJKHzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 03:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbWJKHzI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 03:55:08 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:50412 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030677AbWJKHzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 03:55:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011075502.CEPI26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 03:55:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yvv41V00h1kojtg0000000
	Wed, 11 Oct 2006 03:55:05 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0610101246241.9789@iabervon.org> (Daniel
	Barkalow's message of "Tue, 10 Oct 2006 13:39:47 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28700>

Daniel Barkalow <barkalow@iabervon.org> writes:

> [1] git log and git blame are pretty impressive, but they don't quite 
> catch that most of date.c was written by David as part of commit-tree.c, 
> then Tony replaced it with a version that uses curl, then Edgar separated 
> it out into a date.c and simultaneously reverted Tony's changes. On the 
> other hand, the commit messages do say this, and you can use git log and 
> git blame to verify that they're true. The only thing they don't let 
> you verify is what the differences are between the date.c added in 
> ecee9d9e and the similar part of commit-tree.c in 812666c8. If someone 
> wants to make git blame *really* magic, date.c would be a good test case.

That's good to know.  I have in my head a super-duper blame that
I outlined in my obituary for git-annotate, but that is still a
vaporware and will continue to be for some time.
