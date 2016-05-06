From: Li Peng <lip@dtdream.com>
Subject: [PATCH] path: fix duplicate words of "look"
Date: Fri,  6 May 2016 20:15:15 +0800
Message-ID: <1462536915-17505-1-git-send-email-lip@dtdream.com>
Cc: dturner@twopensource.com, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:15:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayefc-0001Zu-An
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208AbcEFMPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:15:45 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:49773 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997AbcEFMPo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 08:15:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09449203|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03281;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mNY34o_1462536916;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.42.241);
          Fri, 06 May 2016 20:15:22 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293767>

Fix duplicate words of "look" in comment.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index bbaea5a..5037667 100644
--- a/path.c
+++ b/path.c
@@ -134,7 +134,7 @@ static struct common_dir common_list[] = {
  * definite
  * definition
  *
- * The trie would look look like:
+ * The trie would look like:
  * root: len = 0, children a and d non-NULL, value = NULL.
  *    a: len = 2, contents = bc, value = (data for "abc")
  *    d: len = 2, contents = ef, children i non-NULL, value = (data for "def")
-- 
1.8.3.1
