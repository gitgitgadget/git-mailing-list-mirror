From: freku045@student.liu.se
Subject: [PATCH 8/11] git-lost-found: Usage string clean-up, emit usage string at incorrect invocation
Date: Tue, 13 Dec 2005 23:30:31 +0100
Message-ID: <1134513031645-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:32:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIfZ-0006Sp-Bi
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVLMWap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVLMWao
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:44 -0500
Received: from [85.8.31.11] ([85.8.31.11]:51154 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030294AbVLMWal (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:41 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 3FF1D4117; Tue, 13 Dec 2005 23:41:00 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfI-0001zJ-00; Tue, 13 Dec 2005 23:30:32 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13594>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-lost-found.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

240de5191779f0637fb339a80a76770ee35f5a68
diff --git a/git-lost-found.sh b/git-lost-found.sh
index 2beec2a..ba6d587 100755
--- a/git-lost-found.sh
+++ b/git-lost-found.sh
@@ -1,6 +1,14 @@
 #!/bin/sh
 
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
+USAGE=''
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
+
+if [ "$#" != "0" ]
+then
+    usage
+fi
+
 laf="$GIT_DIR/lost-found"
 rm -fr "$laf" && mkdir -p "$laf/commit" "$laf/other" || exit
 
-- 
0.99.9.GIT
