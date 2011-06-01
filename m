From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 3/3] Fix typo: existant->existent
Date: Thu,  2 Jun 2011 04:27:58 +0600
Message-ID: <1306967278-1971-3-git-send-email-divanorama@gmail.com>
References: <1306967278-1971-1-git-send-email-divanorama@gmail.com>
Cc: Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 00:28:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRttg-00039t-NQ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667Ab1FAW2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:28:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62533 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab1FAW2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:28:11 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so448770bwz.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=IUUqP4to4Tm/a6wT2Jx5hQx6GtfTiEykH5KVrPJMMrs=;
        b=atf8qvIgXwfubpJsPxFRcaM5a+OFh0h7B6/YA7MCy6kZAjRKl0JYfZGDcigs0yeoYH
         TSs9K3u98T2LlWj2mDxNz4kspx1V5/BvNQzFbzBAtC3UtXALEI1vKJY/y6YHU1PXWpdG
         LsuDWypTNMvFGnjDgroUOBqI7AihiEN4VVhX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ffpPz05y25cYNDwkIkSvKCTlL5mtT8wPTy4C/UcdTQJNutlLh+79Hg1t0ogO5hyn32
         c5DgF6mos/ddG6mcHXVeezvJG1VPoC4x0aSgBIIWGOA45Xo//M6kRkpWxfgRruZ3eAGq
         xMAAPHE+0vKt5wqy+DKLSVHqFmdNzm/9Ixu84=
Received: by 10.204.41.206 with SMTP id p14mr28819bke.53.1306967291158;
        Wed, 01 Jun 2011 15:28:11 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm5071bkc.19.2011.06.01.15.28.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 15:28:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1306967278-1971-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174909>

Fix this typo in tests internals.
They still pass.
---
 t/t3903-stash.sh              |    2 +-
 t/t4203-mailmap.sh            |    2 +-
 t/t4205-log-pretty-formats.sh |    2 +-
 t/t5506-remote-groups.sh      |    6 +++---
 t/t5516-fetch-push.sh         |   10 +++++-----
 t/t9300-fast-import.sh        |    4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5c72540..7197aae 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -536,7 +536,7 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
 	git reset --hard HEAD
 '
 
-test_expect_success 'ref with non-existant reflog' '
+test_expect_success 'ref with non-existent reflog' '
 	git stash clear &&
 	echo bar5 > file &&
 	echo bar6 > file2 &&
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index e818de6..1f182f6 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -94,7 +94,7 @@ nick1 (1):
 
 EOF
 
-test_expect_success 'mailmap.file non-existant' '
+test_expect_success 'mailmap.file non-existent' '
 	rm internal_mailmap/.mailmap &&
 	rmdir internal_mailmap &&
 	git shortlog HEAD >actual &&
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index cb9f2bd..2ae9faa 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -45,7 +45,7 @@ test_expect_success 'alias user-defined tformat' '
 	test_cmp expected actual
 '
 
-test_expect_success 'alias non-existant format' '
+test_expect_success 'alias non-existent format' '
 	git config pretty.test-alias format-that-will-never-exist &&
 	test_must_fail git log --pretty=test-alias
 '
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index b7b7dda..530b016 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -43,10 +43,10 @@ test_expect_success 'no group updates all' '
 	repo_fetched two
 '
 
-test_expect_success 'nonexistant group produces error' '
-	mark nonexistant &&
+test_expect_success 'nonexistent group produces error' '
+	mark nonexistent &&
 	update_repos &&
-	test_must_fail git remote update nonexistant &&
+	test_must_fail git remote update nonexistent &&
 	! repo_fetched one &&
 	! repo_fetched two
 '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index d73731e..3abb290 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -367,7 +367,7 @@ test_expect_success 'push with colon-less refspec (4)' '
 
 '
 
-test_expect_success 'push head with non-existant, incomplete dest' '
+test_expect_success 'push head with non-existent, incomplete dest' '
 
 	mk_test &&
 	git push testrepo master:branch &&
@@ -375,7 +375,7 @@ test_expect_success 'push head with non-existant, incomplete dest' '
 
 '
 
-test_expect_success 'push tag with non-existant, incomplete dest' '
+test_expect_success 'push tag with non-existent, incomplete dest' '
 
 	mk_test &&
 	git tag -f v1.0 &&
@@ -384,14 +384,14 @@ test_expect_success 'push tag with non-existant, incomplete dest' '
 
 '
 
-test_expect_success 'push sha1 with non-existant, incomplete dest' '
+test_expect_success 'push sha1 with non-existent, incomplete dest' '
 
 	mk_test &&
 	test_must_fail git push testrepo `git rev-parse master`:foo
 
 '
 
-test_expect_success 'push ref expression with non-existant, incomplete dest' '
+test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 	mk_test &&
 	test_must_fail git push testrepo master^:branch
@@ -436,7 +436,7 @@ test_expect_success 'push with +HEAD' '
 
 '
 
-test_expect_success 'push HEAD with non-existant, incomplete dest' '
+test_expect_success 'push HEAD with non-existent, incomplete dest' '
 
 	mk_test &&
 	git checkout master &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6b1ba6c..2a53640 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1893,7 +1893,7 @@ test_expect_success \
     test_cmp marks.out marks.new'
 
 cat >input <<EOF
-feature import-marks=nonexistant.marks
+feature import-marks=nonexistent.marks
 feature export-marks=marks.new
 EOF
 
@@ -1904,7 +1904,7 @@ test_expect_success \
 
 
 cat >input <<EOF
-feature import-marks=nonexistant.marks
+feature import-marks=nonexistent.marks
 feature export-marks=combined.marks
 EOF
 
-- 
1.7.3.4
