From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 22:49:21 -0700
Message-ID: <7vzmbqgqvy.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
	<20061019161319.GA75501@over-yonder.net>
	<Pine.LNX.4.64.0610190948540.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610191110290.3962@g5.osdl.org>
	<vpqlknc3zmn.fsf@ecrins.imag.fr>
	<Pine.LNX.4.64.0610191258290.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 07:49:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb9je-0000eC-NC
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 07:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992828AbWJUFtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 01:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWJUFtX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 01:49:23 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:18357 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932222AbWJUFtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 01:49:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021054922.IFSF2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Oct 2006 01:49:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ctp71V00Q1kojtg0000000
	Sat, 21 Oct 2006 01:49:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610191258290.3962@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 19 Oct 2006 13:47:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29585>

Linus Torvalds <torvalds@osdl.org> writes:

> For example, while git now does "annotate" (or "blame"), it's not 
> lightning fast, and I simply don't care. Doing a
>
> 	git blame kernel/sched.c
>
> takes about three seconds for me, and that's on a pretty good machine (and 
> on the kernel tree, which for me is always in the cache ;).

ll.6041-6091 of that file is blamed to arch/ia64/kernel/domain.c
by pickaxe -C (attributed to commit 2.6.12-rc2) while blame says
they are brought in by commit 9c1cfa, which says "Move the ia64
domain setup code to the generic code".  I am slowly realizing
that comparing the output from blame and pickaxe might be a good
way to study the project history.
