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
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B671F461
	for <e@80x24.org>; Tue, 27 Aug 2019 13:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfH0NqU (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 09:46:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38370 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfH0NqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 09:46:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so3106825wmm.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1NIkbw2GHHeEGb3qzEsc3YmJmhMiSPiAngrxaC7hU7Q=;
        b=n+27O0reRLoWOSmoGSEjKaFoqz12+G92LbdvzRCrtLfHghXZBCkGn0/V6V7s6z+Pof
         4oBeq4QXDnwPhe6nIu4K0WjaYxXKJHFtF+Z9MPoN62SvqYXhnUBpL+8pM0kp0+NCcp/f
         7tdR/UGSkuzBMWeM1L+jcrQlVOFjc/oyj4kf+ciG332mqt8RHGjbsVdYQO2s6aUzI5Ce
         ERKIzo3ZIdFS+VA+jwoJplBB06EgqmM4PXL3U3TGzOukxafptFc+dIpIG0K3uK+EmIif
         sO9UfLDnd+Cvb0rXdEa40LA8OysS+y8Agfa/X0jf4qboQsNNSZWFkWMbya04ViO82Jh4
         xADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1NIkbw2GHHeEGb3qzEsc3YmJmhMiSPiAngrxaC7hU7Q=;
        b=KJEBFOm50K0LUmjivBwxasp6TTaLGLPrek00KM4CZHr48y0SBKYGljh6qpqYfxJVjW
         jkhJLepBRw1zuntGL5SauPZgscqA98docTalf2YIgtc91NxhKZboS2s3qULtyKvkGqT8
         FWrbCvTEByyhjubpNHCmWI0+BXPS7wJvt4XYBHWYyYB5KqpnwPqLd2diB6L78bSsFrYp
         a+aNjeqR64C4REDDSMimiX0Pc1ElKuzuTMlsKOvqVUWtU6hlC3hFCABntnLe/y2gFcb7
         W7KWheqFln2fP87yzIXlhfzASXxn6AJG+HcHGqx9WyPGkgwWD9Na70wV8DnrjD1EtpE2
         wy4Q==
X-Gm-Message-State: APjAAAWV34FWfPovQlshQw+C9jeQoQj5xmR9dYyIxwnSP5q5txwuv98O
        1KjZLl36Oe6jf7nCycqG4BwosQ5M1Es=
X-Google-Smtp-Source: APXvYqyziSpuBR3kSeGXlGdO9w/g19b0MKFcRFf5/MkThItYyvnj0t2X0ph6YEr4x6BjAkOaITyThA==
X-Received: by 2002:a05:600c:23cd:: with SMTP id p13mr26448453wmb.86.1566913577789;
        Tue, 27 Aug 2019 06:46:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm11758089wrq.95.2019.08.27.06.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 06:46:17 -0700 (PDT)
Date:   Tue, 27 Aug 2019 06:46:17 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 13:46:13 GMT
Message-Id: <63e7e7794ee2afed1b57fe7585ef6e7af9cf8391.1566913575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.v2.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
        <pull.305.v2.git.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] Change HOME, PATH, and .gitconfig paths to be
 customizable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

In Plan 9, almost environment variables are not capitalized.

Signed-off-by: lufia <lufia@lufia.org>
---
 Makefile           | 40 +++++++++++++++++++++++++++++++++++++---
 builtin/config.c   |  2 +-
 config.c           |  2 +-
 credential-cache.c |  2 +-
 credential-store.c |  2 +-
 exec-cmd.c         |  4 ++--
 git-compat-util.h  |  8 ++++++++
 help.c             |  2 +-
 path.c             |  6 +++---
 run-command.c      |  4 ++--
 sequencer.c        |  2 +-
 shell.c            |  2 +-
 12 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index f9255344ae..04ff7df64a 100644
--- a/Makefile
+++ b/Makefile
@@ -539,8 +539,21 @@ perllibdir = $(sharedir)/perl5
 localedir = $(sharedir)/locale
 template_dir = share/git-core/templates
 htmldir = $(prefix)/share/doc/git-doc
-ETC_GITCONFIG = $(sysconfdir)/gitconfig
-ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
+ifndef ETC_GITCONFIG
+	ETC_GITCONFIG = $(sysconfdir)/gitconfig
+endif
+ifndef ETC_GITATTRIBUTES
+	ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
+endif
+ifndef USER_GITCONFIG
+	USER_GITCONFIG = ~/.gitconfig
+endif
+ifndef USER_GITCREDENTIALS
+	USER_GITCREDENTIALS = ~/.git-credentials
+endif
+ifndef USER_GITCREDENTIAL_CACHE
+	USER_GITCREDENTIAL_CACHE = ~/.git-credential-cache
+endif
 lib = lib
 # DESTDIR =
 pathsep = :
@@ -1910,6 +1923,9 @@ endif
 
 ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
+USER_GITCONFIG_SQ = $(subst ','\'',$(USER_GITCONFIG))
+USER_GITCREDENTIALS_SQ = $(subst ','\'',$(USER_GITCREDENTIALS))
+USER_GITCREDENTIAL_CACHE_SQ = $(subst ','\'',$(USER_GITCREDENTIAL_CACHE))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
@@ -2400,12 +2416,30 @@ builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 
 config.sp config.s config.o: GIT-PREFIX
 config.sp config.s config.o: EXTRA_CPPFLAGS = \
-	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
+	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' \
+	-DUSER_GITCONFIG='"$(USER_GITCONFIG_SQ)"'
+
+builtin/config.sp builtin/config.s builtin/config.o: GIT-PREFIX
+builtin/config.sp builtin/config.s builtin/config.o: EXTRA_CPPFLAGS = \
+	-DUSER_GITCONFIG='"$(USER_GITCONFIG_SQ)"'
+
+sequencer.sp sequencer.s sequencer.o: GIT-PREFIX
+sequencer.sp sequencer.s sequencer.o: EXTRA_CPPFLAGS = \
+	-DUSER_GITCONFIG='"$(USER_GITCONFIG_SQ)"'
 
 attr.sp attr.s attr.o: GIT-PREFIX
 attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
 	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
 
+credential-cache.sp credential-cache.s credential-cache.o: GIT-PREFIX
+credential-cache.sp credential-cache.s credential-cache.o: EXTRA_CPPFLAGS = \
+	-DUSER_GITCONFIG='"$(USER_GITCONFIG_SQ)"' \
+	-DUSER_GITCREDENTIAL_CACHE='"$(USER_GITCREDENTIAL_CACHE_SQ)"'
+
+credential-store.sp credential-store.s credential-store.o: GIT-PREFIX
+credential-store.sp credential-store.s credential-store.o: EXTRA_CPPFLAGS = \
+	-DUSER_GITCREDENTIALS='"$(USER_GITCREDENTIALS_SQ)"'
+
 gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
diff --git a/builtin/config.c b/builtin/config.c
index 98d65bc0ad..22c4f0ab71 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -625,7 +625,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (use_global_config) {
-		char *user_config = expand_user_path("~/.gitconfig", 0);
+		char *user_config = expand_user_path(USER_GITCONFIG, 0);
 		char *xdg_config = xdg_config_home("config");
 
 		if (!user_config)
diff --git a/config.c b/config.c
index 3900e4947b..14de96ee6d 100644
--- a/config.c
+++ b/config.c
@@ -1700,7 +1700,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 {
 	int ret = 0;
 	char *xdg_config = xdg_config_home("config");
-	char *user_config = expand_user_path("~/.gitconfig", 0);
+	char *user_config = expand_user_path(USER_GITCONFIG, 0);
 	char *repo_config;
 
 	if (opts->commondir)
diff --git a/credential-cache.c b/credential-cache.c
index 1cccc3a0b9..3e2ed6c0be 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -87,7 +87,7 @@ static char *get_socket_path(void)
 {
 	struct stat sb;
 	char *old_dir, *socket;
-	old_dir = expand_user_path("~/.git-credential-cache", 0);
+	old_dir = expand_user_path(USER_GITCREDENTIAL_CACHE, 0);
 	if (old_dir && !stat(old_dir, &sb) && S_ISDIR(sb.st_mode))
 		socket = xstrfmt("%s/socket", old_dir);
 	else
diff --git a/credential-store.c b/credential-store.c
index ac295420dd..37256ee942 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -168,7 +168,7 @@ int cmd_main(int argc, const char **argv)
 	if (file) {
 		string_list_append(&fns, file);
 	} else {
-		if ((file = expand_user_path("~/.git-credentials", 0)))
+		if ((file = expand_user_path(USER_GITCREDENTIALS, 0)))
 			string_list_append_nodup(&fns, file);
 		file = xdg_config_home("credentials");
 		if (file)
diff --git a/exec-cmd.c b/exec-cmd.c
index 7deeab3039..c95fc8dbdd 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -304,7 +304,7 @@ static void add_path(struct strbuf *out, const char *path)
 void setup_path(void)
 {
 	const char *exec_path = git_exec_path();
-	const char *old_path = getenv("PATH");
+	const char *old_path = getenv(PATH_ENVIRONMENT);
 	struct strbuf new_path = STRBUF_INIT;
 
 	git_set_exec_path(exec_path);
@@ -315,7 +315,7 @@ void setup_path(void)
 	else
 		strbuf_addstr(&new_path, _PATH_DEFPATH);
 
-	setenv("PATH", new_path.buf, 1);
+	setenv(PATH_ENVIRONMENT, new_path.buf, 1);
 
 	strbuf_release(&new_path);
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 83be89de0a..f8fdd79591 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1238,6 +1238,14 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 # define SHELL_PATH "/bin/sh"
 #endif
 
+#ifndef HOME_ENVIRONMENT
+# define HOME_ENVIRONMENT "HOME"
+#endif
+
+#ifndef PATH_ENVIRONMENT
+# define PATH_ENVIRONMENT "PATH"
+#endif
+
 #ifndef _POSIX_THREAD_SAFE_FUNCTIONS
 #define flockfile(fh)
 #define funlockfile(fh)
diff --git a/help.c b/help.c
index 5261d83ecf..6094bfae7d 100644
--- a/help.c
+++ b/help.c
@@ -260,7 +260,7 @@ void load_command_list(const char *prefix,
 		struct cmdnames *main_cmds,
 		struct cmdnames *other_cmds)
 {
-	const char *env_path = getenv("PATH");
+	const char *env_path = getenv(PATH_ENVIRONMENT);
 	const char *exec_path = git_exec_path();
 
 	if (exec_path) {
diff --git a/path.c b/path.c
index 25e97b8c3f..45bde04d37 100644
--- a/path.c
+++ b/path.c
@@ -719,7 +719,7 @@ char *expand_user_path(const char *path, int real_home)
 		const char *username = path + 1;
 		size_t username_len = first_slash - username;
 		if (username_len == 0) {
-			const char *home = getenv("HOME");
+			const char *home = getenv(HOME_ENVIRONMENT);
 			if (!home)
 				goto return_null;
 			if (real_home)
@@ -1426,7 +1426,7 @@ char *xdg_config_home(const char *filename)
 	if (config_home && *config_home)
 		return mkpathdup("%s/git/%s", config_home, filename);
 
-	home = getenv("HOME");
+	home = getenv(HOME_ENVIRONMENT);
 	if (home)
 		return mkpathdup("%s/.config/git/%s", home, filename);
 	return NULL;
@@ -1441,7 +1441,7 @@ char *xdg_cache_home(const char *filename)
 	if (cache_home && *cache_home)
 		return mkpathdup("%s/git/%s", cache_home, filename);
 
-	home = getenv("HOME");
+	home = getenv(HOME_ENVIRONMENT);
 	if (home)
 		return mkpathdup("%s/.cache/git/%s", home, filename);
 	return NULL;
diff --git a/run-command.c b/run-command.c
index 3449db319b..85d7a8c342 100644
--- a/run-command.c
+++ b/run-command.c
@@ -180,14 +180,14 @@ int is_executable(const char *name)
  */
 static char *locate_in_PATH(const char *file)
 {
-	const char *p = getenv("PATH");
+	const char *p = getenv(PATH_ENVIRONMENT);
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!p || !*p)
 		return NULL;
 
 	while (1) {
-		const char *end = strchrnul(p, ':');
+		const char *end = strchrnul(p, PATH_SEP);
 
 		strbuf_reset(&buf);
 
diff --git a/sequencer.c b/sequencer.c
index 34ebf8ed94..044b0fabea 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1246,7 +1246,7 @@ N_("Your name and email address were configured automatically based\n"
 
 static const char *implicit_ident_advice(void)
 {
-	char *user_config = expand_user_path("~/.gitconfig", 0);
+	char *user_config = expand_user_path(USER_GITCONFIG, 0);
 	char *xdg_config = xdg_config_home("config");
 	int config_exists = file_exists(user_config) || file_exists(xdg_config);
 
diff --git a/shell.c b/shell.c
index 40084a3013..fa844425b9 100644
--- a/shell.c
+++ b/shell.c
@@ -39,7 +39,7 @@ static char *make_cmd(const char *prog)
 
 static void cd_to_homedir(void)
 {
-	const char *home = getenv("HOME");
+	const char *home = getenv(HOME_ENVIRONMENT);
 	if (!home)
 		die("could not determine user's home directory; HOME is unset");
 	if (chdir(home) == -1)
-- 
gitgitgadget

