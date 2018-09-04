Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A57561F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeIEC1M (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42512 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeIEC1J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so2347227pff.9
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qSvun48v37mT8vMQFZwOiFqfakQpEhZZF8sbdHT2XoY=;
        b=ZZgK9BDugcIr8LXkI5QbXFp7GaKb620nVEo0A6xHWRXKN+uFvHGlpvE+uSaq2fwCTW
         xrpWk/c23vzL/Lmm+KpPVhJPeRoVCZ72gnhZLOWtSrW84m+yh5tIVnBjeG/9Yy7sEms6
         1swP7eT7+YnfMDBHPOPuVxohyrn3DEmCWg3LkB0ip4Vbt3rijBDqOEHk+fitwCSosJwM
         xNe8Q9NAKrCPFeNnOsn4+NFPpT2jxht2xwvRtsLK6GmTRp4NHuCieBFzsA0dyndbDki2
         xcYQ76cavRLPRaQE0FfsVBV74scEk/ZZIpOCiXu04KXnVkjQnb9XZUz3dYT+7Bhkkgxy
         wZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qSvun48v37mT8vMQFZwOiFqfakQpEhZZF8sbdHT2XoY=;
        b=dDrNR1K05Hs7ddpA5uhrUxo93j5IP7DvN0ub5BWugInPi/eo8ymR6JeNiMqsF5Ik6K
         Yv1sEtmEQrj1Ja2zidkeH0LyhBsDL8Xd+HAEXr1GjjglY3zA7jsQPpM2BISOAonAwRym
         1LtE0Q8dcEs3/LUGhTWxIxfSCB4BNJhe6FshbxzoPTHDGTDVhFmy16ulSsZmbjPCuMz2
         xnorSl+Do3bgLoS/4s4bfzxeHDtqorPle7oGgQA92OEJd8H+7ub5L7QuyxWbff5sQywp
         mxORRr+th0VEdMTliAdViTfrQI8YGYADi/Czde2lxEt6CPV1pEFlsQI7afwCSpypvDGQ
         pAIw==
X-Gm-Message-State: APzg51Am1nxxTyEFPqX4ennDsqgBMJJFitmdk59t31G5g6tR4sf9sQfw
        tv30meme6xubTYgv6Q+mAGty28sJ
X-Google-Smtp-Source: ANB0VdaicREXg2TzOtJJnOYXI3cduJ+vzFuP12YyyT6k56ISLuFlSCjBifS8nc6/XrHLCg3Z3e5npA==
X-Received: by 2002:a65:4289:: with SMTP id j9-v6mr7383624pgp.284.1536098405038;
        Tue, 04 Sep 2018 15:00:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id x23-v6sm10542pff.9.2018.09.04.15.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:00:04 -0700 (PDT)
Date:   Tue, 04 Sep 2018 15:00:04 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:39 GMT
Message-Id: <01e5cb3e9185633fd6a07fcbdde99727b414d94d.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 12/18] builtin rebase: support `--exec`
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

This commit adds support for the `--exec` option which takes a shell
command-line as argument. This argument will be appended as an `exec
<cmd>` command after each line in the todo list that creates a commit in
the final history.  commands.

Note: while the shell script version of `git rebase` assigned the empty
string to `cmd` by default, we *unset* it here because the code looks
nicer and it does not change the behavior.

The `--exec` option requires `--interactive` machinery.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1e35b82d9a..2547be9efe 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -93,6 +93,7 @@ struct rebase_options {
 	int autosquash;
 	char *gpg_sign_opt;
 	int autostash;
+	char *cmd;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -346,6 +347,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
+	add_var(&script_snippet, "cmd", opts->cmd);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -619,6 +621,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	const char *gpg_sign = NULL;
 	int opt_c = -1;
 	struct string_list whitespace = STRING_LIST_INIT_NODUP;
+	struct string_list exec = STRING_LIST_INIT_NODUP;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -691,6 +694,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    REBASE_AM),
 		OPT_BOOL(0, "autostash", &options.autostash,
 			 N_("automatically stash/stash pop before and after")),
+		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
+				N_("add exec lines after each commit of the "
+				   "editable list")),
 		OPT_END(),
 	};
 
@@ -915,6 +921,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (exec.nr) {
+		int i;
+
+		imply_interactive(&options, "--exec");
+
+		strbuf_reset(&buf);
+		for (i = 0; i < exec.nr; i++)
+			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
+		options.cmd = xstrdup(buf.buf);
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1197,5 +1214,6 @@ cleanup:
 	strbuf_release(&revisions);
 	free(options.head_name);
 	free(options.gpg_sign_opt);
+	free(options.cmd);
 	return ret;
 }
-- 
gitgitgadget

