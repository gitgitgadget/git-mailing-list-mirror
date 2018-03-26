Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8331F404
	for <e@80x24.org>; Mon, 26 Mar 2018 16:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeCZQ4T (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 12:56:19 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46896 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeCZQ4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 12:56:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id j68-v6so29164423lfg.13
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grqPLJULmCclQyO1AzsXQmNbj97muZG/+f9hNhWhIro=;
        b=ii680U4Zvj4fxdEYlZxtXtm+uZPK7i6OfAgudYvYN88Z8EmnS8vANsiklxr1+QG1hm
         LIzxStj0x1KVCKO67aFFFpa2YJRhQs3nCw7Za/ROi2UafzPEKvtyUAWtoAxxCXtcawhf
         8SWaCfTN5j0cLCziXsVKTSY3rHL1DPsHjc5EAmSxQSqTIvMHFS2K1lHJA0oZC3/1FBZ5
         7l086l5GRB2AxZInmQBZqyriq44tzn2NzNRZJRF/mIB9MN3qu59tB0Xp1fARxvxRveb5
         dlDFaGmsTD2M5JRZLSNxnJ+JRI3IeCu4cA4Nlo48yd8IEeAUEUp4JVxZY1IjfxtkOrPS
         Vp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grqPLJULmCclQyO1AzsXQmNbj97muZG/+f9hNhWhIro=;
        b=BDOJVOR36GmJe4z4+C26mxj6B1OzYAuIu1bSrTTlbiv05T4ttCNbuWheU3n99+3+JW
         x/GKX7WambK2V3/0U4he7VuDLg6LSygikKL3liEj2mCIrZHfbI3Mw5iM/AdodvXp9qQn
         umh5Phk1VIIvd9dxT+C16TsAyKRoBzIgSqza5sM4NsuWWTgvuMtjj6PGxrBSlSgpuOFC
         C+84dfnB2q4WAYZhliZZWVtxVF3W1E7TMCREetPGIHtICHrKw5M0GTcd3ZPmyoqFTSpq
         pRDb5Uj3g1ayChOGKQ14kcOIFE9DKVcJ/iG8FhheSjo6nPTrkMdetYPQPeUz1Q0LL5bC
         BIpg==
X-Gm-Message-State: AElRT7F+TCUt3NFpvaIowD+IiwiHeRZ/ZZPjbLf9L/L03M+wHooGXy3P
        C0JxlGDQTdX5Zf0kpxMYnsY+0A==
X-Google-Smtp-Source: AIpwx48qCjFk0NxlmAxugcdIDaR7fPpsgIvsUQ9ug5uwbvz1qQJTtlN2KYHEHkR8cBIDxOkhWoWm4w==
X-Received: by 10.46.45.18 with SMTP id t18mr376992ljt.48.1522083371617;
        Mon, 26 Mar 2018 09:56:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j8sm814451lje.83.2018.03.26.09.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 09:56:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 5/5] help: add "-a --verbose" to list all commands with synopsis
Date:   Mon, 26 Mar 2018 18:55:20 +0200
Message-Id: <20180326165520.802-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180326165520.802-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-help.txt |  4 ++-
 builtin/help.c             |  6 ++++
 help.c                     | 61 ++++++++++++++++++++++++++++++++++++++
 help.h                     |  1 +
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 40d328a4b3..a40fc38d8b 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all] [-g|--guide]
+'git help' [-a|--all [--verbose]] [-g|--guide]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
@@ -42,6 +42,8 @@ OPTIONS
 --all::
 	Prints all the available commands on the standard output. This
 	option overrides any given command or guide name.
+	When used with `--verbose` print description for all recognized
+	commands.
 
 -g::
 --guides::
diff --git a/builtin/help.c b/builtin/help.c
index 598867cfea..a371199674 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -36,6 +36,7 @@ static const char *html_path;
 
 static int show_all = 0;
 static int show_guides = 0;
+static int verbose;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
@@ -48,6 +49,7 @@ static struct option builtin_help_options[] = {
 			HELP_FORMAT_WEB),
 	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
 			HELP_FORMAT_INFO),
+	OPT__VERBOSE(&verbose, N_("print command description")),
 	OPT_END(),
 };
 
@@ -463,6 +465,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		git_config(git_help_config, NULL);
+		if (verbose) {
+			list_all_cmds_help();
+			return 0;
+		}
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		load_command_list("git-", &main_cmds, &other_cmds);
 		list_commands(colopts, &main_cmds, &other_cmds);
diff --git a/help.c b/help.c
index cacd8249bb..afbf98c241 100644
--- a/help.c
+++ b/help.c
@@ -282,6 +282,67 @@ void list_porcelain_cmds(void)
 	}
 }
 
+static int cmd_category_cmp(const void *elem1, const void *elem2)
+{
+	const struct cmdname_help *e1 = elem1;
+	const struct cmdname_help *e2 = elem2;
+
+	if (e1->category < e2->category)
+		return -1;
+	if (e1->category > e2->category)
+		return 1;
+	return strcmp(e1->name, e2->name);
+}
+
+static const char *get_category_name(unsigned int category)
+{
+	switch (category) {
+	case CAT_ancillaryinterrogators: return _("Ancillary interrogators");
+	case CAT_ancillarymanipulators: return _("Ancillary manipulators");
+	case CAT_foreignscminterface: return _("Foreign SCM interface");
+	case CAT_mainporcelain: return _("Main porcelain");
+	case CAT_plumbinginterrogators: return _("Plumbing interrogators");
+	case CAT_plumbingmanipulators: return _("Plumbing interrogators");
+	case CAT_purehelpers: return _("Pure helpers");
+	case CAT_synchelpers: return _("Sync helpers");
+	case CAT_synchingrepositories: return _("Synching repositories");
+	default:
+		die("BUG: unknown command category %u", category);
+	}
+}
+
+void list_all_cmds_help(void)
+{
+	int i, longest = 0;
+	int current_category = -1;
+	int nr = ARRAY_SIZE(command_list);
+	struct cmdname_help *cmds = command_list;
+
+	for (i = 0; i < nr; i++) {
+		struct cmdname_help *cmd = cmds + i;
+
+		if (longest < strlen(cmd->name))
+			longest = strlen(cmd->name);
+	}
+
+	QSORT(cmds, nr, cmd_category_cmp);
+
+	puts(_("These are all Git commands:"));
+
+	for (i = 0; i < nr; i++) {
+		struct cmdname_help *cmd = cmds + i;
+
+		if (cmd->category != current_category) {
+			current_category = cmd->category;
+			printf("\n%s:\n", get_category_name(current_category));
+		}
+
+		printf("   %s   ", cmd->name);
+		mput_char(' ', longest - strlen(cmd->name));
+		puts(_(cmd->help));
+	}
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 33e2210ebd..62449f1b7e 100644
--- a/help.h
+++ b/help.h
@@ -17,6 +17,7 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_cmds_help(void);
 extern void list_all_cmds(void);
 extern void list_porcelain_cmds(void);
 extern const char *help_unknown_cmd(const char *cmd);
-- 
2.17.0.rc0.348.gd5a49e0b6f

