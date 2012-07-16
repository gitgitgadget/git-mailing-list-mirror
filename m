From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH v2 6/8] t4012: Re-indent test snippets
Date: Mon, 16 Jul 2012 22:45:40 +0200
Message-ID: <7e7734764f24b17a1d2cd1205de7222a29723d35.1342468069.git.eclipse7@gmx.net>
References: <cover.1342468069.git.eclipse7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 22:45:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqsAy-00039d-9G
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab2GPUps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:45:48 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:56789 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752826Ab2GPUpq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:45:46 -0400
Received: (qmail invoked by alias); 16 Jul 2012 20:45:43 -0000
Received: from p5DC37C42.dip.t-dialin.net (EHLO gmx.net) [93.195.124.66]
  by mail.gmx.net (mp038) with SMTP; 16 Jul 2012 22:45:43 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX19v7dESAkFvSSkWgxDV6bBwLZ3ydFdATtaQulonVl
	Zo9yECDDqt0W/s
Received: by gmx.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 22:45:40 +0200
Content-Disposition: inline
In-Reply-To: <cover.1342468069.git.eclipse7@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201573>

Most one-level indents were 1 HT (horizontal tab) followed by 1 SP.
Remove the SP.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4012-diff-binary.sh | 68 +++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 4767761..7b0e759 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -16,12 +16,12 @@ cat >expect.binary-numstat <<\EOF
 EOF
 
 test_expect_success 'prepare repository' '
-	 echo AIT >a && echo BIT >b && echo CIT >c && echo DIT >d &&
-	 git update-index --add a b c d &&
-	 echo git >a &&
-	 cat "$TEST_DIRECTORY"/test-binary-1.png >b &&
-	 echo git >c &&
-	 cat b b >d
+	echo AIT >a && echo BIT >b && echo CIT >c && echo DIT >d &&
+	git update-index --add a b c d &&
+	echo git >a &&
+	cat "$TEST_DIRECTORY"/test-binary-1.png >b &&
+	echo git >c &&
+	cat b b >d
 '
 
 cat > expected <<\EOF
@@ -64,52 +64,52 @@ test_expect_success 'apply --numstat understands diff --binary format' '
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
 test_expect_success 'apply detecting corrupt patch correctly' '
-	 git diff >output &&
-	 sed -e "s/-CIT/xCIT/" <output >broken &&
-	 if git apply --stat --summary broken 2>detected
-	 then
+	git diff >output &&
+	sed -e "s/-CIT/xCIT/" <output >broken &&
+	if git apply --stat --summary broken 2>detected
+	then
 		echo unhappy - should have detected an error
 		(exit 1)
-	 else
+	else
 		echo happy
-	 fi &&
-	 detected=`cat detected` &&
-	 detected=`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
-	 detected=`sed -ne "${detected}p" broken` &&
-	 test "$detected" = xCIT
+	fi &&
+	detected=`cat detected` &&
+	detected=`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
+	detected=`sed -ne "${detected}p" broken` &&
+	test "$detected" = xCIT
 '
 
 test_expect_success 'apply detecting corrupt patch correctly' '
-	 git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
-	 if git apply --stat --summary broken 2>detected
-	 then
+	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
+	if git apply --stat --summary broken 2>detected
+	then
 		echo unhappy - should have detected an error
 		(exit 1)
-	 else
+	else
 		echo happy
-	 fi &&
-	 detected=`cat detected` &&
-	 detected=`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
-	 detected=`sed -ne "${detected}p" broken` &&
-	 test "$detected" = xCIT
+	fi &&
+	detected=`cat detected` &&
+	detected=`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
+	detected=`sed -ne "${detected}p" broken` &&
+	test "$detected" = xCIT
 '
 
 test_expect_success 'initial commit' 'git commit -a -m initial'
 
 # Try removal (b), modification (d), and creation (e).
 test_expect_success 'diff-index with --binary' '
-	 echo AIT >a && mv b e && echo CIT >c && cat e >d &&
-	 git update-index --add --remove a b c d e &&
-	 tree0=`git write-tree` &&
-	 git diff --cached --binary >current &&
-	 git apply --stat --summary current
+	echo AIT >a && mv b e && echo CIT >c && cat e >d &&
+	git update-index --add --remove a b c d e &&
+	tree0=`git write-tree` &&
+	git diff --cached --binary >current &&
+	git apply --stat --summary current
 '
 
 test_expect_success 'apply binary patch' '
-	 git reset --hard &&
-	 git apply --binary --index <current &&
-	 tree1=`git write-tree` &&
-	 test "$tree1" = "$tree0"
+	git reset --hard &&
+	git apply --binary --index <current &&
+	tree1=`git write-tree` &&
+	test "$tree1" = "$tree0"
 '
 
 test_expect_success 'diff --no-index with binary creation' '
-- 
1.7.10.2.552.gaa3bb87
