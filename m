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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE191F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 12:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfJDMbC (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 08:31:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38057 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbfJDMbC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 08:31:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so5663402wmi.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8qU8yplTo7zGQjrP57YWqvms36kVRxd4v/iujm47Mu8=;
        b=OxcY+OEXpba2ft1p1H0Q8F735yioM3V2FbZMraqGDTkx7vlCUIsoobJ1Vx+6s1qtZj
         g1oS3V/lcFAfl/YmxLMgzJMCvEcRB1vLfQHCrjLHGuMZJw5wIunx5t8tqrqkc5iE6196
         ZweLS8l+VFcETktzUJPbS2ygD7jyJJgTGgcbhVTSDTIqYMFaA+J63foTZzBfm0QX8w/e
         LmX6paMcLBND4IzVO9Pgmp+UKBlfjD/OtN90/NCXQdUF4vGypIeYHVtfUNWCWaRnp6eS
         bnL8ZRJbSaYrAavUTdjo5KpsU5pXkaB6RHljWrfvVXiNj2B58jQHeE6t0g9vx6qYjMMe
         adzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8qU8yplTo7zGQjrP57YWqvms36kVRxd4v/iujm47Mu8=;
        b=qDmNUX2gzJHbsH9Wa1MvdnVK873OIRUlgruiePAaJm2Eo/di9761OCcmLH07ytodtQ
         +hNit+U6o1GgsaoepC6XbGra6zoloFz1DO3MomrDqmldCtfZY4quyKOTDBRWycLRVzZh
         k95+9YNrwZi28LhPpPhhdVX3Dfqti8xCH+alw3DgSHXLbUi/cGnNuXFgO6ZDLXRXpjxu
         DQd0sKfxWbL9+RMiFRCYJwNra0AOaUmdNIuK2ViRVi4219RvcFdR4ZXrdMO90NFWft6U
         ULz0ya7eqETdsBCCp4I0bZvCyoi/ZT/9mQb7MxE2674fsCCoeZIfqViblSz075dQ2gKo
         utzw==
X-Gm-Message-State: APjAAAVLytD0Gk0myACF+1PyUa8T/qrbkCwHnHxXrGoz53uf3kBF8i1x
        81OrY71ffJhj5nOuOOnzi12RWer7
X-Google-Smtp-Source: APXvYqxrmUQD5kzoHs+eRvUM4csmIunTM0/mPJ8kS0k4hHLEcMlrdHVGrMjFyrxA/bNoipp/8NDHHw==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr10230480wmi.72.1570192259745;
        Fri, 04 Oct 2019 05:30:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm7011161wrm.64.2019.10.04.05.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 05:30:59 -0700 (PDT)
Date:   Fri, 04 Oct 2019 05:30:59 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 12:30:57 GMT
Message-Id: <4e19436fbfbc923df6ab26477edfbacf9eab0ead.1570192257.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.354.v2.git.gitgitgadget@gmail.com>
References: <pull.354.git.gitgitgadget@gmail.com>
        <pull.354.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] stash apply: report status correctly even in a
 worktree's subdirectory
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

When Git wants to spawn a child Git process inside a worktree's
subdirectory while `GIT_DIR` is set, we need to take care of specifying
the work tree's top-level directory explicitly because it cannot be
discovered: the current directory is _not_ the top-level directory of
the work tree, and neither is it inside the parent directory of
`GIT_DIR`.

This fixes the problem where `git stash apply` would report pretty much
everything deleted or untracked when run inside a worktree's
subdirectory.

To make sure that we do not introduce the "reverse problem", i.e. when
`GIT_WORK_TREE` is defined but `GIT_DIR` is not, we simply make sure
that both are set.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c              |  4 ++++
 t/t3908-stash-in-worktree.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100755 t/t3908-stash-in-worktree.sh

diff --git a/builtin/stash.c b/builtin/stash.c
index b5a301f24d..b108f099fa 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -497,6 +497,10 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		 */
 		cp.git_cmd = 1;
 		cp.dir = prefix;
+		argv_array_pushf(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT"=%s",
+				 absolute_path(get_git_work_tree()));
+		argv_array_pushf(&cp.env_array, GIT_DIR_ENVIRONMENT"=%s",
+				 absolute_path(get_git_dir()));
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
