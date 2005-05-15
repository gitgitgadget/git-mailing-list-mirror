From: Junio C Hamano <junkio@cox.net>
Subject: Request reverting some from git-pb
Date: Sun, 15 May 2005 11:25:02 -0700
Message-ID: <7vy8agtkht.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun May 15 20:26:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXNoN-0003Kq-DP
	for gcvg-git@gmane.org; Sun, 15 May 2005 20:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVEOSZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 14:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVEOSZ2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 14:25:28 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:33507 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261195AbVEOSZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 14:25:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515182504.QITD19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 14:25:04 -0400
To: pasky@ucw.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr, please do not do these name clean-ups yet, _especially_
without having GIT mailing list discussion about renaming.  This
kind of change inevitably introduces merge conflicts.

I suspect this is something you lifted from the larger
libification patch.  While I think name cleanups are good in the
long run, I do not see value in lifting only some name cleanups
from a larger libification patch and having people to adjust for
the merge conflicts twice.  I would not mind if these renames
happen as a part of libification as a whole.  Pending patches
need to be inspected and adjusted when that happens anyway.  But
not until then, at least please have a courtecy to give people a
bit of warning and an opportunity to speak out.

------------------------------------------------
Rename some more cache-related functions

same_name -> ce_same_name()
remove_entry_at() -> remove_cache_entry_at()

Signed-off-by: Brad Roberts <braddr@puremagic.com>
Signed-off-by: Petr Baudis <pasky@ucw.cz>
------------------------------------------------
Rename cache_match_stat() to ce_match_stat()

Signed-off-by: Brad Roberts <braddr@puremagic.com>
Signed-off-by: Petr Baudis <pasky@ucw.cz>
------------------------------------------------
Rename cache_match_stat() to ce_match_stat()

Signed-off-by: Brad Roberts <braddr@puremagic.com>
Signed-off-by: Petr Baudis <pasky@ucw.cz>
------------------------------------------------

