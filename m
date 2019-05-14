Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743711F461
	for <e@80x24.org>; Tue, 14 May 2019 11:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfENLWh (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:22:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35374 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfENLWg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:22:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so22356368edr.2
        for <git@vger.kernel.org>; Tue, 14 May 2019 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RN2ZtMnqN2hDdGfV8VdHKgJo+U2jIq62inOEejjroDI=;
        b=Hswfv79nXQngBPWU8atZwahH5JNT2MlV4DL3+iBR1o726i/lEob/ShLLeYVkP3+s4e
         D+TsQ2xkW9yaydwiOMnPm4CypFvicdm8mb7g6H9SbmXlkwkOoAj3Tb6W75xEujr8/O7s
         Uf238klXUU4mBi4SeYGYv+3LEf6VBtejaDmkdd3g3TTxVk4mJGTebUu/SswmKNEDxdVO
         RXOjd+HXyh8cYFS327prqzRPAv0W0fWL603Tm0sZH3uhgpmYHB6+TZQvW/XPrpa2eJ9v
         U8WU8C9YckKcC13YGIyYVEWSapiQ/Bz9OH3lMG5pG5QJJLqpFGcy7fpV5oC8m3qAosqk
         jhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RN2ZtMnqN2hDdGfV8VdHKgJo+U2jIq62inOEejjroDI=;
        b=FTrOxt7RRjhZFBJmwqgX1kwhftM8sV3sphQXNb3qb6G0AfpDnBTANQYOEFrqkwRRis
         lEG2E+zMdZ5tWh6bOSL7sZz7jaFqWECY5Y6piqQq+3w2EhAr0CynxpTPGBLLFUtKuC/K
         PzNL4Uy5Ryn44lNTXGTp0/fiaYRuoX+9/F1HJfperUvpHTV3xL9MTUtxu8EAdtAzS0N7
         RvKfe3kmSoXOGcFs1H/JZv0QWsH1K1oMbG5QU6cAtcM+o/HMyfeaZkohOQnKcT72zfo/
         mxqaHZmivNv1DxfXMxMKu7LG4+8y+YYl+7eEEDB336jqmluACA7yrxs/x2ZabmYrI9E6
         yh9A==
X-Gm-Message-State: APjAAAWKScpK1JCsnZ7PPKOtegLFfXU7UNjes2wQKp6y8/IgFpZDkYld
        Uo/rrAjS4JlwnHi3lIdm9bmvs65F
X-Google-Smtp-Source: APXvYqwcE7kIJTXC+fOomz+bdjn0thcK8j4/kJaXw4QbzjX25ldT0kY1AuGcE/g/RGEQA2ZLmM/0AQ==
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr16434653ejv.109.1557832954617;
        Tue, 14 May 2019 04:22:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm4391476edf.89.2019.05.14.04.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 04:22:34 -0700 (PDT)
Date:   Tue, 14 May 2019 04:22:34 -0700 (PDT)
X-Google-Original-Date: Tue, 14 May 2019 11:22:29 GMT
Message-Id: <70af172e052e62abbf767c21b7d90d70bd69dbbb.1557832949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.194.git.gitgitgadget@gmail.com>
References: <pull.194.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/5] rebase: fold git-rebase--common into the -p backend
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

The only remaining scripted part of `git rebase` is the
`--preserve-merges` backend. Meaning: there is little reason to keep the
"library of common rebase functions" as a separate file.

While moving the functions to `git-rebase--preserve-merges.sh`, we also
drop the `move_to_original_branch` function that is no longer used.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                     |  1 -
 Makefile                       |  1 -
 builtin/rebase.c               |  3 +-
 git-rebase--common.sh          | 69 ----------------------------------
 git-rebase--preserve-merges.sh | 55 +++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 73 deletions(-)
 delete mode 100644 git-rebase--common.sh

diff --git a/.gitignore b/.gitignore
index bcee4fda81..4470d7cfc0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -122,7 +122,6 @@
 /git-range-diff
 /git-read-tree
 /git-rebase
-/git-rebase--common
 /git-rebase--preserve-merges
 /git-receive-pack
 /git-reflog
diff --git a/Makefile b/Makefile
index 9370d85ff3..9fc617e38f 100644
--- a/Makefile
+++ b/Makefile
@@ -624,7 +624,6 @@ SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
-SCRIPT_LIB += git-rebase--common
 SCRIPT_LIB += git-rebase--preserve-merges
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d5f6f403e2..9c52144fc4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1163,8 +1163,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	}
 
 	strbuf_addf(&script_snippet,
-		    ". git-sh-setup && . git-rebase--common &&"
-		    " . %s && %s", backend, backend_func);
+		    ". git-sh-setup && . %s && %s", backend, backend_func);
 	argv[0] = script_snippet.buf;
 
 	status = run_command_v_opt(argv, RUN_USING_SHELL);
diff --git a/git-rebase--common.sh b/git-rebase--common.sh
deleted file mode 100644
index f00e13e5d0..0000000000
--- a/git-rebase--common.sh
+++ /dev/null
@@ -1,69 +0,0 @@
-
-resolvemsg="
-$(gettext 'Resolve all conflicts manually, mark them as resolved with
-"git add/rm <conflicted_files>", then run "git rebase --continue".
-You can instead skip this commit: run "git rebase --skip".
-To abort and get back to the state before "git rebase", run "git rebase --abort".')
-"
-
-write_basic_state () {
-	echo "$head_name" > "$state_dir"/head-name &&
-	echo "$onto" > "$state_dir"/onto &&
-	echo "$orig_head" > "$state_dir"/orig-head &&
-	test t = "$GIT_QUIET" && : > "$state_dir"/quiet
-	test t = "$verbose" && : > "$state_dir"/verbose
-	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
-	test -n "$strategy_opts" && echo "$strategy_opts" > \
-		"$state_dir"/strategy_opts
-	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
-		"$state_dir"/allow_rerere_autoupdate
-	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
-	test -n "$signoff" && echo "$signoff" >"$state_dir"/signoff
-	test -n "$reschedule_failed_exec" && : > "$state_dir"/reschedule-failed-exec
-}
-
-apply_autostash () {
-	if test -f "$state_dir/autostash"
-	then
-		stash_sha1=$(cat "$state_dir/autostash")
-		if git stash apply $stash_sha1 >/dev/null 2>&1
-		then
-			echo "$(gettext 'Applied autostash.')" >&2
-		else
-			git stash store -m "autostash" -q $stash_sha1 ||
-			die "$(eval_gettext "Cannot store \$stash_sha1")"
-			gettext 'Applying autostash resulted in conflicts.
-Your changes are safe in the stash.
-You can run "git stash pop" or "git stash drop" at any time.
-' >&2
-		fi
-	fi
-}
-
-move_to_original_branch () {
-	case "$head_name" in
-	refs/*)
-		message="rebase finished: $head_name onto $onto"
-		git update-ref -m "$message" \
-			$head_name $(git rev-parse HEAD) $orig_head &&
-		git symbolic-ref \
-			-m "rebase finished: returning to $head_name" \
-			HEAD $head_name ||
-		die "$(eval_gettext "Could not move back to \$head_name")"
-		;;
-	esac
-}
-
-output () {
-	case "$verbose" in
-	'')
-		output=$("$@" 2>&1 )
-		status=$?
-		test $status != 0 && printf "%s\n" "$output"
-		return $status
-		;;
-	*)
-		"$@"
-		;;
-	esac
-}
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index afbb65765d..dec90e9af6 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -77,6 +77,61 @@ rewritten_pending="$state_dir"/rewritten-pending
 # and leaves CR at the end instead.
 cr=$(printf "\015")
 
+resolvemsg="
+$(gettext 'Resolve all conflicts manually, mark them as resolved with
+"git add/rm <conflicted_files>", then run "git rebase --continue".
+You can instead skip this commit: run "git rebase --skip".
+To abort and get back to the state before "git rebase", run "git rebase --abort".')
+"
+
+write_basic_state () {
+	echo "$head_name" > "$state_dir"/head-name &&
+	echo "$onto" > "$state_dir"/onto &&
+	echo "$orig_head" > "$state_dir"/orig-head &&
+	test t = "$GIT_QUIET" && : > "$state_dir"/quiet
+	test t = "$verbose" && : > "$state_dir"/verbose
+	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
+	test -n "$strategy_opts" && echo "$strategy_opts" > \
+		"$state_dir"/strategy_opts
+	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
+		"$state_dir"/allow_rerere_autoupdate
+	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
+	test -n "$signoff" && echo "$signoff" >"$state_dir"/signoff
+	test -n "$reschedule_failed_exec" && : > "$state_dir"/reschedule-failed-exec
+}
+
+apply_autostash () {
+	if test -f "$state_dir/autostash"
+	then
+		stash_sha1=$(cat "$state_dir/autostash")
+		if git stash apply $stash_sha1 >/dev/null 2>&1
+		then
+			echo "$(gettext 'Applied autostash.')" >&2
+		else
+			git stash store -m "autostash" -q $stash_sha1 ||
+			die "$(eval_gettext "Cannot store \$stash_sha1")"
+			gettext 'Applying autostash resulted in conflicts.
+Your changes are safe in the stash.
+You can run "git stash pop" or "git stash drop" at any time.
+' >&2
+		fi
+	fi
+}
+
+output () {
+	case "$verbose" in
+	'')
+		output=$("$@" 2>&1 )
+		status=$?
+		test $status != 0 && printf "%s\n" "$output"
+		return $status
+		;;
+	*)
+		"$@"
+		;;
+	esac
+}
+
 strategy_args=${strategy:+--strategy=$strategy}
 test -n "$strategy_opts" &&
 eval '
-- 
gitgitgadget
