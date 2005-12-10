From: freku045@student.liu.se
Subject: [PATCH 13/25] git-merge: Print $0 instead of program name in usage message.
Date: Sat, 10 Dec 2005 20:37:58 +0100
Message-ID: <11342434782697-git-send-email-freku045@student.liu.se>
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
	id 1ElAYX-0002PO-N8
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbVLJTim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbVLJTik
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:40 -0500
Received: from [85.8.31.11] ([85.8.31.11]:25805 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161059AbVLJTiP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:15 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 8BD79411E; Sat, 10 Dec 2005 20:48:15 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXe-0006zU-00; Sat, 10 Dec 2005 20:37:58 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13464>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ea22e6b3b15294ae1c6f367b109ee3f969b115c8
diff --git a/git-merge.sh b/git-merge.sh
index a221daa..f7aca19 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -9,7 +9,7 @@ LF='
 '
 
 usage () {
-    die "git-merge [-n] [--no-commit] [-s <strategy>]... <merge-message> <head> <remote>+"
+    die "usage: $0 [-n] [--no-commit] [-s <strategy>]... <merge-message> <head> <remote>+"
 }
 
 all_strategies='recursive octopus resolve stupid ours'
-- 
0.99.9.GIT
