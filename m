From: Junio C Hamano <junkio@cox.net>
Subject: Request reverting some from git-pb
Date: Sun, 15 May 2005 11:29:36 -0700
Message-ID: <7vmzqwtka7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun May 15 20:29:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXNrj-0003nu-Bj
	for gcvg-git@gmane.org; Sun, 15 May 2005 20:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEOS3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 14:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVEOS3k
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 14:29:40 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17381 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261196AbVEOS3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 14:29:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515182937.QKKG19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 14:29:37 -0400
To: pasky@ucw.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr, you added two small patches to git-pb recently.

 * Rename some more cache-related functions
 * Rename cache_match_stat() to ce_match_stat()

I would really appreciate if you do not do these name clean-ups
yet, _especially_ not without having GIT mailing list discussion
about it first.  This kind of changes inevitably introduce merge
conflicts.

I suspect this is something you lifted from a larger
libification patch.  While I think name cleanups are good in the
long run, I do not see value in lifting only some name cleanups
from the libification patch and having people to adjust for the
merge conflicts twice (now and when libification is ready to be
included).  I would not mind if these renames happen as a part
of libification as a whole.  Pending patches need to be
inspected and adjusted when that happens anyway.  But not until
then, at least please have a courtesy to give people a warning
and an opportunity to speak out.

