From: freku045@student.liu.se
Subject: [PATCH 5/25] git-clone: Use $0 instead of program name in usage message.
Date: Sat, 10 Dec 2005 20:37:57 +0100
Message-ID: <11342434771528-git-send-email-freku045@student.liu.se>
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
	id 1ElAYb-0002PO-Oy
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbVLJTiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVLJTiS
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:18 -0500
Received: from [85.8.31.11] ([85.8.31.11]:20685 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161039AbVLJTiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 82B594115; Sat, 10 Dec 2005 20:48:14 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXd-0006yy-00; Sat, 10 Dec 2005 20:37:57 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13453>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

028cbc161562fae23c9797564c8d50da6c082941
diff --git a/git-clone.sh b/git-clone.sh
index 699205e..d07e4d9 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@
 unset CDPATH
 
 usage() {
-	echo >&2 "* git clone [-l [-s]] [-q] [-u <upload-pack>] [-n] <repo> [<dir>]"
+	echo >&2 "usage: $0 [-l [-s]] [-q] [-u <upload-pack>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
-- 
0.99.9.GIT
