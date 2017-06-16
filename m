Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4BC20401
	for <e@80x24.org>; Fri, 16 Jun 2017 04:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbdFPEbG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 00:31:06 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34986 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdFPEbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 00:31:05 -0400
Received: by mail-io0-f196.google.com with SMTP id f79so3466700ioi.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 21:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cSmahH+6ZY7j9Ja0pbOB3pWK5fKpOJd5dqoVSFfSolA=;
        b=M47RcgfIP4pHGw42MwcT7/qN/X3f/hNc5chXKBVnki3ryO9VCXfU4Oe+B/mdM3/MUC
         kd9qJ8H5pG39K+L9b6kmhCUpDMz409FUJVS7qswWqOQ7edxFfr6NrO2KxwAv0ZwLvxyr
         5LHgjoqEocwLCBuw7169yOndAePcpwnceCERVkS8U3Q4yYphLJs4oPGBgxMFk0O5PEbG
         NmbFxd57+GcAys06FAsiqpvN7q6dbBrkUdr8XdBASCOW2i0XbbHN0qeZlWxf7omZcUHu
         RTYiF7mS9V/NCD/BGnhsfgH0ExGkyci7JsQIxtBF6tj9jrdkJNX4lmc3fmpufhi+bH9w
         fXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cSmahH+6ZY7j9Ja0pbOB3pWK5fKpOJd5dqoVSFfSolA=;
        b=SKdb1DT0PT5ktJLm6KaWvs5lQe/aecEYonGsaaFDzHHQpHAN/MbHKjzKFZw17XoUDQ
         pNeLiJR6YN/kvdSEkEX+6u026z0vrULqobf7aLHbPYisSmz77l/3SjPgMh35vy3plGnF
         7M4l2+RRcj6ig1oTaBGK/08gs7/yRnyncgFBeYBGpUgF4gUOVIJNttg1FvePA6UQXZrf
         iv5qad3zs7Wi8zIBf9/kPHAiOnOAQOfNtCNH8awhdBNq002TpQPcZf8A6uwwvwgZolaV
         95Bl1o7QrKcFS6dExYcslAg6Q7OrTVashe9dR32JNfN44x1RomMLHu/+kvYREkO8sk+S
         hOIQ==
X-Gm-Message-State: AKS2vOxv2bFhE09HocLaWIbLaNj/+bNNJgZjMZkhU0Bxkn/Xz+UQjbFh
        KqZgcpBo9mM363re2UY=
X-Received: by 10.107.131.104 with SMTP id f101mr8098296iod.40.1497587464351;
        Thu, 15 Jun 2017 21:31:04 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p22sm627405iod.22.2017.06.15.21.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 21:31:03 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, houstonfortney@gmail.com, kostix+git@007spb.ru,
        peff@peff.net, sxlijin@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 1/3] stash: update documentation to use 'stash entries'
Date:   Fri, 16 Jun 2017 00:30:48 -0400
Message-Id: <20170616043050.29192-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170616043050.29192-1-liambeguin@gmail.com>
References: <20170616043050.29192-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the time, a 'stash entry' is called a 'stash'
or a 'stash state'. Lets use 'stash entry' instead.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/config.txt     |  6 +++---
 Documentation/git-pull.txt   |  2 +-
 Documentation/git-rebase.txt |  2 +-
 Documentation/git-stash.txt  | 49 ++++++++++++++++++++++----------------------
 Documentation/gitcli.txt     |  2 +-
 git-stash.sh                 |  6 +++---
 6 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f6278a5ae6a1..23b807065d92 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2620,7 +2620,7 @@ rebase.autoSquash::
 	If set to true enable `--autosquash` option by default.
 
 rebase.autoStash::
-	When set to true, automatically create a temporary stash
+	When set to true, automatically create a temporary stash entry
 	before the operation begins, and apply it after the operation
 	ends.  This means that you can run rebase on a dirty worktree.
 	However, use with care: the final stash application after a
@@ -3029,12 +3029,12 @@ status.submoduleSummary::
 
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
-	option will show the stash in patch form.  Defaults to false.
+	option will show the stash entry in patch form.  Defaults to false.
 	See description of 'show' command in linkgit:git-stash[1].
 
 stash.showStat::
 	If this is set to true, the `git stash show` command without an
-	option will show diffstat of the stash.  Defaults to true.
+	option will show diffstat of the stash entry.  Defaults to true.
 	See description of 'show' command in linkgit:git-stash[1].
 
 submodule.<name>.url::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e414185f5a6a..9db5e08f4a63 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -131,7 +131,7 @@ unless you have read linkgit:git-rebase[1] carefully.
 --autostash::
 --no-autostash::
 	Before starting rebase, stash local modifications away (see
-	linkgit:git-stash[1]) if needed, and apply the stash when
+	linkgit:git-stash[1]) if needed, and apply the stash entry when
 	done. `--no-autostash` is useful to override the `rebase.autoStash`
 	configuration variable (see linkgit:git-config[1]).
 +
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 53f4e144444a..a5afd602d8eb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -446,7 +446,7 @@ used to override and disable this setting.
 
 --autostash::
 --no-autostash::
-	Automatically create a temporary stash before the operation
+	Automatically create a temporary stash entry before the operation
 	begins, and apply it after the operation ends.  This means
 	that you can run rebase on a dirty worktree.  However, use
 	with care: the final stash application after a successful
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 70191d06b69e..59979ad31dfe 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -51,18 +51,18 @@ OPTIONS
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
-	Save your local modifications to a new 'stash' and roll them
+	Save your local modifications to a new 'stash entry' and roll them
 	back to HEAD (in the working tree and in the index).
 	The <message> part is optional and gives
 	the description along with the stashed state.
 +
 For quickly making a snapshot, you can omit "push".  In this mode,
 non-option arguments are not allowed to prevent a misspelled
-subcommand from making an unwanted stash.  The two exceptions to this
+subcommand from making an unwanted entry.  The two exceptions to this
 are `stash -p` which acts as alias for `stash push -p` and pathspecs,
 which are allowed after a double hyphen `--` for disambiguation.
 +
-When pathspec is given to 'git stash push', the new stash records the
+When pathspec is given to 'git stash push', the new stash entry records the
 modified states only for the files that match the pathspec.  The index
 entries and working tree files are then rolled back to the state in
 HEAD only for these files, too, leaving files that do not match the
@@ -89,10 +89,10 @@ The `--patch` option implies `--keep-index`.  You can use
 
 list [<options>]::
 
-	List the stashes that you currently have.  Each 'stash' is listed
-	with its name (e.g. `stash@{0}` is the latest stash, `stash@{1}` is
+	List the stash entries that you currently have.  Each 'stash entry' is
+	listed with its name (e.g. `stash@{0}` is the latest entry, `stash@{1}` is
 	the one before, etc.), the name of the branch that was current when the
-	stash was made, and a short description of the commit the stash was
+	entry was made, and a short description of the commit the entry was
 	based on.
 +
 ----------------------------------------------------------------
@@ -105,11 +105,11 @@ command to control what is shown and how. See linkgit:git-log[1].
 
 show [<stash>]::
 
-	Show the changes recorded in the stash as a diff between the
-	stashed state and its original parent. When no `<stash>` is given,
+	Show the changes recorded in the stash entry as a diff between the
+	stashed entry and its original parent. When no `<stash>` is given, it
 	shows the latest one. By default, the command shows the diffstat, but
 	it will accept any format known to 'git diff' (e.g., `git stash show
-	-p stash@{1}` to view the second most recent stash in patch form).
+	-p stash@{1}` to view the second most recent entry in patch form).
 	You can use stash.showStat and/or stash.showPatch config variables
 	to change the default behavior.
 
@@ -149,26 +149,27 @@ branch <branchname> [<stash>]::
 +
 This is useful if the branch on which you ran `git stash save` has
 changed enough that `git stash apply` fails due to conflicts. Since
-the stash is applied on top of the commit that was HEAD at the time
-`git stash` was run, it restores the originally stashed state with
-no conflicts.
+the stash entry is applied on top of the commit that was HEAD at the
+time `git stash` was run, it restores the originally stashed entry
+with no conflicts.
 
 clear::
-	Remove all the stashed states. Note that those states will then
+	Remove all the stashed entries. Note that those entries will then
 	be subject to pruning, and may be impossible to recover (see
 	'Examples' below for a possible strategy).
 
 drop [-q|--quiet] [<stash>]::
 
-	Remove a single stashed state from the stash list. When no `<stash>`
+	Remove a single stashed entry from the stash list. When no `<stash>`
 	is given, it removes the latest one. i.e. `stash@{0}`, otherwise
 	`<stash>` must be a valid stash log reference of the form
 	`stash@{<revision>}`.
 
 create::
 
-	Create a stash (which is a regular commit object) and return its
-	object name, without storing it anywhere in the ref namespace.
+	Create a stash entry (which is a regular commit object) and
+	return its object name, without storing it anywhere in the ref
+	namespace.
 	This is intended to be useful for scripts.  It is probably not
 	the command you want to use; see "save" above.
 
@@ -182,10 +183,10 @@ store::
 DISCUSSION
 ----------
 
-A stash is represented as a commit whose tree records the state of the
-working directory, and its first parent is the commit at `HEAD` when
-the stash was created.  The tree of the second parent records the
-state of the index when the stash is made, and it is made a child of
+A stash entry is represented as a commit whose tree records the state
+of the working directory, and its first parent is the commit at `HEAD`
+when the entry was created.  The tree of the second parent records the
+state of the index when the entry is made, and it is made a child of
 the `HEAD` commit.  The ancestry graph looks like this:
 
             .----W
@@ -269,12 +270,12 @@ $ edit/build/test remaining parts
 $ git commit foo -m 'Remaining parts'
 ----------------------------------------------------------------
 
-Recovering stashes that were cleared/dropped erroneously::
+Recovering stash entries that were cleared/dropped erroneously::
 
-If you mistakenly drop or clear stashes, they cannot be recovered
+If you mistakenly drop or clear stash entries, they cannot be recovered
 through the normal safety mechanisms.  However, you can try the
-following incantation to get a list of stashes that are still in your
-repository, but not reachable any more:
+following incantation to get a list of stash entries that are still in
+your repository, but not reachable any more:
 +
 ----------------------------------------------------------------
 git fsck --unreachable |
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index dfe7d8372723..9f13266a6851 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -194,7 +194,7 @@ different things.
  * The `--index` option is used to ask a command that
    usually works on files in the working tree to *also*
    affect the index.  For example, `git stash apply` usually
-   merges changes recorded in a stash to the working tree,
+   merges changes recorded in a stash entry to the working tree,
    but with the `--index` option, it also merges changes to
    the index as well.
 
diff --git a/git-stash.sh b/git-stash.sh
index 2fb651b2b8d9..0dfa4785f361 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -481,7 +481,7 @@ parse_flags_and_rev()
 
 	case $# in
 		0)
-			have_stash || die "$(gettext "No stash found.")"
+			have_stash || die "$(gettext "No stash entry found.")"
 			set -- ${ref_stash}@{0}
 		;;
 		1)
@@ -573,7 +573,7 @@ apply_stash () {
 		GIT_INDEX_FILE="$TMPindex" git-read-tree "$u_tree" &&
 		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
 		rm -f "$TMPindex" ||
-		die "$(gettext "Could not restore untracked files from stash")"
+		die "$(gettext "Could not restore untracked files from stash entry")"
 	fi
 
 	eval "
@@ -627,7 +627,7 @@ pop_stash() {
 		drop_stash "$@"
 	else
 		status=$?
-		say "$(gettext "The stash is kept in case you need it again.")"
+		say "$(gettext "The stash entry is kept in case you need it again.")"
 		exit $status
 	fi
 }
-- 
2.9.4

