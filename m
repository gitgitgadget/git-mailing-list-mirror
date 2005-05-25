From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Tue, 24 May 2005 18:05:42 -0700
Message-ID: <7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 03:05:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DakKM-0006lr-VI
	for gcvg-git@gmane.org; Wed, 25 May 2005 03:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVEYBGD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 21:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVEYBGD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 21:06:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12701 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262221AbVEYBFr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 21:05:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525010542.CZUX12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 21:05:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 18:00:54 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> No, it's more broken than that.

I'll take a look at this later and submit an update, but an OT
point I feel I should address.

LT> Btw, that "1 < argc" order is very unintuitive to most humans.

Yeah?  Not to people around where I come from, I do not know
why.  It is not done for the assignment confusion avoidance
"1==a".

The comparison lists things in the ascending order from left to
right.  The fact that 1 comes before argc on that line of code
visually makes it obvious that I am talking about argc being
larger than one and that is the reason.  I'd write (argc < 4)
not (4 > argc) for the same reason.


