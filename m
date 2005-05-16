From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Implement git-checkout-cache -u to update stat
 information in the cache.
Date: Mon, 16 May 2005 16:11:29 -0700
Message-ID: <7vk6lyn4v2.fsf@assigned-by-dhcp.cox.net>
References: <7vll6gqj3z.fsf@assigned-by-dhcp.cox.net>
	<20050516220153.GA8609@pasky.ji.cz>
	<Pine.LNX.4.58.0505161530230.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 01:11:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXojy-0002k5-TF
	for gcvg-git@gmane.org; Tue, 17 May 2005 01:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVEPXLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 19:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEPXLe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 19:11:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:24259 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261958AbVEPXLb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 19:11:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516231128.UIVQ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 19:11:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505161530230.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 16 May 2005 15:32:24 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> ... and as long as the index file locking is honoured
LT> (which the patch seemed to do) ...

Yes, it does.  But that was one thing I was not very sure about
this patch.  I am reasonably sure this "index.c" conflicts with
the libification effort, and when the libification finishes, I
feel that what "index.c" does should be part of it.

