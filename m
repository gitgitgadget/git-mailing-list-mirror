Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E119520248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCHJ6W (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35384 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHJ6W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so13794808pfa.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Din4QJ2Mm5FGcSFb3hDmSH+VEkqp4Uw3/voNSBEgY8I=;
        b=d4dyXh7kbsRWAG7INpQrXzaJwDZ5/saGBAgOaz14wY7+jpPxaMiancQWDYSItlSv5D
         2fO6FPQucG9aB5rQpP0pfdUhDFgmm8xpcIuwVGjd0a8gf3ktU7i4+Ocy/O3boP+kjOCw
         eZhtAXH08+rZEgLG4Ui4sxnVAb3tkI14owEPPCFDGAljm7CCdU9idZy+gkMtS6cE0nSM
         Q6CmvM+7KSJvaPo2zPCM5V0Yw3Rj3yJSLOh7H5ltCZBg5oyzIQ4CRq7BNRirJYLd93cL
         rRS/p8V6gUSLpv0i+AjDBQABfkdugaFXt8LF5zpj9qpirD7YCswlswKoZktPdY423FBU
         BkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Din4QJ2Mm5FGcSFb3hDmSH+VEkqp4Uw3/voNSBEgY8I=;
        b=W9DfsZQ3SSC83cMJ4Q+LMY6NKCDWZfQ5o1e4C252xYUHz/NGZEF5unsLBQnbD2VVoL
         xgUK8iRm84mRaIfYsm8H2umLqkeFnoH1o8nPLFcHpeao7qK0Bl9KTJKmopexEddgs548
         GnrKJVnORZ/99pvo3HHPMa25rHDierA8Cq7UGriK4RS2frzevEHNLwZRMaNN9swNuRmf
         zeEgLfAttLkQAY28TKSx7jVZkcMlHFfUhdyV2EtuVRyF9X+UYDfXRm0EvQdx8890yro5
         36qoq8E4E9k3EZKjL1jK9XG5IEeSoLubf5VOFCVSlyBkAkR7m2A2/6iJmKashEc+LxMM
         CE2A==
X-Gm-Message-State: APjAAAWtsc41b8yXG//vRjZP2OgBEzjPHQpNnCitUatNh0NTh3phEQiT
        P8G4FnoacYI1ae4X6G58fsI=
X-Google-Smtp-Source: APXvYqxM6qw1UwTDH5083CqqVXL+DYUs+K70c1dLD30QNymcm3Dfb8pCREBiAPtLuBAp3B/zHPTQ8g==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr15512815pge.79.1552039101503;
        Fri, 08 Mar 2019 01:58:21 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id h11sm8491655pgq.57.2019.03.08.01.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:58:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:58:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 04/21] git-checkout.txt: fix monospace typeset
Date:   Fri,  8 Mar 2019 16:57:35 +0700
Message-Id: <20190308095752.8574-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/git-checkout.txt | 60 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 5280d1f9ed..1b9d689933 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -24,14 +24,14 @@ also update `HEAD` to set the specified branch as the current
 branch.
 
 'git checkout' [<branch>]::
-	To prepare for working on <branch>, switch to it by updating
+	To prepare for working on `<branch>`, switch to it by updating
 	the index and the files in the working tree, and by pointing
 	HEAD at the branch. Local modifications to the files in the
 	working tree are kept, so that they can be committed to the
-	<branch>.
+	`<branch>`.
 +
-If <branch> is not found but there does exist a tracking branch in
-exactly one remote (call it <remote>) with a matching name, treat as
+If `<branch>` is not found but there does exist a tracking branch in
+exactly one remote (call it `<remote>`) with a matching name, treat as
 equivalent to
 +
 ------------
@@ -47,7 +47,7 @@ branches from there if `<branch>` is ambiguous but exists on the
 'origin' remote. See also `checkout.defaultRemote` in
 linkgit:git-config[1].
 +
-You could omit <branch>, in which case the command degenerates to
+You could omit `<branch>`, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
 if exists, for the current branch.
@@ -61,7 +61,7 @@ if exists, for the current branch.
 	`--track` without `-b` implies branch creation; see the
 	description of `--track` below.
 +
-If `-B` is given, <new_branch> is created if it doesn't exist; otherwise, it
+If `-B` is given, `<new_branch>` is created if it doesn't exist; otherwise, it
 is reset. This is the transactional equivalent of
 +
 ------------
@@ -75,25 +75,25 @@ successful.
 'git checkout' --detach [<branch>]::
 'git checkout' [--detach] <commit>::
 
-	Prepare to work on top of <commit>, by detaching HEAD at it
+	Prepare to work on top of `<commit>`, by detaching HEAD at it
 	(see "DETACHED HEAD" section), and updating the index and the
 	files in the working tree.  Local modifications to the files
 	in the working tree are kept, so that the resulting working
 	tree will be the state recorded in the commit plus the local
 	modifications.
 +
-When the <commit> argument is a branch name, the `--detach` option can
+When the `<commit>` argument is a branch name, the `--detach` option can
 be used to detach HEAD at the tip of the branch (`git checkout
-<branch>` would check out that branch without detaching HEAD).
+`<branch>`` would check out that branch without detaching HEAD).
 +
-Omitting <branch> detaches HEAD at the tip of the current branch.
+Omitting `<branch>` detaches HEAD at the tip of the current branch.
 
 'git checkout' [<tree-ish>] [--] <pathspec>...::
 
 	Overwrite paths in the working tree by replacing with the
-	contents in the index or in the <tree-ish> (most often a
-	commit).  When a <tree-ish> is given, the paths that
-	match the <pathspec> are updated both in the index and in
+	contents in the index or in the `<tree-ish>` (most often a
+	commit).  When a `<tree-ish>` is given, the paths that
+	match the `<pathspec>` are updated both in the index and in
 	the working tree.
 +
 The index may contain unmerged entries because of a previous failed merge.
@@ -155,12 +155,12 @@ on your side branch as `theirs` (i.e. "one contributor's work on top
 of it").
 
 -b <new_branch>::
-	Create a new branch named <new_branch> and start it at
-	<start_point>; see linkgit:git-branch[1] for details.
+	Create a new branch named `<new_branch>` and start it at
+	`<start_point>`; see linkgit:git-branch[1] for details.
 
 -B <new_branch>::
-	Creates the branch <new_branch> and start it at <start_point>;
-	if it already exists, then reset it to <start_point>. This is
+	Creates the branch `<new_branch>` and start it at `<start_point>`;
+	if it already exists, then reset it to `<start_point>`. This is
 	equivalent to running "git branch" with "-f"; see
 	linkgit:git-branch[1] for details.
 
@@ -191,19 +191,19 @@ explicitly give a name with `-b` in such a case.
 	Rather than checking out a branch to work on it, check out a
 	commit for inspection and discardable experiments.
 	This is the default behavior of "git checkout <commit>" when
-	<commit> is not a branch name.  See the "DETACHED HEAD" section
+	`<commit>` is not a branch name.  See the "DETACHED HEAD" section
 	below for details.
 
 --orphan <new_branch>::
-	Create a new 'orphan' branch, named <new_branch>, started from
-	<start_point> and switch to it.  The first commit made on this
+	Create a new 'orphan' branch, named `<new_branch>`, started from
+	`<start_point>` and switch to it.  The first commit made on this
 	new branch will have no parents and it will be the root of a new
 	history totally disconnected from all the other branches and
 	commits.
 +
 The index and the working tree are adjusted as if you had previously run
 "git checkout <start_point>".  This allows you to start a new history
-that records a set of paths similar to <start_point> by easily running
+that records a set of paths similar to `<start_point>` by easily running
 "git commit -a" to make the root commit.
 +
 This can be useful when you want to publish the tree from a commit
@@ -213,7 +213,7 @@ whose full history contains proprietary or otherwise encumbered bits of
 code.
 +
 If you want to start a disconnected history that records a set of paths
-that is totally different from the one of <start_point>, then you should
+that is totally different from the one of `<start_point>`, then you should
 clear the index and the working tree right after creating the orphan
 branch by running "git rm -rf ." from the top level of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating the
@@ -221,9 +221,9 @@ working tree, by copying them from elsewhere, extracting a tarball, etc.
 
 --ignore-skip-worktree-bits::
 	In sparse checkout mode, `git checkout -- <paths>` would
-	update only entries matched by <paths> and sparse patterns
+	update only entries matched by `<paths>` and sparse patterns
 	in $GIT_DIR/info/sparse-checkout. This option ignores
-	the sparse patterns and adds back any files in <paths>.
+	the sparse patterns and adds back any files in `<paths>`.
 
 -m::
 --merge::
@@ -254,9 +254,9 @@ the conflicted merge in the specified paths.
 -p::
 --patch::
 	Interactively select hunks in the difference between the
-	<tree-ish> (or the index, if unspecified) and the working
+	`<tree-ish>` (or the index, if unspecified) and the working
 	tree.  The chosen hunks are then applied in reverse to the
-	working tree (and if a <tree-ish> was specified, the index).
+	working tree (and if a `<tree-ish>` was specified, the index).
 +
 This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
@@ -279,10 +279,10 @@ Note that this option uses the no overlay mode by default (see also
 
 --recurse-submodules::
 --no-recurse-submodules::
-	Using --recurse-submodules will update the content of all initialized
+	Using `--recurse-submodules` will update the content of all initialized
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
-	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
+	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
 	is used, the work trees of submodules will not be updated.
 	Just like linkgit:git-submodule[1], this will detach the
 	submodules HEAD.
@@ -296,8 +296,8 @@ Note that this option uses the no overlay mode by default (see also
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
 	specifying `--no-overlay`, files that appear in the index and
-	working tree, but not in <tree-ish> are removed, to make them
-	match <tree-ish> exactly.
+	working tree, but not in `<tree-ish>` are removed, to make them
+	match `<tree-ish>` exactly.
 
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
-- 
2.21.0.rc1.337.gdf7f8d0522

