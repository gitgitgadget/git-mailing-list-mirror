From: Li Peng <lip@dtdream.com>
Subject: [PATCH] wildmatch: fix duplicate words of "the"
Date: Fri,  6 May 2016 20:36:46 +0800
Message-ID: <1462538206-18651-1-git-send-email-lip@dtdream.com>
Cc: pclouds@gmail.com, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:37:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayf0n-00083F-BU
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565AbcEFMhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:37:32 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:49866 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758325AbcEFMhc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 08:37:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05972305|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03275;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mNhcpB_1462538209;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.41.178);
          Fri, 06 May 2016 20:36:59 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293773>

Fix duplicate words of "the" in comment.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 wildmatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wildmatch.c b/wildmatch.c
index f91ba99..57c8765 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -136,7 +136,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 				/*
 				 * Try to advance faster when an asterisk is
 				 * followed by a literal. We know in this case
-				 * that the the string before the literal
+				 * that the string before the literal
 				 * must belong to "*".
 				 * If match_slash is false, do not look past
 				 * the first slash as it cannot belong to '*'.
-- 
1.8.3.1
