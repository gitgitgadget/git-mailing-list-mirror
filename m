From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:07:24 -0700
Message-ID: <7v4pu1z3ab.fsf@assigned-by-dhcp.cox.net>
References: <20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<20061018185907.GV20017@pasky.or.cz>
	<7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610181510510.1971@xanadu.home>
	<20061018191834.GA18829@spearce.org>
	<Pine.LNX.4.64.0610181525410.1971@xanadu.home>
	<20061018204626.GA19194@spearce.org>
	<Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
	<20061018213225.GD19194@spearce.org>
	<Pine.LNX.4.64.0610181449290.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 00:07:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJZR-0007AN-Ho
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 00:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423064AbWJRWH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWJRWH0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 18:07:26 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43007 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751408AbWJRWH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 18:07:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018220725.QYXI12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 18:07:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id by7U1V01U1kojtg0000000
	Wed, 18 Oct 2006 18:07:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610181449290.3962@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 18 Oct 2006 14:55:47 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29289>

Linus Torvalds <torvalds@osdl.org> writes:

> I think thin packs have been a good idea, and they certainly cut the 
> amount of data sent over the network down by a large amount (much more 
> than 50%), so I think thin packs are a great idea. Just _not_ when 
> indexed.

Ah, I feel quite behind.  I was about to say "oh have you been
pushing with --thin option?", and then realized that we made it
default since late March this year.

I need to run memtest86 on myself X-<.
