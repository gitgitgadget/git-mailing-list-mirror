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
	by dcvr.yhbt.net (Postfix) with ESMTP id 634E71F454
	for <e@80x24.org>; Wed,  6 Nov 2019 07:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfKFH2k (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 02:28:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53788 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfKFH2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 02:28:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id x4so2111897wmi.3
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 23:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HcBnyYhAxOqiw4HxSv3c/G67iJtHAFJn/VV6EYJroAs=;
        b=WL4XcPBTaavtFKLMbSsxUClbE1gf0IoirJJiwQeBypVWSb0v37wBm8eQS8NW98K1yA
         cxZgm33HdyPcm93UJ0VdAgbqqsZVnt378/N0o30slI/FAvZPMMOnR+4ahMY+DYZRTgU8
         JUGkzb+R2zDxJHtdbSC7/7mEVmT4M4clIynZTCcmO8o+qPmk/nGDmKdcaCb4ceqjBBEf
         DjOp9V3RZdNpiWjZQAwYDd+IiSoPfcmwhnQXLO3BHjAZj4qvFjmjSs1NvXwWDzCAGg3a
         p7O3vx+nCP9vb6OqjPwg/W4gYBU1nJ9Y4UGyHv7Zw4mMfyIc1wlyzhoGRb5ytJqMmwLn
         t1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HcBnyYhAxOqiw4HxSv3c/G67iJtHAFJn/VV6EYJroAs=;
        b=XoJNa48y++tsXJeNm7aM6Hmc39v4JBaijxZ19hlgOcLNPgHQqy5lKMcRMpI/Z7d7NW
         1eJ1SKKEg5RylJUZtivB60bQpQWo0pU36Tyy76UKpD+YQDwC2A1D7B/SjFlPFW2PmKbW
         GKS1lr6BAlqvoogDDrADZlof32a0NjdlZMNACw/PeA0Gj55kPYPNEEtXf5LlCqtgQoUL
         FAzwYbB0eiR0UC0Fb2VGjnIQ1AhMXoacJigqrUSkgT866QnR5AXLsySSZSO71Iw979LF
         1k6wNjyREXEGt+RDS4c3gcI+eyQEjXr0/4jANfN35/SUh20QFfFsstBEWf+1SkxPwL8B
         YMqw==
X-Gm-Message-State: APjAAAU6ikgjC3CL9ecWyX0cAn5bJCTtbLSmAeglX/MydZiJq312hRU1
        OiMHTdjuu1NXTwoiaLy31CwESGEU
X-Google-Smtp-Source: APXvYqwHVDU0EUvx1Ugdu/DYZlCb5aVL6fv0Q6LAgNJoneLj0SJV4dXqz4AvXPKa2cWIUGX5nzRudA==
X-Received: by 2002:a1c:2b82:: with SMTP id r124mr1086531wmr.112.1573025317677;
        Tue, 05 Nov 2019 23:28:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q124sm1104181wme.13.2019.11.05.23.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 23:28:37 -0800 (PST)
Message-Id: <b36fdf6a92b3e5392ae45bf5e8a9132c54675d27.1573025315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.271.git.1573025315.gitgitgadget@gmail.com>
References: <pull.271.git.1573025315.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 07:28:35 +0000
Subject: [PATCH 1/1] refactor: rename is_directory() to dir_exists() and use
 it in clone.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Lin <johnlinp@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        John Lin <johnlinp@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Lin <johnlinp@gmail.com>

The original is_directory() checks whether the given path exists as
a directory, which makes dir_exists() a more suitable name.
However, there is already an existing function called dir_exists(),
while it doesn't check if the path is a directory.

We decided to do the following:
- remove the original dir_exists()
- rename the original is_directory() to dir_exists()
- use the new dir_exists() where the original dir_exists() is called

Hope it can reduce some confusion.

Signed-off-by: John Lin <johnlinp@gmail.com>
---
 abspath.c                   |  2 +-
 builtin/am.c                |  2 +-
 builtin/clone.c             |  6 ------
 builtin/mv.c                |  2 +-
 builtin/rebase.c            | 10 +++++-----
 builtin/submodule--helper.c |  4 ++--
 builtin/worktree.c          |  6 +++---
 cache.h                     |  2 +-
 daemon.c                    |  2 +-
 diff-no-index.c             |  4 ++--
 dir.c                       |  2 +-
 gettext.c                   |  2 +-
 rerere.c                    |  2 +-
 sha1-file.c                 |  6 +++---
 submodule.c                 |  4 ++--
 trace2/tr2_dst.c            |  2 +-
 worktree.c                  |  2 +-
 17 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/abspath.c b/abspath.c
index 9857985329..13bd92eca5 100644
--- a/abspath.c
+++ b/abspath.c
@@ -5,7 +5,7 @@
  * symlink to a directory, we do not want to say it is a directory when
  * dealing with tracked content in the working tree.
  */
-int is_directory(const char *path)
+int dir_exists(const char *path)
 {
 	struct stat st;
 	return (!stat(path, &st) && S_ISDIR(st.st_mode));
diff --git a/builtin/am.c b/builtin/am.c
index 8181c2aef3..f872125fc7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -576,7 +576,7 @@ static int detect_patch_format(const char **paths)
 	/*
 	 * We default to mbox format if input is from stdin and for directories
 	 */
-	if (!*paths || !strcmp(*paths, "-") || is_directory(*paths))
+	if (!*paths || !strcmp(*paths, "-") || dir_exists(*paths))
 		return PATCH_FORMAT_MBOX;
 
 	/*
diff --git a/builtin/clone.c b/builtin/clone.c
index c46ee29f0a..f89938bf94 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -899,12 +899,6 @@ static void dissociate_from_references(void)
 	free(alternates);
 }
 
-static int dir_exists(const char *path)
-{
-	struct stat sb;
-	return !stat(path, &sb);
-}
-
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
diff --git a/builtin/mv.c b/builtin/mv.c
index be15ba7044..194e1618a0 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -152,7 +152,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	 * "git mv directory no-such-dir/".
 	 */
 	flags = KEEP_TRAILING_SLASH;
-	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
+	if (argc == 1 && dir_exists(argv[0]) && !dir_exists(argv[1]))
 		flags = 0;
 	dest_path = internal_prefix_pathspec(prefix, argv + argc, 1, flags);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4a20582e72..c66cdf729b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -275,7 +275,7 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 {
 	FILE *interactive;
 
-	if (!is_directory(merge_dir()) && mkdir_in_gitdir(merge_dir()))
+	if (!dir_exists(merge_dir()) && mkdir_in_gitdir(merge_dir()))
 		return error_errno(_("could not create temporary %s"), merge_dir());
 
 	delete_reflog("REBASE_HEAD");
@@ -1068,7 +1068,7 @@ static int run_am(struct rebase_options *opts)
 		return move_to_original_branch(opts);
 	}
 
-	if (is_directory(opts->state_dir))
+	if (dir_exists(opts->state_dir))
 		rebase_write_basic_state(opts);
 
 	return status;
@@ -1529,13 +1529,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if(file_exists(buf.buf))
 		die(_("It looks like 'git am' is in progress. Cannot rebase."));
 
-	if (is_directory(apply_dir())) {
+	if (dir_exists(apply_dir())) {
 		options.type = REBASE_AM;
 		options.state_dir = apply_dir();
-	} else if (is_directory(merge_dir())) {
+	} else if (dir_exists(merge_dir())) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s/rewritten", merge_dir());
-		if (is_directory(buf.buf)) {
+		if (dir_exists(buf.buf)) {
 			options.type = REBASE_PRESERVE_MERGES;
 			options.flags |= REBASE_INTERACTIVE_EXPLICIT;
 		} else {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2c2395a620..8df36e06b4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1096,7 +1096,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	displaypath = get_submodule_displaypath(path, prefix);
 
 	/* remove the submodule work tree (unless the user already did it) */
-	if (is_directory(path)) {
+	if (dir_exists(path)) {
 		struct strbuf sb_rm = STRBUF_INIT;
 		const char *format;
 
@@ -1105,7 +1105,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 		 * NEEDSWORK: instead of dying, automatically call
 		 * absorbgitdirs and (possibly) warn.
 		 */
-		if (is_directory(sub_git_dir))
+		if (dir_exists(sub_git_dir))
 			die(_("Submodule work tree '%s' contains a .git "
 			      "directory (use 'rm -rf' if you really want "
 			      "to remove it including all of its history)"),
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4de44f579a..a69a1e5612 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -75,7 +75,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	size_t len;
 	ssize_t read_result;
 
-	if (!is_directory(git_path("worktrees/%s", id))) {
+	if (!dir_exists(git_path("worktrees/%s", id))) {
 		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"), id);
 		return 1;
 	}
@@ -738,7 +738,7 @@ static void validate_no_submodules(const struct worktree *wt)
 	struct strbuf path = STRBUF_INIT;
 	int i, found_submodules = 0;
 
-	if (is_directory(worktree_git_path(wt, "modules"))) {
+	if (dir_exists(worktree_git_path(wt, "modules"))) {
 		/*
 		 * There could be false positives, e.g. the "modules"
 		 * directory exists but is empty. But it's a rare case and
@@ -799,7 +799,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
-	if (is_directory(dst.buf)) {
+	if (dir_exists(dst.buf)) {
 		const char *sep = find_last_dir_sep(wt->path);
 
 		if (!sep)
diff --git a/cache.h b/cache.h
index 04cabaac11..596de2db38 100644
--- a/cache.h
+++ b/cache.h
@@ -1274,7 +1274,7 @@ static inline int is_absolute_path(const char *path)
 {
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
 }
-int is_directory(const char *);
+int dir_exists(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
 const char *real_path(const char *path);
diff --git a/daemon.c b/daemon.c
index 9d2e0d20ef..050c1ffacf 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1455,7 +1455,7 @@ int cmd_main(int argc, const char **argv)
 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");
 
-	if (base_path && !is_directory(base_path))
+	if (base_path && !dir_exists(base_path))
 		die("base-path '%s' does not exist or is not a directory",
 		    base_path);
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 7814eabfe0..7f6e17fc76 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -221,8 +221,8 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 	if (path[0] == file_from_standard_input ||
 	    path[1] == file_from_standard_input)
 		return;
-	isdir0 = is_directory(path[0]);
-	isdir1 = is_directory(path[1]);
+	isdir0 = dir_exists(path[0]);
+	isdir1 = dir_exists(path[1]);
 	if (isdir0 == isdir1)
 		return;
 	if (isdir0) {
diff --git a/dir.c b/dir.c
index 61f559f980..fd22bc1866 100644
--- a/dir.c
+++ b/dir.c
@@ -2100,7 +2100,7 @@ static int treat_leading_path(struct dir_struct *dir,
 			baselen = cp - path;
 		strbuf_setlen(&sb, 0);
 		strbuf_add(&sb, path, baselen);
-		if (!is_directory(sb.buf))
+		if (!dir_exists(sb.buf))
 			break;
 		if (simplify_away(sb.buf, sb.len, pathspec))
 			break;
diff --git a/gettext.c b/gettext.c
index 35d2c1218d..c02f6675fa 100644
--- a/gettext.c
+++ b/gettext.c
@@ -183,7 +183,7 @@ void git_setup_gettext(void)
 
 	use_gettext_poison(); /* getenv() reentrancy paranoia */
 
-	if (!is_directory(podir)) {
+	if (!dir_exists(podir)) {
 		free(p);
 		return;
 	}
diff --git a/rerere.c b/rerere.c
index 3e51fdfe58..1d6a4b8df2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -873,7 +873,7 @@ static int is_rerere_enabled(void)
 	if (!rerere_enabled)
 		return 0;
 
-	rr_cache_exists = is_directory(git_path_rr_cache());
+	rr_cache_exists = dir_exists(git_path_rr_cache());
 	if (rerere_enabled < 0)
 		return rr_cache_exists;
 
diff --git a/sha1-file.c b/sha1-file.c
index 188de57634..d0aca36abf 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -448,7 +448,7 @@ static int alt_odb_usable(struct raw_object_store *o,
 	struct object_directory *odb;
 
 	/* Detect cases where alternate disappeared */
-	if (!is_directory(path->buf)) {
+	if (!dir_exists(path->buf)) {
 		error(_("object directory %s does not exist; "
 			"check .git/objects/info/alternates"),
 		      path->buf);
@@ -699,11 +699,11 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 		ref_git = xstrdup(repo);
 	}
 
-	if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
+	if (!repo && dir_exists(mkpath("%s/.git/objects", ref_git))) {
 		char *ref_git_git = mkpathdup("%s/.git", ref_git);
 		free(ref_git);
 		ref_git = ref_git_git;
-	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
+	} else if (!dir_exists(mkpath("%s/objects", ref_git))) {
 		struct strbuf sb = STRBUF_INIT;
 		seen_error = 1;
 		if (get_common_dir(&sb, ref_git)) {
diff --git a/submodule.c b/submodule.c
index 0f199c5137..870f35cd56 100644
--- a/submodule.c
+++ b/submodule.c
@@ -174,7 +174,7 @@ int add_submodule_odb(const char *path)
 	ret = strbuf_git_path_submodule(&objects_directory, path, "objects/");
 	if (ret)
 		goto done;
-	if (!is_directory(objects_directory.buf)) {
+	if (!dir_exists(objects_directory.buf)) {
 		ret = -1;
 		goto done;
 	}
@@ -1647,7 +1647,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	if (!git_dir)
 		git_dir = buf.buf;
 	if (!is_git_directory(git_dir)) {
-		if (is_directory(git_dir))
+		if (dir_exists(git_dir))
 			die(_("'%s' not recognized as a git repository"), git_dir);
 		strbuf_release(&buf);
 		/* The submodule is not checked out, so it is not modified */
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index ae052a07fe..fe0b4d94ff 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -337,7 +337,7 @@ int tr2_dst_get_trace_fd(struct tr2_dst *dst)
 	}
 
 	if (is_absolute_path(tgt_value)) {
-		if (is_directory(tgt_value))
+		if (dir_exists(tgt_value))
 			return tr2_dst_try_auto_path(dst, tgt_value);
 		else
 			return tr2_dst_try_path(dst, tgt_value);
diff --git a/worktree.c b/worktree.c
index 5b4793caa3..e2d2e2dbf1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -290,7 +290,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 	strbuf_addf(&wt_path, "%s/.git", wt->path);
 
 	if (is_main_worktree(wt)) {
-		if (is_directory(wt_path.buf)) {
+		if (dir_exists(wt_path.buf)) {
 			ret = 0;
 			goto done;
 		}
-- 
gitgitgadget
