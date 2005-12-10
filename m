From: freku045@student.liu.se
Subject: [PATCH 19/25] git-request-pull: Print usage message to stderr.
Date: Sat, 10 Dec 2005 20:37:59 +0100
Message-ID: <11342434792502-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:40:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAYe-0002PO-Is
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbVLJTi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbVLJTiZ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:25 -0500
Received: from [85.8.31.11] ([85.8.31.11]:22989 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161032AbVLJTiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:10 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 74F344125; Sat, 10 Dec 2005 20:48:16 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXf-0006zw-00; Sat, 10 Dec 2005 20:37:59 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13452>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-request-pull.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

342b45c20724b86b1b12c3f588d6aff12c1ceb11
diff --git a/git-request-pull.sh b/git-request-pull.sh
index ae6cd27..e199a91 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -6,9 +6,9 @@
 
 usage()
 {
-	echo "$0 <commit> <url> [ <head> ]"
-	echo "  Summarizes the changes since <commit> to the standard output,"
-	echo "  and includes <url> in the message generated."
+	echo >&2 "usage: $0 <commit> <url> [<head>]"
+	echo >&2 '  Summarizes the changes since <commit> to the standard output,'
+	echo >&2 '  and includes <url> in the message generated.'
 	exit 1
 }
 
-- 
0.99.9.GIT
