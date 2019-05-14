Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434871F461
	for <e@80x24.org>; Tue, 14 May 2019 11:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfENLWd (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:22:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34462 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfENLWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:22:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so22373424eda.1
        for <git@vger.kernel.org>; Tue, 14 May 2019 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E2A/JqW97uFERCd+1K0BINidai7pSYgu+Dzcie5HIEE=;
        b=ca0IHJ59r6y+UWdfRpHaB21/+qPhm+91Gqes6PV9o8phKU4sR3nTGBTpDB8LWvy9zH
         c34S6GNo45NPCuMTSkjeGxRh7oYWfqvs0H7sS7RbDOV6oK2sfFEXENJCQBy2tjEvN1WL
         VsDRSMU759sEHsQwpnZw8zOibgALz80DVso0CXVGrVaKk/pmd86/Y97bB9UZ7K+c49UD
         ICOs+MOsvw01hRl+np2J803t9a2kZmKpPCVlggbfSsBoa3XlQmk/197uPbKXJQjGvJJY
         LzGlOfzBvjpg/HOaY3sWZ3yZp7f/AZIYNizSqD80d4ZQ/Dzc0WsfGXZt8O5FlKgF32AQ
         oKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E2A/JqW97uFERCd+1K0BINidai7pSYgu+Dzcie5HIEE=;
        b=Kp03nVWl+9GQjt+eHkxOmsaEHytVrWF1jjrABsWMlV/1bkO5IJUF2hqViEFTrKHczG
         tepiilUbK9ICz9quERYD1mg+QReHFK8IQ2ikenletojtGPlbxbTY6euf4zGcRLqayYqN
         oVLMEY+dhzW7L8G5O9rdR5hoiv2zqU4v34DJcQddPjiJv897DdoVzMLV78RblGNcLI28
         17AohX6L9bvdgDZ8p0O4PIGROFQUBZWFTjZhMByP0gm+N7Kk2I95C37e3YMDFjC87ARh
         ZCTp4Qcdyl9x11VoQCXdE4eSbsveYh+F/Z5Joa/HCAeyiPCn/qnu9WR245HqvLJ3rKRN
         KZzg==
X-Gm-Message-State: APjAAAWre2/8NN3nBu3ECDp88vlAM8w/RnFm00wlZzJWC1HjQesxR08O
        o0H/JvaXrFpo6LVUWE1pD0jG1W2A
X-Google-Smtp-Source: APXvYqyF1mA+QA/zZXyV79A3Sft54QE1MdCXLDgZZ5ORhbgGZHBNKxjxrHI1UmSgIADMjLeiNZ59zw==
X-Received: by 2002:a50:a5f1:: with SMTP id b46mr34956218edc.167.1557832951622;
        Tue, 14 May 2019 04:22:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13sm4519596eda.87.2019.05.14.04.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 04:22:31 -0700 (PDT)
Date:   Tue, 14 May 2019 04:22:31 -0700 (PDT)
X-Google-Original-Date: Tue, 14 May 2019 11:22:25 GMT
Message-Id: <fa2b967ce8b7c9da54b2304edc7e7505d262a238.1557832949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.194.git.gitgitgadget@gmail.com>
References: <pull.194.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/5] Drop unused git-rebase--am.sh
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

Since 21853626ea (built-in rebase: call `git am` directly, 2019-01-18),
the built-in rebase already uses the built-in `git am` directly.

Now that d03ebd411c (rebase: remove the rebase.useBuiltin setting,
2019-03-18) even removed the scripted rebase, there is no longer any
user of `git-rebase--am.sh`, so let's just remove it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore        |  1 -
 Makefile          |  1 -
 builtin/rebase.c  |  4 ---
 git-rebase--am.sh | 85 -----------------------------------------------
 4 files changed, 91 deletions(-)
 delete mode 100644 git-rebase--am.sh

diff --git a/.gitignore b/.gitignore
index 2374f77a1a..875f3fc6e8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -122,7 +122,6 @@
 /git-range-diff
 /git-read-tree
 /git-rebase
-/git-rebase--am
 /git-rebase--common
 /git-rebase--interactive
 /git-rebase--preserve-merges
diff --git a/Makefile b/Makefile
index f965509b3c..9370d85ff3 100644
--- a/Makefile
+++ b/Makefile
@@ -624,7 +624,6 @@ SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
-SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--common
 SCRIPT_LIB += git-rebase--preserve-merges
 SCRIPT_LIB += git-sh-setup
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ba3a574e40..d5f6f403e2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1153,10 +1153,6 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	}
 
 	switch (opts->type) {
-	case REBASE_AM:
-		backend = "git-rebase--am";
-		backend_func = "git_rebase__am";
-		break;
 	case REBASE_PRESERVE_MERGES:
 		backend = "git-rebase--preserve-merges";
 		backend_func = "git_rebase__preserve_merges";
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
deleted file mode 100644
index 6416716ee6..0000000000
--- a/git-rebase--am.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-# This shell script fragment is sourced by git-rebase to implement
-# its default, fast, patch-based, non-interactive mode.
-#
-# Copyright (c) 2010 Junio C Hamano.
-#
-
-git_rebase__am () {
-
-case "$action" in
-continue)
-	git am --resolved --resolvemsg="$resolvemsg" \
-		${gpg_sign_opt:+"$gpg_sign_opt"} &&
-	move_to_original_branch
-	return
-	;;
-skip)
-	git am --skip --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
-	return
-	;;
-show-current-patch)
-	exec git am --show-current-patch
-	;;
-esac
-
-if test -z "$rebase_root"
-	# this is now equivalent to ! -z "$upstream"
-then
-	revisions=$upstream...$orig_head
-else
-	revisions=$onto...$orig_head
-fi
-
-ret=0
-rm -f "$GIT_DIR/rebased-patches"
-
-git format-patch -k --stdout --full-index --cherry-pick --right-only \
-	--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
-	--pretty=mboxrd --topo-order \
-	$git_format_patch_opt \
-	"$revisions" ${restrict_revision+^$restrict_revision} \
-	>"$GIT_DIR/rebased-patches"
-ret=$?
-
-if test 0 != $ret
-then
-	rm -f "$GIT_DIR/rebased-patches"
-	case "$head_name" in
-	refs/heads/*)
-		git checkout -q "$head_name"
-		;;
-	*)
-		git checkout -q "$orig_head"
-		;;
-	esac
-
-	cat >&2 <<-EOF
-
-	git encountered an error while preparing the patches to replay
-	these revisions:
-
-	    $revisions
-
-	As a result, git cannot rebase them.
-	EOF
-	return $ret
-fi
-
-git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
-	--patch-format=mboxrd \
-	$allow_rerere_autoupdate \
-	${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
-ret=$?
-
-rm -f "$GIT_DIR/rebased-patches"
-
-if test 0 != $ret
-then
-	test -d "$state_dir" && write_basic_state
-	return $ret
-fi
-
-move_to_original_branch
-
-}
-- 
gitgitgadget

