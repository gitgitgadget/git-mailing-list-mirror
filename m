From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] t1005: reindent
Date: Fri,  1 Nov 2013 15:44:54 -0700
Message-ID: <1383345895-23341-3-git-send-email-gitster@pobox.com>
References: <20131031172116.GA19428@sigill.intra.peff.net>
 <1383345895-23341-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 23:45:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcNSx-0002E7-8d
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 23:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab3KAWpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 18:45:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868Ab3KAWpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 18:45:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7A7E4D12F;
	Fri,  1 Nov 2013 18:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=L3vW
	RotF8A8vSfocTCrRgJG6aQ8=; b=F4QdHeUh2KImrdlPWe1lZYXwzeprN7XND6PZ
	omM8JvI8H7anz4gBtShO/Oj4AWKuO5wU2n6OHtAMNt06CBwTHI0owJVUHGOt+vA/
	RS8oIFpSLN/bToxvFiLVoJDUsKvBwOOAosdYztXqdcLw6DKLyUsDHvwdwbV1WgzR
	SyCUpOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	OIP9pYz0OZlmPpCZpU064Z2nuVZ7juOE8+rB+sUlVwfdPdNZyYB49eCuUNlLu5/f
	P4DSQcwiOCRokKiWfw7U+/0PtwlTyzSHM+N1lRhwePenc3819+C8NqnzeSxR+FhK
	GXbnhYEBO2MQO/gp9V5RI2gy1Uwm2+VyiHCstiJyNPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7D2E4D12E;
	Fri,  1 Nov 2013 18:45:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29DA34D12D;
	Fri,  1 Nov 2013 18:45:05 -0400 (EDT)
X-Mailer: git-send-email 1.8.5-rc0-281-g8951339
In-Reply-To: <1383345895-23341-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 404D39B0-4347-11E3-B0BC-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237226>

Just to update the style of this ancient test script to match
our house style.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-read-tree.sh         |  52 +++++++++----------
 t/t1005-read-tree-reset.sh | 126 ++++++++++++++++++++++-----------------------
 2 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/t/lib-read-tree.sh b/t/lib-read-tree.sh
index abc2c6f..ef079af 100644
--- a/t/lib-read-tree.sh
+++ b/t/lib-read-tree.sh
@@ -5,39 +5,39 @@
 # write the index and that together with -u it doesn't touch the work tree.
 #
 read_tree_must_succeed () {
-    git ls-files -s >pre-dry-run &&
-    git read-tree -n "$@" &&
-    git ls-files -s >post-dry-run &&
-    test_cmp pre-dry-run post-dry-run &&
-    git read-tree "$@"
+	git ls-files -s >pre-dry-run &&
+	git read-tree -n "$@" &&
+	git ls-files -s >post-dry-run &&
+	test_cmp pre-dry-run post-dry-run &&
+	git read-tree "$@"
 }
 
 read_tree_must_fail () {
-    git ls-files -s >pre-dry-run &&
-    test_must_fail git read-tree -n "$@" &&
-    git ls-files -s >post-dry-run &&
-    test_cmp pre-dry-run post-dry-run &&
-    test_must_fail git read-tree "$@"
+	git ls-files -s >pre-dry-run &&
+	test_must_fail git read-tree -n "$@" &&
+	git ls-files -s >post-dry-run &&
+	test_cmp pre-dry-run post-dry-run &&
+	test_must_fail git read-tree "$@"
 }
 
 read_tree_u_must_succeed () {
-    git ls-files -s >pre-dry-run &&
-    git diff-files -p >pre-dry-run-wt &&
-    git read-tree -n "$@" &&
-    git ls-files -s >post-dry-run &&
-    git diff-files -p >post-dry-run-wt &&
-    test_cmp pre-dry-run post-dry-run &&
-    test_cmp pre-dry-run-wt post-dry-run-wt &&
-    git read-tree "$@"
+	git ls-files -s >pre-dry-run &&
+	git diff-files -p >pre-dry-run-wt &&
+	git read-tree -n "$@" &&
+	git ls-files -s >post-dry-run &&
+	git diff-files -p >post-dry-run-wt &&
+	test_cmp pre-dry-run post-dry-run &&
+	test_cmp pre-dry-run-wt post-dry-run-wt &&
+	git read-tree "$@"
 }
 
 read_tree_u_must_fail () {
-    git ls-files -s >pre-dry-run &&
-    git diff-files -p >pre-dry-run-wt &&
-    test_must_fail git read-tree -n "$@" &&
-    git ls-files -s >post-dry-run &&
-    git diff-files -p >post-dry-run-wt &&
-    test_cmp pre-dry-run post-dry-run &&
-    test_cmp pre-dry-run-wt post-dry-run-wt &&
-    test_must_fail git read-tree "$@"
+	git ls-files -s >pre-dry-run &&
+	git diff-files -p >pre-dry-run-wt &&
+	test_must_fail git read-tree -n "$@" &&
+	git ls-files -s >post-dry-run &&
+	git diff-files -p >post-dry-run-wt &&
+	test_cmp pre-dry-run post-dry-run &&
+	test_cmp pre-dry-run-wt post-dry-run-wt &&
+	test_must_fail git read-tree "$@"
 }
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index f53de79..e29cf63 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -8,84 +8,84 @@ test_description='read-tree -u --reset'
 # two-tree test
 
 test_expect_success 'setup' '
-  git init &&
-  mkdir df &&
-  echo content >df/file &&
-  git add df/file &&
-  git commit -m one &&
-  git ls-files >expect &&
-  rm -rf df &&
-  echo content >df &&
-  git add df &&
-  echo content >new &&
-  git add new &&
-  git commit -m two
+	git init &&
+	mkdir df &&
+	echo content >df/file &&
+	git add df/file &&
+	git commit -m one &&
+	git ls-files >expect &&
+	rm -rf df &&
+	echo content >df &&
+	git add df &&
+	echo content >new &&
+	git add new &&
+	git commit -m two
 '
 
 test_expect_success 'reset should work' '
-  read_tree_u_must_succeed -u --reset HEAD^ &&
-  git ls-files >actual &&
-  test_cmp expect actual
+	read_tree_u_must_succeed -u --reset HEAD^ &&
+	git ls-files >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'reset should remove remnants from a failed merge' '
-  read_tree_u_must_succeed --reset -u HEAD &&
-  git ls-files -s >expect &&
-  sha1=$(git rev-parse :new) &&
-  (
-	echo "100644 $sha1 1	old"
-	echo "100644 $sha1 3	old"
-  ) | git update-index --index-info &&
-  >old &&
-  git ls-files -s &&
-  read_tree_u_must_succeed --reset -u HEAD &&
-  git ls-files -s >actual &&
-  ! test -f old
+	read_tree_u_must_succeed --reset -u HEAD &&
+	git ls-files -s >expect &&
+	sha1=$(git rev-parse :new) &&
+	(
+		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 3	old"
+	) | git update-index --index-info &&
+	>old &&
+	git ls-files -s &&
+	read_tree_u_must_succeed --reset -u HEAD &&
+	git ls-files -s >actual &&
+	! test -f old
 '
 
 test_expect_success 'Porcelain reset should remove remnants too' '
-  read_tree_u_must_succeed --reset -u HEAD &&
-  git ls-files -s >expect &&
-  sha1=$(git rev-parse :new) &&
-  (
-	echo "100644 $sha1 1	old"
-	echo "100644 $sha1 3	old"
-  ) | git update-index --index-info &&
-  >old &&
-  git ls-files -s &&
-  git reset --hard &&
-  git ls-files -s >actual &&
-  ! test -f old
+	read_tree_u_must_succeed --reset -u HEAD &&
+	git ls-files -s >expect &&
+	sha1=$(git rev-parse :new) &&
+	(
+		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 3	old"
+	) | git update-index --index-info &&
+	>old &&
+	git ls-files -s &&
+	git reset --hard &&
+	git ls-files -s >actual &&
+	! test -f old
 '
 
 test_expect_success 'Porcelain checkout -f should remove remnants too' '
-  read_tree_u_must_succeed --reset -u HEAD &&
-  git ls-files -s >expect &&
-  sha1=$(git rev-parse :new) &&
-  (
-	echo "100644 $sha1 1	old"
-	echo "100644 $sha1 3	old"
-  ) | git update-index --index-info &&
-  >old &&
-  git ls-files -s &&
-  git checkout -f &&
-  git ls-files -s >actual &&
-  ! test -f old
+	read_tree_u_must_succeed --reset -u HEAD &&
+	git ls-files -s >expect &&
+	sha1=$(git rev-parse :new) &&
+	(
+		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 3	old"
+	) | git update-index --index-info &&
+	>old &&
+	git ls-files -s &&
+	git checkout -f &&
+	git ls-files -s >actual &&
+	! test -f old
 '
 
 test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
-  read_tree_u_must_succeed --reset -u HEAD &&
-  git ls-files -s >expect &&
-  sha1=$(git rev-parse :new) &&
-  (
-	echo "100644 $sha1 1	old"
-	echo "100644 $sha1 3	old"
-  ) | git update-index --index-info &&
-  >old &&
-  git ls-files -s &&
-  git checkout -f HEAD &&
-  git ls-files -s >actual &&
-  ! test -f old
+	read_tree_u_must_succeed --reset -u HEAD &&
+	git ls-files -s >expect &&
+	sha1=$(git rev-parse :new) &&
+	(
+		echo "100644 $sha1 1	old"
+		echo "100644 $sha1 3	old"
+	) | git update-index --index-info &&
+	>old &&
+	git ls-files -s &&
+	git checkout -f HEAD &&
+	git ls-files -s >actual &&
+	! test -f old
 '
 
 test_done
-- 
1.8.5-rc0-281-g8951339
