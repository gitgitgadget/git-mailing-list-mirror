From: Li Peng <lip@dtdream.com>
Subject: [PATCH] t: fix duplicate words of "output"
Date: Fri,  6 May 2016 20:22:43 +0800
Message-ID: <1462537363-17962-1-git-send-email-lip@dtdream.com>
Cc: ilya.bobyr@gmail.com, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:23:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayemq-0006hB-Ge
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbcEFMXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:23:13 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:36128 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932171AbcEFMXM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 08:23:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.01015772|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mNY5SQ_1462537365;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.42.241);
          Fri, 06 May 2016 20:22:52 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293769>

Fix duplicate words of "output" in comment.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 79b9074..60811a3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -98,7 +98,7 @@ check_sub_test_lib_test () {
 }
 
 check_sub_test_lib_test_err () {
-	name="$1" # stdin is the expected output output from the test
+	name="$1" # stdin is the expected output from the test
 	# expected error output is in descriptior 3
 	(
 		cd "$name" &&
-- 
1.8.3.1
