Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC731F453
	for <e@80x24.org>; Fri, 25 Jan 2019 12:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfAYMXl (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 07:23:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46647 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfAYMXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so7189428edt.13
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 04:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c0HymROOdhLPhJ4ItXr0cvQM8M8lupIo2/ijvNiLxeg=;
        b=mmVDK+il1E1B9BFwolXxZfabL05IjXlNFqv/sVT9cZkvY9r4J8q5UGkQtgSKfOTwr2
         o2EbFUAjjcuwkPqbf/ns3b+sR05+wE09FhlqW/l86JbH4jNP5kac6HyJYCer6x+xMNvO
         yrYay8KUmPfA10aqd3Y+QxxYbvOPClA92jctxVEPhugwpRt7eG60aN8KXK/8E2ZuxQzv
         RBtVs05E0St2squdZoUqlHwkehISw0XzlXWc7wU3TRQMX3jCpQWS/aK9uOuCoH4uDqeI
         0mJRsnAqPVTRJuFtTcyA0xaw/AUKrrzAxQWKNQyipk2En/QuH1sYZ99gk1NaJq/QKu2m
         Yj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c0HymROOdhLPhJ4ItXr0cvQM8M8lupIo2/ijvNiLxeg=;
        b=ay83SH5ZG1HgGy0+fmO/FvXMaoXuSPQUiRK1gvfg1d6zc+9HlEUkiX9+p0aFJ4BErU
         6t/EGeT0VGbLDTmhfzl0iXg+q32UZYWSD2rglnX/7hB1LAX9Vdwy6KhVzF6qpN5fKrSv
         lR/h8Qi09/OvgR8rguRjYxyEQuuaX6FA/RWqPMeGmv0n39aDMwDWqB6NMGDeHxfSF9k+
         H19mOEvVCBzDNNCHpHe58a8pXnKPDlkECialLApAwE4PWRuDE0HO6c8I5cP61e72vgXe
         ZRDplryQ+VNF4KAcng9YExCSiJybXir8HJLsv7SvX8AYyPabtGpYIuxkigToqKLCd8Hu
         n2yw==
X-Gm-Message-State: AJcUukfd4wfozjxeNk4soKSpLwAH7PHZjeDO4Es9+KmgkEWi/YcRjpfq
        LrbfSGBhUQXUSnsRDJrPWF7ipxLu
X-Google-Smtp-Source: ALg8bN58Hm3rYC89YmI1R/ktCy9ewIiLmHLIMcj/WNFvev6e6T51OlRLT77We+L8PpEANA6iGhpMWA==
X-Received: by 2002:a17:906:3b09:: with SMTP id g9mr8450349ejf.166.1548419015621;
        Fri, 25 Jan 2019 04:23:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b45sm11710917eda.34.2019.01.25.04.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:23:35 -0800 (PST)
Date:   Fri, 25 Jan 2019 04:23:35 -0800 (PST)
X-Google-Original-Date: Fri, 25 Jan 2019 12:23:27 GMT
Message-Id: <ab16afd1d546ad640fd81338a602c6df1d9ae5ab.1548419009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v4.git.gitgitgadget@gmail.com>
References: <pull.103.v3.git.gitgitgadget@gmail.com>
        <pull.103.v4.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 5/7] add-interactive.c: implement show-help command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Implement show-help command in add-interactive.c and use it in
builtin add--helper.c.

Use command name "show-help" instead of "help": add--helper is
builtin, hence add--helper --help would be intercepted by
handle_builtin and re-routed to the help command, without ever
calling cmd_add__helper().

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 add-interactive.c     | 17 +++++++++++++++++
 add-interactive.h     |  4 +++-
 builtin/add--helper.c |  7 ++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index c55d934186..d239037bc1 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -244,3 +244,20 @@ void add_i_print_modified(void)
 	free(files);
 	hashmap_free(&s.file_map, 1);
 }
+
+void add_i_show_help(void)
+{
+	const char *help_color = get_color(COLOR_HELP);
+	color_fprintf_ln(stdout, help_color, "status        - %s",
+			_("show paths with changes"));
+	color_fprintf_ln(stdout, help_color, "update        - %s",
+			_("add working tree state to the staged set of changes"));
+	color_fprintf_ln(stdout, help_color, "revert        - %s",
+			_("revert staged set of changes back to the HEAD version"));
+	color_fprintf_ln(stdout, help_color, "patch         - %s",
+			_("pick hunks and update selectively"));
+	color_fprintf_ln(stdout, help_color, "diff          - %s",
+			_("view diff between HEAD and index"));
+	color_fprintf_ln(stdout, help_color, "add untracked - %s",
+			_("add contents of untracked files to the staged set of changes"));
+}
diff --git a/add-interactive.h b/add-interactive.h
index 1f4747553c..46e17c5c71 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -5,4 +5,6 @@ int add_i_config(const char *var, const char *value, void *cbdata);
 
 void add_i_print_modified(void);
 
-#endif
\ No newline at end of file
+void add_i_show_help(void);
+
+#endif
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
index 43545d9af5..a3b3a68b68 100644
--- a/builtin/add--helper.c
+++ b/builtin/add--helper.c
@@ -10,7 +10,8 @@ static const char * const builtin_add_helper_usage[] = {
 
 enum cmd_mode {
 	DEFAULT = 0,
-	STATUS
+	STATUS,
+	HELP
 };
 
 int cmd_add__helper(int argc, const char **argv, const char *prefix)
@@ -20,6 +21,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "status", &mode,
 			 N_("print status information with diffstat"), STATUS),
+		OPT_CMDMODE(0, "show-help", &mode,
+			 N_("show help"), HELP),
 		OPT_END()
 	};
 
@@ -30,6 +33,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
 
 	if (mode == STATUS)
 		add_i_print_modified();
+	else if (mode == HELP)
+		add_i_show_help();
 	else
 		usage_with_options(builtin_add_helper_usage,
 				   options);
-- 
gitgitgadget

