Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEBA21F404
	for <e@80x24.org>; Tue,  6 Feb 2018 06:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeBFGPt (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 01:15:49 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54363 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBFGPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 01:15:47 -0500
Received: by mail-wm0-f66.google.com with SMTP id i186so1412829wmi.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 22:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5QYPDsyF/MxksgX3TkSgOGhjLkmUZKK2Mwh/bt1rl4g=;
        b=KjMOVYS2AKjzBrDAbznurIVPvveRo8AA4BJPzCZ6TKuAI5yarNVAzgq5dKo/jMd2ZC
         5Jxcy157cAhqcuHLq9aTE2uwsPm54DFLWbcCtih0EhtQro5luIhq+uVYEMpYMw2WH/0O
         AUrbY+OWNz8Q5yG7Qzro947/glrmYOsc9bfOZaaCiOaq2z6PKF5r9R+8xykGuOXSzfg/
         SlKUwztIg/eQKrH0JflU5/PwOvQ2vJ/sD0qcpU1/W1QDQ2KEVL/cLcZVFseg6z5kgYxZ
         xdm/FZbs7sqqmrECs/XN8yzjETxP/oLqRD6cIK8hTes0y6mIsPnKltgcxdyzuC6uBZw0
         1ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5QYPDsyF/MxksgX3TkSgOGhjLkmUZKK2Mwh/bt1rl4g=;
        b=sE5fRuH429ALGBhLLdQbECQds5xRiCjur78GI2Q7hj1HQMqBPDdC4IyYKRfR5+X5oC
         F6GPnDx/7UVPZFBEtGQKrDG/50ycEEsYG9fPu9HMUYU17w68SNh4KeQTxQElelJX4E7F
         f2nGJugu1SpBgfdse82UWSssP3caQnlJKZV3NGPmUHVoaiP+7/uU0kZPi+ZDiYzKnduI
         AbWkGTRhfmDtvPFFnebFC7kTDbE2u3ut2JX+duazxqxIkyvuFGVrHQSfSUZOJMbb+hr1
         8ibPWYFuxrOttqqr64U3PFNAfPIxXVXf3DLcghBfm0t1qQOersKgSjw+41H4kYL7wodC
         nYRw==
X-Gm-Message-State: APf1xPCsQXw6is6AEMSPQuI49/fChnBnM9JwPbUH8gMVn706i5GXeVoM
        IHv/bW9mWIxfWvWHlsaMuZ723+qr3feK+w==
X-Google-Smtp-Source: AH8x225uD5g+YPNywxWfcZZljtu0We0kHbg2OEBPMYyaOvs2XP2icEBcBs7k6Miq9ZZRVrJY+ARMxg==
X-Received: by 10.80.179.6 with SMTP id q6mr2248545edd.87.1517897745093;
        Mon, 05 Feb 2018 22:15:45 -0800 (PST)
Received: from 192.168.2.26 ([2a02:a441:160d:1:39bf:c953:110:444d])
        by smtp.gmail.com with ESMTPSA id r7sm7950872edc.23.2018.02.05.22.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 22:15:44 -0800 (PST)
From:   Alexander Shopov <ash@kambanaria.org>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Alexander Shopov <ash@kambanaria.org>, martin.agren@gmail.com,
        bmwill@google.com, peff@peff.net, sandals@crustytoothpaste.net,
        worldhello.net@gmail.com, j6t@kdbg.org, sunshine@sunshineco.com,
        pclouds@gmail.com
Subject: [PATCH 1/1] Mark messages for translations
Date:   Tue,  6 Feb 2018 07:15:37 +0100
Message-Id: <20180206061537.2573-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206061537.2573-1-ash@kambanaria.org>
References: <20180206061537.2573-1-ash@kambanaria.org>
In-Reply-To: <20180115054419.4112-1-ash@kambanaria.org>
References: <20180115054419.4112-1-ash@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Small changes in messages to fit the style and typography of rest
Reuse already translated messages if possible
Do not translate messages aimed at developers of git
Fix unit tests depending on the original string

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 git.c              | 38 ++++++++++++++++-----------------
 setup.c            | 62 +++++++++++++++++++++++++++---------------------------
 t/t0002-gitfile.sh |  4 ++--
 t/t0008-ignores.sh |  2 +-
 4 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/git.c b/git.c
index c870b9719..5ddcb75d4 100644
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
+	N_("git [--version] [--help] [-C <path>] [-c <name>=<value>]\n"
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
+  				fprintf(stderr, _("no directory given for --git-dir\n" ));
 				usage(git_usage_string);
 			}
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
@@ -106,7 +106,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--namespace")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No namespace given for --namespace.\n" );
+				fprintf(stderr, _("no namespace given for --namespace\n" ));
 				usage(git_usage_string);
 			}
 			setenv(GIT_NAMESPACE_ENVIRONMENT, (*argv)[1], 1);
@@ -120,7 +120,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No directory given for --work-tree.\n" );
+				fprintf(stderr, _("no directory given for --work-tree\n" ));
 				usage(git_usage_string);
 			}
 			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
@@ -134,7 +134,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--super-prefix")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No prefix given for --super-prefix.\n" );
+				fprintf(stderr, _("no prefix given for --super-prefix\n" ));
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
@@ -194,12 +194,12 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
 			if (*argc < 2) {
-				fprintf(stderr, "No directory given for -C.\n" );
+				fprintf(stderr, _("no directory given for -C\n" ));
 				usage(git_usage_string);
 			}
 			if ((*argv)[1][0]) {
 				if (chdir((*argv)[1]))
-					die_errno("Cannot change to '%s'", (*argv)[1]);
+					die_errno("cannot change to '%s'", (*argv)[1]);
 				if (envchanged)
 					*envchanged = 1;
 			}
@@ -209,7 +209,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			list_builtins();
 			exit(0);
 		} else {
-			fprintf(stderr, "Unknown option: %s\n", cmd);
+			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
 		}
 
@@ -247,7 +247,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
-			die_errno("While expanding alias '%s': '%s'",
+			die_errno("while expanding alias '%s': '%s'",
 			    alias_command, alias_string + 1);
 		}
 		count = split_cmdline(alias_string, &new_argv);
@@ -256,8 +256,8 @@ static int handle_alias(int *argcp, const char ***argv)
 			    split_cmdline_strerror(count));
 		option_count = handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
-			die("alias '%s' changes environment variables\n"
-				 "You can use '!git' in the alias to do this.",
+			die("alias '%s' changes environment variables.\n"
+				 "You can use '!git' in the alias to do this",
 				 alias_command);
 		memmove(new_argv - option_count, new_argv,
 				count * sizeof(char *));
@@ -684,8 +684,8 @@ int cmd_main(int argc, const char **argv)
 		if (errno != ENOENT)
 			break;
 		if (was_alias) {
-			fprintf(stderr, "Expansion of alias '%s' failed; "
-				"'%s' is not a git command\n",
+			fprintf(stderr, _("expansion of alias '%s' failed; "
+					  "'%s' is not a git command\n"),
 				cmd, argv[0]);
 			exit(1);
 		}
@@ -696,7 +696,7 @@ int cmd_main(int argc, const char **argv)
 			break;
 	}
 
-	fprintf(stderr, "Failed to run command '%s': %s\n",
+	fprintf(stderr, _("failed to run command '%s': %s\n"),
 		cmd, strerror(errno));
 
 	return 1;
diff --git a/setup.c b/setup.c
index 8cc34186c..30894cec9 100644
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
+	die_errno(_("failed to stat '%s'"), arg);
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
+		die(_("this operation must be run in a work tree"));
 
 	/*
 	 * Make sure subsequent git processes find correct worktree
@@ -525,17 +525,17 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 		/* non-fatal; follow return path */
 		break;
 	case READ_GITFILE_ERR_OPEN_FAILED:
-		die_errno("Error opening '%s'", path);
+		die_errno(_("error opening '%s'"), path);
 	case READ_GITFILE_ERR_TOO_LARGE:
-		die("Too large to be a .git file: '%s'", path);
+		die(_("too large to be a .git file: '%s'"), path);
 	case READ_GITFILE_ERR_READ_FAILED:
-		die("Error reading %s", path);
+		die(_("error reading %s"), path);
 	case READ_GITFILE_ERR_INVALID_FORMAT:
-		die("Invalid gitfile format: %s", path);
+		die(_("invalid gitfile format: %s"), path);
 	case READ_GITFILE_ERR_NO_PATH:
-		die("No path in gitfile: %s", path);
+		die(_("no path in gitfile: %s"), path);
 	case READ_GITFILE_ERR_NOT_A_REPO:
-		die("Not a git repository: %s", dir);
+		die(_("not a git repository: %s"), dir);
 	default:
 		die("BUG: unknown error code");
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
+		die(_("not a git repository: '%s'"), gitdirenv);
 	}
 
 	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
@@ -677,12 +677,12 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
-				die_errno("Could not chdir to '%s'", gitdirenv);
+				die_errno(_("cannot chdir to '%s'"), gitdirenv);
 			if (chdir(git_work_tree_cfg))
-				die_errno("Could not chdir to '%s'", git_work_tree_cfg);
+				die_errno(_("cannot chdir to '%s'"), git_work_tree_cfg);
 			core_worktree = xgetcwd();
 			if (chdir(cwd->buf))
-				die_errno("Could not come back to cwd");
+			        die_errno(_("cannot come back to cwd"));
 			set_git_work_tree(core_worktree);
 			free(core_worktree);
 		}
@@ -710,7 +710,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	if (offset >= 0) {	/* cwd inside worktree? */
 		set_git_dir(real_path(gitdirenv));
 		if (chdir(worktree))
-			die_errno("Could not chdir to '%s'", worktree);
+			die_errno(_("cannot chdir to '%s'"), worktree);
 		strbuf_addch(cwd, '/');
 		free(gitfile);
 		return cwd->buf + offset;
@@ -738,7 +738,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 		if (offset != cwd->len && !is_absolute_path(gitdir))
 			gitdir = to_free = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
-			die_errno("Could not come back to cwd");
+			die_errno(_("cannot come back to cwd"));
 		ret = setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
 		free(to_free);
 		return ret;
@@ -748,7 +748,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	if (is_bare_repository_cfg > 0) {
 		set_git_dir(offset == cwd->len ? gitdir : real_path(gitdir));
 		if (chdir(cwd->buf))
-			die_errno("Could not come back to cwd");
+			die_errno(_("cannot come back to cwd"));
 		return NULL;
 	}
 
@@ -787,7 +787,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
-			die_errno("Could not come back to cwd");
+			die_errno(_("cannot come back to cwd"));
 		return setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
 	}
 
@@ -795,7 +795,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 	inside_work_tree = 0;
 	if (offset != cwd->len) {
 		if (chdir(cwd->buf))
-			die_errno("Cannot come back to cwd");
+			die_errno(_("cannot come back to cwd"));
 		root_len = offset_1st_component(cwd->buf);
 		strbuf_setlen(cwd, offset > root_len ? offset : root_len);
 		set_git_dir(cwd->buf);
@@ -808,9 +808,9 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 static const char *setup_nongit(const char *cwd, int *nongit_ok)
 {
 	if (!nongit_ok)
-		die(_("Not a git repository (or any of the parent directories): %s"), DEFAULT_GIT_DIR_ENVIRONMENT);
+		die(_("not a git repository (or any of the parent directories): %s"), DEFAULT_GIT_DIR_ENVIRONMENT);
 	if (chdir(cwd))
-		die_errno(_("Cannot come back to cwd"));
+		die_errno(_("cannot come back to cwd"));
 	*nongit_ok = 1;
 	return NULL;
 }
@@ -819,7 +819,7 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
 {
 	struct stat buf;
 	if (stat(path, &buf)) {
-		die_errno("failed to stat '%*s%s%s'",
+		die_errno(_("failed to stat '%*s%s%s'"),
 				prefix_len,
 				prefix ? prefix : "",
 				prefix ? "/" : "", path);
@@ -1061,13 +1061,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
-			die(_("Cannot change to '%s'"), dir.buf);
+			die(_("cannot change to '%s'"), dir.buf);
 		prefix = setup_discovered_git_dir(gitdir.buf, &cwd, dir.len,
 						  &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
-			die(_("Cannot change to '%s'"), dir.buf);
+			die(_("cannot change to '%s'"), dir.buf);
 		prefix = setup_bare_git_dir(&cwd, dir.len, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
@@ -1080,7 +1080,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			strbuf_release(&dir);
 			return NULL;
 		}
-		die(_("Not a git repository (or any parent up to mount point %s)\n"
+		die(_("not a git repository (or any parent up to mount point %s)\n"
 		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
 		    dir.buf);
 	default:
@@ -1164,7 +1164,7 @@ int git_config_perm(const char *var, const char *value)
 	/* A filemode value was given: 0xxx */
 
 	if ((i & 0600) != 0600)
-		die(_("Problem with core.sharedRepository filemode value "
+		die(_("problem with core.sharedRepository filemode value "
 		    "(0%.3o).\nThe owner of files must always have "
 		    "read and write permissions."), i);
 
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
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 9670e8cbe..309b466d4 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -31,7 +31,7 @@ test_expect_success 'bad setup: invalid .git file format' '
 		echo "git rev-parse accepted an invalid .git file"
 		false
 	fi &&
-	if ! grep "Invalid gitfile format" .err
+	if ! grep "invalid gitfile format" .err
 	then
 		echo "git rev-parse returned wrong error"
 		false
@@ -45,7 +45,7 @@ test_expect_success 'bad setup: invalid .git file path' '
 		echo "git rev-parse accepted an invalid .git file path"
 		false
 	fi &&
-	if ! grep "Not a git repository" .err
+	if ! grep "not a git repository" .err
 	then
 		echo "git rev-parse returned wrong error"
 		false
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index d27f438bf..5743b482f 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -307,7 +307,7 @@ test_expect_success_multi 'needs work tree' '' '
 		cd .git &&
 		test_check_ignore "foo" 128
 	) &&
-	stderr_contains "fatal: This operation must be run in a work tree"
+	stderr_contains "fatal: this operation must be run in a work tree"
 '
 
 ############################################################################
-- 
2.16.1

