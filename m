Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309D31F732
	for <e@80x24.org>; Sat,  3 Aug 2019 23:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfHCXwN (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:52:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42305 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfHCXwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:52:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so30907976wrr.9
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/L4URON6mUc66z8fixemd0B811BiNReVi41DBT+ZmgM=;
        b=LTsG7kg4ejv6g01M/sUwCBZRvq/SwXJrZcUQq8nzJE5DLllfXiAVJIxemuHcanUqYc
         Lt/tVxw82CpXzKTXTX1S4aG9+1UTizSuReio4Qb9YC25wBxyFoav8FeyZ5YYW1Q1ReDu
         wzBjbVvu/Z5V0+ROOY8rQZhD4kFB+CJj+UbxeFPHouD6Kir3/SerB5PxCt6O0q1UTx1g
         +bWEEYmjfohdcmSxtb/O8+92vsUtGt5T7LcLNVb0hKTmwAbgwWw2sugxqWcrTZEl599d
         TkYedJshNS3lQLFssHI0rX2RInCSRsLCyyBZFeFJadX+kZ6JiQnzC7022tB5muqL29I1
         siiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/L4URON6mUc66z8fixemd0B811BiNReVi41DBT+ZmgM=;
        b=EK9t88LnlM/gFSjKBGQ4gX8rTripJ7sh0iFp1x2xu+sdpSrxBgDgt8JaEQJVxTQfpO
         t2goYWCBNuxbcC3/RKd2LnldERJvWkWIDYGnUTtfXY3QbIFjdlyZU8W54TYSpchuDg3S
         h4ynJc43TJGgYTOfc9ZjoHcilRGPxTrb2FljPtktE4xuzPtWxmPHa38tR9715ccVlqir
         gUZkrKgrk3SPfHvN2u8Z9JkrlxywceZkl+T7fxprqnOvjGY153bSECJWR5NjHb/654Yt
         VyLj8+h9cCgzIOUh/59agpRLYdLWcRfU95HwtFYwfEsLDtLuRzq/YrEUz9WDNahZy39I
         qJgA==
X-Gm-Message-State: APjAAAXoVGJqwnxWaAR3ytUdRP+kH9K2N+oREjd7Yri3qjp/HZ5yIRo5
        zIslXg+Bi0SlOhwleXjxMaCxuLi6
X-Google-Smtp-Source: APXvYqyj6apEJd6jSsqjWRmxqlT9rUjeSNCy9X7Y6D0Kq/9nWz/Pw0VEN+p9w/QWvx8wzcvaUPvpUQ==
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr58731107wrt.106.1564876330094;
        Sat, 03 Aug 2019 16:52:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y24sm58121862wmi.10.2019.08.03.16.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 16:52:09 -0700 (PDT)
Date:   Sat, 03 Aug 2019 16:52:09 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Aug 2019 23:52:02 GMT
Message-Id: <fa539c75b29f0ba5433a52bec5c7679476e15e8b.1564876327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/6] Change HOME, PATH, and .gitconfig paths to be
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
 Makefile           | 26 +++++++++++++++++++++++++-
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
 12 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index bd246f2989..721364efba 100644
--- a/Makefile
+++ b/Makefile
@@ -541,6 +541,9 @@ template_dir = share/git-core/templates
 htmldir = $(prefix)/share/doc/git-doc
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
 ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
+USER_GITCONFIG = ~/.gitconfig
+USER_GITCREDENTIALS = ~/.git-credentials
+USER_GITCREDENTIAL_CACHE = ~/.git-credential-cache
 lib = lib
 # DESTDIR =
 pathsep = :
@@ -1910,6 +1913,9 @@ endif
 
 ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
+USER_GITCONFIG_SQ = $(subst ','\'',$(USER_GITCONFIG))
+USER_GITCREDENTIALS_SQ = $(subst ','\'',$(USER_GITCREDENTIALS))
+USER_GITCREDENTIAL_CACHE_SQ = $(subst ','\'',$(USER_GITCREDENTIAL_CACHE))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
@@ -2400,12 +2406,30 @@ builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 
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
index ed7f58e0fc..f67cef5cf8 100644
--- a/config.c
+++ b/config.c
@@ -1699,7 +1699,7 @@ static int do_git_config_sequence(const struct config_options *opts,
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

