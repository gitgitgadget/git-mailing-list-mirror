From: Li Peng <lip@dtdream.com>
Subject: [PATCH] remote-ext: fix typo
Date: Fri,  6 May 2016 11:39:35 +0800
Message-ID: <1462505975-6708-1-git-send-email-lip@dtdream.com>
Cc: ilari.liusvaara@elisanet.fi, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 05:46:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayWiV-0001zL-UI
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 05:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbcEFDqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 23:46:05 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:38657 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755970AbcEFDqE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2016 23:46:04 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 May 2016 23:46:04 EDT
X-Alimail-AntiSpam: AC=CONTINUE;BC=-0.01965111|-1;FP=12681261562056981487|1|1|2|0|-1|-1|-1;HT=e02c03283;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mDFIo4_1462505977;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.44.118);
          Fri, 06 May 2016 11:39:54 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293736>

Fix a typo in builtin/remote-ext.c.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 builtin/remote-ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 7457c74..88eb8f9 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -168,7 +168,7 @@ static int command_loop(const char *child)
 		size_t i;
 		if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
 			if (ferror(stdin))
-				die("Comammand input error");
+				die("Command input error");
 			exit(0);
 		}
 		/* Strip end of line characters. */
-- 
1.8.3.1
