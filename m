From: Li Peng <lip@dtdream.com>
Subject: [PATCH] utf8: fix duplicate words of "the"
Date: Fri,  6 May 2016 20:31:33 +0800
Message-ID: <1462537893-18493-1-git-send-email-lip@dtdream.com>
Cc: peff@peff.net, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:32:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayevP-0004Hd-KH
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758040AbcEFMcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:32:03 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:37245 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757850AbcEFMcC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 08:32:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=-0.02060219|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mNXNev_1462537895;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.40.200);
          Fri, 06 May 2016 20:31:40 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293772>

Fix duplicate words of "the" in comment.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 transport-helper.c | 2 +-
 utf8.h             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b934183..13b7a57 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1152,7 +1152,7 @@ static void udt_close_if_finished(struct unidirectional_transfer *t)
 }
 
 /*
- * Tries to read read data from source into buffer. If buffer is full,
+ * Tries to read data from source into buffer. If buffer is full,
  * no data is read. Returns 0 on success, -1 on error.
  */
 static int udt_do_read(struct unidirectional_transfer *t)
diff --git a/utf8.h b/utf8.h
index 7930b44..6bbcf31 100644
--- a/utf8.h
+++ b/utf8.h
@@ -48,7 +48,7 @@ static inline char *reencode_string(const char *in,
 int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
 
 /*
- * Returns true if the the path would match ".git" after HFS case-folding.
+ * Returns true if the path would match ".git" after HFS case-folding.
  * The path should be NUL-terminated, but we will match variants of both ".git\0"
  * and ".git/..." (but _not_ ".../.git"). This makes it suitable for both fsck
  * and verify_path().
-- 
1.8.3.1
