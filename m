Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9C820248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCDPr0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:47:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34519 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDPr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:47:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id a15so3028329qkc.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 07:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jh6WUXk0RQjRFF6qwmgj/mHbci4nAH0pmeOUy1ND1Ww=;
        b=W48eLb5l8WNRfnOymxZxF952XVGT5YePi0Ngo3ntmNgnRD+ANj7HDtHRLTGMoPtHu1
         nxfPX/xuTQX5pJoikAPNRBdNG4YePi7oRxDROBz+A8ECAHPwy4O0MX7PIoJbBKXb+KWP
         2GVlQG7/Xar+zCMCiIcUMFPhOQp6N1HM/dV4V00Dg5yD6bj+GmxJ9HO9LksT+xe3R7UU
         GQPVjWVS+8ReO3M/quj70R+FUcuJytiGYx5RalUvQUAG+lScfdt7GSrmNkD3e9ikvESf
         hQaeHkUHQ6dd77L+HECkRRMmTu6Y2vF9a7c86B+wayPu6meUz3XesW35T0mTpmaVW2qX
         iAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jh6WUXk0RQjRFF6qwmgj/mHbci4nAH0pmeOUy1ND1Ww=;
        b=eUxWTYUeR7sTWwUXV1WLttjwhWW230yMObtyTRw4+r8EhuIJ/XTKUl/LFIEWuzb56+
         ET0GsuHJeBOzCt/UKEUthdVeMPxNQOGDFlhx+1/XE95V/fqxcFdVDL2lg/085IkDoH/s
         AnTr2OMnkNvnH7Ry41M8lEAiB6+LKYpjQBjpVkb8QHm9YM3EDIuuqF4WqanO/RtZ5VXH
         S+ywQAqF3ljB4NB3bFQ8AbCtDyCUeR97N2WgBPeeHmN8SEvpp74YJPb74ndnQkCHnZnG
         m5Qk5DcNIKUVpPhUYBr655GfTEkOP7Nd/dAoMCs94kN3014m6/8dtNRybUC9qBOfZ72F
         aVlg==
X-Gm-Message-State: APjAAAVgNWtg1E33Af+r9awfgxsXK9XZZrtWz5pI4ADgH9/f2tAelm3V
        ItK4YXSXPtZ8e2qhe6Uh83JkPxzHpOI=
X-Google-Smtp-Source: APXvYqxT8RuRuVYmCCFGPaLkGqQ1r16ET8OL0iY0GchBn81nPAH9HaiZ/YZ1Ao1oziBw0ICJrMH6fg==
X-Received: by 2002:ae9:dd04:: with SMTP id r4mr13502717qkf.187.1551714444901;
        Mon, 04 Mar 2019 07:47:24 -0800 (PST)
Received: from [10.124.100.9] ([66.210.32.226])
        by smtp.gmail.com with ESMTPSA id n14sm4480723qtk.97.2019.03.04.07.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:47:23 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [RFC PATCH 1/4] Add alias option to git branch
From:   Kenneth Cochran <kenneth.cochran101@gmail.com>
In-Reply-To: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
Date:   Mon, 4 Mar 2019 09:47:22 -0600
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D21A788-5E38-466F-B3CC-F6A5CBEB2E2E@gmail.com>
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
To:     Kenneth Cochran <kenneth.cochran101@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom 2f6409a39b24db826a22d2813ec8d5de46723500 Mon Sep 17 00:00:00 2001
From: Kenneth Cochran <kenneth.cochran101@gmail.com>
Date: Tue, 26 Feb 2019 04:41:22 -0600
Subject: [RFC PATCH 1/4] branch: add "--alias" option to create an alias
Cc: Sahil Dua <sahildua2305@gmail.com>,
    Duy Nguyen <pclouds@gmail.com>,
    Jeff King <peff@peff.net>

Often, people have to use long or unweildly branch names
e.g. `feature/<bug_number>`. When working locally, it's nice to be
able to refer to that by something more friendly. It's already possible
to do this, with `git symbolic-ref refs/heads/alias_name =
refs/heads/branch_name`
I see three problems with this current approach:
  1. Typing out "refs/heads/" is tedious and error prone
  2. git will willingly overwrite existing branch names
  3. Deleting a checked out symref leaves head in an invalid state.

This commit solves the first two of the above issues.
I've implemented this as a new option for git branch, since this seemed =
like the
best place for it. We'll still need additional work to improve how git =
handles
deleting checked out symrefs.

These changes were originally proposed by Phil Sainty, but it doesn't =
seem
like there was ever any discussion about it:
https://www.mail-archive.com/git@vger.kernel.org/msg161274.html

Reported-by: Phil Sainty <psainty@orcon.net.nz>
Signed-off-by: Kenneth Cochran <kenneth.cochran101@gmail.com>
---
 Documentation/git-branch.txt |  8 +++++
 builtin/branch.c             | 29 ++++++++++++++++--
 t/t3207-branch-alias.sh      | 58 ++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 2 deletions(-)
 create mode 100755 t/t3207-branch-alias.sh

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 3bd83a7cbd..0476c8567b 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-c | -C) [<oldbranch>] <newbranch>
+'git branch' --alias <aliasname> [<branchname>]
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
=20
@@ -69,6 +70,10 @@ The `-c` and `-C` options have the exact same =
semantics as `-m` and
 `-M`, except instead of the branch being renamed it along with its
 config and reflog will be copied to a new name.
=20
+With a `--alias` option, a symbolic ref with `<aliasname>` will be
+created. You may specify a branch to create the alias for. If one is
+not specified, the currently checked out branch is assumed.
+
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
@@ -124,6 +129,9 @@ OPTIONS
 -C::
 	Shortcut for `--copy --force`.
=20
+--alias::
+	Create an alias for a branch.
+
 --color[=3D<when>]::
 	Color branches to highlight current, local, and
 	remote-tracking branches.
diff --git a/builtin/branch.c b/builtin/branch.c
index 1be727209b..4b8b8fc08f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -547,6 +547,20 @@ static void copy_or_rename_branch(const char =
*oldname, const char *newname, int
 	strbuf_release(&newsection);
 }
=20
+static void create_branch_alias(const char* branch_name, const char* =
alias_name) {
+	struct strbuf branch_ref =3D STRBUF_INIT;
+	struct strbuf alias_ref =3D STRBUF_INIT;
+
+	if(!validate_branchname(branch_name, &branch_ref))
+		die(_("%s is not a valid branch"), branch_name);
+	validate_new_branchname(alias_name, &alias_ref, 0);
+	create_symref(alias_ref.buf, branch_ref.buf, "");
+
+	strbuf_release(&branch_ref);
+	strbuf_release(&alias_ref);
+	printf(_("%s created as an alias for %s\n"), alias_name, =
branch_name);
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
=20
 static int edit_branch_description(const char *branch_name)
@@ -580,7 +594,7 @@ static int edit_branch_description(const char =
*branch_name)
=20
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete =3D 0, rename =3D 0, copy =3D 0, force =3D 0, list =3D =
0;
+	int delete =3D 0, rename =3D 0, copy =3D 0, force =3D 0, list =3D =
0, alias =3D 0;
 	int reflog =3D 0, edit_description =3D 0;
 	int quiet =3D 0, unset_upstream =3D 0;
 	const char *new_upstream =3D NULL;
@@ -617,6 +631,7 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if =
not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch =
and its reflog"), 1),
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, =
even if target exists"), 2),
+		OPT_BOOL(0, "alias", &alias, N_("create an alias for a =
branch")),
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its =
reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if =
target exists"), 2),
 		OPT_BOOL('l', "list", &list, N_("list branch names")),
@@ -662,7 +677,8 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, =
builtin_branch_usage,
 			     0);
=20
-	if (!delete && !rename && !copy && !edit_description && =
!new_upstream && !unset_upstream && argc =3D=3D 0)
+	if (!delete && !rename && !copy && !edit_description && =
!new_upstream && !unset_upstream &&
+	    !alias && argc =3D=3D 0)
 		list =3D 1;
=20
 	if (filter.with_commit || filter.merge !=3D =
REF_FILTER_MERGED_NONE || filter.points_at.nr ||
@@ -762,6 +778,15 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 			copy_or_rename_branch(argv[0], argv[1], 0, =
rename > 1);
 		else
 			die(_("too many arguments for a rename =
operation"));
+	} else if (alias) {
+		if (!argc)
+			die(_("alias name required"));
+		else if (argc =3D=3D 1)
+			create_branch_alias(head, argv[0]);
+		else if (argc =3D=3D 2)
+			create_branch_alias(argv[1], argv[0]);
+		else
+			die(_("too many arguments for an alias =
operation"));
 	} else if (new_upstream) {
 		struct branch *branch =3D branch_get(argv[0]);
=20
diff --git a/t/t3207-branch-alias.sh b/t/t3207-branch-alias.sh
new file mode 100755
index 0000000000..9d4c8c2914
--- /dev/null
+++ b/t/t3207-branch-alias.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Amos Waterland
+#
+
+test_description=3D'git branch assorted tests'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'prepare a trivial repository' '
+	echo Hello >A &&
+	git update-index --add A &&
+	git commit -m "Initial commit." &&
+	echo World >>A &&
+	git update-index --add A &&
+	git commit -m "Second commit." &&
+	HEAD=3D$(git rev-parse --verify HEAD)
+'
+
+test_expect_success 'git branch --alias' '
+	test_must_fail git branch --alias
+'
+
+test_expect_success 'git branch --alias sym' '
+	echo "sym created as an alias for master" >expect &&
+	git branch --alias sym >actual &&
+	test_i18ncmp expect actual &&
+	echo $HEAD >expect &&
+	git rev-parse --verify sym >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'git branch --alias sym1 brnch' '
+	git branch brnch &&
+	echo "sym1 created as an alias for brnch" >expect &&
+	git branch --alias sym1 brnch >actual &&
+	test_i18ncmp expect actual &&
+	git rev-parse --verify brnch >expect &&
+	git rev-parse --verify sym1 >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'git branch --alias sym2 brnch2 third_arg' '
+	test_must_fail git branch --alias sym2 brnch2 third_arg
+'
+
+test_expect_success 'git branch --alias refuses to overwrite existing =
branch' '
+	git branch bre &&
+	test_must_fail git branch --alias bre
+'
+
+test_expect_success 'git branch --alias refuses to overwrite existing =
symref' '
+	git branch --alias syme &&
+	test_must_fail git branch --alias syme
+'
+
+test_done
--=20
2.17.1


