From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -O<orderfile> option to diff-* brothers.
Date: Sat, 28 May 2005 09:14:37 -0700
Message-ID: <7vu0knuy36.fsf@assigned-by-dhcp.cox.net>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
	<20050528111238.GA1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 18:14:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dc3vI-0008B1-42
	for gcvg-git@gmane.org; Sat, 28 May 2005 18:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVE1QOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVE1QOn
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 12:14:43 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:25319 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261157AbVE1QOl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 12:14:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528161439.ONFV26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 12:14:39 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050528111238.GA1036@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 28 May 2005 13:12:38 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Hmm, is this really useful in practice? diff itself doesn't appear to
PB> have it either, and I haven't seen something like this before. So is it
PB> worth the code?

CVS nor SVN does not do pickaxe as far as I know either, but I
think some people in GIT community are already having fun with
pickaxe.

The amount of the code is small, and it does not impact if you
do not use the option.  I am more concerned by (1) the fact that
each new diffcore filters would carve out its own niche from the
scarse command option namespace; (2) you have to duplicate the
option parsing in all three diff-* brothers; and (3) diff-tree
is sometimes an odd-man-out among those three and it is not so
simple to unify the option parsing.  A help in that area is very
much appreciated.

