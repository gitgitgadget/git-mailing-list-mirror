From: Li Peng <lip@dtdream.com>
Subject: [PATCH] precompose-utf8: fix typo of "sequences"
Date: Fri,  6 May 2016 19:55:10 +0800
Message-ID: <1462535710-16382-1-git-send-email-lip@dtdream.com>
Cc: tboegi@web.de, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 13:55:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayeMC-0004jV-P3
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 13:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208AbcEFLzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 07:55:35 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:33988 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751306AbcEFLzf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 07:55:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05919932|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03284;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mMKWnt_1462535711;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.42.241);
          Fri, 06 May 2016 19:55:17 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293762>

Fix a typo in comment.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 compat/precompose_utf8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index dfbe6d8..4293b53 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -147,7 +147,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 				if (errno || inleft) {
 					/*
 					 * iconv() failed and errno could be E2BIG, EILSEQ, EINVAL, EBADF
-					 * MacOS X avoids illegal byte sequemces.
+					 * MacOS X avoids illegal byte sequences.
 					 * If they occur on a mounted drive (e.g. NFS) it is not worth to
 					 * die() for that, but rather let the user see the original name
 					*/
-- 
1.8.3.1
