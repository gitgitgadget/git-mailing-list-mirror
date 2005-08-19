From: Jason Riedy <ejr@cs.berkeley.edu>
Subject: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Thu, 18 Aug 2005 21:10:08 -0700
Message-ID: <812.1124424608@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Fri Aug 19 06:10:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5yD0-0005Oq-Ew
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 06:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVHSEKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 00:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVHSEKO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 00:10:14 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:46270 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932289AbVHSEKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 00:10:13 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id j7J4A86d000814
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 21:10:08 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id j7J4A8gn000813
	for <git@vger.kernel.org>; Thu, 18 Aug 2005 21:10:08 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sun's cc doesn't know __attribute__.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>
---

 cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

4181b19f615b3d56f9fae5f3accd435480aa7d2f
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -41,7 +41,7 @@
 #endif
 
 #ifndef __attribute__
-#define __attribute(x)
+#define __attribute__(x)
 #endif
 
 /*
