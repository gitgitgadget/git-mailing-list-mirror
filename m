From: freku045@student.liu.se
Subject: [PATCH 9/11] git-prune: Usage string clean-up, use the 'usage' function
Date: Tue, 13 Dec 2005 23:30:32 +0100
Message-ID: <11345130322374-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:32:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIfZ-0006Sp-Tc
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVLMWar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbVLMWap
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:45 -0500
Received: from [85.8.31.11] ([85.8.31.11]:51666 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030293AbVLMWal (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:41 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 5ECF74118; Tue, 13 Dec 2005 23:41:00 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfI-0001zN-00; Tue, 13 Dec 2005 23:30:32 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13599>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-prune.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

7fb74410bb8975f547d0bae395b74ca783a5cce4
diff --git a/git-prune.sh b/git-prune.sh
index 7e7f0ad..7b61d05 100755
--- a/git-prune.sh
+++ b/git-prune.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+USAGE='[-n] [--] [<head>...]'
 . git-sh-setup
 
 dryrun=
@@ -9,7 +10,7 @@ do
     case "$1" in
     -n) dryrun=-n echo=echo ;;
     --) break ;;
-    -*) echo >&2 "usage: git-prune [ -n ] [ heads... ]"; exit 1 ;;
+    -*) usage ;;
     *)  break ;;
     esac
     shift;
-- 
0.99.9.GIT
