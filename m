From: freku045@student.liu.se
Subject: [PATCH 9/25] git-format-patch: Use the 'die'-function where appropriate.
Date: Sat, 10 Dec 2005 20:37:57 +0100
Message-ID: <11342434773441-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:39:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAY0-0002Gb-Ad
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVLJTiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVLJTiN
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:13 -0500
Received: from [85.8.31.11] ([85.8.31.11]:21197 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161040AbVLJTiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 0ED22411A; Sat, 10 Dec 2005 20:48:15 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXd-0006zE-00; Sat, 10 Dec 2005 20:37:58 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13450>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-format-patch.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

78267845f0e0d20f23448692bf3ff967faf5fea7
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 1eebe85..4ecbf49 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -10,7 +10,7 @@ LANG=C LC_ALL=C
 export LANG LC_ALL
 
 usage () {
-    echo >&2 "usage: $0"' [-n] [-o dir | --stdout] [--keep-subject] [--mbox]
+    die "usage: $0"' [-n] [-o dir | --stdout] [--keep-subject] [--mbox]
     [--check] [--signoff] [-<diff options>...]
     [--help]
     ( from..to ... | upstream [ our-head ] )
@@ -30,7 +30,6 @@ When --mbox is specified, the output is 
 UNIX mailbox format, and can be concatenated together for processing
 with applymbox.
 '
-    exit 1
 }
 
 diff_opts=
-- 
0.99.9.GIT
