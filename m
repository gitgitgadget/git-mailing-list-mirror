From: Junio C Hamano <junkio@cox.net>
Subject: Re: -p diff output and the 'Index:' line
Date: Sun, 29 May 2005 00:41:03 -0700
Message-ID: <7vd5raqy28.fsf@assigned-by-dhcp.cox.net>
References: <20050529071520.GC1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 09:39:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcINy-0007E9-Gd
	for gcvg-git@gmane.org; Sun, 29 May 2005 09:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVE2HlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 03:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVE2HlM
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 03:41:12 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52156 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261267AbVE2HlF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 03:41:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529074104.DMQX22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 03:41:04 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050529071520.GC1036@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 29 May 2005 09:15:20 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB>   What do you think? Would you hate it to show up in the diffs, or are
PB> you ok with it?

I cannot tell if you are asking about cg-diff or changing the
built-in diff-* output.  The Subject: line suggests you are
talking about the latter, but if that is the case I have to
admit that I am not that sympathetic to Index: nor separator.

Like Linus, I do "/^diff --git .*" in my less sessions, which
gives a very nice highlighted separator line without wasting a
single line on the terminal.  If any of the readers on the list
didn't know about this trick (especially the trailing .* part),
please try it.  I'm certain everybody would love it.

