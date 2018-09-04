Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2050B1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeIEC1F (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38379 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeIEC1F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so2357498pfh.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M52MPgAbLsG9rpYDWGcxBccoKjLz69qSalI8QIBwFLo=;
        b=aLKiPSi9mjyl2jPoMZgxGAzUJks1Ax7h4wCq4eU20IAufBlqADivc2DpM3J1tE6vAf
         dWu7kySk76fo/Ka6FH6ZuDiggBcouyPYPgEmlFDNpN+6qMmznFmJdVoaHrQuD2jJNCP0
         bnWZmQkEDJit8hXu+XhkMxe+nxFT7Ep+7Vcse7glrpWzJjQr8PVjY2e81LS9oUZuAAy+
         Ju2whdAbU7PTcUB76JfdXtORJyZazwNeFmRI9qSAlJC2M/fZgxJk2L/5MRNynQ6TxigF
         Yz9EjbfUYtZA7rgrgCrHvXx22ddkN8MHCwSnkpDaBDpd4wXH6W0mXxKej12RF+QD9NG0
         mRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M52MPgAbLsG9rpYDWGcxBccoKjLz69qSalI8QIBwFLo=;
        b=m+PV1mpGrlWSC9wuslwOzbqASfOJo7GuNBczVanoJy/HH8gyD3UuwxAAk1Fg0Gjt/C
         S0SJtCssdfOr5D62HtpeJ2aC/Eu3nmtHr5aX1R2TdzHIDouPoBH8a0bzyiWvH3Ob8VRv
         U2OqE5v7xfJ3JN/WJCFlW8ItSO3j9eiF+Udl2/3CCLBbMbdXbXuiZVQBoBRrKs6f9Kjh
         lRPiCRsU0XSDaAYo0erolPBKlv9d40KhD+AB5dpu64HLqYK4fbrfVwglBeySFuCLMKDk
         Yh313Kl6WejdJRumWgdjraA/AKpkwRN07vIiPs58qLYJtQMwJWDT+SrWRn7oUE4TPQma
         otVg==
X-Gm-Message-State: APzg51BBOj2qKlMotSVENs0QFC3i9tj2VyaxpppMx873LA6WuBfhE5U0
        ooA41yNzNz55FGyrA9bUXKsxGebO
X-Google-Smtp-Source: ANB0VdaQJclV3pz04OD1RSJXsxnITWljz9etD91qX3eByjlXegp/n78AvHI5ob+LOFBlXPG+vXTAeg==
X-Received: by 2002:a63:ed07:: with SMTP id d7-v6mr33484689pgi.429.1536098400929;
        Tue, 04 Sep 2018 15:00:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id l3-v6sm9309pff.8.2018.09.04.14.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:00:00 -0700 (PDT)
Date:   Tue, 04 Sep 2018 15:00:00 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:36 GMT
Message-Id: <b8055fb258ef07ba55e2e8c1ab3c3a5e91ddd16f.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/18] builtin rebase: support `--gpg-sign` option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

This commit introduces support for `--gpg-sign` option which is used
to GPG-sign commits.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c80eebfbd2..0ab86b7c4c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -97,6 +97,7 @@ struct rebase_options {
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
+	char *gpg_sign_opt;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -209,6 +210,15 @@ static int read_basic_state(struct rebase_options *opts)
 	} else
 		opts->allow_rerere_autoupdate = -1;
 
+	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
+		strbuf_reset(&buf);
+		if (read_one(state_dir_path("gpg_sign_opt", opts),
+			    &buf))
+			return -1;
+		free(opts->gpg_sign_opt);
+		opts->gpg_sign_opt = xstrdup(buf.buf);
+	}
+
 	strbuf_release(&buf);
 
 	return 0;
@@ -297,6 +307,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 		"--rerere-autoupdate" : "--no-rerere-autoupdate");
 	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
+	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -462,6 +473,13 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "commit.gpgsign")) {
+		free(opts->gpg_sign_opt);
+		opts->gpg_sign_opt = git_config_bool(var, value) ?
+			xstrdup("-S") : NULL;
+		return 0;
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -555,6 +573,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int committer_date_is_author_date = 0;
 	int ignore_date = 0;
 	int ignore_whitespace = 0;
+	const char *gpg_sign = NULL;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -619,6 +638,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
+		OPT_STRING('S', "gpg-sign", &gpg_sign,
+			   N_("gpg-sign?"), N_("GPG-sign commits")),
 		OPT_END(),
 	};
 
@@ -821,6 +842,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.keep_empty)
 		imply_interactive(&options, "--keep-empty");
 
+	if (gpg_sign) {
+		free(options.gpg_sign_opt);
+		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1046,5 +1072,6 @@ run_rebase:
 cleanup:
 	strbuf_release(&revisions);
 	free(options.head_name);
+	free(options.gpg_sign_opt);
 	return ret;
 }
-- 
gitgitgadget

