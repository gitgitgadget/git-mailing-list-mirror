From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] various contrib: Fix links in man pages
Date: Thu,  7 Aug 2014 16:27:12 +0200
Message-ID: <1407421632-12490-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 07 16:27:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFOf6-00045p-2D
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 16:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757560AbaHGO1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 10:27:19 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36315 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757529AbaHGO1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 10:27:16 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so4208265wgg.4
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Mn6BYAbwz/sxK1VxCpw48ifdelZWdSBmhXo4DPo9e4w=;
        b=m1ddQoy1JOeKMqLzM+oLw7YelJ33F8S3YTgFtf2DKBeZij+AQVgQF8TimGMSn5eONY
         WOpfwW5hzG4FzUIJngkzzpTnICc3/d6KyxyyJ0OY18ggxIDJb8/2scrNs5E8sZ+zbJfu
         xJbdKP4isyJituPY/BUVtfdLnqRTyIkU9ho8uOQSlCq473R2x1VPyR9e1Op4GWToo0uL
         127TVrimy+M2JWBK5S0YBZ1eI+vaI14XoiNFhsS8rGpYwfKAJH3P9/+82kKrTyrAKBMl
         E5UhUCxHpCq9FWUM23a5WPSxKj5+Xcx7JPTU46+9qd/ZkJwuxEzuCpH6TW3GkBctxkfC
         un3w==
X-Received: by 10.194.237.135 with SMTP id vc7mr25832329wjc.86.1407421635338;
        Thu, 07 Aug 2014 07:27:15 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id i8sm182033wib.6.2014.08.07.07.27.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 07:27:14 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc0.52.gaa544bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254960>

Inspired by 2147fa7e (2014-07-31 git-push: fix link in man page),
I grepped through the whole tree searching for 'gitlink:' occurrences.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 contrib/convert-objects/git-convert-objects.txt | 2 +-
 contrib/examples/git-svnimport.txt              | 2 +-
 contrib/gitview/gitview.txt                     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/convert-objects/git-convert-objects.txt b/contrib/convert-objects/git-convert-objects.txt
index 0565d83..f871880 100644
--- a/contrib/convert-objects/git-convert-objects.txt
+++ b/contrib/convert-objects/git-convert-objects.txt
@@ -26,4 +26,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the gitlink:git[7] suite
+Part of the linkgit:git[7] suite
diff --git a/contrib/examples/git-svnimport.txt b/contrib/examples/git-svnimport.txt
index 3bb871e..3f0a9c3 100644
--- a/contrib/examples/git-svnimport.txt
+++ b/contrib/examples/git-svnimport.txt
@@ -176,4 +176,4 @@ Documentation by Matthias Urlichs <smurf@smurf.noris.de>.
 
 GIT
 ---
-Part of the gitlink:git[7] suite
+Part of the linkgit:git[7] suite
diff --git a/contrib/gitview/gitview.txt b/contrib/gitview/gitview.txt
index 9e12f97..7b5f900 100644
--- a/contrib/gitview/gitview.txt
+++ b/contrib/gitview/gitview.txt
@@ -28,7 +28,7 @@ OPTIONS
 
 <args>::
 
-	All the valid option for gitlink:git-rev-list[1].
+	All the valid option for linkgit:git-rev-list[1].
 
 Key Bindings
 ------------
-- 
2.1.0.rc0.52.gaa544bf
