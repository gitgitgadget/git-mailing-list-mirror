From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -O<orderfile> option to diff-* brothers.
Date: Sun, 29 May 2005 17:23:03 -0700
Message-ID: <7vekbpftp4.fsf@assigned-by-dhcp.cox.net>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291154030.10545@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 02:21:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcY1K-00060j-Sz
	for gcvg-git@gmane.org; Mon, 30 May 2005 02:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVE3AXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 20:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVE3AXH
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 20:23:07 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:7624 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261478AbVE3AXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 20:23:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530002303.IYGD22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 20:23:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505291154030.10545@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 29 May 2005 11:56:10 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

I realize I did not answer your question.

LT> In other words: what is the problem this is trying to solve?

To produce a patch that is easier to review, using customized
patch order list for projects.  I envision that Porcelain
noticing the existence of ${GIT-.git}/patch-order file and
adding -O to its diff-* argument would make the world a better
place.

