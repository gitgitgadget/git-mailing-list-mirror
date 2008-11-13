From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/3] Fix some tab/space inconsistencies in git-mergetool.sh
Date: Thu, 13 Nov 2008 12:41:13 +0000
Message-ID: <1226580075-29289-2-git-send-email-charles@hashpling.org>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0bX3-00086U-Qt
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 13:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYKMMl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 07:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYKMMl3
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 07:41:29 -0500
Received: from ptb-relay02.plus.net ([212.159.14.146]:56606 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbYKMMl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 07:41:28 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1L0bVc-0002DN-JO; Thu, 13 Nov 2008 12:41:16 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mADCfFN5029323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 12:41:15 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id mADCfF5w029322;
	Thu, 13 Nov 2008 12:41:15 GMT
X-Mailer: git-send-email 1.6.0.2.534.g5ab59
In-Reply-To: <1226580075-29289-1-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 2c3a58d473136ba897facf38a653b4a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100869>

git-mergetool.sh mostly uses 8 space tabs and 4 spaces per indent. This
change corrects this in a part of the file affect by a later commit in
this patch series. diff -w considers this change is to be a null change.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 git-mergetool.sh |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 94187c3..e2da5fc 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -401,25 +401,25 @@ fi
 
 
 if test $# -eq 0 ; then
-	files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
-	if test -z "$files" ; then
-		echo "No files need merging"
-		exit 0
-	fi
-	echo Merging the files: "$files"
-	git ls-files -u |
-	sed -e 's/^[^	]*	//' |
-	sort -u |
-	while IFS= read i
-	do
-		printf "\n"
-		merge_file "$i" < /dev/tty > /dev/tty
-	done
+    files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
+    if test -z "$files" ; then
+	echo "No files need merging"
+	exit 0
+    fi
+    echo Merging the files: "$files"
+    git ls-files -u |
+    sed -e 's/^[^	]*	//' |
+    sort -u |
+    while IFS= read i
+    do
+	printf "\n"
+	merge_file "$i" < /dev/tty > /dev/tty
+    done
 else
-	while test $# -gt 0; do
-		printf "\n"
-		merge_file "$1"
-		shift
-	done
+    while test $# -gt 0; do
+	printf "\n"
+	merge_file "$1"
+	shift
+    done
 fi
 exit 0
-- 
1.6.0.2.534.g5ab59
