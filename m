From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] show-diff.c: do not include unused header file
Date: Sat, 16 Apr 2005 22:39:45 -0700
Message-ID: <7vvf6m0xni.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:36:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN2Rv-00005N-47
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDQFjs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 01:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVDQFjs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 01:39:48 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:1226 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261263AbVDQFjr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 01:39:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417053947.NWVR19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 01:39:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is my bad.  I added #include <ctype.h> to the file,
which I ended up not using and failed to remove it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

show-diff.c: d85d79b97a59342390bd34da09049dd58d56900f
--- show-diff.c
+++ show-diff.c	2005-04-16 22:37:29.000000000 -0700
@@ -4,7 +4,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
-#include <ctype.h>
 
 static char *diff_cmd = "diff -L '%s' -u -N  - '%s'";


