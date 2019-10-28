Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16FEA1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 12:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfJ1M5X (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 08:57:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51983 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJ1M5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 08:57:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id q70so9351205wme.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H9ioiFSvqlmVyZgbxnoQsoLXvDDhoeoZatx10f+xDOI=;
        b=q+NCnNT9Zu/GGCAbo5i/Bl0WBUNblwRovNPIT20jI6x+dGchoKhC9budiqU71Y2XT5
         cbw94qI6SdNHmpXh08T3mWJfsWg+82C6zw4twm0M5IZohFyFBl5dBpXflG4mSCjlMVEn
         tAaWipPeklho27IQuX+VaAhapvnAhHLKARVFjSuzHRIYtZ2KNr99B6tJismm0CjY3vRy
         1O1wLLt1/nqDyfnguyUysXQ5P56JX3iSHcGWC+2IkeXNxuSXdCa6h3AWiJa6Ejg+qUDG
         06rrt3DwP4u7xjdFXED3KU1UdcdU83cFJAQCHLgznK+ov5na9/m9+90FP2cvRcbBkSKd
         DE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H9ioiFSvqlmVyZgbxnoQsoLXvDDhoeoZatx10f+xDOI=;
        b=SZWwrTp9IcSVJEQXGtEREtXnY6BZED2H0TP1Rnh0bSarVmRMK/iHSkGRmsOPyP8C3a
         R2aUs5FJA5P0PIvpJUdmNCuGDW+vV82RfyLVsV8/aQ73Ui3tc5YTEuiUBwL8uQi0lE9S
         DPVZcy7+ozoi7/TBvaV3IWYNDCz30wMSpWY1EBImPW6oKOCD3i4r3j4r00Bf+4W4bMSS
         p1PB3DSE6yqbrAM6j0tyry4Rt3kL4rLlKPg/dyfbiFc/JJqh6sh20bKVSwuuOZurNp6+
         M0zqf1QiNYDxiPWaPSb9hOCzgtczgG0sEoJHiDKOnmcjku5R8DbpgmkdBuJDfab8Ux19
         bpmg==
X-Gm-Message-State: APjAAAVMoQaZSJWCzQr7/m9C68bhqm/9ATB/easJsEE9Bn2gHegGQHwz
        m+n22KjvgbdNRHfy1CBwD2Gh1Z0L
X-Google-Smtp-Source: APXvYqy7XGuTbEDqGKW/vWddKdYxCdTpjjeUw5t3F0AsWV9TDjpIrviSYDnS5RGXLCcuF7zOsLekRA==
X-Received: by 2002:a1c:106:: with SMTP id 6mr14241784wmb.134.1572267440979;
        Mon, 28 Oct 2019 05:57:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm11602845wru.83.2019.10.28.05.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:57:20 -0700 (PDT)
Message-Id: <d98810875ee4a085e84bf00836ce198a7d64d1a2.1572267438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.v4.git.1572267438.gitgitgadget@gmail.com>
References: <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
        <pull.401.v4.git.1572267438.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 12:57:18 +0000
Subject: [PATCH v4 2/2] git_path(): handle `.lock` files correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Ever since worktrees were introduced, the `git_path()` function _really_
needed to be called e.g. to get at the path to `logs/HEAD` (`HEAD` is
specific to the worktree, and therefore so is its reflog). However, the
wrong path is returned for `logs/HEAD.lock`.

This does not matter as long as the Git executable is doing the asking,
as the path for that `logs/HEAD.lock` file is constructed from
`git_path("logs/HEAD")` by appending the `.lock` suffix.

However, Git GUI just learned to use `--git-path` instead of appending
relative paths to what `git rev-parse --git-dir` returns (and as a
consequence not only using the correct hooks directory, but also using
the correct paths in worktrees other than the main one). While it does
not seem as if Git GUI in particular is asking for `logs/HEAD.lock`,
let's be safe rather than sorry.

Side note: Git GUI _does_ ask for `index.lock`, but that is already
resolved correctly, due to `update_common_dir()` preferring to leave
unknown paths in the (worktree-specific) git directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 path.c                | 6 ++++++
 t/t0060-path-utils.sh | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/path.c b/path.c
index e3da1f3c4e..198a867017 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
 #include "path.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "lockfile.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -350,9 +351,14 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len,
 			      const char *common_dir)
 {
 	char *base = buf->buf + git_dir_len;
+	int has_lock_suffix = strbuf_strip_suffix(buf, LOCK_SUFFIX);
+
 	init_common_trie();
 	if (trie_find(&common_trie, base, check_common, NULL) > 0)
 		replace_dir(buf, git_dir_len, common_dir);
+
+	if (has_lock_suffix)
+		strbuf_addstr(buf, LOCK_SUFFIX);
 }
 
 void report_linked_checkout_garbage(void)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index c7b53e494b..2aca8ccff9 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -285,8 +285,10 @@ test_git_path GIT_OBJECT_DIRECTORY=foo objects/foo foo/foo
 test_git_path GIT_OBJECT_DIRECTORY=foo objects2 .git/objects2
 test_expect_success 'setup common repository' 'git --git-dir=bar init'
 test_git_path GIT_COMMON_DIR=bar index                    .git/index
+test_git_path GIT_COMMON_DIR=bar index.lock               .git/index.lock
 test_git_path GIT_COMMON_DIR=bar HEAD                     .git/HEAD
 test_git_path GIT_COMMON_DIR=bar logs/HEAD                .git/logs/HEAD
+test_git_path GIT_COMMON_DIR=bar logs/HEAD.lock           .git/logs/HEAD.lock
 test_git_path GIT_COMMON_DIR=bar logs/refs/bisect/foo     .git/logs/refs/bisect/foo
 test_git_path GIT_COMMON_DIR=bar logs/refs/bisec/foo      bar/logs/refs/bisec/foo
 test_git_path GIT_COMMON_DIR=bar logs/refs/bisec          bar/logs/refs/bisec
-- 
gitgitgadget
