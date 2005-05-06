From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Remove unused sha1_file_directory variable.
Date: Fri, 06 May 2005 16:33:39 -0700
Message-ID: <7vpsw4aq0c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 01:31:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUCH0-0004Py-0n
	for gcvg-git@gmane.org; Sat, 07 May 2005 01:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVEFXgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 19:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVEFXfX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 19:35:23 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:32653 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261354AbVEFXdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 19:33:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506233340.HPJV7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 May 2005 19:33:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Now all the users have gone.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h     |    1 -
 sha1_file.c |    3 ---
 2 files changed, 4 deletions(-)

--- a/cache.h
+++ b/cache.h
@@ -96,7 +96,6 @@ static inline unsigned int create_ce_mod
 
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)
 
-const char *sha1_file_directory;
 struct cache_entry **active_cache;
 unsigned int active_nr, active_alloc;
 
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -9,8 +9,6 @@
 #include <stdarg.h>
 #include "cache.h"
 
-const char *sha1_file_directory = NULL;
-
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
 #define O_NOATIME 01000000
----------------------------------------------------------------

