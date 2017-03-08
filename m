Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0D8E1FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 01:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933539AbdCHBpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 20:45:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:55379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933382AbdCHBpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 20:45:20 -0500
Received: from virtualbox ([95.208.58.158]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LomuB-1c4vGi1qaR-00grB4; Wed, 08
 Mar 2017 01:51:23 +0100
Date:   Wed, 8 Mar 2017 01:51:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     valtron <valtron2000@gmail.com>
cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
In-Reply-To: <alpine.DEB.2.20.1703072345530.3767@virtualbox>
Message-ID: <alpine.DEB.2.20.1703080104580.3767@virtualbox>
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com> <alpine.DEB.2.20.1703072345530.3767@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cJSIZ6taQzUpahWw6x1e3Nc4L5geUyePsjgUZhsWKpLr/QW+civ
 oLDzyiH6DUezfTuCx+7LXJy7CG4fIruPh0mkwl54O9oMbm50oaKB6HU/VQ40g78gj01ZBQA
 rRjvSAkpgRadGUDLTyK7rK8onkmatH3OKt3L+jtSiti1MijjB6hluTMtbWarbZBgjnhOfq4
 UWtN0IKEE6A9AoT9wtbbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A5O6xu65tCc=:ZyAIvH3xA/kHh77sWSvrdI
 AbiSv+QQZSH7A+ccvyAZzsxgAvYKqB11V5eseGCbKAzdKk8pzjclPGy3SOxjPD8O9lwJB2E9w
 4o3saGMIZvJxwxKMrDotBbALqeRrRqzmCXSoNPn2LzILnfTVE8sh8lA0lWFB5kGrhMThglnLn
 c/269PFXFjpL3bwwe77IxbhlPwIE5g9KPShvKYDh4pdqJLF+HkEqYTDwsbN76DCUluK0dCEh7
 qgZOGc6elP0u+yWo41rX2GnIvyknyenzeivmbQPmIZXWq4K+qYzY+sKRNAv0hg4QYoC4MapGO
 eIeVDDn+DGUOki/cpCJbl4ehSpQo0Kwg2j1/yrjA1rFNZDrLRIZZGA0+BEyMJLH+JIL+X2Iog
 AUWMZ0Ig6cH1xi31H0FYp3Vzm65SI4qye7H0l+jEPbRc2IxRjfhB0AAjJEL5K+rNbZL1ycj00
 jyq4JuMsDaQD5PLR2oWQqqnioSKUY43sOiGyWeb1Xe2TpMfk99rr2k4le1SFtmw/P6IBjSLCJ
 RoLCAcZkQDDSKeQ5ZUDHUcOctjN2TJjLZ0fZxvu+XOwbN5GH9MAtKlSd72Aeh7+KWjCS4Hygo
 sRlpgE9REWfeV9P/F2x3C+7vkX41kVW50KN2AhE75GnpRQW5LK2olnvbAXBz3ttxeIkPASv+t
 Lqk1deDxpK5IuAsmQ3aQnHdW4pz7TdA2WnZOLm0o6O35xMl3532ay+KKiP8cKl91gy4ZYYHP4
 91nD5WDMWYIJTgTgiX+8sVKmIp6YWfc0i/TiyY5fZN269SLJByOaN6PtKtjae2hHdqxABBjUS
 OSTwBxp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi valtron,

On Wed, 8 Mar 2017, Johannes Schindelin wrote:

> On Tue, 7 Mar 2017, valtron wrote:
> 
> > When GIT_WORK_TREE contains a drive-letter and forward-slashes, some git
> > commands crash:
> > 
> > C:\repo>set GIT_WORK_TREE=C:/repo
> > C:\repo>git rev-parse HEAD
> >      1 [main] git 2332 cygwin_exception::open_stackdumpfile: Dumping
> > stack trace to git.exe.stackdump
> 
> [...]
>
> In any case, this problem is squarely within the MSYS2 runtime. It has
> nothing to do with Git except for the motivation to set an environment
> variable to an absolute path as you outlined.

Oh boy was I *wrong*! I take that back and apologize for my premature
verdict.

It is true that you should not set GIT_WORKTREE=c:/repo if you want to
work with MSYS2 Git because MSYS2 expects pseudo Unix paths, i.e. /c/repo,
and it will simply try to guess correctly and convert Windows paths with
drive letters and backslashes to that form.

But that does not excuse a crash.

The problem is actually even worse: On *Linux*, this happens:

	$ GIT_WORK_TREE=c:/invalid git rev-parse HEAD
	Segmentation fault (core dumped)

The reason is this: when set_git_work_tree() was converted from using
xstrdup(real_path()) to real_pathdup(), we completely missed the fact that
the former passed die_on_error = 1 to strbuf_realpath(), while the latter
passed die_on_error = 0. As a consequence, work_tree can be NULL now, and
the current code does not expect set_git_work_tree() to return
successfully after setting work_tree to NULL.

I Cc:ed Brandon, the author of 4ac9006f832 (real_path: have callers use
real_pathdup and strbuf_realpath, 2016-12-12).

Brandon, I have a hunch that pretty much all of the xstrdup(real_path())
-> real_pathdup() sites have a problem now. The previous contract was that
real_path() would die() if the passed path is invalid. The new contract is
that real_pathdup() returns NULL in such a case. I believe that the
following call sites are problematic in particular:

builtin/init-db.c: init_db():
	char *original_git_dir = real_pathdup(git_dir);

builtin/init-db.c: cmd_init_db():
	real_git_dir = real_pathdup(real_git_dir);
	...
	git_work_tree_cfg = real_pathdup(rel);

environment.c: set_git_work_tree():
	work_tree = real_pathdup(new_work_tree);

setup.c: setup_discovered_git_dir():
	gitdir = real_pathdup(gitdir);

submodule.c: connect_work_tree_and_git_dir():
	const char *real_work_tree = real_pathdup(work_tree);

transport.c: refs_from_alternate_cb():
	other = real_pathdup(e->path);

worktree.c: find_worktree():
	path = real_pathdup(arg);

I verified that all calls are still there, except for the submodule.c one
which simply moved to dir.c and the transport.c one which apparently now
no longer die()s but simply ignores non-existing paths now.

That leaves six places to patch, methinks... This diff may serve as an
initial version, but I have not really had a deep look at all call sites
(and it is an unwise idea to trust me at this hour anyway, look at the
time when I sent this mail):

-- snipsnap --
diff --git a/abspath.c b/abspath.c
index 2f0c26e0e2c..b02e068aa34 100644
--- a/abspath.c
+++ b/abspath.c
@@ -214,12 +214,12 @@ const char *real_path_if_valid(const char *path)
 	return strbuf_realpath(&realpath, path, 0);
 }
 
-char *real_pathdup(const char *path)
+char *real_pathdup(const char *path, int die_on_error)
 {
 	struct strbuf realpath = STRBUF_INIT;
 	char *retval = NULL;
 
-	if (strbuf_realpath(&realpath, path, 0))
+	if (strbuf_realpath(&realpath, path, die_on_error))
 		retval = strbuf_detach(&realpath, NULL);
 
 	strbuf_release(&realpath);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 1d4d6a00789..8a6acb0ec69 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -338,7 +338,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
-	char *original_git_dir = real_pathdup(git_dir);
+	char *original_git_dir = real_pathdup(git_dir, 1);
 
 	if (real_git_dir) {
 		struct stat st;
@@ -489,7 +489,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
-		real_git_dir = real_pathdup(real_git_dir);
+		real_git_dir = real_pathdup(real_git_dir, 1);
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
@@ -560,7 +560,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		const char *git_dir_parent = strrchr(git_dir, '/');
 		if (git_dir_parent) {
 			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
-			git_work_tree_cfg = real_pathdup(rel);
+			git_work_tree_cfg = real_pathdup(rel, 1);
 			free(rel);
 		}
 		if (!git_work_tree_cfg)
diff --git a/cache.h b/cache.h
index e7b57457e73..7168c1e5ff0 100644
--- a/cache.h
+++ b/cache.h
@@ -1160,7 +1160,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
-char *real_pathdup(const char *path);
+char *real_pathdup(const char *path, int die_on_error);
 const char *absolute_path(const char *path);
 char *absolute_pathdup(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
diff --git a/dir.c b/dir.c
index 4541f9e1460..aeeb5ce1049 100644
--- a/dir.c
+++ b/dir.c
@@ -2730,8 +2730,8 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	char *git_dir = real_pathdup(git_dir_);
-	char *work_tree = real_pathdup(work_tree_);
+	char *git_dir = real_pathdup(git_dir_, 1);
+	char *work_tree = real_pathdup(work_tree_, 1);
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
diff --git a/environment.c b/environment.c
index c07fb17fb70..42dc3106d2f 100644
--- a/environment.c
+++ b/environment.c
@@ -259,7 +259,7 @@ void set_git_work_tree(const char *new_work_tree)
 		return;
 	}
 	git_work_tree_initialized = 1;
-	work_tree = real_pathdup(new_work_tree);
+	work_tree = real_pathdup(new_work_tree, 1);
 }
 
 const char *get_git_work_tree(void)
diff --git a/setup.c b/setup.c
index 9118b48590a..d51549a6de3 100644
--- a/setup.c
+++ b/setup.c
@@ -698,7 +698,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		if (offset != cwd->len && !is_absolute_path(gitdir))
-			gitdir = real_pathdup(gitdir);
+			gitdir = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
 		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
@@ -808,7 +808,7 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 		/* Keep entry but do not canonicalize it */
 		return 1;
 	} else {
-		char *real_path = real_pathdup(ceil);
+		char *real_path = real_pathdup(ceil, 0);
 		if (!real_path) {
 			return 0;
 		}
diff --git a/submodule.c b/submodule.c
index 3b98766a6bc..1d4c0ce86ee 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1403,7 +1403,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 		/* If it is an actual gitfile, it doesn't need migration. */
 		return;
 
-	real_old_git_dir = real_pathdup(old_git_dir);
+	real_old_git_dir = real_pathdup(old_git_dir, 0);
 
 	sub = submodule_from_path(null_sha1, path);
 	if (!sub)
@@ -1412,7 +1412,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 	new_git_dir = git_path("modules/%s", sub->name);
 	if (safe_create_leading_directories_const(new_git_dir) < 0)
 		die(_("could not create directory '%s'"), new_git_dir);
-	real_new_git_dir = real_pathdup(new_git_dir);
+	real_new_git_dir = real_pathdup(new_git_dir, 0);
 
 	if (!prefix)
 		prefix = get_super_prefix();
@@ -1472,14 +1472,14 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		new_git_dir = git_path("modules/%s", sub->name);
 		if (safe_create_leading_directories_const(new_git_dir) < 0)
 			die(_("could not create directory '%s'"), new_git_dir);
-		real_new_git_dir = real_pathdup(new_git_dir);
+		real_new_git_dir = real_pathdup(new_git_dir, 0);
 		connect_work_tree_and_git_dir(path, real_new_git_dir);
 
 		free(real_new_git_dir);
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
-		char *real_sub_git_dir = real_pathdup(sub_git_dir);
-		char *real_common_git_dir = real_pathdup(get_git_common_dir());
+		char *real_sub_git_dir = real_pathdup(sub_git_dir, 0);
+		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 0);
 
 		if (!starts_with(real_sub_git_dir, real_common_git_dir))
 			relocate_single_git_dir_into_superproject(prefix, path);
diff --git a/worktree.c b/worktree.c
index d633761575b..0486e31ad4a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -255,7 +255,7 @@ struct worktree *find_worktree(struct worktree **list,
 		return wt;
 
 	arg = prefix_filename(prefix, strlen(prefix), arg);
-	path = real_pathdup(arg);
+	path = real_pathdup(arg, 1);
 	for (; *list; list++)
 		if (!fspathcmp(path, real_path((*list)->path)))
 			break;
