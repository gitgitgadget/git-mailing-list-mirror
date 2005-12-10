From: freku045@student.liu.se
Subject: [PATCH 23/25] git-tag: Clean-up usage message.
Date: Sat, 10 Dec 2005 20:37:59 +0100
Message-ID: <11342434793108-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYY-0002PO-Vd
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbVLJTic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbVLJTia
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:30 -0500
Received: from [85.8.31.11] ([85.8.31.11]:24013 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161048AbVLJTiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:10 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 01A594129; Sat, 10 Dec 2005 20:48:17 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXf-00070C-00; Sat, 10 Dec 2005 20:37:59 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13467>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-tag.sh |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

3a3150d9fbd640ffb269fc49a322c04466e700f5
diff --git a/git-tag.sh b/git-tag.sh
index 2435a75..f4a0150 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -1,16 +1,10 @@
 #!/bin/sh
 # Copyright (c) 2005 Linus Torvalds
 
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
+. git-sh-setup
 
 usage () {
-    echo >&2 "Usage: git-tag [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <tagname> [<head>]"
-    exit 1
-}
-
-die () {
-    echo >&2 "$*"
-    exit 1
+    die "usage: $0 [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <tagname> [<head>]"
 }
 
 annotate=
-- 
0.99.9.GIT
