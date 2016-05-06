From: Li Peng <lip@dtdream.com>
Subject: [PATCH] worktree.c: fix typo
Date: Fri,  6 May 2016 19:39:23 +0800
Message-ID: <1462534763-15655-1-git-send-email-lip@dtdream.com>
Cc: rappazzo@gmail.com, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 13:40:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aye75-00034z-Ef
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 13:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489AbcEFLj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 07:39:57 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:60757 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757430AbcEFLjy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 07:39:54 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1364548|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03293;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mME.xJ_1462534766;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.43.95);
          Fri, 06 May 2016 19:39:33 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293759>

Fix a typo in comment.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index 6181a66..89ebe67 100644
--- a/worktree.c
+++ b/worktree.c
@@ -18,7 +18,7 @@ void free_worktrees(struct worktree **worktrees)
 
 /*
  * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
- * set is_detached to 1 (0) if the ref is detatched (is not detached).
+ * set is_detached to 1 (0) if the ref is detached (is not detached).
  *
  * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so
  * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
-- 
1.8.3.1
