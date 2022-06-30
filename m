Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE6C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 06:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiF3GAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiF3GAC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 02:00:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0480235A80
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:00:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n185so10619538wmn.4
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NwH8jWbNxa+zcrDPPse9zZEdHE/1xpqSZ2nE8jkoyjU=;
        b=FxGO0f124jpC6fqfZ6h0iGOcanFH4hKzSxOcsLMmFvEkP1pQuRiw6AsPWY9gb+S2B8
         +y8Ubl7vZ8us6w1ZdvuPr/ZxNYGuz7zzx2a/wsE1ywurCP20ak8ohd2L9Qdc6BmmDwrV
         JOhNmMFNJ7GOhDGurvaWHQZSVX4K5g5EQ1yiXcfrFunhOahZ/mDRvFvc1528O4dM1ind
         BCB/XKjyrxEwrzpi0gapeJUmT2imO527k/NR4sJ8qAWqXpWXzKOSkokam5w9cEXxrd8D
         fovYYvQ1os3jRW1pnu/CYF8AONq6chwrqWejR4j+3rs0/dHAFOtPwlwVQxbj/Jk4xYIe
         Rmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NwH8jWbNxa+zcrDPPse9zZEdHE/1xpqSZ2nE8jkoyjU=;
        b=E9Rxn5u5EN39d8HyeYeVEiFfUl4wBtjJUcAGUtwwcplgOfDDh+AZdFC0HBpJdcRZLS
         ajCqKTs9klzCGxM5SMdKWBci4+k5f6L41MWl6U9h6Lohi+p6V5gXZSAPXAU6cOyZBe2T
         IlaPu3rwAsFJ08AT9sydNahS+IA1N02aAJtdrSCRLazi15Ih0sbH4NgFyOGYy1WE4ue6
         G76Chf+BfB5UfPHwjFYSMsQuXMa10kww5tGozuYZSA7HTdLNv88ccztYZDjTh7LAWf5u
         aopn4Rs/KYUgOO/vT7nI4tvKcil7pNKRV7iGSAYu5H+L4deIh/TeSddr2/qgIagbdHuW
         yUTA==
X-Gm-Message-State: AJIora+KL9OAo2ludna7xvaEmfw0wFvXr65MkMIfsfMRCP1T3AHKaYiQ
        BEgIWLbTfDXFGHzS2yguOHZ4WhiszCptxg==
X-Google-Smtp-Source: AGRyM1vsuBqrhAvY83b9ZkP8m7yiy7ki7jc7dpB+TTKH3JnJngcz+g6zD0kAWbLOvXLxusmbEuVYtg==
X-Received: by 2002:a05:600c:3ac3:b0:3a0:45b6:7efb with SMTP id d3-20020a05600c3ac300b003a045b67efbmr9604014wms.183.1656568799038;
        Wed, 29 Jun 2022 22:59:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm5225784wmj.35.2022.06.29.22.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 22:59:58 -0700 (PDT)
Message-Id: <pull.1269.v4.git.1656568797328.gitgitgadget@gmail.com>
In-Reply-To: <pull.1269.v3.git.1656409884091.gitgitgadget@gmail.com>
References: <pull.1269.v3.git.1656409884091.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 05:59:57 +0000
Subject: [PATCH v4] ls-files: update test style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Li Linchao <lilinchao@oschina.cn>,
        Li Linchao <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Li Linchao <lilinchao@oschina.cn>

Update test style in t/t30[*].sh for uniformity, that's to
keep test title the same line with helper function itself,
and fix some indentions.

Add a new section "recommended style" in t/README to
encourage people to use more modern style in test.

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
    ls-files: update test style
    
    Update test style in t/t30[*].sh for uniformity, that's to keep test
    title the same line with helper function itself.
    
    And update t/README to describe this test style.
    
    Signed-off-by: Li Linchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1269%2FCactusinhand%2Fllc%2Ffix-test-title-style-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1269/Cactusinhand/llc/fix-test-title-style-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1269

Range-diff vs v3:

 1:  b3d80bd9cd5 ! 1:  d0ee9836f23 ls-files: update test style
     @@ t/README: This test harness library does the following things:
      +   Take test_expect_success helper for example, write it like:
      +
      +  test_expect_success 'test title' '
     -+  ... test body ...
     ++      ... test body ...
      +  '
      +
      +   Instead of:
      +
      +  test_expect_success \
     -+  'test title' \
     -+  '... test body ...'
     ++      'test title' \
     ++      '... test body ...'
      +
      +
      + - End the line with a single quote.
      +
     -+ - Indent the body of here-document, and use "<< -" instead of "<<" to strip prefix TAB:
     ++ - Indent the body of here-document, and use "<<-" instead of "<<"
     ++   to strip leading TABs used for indentation:
      +
      +  test_expect_success 'test something' '
      +      cat >expect <<-\EOF &&


 t/README                           | 47 ++++++++++++++++
 t/t3001-ls-files-others-exclude.sh | 42 +++++++--------
 t/t3002-ls-files-dashpath.sh       | 86 ++++++++++++++++--------------
 t/t3020-ls-files-error-unmatch.sh  | 12 ++---
 t/t3060-ls-files-with-tree.sh      |  8 +--
 5 files changed, 124 insertions(+), 71 deletions(-)

diff --git a/t/README b/t/README
index 309a31133c6..f662471338d 100644
--- a/t/README
+++ b/t/README
@@ -547,6 +547,53 @@ This test harness library does the following things:
    consistently when command line arguments --verbose (or -v),
    --debug (or -d), and --immediate (or -i) is given.
 
+Recommended style
+-----------------
+Here are some recommented styles when writing test case.
+
+ - Keep test title the same line with test helper function itself.
+
+   Take test_expect_success helper for example, write it like:
+
+  test_expect_success 'test title' '
+      ... test body ...
+  '
+
+   Instead of:
+
+  test_expect_success \
+      'test title' \
+      '... test body ...'
+
+
+ - End the line with a single quote.
+
+ - Indent the body of here-document, and use "<<-" instead of "<<"
+   to strip leading TABs used for indentation:
+
+  test_expect_success 'test something' '
+      cat >expect <<-\EOF &&
+      one
+      two
+      three
+      EOF
+      test_something > actual &&
+      test_cmp expect actual
+  '
+
+   Instead of:
+
+  test_expect_success 'test something' '
+      cat >expect <<\EOF &&
+  one
+  two
+  three
+  EOF
+      test_something > actual &&
+      test_cmp expect actual
+  '
+
+
 Do's & don'ts
 -------------
 
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 48cec4e5f88..e07ac6c6dce 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -67,26 +67,26 @@ echo '!*.2
 
 allignores='.gitignore one/.gitignore one/two/.gitignore'
 
-test_expect_success \
-    'git ls-files --others with various exclude options.' \
-    'git ls-files --others \
+test_expect_success 'git ls-files --others with various exclude options.' '
+	git ls-files --others \
        --exclude=\*.6 \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
-       >output &&
-     test_cmp expect output'
+	>output &&
+	test_cmp expect output
+'
 
 # Test \r\n (MSDOS-like systems)
 printf '*.1\r\n/*.3\r\n!*.6\r\n' >.gitignore
 
-test_expect_success \
-    'git ls-files --others with \r\n line endings.' \
-    'git ls-files --others \
+test_expect_success 'git ls-files --others with \r\n line endings.' '
+	git ls-files --others \
        --exclude=\*.6 \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
-       >output &&
-     test_cmp expect output'
+	>output &&
+	test_cmp expect output
+'
 
 test_expect_success 'setup skip-worktree gitignore' '
 	git add $allignores &&
@@ -94,14 +94,14 @@ test_expect_success 'setup skip-worktree gitignore' '
 	rm $allignores
 '
 
-test_expect_success \
-    'git ls-files --others with various exclude options.' \
-    'git ls-files --others \
+test_expect_success 'git ls-files --others with various exclude options.' '
+	git ls-files --others \
        --exclude=\*.6 \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
-       >output &&
-     test_cmp expect output'
+	>output &&
+	test_cmp expect output
+'
 
 test_expect_success !SANITIZE_LEAK 'restore gitignore' '
 	git checkout --ignore-skip-worktree-bits $allignores &&
@@ -283,12 +283,12 @@ test_expect_success 'pattern matches prefix completely' '
 '
 
 test_expect_success 'ls-files with "**" patterns' '
-	cat <<\EOF >expect &&
-a.1
-one/a.1
-one/two/a.1
-three/a.1
-EOF
+	cat <<-\EOF >expect &&
+	a.1
+	one/a.1
+	one/two/a.1
+	three/a.1
+	EOF
 	git ls-files -o -i --exclude "**/a.1" >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index 54d22a45dfb..4dd24550eba 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -16,56 +16,62 @@ filesystem.
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success \
-	setup \
-	'echo frotz >path0 &&
+test_expect_success 'setup' '
+	echo frotz >path0 &&
 	echo frotz >./-foo &&
-	echo frotz >./--'
+	echo frotz >./--
+'
 
-test_expect_success \
-    'git ls-files without path restriction.' \
-    'git ls-files --others >output &&
-     test_cmp output - <<EOF
---
--foo
-output
-path0
-EOF
+test_expect_success 'git ls-files without path restriction.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others >output &&
+	cat >expect <<-\EOF &&
+	--
+	-foo
+	output
+	path0
+	EOF
+	test_cmp output expect
 '
 
-test_expect_success \
-    'git ls-files with path restriction.' \
-    'git ls-files --others path0 >output &&
-	test_cmp output - <<EOF
-path0
-EOF
+test_expect_success 'git ls-files with path restriction.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others path0 >output &&
+	cat >expect <<-\EOF &&
+	path0
+	EOF
+	test_cmp output expect
 '
 
-test_expect_success \
-    'git ls-files with path restriction with --.' \
-    'git ls-files --others -- path0 >output &&
-	test_cmp output - <<EOF
-path0
-EOF
+test_expect_success 'git ls-files with path restriction with --.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others -- path0 >output &&
+	cat >expect <<-\EOF &&
+	path0
+	EOF
+	test_cmp output expect
 '
 
-test_expect_success \
-    'git ls-files with path restriction with -- --.' \
-    'git ls-files --others -- -- >output &&
-	test_cmp output - <<EOF
---
-EOF
+test_expect_success 'git ls-files with path restriction with -- --.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others -- -- >output &&
+	cat >expect <<-\EOF &&
+	--
+	EOF
+	test_cmp output expect
 '
 
-test_expect_success \
-    'git ls-files with no path restriction.' \
-    'git ls-files --others -- >output &&
-	test_cmp output - <<EOF
---
--foo
-output
-path0
-EOF
+test_expect_success 'git ls-files with no path restriction.' '
+	test_when_finished "rm -f expect" &&
+	git ls-files --others -- >output &&
+	cat >expect <<-\EOF &&
+	--
+	-foo
+	output
+	path0
+	EOF
+	test_cmp output expect
+
 '
 
 test_done
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index 2cbcbc0721b..133593d23c0 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -19,12 +19,12 @@ test_expect_success 'setup' '
 	git commit -m "add foo bar"
 '
 
-test_expect_success \
-    'git ls-files --error-unmatch should fail with unmatched path.' \
-    'test_must_fail git ls-files --error-unmatch foo bar-does-not-match'
+test_expect_success 'git ls-files --error-unmatch should fail with unmatched path.' '
+	test_must_fail git ls-files --error-unmatch foo bar-does-not-match
+'
 
-test_expect_success \
-    'git ls-files --error-unmatch should succeed with matched paths.' \
-    'git ls-files --error-unmatch foo bar'
+test_expect_success 'git ls-files --error-unmatch should succeed with matched paths.' '
+	git ls-files --error-unmatch foo bar
+'
 
 test_done
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index b257c792a46..52f76f7b57f 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -10,7 +10,7 @@ a scenario known to trigger a crash with some versions of git.
 '
 . ./test-lib.sh
 
-test_expect_success setup '
+test_expect_success 'setup' '
 
 	# The bug we are exercising requires a fair number of entries
 	# in a sub-directory so that add_index_entry will trigger a
@@ -62,9 +62,9 @@ test_expect_success 'git ls-files --with-tree should succeed from subdir' '
 	)
 '
 
-test_expect_success \
-    'git ls-files --with-tree should add entries from named tree.' \
-    'test_cmp expected output'
+test_expect_success 'git ls-files --with-tree should add entries from named tree.' '
+	test_cmp expected output
+'
 
 test_expect_success 'no duplicates in --with-tree output' '
 	git ls-files --with-tree=HEAD >actual &&

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
gitgitgadget
