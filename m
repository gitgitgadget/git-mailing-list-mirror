From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] the use of 'tr' in the test suite isn't really portable
Date: Mon, 17 Dec 2007 23:28:46 +0100
Message-ID: <20071217232846.476940ec@pc09.procura.nl>
References: <20071217191508.79cc05e2@pc09.procura.nl>
	<7vlk7t6pc6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/9sN=tmzMMe6zAiFyIf_X/vX"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OUY-0000ck-QC
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbXLQWaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbXLQWaJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:30:09 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:2730 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757545AbXLQWaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:30:06 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBHMSkqM062503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Dec 2007 23:28:55 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vlk7t6pc6.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68639>

--MP_/9sN=tmzMMe6zAiFyIf_X/vX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 17 Dec 2007 12:25:29 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> The contents looked correct but the patch was garbled.

http://www.xs4all.nl/~procura/git-tr.diff
and attached

The docs tell me to use git-diff, but I don't have a git repos for git,
because git on HP-UX doesn't work yet out of the box, so I use the
snapshots from http://www.codemonkey.org.uk/projects/git-snapshots/git/

This was based on 2007-12-17


-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/

--MP_/9sN=tmzMMe6zAiFyIf_X/vX
Content-Type: text/x-patch; name=git-tr.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=git-tr.diff

diff -pur git-2007-12-10_01/git-filter-branch.sh git-2007-12-10/git-filter-branch.sh
--- git-2007-12-10_01/git-filter-branch.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/git-filter-branch.sh	2007-12-11 13:39:02 +0100
@@ -290,7 +290,7 @@ while read commit parents; do
 		eval "$filter_tree" < /dev/null ||
 			die "tree filter failed: $filter_tree"
 
-		git diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
+		git diff-index -r $commit | cut -f 2- | tr '\n' '\000' | \
 			xargs -0 git update-index --add --replace --remove
 		git ls-files -z --others | \
 			xargs -0 git update-index --add --replace --remove
diff -pur git-2007-12-10_01/t/diff-lib.sh git-2007-12-10/t/diff-lib.sh
--- git-2007-12-10_01/t/diff-lib.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/diff-lib.sh	2007-12-11 13:39:56 +0100
@@ -21,8 +21,8 @@ compare_diff_raw_z () {
     # Also we do not check SHA1 hash generation in this test, which
     # is a job for t0000-basic.sh
 
-    tr '\0' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
-    tr '\0' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
+    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
+    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
     git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
diff -pur git-2007-12-10_01/t/t0020-crlf.sh git-2007-12-10/t/t0020-crlf.sh
--- git-2007-12-10_01/t/t0020-crlf.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t0020-crlf.sh	2007-12-10 14:25:58 +0100
@@ -5,7 +5,7 @@ test_description='CRLF conversion'
 . ./test-lib.sh
 
 q_to_nul () {
-	tr Q '\0'
+	tr Q '\000'
 }
 
 append_cr () {
diff -pur git-2007-12-10_01/t/t1300-repo-config.sh git-2007-12-10/t/t1300-repo-config.sh
--- git-2007-12-10_01/t/t1300-repo-config.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t1300-repo-config.sh	2007-12-10 09:49:48 +0100
@@ -591,12 +591,12 @@ Qsection.sub=section.val4
 Qsection.sub=section.val5Q
 EOF
 
-git config --null --list | tr '[\000]' 'Q' > result
+git config --null --list | tr '\000' 'Q' > result
 echo >>result
 
 test_expect_success '--null --list' 'cmp result expect'
 
-git config --null --get-regexp 'val[0-9]' | tr '[\000]' 'Q' > result
+git config --null --get-regexp 'val[0-9]' | tr '\000' 'Q' > result
 echo >>result
 
 test_expect_success '--null --get-regexp' 'cmp result expect'
diff -pur git-2007-12-10_01/t/t3300-funny-names.sh git-2007-12-10/t/t3300-funny-names.sh
--- git-2007-12-10_01/t/t3300-funny-names.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t3300-funny-names.sh	2007-12-11 13:40:32 +0100
@@ -54,7 +54,7 @@ echo 'just space
 no-funny
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git ls-files -z with-funny' \
-	'git ls-files -z | tr \\0 \\012 >current &&
+	'git ls-files -z | tr \\000 \\012 >current &&
 	git diff expected current'
 
 t1=`git write-tree`
@@ -83,11 +83,11 @@ test_expect_success 'git diff-tree with-
 echo 'A
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git diff-index -z with-funny' \
-	'git diff-index -z --name-status $t0 | tr \\0 \\012 >current &&
+	'git diff-index -z --name-status $t0 | tr \\000 \\012 >current &&
 	git diff expected current'
 
 test_expect_success 'git diff-tree -z with-funny' \
-	'git diff-tree -z --name-status $t0 $t1 | tr \\0 \\012 >current &&
+	'git diff-tree -z --name-status $t0 $t1 | tr \\000 \\012 >current &&
 	git diff expected current'
 
 cat > expected <<\EOF
diff -pur git-2007-12-10_01/t/t4020-diff-external.sh git-2007-12-10/t/t4020-diff-external.sh
--- git-2007-12-10_01/t/t4020-diff-external.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t4020-diff-external.sh	2007-12-11 13:40:44 +0100
@@ -99,7 +99,7 @@ test_expect_success 'no diff with -diff'
 	git diff | grep Binary
 '
 
-echo NULZbetweenZwords | tr Z '\0' > file
+echo NULZbetweenZwords | tr Z '\000' > file
 
 test_expect_success 'force diff with "diff"' '
 	echo >.gitattributes "file diff" &&
diff -pur git-2007-12-10_01/t/t4103-apply-binary.sh git-2007-12-10/t/t4103-apply-binary.sh
--- git-2007-12-10_01/t/t4103-apply-binary.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t4103-apply-binary.sh	2007-12-11 13:40:57 +0100
@@ -24,10 +24,10 @@ git update-index --add --remove file1 fi
 git-commit -m 'Initial Version' 2>/dev/null
 
 git-checkout -b binary
-tr 'x' '\0' <file1 >file3
+tr 'x' '\000' <file1 >file3
 cat file3 >file4
 git add file2
-tr '\0' 'v' <file3 >file1
+tr '\000' 'v' <file3 >file1
 rm -f file2
 git update-index --add --remove file1 file2 file3 file4
 git-commit -m 'Second Version'
diff -pur git-2007-12-10_01/t/t4116-apply-reverse.sh git-2007-12-10/t/t4116-apply-reverse.sh
--- git-2007-12-10_01/t/t4116-apply-reverse.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t4116-apply-reverse.sh	2007-12-11 13:42:13 +0100
@@ -12,14 +12,14 @@ test_description='git apply in reverse
 test_expect_success setup '
 
 	for i in a b c d e f g h i j k l m n; do echo $i; done >file1 &&
-	tr "[ijk]" '\''[\0\1\2]'\'' <file1 >file2 &&
+	tr "ijk" '\''\000\001\002'\'' <file1 >file2 &&
 
 	git add file1 file2 &&
 	git commit -m initial &&
 	git tag initial &&
 
 	for i in a b c g h i J K L m o n p q; do echo $i; done >file1 &&
-	tr "[mon]" '\''[\0\1\2]'\'' <file1 >file2 &&
+	tr "mon" '\''\000\001\002'\'' <file1 >file2 &&
 
 	git commit -a -m second &&
 	git tag second &&
diff -pur git-2007-12-10_01/t/t4200-rerere.sh git-2007-12-10/t/t4200-rerere.sh
--- git-2007-12-10_01/t/t4200-rerere.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t4200-rerere.sh	2007-12-11 13:42:28 +0100
@@ -129,7 +129,7 @@ test_expect_success 'rerere kicked in' "
 test_expect_success 'rerere prefers first change' 'git diff a1 expect'
 
 rm $rr/postimage
-echo "$sha1	a1" | tr '\012' '\0' > .git/rr-cache/MERGE_RR
+echo "$sha1	a1" | tr '\012' '\000' > .git/rr-cache/MERGE_RR
 
 test_expect_success 'rerere clear' 'git rerere clear'
 
diff -pur git-2007-12-10_01/t/t5300-pack-object.sh git-2007-12-10/t/t5300-pack-object.sh
--- git-2007-12-10_01/t/t5300-pack-object.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/t/t5300-pack-object.sh	2007-12-11 13:42:46 +0100
@@ -15,7 +15,7 @@ test_expect_success \
     'rm -f .git/index*
      for i in a b c
      do
-	     dd if=/dev/zero bs=4k count=1 | tr "\\0" $i >$i &&
+	     dd if=/dev/zero bs=4k count=1 | tr "\\000" $i >$i &&
 	     git update-index --add $i || return 1
      done &&
      cat c >d && echo foo >>d && git update-index --add d &&
diff -pur git-2007-12-10_01/test-sha1.sh git-2007-12-10/test-sha1.sh
--- git-2007-12-10_01/test-sha1.sh	2007-12-09 10:23:48 +0100
+++ git-2007-12-10/test-sha1.sh	2007-12-11 13:39:29 +0100
@@ -10,7 +10,7 @@ do
 		{
 			test -z "$pfx" || echo "$pfx"
 			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-			tr '[\0]' '[g]'
+			tr '\000' 'g'
 		} | ./test-sha1 $cnt
 	`
 	if test "$expect" = "$actual"
@@ -55,7 +55,7 @@ do
 		{
 			test -z "$pfx" || echo "$pfx"
 			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
-			tr '[\0]' '[g]'
+			tr '\000' 'g'
 		} | sha1sum |
 		sed -e 's/ .*//'
 	`

--MP_/9sN=tmzMMe6zAiFyIf_X/vX--
