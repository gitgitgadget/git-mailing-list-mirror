From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 14:56:57 -0700
Message-ID: <7vejt5z3rq.fsf@assigned-by-dhcp.cox.net>
References: <200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<20061018185907.GV20017@pasky.or.cz>
	<7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610181510510.1971@xanadu.home>
	<20061018191834.GA18829@spearce.org>
	<Pine.LNX.4.64.0610181525410.1971@xanadu.home>
	<20061018204626.GA19194@spearce.org>
	<Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:57:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJPK-0005Az-9e
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWJRV47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWJRV47
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:56:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:15830 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751502AbWJRV46 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:56:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018215658.TCTP2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 17:56:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bxx11V0091kojtg0000000
	Wed, 18 Oct 2006 17:57:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 18 Oct 2006 14:17:42 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29285>

Linus Torvalds <torvalds@osdl.org> writes:

> My personal suspicion is that we'll want to have a 64-bit index file some 
> day, and THAT is worthy of a format change. That day is not now, btw. It's 
> probably not even very close. Even the mozilla repo that was pushing the 
> limit was only doing so until it was optimized better, and now it's 
> apparently nowhere _near_ that limit.
>
> But even then, we might well want to update _just_ the index file format.

We've tried this already, and I shelved the patch for 64-index
for now due to exactly the same reasoning as yours (and it would
have conflicted heavily with Shawn's windowed-mmap() patch).  It
involved updating just the index file format, so you are right
on both counts.

But you are always right anyway, so it may not be a news at all
;-).
