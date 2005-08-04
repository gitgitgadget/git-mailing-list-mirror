From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Unify Makefile indentation
Date: Fri, 5 Aug 2005 00:52:46 +0200
Message-ID: <20050804225246.GI24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 05 01:05:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0okv-0001b8-Gv
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 01:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVHDXBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVHDWxr
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 18:53:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50189 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262745AbVHDWwq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 18:52:46 -0400
Received: (qmail 6519 invoked by uid 2001); 4 Aug 2005 22:52:46 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Use <tab> instead of two spaces uniformly in the Makefile, even in the
ifdefs. Gives it a nice consistent look.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit aa6f095b0cd57ab424f02695ccfc8168f5c3b981
tree 046906d724925998ec7f47efc26bab7e84052014
parent ccf4810a5187b6f13b809e659870101e66d19807
author Petr Baudis <pasky@suse.cz> Fri, 05 Aug 2005 00:51:06 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 05 Aug 2005 00:51:06 +0200

 Makefile |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -87,7 +87,7 @@ PROG=   git-update-cache git-diff-files 
 	git-update-server-info git-show-rev-cache git-build-rev-cache
 
 ifndef NO_CURL
-PROG+= git-http-pull
+	PROG += git-http-pull
 endif
 
 LIB_FILE=libgit.a
@@ -129,18 +129,18 @@ else
 	OPENSSL_LIBSSL=
 endif
 ifdef MOZILLA_SHA1
-  SHA1_HEADER="mozilla-sha1/sha1.h"
-  LIB_OBJS += mozilla-sha1/sha1.o
+	SHA1_HEADER="mozilla-sha1/sha1.h"
+	LIB_OBJS += mozilla-sha1/sha1.o
 else
 ifdef PPC_SHA1
-  SHA1_HEADER="ppc/sha1.h"
-  LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
+	SHA1_HEADER="ppc/sha1.h"
+	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 else
-  SHA1_HEADER=<openssl/sha.h>
+	SHA1_HEADER=<openssl/sha.h>
 ifeq ($(shell uname -s),Darwin)
-  LIBS += -lcrypto -lssl
+	LIBS += -lcrypto -lssl
 else
-  LIBS += -lcrypto
+	LIBS += -lcrypto
 endif
 endif
 endif
