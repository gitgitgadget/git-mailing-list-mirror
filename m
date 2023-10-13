Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC881B29E
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESyUSX8t"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE6C2
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:33:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so3992061a12.1
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697211230; x=1697816030; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmaSFk07szfFH3EeIj7VOmRnL3KuJE2DL/rNmUXGIg8=;
        b=ESyUSX8trFz01pKObuSWfOhSp3Yho+whWpIE7BkZwttXUfc3eGsHuCeZwKc+l5q6SC
         dryFE9hZ+gGK5rf+IOu02sfoAaxLZu0GdFshmwrRWIQ/MFsYXtFDBznAidextrXXDQ7V
         ec5CTxYc0qqT/9I0XxngK2tHAXh1R7xltk3cuzp9WwFJpLtBIW+gDMEgqt9Tyui9TSoW
         xXtwGruaWFKB+lCa9eL8LarZR9TB2Y1IucoxCzZD7PzGEaWacVeXysIn4e7KD4ODk02W
         GwUSeDjnKlh4Jk2G4qSWGOyBQS409tdFQ4PWRNp1LfLuvn5AfUaiSRGNwHq6RJRm801N
         iLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211230; x=1697816030;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmaSFk07szfFH3EeIj7VOmRnL3KuJE2DL/rNmUXGIg8=;
        b=dqn12dUdeDjHDyGG+dsXb79RaM6dPRrR9mWsNcKaASEyqyXyrm9I4B0Z68D6xmDm0m
         gVp0yDHV38pLW9xSfqSzgkxdBDtGa4HukTVULogNf0ckxNBtTsY/ZNdW4p9KgDiUGmwc
         nQDaTa2+EHSbwaTkP6QwVhzqjqsAQn0q1wEyuplel/+mqy3JfrxBY/OQgZCD6/10RBSF
         G5ZgAJKh5h7ol1NGegDN2Y9U7+Km7T8lmf9oCu35aLwyzd3qGrScfQJb1oomtwopZAcq
         Y1A3t6STEIjvvm5CX/aeknQpvBJWE9RLkuoNCQxtds3a80+4mqVxP/TTiWa+Y+TzdwqB
         XcZg==
X-Gm-Message-State: AOJu0YyXRAxU4VZFUVCVO3+9ja6iHz8C2O6o//7lglxnDjPnsxe71qE1
	cFKkZfEz0DrNhWeIQ0k0HPzaXL1o+8U=
X-Google-Smtp-Source: AGHT+IG3twQ5lY+xbf5lrs2F3rT2tHh5X0LQN3QyHztpvUUiADmoEUaLGBNfDPuvj5uBXmLBaZ+nLw==
X-Received: by 2002:a17:907:7d90:b0:9bd:fa48:83c5 with SMTP id oz16-20020a1709077d9000b009bdfa4883c5mr840644ejc.70.1697211230474;
        Fri, 13 Oct 2023 08:33:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b0040596352951sm453102wms.5.2023.10.13.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:33:50 -0700 (PDT)
Message-ID: <91e4ad3984147fcc277254a3f6836bf79f5c9550.1697211227.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com>
References: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com>
From: "Isoken June Ibizugbe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Oct 2023 15:33:47 +0000
Subject: [PATCH 2/2] branch.c: adjust error messages to coding guidelines
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Isoken June Ibizugbe <isokenjune@gmail.com>,
    Isoken June Ibizugbe <isokenjune@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Isoken June Ibizugbe <isokenjune@gmail.com>

Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
---
 builtin/branch.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a756543d644..e7ee9bd0f15 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -173,11 +173,11 @@ static int branch_merged(int kind, const char *name,
 	    (head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0) != merged) {
 		if (merged)
 			warning(_("deleting branch '%s' that has been merged to\n"
-				"         '%s', but not yet merged to HEAD."),
+				"         '%s', but not yet merged to HEAD"),
 				name, reference_name);
 		else
 			warning(_("not deleting branch '%s' that is not yet merged to\n"
-				"         '%s', even though it is merged to HEAD."),
+				"         '%s', even though it is merged to HEAD"),
 				name, reference_name);
 	}
 	free(reference_name_to_free);
@@ -190,13 +190,13 @@ static int check_branch_commit(const char *branchname, const char *refname,
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
-		error(_("Couldn't look up commit object for '%s'"), refname);
+		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("The branch '%s' is not fully merged.\n"
+		error(_("the branch '%s' is not fully merged.\n"
 		      "If you are sure you want to delete it, "
-		      "run 'git branch -D %s'."), branchname, branchname);
+		      "run 'git branch -D %s'"), branchname, branchname);
 		return -1;
 	}
 	return 0;
@@ -207,7 +207,7 @@ static void delete_branch_config(const char *branchname)
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "branch.%s", branchname);
 	if (git_config_rename_section(buf.buf, NULL) < 0)
-		warning(_("Update of config-file failed"));
+		warning(_("update of config-file failed"));
 	strbuf_release(&buf);
 }
 
@@ -260,7 +260,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		if (kinds == FILTER_REFS_BRANCHES) {
 			const char *path;
 			if ((path = branch_checked_out(name))) {
-				error(_("Cannot delete branch '%s' "
+				error(_("cannot delete branch '%s' "
 					"used by worktree at '%s'"),
 				      bname.buf, path);
 				ret = 1;
@@ -275,7 +275,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					&oid, &flags);
 		if (!target) {
 			if (remote_branch) {
-				error(_("remote-tracking branch '%s' not found."), bname.buf);
+				error(_("remote-tracking branch '%s' not found"), bname.buf);
 			} else {
 				char *virtual_name = mkpathdup(fmt_remotes, bname.buf);
 				char *virtual_target = resolve_refdup(virtual_name,
@@ -290,7 +290,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 						"Did you forget --remote?"),
 						bname.buf);
 				else
-					error(_("branch '%s' not found."), bname.buf);
+					error(_("branch '%s' not found"), bname.buf);
 				FREE_AND_NULL(virtual_target);
 			}
 			ret = 1;
@@ -630,17 +630,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	if (recovery) {
 		if (copy)
-			warning(_("Created a copy of a misnamed branch '%s'"),
+			warning(_("created a copy of a misnamed branch '%s'"),
 				interpreted_oldname);
 		else
-			warning(_("Renamed a misnamed branch '%s' away"),
+			warning(_("renamed a misnamed branch '%s' away"),
 				interpreted_oldname);
 	}
 
 	if (!copy && (oldref_usage & IS_HEAD) &&
 	    replace_each_worktree_head_symref(worktrees, oldref.buf, newref.buf,
 					      logmsg.buf))
-		die(_("branch renamed to %s, but HEAD is not updated!"), newname);
+		die(_("branch renamed to %s, but HEAD is not updated"), newname);
 
 	strbuf_release(&logmsg);
 
@@ -878,8 +878,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
 			error((!argc || branch_checked_out(branch_ref.buf))
-			      ? _("No commit on branch '%s' yet.")
-			      : _("No branch named '%s'."),
+			      ? _("no commit on branch '%s' yet")
+			      : _("no branch named '%s'"),
 			      branch_name);
 		else if (!edit_branch_description(branch_name))
 			ret = 0; /* happy */
@@ -893,7 +893,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("branch name required"));
 		else if ((argc == 1) && filter.detached)
 			die(copy? _("cannot copy the current branch while not on any")
-				: _("cannot rename the current branch while not on any."));
+				: _("cannot rename the current branch while not on any"));
 		else if (argc == 1)
 			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
 		else if (argc == 2)
@@ -965,7 +965,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		const char *start_name = argc == 2 ? argv[1] : head;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
-			die(_("the -a, and -r, options to 'git branch' do not take a branch name\n"
+			die(_("the -a, and -r, options to 'git branch' do not take a branch name.\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
-- 
gitgitgadget
