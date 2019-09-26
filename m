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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5A91F463
	for <e@80x24.org>; Thu, 26 Sep 2019 07:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfIZHmf (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 03:42:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35316 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731084AbfIZHme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 03:42:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so948575lfl.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FPsqk1PK/xKUY/hJlGx/dDqrkcUC7sJ7OXr3+q+Wi0Q=;
        b=LkuSb85mZ4LgfnPCXfcxdcHvymw2B19yOybCnIIAYhxVlmZLAKwfygRRzSSwDpbIVH
         4tOxEsiyROvLQaY05MHMGiYimYzqXXVS4X5vnvs2IdPRxvSgTeDR9M8ulvrUcyxdnXbT
         tHDD7IBMi/EAfY1+kuzM3gBzIc8hpHAYOb/5OELzZuYWeM/kN35rtnK2bWtJsKnKBVmg
         jknJkwQUqOvxKdJB6daJWs5TmMFxAuk+rQrf+S/8wnew9BLTaBjL9A90y40xav9+hE1J
         UBEPXkuZbS+St7aCMVwrHM3PEzUU7pAGSKxbLv2F8shRere4ZQh6IK3zYlJwSNizHBNB
         I7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FPsqk1PK/xKUY/hJlGx/dDqrkcUC7sJ7OXr3+q+Wi0Q=;
        b=Q9aSIurN86fYuWxUKwww2dUQZUsTI6vFkuQlTx9LMF9AL3LHeh+oor3Ai+EJfV8B7L
         jPXREGOsh4p1oVg6w1jKE6qUJbI9WN5cSKd5N1CDQ8Z6AP9ANXwhQdHasVOc83GHxYIW
         s4b6XQ+lWuks6HmD/grM+MvP0kJdPQnN9jBaN1WZO+KYnuF8VYZfCRnEyUiGhCtlGxDZ
         D9FvfI+qacbw+7VTbgfSq0XjiZKgO2zgWZ1huCi8OfhlRPcmSltNhOVnuqzf4QC+VyZA
         P4/+IXXa/FKndms2lbjAjP0/yYh7FNcjzaQFAhOyC+A/vhZ5t8bmowXzQ+cP719PPIUR
         7u3A==
X-Gm-Message-State: APjAAAULPLA2hJ1eXiVhC7wGshcvlutmmEuakKra4QxKLwrzri9a3aIR
        g83m2Ds85l66C/uZt02nqiYqdjpv
X-Google-Smtp-Source: APXvYqy5GBaznVSFbmisnhoTPnTrJS14/flvqCCKxU0dmgVfEr+7p+regu2XXFTAXkCO6JVVQu2LsA==
X-Received: by 2002:a19:7715:: with SMTP id s21mr1251273lfc.98.1569483752775;
        Thu, 26 Sep 2019 00:42:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k68sm254157lje.86.2019.09.26.00.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 00:42:32 -0700 (PDT)
Date:   Thu, 26 Sep 2019 00:42:32 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 07:42:27 GMT
Message-Id: <4c684be1794cd0c62cc19d9c9558981584ec3e9a.1569483748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.355.git.gitgitgadget@gmail.com>
References: <pull.355.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] stash: handle staged changes in skip-worktree files
 correctly
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

When calling `git stash` while changes were staged for files that are
marked with the `skip-worktree` bit (e.g. files that are excluded in a
sparse checkout), the files are recorded as _deleted_ instead.

The reason is that `git stash` tries to construct the tree reflecting
the worktree essentially by copying the index to a temporary one and
then updating the files from the worktree. Crucially, it calls `git
diff-index` to update also those files that are in the HEAD but have
been unstaged in the index.

However, when the temporary index is updated via `git update-index --add
--remove`, skip-worktree entries mark the files as deleted by mistake.

Let's use the newly-introduced `--ignore-skip-worktree-entries` option
of `git update-index` to prevent exactly this from happening.

Note that the regression test case deliberately avoids replicating the
scenario described above and instead tries to recreate just the symptom.

Reported by Dan Thompson.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c     |  5 +++--
 git-legacy-stash.sh |  3 ++-
 t/t3903-stash.sh    | 11 +++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index b5a301f24d..56f3b551e4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1082,8 +1082,9 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	}
 
 	cp_upd_index.git_cmd = 1;
-	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
-			 "--remove", "--stdin", NULL);
+	argv_array_pushl(&cp_upd_index.args, "update-index",
+			 "--ignore-skip-worktree-entries",
+			 "-z", "--add", "--remove", "--stdin", NULL);
 	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 
diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
index f60e9b3e87..5398a5161d 100755
--- a/git-legacy-stash.sh
+++ b/git-legacy-stash.sh
@@ -193,7 +193,8 @@ create_stash () {
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
 			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
-			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
+			git update-index --ignore-skip-worktree-entries \
+				-z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
 		) ) ||
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b8e337893f..1e977145b8 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1241,4 +1241,15 @@ test_expect_success 'stash --keep-index with file deleted in index does not resu
 	test_path_is_missing to-remove
 '
 
+test_expect_success 'stash handles skip-worktree entries nicely' '
+	test_commit A &&
+	echo changed >A.t &&
+	git add A.t &&
+	git update-index --skip-worktree A.t &&
+	rm A.t &&
+	git stash &&
+
+	git rev-parse --verify refs/stash:A.t
+'
+
 test_done
-- 
gitgitgadget
