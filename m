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
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A1E1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 12:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405698AbfIYMp1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 08:45:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43906 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404621AbfIYMp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 08:45:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id q17so6775967wrx.10
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 05:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2r0ALgRKisw5BArvTdwU0oIOtcZvpmG4qZxwXk7SjTg=;
        b=VObuHa94vrdKlWFq/aaQEZoxdZfGbc3IGLhp5NtSVquQjbj8l1I7UW3jhpSnxsg5sJ
         KJPpFeOV2vWgWSDDqjeoD3qkfre0XNIr1NJECpt7h3GqhkJ8UQ/o4Mx2v7WX95x3An5/
         fPi0zAQKcCuEFa6svmti3zGMJdMAdsBZFfYfILkwlvmX89n74CWVAGlQmHDybmE1/dmP
         nfxQY+EpBZ8d07Vnvxke0tNxV2d5fFxlrGPxl/6UI9ghetvzJhbssCiGM8oBDxw+UgB1
         t094+HGZIA/Y25qVUP9FvQpw2lMhVJS3NuwHVXxwDZ7Lk7KIP9GU+ngXdl9sc/nPhqba
         q4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2r0ALgRKisw5BArvTdwU0oIOtcZvpmG4qZxwXk7SjTg=;
        b=bawz2tZXVa3IvmvKfSKLzmSoNbP/KaKAa0PymVGaT7jhOK7p+lbmJoCGP02UHaNjcQ
         ho9wJeHpvmO3qt5hu+9cQv5vw+a6BVLrtvNnnci+BMbXTSdWqxS6xKlF8BTAJLiX8bu0
         fcoUKGGNzWIkSazeGKcmI+Z1XXrCuT3ttk1AnJlNy9N5yUbR9kbhUsH3JAzBBItMQWlq
         8FRpbBzvp502NRItIZPOM6wmgqehoCfW89J+9Cv53aL+B7tr55CTQViDTuaT93jf0gsP
         s9msC7qtGf/GHv8jV2jdqYDKI0uzgN3GbCjf6rlJ72fAbhPT6OXlH4rW1qSsXRxaL+ft
         mKCg==
X-Gm-Message-State: APjAAAW6idhhg4LMHCoFt4boq1bmHewvJ4s4Hr9Jlnh96l3YZaQLTs0e
        MckZbROQxvefG8OYiFjh/UyMyeDD
X-Google-Smtp-Source: APXvYqxzLaVKhgx55sNz6YsZ5bCaCJci55EZJEqW4X8Kmz/7J1gcl7zvOT43Vfi0vEBlbdt01w2IcA==
X-Received: by 2002:a05:6000:160a:: with SMTP id u10mr9780476wrb.235.1569415524505;
        Wed, 25 Sep 2019 05:45:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm4327162wmo.22.2019.09.25.05.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 05:45:24 -0700 (PDT)
Date:   Wed, 25 Sep 2019 05:45:24 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Sep 2019 12:45:22 GMT
Message-Id: <a687c16b824ec9ab45d1e2c39a5470ed89153fc0.1569415522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.354.git.gitgitgadget@gmail.com>
References: <pull.354.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] stash apply: report status correctly even in a worktree's
 subdirectory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git wants to spawn a child Git process inside a worktree's
subdirectory, we need to take care of specifying the work tree's
top-level directory explicitly because it cannot be discovered: the
current directory is _not_ the top-level directory of the work tree, and
neither is it inside the parent directory of `GIT_DIR`.

This fixes the problem where `git stash apply` would report pretty much
everything deleted or untracked when run inside a worktree's
subdirectory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c              |  2 ++
 t/t3908-stash-in-worktree.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100755 t/t3908-stash-in-worktree.sh

diff --git a/builtin/stash.c b/builtin/stash.c
index b5a301f24d..a1e2e7ae7e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -497,6 +497,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		 */
 		cp.git_cmd = 1;
 		cp.dir = prefix;
+		argv_array_pushf(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT"=%s",
+				 absolute_path(get_git_work_tree()));
 		argv_array_push(&cp.args, "status");
 		run_command(&cp);
 	}
diff --git a/t/t3908-stash-in-worktree.sh b/t/t3908-stash-in-worktree.sh
new file mode 100755
index 0000000000..2b2b366ef9
--- /dev/null
+++ b/t/t3908-stash-in-worktree.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Johannes E Schindelin
+#
+
+test_description='Test git stash in a worktree'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial &&
+	git worktree add wt &&
+	test_commit -C wt in-worktree
+'
+
+test_expect_success 'apply in subdirectory' '
+	mkdir wt/subdir &&
+	(
+		cd wt/subdir &&
+		echo modified >../initial.t &&
+		git stash &&
+		git stash apply >out
+	) &&
+	grep "\.\.\/initial\.t" wt/subdir/out
+'
+
+test_done
-- 
gitgitgadget
