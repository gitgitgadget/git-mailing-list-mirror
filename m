Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC591F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfBTLli (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:38 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45200 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfBTLlg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id d9so19542011edh.12
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KbbtFYNMvfDeyEUTpj+UtfCRufl4UzTuKPZCT5cAS0I=;
        b=koOT5z8lIV857zPzXQ9UHSjipXSDq6Al0i4m5UOyU5+OlOqFTI8CXOEU0bQ22qFpGk
         mNYb+vuhy6qfNNRQI866705Q8OJxT7LDYGTIs4yBY6V4I/uyxp5UI4iTvm7/T0NGhKvq
         YhXoC+Y74DycPcRRUJmZkH66B5kyz9UmAyErGfZoNtCbokJaaCqN50wk3nv6fo1O0h0Z
         PMlfRCBiqjhtuPdu03KK0xbiI1Crc+5LeCTyzjKWAJfSr4qTpvUAwd1tYn+6XFUn9zqC
         MSSK0nK6bO3knzGafiz75OQk1uAr+RjrLBrRXowDWYxzAynXZQXY/GxbGGrWz4BpzSd+
         Z9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KbbtFYNMvfDeyEUTpj+UtfCRufl4UzTuKPZCT5cAS0I=;
        b=fByhdQTLlvRKZmdrwJw9SOxIv3pr+phdlSng4w9/UMUvjO5AvYDXlEUeiZNW47S1KC
         SFEEGfJeLB+oXBABvJ95WNjPr7VnWudQtlckknaKuulLvaRWd1D3hgPwyWQStPqq60FU
         88g+9Qux0XE1ANR5P3pSoZfrJI1RKxOndcNsYg/fMoyHTks9LxWJxoJ18foHPPkJrNs4
         dERjgoIaBqUd2RtNaJvzyZSXRBl8SF6QJbWM23gjJAmFuqiqFoxO0/aaDxkdLmT65N+Q
         UxzhsAIdVKw2j0zDmVhgECrXepQnAbwqqQ4PigJIC6K8h70M8YJqw3jWCDmY7Mr7RAN+
         P0PA==
X-Gm-Message-State: AHQUAuYcBfQO9NAG514a2V5bHy9jb/tYK15cISQ9fPDZ6apUFxPhrzJ6
        81J/3eJurr+nlZhCZQc6F8fRukRN
X-Google-Smtp-Source: AHgI3Ib8zJCCOJ3F+9Gvj/1I2do2OMcuJN5cHmAgEziMNCDqvat0KzUkolzIDdOshNJP73trWYOgQw==
X-Received: by 2002:a17:906:b742:: with SMTP id fx2mr18252451ejb.199.1550662894925;
        Wed, 20 Feb 2019 03:41:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm5625012edn.14.2019.02.20.03.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:34 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:34 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:25 GMT
Message-Id: <441321fc3dbbb8427ea7ec2663b4c21db8771c6c.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 08/10] add-interactive.c: implement show-help command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
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

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 add-interactive.c     | 17 +++++++++++++++++
 add-interactive.h     |  2 ++
 builtin/add--helper.c |  7 ++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 3c2e972413..ad05bf7e1f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -800,3 +800,20 @@ void add_i_status(void)
 	free(s);
 	free_choices(&choices);
 }
+
+void add_i_show_help(void)
+{
+	const char *help_color = get_color(COLOR_HELP);
+	color_fprintf_ln(stdout, help_color, "status        - %s",
+			 _("show paths with changes"));
+	color_fprintf_ln(stdout, help_color, "update        - %s",
+			 _("add working tree state to the staged set of changes"));
+	color_fprintf_ln(stdout, help_color, "revert        - %s",
+			 _("revert staged set of changes back to the HEAD version"));
+	color_fprintf_ln(stdout, help_color, "patch         - %s",
+			 _("pick hunks and update selectively"));
+	color_fprintf_ln(stdout, help_color, "diff          - %s",
+			 _("view diff between HEAD and index"));
+	color_fprintf_ln(stdout, help_color, "add untracked - %s",
+			 _("add contents of untracked files to the staged set of changes"));
+}
diff --git a/add-interactive.h b/add-interactive.h
index 8ef3d2e82b..ddeedd3a33 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -5,4 +5,6 @@ int add_i_config(const char *var, const char *value, void *cbdata);
 
 void add_i_status(void);
 
+void add_i_show_help(void);
+
 #endif
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
index 464d2245f3..1fe64bc7fb 100644
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
+			    N_("show help"), HELP),
 		OPT_END()
 	};
 
@@ -30,6 +33,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
 
 	if (mode == STATUS)
 		add_i_status();
+	else if (mode == HELP)
+		add_i_show_help();
 	else
 		usage_with_options(builtin_add_helper_usage,
 				   options);
-- 
gitgitgadget

