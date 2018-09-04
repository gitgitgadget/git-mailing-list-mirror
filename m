Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F59F1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeIEC1M (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46569 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeIEC1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id t19-v6so2238664ply.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TVVgKOU7ZkL9cTbnbgPhXedEy3MFWc0orz1G9X7ZM50=;
        b=HyqloKUBI1v3TLwFrL2K57BhhTTc58hcVCIsjfdcqJzWTTYo+mUfAMeiZLI/kPOZLc
         t9I8Tyi0DJRfeonaBFVVeOXsmZ2UbYfKlj+J7SVkjzso6C/X21VocMbuTICon72Uczqi
         VjLEKWcXkKldqifNZfXH9o4qm2nlpPLhhO+GkxnaFOf/UTvMGAWK4ejOmstE49K+pMFA
         u5smQilbtgpQ9Syp2EDgOEzqMHZCh5rpz5hypiVaXj11dzNnxXItGXh2Vtv5ZrZkvGNi
         8KJRcE5vupqb3n6uuSxU8aKpes2a3/HwEYSu4MOuC/4A6RO9SWIerOsPwd2GSqKZ4AWE
         hJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TVVgKOU7ZkL9cTbnbgPhXedEy3MFWc0orz1G9X7ZM50=;
        b=ktn+Jip2lQqinglvno7qxZm2aow1Q0bwxZ/HUIFwfrqks7Zcu59VZzpQwvkbZ8cnAL
         7KAXMGseLX3HDAjXx4qvcziSDSbDASY4DUNrhIHJHDm8gELyGE/lfygiyYQEIKHB1YXr
         lFt7ohLALPPdqpo812cDwhyVaBKqoimC5dG/YxD1j523OUOb1SD+mD5jqQgHEMvoW38v
         bP51k6tyGL7VxWEAxEtqZLFN+mkndiBwnczbmZIz+8mWWQmCkV9oco5UZoyswp8CRFMv
         Q6qTXQhhWUAt9JpqNPIQ4plnNKXUkk9CQCTGmzAebExlhoCzQsQWquNxckiUZmpdPYg6
         lQAQ==
X-Gm-Message-State: APzg51BFWGUZnvm6eNq7tTygUuUL288A2z9yAHq1KdvV/nXE4RaJ0hsD
        hFqq1IrRno7Jdr2bgb30SHYuCMFm
X-Google-Smtp-Source: ANB0VdYT+72ObJ4U+gPtTAHq4H90ejN+JD2sEzc8o7pJuFFXKY7IKEEGQqJzER3WBBD7VtHVsDnneg==
X-Received: by 2002:a17:902:704c:: with SMTP id h12-v6mr35529662plt.237.1536098406414;
        Tue, 04 Sep 2018 15:00:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id i26-v6sm28452173pfo.107.2018.09.04.15.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:00:05 -0700 (PDT)
Date:   Tue, 04 Sep 2018 15:00:05 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:40 GMT
Message-Id: <1c723ad5920a6282139c8fc0bb2f9f3b2e2cede9.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 13/18] builtin rebase: support `--allow-empty-message`
 option
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

This commit introduces the `--allow-empty-message` option to
`builtin/rebase.c`. The motivation behind this option is: if there are
empty messages (which is not allowed in Git by default, but can be
imported from different version control systems), the rebase will fail.

Using `--allow-empty-message` overrides that behaviour which will allow
the commits having empty messages to continue in rebase operation.

Note: a very recent change made this the default in the shell scripted
`git rebase`, therefore the builtin rebase does the same.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2547be9efe..3e37603da4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -94,6 +94,7 @@ struct rebase_options {
 	char *gpg_sign_opt;
 	int autostash;
 	char *cmd;
+	int allow_empty_message;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -348,6 +349,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
 	add_var(&script_snippet, "cmd", opts->cmd);
+	add_var(&script_snippet, "allow_empty_message",
+		opts->allow_empty_message ?  "--allow-empty-message" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -598,6 +601,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.flags = REBASE_NO_QUIET,
 		.git_am_opt = STRBUF_INIT,
 		.allow_rerere_autoupdate  = -1,
+		.allow_empty_message = 1,
 	};
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
@@ -697,6 +701,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
 				N_("add exec lines after each commit of the "
 				   "editable list")),
+		OPT_BOOL(0, "allow-empty-message",
+			 &options.allow_empty_message,
+			 N_("allow rebasing commits with empty messages")),
 		OPT_END(),
 	};
 
-- 
gitgitgadget

