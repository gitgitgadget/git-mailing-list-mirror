From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 3/4] tests: use "git xyzzy" form (t7000 - t7199)
Date: Wed, 03 Sep 2008 17:59:31 +0900
Message-ID: <20080903175931.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 11:01:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaoF2-00011w-Q6
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYICJAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbYICJAM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:00:12 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36035 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbYICJAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:00:06 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id A2B59C8904;
	Wed,  3 Sep 2008 03:59:56 -0500 (CDT)
Received: from 8115.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 0PDK8Q4TMT8H; Wed, 03 Sep 2008 04:00:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Kj3+bnznW6LnJWeisvDzpkNG4HsUqEejR12MuMUafkrXWY7XJW3CUyHgP9LPYg60yBrFcsH+uqBf6YGdAdSTq/78uDsTw7fqQRKmH5MkJrzy3s/dzg80rpW8QfViCVFbBH3ET9hvjMDDH5/Z+uzTnT+N/VRq800Laz8G73KrDxA=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94770>

Converts tests between t7001-t7103.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 t/t7001-mv.sh            |   12 +-
 t/t7003-filter-branch.sh |   22 ++--
 t/t7004-tag.sh           |  318 +++++++++++++++++++++++-----------------------
 t/t7101-reset.sh         |    8 +-
 t/t7102-reset.sh         |    4 +-
 t/t7103-reset-bare.sh    |    2 +-
 6 files changed, 183 insertions(+), 183 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7816798..575ef5b 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -10,3 +10,3 @@ test_expect_success \
      git add path0/COPYING &&
-     git-commit -m add -a'
+     git commit -m add -a'
 
@@ -19,3 +19,3 @@ test_expect_success \
     'commiting the change' \
-    'cd .. && git-commit -m move-out -a'
+    'cd .. && git commit -m move-out -a'
 
@@ -33,3 +33,3 @@ test_expect_success \
     'commiting the change' \
-    'cd .. && git-commit -m move-in -a'
+    'cd .. && git commit -m move-in -a'
 
@@ -44,3 +44,3 @@ test_expect_success \
      git add path0/README &&
-     git-commit -m add2 -a'
+     git commit -m add2 -a'
 
@@ -52,3 +52,3 @@ test_expect_success \
     'commiting the change' \
-    'git-commit -m dir-move -a'
+    'git commit -m dir-move -a'
 
@@ -71,3 +71,3 @@ test_expect_success \
     'commiting the change' \
-    'git-commit -m dir-move -a'
+    'git commit -m dir-move -a'
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 95f13a8..b0a9d7d 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -2,3 +2,3 @@
 
-test_description='git-filter-branch'
+test_description='git filter-branch'
 . ./test-lib.sh
@@ -34,3 +34,3 @@ H=$(git rev-parse H)
 test_expect_success 'rewrite identically' '
-	git-filter-branch branch
+	git filter-branch branch
 '
@@ -41,3 +41,3 @@ test_expect_success 'result is really identical' '
 test_expect_success 'rewrite bare repository identically' '
-	(git config core.bare true && cd .git && git-filter-branch branch)
+	(git config core.bare true && cd .git && git filter-branch branch)
 '
@@ -49,3 +49,3 @@ test_expect_success 'result is really identical' '
 test_expect_success 'rewrite, renaming a specific file' '
-	git-filter-branch -f --tree-filter "mv d doh || :" HEAD
+	git filter-branch -f --tree-filter "mv d doh || :" HEAD
 '
@@ -60,3 +60,3 @@ test_expect_success 'test that the file was renamed' '
 test_expect_success 'rewrite, renaming a specific directory' '
-	git-filter-branch -f --tree-filter "mv dir diroh || :" HEAD
+	git filter-branch -f --tree-filter "mv dir diroh || :" HEAD
 '
@@ -75,3 +75,3 @@ test_expect_success 'rewrite one branch, keeping a side branch' '
 	git branch modD oldD &&
-	git-filter-branch -f --tree-filter "mv b boh || :" D..modD
+	git filter-branch -f --tree-filter "mv b boh || :" D..modD
 '
@@ -99,3 +99,3 @@ test_expect_success 'filter subdirectory only' '
 	git branch sub-earlier HEAD~2 &&
-	git-filter-branch -f --subdirectory-filter subdir \
+	git filter-branch -f --subdirectory-filter subdir \
 		refs/heads/sub refs/heads/sub-earlier
@@ -126,3 +126,3 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 	git branch directorymoved &&
-	git-filter-branch -f --index-filter \
+	git filter-branch -f --index-filter \
 		 "git ls-files -s | sed \"s-\\t-&newsubdir/-\" |
@@ -135,3 +135,3 @@ test_expect_success 'stops when msg filter fails' '
 	old=$(git rev-parse HEAD) &&
-	test_must_fail git-filter-branch -f --msg-filter false HEAD &&
+	test_must_fail git filter-branch -f --msg-filter false HEAD &&
 	test $old = $(git rev-parse HEAD) &&
@@ -146,3 +146,3 @@ test_expect_success 'author information is preserved' '
 	git branch preserved-author &&
-	git-filter-branch -f --msg-filter "cat; \
+	git filter-branch -f --msg-filter "cat; \
 			test \$GIT_COMMIT != $(git rev-parse master) || \
@@ -158,3 +158,3 @@ test_expect_success "remove a certain author's commits" '
 	git branch removed-author &&
-	git-filter-branch -f --commit-filter "\
+	git filter-branch -f --commit-filter "\
 		if [ \"\$GIT_AUTHOR_NAME\" = \"B V Uips\" ];\
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 198244c..f0edbf1 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -5,3 +5,3 @@
 
-test_description='git-tag
+test_description='git tag
 
@@ -24,4 +24,4 @@ test_expect_success 'listing all tags in an empty tree should succeed' '
 test_expect_success 'listing all tags in an empty tree should output nothing' '
-	test `git-tag -l | wc -l` -eq 0 &&
-	test `git-tag | wc -l` -eq 0
+	test `git tag -l | wc -l` -eq 0 &&
+	test `git tag | wc -l` -eq 0
 '
@@ -32,3 +32,3 @@ test_expect_success 'looking for a tag in an empty tree should fail' \
 test_expect_success 'creating a tag in an empty tree should fail' '
-	test_must_fail git-tag mynotag &&
+	test_must_fail git tag mynotag &&
 	! tag_exists mynotag
@@ -37,3 +37,3 @@ test_expect_success 'creating a tag in an empty tree should fail' '
 test_expect_success 'creating a tag for HEAD in an empty tree should fail' '
-	test_must_fail git-tag mytaghead HEAD &&
+	test_must_fail git tag mytaghead HEAD &&
 	! tag_exists mytaghead
@@ -42,3 +42,3 @@ test_expect_success 'creating a tag for HEAD in an empty tree should fail' '
 test_expect_success 'creating a tag for an unknown revision should fail' '
-	test_must_fail git-tag mytagnorev aaaaaaaaaaa &&
+	test_must_fail git tag mytagnorev aaaaaaaaaaa &&
 	! tag_exists mytagnorev
@@ -56,4 +56,4 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
 test_expect_success 'listing all tags if one exists should succeed' '
-	git-tag -l &&
-	git-tag
+	git tag -l &&
+	git tag
 '
@@ -61,4 +61,4 @@ test_expect_success 'listing all tags if one exists should succeed' '
 test_expect_success 'listing all tags if one exists should output that tag' '
-	test `git-tag -l` = mytag &&
-	test `git-tag` = mytag
+	test `git tag -l` = mytag &&
+	test `git tag` = mytag
 '
@@ -68,3 +68,3 @@ test_expect_success 'listing all tags if one exists should output that tag' '
 test_expect_success 'listing a tag using a matching pattern should succeed' \
-	'git-tag -l mytag'
+	'git tag -l mytag'
 
@@ -72,3 +72,3 @@ test_expect_success \
 	'listing a tag using a matching pattern should output that tag' \
-	'test `git-tag -l mytag` = mytag'
+	'test `git tag -l mytag` = mytag'
 
@@ -77,3 +77,3 @@ test_expect_success \
 	'listing tags using a non-matching pattern should suceed' \
-	'git-tag -l xxx'
+	'git tag -l xxx'
 
@@ -81,3 +81,3 @@ test_expect_success \
 	'listing tags using a non-matching pattern should output nothing' \
-	'test `git-tag -l xxx | wc -l` -eq 0'
+	'test `git tag -l xxx | wc -l` -eq 0'
 
@@ -91,3 +91,3 @@ test_expect_success \
 	'trying to create a tag with a non-valid name should fail' '
-	test `git-tag -l | wc -l` -eq 1 &&
+	test `git tag -l | wc -l` -eq 1 &&
 	test_must_fail git tag "" &&
@@ -97,3 +97,3 @@ test_expect_success \
 	test_must_fail git tag "other~tag" &&
-	test `git-tag -l | wc -l` -eq 1
+	test `git tag -l | wc -l` -eq 1
 '
@@ -109,3 +109,3 @@ test_expect_success 'trying to delete an unknown tag should fail' '
 	! tag_exists unknown-tag &&
-	test_must_fail git-tag -d unknown-tag
+	test_must_fail git tag -d unknown-tag
 '
@@ -119,3 +119,3 @@ test_expect_success \
 	git tag -l > actual && test_cmp expect actual &&
-	git-tag -d &&
+	git tag -d &&
 	git tag -l > actual && test_cmp expect actual
@@ -127,3 +127,3 @@ test_expect_success \
 	tag_exists myhead &&
-	git-tag -d mytag myhead &&
+	git tag -d mytag myhead &&
 	! tag_exists mytag &&
@@ -135,3 +135,3 @@ test_expect_success \
 	! tag_exists mytag &&
-	git-tag mytag &&
+	git tag mytag &&
 	tag_exists mytag
@@ -143,3 +143,3 @@ test_expect_success \
 	! tag_exists myhead &&
-	test_must_fail git-tag -d mytag anothertag &&
+	test_must_fail git tag -d mytag anothertag &&
 	! tag_exists mytag &&
@@ -149,3 +149,3 @@ test_expect_success \
 test_expect_success 'trying to delete an already deleted tag should fail' \
-	'test_must_fail git-tag -d mytag'
+	'test_must_fail git tag -d mytag'
 
@@ -187,3 +187,3 @@ test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
-	git-tag -l "*a*" > actual &&
+	git tag -l "*a*" > actual &&
 	test_cmp expect actual
@@ -197,3 +197,3 @@ test_expect_success \
 	'listing tags with a suffix as pattern must print those matching' '
-	git-tag -l "*.1" > actual &&
+	git tag -l "*.1" > actual &&
 	test_cmp expect actual
@@ -207,3 +207,3 @@ test_expect_success \
 	'listing tags with a prefix as pattern must print those matching' '
-	git-tag -l "t21*" > actual &&
+	git tag -l "t21*" > actual &&
 	test_cmp expect actual
@@ -216,3 +216,3 @@ test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git-tag -l a1 > actual &&
+	git tag -l a1 > actual &&
 	test_cmp expect actual
@@ -225,3 +225,3 @@ test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git-tag -l v1.0 > actual &&
+	git tag -l v1.0 > actual &&
 	test_cmp expect actual
@@ -235,3 +235,3 @@ test_expect_success \
 	'listing tags with ? in the pattern should print those matching' '
-	git-tag -l "v1.?.?" > actual &&
+	git tag -l "v1.?.?" > actual &&
 	test_cmp expect actual
@@ -242,3 +242,3 @@ test_expect_success \
 	'listing tags using v.* should print nothing because none have v.' '
-	git-tag -l "v.*" > actual &&
+	git tag -l "v.*" > actual &&
 	test_cmp expect actual
@@ -254,3 +254,3 @@ test_expect_success \
 	'listing tags using v* should print only those having v' '
-	git-tag -l "v*" > actual &&
+	git tag -l "v*" > actual &&
 	test_cmp expect actual
@@ -262,3 +262,3 @@ test_expect_success \
 	'a non-annotated tag created without parameters should point to HEAD' '
-	git-tag non-annotated-tag &&
+	git tag non-annotated-tag &&
 	test $(git cat-file -t non-annotated-tag) = commit &&
@@ -268,3 +268,3 @@ test_expect_success \
 test_expect_success 'trying to verify an unknown tag should fail' \
-	'test_must_fail git-tag -v unknown-tag'
+	'test_must_fail git tag -v unknown-tag'
 
@@ -272,3 +272,3 @@ test_expect_success \
 	'trying to verify a non-annotated and non-signed tag should fail' \
-	'test_must_fail git-tag -v non-annotated-tag'
+	'test_must_fail git tag -v non-annotated-tag'
 
@@ -276,3 +276,3 @@ test_expect_success \
 	'trying to verify many non-annotated or unknown tags, should fail' \
-	'test_must_fail git-tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+	'test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2'
 
@@ -302,3 +302,3 @@ test_expect_success \
 	'creating an annotated tag with -m message should succeed' '
-	git-tag -m "A message" annotated-tag &&
+	git tag -m "A message" annotated-tag &&
 	get_tag_msg annotated-tag >actual &&
@@ -315,3 +315,3 @@ test_expect_success \
 	'creating an annotated tag with -F messagefile should succeed' '
-	git-tag -F msgfile file-annotated-tag &&
+	git tag -F msgfile file-annotated-tag &&
 	get_tag_msg file-annotated-tag >actual &&
@@ -327,3 +327,3 @@ cat inputmsg >>expect
 test_expect_success 'creating an annotated tag with -F - should succeed' '
-	git-tag -F - stdin-annotated-tag <inputmsg &&
+	git tag -F - stdin-annotated-tag <inputmsg &&
 	get_tag_msg stdin-annotated-tag >actual &&
@@ -336,3 +336,3 @@ test_expect_success \
 	! tag_exists notag &&
-	test_must_fail git-tag -F nonexistingfile notag &&
+	test_must_fail git tag -F nonexistingfile notag &&
 	! tag_exists notag
@@ -345,7 +345,7 @@ test_expect_success \
 	! tag_exists msgtag &&
-	test_must_fail git-tag -m "message 1" -F msgfile1 msgtag &&
+	test_must_fail git tag -m "message 1" -F msgfile1 msgtag &&
 	! tag_exists msgtag &&
-	test_must_fail git-tag -F msgfile1 -m "message 1" msgtag &&
+	test_must_fail git tag -F msgfile1 -m "message 1" msgtag &&
 	! tag_exists msgtag &&
-	test_must_fail git-tag -m "message 1" -F msgfile1 \
+	test_must_fail git tag -m "message 1" -F msgfile1 \
 		-m "message 2" msgtag &&
@@ -359,3 +359,3 @@ test_expect_success \
 	'creating a tag with an empty -m message should succeed' '
-	git-tag -m "" empty-annotated-tag &&
+	git tag -m "" empty-annotated-tag &&
 	get_tag_msg empty-annotated-tag >actual &&
@@ -368,3 +368,3 @@ test_expect_success \
 	'creating a tag with an empty -F messagefile should succeed' '
-	git-tag -F emptyfile emptyfile-annotated-tag &&
+	git tag -F emptyfile emptyfile-annotated-tag &&
 	get_tag_msg emptyfile-annotated-tag >actual &&
@@ -389,3 +389,3 @@ test_expect_success \
 	'extra blanks in the message for an annotated tag should be removed' '
-	git-tag -F blanksfile blanks-annotated-tag &&
+	git tag -F blanksfile blanks-annotated-tag &&
 	get_tag_msg blanks-annotated-tag >actual &&
@@ -397,3 +397,3 @@ test_expect_success \
 	'creating a tag with blank -m message with spaces should succeed' '
-	git-tag -m "     " blank-annotated-tag &&
+	git tag -m "     " blank-annotated-tag &&
 	get_tag_msg blank-annotated-tag >actual &&
@@ -408,3 +408,3 @@ test_expect_success \
 	'creating a tag with blank -F messagefile with spaces should succeed' '
-	git-tag -F blankfile blankfile-annotated-tag &&
+	git tag -F blankfile blankfile-annotated-tag &&
 	get_tag_msg blankfile-annotated-tag >actual &&
@@ -417,3 +417,3 @@ test_expect_success \
 	'creating a tag with -F file of spaces and no newline should succeed' '
-	git-tag -F blanknonlfile blanknonlfile-annotated-tag &&
+	git tag -F blanknonlfile blanknonlfile-annotated-tag &&
 	get_tag_msg blanknonlfile-annotated-tag >actual &&
@@ -452,3 +452,3 @@ test_expect_success \
 	'creating a tag using a -F messagefile with #comments should succeed' '
-	git-tag -F commentsfile comments-annotated-tag &&
+	git tag -F commentsfile comments-annotated-tag &&
 	get_tag_msg comments-annotated-tag >actual &&
@@ -460,3 +460,3 @@ test_expect_success \
 	'creating a tag with a #comment in the -m message should succeed' '
-	git-tag -m "#comment" comment-annotated-tag &&
+	git tag -m "#comment" comment-annotated-tag &&
 	get_tag_msg comment-annotated-tag >actual &&
@@ -471,3 +471,3 @@ test_expect_success \
 	'creating a tag with #comments in the -F messagefile should succeed' '
-	git-tag -F commentfile commentfile-annotated-tag &&
+	git tag -F commentfile commentfile-annotated-tag &&
 	get_tag_msg commentfile-annotated-tag >actual &&
@@ -480,3 +480,3 @@ test_expect_success \
 	'creating a tag with a file of #comment and no newline should succeed' '
-	git-tag -F commentnonlfile commentnonlfile-annotated-tag &&
+	git tag -F commentnonlfile commentnonlfile-annotated-tag &&
 	get_tag_msg commentnonlfile-annotated-tag >actual &&
@@ -489,10 +489,10 @@ test_expect_success \
 	'listing the one-line message of a non-signed tag should succeed' '
-	git-tag -m "A msg" tag-one-line &&
+	git tag -m "A msg" tag-one-line &&
 
 	echo "tag-one-line" >expect &&
-	git-tag -l | grep "^tag-one-line" >actual &&
+	git tag -l | grep "^tag-one-line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l | grep "^tag-one-line" >actual &&
+	git tag -n0 -l | grep "^tag-one-line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l tag-one-line >actual &&
+	git tag -n0 -l tag-one-line >actual &&
 	test_cmp expect actual &&
@@ -500,11 +500,11 @@ test_expect_success \
 	echo "tag-one-line    A msg" >expect &&
-	git-tag -n1 -l | grep "^tag-one-line" >actual &&
+	git tag -n1 -l | grep "^tag-one-line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n -l | grep "^tag-one-line" >actual &&
+	git tag -n -l | grep "^tag-one-line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n1 -l tag-one-line >actual &&
+	git tag -n1 -l tag-one-line >actual &&
 	test_cmp expect actual &&
-	git-tag -n2 -l tag-one-line >actual &&
+	git tag -n2 -l tag-one-line >actual &&
 	test_cmp expect actual &&
-	git-tag -n999 -l tag-one-line >actual &&
+	git tag -n999 -l tag-one-line >actual &&
 	test_cmp expect actual
@@ -514,10 +514,10 @@ test_expect_success \
 	'listing the zero-lines message of a non-signed tag should succeed' '
-	git-tag -m "" tag-zero-lines &&
+	git tag -m "" tag-zero-lines &&
 
 	echo "tag-zero-lines" >expect &&
-	git-tag -l | grep "^tag-zero-lines" >actual &&
+	git tag -l | grep "^tag-zero-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l | grep "^tag-zero-lines" >actual &&
+	git tag -n0 -l | grep "^tag-zero-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l tag-zero-lines >actual &&
+	git tag -n0 -l tag-zero-lines >actual &&
 	test_cmp expect actual &&
@@ -525,11 +525,11 @@ test_expect_success \
 	echo "tag-zero-lines  " >expect &&
-	git-tag -n1 -l | grep "^tag-zero-lines" >actual &&
+	git tag -n1 -l | grep "^tag-zero-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n -l | grep "^tag-zero-lines" >actual &&
+	git tag -n -l | grep "^tag-zero-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n1 -l tag-zero-lines >actual &&
+	git tag -n1 -l tag-zero-lines >actual &&
 	test_cmp expect actual &&
-	git-tag -n2 -l tag-zero-lines >actual &&
+	git tag -n2 -l tag-zero-lines >actual &&
 	test_cmp expect actual &&
-	git-tag -n999 -l tag-zero-lines >actual &&
+	git tag -n999 -l tag-zero-lines >actual &&
 	test_cmp expect actual
@@ -542,10 +542,10 @@ test_expect_success \
 	'listing many message lines of a non-signed tag should succeed' '
-	git-tag -F annotagmsg tag-lines &&
+	git tag -F annotagmsg tag-lines &&
 
 	echo "tag-lines" >expect &&
-	git-tag -l | grep "^tag-lines" >actual &&
+	git tag -l | grep "^tag-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l | grep "^tag-lines" >actual &&
+	git tag -n0 -l | grep "^tag-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l tag-lines >actual &&
+	git tag -n0 -l tag-lines >actual &&
 	test_cmp expect actual &&
@@ -553,7 +553,7 @@ test_expect_success \
 	echo "tag-lines       tag line one" >expect &&
-	git-tag -n1 -l | grep "^tag-lines" >actual &&
+	git tag -n1 -l | grep "^tag-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n -l | grep "^tag-lines" >actual &&
+	git tag -n -l | grep "^tag-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n1 -l tag-lines >actual &&
+	git tag -n1 -l tag-lines >actual &&
 	test_cmp expect actual &&
@@ -561,5 +561,5 @@ test_expect_success \
 	echo "    tag line two" >>expect &&
-	git-tag -n2 -l | grep "^ *tag.line" >actual &&
+	git tag -n2 -l | grep "^ *tag.line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n2 -l tag-lines >actual &&
+	git tag -n2 -l tag-lines >actual &&
 	test_cmp expect actual &&
@@ -567,13 +567,13 @@ test_expect_success \
 	echo "    tag line three" >>expect &&
-	git-tag -n3 -l | grep "^ *tag.line" >actual &&
+	git tag -n3 -l | grep "^ *tag.line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n3 -l tag-lines >actual &&
+	git tag -n3 -l tag-lines >actual &&
 	test_cmp expect actual &&
-	git-tag -n4 -l | grep "^ *tag.line" >actual &&
+	git tag -n4 -l | grep "^ *tag.line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n4 -l tag-lines >actual &&
+	git tag -n4 -l tag-lines >actual &&
 	test_cmp expect actual &&
-	git-tag -n99 -l | grep "^ *tag.line" >actual &&
+	git tag -n99 -l | grep "^ *tag.line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n99 -l tag-lines >actual &&
+	git tag -n99 -l tag-lines >actual &&
 	test_cmp expect actual
@@ -594,3 +594,3 @@ test_expect_success \
 	tag_exists annotated-tag &&
-	test_must_fail git-tag -v annotated-tag
+	test_must_fail git tag -v annotated-tag
 '
@@ -600,3 +600,3 @@ test_expect_success \
 	tag_exists file-annotated-tag &&
-	test_must_fail git-tag -v file-annotated-tag
+	test_must_fail git tag -v file-annotated-tag
 '
@@ -606,3 +606,3 @@ test_expect_success \
 	tag_exists annotated-tag file-annotated-tag &&
-	test_must_fail git-tag -v annotated-tag file-annotated-tag
+	test_must_fail git tag -v annotated-tag file-annotated-tag
 '
@@ -636,3 +636,3 @@ echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success 'creating a signed tag with -m message should succeed' '
-	git-tag -s -m "A signed tag message" signed-tag &&
+	git tag -s -m "A signed tag message" signed-tag &&
 	get_tag_msg signed-tag >actual &&
@@ -677,3 +677,3 @@ echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success '-u implies signed tag' '
-	GIT_EDITOR=./fakeeditor git-tag -u CDDE430D implied-sign &&
+	GIT_EDITOR=./fakeeditor git tag -u CDDE430D implied-sign &&
 	get_tag_msg implied-sign >actual &&
@@ -691,3 +691,3 @@ test_expect_success \
 	'creating a signed tag with -F messagefile should succeed' '
-	git-tag -s -F sigmsgfile file-signed-tag &&
+	git tag -s -F sigmsgfile file-signed-tag &&
 	get_tag_msg file-signed-tag >actual &&
@@ -704,3 +704,3 @@ echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success 'creating a signed tag with -F - should succeed' '
-	git-tag -s -F - stdin-signed-tag <siginputmsg &&
+	git tag -s -F - stdin-signed-tag <siginputmsg &&
 	get_tag_msg stdin-signed-tag >actual &&
@@ -713,3 +713,3 @@ echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success '-s implies annotated tag' '
-	GIT_EDITOR=./fakeeditor git-tag -s implied-annotate &&
+	GIT_EDITOR=./fakeeditor git tag -s implied-annotate &&
 	get_tag_msg implied-annotate >actual &&
@@ -722,3 +722,3 @@ test_expect_success \
 	! tag_exists nosigtag &&
-	test_must_fail git-tag -s -F nonexistingfile nosigtag &&
+	test_must_fail git tag -s -F nonexistingfile nosigtag &&
 	! tag_exists nosigtag
@@ -727,6 +727,6 @@ test_expect_success \
 test_expect_success 'verifying a signed tag should succeed' \
-	'git-tag -v signed-tag'
+	'git tag -v signed-tag'
 
 test_expect_success 'verifying two signed tags in one command should succeed' \
-	'git-tag -v signed-tag file-signed-tag'
+	'git tag -v signed-tag file-signed-tag'
 
@@ -734,7 +734,7 @@ test_expect_success \
 	'verifying many signed and non-signed tags should fail' '
-	test_must_fail git-tag -v signed-tag annotated-tag &&
-	test_must_fail git-tag -v file-annotated-tag file-signed-tag &&
-	test_must_fail git-tag -v annotated-tag \
+	test_must_fail git tag -v signed-tag annotated-tag &&
+	test_must_fail git tag -v file-annotated-tag file-signed-tag &&
+	test_must_fail git tag -v annotated-tag \
 		file-signed-tag file-annotated-tag &&
-	test_must_fail git-tag -v signed-tag annotated-tag file-signed-tag
+	test_must_fail git tag -v signed-tag annotated-tag file-signed-tag
 '
@@ -746,3 +746,3 @@ test_expect_success 'verifying a forged tag should fail' '
 	git tag forged-tag $forged &&
-	test_must_fail git-tag -v forged-tag
+	test_must_fail git tag -v forged-tag
 '
@@ -755,6 +755,6 @@ test_expect_success \
 	'creating a signed tag with an empty -m message should succeed' '
-	git-tag -s -m "" empty-signed-tag &&
+	git tag -s -m "" empty-signed-tag &&
 	get_tag_msg empty-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v empty-signed-tag
+	git tag -v empty-signed-tag
 '
@@ -766,6 +766,6 @@ test_expect_success \
 	'creating a signed tag with an empty -F messagefile should succeed' '
-	git-tag -s -F sigemptyfile emptyfile-signed-tag &&
+	git tag -s -F sigemptyfile emptyfile-signed-tag &&
 	get_tag_msg emptyfile-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v emptyfile-signed-tag
+	git tag -v emptyfile-signed-tag
 '
@@ -789,6 +789,6 @@ test_expect_success \
 	'extra blanks in the message for a signed tag should be removed' '
-	git-tag -s -F sigblanksfile blanks-signed-tag &&
+	git tag -s -F sigblanksfile blanks-signed-tag &&
 	get_tag_msg blanks-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v blanks-signed-tag
+	git tag -v blanks-signed-tag
 '
@@ -799,6 +799,6 @@ test_expect_success \
 	'creating a signed tag with a blank -m message should succeed' '
-	git-tag -s -m "     " blank-signed-tag &&
+	git tag -s -m "     " blank-signed-tag &&
 	get_tag_msg blank-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v blank-signed-tag
+	git tag -v blank-signed-tag
 '
@@ -812,6 +812,6 @@ test_expect_success \
 	'creating a signed tag with blank -F file with spaces should succeed' '
-	git-tag -s -F sigblankfile blankfile-signed-tag &&
+	git tag -s -F sigblankfile blankfile-signed-tag &&
 	get_tag_msg blankfile-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v blankfile-signed-tag
+	git tag -v blankfile-signed-tag
 '
@@ -823,6 +823,6 @@ test_expect_success \
 	'creating a signed tag with spaces and no newline should succeed' '
-	git-tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
+	git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
 	get_tag_msg blanknonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v signed-tag
+	git tag -v signed-tag
 '
@@ -860,6 +860,6 @@ test_expect_success \
 	'creating a signed tag with a -F file with #comments should succeed' '
-	git-tag -s -F sigcommentsfile comments-signed-tag &&
+	git tag -s -F sigcommentsfile comments-signed-tag &&
 	get_tag_msg comments-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v comments-signed-tag
+	git tag -v comments-signed-tag
 '
@@ -870,6 +870,6 @@ test_expect_success \
 	'creating a signed tag with #commented -m message should succeed' '
-	git-tag -s -m "#comment" comment-signed-tag &&
+	git tag -s -m "#comment" comment-signed-tag &&
 	get_tag_msg comment-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v comment-signed-tag
+	git tag -v comment-signed-tag
 '
@@ -883,6 +883,6 @@ test_expect_success \
 	'creating a signed tag with #commented -F messagefile should succeed' '
-	git-tag -s -F sigcommentfile commentfile-signed-tag &&
+	git tag -s -F sigcommentfile commentfile-signed-tag &&
 	get_tag_msg commentfile-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v commentfile-signed-tag
+	git tag -v commentfile-signed-tag
 '
@@ -894,6 +894,6 @@ test_expect_success \
 	'creating a signed tag with a #comment and no newline should succeed' '
-	git-tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
+	git tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
 	get_tag_msg commentnonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
-	git-tag -v commentnonlfile-signed-tag
+	git tag -v commentnonlfile-signed-tag
 '
@@ -904,10 +904,10 @@ test_expect_success \
 	'listing the one-line message of a signed tag should succeed' '
-	git-tag -s -m "A message line signed" stag-one-line &&
+	git tag -s -m "A message line signed" stag-one-line &&
 
 	echo "stag-one-line" >expect &&
-	git-tag -l | grep "^stag-one-line" >actual &&
+	git tag -l | grep "^stag-one-line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l | grep "^stag-one-line" >actual &&
+	git tag -n0 -l | grep "^stag-one-line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l stag-one-line >actual &&
+	git tag -n0 -l stag-one-line >actual &&
 	test_cmp expect actual &&
@@ -915,11 +915,11 @@ test_expect_success \
 	echo "stag-one-line   A message line signed" >expect &&
-	git-tag -n1 -l | grep "^stag-one-line" >actual &&
+	git tag -n1 -l | grep "^stag-one-line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n -l | grep "^stag-one-line" >actual &&
+	git tag -n -l | grep "^stag-one-line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n1 -l stag-one-line >actual &&
+	git tag -n1 -l stag-one-line >actual &&
 	test_cmp expect actual &&
-	git-tag -n2 -l stag-one-line >actual &&
+	git tag -n2 -l stag-one-line >actual &&
 	test_cmp expect actual &&
-	git-tag -n999 -l stag-one-line >actual &&
+	git tag -n999 -l stag-one-line >actual &&
 	test_cmp expect actual
@@ -929,10 +929,10 @@ test_expect_success \
 	'listing the zero-lines message of a signed tag should succeed' '
-	git-tag -s -m "" stag-zero-lines &&
+	git tag -s -m "" stag-zero-lines &&
 
 	echo "stag-zero-lines" >expect &&
-	git-tag -l | grep "^stag-zero-lines" >actual &&
+	git tag -l | grep "^stag-zero-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l | grep "^stag-zero-lines" >actual &&
+	git tag -n0 -l | grep "^stag-zero-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l stag-zero-lines >actual &&
+	git tag -n0 -l stag-zero-lines >actual &&
 	test_cmp expect actual &&
@@ -940,11 +940,11 @@ test_expect_success \
 	echo "stag-zero-lines " >expect &&
-	git-tag -n1 -l | grep "^stag-zero-lines" >actual &&
+	git tag -n1 -l | grep "^stag-zero-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n -l | grep "^stag-zero-lines" >actual &&
+	git tag -n -l | grep "^stag-zero-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n1 -l stag-zero-lines >actual &&
+	git tag -n1 -l stag-zero-lines >actual &&
 	test_cmp expect actual &&
-	git-tag -n2 -l stag-zero-lines >actual &&
+	git tag -n2 -l stag-zero-lines >actual &&
 	test_cmp expect actual &&
-	git-tag -n999 -l stag-zero-lines >actual &&
+	git tag -n999 -l stag-zero-lines >actual &&
 	test_cmp expect actual
@@ -957,10 +957,10 @@ test_expect_success \
 	'listing many message lines of a signed tag should succeed' '
-	git-tag -s -F sigtagmsg stag-lines &&
+	git tag -s -F sigtagmsg stag-lines &&
 
 	echo "stag-lines" >expect &&
-	git-tag -l | grep "^stag-lines" >actual &&
+	git tag -l | grep "^stag-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l | grep "^stag-lines" >actual &&
+	git tag -n0 -l | grep "^stag-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n0 -l stag-lines >actual &&
+	git tag -n0 -l stag-lines >actual &&
 	test_cmp expect actual &&
@@ -968,7 +968,7 @@ test_expect_success \
 	echo "stag-lines      stag line one" >expect &&
-	git-tag -n1 -l | grep "^stag-lines" >actual &&
+	git tag -n1 -l | grep "^stag-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n -l | grep "^stag-lines" >actual &&
+	git tag -n -l | grep "^stag-lines" >actual &&
 	test_cmp expect actual &&
-	git-tag -n1 -l stag-lines >actual &&
+	git tag -n1 -l stag-lines >actual &&
 	test_cmp expect actual &&
@@ -976,5 +976,5 @@ test_expect_success \
 	echo "    stag line two" >>expect &&
-	git-tag -n2 -l | grep "^ *stag.line" >actual &&
+	git tag -n2 -l | grep "^ *stag.line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n2 -l stag-lines >actual &&
+	git tag -n2 -l stag-lines >actual &&
 	test_cmp expect actual &&
@@ -982,13 +982,13 @@ test_expect_success \
 	echo "    stag line three" >>expect &&
-	git-tag -n3 -l | grep "^ *stag.line" >actual &&
+	git tag -n3 -l | grep "^ *stag.line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n3 -l stag-lines >actual &&
+	git tag -n3 -l stag-lines >actual &&
 	test_cmp expect actual &&
-	git-tag -n4 -l | grep "^ *stag.line" >actual &&
+	git tag -n4 -l | grep "^ *stag.line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n4 -l stag-lines >actual &&
+	git tag -n4 -l stag-lines >actual &&
 	test_cmp expect actual &&
-	git-tag -n99 -l | grep "^ *stag.line" >actual &&
+	git tag -n99 -l | grep "^ *stag.line" >actual &&
 	test_cmp expect actual &&
-	git-tag -n99 -l stag-lines >actual &&
+	git tag -n99 -l stag-lines >actual &&
 	test_cmp expect actual
@@ -1007,3 +1007,3 @@ test_expect_success \
 	'creating a signed tag pointing to a tree should succeed' '
-	git-tag -s -m "A message for a tree" tree-signed-tag HEAD^{tree} &&
+	git tag -s -m "A message for a tree" tree-signed-tag HEAD^{tree} &&
 	get_tag_msg tree-signed-tag >actual &&
@@ -1017,3 +1017,3 @@ test_expect_success \
 	'creating a signed tag pointing to a blob should succeed' '
-	git-tag -s -m "A message for a blob" blob-signed-tag HEAD:foo &&
+	git tag -s -m "A message for a blob" blob-signed-tag HEAD:foo &&
 	get_tag_msg blob-signed-tag >actual &&
@@ -1027,3 +1027,3 @@ test_expect_success \
 	'creating a signed tag pointing to another tag should succeed' '
-	git-tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
+	git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
 	get_tag_msg tag-signed-tag >actual &&
@@ -1035,3 +1035,3 @@ git config user.signingkey BobTheMouse
 test_expect_success \
-	'git-tag -s fails if gpg is misconfigured' \
+	'git tag -s fails if gpg is misconfigured' \
 	'test_must_fail git tag -s -m tail tag-gpg-failure'
@@ -1044,6 +1044,6 @@ test_expect_success \
 	'verify signed tag fails when public key is not present' \
-	'test_must_fail git-tag -v signed-tag'
+	'test_must_fail git tag -v signed-tag'
 
 test_expect_success \
-	'git-tag -a fails if tag annotation is empty' '
+	'git tag -a fails if tag annotation is empty' '
 	! (GIT_EDITOR=cat git tag -a initial-comment)
diff --git a/t/t7101-reset.sh b/t/t7101-reset.sh
index ffaeb39..96e163f 100755
--- a/t/t7101-reset.sh
+++ b/t/t7101-reset.sh
@@ -5,3 +5,3 @@
 
-test_description='git-reset should cull empty subdirs'
+test_description='git reset should cull empty subdirs'
 . ./test-lib.sh
@@ -13,3 +13,3 @@ test_expect_success \
      git add path0/COPYING &&
-     git-commit -m add -a'
+     git commit -m add -a'
 
@@ -27,3 +27,3 @@ test_expect_success \
      git add path0/COPYING-TOO &&
-     git-commit -m change -a'
+     git commit -m change -a'
 
@@ -31,3 +31,3 @@ test_expect_success \
     'resetting tree HEAD^' \
-    'git-reset --hard HEAD^'
+    'git reset --hard HEAD^'
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 29f5678..e637c7d 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -5,5 +5,5 @@
 
-test_description='git-reset
+test_description='git reset
 
-Documented tests for git-reset'
+Documented tests for git reset'
 
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index cdecebe..42bf518 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -2,3 +2,3 @@
 
-test_description='git-reset in a bare repository'
+test_description='git reset in a bare repository'
 . ./test-lib.sh
-- 
1.6.0.1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
