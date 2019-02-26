Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174A820248
	for <e@80x24.org>; Tue, 26 Feb 2019 22:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfBZWtA (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 17:49:00 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43570 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfBZWs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 17:48:59 -0500
Received: by mail-ed1-f52.google.com with SMTP id m35so12223034ede.10
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/ap1NVFlex8z7hwsByIa50V/ZSh5GxPGBa+fKqwmcsM=;
        b=UDkIFnvSvbMbQ3YaSXiFwJ2PyiojH5fyIf8K1JtsO/54+BxMlCQALrcjsnIwN75Mfb
         4QqfYDI8S/Mh++oMXfwUrJOY/79MALDFgVm8wkWKCS/FZNwQN5sV80sALr2xpoCHSPS0
         0nWyJ4S2xxkKjCMvy2hZS3TQLSZl9pFuYiuxhoyW8uBAOGUC8GGFtGvBTxB4x4IUR4YU
         xhZcIwSu1xjW1kzdTSpUVMVRYZJw43IkiZo4EI5U92B/7AsAsx/DAHnh1aNWKMRkaozz
         gQZDi6qZOQLKMp4fUiTuJ9WYv0LU93HJx2b7rKjQnhCsNhLPqhNZ5woG1IlVLtyvRyg3
         Aaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/ap1NVFlex8z7hwsByIa50V/ZSh5GxPGBa+fKqwmcsM=;
        b=oKMZrZVm3I5svdsx3HWTu+I9ZAkSZHWksR2+OOQzvAGBMftTdVYk5MRPEsQve3KREE
         EZrf4XkKf6cwnwbPq4/NOmyivNe3NsDr3nnVkRhSHPDQIkVjrYOogqxRo6Us/qGP6lDb
         1Cm8bWDR0Ak88ueUvhiUSgwch23+KqfShl4hGKDA2YESdowEjWic9dfpz2HV6vy2gmz+
         mLhGluW0QOQQT9S50ouPIk57hQ0zpd9EtZ0aY2fwDXd0w/p3t3SgPhZ+JJsZFr8bFrqX
         FvDOq5A2/bbxlKkQx3hmTDc9QSavj69bttiGks/nsGKQTYPLudAK2nLHg9v3iVmsnudD
         d+rA==
X-Gm-Message-State: AHQUAubWa3C1hWsZ3mEbsc8bUwjax1LvQxzV2+sN9NiefDhALTSGfZOm
        bD3dXeMlM6oYuFoT2fbiQpUWbvB+
X-Google-Smtp-Source: AHgI3IYrTuHfIgjZicPsBcP04XhjqleXbxncIGI9kWcWDcyk3//nRT38WP8yb0lCvWrBOqVPbqQxpw==
X-Received: by 2002:a17:906:1a4c:: with SMTP id j12mr18602971ejf.134.1551221336241;
        Tue, 26 Feb 2019 14:48:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm1915646edb.36.2019.02.26.14.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 14:48:55 -0800 (PST)
Date:   Tue, 26 Feb 2019 14:48:55 -0800 (PST)
X-Google-Original-Date: Tue, 26 Feb 2019 22:48:54 GMT
Message-Id: <bfeba25c885484093bf8307294935f8baa6b155b.1551221334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.152.v3.git.gitgitgadget@gmail.com>
References: <pull.152.v2.git.gitgitgadget@gmail.com>
        <pull.152.v3.git.gitgitgadget@gmail.com>
From:   "Rohit Ashiwal via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/1] t3600: use test_path_is_* functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

Replace `test -(d|f|e)` calls in t3600-rm.sh

Previously we were using `test -(d|f|e)` to verify
the presence of a directory/file, but we already
have helper functions, viz, `test_path_is_dir`,
`test_path_is_file` and `test_path_is_missing`
with better functionality.

These helper functions make code more readable
and informative to someone new to code, also
these functions have better error messages

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/t3600-rm.sh | 138 +++++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 04e5d42bd3..ad638490ac 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -83,7 +83,7 @@ test_expect_success \
 
 test_expect_success \
     'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
-    '! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
+    'test_path_is_missing bar && test_must_fail git ls-files --error-unmatch bar'
 
 test_expect_success \
     'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \
@@ -137,15 +137,15 @@ test_expect_success 'Re-add foo and baz' '
 test_expect_success 'Modify foo -- rm should refuse' '
 	echo >>foo &&
 	test_must_fail git rm foo baz &&
-	test -f foo &&
-	test -f baz &&
+	test_path_is_file foo &&
+	test_path_is_file baz &&
 	git ls-files --error-unmatch foo baz
 '
 
 test_expect_success 'Modified foo -- rm -f should work' '
 	git rm -f foo baz &&
-	test ! -f foo &&
-	test ! -f baz &&
+	test_path_is_missing foo &&
+	test_path_is_missing baz &&
 	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch bar
 '
@@ -159,15 +159,15 @@ test_expect_success 'Re-add foo and baz for HEAD tests' '
 
 test_expect_success 'foo is different in index from HEAD -- rm should refuse' '
 	test_must_fail git rm foo baz &&
-	test -f foo &&
-	test -f baz &&
+	test_path_is_file foo &&
+	test_path_is_file baz &&
 	git ls-files --error-unmatch foo baz
 '
 
 test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
-	test ! -f foo &&
-	test ! -f baz &&
+	test_path_is_missing foo &&
+	test_path_is_missing baz &&
 	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch baz
 '
@@ -194,21 +194,21 @@ test_expect_success 'Recursive test setup' '
 
 test_expect_success 'Recursive without -r fails' '
 	test_must_fail git rm frotz &&
-	test -d frotz &&
-	test -f frotz/nitfol
+	test_path_is_dir frotz &&
+	test_path_is_file frotz/nitfol
 '
 
 test_expect_success 'Recursive with -r but dirty' '
 	echo qfwfq >>frotz/nitfol &&
 	test_must_fail git rm -r frotz &&
-	test -d frotz &&
-	test -f frotz/nitfol
+	test_path_is_dir frotz &&
+	test_path_is_file frotz/nitfol
 '
 
 test_expect_success 'Recursive with -r -f' '
 	git rm -f -r frotz &&
-	! test -f frotz/nitfol &&
-	! test -d frotz
+	test_path_is_missing frotz/nitfol &&
+	test_path_is_missing frotz
 '
 
 test_expect_success 'Remove nonexistent file returns nonzero exit status' '
@@ -232,7 +232,7 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 	git reset --hard &&
 	test-tool chmtime -86400 frotz/nitfol &&
 	git rm frotz/nitfol &&
-	test ! -f frotz/nitfol
+	test_path_is_missing frotz/nitfol
 
 '
 
@@ -254,7 +254,7 @@ test_expect_success 'rm removes subdirectories recursively' '
 	echo content >dir/subdir/subsubdir/file &&
 	git add dir/subdir/subsubdir/file &&
 	git rm -f dir/subdir/subsubdir/file &&
-	! test -d dir
+	test_path_is_missing dir
 '
 
 cat >expect <<EOF
@@ -292,7 +292,7 @@ test_expect_success 'rm removes empty submodules from work tree' '
 	git add .gitmodules &&
 	git commit -m "add submodule" &&
 	git rm submod &&
-	test ! -e submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -314,7 +314,7 @@ test_expect_success 'rm removes work tree of unmodified submodules' '
 	git reset --hard &&
 	git submodule update &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -325,7 +325,7 @@ test_expect_success 'rm removes a submodule with a trailing /' '
 	git reset --hard &&
 	git submodule update &&
 	git rm submod/ &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -343,12 +343,12 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
 	git submodule update &&
 	git -C submod checkout HEAD^ &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -359,8 +359,8 @@ test_expect_success 'rm --cached leaves work tree of populated submodules and .g
 	git reset --hard &&
 	git submodule update &&
 	git rm --cached submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect.cached actual &&
 	git config -f .gitmodules submodule.sub.url &&
@@ -371,7 +371,7 @@ test_expect_success 'rm --dry-run does not touch the submodule or .gitmodules' '
 	git reset --hard &&
 	git submodule update &&
 	git rm -n submod &&
-	test -f submod/.git &&
+	test_path_is_file submod/.git &&
 	git diff-index --exit-code HEAD
 '
 
@@ -381,8 +381,8 @@ test_expect_success 'rm does not complain when no .gitmodules file is found' '
 	git rm .gitmodules &&
 	git rm submod >actual 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect.both_deleted actual
 '
@@ -393,14 +393,14 @@ test_expect_success 'rm will error out on a modified .gitmodules file unless sta
 	git config -f .gitmodules foo.bar true &&
 	test_must_fail git rm submod >actual 2>actual.err &&
 	test -s actual.err &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git diff-files --quiet -- submod &&
 	git add .gitmodules &&
 	git rm submod >actual 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect actual
 '
@@ -413,8 +413,8 @@ test_expect_success 'rm issues a warning when section is not found in .gitmodule
 	echo "warning: Could not find section in .gitmodules where path=submod" >expect.err &&
 	git rm submod >actual 2>actual.err &&
 	test_i18ncmp expect.err actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect actual
 '
@@ -424,12 +424,12 @@ test_expect_success 'rm of a populated submodule with modifications fails unless
 	git submodule update &&
 	echo X >submod/empty &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -439,12 +439,12 @@ test_expect_success 'rm of a populated submodule with untracked files fails unle
 	git submodule update &&
 	echo X >submod/untracked &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -481,7 +481,7 @@ test_expect_success 'rm removes work tree of unmodified conflicted submodule' '
 	git submodule update &&
 	test_must_fail git merge conflict2 &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -493,12 +493,12 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
 	git -C submod checkout HEAD^ &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -512,12 +512,12 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
 	echo X >submod/empty &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -531,12 +531,12 @@ test_expect_success 'rm of a conflicted populated submodule with untracked files
 	echo X >submod/untracked &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -552,13 +552,13 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
 	) &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -d submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_dir submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	test_must_fail git rm -f submod &&
-	test -d submod &&
-	test -d submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_dir submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git merge --abort &&
@@ -570,7 +570,7 @@ test_expect_success 'rm of a conflicted unpopulated submodule succeeds' '
 	git reset --hard &&
 	test_must_fail git merge conflict2 &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -586,8 +586,8 @@ test_expect_success 'rm of a populated submodule with a .git directory migrates
 		rm -r ../.git/modules/sub
 	) &&
 	git rm submod 2>output.err &&
-	! test -d submod &&
-	! test -d submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test -s actual &&
 	test_i18ngrep Migrating output.err
@@ -614,7 +614,7 @@ test_expect_success 'setup subsubmodule' '
 
 test_expect_success 'rm recursively removes work tree of unmodified submodules' '
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -624,12 +624,12 @@ test_expect_success 'rm of a populated nested submodule with different nested HE
 	git submodule update --recursive &&
 	git -C submod/subsubmod checkout HEAD^ &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -639,12 +639,12 @@ test_expect_success 'rm of a populated nested submodule with nested modification
 	git submodule update --recursive &&
 	echo X >submod/subsubmod/empty &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -654,12 +654,12 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	git submodule update --recursive &&
 	echo X >submod/subsubmod/untracked &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -673,8 +673,8 @@ test_expect_success "rm absorbs submodule's nested .git directory" '
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	git rm submod 2>output.err &&
-	! test -d submod &&
-	! test -d submod/subsubmod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/subsubmod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test -s actual &&
 	test_i18ngrep Migrating output.err
-- 
gitgitgadget
