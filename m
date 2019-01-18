Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D541F453
	for <e@80x24.org>; Fri, 18 Jan 2019 07:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfARHrK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 02:47:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44389 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfARHrI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 02:47:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so10363499edd.11
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 23:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d7U7T5sEAfWL6DSSMOOF1JfJchy4XqNd3KtgPqPBD+M=;
        b=mIdY69zRnWJyk/8fMlGf1/ciOPHHVvodPa8fWtk9RCRVlC1mX1pNrSuZLua3JLIuYl
         iUt5jhlcrHKOnYKObJZyTHud4mgSoN6bqA55cCI3keDoSaxrXbI3aTvCF+3Xc8FhFNyH
         gh7gJdbOUCKYZOGQgVdeYgmKCcJIvnT3uNNGiQEh/hCq+FCMpf/Bmq5k8vv6seUHt3c4
         jZXh7R7r2D3WR9K1g1DBz8PB66FT3ZVSOeok4GGLgwCdW+AOlJvT/eMrfXZCYXry+GIJ
         mo/vNrLdaYjeplXKkb3d8kJ16gXBhA4LB/6RiUEZuOgyhMF03H28YA3vIApag2axN6+g
         ol3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d7U7T5sEAfWL6DSSMOOF1JfJchy4XqNd3KtgPqPBD+M=;
        b=rYO4JMnBw0O2VevT1eVZX0lvzKRbMh+A+gxYMKjoNieCe/CakegnJ5bVhrJ3avC65B
         9/mRLxEVy3foXlXEtLSGF3H6aivtTKnUH9LhLMRSfaioYvPvdrnxtPjGL8vYQe24nIFt
         0R1038b51Lx0366EqRxPASD0ywYj7S7JIb0DXs6EjzvhUT/Xdf1aY8GxxneO51vqckH5
         jjHgkogVxAY1VTzT2LkdhiSe/zjp8HSMrgZ3GMed+/LilN3md2yd/NN3XVRjeoJWhjAO
         VxOosZHLAWll9E0h+U85GqpL1xIAqwBaM9bj6Fg8ve1yhs9d96JaQQxM7URADTBX4epR
         aHVg==
X-Gm-Message-State: AJcUukdjtFu1g2IOALXitOAumcZAl+vU2ZaP/2ARki/+D0WMXcXYKsaU
        JncxBUimoRcSjIMqhu743Lfb4Mxt
X-Google-Smtp-Source: ALg8bN7HwCRm5qeEuVHlXyB4JbtrTtq8NS9Yhcwv6bslHrPO3ZsxO+DReRbIE1MxnaleGbDIYYF9iw==
X-Received: by 2002:a17:906:4f04:: with SMTP id t4-v6mr13393012eju.153.1547797626708;
        Thu, 17 Jan 2019 23:47:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12sm6679876edi.52.2019.01.17.23.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 23:47:06 -0800 (PST)
Date:   Thu, 17 Jan 2019 23:47:06 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 07:46:58 GMT
Message-Id: <cf4e913a5a01cfb9e9b8b83b222cd4647fbc0bf2.1547797620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v2.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
        <pull.103.v2.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/7] add-interactive.c: implement show-help command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
 add-interactive.c     | 23 +++++++++++++++++++++++
 add-interactive.h     |  4 +++-
 builtin/add--helper.c |  7 ++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index c55d934186..76c3f4c3eb 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -244,3 +244,26 @@ void add_i_print_modified(void)
 	free(files);
 	hashmap_free(&s.file_map, 1);
 }
+
+void add_i_show_help(void)
+{
+	const char *help_color = get_color(COLOR_HELP);
+	color_fprintf(stdout, help_color, "%s%s", _("status"), 
+		N_("        - show paths with changes"));
+	printf("\n");
+	color_fprintf(stdout, help_color, "%s%s", _("update"), 
+		N_("        - add working tree state to the staged set of changes"));
+	printf("\n");	
+	color_fprintf(stdout, help_color, "%s%s", _("revert"),
+		N_("        - revert staged set of changes back to the HEAD version"));
+	printf("\n");
+	color_fprintf(stdout, help_color, "%s%s", _("patch"),
+		N_("         - pick hunks and update selectively"));
+	printf("\n");
+	color_fprintf(stdout, help_color, "%s%s", _("diff"),
+		N_("          - view diff between HEAD and index"));
+	printf("\n");
+	color_fprintf(stdout, help_color, "%s%s", _("add untracked"),
+		N_(" - add contents of untracked files to the staged set of changes"));
+	printf("\n");
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

