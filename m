From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] read-tree -m 3-way: handle more trivial merges
 internally
Date: Fri, 10 Jun 2005 12:59:05 -0700
Message-ID: <7vekba7zli.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net>
	<7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org>
	<7vaclzclqd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 21:56:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgpbi-00047Y-Sx
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 21:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVFJT72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 15:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVFJT72
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 15:59:28 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25044 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261196AbVFJT7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 15:59:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050610195906.CHUD19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Jun 2005 15:59:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vaclzclqd.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 09 Jun 2005 13:35:06 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> So, yes I ended up arguing that the intelligent merge logic
JCH> could and probably needs to look at the trees involved ;-).

"Could look at, and probably be better off looking at," would
have been a better wording.

Linus, please discard the patches from me that you have not
applied about the "loosening of too strict index requirements"
(yesterday and the day before).  I think I am finally getting
somewhere but the solution, if it works, would be somewhat
different from what I have been sending you.




