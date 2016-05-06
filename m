From: Li Peng <lip@dtdream.com>
Subject: [PATCH] transport-helper: fix duplicate words of "read"
Date: Fri,  6 May 2016 20:27:10 +0800
Message-ID: <1462537630-18101-1-git-send-email-lip@dtdream.com>
Cc: ilari.liusvaara@elisanet.fi, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:27:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayer6-0001In-GO
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbcEFM1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:27:36 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:39113 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932293AbcEFM1g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 08:27:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08130053|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03298;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mNBJCH_1462537631;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.41.137);
          Fri, 06 May 2016 20:27:17 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293771>

Fix duplicate words of "read" in comment.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
1.8.3.1
