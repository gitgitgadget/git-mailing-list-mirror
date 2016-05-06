From: Li Peng <lip@dtdream.com>
Subject: [PATCH] git-cvsserver: fix duplicate words
Date: Fri,  6 May 2016 20:09:30 +0800
Message-ID: <1462536570-17199-1-git-send-email-lip@dtdream.com>
Cc: mmogilvi_git@miniinfo.net, Li Peng <lip@dtdream.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:10:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayea8-00068T-Tr
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 14:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758644AbcEFMKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 08:10:03 -0400
Received: from smtp2203-239.mail.aliyun.com ([121.197.203.239]:50969 "EHLO
	smtp2203-239.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758607AbcEFMKB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 08:10:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08323886|-1;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03288;MF=lip@dtdream.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_----4mNXGqR_1462536574;
Received: from localhost.localdomain(mailfrom:lip@dtdream.com ip:111.198.29.130)
          by smtp.aliyun-inc.com(10.147.40.200);
          Fri, 06 May 2016 20:09:40 +0800
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293766>

Fix duplicate words in comments.

Signed-off-by: Li Peng <lip@dtdream.com>
---
 git-cvsserver.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 02c0445..392e59e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1156,7 +1156,7 @@ sub prepDirForOutput
     # FUTURE: This would more accurately emulate CVS by sending
     #   another copy of sticky after processing the files in that
     #   directory.  Or intermediate: perhaps send all sticky's for
-    #   $seendirs after after processing all files.
+    #   $seendirs after processing all files.
 }
 
 # update \n
@@ -2824,7 +2824,7 @@ sub statecleanup
 }
 
 # Return working directory CVS revision "1.X" out
-# of the the working directory "entries" state, for the given filename.
+# of the working directory "entries" state, for the given filename.
 # This is prefixed with a dash if the file is scheduled for removal
 # when it is committed.
 sub revparse
@@ -2935,7 +2935,7 @@ sub filecleanup
     return $filename;
 }
 
-# Remove prependdir from the path, so that is is relative to the directory
+# Remove prependdir from the path, so that is relative to the directory
 # the CVS client was started from, rather than the top of the project.
 # Essentially the inverse of filecleanup().
 sub remove_prependdir
-- 
1.8.3.1
