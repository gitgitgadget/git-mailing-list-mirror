From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] dir: do all size checks before seeking back and fix file closing
Date: Sat, 26 Aug 2006 19:15:24 -0700
Message-ID: <7v8xlazzyb.fsf@assigned-by-dhcp.cox.net>
References: <20060826141709.GC11601@diku.dk>
	<Pine.LNX.4.64.0608261509290.11811@g5.osdl.org>
	<7v4pvz11o6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 04:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHAB4-0001kx-Lf
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 04:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWH0CPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 22:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWH0CPE
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 22:15:04 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:55038 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751003AbWH0CPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 22:15:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827021501.NFSN18458.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 22:15:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id EqEy1V00P4Noztg0000000
	Sat, 26 Aug 2006 22:14:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v4pvz11o6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 26 Aug 2006 17:07:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26079>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> Now, admittedly it's wrong because another bad habit Junio picked up 
>> (doing comparisons with constants in the wrong order)
>
> I think you misunderstand the rationale used to encourage the
> comparison used there.  It does not have anything to do with
> having comparison on the left.

s/comparison/constant/; I cannot spell.
