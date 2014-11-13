From: <stefan.naewe@atlas-elektronik.com>
Subject: [PATCH] gittutorial: fix output of 'git status'
Date: Thu, 13 Nov 2014 10:40:07 +0000
Message-ID: <1415875207-5992-1-git-send-email-stefan.naewe@atlas-elektronik.com>
References: <1638160691.207203.1415866403277.JavaMail.ngmail@webmail23.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <th.acker@arcor.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 11:40:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XorpN-00028J-OY
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 11:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbaKMKke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 05:40:34 -0500
Received: from mail96.atlas.de ([194.156.172.86]:16193 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932229AbaKMKkd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 05:40:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id D75C34A009;
	Thu, 13 Nov 2014 11:40:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbqVNLg3Mb7g; Thu, 13 Nov 2014 11:40:21 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 13 Nov 2014 11:40:21 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 27EE02716A;
	Thu, 13 Nov 2014 11:40:20 +0100 (CET)
Received: from localhost (10.200.54.122) by MSSRVS1.atlas.de (10.200.101.71)
 with Microsoft SMTP Server (TLS) id 8.3.327.1; Thu, 13 Nov 2014 11:40:20
 +0100
X-Mailer: git-send-email 1.9.2.msysgit.0.2270.g8768113
In-Reply-To: <1638160691.207203.1415866403277.JavaMail.ngmail@webmail23.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Naewe <stefan.naewe@gmail.com>

'git status' doesn't output leading '#'s these days.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 Documentation/gittutorial-2.txt | 23 ++++++++++++-----------
 Documentation/gittutorial.txt   | 17 +++++++++--------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 3109ea8..1901af7 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -368,17 +368,18 @@ situation:
 
 ------------------------------------------------
 $ git status
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#       new file: closing.txt
-#
-# Changes not staged for commit:
-#   (use "git add <file>..." to update what will be committed)
-#
-#       modified: file.txt
-#
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+        new file:   closing.txt
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+        modified:   file.txt
+
 ------------------------------------------------
 
 Since the current state of closing.txt is cached in the index file,
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 8262196..8715244 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -107,14 +107,15 @@ summary of the situation with 'git status':
 
 ------------------------------------------------
 $ git status
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	modified:   file1
-#	modified:   file2
-#	modified:   file3
-#
+On branch master
+Changes to be committed:
+Your branch is up-to-date with 'origin/master'.
+  (use "git reset HEAD <file>..." to unstage)
+
+        modified:   file1
+        modified:   file2
+        modified:   file3
+
 ------------------------------------------------
 
 If you need to make any further adjustments, do so now, and then add any
-- 
1.9.2.msysgit.0.2270.g8768113
