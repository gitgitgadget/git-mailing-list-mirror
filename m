Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12161F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeIEC1A (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:00 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:42125 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIEC1A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:00 -0400
Received: by mail-pf1-f177.google.com with SMTP id l9-v6so2347032pff.9
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dkHnOCuux6Cxwy6TpYAkcK0scF8b8FHD3zlItGzpSG4=;
        b=SKc4IjQaJnG35L2asaS0ereRjlka0TOE9xP2TDrhN7yVFD0TXOnnWAusNNCRY1A1zW
         JxPu2ukwE+2bgObNA0QztQBjQ1lHkUEfmkZ83qIvTLukxqsmBlvvun9jUENnGpdXfzl+
         BHCNANqXAihzCIVATR2vcE3VhYPkjIPdUGnHo44WUGcfMMlOg7GzfjmjwG+920Hx9jVF
         Kxh1bxRi+6QHU2WSXVIM/L+gClE2PozAN9opjd12Gh48k+CC/5hDGsliJMob2Zlt+H07
         gk2oNNYPZ04i2jSorAMM0GDZHSeqo1BwrcPRRXtXDpwEMwJGuHLxWQhnKClrHUZDNtvT
         lT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dkHnOCuux6Cxwy6TpYAkcK0scF8b8FHD3zlItGzpSG4=;
        b=W4Y3wlToC0p4qw7Xau/KIpHUWxHmAp8ktt/bmqpNncw8tPoItsw9Wk4mqEIMpzD2b+
         dTH/jsNV70IG/tJzLzndaGIqlKl9GjBMso96kGWuM418UaB5tAm+NCGMeJF3EVI7TMxJ
         uK3pLbyTqn4AOFW3cdUllXVXCVopz5FgnISkyMVl5wRx1Y3W/YC1C2CJ/LjQGOEjGAT/
         PAjZEcVkzN3q2eQG5vIzeZgLhCFSkSN3es4h/SXnnjuuuVL8Zzqtbu94AoB3ELYP2Qiz
         XOfnArXLPK5hNJUEQAjjuXAcUrNjEExpBb9C7GNEsAZEWJDfLh1L7ONcWaip4p8jIE0D
         XGeg==
X-Gm-Message-State: APzg51B3BGQOPXUZuC8WG8JQkBIcjFh18DbyJyXvylT0+MREJSBZANka
        eJnSI7HqFxfc/rIQ4pGcOe9QyJwU
X-Google-Smtp-Source: ANB0VdYD10xAyPoHkZsFDN5ZYB9i226zP910gfwgr3ykgRHFtxsNk86ndH5F4WduhuTe8molnOo+cQ==
X-Received: by 2002:aa7:86cb:: with SMTP id h11-v6mr36612085pfo.58.1536098395453;
        Tue, 04 Sep 2018 14:59:55 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id k26-v6sm38349865pfb.167.2018.09.04.14.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:59:54 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:59:54 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:32 GMT
Message-Id: <f04394a5002859d7e95f3bfc518028dcfb6d202d.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/18] builtin rebase: support `ignore-whitespace` option
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

This commit adds support for the `--ignore-whitespace` option
of the rebase command. This option is simply passed to the
`--am` backend.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index eef16206c2..7490d215ef 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -527,6 +527,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
 	int committer_date_is_author_date = 0;
+	int ignore_whitespace = 0;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -542,6 +543,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
 			N_("do not show diffstat of what changed upstream"),
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
+		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
+			 N_("passed to 'git apply'")),
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -773,6 +776,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.flags |= REBASE_FORCE;
 	}
 
+	if (ignore_whitespace)
+		strbuf_addstr(&options.git_am_opt, " --ignore-whitespace");
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
gitgitgadget

