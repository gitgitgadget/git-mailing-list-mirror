Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9EFE20248
	for <e@80x24.org>; Tue, 26 Feb 2019 13:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfBZNmK (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 08:42:10 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38450 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBZNmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 08:42:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so10751127edb.5
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 05:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8QywU4RDGA9x/rgXu+oXnHZ6bQwxsV21b+SRz9YTjAY=;
        b=hxbZfaoaN+fT8/WZibS7nKwDT8i9dnglNrfY+DuD40OxRVY4R2iM6JkQA+a7gENdtA
         6uHG8aNnRAh+v+iBCXKojkfTEKKhxAiYgAZR4AMvao4NKalX0bgBRbbiR/NG2MFxcNa0
         riWSvjgLZ+qt6GUOVPVo45IdC7/B7MaDvdC8obXggWExI8hDJhW2mgiSC/3wk6DVLQcw
         2d78ExXWkyjvwTOUIp5MTSCdlJ9CnBL4cYK5lEgg8k80iwBRBs8P2JfyM+8pG8wkcjM0
         rG4e7MQyECaXp10wWCmc8IMAnbQhhn0dIZworacDx1qQh+oGEFJeiw7ctYmkMnh+y61Q
         I0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8QywU4RDGA9x/rgXu+oXnHZ6bQwxsV21b+SRz9YTjAY=;
        b=Bd1qppLa884i0TY3OlMFWcPOFfXphLGCHqgycnGG2GN0Q8SM8n9o4fDxSpJ/RYfd3i
         iuUn58WhTPq55rlvWL3J/82lVq1kEhv8SaqUB/MclnhjSQuwzp5l1Mo3GC0hHP+Jszjd
         mfAZpi2Ezp4D6VjDY4KIibOFfxv9JvUjixcnYdKm5OeXsbefLjELIGWDTGmeChmcmeqx
         KR03wPZX3rMP4Wy0lyPZaP52VseqJwiLYsGLunHf3ecGXoSOIWt16Cy+L6SpvCqYlYLD
         5YwBguQJbkaPzR5PzRnzSwbjOAzlLu1G6iBBYET0pPjZbhZDS1i6ouc5o3g8MLuTlzh9
         KP1Q==
X-Gm-Message-State: AHQUAuY+hO53DX2yTBpcwEDCBwYkuDaxHcdgQunDFOuD0KM2a0T6wqcU
        c61YjlDKs1nSfRL+HXezGyua+GNJ
X-Google-Smtp-Source: AHgI3IbZyQyzZhE2DdLLyQNJWi4m8PC/+Kwn7M8Np48DW12VhYmp7jvPgxNlET1uK/xOZCAOMBChkQ==
X-Received: by 2002:a17:906:27c8:: with SMTP id k8mr16682277ejc.230.1551188526611;
        Tue, 26 Feb 2019 05:42:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b46sm3519718edd.18.2019.02.26.05.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 05:42:06 -0800 (PST)
Date:   Tue, 26 Feb 2019 05:42:06 -0800 (PST)
X-Google-Original-Date: Tue, 26 Feb 2019 13:42:04 GMT
Message-Id: <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.152.git.gitgitgadget@gmail.com>
References: <pull.152.git.gitgitgadget@gmail.com>
From:   "Rohit Ashiwal via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] tests: replace `test -(d|f)` with test_path_is_(dir|file)
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

t3600-rm.sh: Previously we were using `test -(d|f)`
to verify the presencee of a directory/file, but we
already have helper functions, viz, test_path_is_dir
and test_path_is_file with same functionality. This
patch will replace `test -(d|f)` calls in t3600-rm.sh.

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
