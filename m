From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git.el: Added colors for dark background
Date: Mon, 27 Aug 2007 11:50:12 +0200
Message-ID: <11882082123581-git-send-email-davidk@lysator.liu.se>
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 11:50:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbEi-0003dG-8X
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 11:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbXH0JuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 05:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbXH0JuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 05:50:16 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56033 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbXH0JuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 05:50:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E53A4200A1AA
	for <git@vger.kernel.org>; Mon, 27 Aug 2007 11:50:13 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 23325-01-45; Mon, 27 Aug 2007 11:50:13 +0200 (CEST)
Received: from morpheus (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 29B7C200A20A;
	Mon, 27 Aug 2007 11:50:13 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id C4F2EBFC7D; Mon, 27 Aug 2007 11:50:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc6.31.g3c3b
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56796>

---
 contrib/emacs/git.el |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 3375549..b0faa48 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -100,47 +100,56 @@ if there is already one that displays the same directory."
 
 
 (defface git-status-face
-  '((((class color) (background light)) (:foreground "purple")))
+  '((((class color) (background light)) (:foreground "purple"))
+    (((class color) (background dark)) (:foreground "salmon")))
   "Git mode face used to highlight added and modified files."
   :group 'git)
 
 (defface git-unmerged-face
-  '((((class color) (background light)) (:foreground "red" :bold t)))
+  '((((class color) (background light)) (:foreground "red" :bold t))
+    (((class color) (background dark)) (:foreground "red" :bold t)))
   "Git mode face used to highlight unmerged files."
   :group 'git)
 
 (defface git-unknown-face
-  '((((class color) (background light)) (:foreground "goldenrod" :bold t)))
+  '((((class color) (background light)) (:foreground "goldenrod" :bold t))
+    (((class color) (background dark)) (:foreground "goldenrod" :bold t)))
   "Git mode face used to highlight unknown files."
   :group 'git)
 
 (defface git-uptodate-face
-  '((((class color) (background light)) (:foreground "grey60")))
+  '((((class color) (background light)) (:foreground "grey60"))
+    (((class color) (background dark)) (:foreground "grey40")))
   "Git mode face used to highlight up-to-date files."
   :group 'git)
 
 (defface git-ignored-face
-  '((((class color) (background light)) (:foreground "grey60")))
+  '((((class color) (background light)) (:foreground "grey60"))
+    (((class color) (background dark)) (:foreground "grey40")))
   "Git mode face used to highlight ignored files."
   :group 'git)
 
 (defface git-mark-face
-  '((((class color) (background light)) (:foreground "red" :bold t)))
+  '((((class color) (background light)) (:foreground "red" :bold t))
+    (((class color) (background dark)) (:foreground "tomato" :bold t)))
   "Git mode face used for the file marks."
   :group 'git)
 
 (defface git-header-face
-  '((((class color) (background light)) (:foreground "blue")))
+  '((((class color) (background light)) (:foreground "blue"))
+    (((class color) (background dark)) (:foreground "blue")))
   "Git mode face used for commit headers."
   :group 'git)
 
 (defface git-separator-face
-  '((((class color) (background light)) (:foreground "brown")))
+  '((((class color) (background light)) (:foreground "brown"))
+    (((class color) (background dark)) (:foreground "brown")))
   "Git mode face used for commit separator."
   :group 'git)
 
 (defface git-permission-face
-  '((((class color) (background light)) (:foreground "green" :bold t)))
+  '((((class color) (background light)) (:foreground "green" :bold t))
+    (((class color) (background dark)) (:foreground "green" :bold t)))
   "Git mode face used for permission changes."
   :group 'git)
 
-- 
1.5.3.rc6.31.g3c3b
