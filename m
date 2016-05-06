From: Li Peng <lip@dtdream.com>
Subject: [PATCH] split-index: fix typo
Date: Fri,  6 May 2016 19:50:11 +0800
Message-ID: <1462535411-16053-1-git-send-email-lip@dtdream.com>
Cc: pclouds@gmail.com, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 13:50:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayeHN-0001Tf-Mw
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 13:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758409AbcEFLul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 07:50:41 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:50000 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758262AbcEFLuk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 07:50:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1352746|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mN4kLV_1462535413;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.41.199);
          Fri, 06 May 2016 19:50:18 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293761>

Fix a typo in comment.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 split-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/split-index.c b/split-index.c
index 968b780..3c75d4b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -60,7 +60,7 @@ static void mark_base_index_entries(struct index_state *base)
 	 * To keep track of the shared entries between
 	 * istate->base->cache[] and istate->cache[], base entry
 	 * position is stored in each base entry. All positions start
-	 * from 1 instead of 0, which is resrved to say "this is a new
+	 * from 1 instead of 0, which is reserved to say "this is a new
 	 * entry".
 	 */
 	for (i = 0; i < base->cache_nr; i++)
-- 
1.8.3.1
