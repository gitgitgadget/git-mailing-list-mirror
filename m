From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/3] Fix some tab/space inconsistencies in git-mergetool.sh
Date: Tue, 21 Oct 2008 11:13:17 +0100
Message-ID: <1224583999-26279-1-git-send-email-charles@hashpling.org>
Cc: Jeff King <peff@peff.net>,
	William Pursell <bill.pursell@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Theodore Ts'o" <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 12:14:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsEG8-0002PX-PC
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 12:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbYJUKNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 06:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbYJUKNa
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 06:13:30 -0400
Received: from pih-relay05.plus.net ([212.159.14.18]:43031 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbYJUKN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 06:13:29 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1KsEEr-0008Qq-2E; Tue, 21 Oct 2008 11:13:21 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9LADKQg026303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Oct 2008 11:13:20 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m9LADJRN026302;
	Tue, 21 Oct 2008 11:13:19 +0100
X-Mailer: git-send-email 1.6.0.2.534.g5ab59
X-Plusnet-Relay: 1c349a3f98ba28d074784ae458e702a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98768>

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
