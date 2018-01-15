Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7351FADF
	for <e@80x24.org>; Mon, 15 Jan 2018 05:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeAOFok (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 00:44:40 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43023 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932269AbeAOFoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 00:44:38 -0500
Received: by mail-wm0-f65.google.com with SMTP id g1so22430881wmg.2
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 21:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OKnQDe9COr1nKirmSqoW2056BQHrAj0vlQ39mmiOBjU=;
        b=qhzuBv3PN/i7J/6tG4Qc26E201KgeH4b02+7nsBanIGsOnKQZc0dfGQD0BNYIOs2YI
         oTFbjy4ajyLd8zSgpIdWDKLdx2rU7CROMtAIml1FxNggV1gZ4yr6ydPU7ZlJBeJhL1c3
         7GDiViAbqTlvimB/YiEh84oxxdWKzUkbK9TrAFDpIs+JbaenNlmK2aJ6zxlJW1Uqflru
         hUWKlyF9sIXegOuek758Xu83iF+Zk1mKxZwBtY4qYl7ea3jWym/UxgJSqwiWM4luXCpj
         5BQEeiYZk1Auoj6KV3mGSm9WQWsszgErb08FqKxUG1VhfxNARwaakCFO+gwt4ZeFmq8s
         iclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OKnQDe9COr1nKirmSqoW2056BQHrAj0vlQ39mmiOBjU=;
        b=bZW9jzlC0Ie1AB6LQXDEisx74gcBPviIYMySnAmJdMj1qBvPl9MZmsh7AuHbySFAK1
         plkk27dd3xoWHEgz7iPZ5gU7aLK3aIjM+ZIVF8CR108y2/cLKOz2rEeTYaKmPCFEzcgg
         KLWZy3buOf5/Sd98WU1IUTPNPHGXLX9JWVP/kCoZyN6P66YkHEK5JUT0QYZMe6/LrKqb
         oyTSjF/GGEDukSb8uADHynM3uqocgvum7KyM0XSHWAsQrNiyeHsxSGEIVLjtFpH/MYre
         KEsO9uVfOBVqLxI2VNXg+1hYCMhG4pj9scevkE8WvpjOpNmgqrZOExUiaD3p+uTgLU+p
         39Qg==
X-Gm-Message-State: AKGB3mIL13gDN/CRNtYpIOxX1MAVRyrQQcxKpQiPLU95vAxEVBScNjDk
        kp+/aZwM8ReRxL98cVIULllVa7rcCBYnAw==
X-Google-Smtp-Source: ACJfBosJynYqSWmHciWJLJTLqXYw9Sl/vPXdqG7i2oyfxnReqVNRABYUpHW3YMbVq0zxt0EjcoPoRA==
X-Received: by 10.80.195.193 with SMTP id i1mr47312043edf.139.1515995076402;
        Sun, 14 Jan 2018 21:44:36 -0800 (PST)
Received: from 192.168.2.62 ([2a02:a441:160d:1:b48:8e3e:c67f:c964])
        by smtp.gmail.com with ESMTPSA id a33sm8758311ede.2.2018.01.14.21.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jan 2018 21:44:35 -0800 (PST)
From:   Alexander Shopov <ash@kambanaria.org>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     martin.agren@gmail.com, bmwill@google.com, peff@peff.net,
        sandals@crustytoothpaste.net, worldhello.net@gmail.com,
        Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 1/1] Mark messages for translations
Date:   Mon, 15 Jan 2018 06:44:19 +0100
Message-Id: <20180115054419.4112-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180115054419.4112-1-ash@kambanaria.org>
References: <20180115054419.4112-1-ash@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reuse already translated messages if possible
Do not translate messages aimed at developers of git

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 git.c   | 30 +++++++++++++++---------------
 setup.c | 52 ++++++++++++++++++++++++++--------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/git.c b/git.c
index c870b9719..e66316ce5 100644
--- a/git.c
+++ b/git.c
@@ -5,11 +5,11 @@
 #include "run-command.h"
 
 const char git_usage_string[] =
-	"git [--version] [--help] [-C <path>] [-c name=value]\n"
-	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
-	"           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
-	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
-	"           <command> [<args>]";
+	N_("git [--version] [--help] [-C <path>] [-c name=value]\n"
+	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
+	   "           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
+	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
+	   "           <command> [<args>]");
 
 const char git_more_info_string[] =
 	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
@@ -92,7 +92,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No directory given for --git-dir.\n" );
+  				fprintf(stderr, _("No directory given for --git-dir.\n" ));
 				usage(git_usage_string);
 			}
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
@@ -106,7 +106,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--namespace")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No namespace given for --namespace.\n" );
+				fprintf(stderr, _("No namespace given for --namespace.\n" ));
 				usage(git_usage_string);
 			}
 			setenv(GIT_NAMESPACE_ENVIRONMENT, (*argv)[1], 1);
@@ -120,7 +120,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No directory given for --work-tree.\n" );
+				fprintf(stderr, _("No directory given for --work-tree.\n" ));
 				usage(git_usage_string);
 			}
 			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
@@ -134,7 +134,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--super-prefix")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No prefix given for --super-prefix.\n" );
+				fprintf(stderr, _("No prefix given for --super-prefix.\n" ));
 				usage(git_usage_string);
 			}
 			setenv(GIT_SUPER_PREFIX_ENVIRONMENT, (*argv)[1], 1);
@@ -156,7 +156,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-c")) {
 			if (*argc < 2) {
-				fprintf(stderr, "-c expects a configuration string\n" );
+				fprintf(stderr, _("-c expects a configuration string\n" ));
 				usage(git_usage_string);
 			}
 			git_config_push_parameter((*argv)[1]);
@@ -194,7 +194,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No directory given for -C.\n" );
+				fprintf(stderr, _("No directory given for -C.\n" ));
 				usage(git_usage_string);
 			}
 			if ((*argv)[1][0]) {
@@ -209,7 +209,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			list_builtins();
 			exit(0);
 		} else {
-			fprintf(stderr, "Unknown option: %s\n", cmd);
+			fprintf(stderr, _("Unknown option: %s\n"), cmd);
 			usage(git_usage_string);
 		}
 
@@ -684,8 +684,8 @@ int cmd_main(int argc, const char **argv)
 		if (errno != ENOENT)
 			break;
 		if (was_alias) {
-			fprintf(stderr, "Expansion of alias '%s' failed; "
-				"'%s' is not a git command\n",
+			fprintf(stderr, _("Expansion of alias '%s' failed; "
+					  "'%s' is not a git command\n"),
 				cmd, argv[0]);
 			exit(1);
 		}
@@ -696,7 +696,7 @@ int cmd_main(int argc, const char **argv)
 			break;
 	}
 
-	fprintf(stderr, "Failed to run command '%s': %s\n",
+	fprintf(stderr, _("Failed to run command '%s': %s\n"),
 		cmd, strerror(errno));
 
 	return 1;
diff --git a/setup.c b/setup.c
index 8cc34186c..4aa8c8360 100644
--- a/setup.c
+++ b/setup.c
@@ -119,7 +119,7 @@ char *prefix_path(const char *prefix, int len, const char *path)
 {
 	char *r = prefix_path_gently(prefix, len, NULL, path);
 	if (!r)
-		die("'%s' is outside repository", path);
+		die(_("'%s' is outside repository"), path);
 	return r;
 }
 
@@ -160,7 +160,7 @@ int check_filename(const char *prefix, const char *arg)
 		free(to_free);
 		return 0; /* file does not exist */
 	}
-	die_errno("failed to stat '%s'", arg);
+	die_errno(_("failed to stat '%s'", arg));
 }
 
 static void NORETURN die_verify_filename(const char *prefix,
@@ -230,7 +230,7 @@ void verify_filename(const char *prefix,
 		     int diagnose_misspelt_rev)
 {
 	if (*arg == '-')
-		die("option '%s' must come before non-option arguments", arg);
+		die(_("option '%s' must come before non-option arguments"), arg);
 	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
@@ -385,14 +385,14 @@ void setup_work_tree(void)
 		return;
 
 	if (work_tree_config_is_bogus)
-		die("unable to set up work tree using invalid config");
+		die(_("unable to set up work tree using invalid config"));
 
 	work_tree = get_git_work_tree();
 	git_dir = get_git_dir();
 	if (!is_absolute_path(git_dir))
 		git_dir = real_path(get_git_dir());
 	if (!work_tree || chdir(work_tree))
-		die("This operation must be run in a work tree");
+		die(_("This operation must be run in a work tree"));
 
 	/*
 	 * Make sure subsequent git processes find correct worktree
@@ -525,19 +525,19 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 		/* non-fatal; follow return path */
 		break;
 	case READ_GITFILE_ERR_OPEN_FAILED:
-		die_errno("Error opening '%s'", path);
+		die_errno(_("Error opening '%s'"), path);
 	case READ_GITFILE_ERR_TOO_LARGE:
-		die("Too large to be a .git file: '%s'", path);
+		die(_("Too large to be a .git file: '%s'"), path);
 	case READ_GITFILE_ERR_READ_FAILED:
-		die("Error reading %s", path);
+		die(_("Error reading %s"), path);
 	case READ_GITFILE_ERR_INVALID_FORMAT:
-		die("Invalid gitfile format: %s", path);
+		die(_("Invalid gitfile format: %s"), path);
 	case READ_GITFILE_ERR_NO_PATH:
-		die("No path in gitfile: %s", path);
+		die(_("No path in gitfile: %s"), path);
 	case READ_GITFILE_ERR_NOT_A_REPO:
-		die("Not a git repository: %s", dir);
+		die(_("Not a git repository: %s"), dir);
 	default:
-		die("BUG: unknown error code");
+		die(_("BUG: unknown error code"));
 	}
 }
 
@@ -634,7 +634,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	int offset;
 
 	if (PATH_MAX - 40 < strlen(gitdirenv))
-		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
+		die(_("'$%s' too big"), GIT_DIR_ENVIRONMENT);
 
 	gitfile = (char*)read_gitfile(gitdirenv);
 	if (gitfile) {
@@ -648,7 +648,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 			free(gitfile);
 			return NULL;
 		}
-		die("Not a git repository: '%s'", gitdirenv);
+		die(_("Not a git repository: '%s'"), gitdirenv);
 	}
 
 	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
@@ -677,12 +677,12 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
-				die_errno("Could not chdir to '%s'", gitdirenv);
+				die_errno(_("Cannot chdir to '%s'"), gitdirenv);
 			if (chdir(git_work_tree_cfg))
-				die_errno("Could not chdir to '%s'", git_work_tree_cfg);
+				die_errno(_("Cannot chdir to '%s'"), git_work_tree_cfg);
 			core_worktree = xgetcwd();
 			if (chdir(cwd->buf))
-				die_errno("Could not come back to cwd");
+				die_errno(_("Cannot come back to cwd");
 			set_git_work_tree(core_worktree);
 			free(core_worktree);
 		}
@@ -710,7 +710,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	if (offset >= 0) {	/* cwd inside worktree? */
 		set_git_dir(real_path(gitdirenv));
 		if (chdir(worktree))
-			die_errno("Could not chdir to '%s'", worktree);
+			die_errno(_("Cannot chdir to '%s'"), worktree);
 		strbuf_addch(cwd, '/');
 		free(gitfile);
 		return cwd->buf + offset;
@@ -738,7 +738,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 		if (offset != cwd->len && !is_absolute_path(gitdir))
 			gitdir = to_free = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
-			die_errno("Could not come back to cwd");
+			die_errno(_("Cannot come back to cwd"));
 		ret = setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
 		free(to_free);
 		return ret;
@@ -748,7 +748,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	if (is_bare_repository_cfg > 0) {
 		set_git_dir(offset == cwd->len ? gitdir : real_path(gitdir));
 		if (chdir(cwd->buf))
-			die_errno("Could not come back to cwd");
+			die_errno(_("Cannot come back to cwd"));
 		return NULL;
 	}
 
@@ -787,7 +787,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
-			die_errno("Could not come back to cwd");
+			die_errno(_("Cannot come back to cwd"));
 		return setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
 	}
 
@@ -795,7 +795,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 	inside_work_tree = 0;
 	if (offset != cwd->len) {
 		if (chdir(cwd->buf))
-			die_errno("Cannot come back to cwd");
+			die_errno(_("Cannot come back to cwd"));
 		root_len = offset_1st_component(cwd->buf);
 		strbuf_setlen(cwd, offset > root_len ? offset : root_len);
 		set_git_dir(cwd->buf);
@@ -819,7 +819,7 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
 {
 	struct stat buf;
 	if (stat(path, &buf)) {
-		die_errno("failed to stat '%*s%s%s'",
+		die_errno(_("failed to stat '%*s%s%s'"),
 				prefix_len,
 				prefix ? prefix : "",
 				prefix ? "/" : "", path);
@@ -1207,7 +1207,7 @@ void sanitize_stdfds(void)
 	while (fd != -1 && fd < 2)
 		fd = dup(fd);
 	if (fd == -1)
-		die_errno("open /dev/null or dup failed");
+		die_errno(_("open /dev/null or dup failed"));
 	if (fd > 2)
 		close(fd);
 }
@@ -1222,12 +1222,12 @@ int daemonize(void)
 		case 0:
 			break;
 		case -1:
-			die_errno("fork failed");
+			die_errno(_("fork failed"));
 		default:
 			exit(0);
 	}
 	if (setsid() == -1)
-		die_errno("setsid failed");
+		die_errno(_("setsid failed"));
 	close(0);
 	close(1);
 	close(2);
-- 
2.15.1

