Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC54E1BDC3
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol8DW4F+"
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F01BE
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:33:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32d9552d765so1482940f8f.2
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697211230; x=1697816030; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hxk8ppGnIUL10RzdrYRBPXH4TFTXzyTyoj+J21G7H1c=;
        b=Ol8DW4F+0bW+7DXFHj7rXw3+8p1Qi/ldKYtG7j56lLV7djFMxQttqBZGN1C6uRhH5P
         UuC9GzF08pM2Q8fCh3fCXv/B1xCPSZnQmc/0SQ6wqVAHaT3outjkmLq0ixVoobzGs0uQ
         kBXKRkKFZoUt0Jg4NxUKYHPsgUqRFBF95i6mgRf7Y3oNh05aNCL1PCjsfqvd6hhw13QB
         tG00VKrudHn0SONwE+Qg7LxS7P3rVsx56oCLs8b98VN615sIcgglX01MDVfZdlHFosjQ
         4y1lEtM4I7OU+M9SXOkAv/jYMKgCFHffDyimCCKdhbw4ojbpauwlI2zaJSr2z8Lt+wZx
         zHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211230; x=1697816030;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hxk8ppGnIUL10RzdrYRBPXH4TFTXzyTyoj+J21G7H1c=;
        b=bdY+YsheLXs2/r24UGcGo/HVbrlfdBagijXkP5eZCh5ULcIQlwMEaql0RVTJKAdrt0
         vSTiVmmi7zDWZBN9pV9eR7wyW4MmcJXkWXAUsZ9519j21zIGUXtXMQLDBJSSM4ai8xY3
         FSIGFGDr+VYEGqAjMNls6B8OAaFfoDsaSofqMkmK8TFlGDmAKWXPysCb6IPaaZmJFtTV
         F8rsqdS1EGE+/FpDqkj3tZ8xaq1wVRDeZOaB9YpIclPxwk8MN1V+Kei6F1PrmaJmM2J2
         Wr0N7W+D6ohZAqXLCOBaDK3art3ZEP5XNkI5mboL+yo0FPus8YAxjOPBvzk1CT9E6QUG
         ocgA==
X-Gm-Message-State: AOJu0YxzK7lZ2zTZz20Bsgsv+MqtKAqPWWLvUF2+M6pRhUVCuw9OTstL
	Xcs6keeeQg403Z2WviW1hQCNwzv6Up0=
X-Google-Smtp-Source: AGHT+IHLSzjW1OvnAnhJr8uEdSppL0Feax3IE4JnLOcwSfuY7fk7xs3RmpL0SSY59viNv/KXFOmLmQ==
X-Received: by 2002:adf:e606:0:b0:317:6314:96e2 with SMTP id p6-20020adfe606000000b00317631496e2mr22218694wrm.14.1697211229950;
        Fri, 13 Oct 2023 08:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d604f000000b003259b068ba6sm21198675wrt.7.2023.10.13.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:33:49 -0700 (PDT)
Message-ID: <24618a8a3e9df4d5ae3cd715ce9ebd6376fcf766.1697211227.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com>
References: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com>
From: "Isoken June Ibizugbe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Oct 2023 15:33:46 +0000
Subject: [PATCH 1/2] branch.c: ammend error messages for die()
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
 builtin/branch.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ec190b14a7..a756543d644 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -518,11 +518,11 @@ static void reject_rebase_or_bisect_branch(struct worktree **worktrees,
 			continue;
 
 		if (is_worktree_being_rebased(wt, target))
-			die(_("Branch %s is being rebased at %s"),
+			die(_("branch %s is being rebased at %s"),
 			    target, wt->path);
 
 		if (is_worktree_being_bisected(wt, target))
-			die(_("Branch %s is being bisected at %s"),
+			die(_("branch %s is being bisected at %s"),
 			    target, wt->path);
 	}
 }
@@ -578,7 +578,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		if (ref_exists(oldref.buf))
 			recovery = 1;
 		else
-			die(_("Invalid branch name: '%s'"), oldname);
+			die(_("invalid branch name: '%s'"), oldname);
 	}
 
 	for (int i = 0; worktrees[i]; i++) {
@@ -594,9 +594,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf)) {
 		if (oldref_usage & IS_HEAD)
-			die(_("No commit on branch '%s' yet."), oldname);
+			die(_("no commit on branch '%s' yet"), oldname);
 		else
-			die(_("No branch named '%s'."), oldname);
+			die(_("no branch named '%s'"), oldname);
 	}
 
 	/*
@@ -624,9 +624,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	if (!copy && !(oldref_usage & IS_ORPHAN) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch rename failed"));
+		die(_("branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch copy failed"));
+		die(_("branch copy failed"));
 
 	if (recovery) {
 		if (copy)
@@ -640,16 +640,16 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (!copy && (oldref_usage & IS_HEAD) &&
 	    replace_each_worktree_head_symref(worktrees, oldref.buf, newref.buf,
 					      logmsg.buf))
-		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+		die(_("branch renamed to %s, but HEAD is not updated!"), newname);
 
 	strbuf_release(&logmsg);
 
 	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
 	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is renamed, but update of config-file failed"));
+		die(_("branch is renamed, but update of config-file failed"));
 	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is copied, but update of config-file failed"));
+		die(_("branch is copied, but update of config-file failed"));
 	strbuf_release(&oldref);
 	strbuf_release(&newref);
 	strbuf_release(&oldsection);
@@ -773,7 +773,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (!head)
-		die(_("Failed to resolve HEAD as a valid ref."));
+		die(_("failed to resolve HEAD as a valid ref"));
 	if (!strcmp(head, "HEAD"))
 		filter.detached = 1;
 	else if (!skip_prefix(head, "refs/heads/", &head))
@@ -866,7 +866,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (!argc) {
 			if (filter.detached)
-				die(_("Cannot give description to detached HEAD"));
+				die(_("cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1) {
 			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
@@ -892,7 +892,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!argc)
 			die(_("branch name required"));
 		else if ((argc == 1) && filter.detached)
-			die(copy? _("cannot copy the current branch while not on any.")
+			die(copy? _("cannot copy the current branch while not on any")
 				: _("cannot rename the current branch while not on any."));
 		else if (argc == 1)
 			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
@@ -916,14 +916,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
 				die(_("could not set upstream of HEAD to %s when "
-				      "it does not point to any branch."),
+				      "it does not point to any branch"),
 				    new_upstream);
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
 		if (!ref_exists(branch->refname)) {
 			if (!argc || branch_checked_out(branch->refname))
-				die(_("No commit on branch '%s' yet."), branch->name);
+				die(_("no commit on branch '%s' yet"), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
 		}
 
@@ -946,12 +946,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
 				die(_("could not unset upstream of HEAD when "
-				      "it does not point to any branch."));
+				      "it does not point to any branch"));
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
 		if (!branch_has_merge_config(branch))
-			die(_("Branch '%s' has no upstream information"), branch->name);
+			die(_("branch '%s' has no upstream information"), branch->name);
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
@@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		const char *start_name = argc == 2 ? argv[1] : head;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
-			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
+			die(_("the -a, and -r, options to 'git branch' do not take a branch name\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
-			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
+			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
 		if (recurse_submodules) {
 			create_branches_recursively(the_repository, branch_name,
-- 
gitgitgadget

