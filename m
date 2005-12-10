From: freku045@student.liu.se
Subject: [PATCH 8/25] git-fetch: Print usage message if we get an unrecognized option.
Date: Sat, 10 Dec 2005 20:37:57 +0100
Message-ID: <11342434773816-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYj-0002PO-N4
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVLJTiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbVLJTiT
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:19 -0500
Received: from [85.8.31.11] ([85.8.31.11]:20429 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161037AbVLJTiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id E14984119; Sat, 10 Dec 2005 20:48:14 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXd-0006zA-00; Sat, 10 Dec 2005 20:37:57 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13463>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-fetch.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

50d509080e5cf32880bf412133473557f9e5f5b2
diff --git a/git-fetch.sh b/git-fetch.sh
index 14ea295..18b421d 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -2,6 +2,11 @@
 #
 . git-sh-setup
 . git-parse-remote
+
+usage () {
+    die "usage: $0 <fetch-options> <repository> <refspec>..."
+}
+
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
@@ -34,6 +39,9 @@ do
 	-v|--verbose)
 		verbose=Yes
 		;;
+        -*)
+                usage
+                ;;
 	*)
 		break
 		;;
-- 
0.99.9.GIT
