Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33CBB20248
	for <e@80x24.org>; Tue, 26 Feb 2019 14:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBZO0O (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 09:26:14 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:32870 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfBZO0N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 09:26:13 -0500
Received: by mail-ed1-f48.google.com with SMTP id c55so10910565edb.0
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 06:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WBYuUSJ7qmAUFTjmH5y3HdCE9/hFQVgsA1rBiEWM/ME=;
        b=Y51UPTmxa97MvmSITLiqf8NvaLh26tumyjWzEK38je1upeqB9fxL/kSW7dDq6yn5xH
         zezO/6IQvd+Kxe4/J13PVILGItB28rUzUjeqf0hyyTLffVxfJs+K9L2ovG11pOeA+Mgd
         o9XSVkbQU8W6caIyFbDmanmdxw8TBc0A9mg0VNUtKBlidr3qnaxqmk/fzuccNW3Q/W/5
         FXhisbh/aiLETK3BbZbsuFjHkc5mq6ybOreM8DJZr9/LDAIj+clAvr0O1e+JjOE7wUtN
         qyM8iMha8LqmhKRMgMnyePLDWYw9/93lsU7Cg8Bd59sMLSjqJ6KVNV9mDfd5wS0qnVAO
         K3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WBYuUSJ7qmAUFTjmH5y3HdCE9/hFQVgsA1rBiEWM/ME=;
        b=iZSgawRCPIq3v6tj05jYwje5Wi4wXI2e/nIa5HtIXtuB3gfabhLg0xjw6u01+xI17e
         M1KZxo+AI9RjsU9nkJUWtmCzCkRkl/2HlN8R5Oy8wpxJFb+eljMgvzTneHFURimixx+L
         qGltyiS2sP4s/0A0RcOPBp4QmTWUN1fFkyyHWalOJCST2WwcIyCBZDk/rDGFOIel9VJG
         0gwou+cCx7PS4U6m3O1eSOM8gX7AktnjaUjahyfci4R+bzCqQMyNaf8WPCHvE5917QhO
         TgdXBXdVWqJhQTYTmf6aHm9kU7l0taBIRLqh969s2WOd5cz8BWLGV4xH+ydSQ5yMDLsC
         iVrA==
X-Gm-Message-State: AHQUAuY2vswlPeAi8myARE7E/YPMlEMq/gPzjc887fLUa/twYXJS4xLL
        mwBYgvrUQ4CgCXYyPXt983hoCLEv
X-Google-Smtp-Source: AHgI3IZIS/qEDDJ8ELxDZsxvKm2LNOBop14U/ZN7Q/zcUzs63P9AJX/KQejvSV6IekSxWH6cwh5llQ==
X-Received: by 2002:a50:fa8f:: with SMTP id w15mr18456962edr.256.1551191170476;
        Tue, 26 Feb 2019 06:26:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w54sm3523792edw.82.2019.02.26.06.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:26:09 -0800 (PST)
Date:   Tue, 26 Feb 2019 06:26:09 -0800 (PST)
X-Google-Original-Date: Tue, 26 Feb 2019 14:26:08 GMT
Message-Id: <fcafc87b382dfef00d8e33e875bcb8b03d5667e4.1551191168.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.152.v2.git.gitgitgadget@gmail.com>
References: <pull.152.git.gitgitgadget@gmail.com>
        <pull.152.v2.git.gitgitgadget@gmail.com>
From:   "Rohit Ashiwal via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] t3600: use test_path_is_dir and test_path_is_file
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

Previously we were using `test -(d|f)` to verify
the presence of a directory/file, but we already
have helper functions, viz, `test_path_is_dir`
and `test_path_is_file` with better functionality.
This patch will replace `test -(d|f)` calls in t3660.sh

These helper functions make code more readable
and informative to someone new to code, also
these functions have better error messages

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/t3600-rm.sh | 96 +++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 04e5d42bd3..dcaa2ab4d6 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -137,8 +137,8 @@ test_expect_success 'Re-add foo and baz' '
 test_expect_success 'Modify foo -- rm should refuse' '
 	echo >>foo &&
 	test_must_fail git rm foo baz &&
-	test -f foo &&
-	test -f baz &&
+	test_path_is_file foo &&
+	test_path_is_file baz &&
 	git ls-files --error-unmatch foo baz
 '
 
@@ -159,8 +159,8 @@ test_expect_success 'Re-add foo and baz for HEAD tests' '
 
 test_expect_success 'foo is different in index from HEAD -- rm should refuse' '
 	test_must_fail git rm foo baz &&
-	test -f foo &&
-	test -f baz &&
+	test_path_is_file foo &&
+	test_path_is_file baz &&
 	git ls-files --error-unmatch foo baz
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
+	! test_path_is_file frotz/nitfol &&
+	! test_path_is_dir frotz
 '
 
 test_expect_success 'Remove nonexistent file returns nonzero exit status' '
@@ -254,7 +254,7 @@ test_expect_success 'rm removes subdirectories recursively' '
 	echo content >dir/subdir/subsubdir/file &&
 	git add dir/subdir/subsubdir/file &&
 	git rm -f dir/subdir/subsubdir/file &&
-	! test -d dir
+	! test_path_is_dir dir
 '
 
 cat >expect <<EOF
@@ -343,8 +343,8 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
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
+	! test_path_is_dir submod &&
+	! test_path_is_file submod/.git &&
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
+	! test_path_is_dir submod &&
+	! test_path_is_file submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect actual
 '
@@ -413,8 +413,8 @@ test_expect_success 'rm issues a warning when section is not found in .gitmodule
 	echo "warning: Could not find section in .gitmodules where path=submod" >expect.err &&
 	git rm submod >actual 2>actual.err &&
 	test_i18ncmp expect.err actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	! test_path_is_dir submod &&
+	! test_path_is_file submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect actual
 '
@@ -424,8 +424,8 @@ test_expect_success 'rm of a populated submodule with modifications fails unless
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
@@ -439,8 +439,8 @@ test_expect_success 'rm of a populated submodule with untracked files fails unle
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
@@ -493,8 +493,8 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
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
@@ -512,8 +512,8 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
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
@@ -531,8 +531,8 @@ test_expect_success 'rm of a conflicted populated submodule with untracked files
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
@@ -586,8 +586,8 @@ test_expect_success 'rm of a populated submodule with a .git directory migrates
 		rm -r ../.git/modules/sub
 	) &&
 	git rm submod 2>output.err &&
-	! test -d submod &&
-	! test -d submod/.git &&
+	! test_path_is_dir submod &&
+	! test_path_is_dir submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test -s actual &&
 	test_i18ngrep Migrating output.err
@@ -624,8 +624,8 @@ test_expect_success 'rm of a populated nested submodule with different nested HE
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
@@ -639,8 +639,8 @@ test_expect_success 'rm of a populated nested submodule with nested modification
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
@@ -654,8 +654,8 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
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
@@ -673,8 +673,8 @@ test_expect_success "rm absorbs submodule's nested .git directory" '
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	git rm submod 2>output.err &&
-	! test -d submod &&
-	! test -d submod/subsubmod/.git &&
+	! test_path_is_dir submod &&
+	! test_path_is_dir submod/subsubmod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test -s actual &&
 	test_i18ngrep Migrating output.err
-- 
gitgitgadget
