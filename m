From: freku045@student.liu.se
Subject: [PATCH 18/25] git-repack: Print usage message on unrecognized option.
Date: Sat, 10 Dec 2005 20:37:59 +0100
Message-ID: <1134243479885-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYa-0002PO-LY
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbVLJTi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbVLJTi0
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:26 -0500
Received: from [85.8.31.11] ([85.8.31.11]:22733 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161047AbVLJTiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:10 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 53EB04124; Sat, 10 Dec 2005 20:48:16 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXf-0006zs-00; Sat, 10 Dec 2005 20:37:59 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13456>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-repack.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

3616296531a068dcbe5a39f8864ddde3b3067969
diff --git a/git-repack.sh b/git-repack.sh
index 430ddc5..9752032 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -4,7 +4,11 @@
 #
 
 . git-sh-setup
-	
+
+usage () {
+	die "usage: $0 [-a] [-d] [-l] [-n]"
+}
+
 no_update_info= all_into_one= remove_redundant= local=
 while case "$#" in 0) break ;; esac
 do
@@ -13,6 +17,7 @@ do
 	-a)	all_into_one=t ;;
 	-d)	remove_redundant=t ;;
 	-l)	local=t ;;
+	-*)	usage ;;
 	*)	break ;;
 	esac
 	shift
-- 
0.99.9.GIT
