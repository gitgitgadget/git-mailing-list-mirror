From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Fri, 13 May 2005 17:03:49 -0700
Message-ID: <7vhdh67jx6.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<20050513224529.GF32232@pasky.ji.cz>
	<7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
	<20050513233354.GK32232@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 02:05:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWkA4-0002Fz-Cq
	for gcvg-git@gmane.org; Sat, 14 May 2005 02:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVENAEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 20:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVENAEJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 20:04:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41404 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262627AbVENADx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 20:03:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514000350.NCXW7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 May 2005 20:03:50 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513233354.GK32232@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 01:33:54 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> .... Even if you think I shouldn't grep

I do not mean you should never grep.  There are cases when there
is no alternative.  One case I did not mention is that you would
want to accept patches via e-mail and apply.  In such a case,
GIT_EXTERNAL_DIFF with git-apply-patch-script way would not work
because that approach is essentially to patch while you are
generating diff locally.

