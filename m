From: freku045@student.liu.se
Subject: [PATCH 3/25] git-checkout: Use $0 instead of program name in usage message.
Date: Sat, 10 Dec 2005 20:37:57 +0100
Message-ID: <11342434771367-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:39:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAXx-0002Gb-Sn
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbVLJTiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbVLJTiK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:10 -0500
Received: from [85.8.31.11] ([85.8.31.11]:14029 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S964946AbVLJTiG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:06 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 402094103; Sat, 10 Dec 2005 20:48:14 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXd-0006yq-00; Sat, 10 Dec 2005 20:37:57 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13449>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-checkout.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

480ea8310be08611c841ae428c57003ac48c1827
diff --git a/git-checkout.sh b/git-checkout.sh
index 4cf30e2..2fcd766 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -2,7 +2,7 @@
 . git-sh-setup
 
 usage () {
-    die "usage: git checkout [-f] [-b <new_branch>] [<branch>] [<paths>...]"
+    die "usage: $0 [-f] [-b <new_branch>] [<branch>] [<paths>...]"
 }
 
 old=$(git-rev-parse HEAD)
-- 
0.99.9.GIT
