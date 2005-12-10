From: freku045@student.liu.se
Subject: [PATCH 6/25] git-commit: Use $0 instead of program name in usage message.
Date: Sat, 10 Dec 2005 20:37:57 +0100
Message-ID: <11342434773071-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:39:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAXz-0002Gb-P2
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbVLJTiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVLJTiP
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:15 -0500
Received: from [85.8.31.11] ([85.8.31.11]:19917 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161036AbVLJTiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A24DF4117; Sat, 10 Dec 2005 20:48:14 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXd-0006z2-00; Sat, 10 Dec 2005 20:37:57 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13451>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

2b859132aeae56504c0d7aaa99436dce9dac2117
diff --git a/git-commit.sh b/git-commit.sh
index 3d250ec..1893f98 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -6,7 +6,7 @@
 . git-sh-setup
 
 usage () {
-	die 'git commit [-a] [-s] [-v | --no-verify]  [-m <message> | -F <logfile> | (-C|-c) <commit>] [-e] [<path>...]'
+	die "usage: $0 [-a] [-s] [-v | --no-verify]  [-m <message> | -F <logfile> | (-C|-c) <commit>] [-e] [<path>...]"
 }
 
 all= logfile= use_commit= no_edit= log_given= log_message= verify=t signoff=
-- 
0.99.9.GIT
