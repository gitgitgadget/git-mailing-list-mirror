Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A45E21F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeIEC1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:02 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:38033 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIEC1B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:01 -0400
Received: by mail-pl1-f169.google.com with SMTP id u11-v6so2258276plq.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d1hsLx9O+J232x7Va7evyWOyMeY9nohOuUXZB0Ufhio=;
        b=q8qxhA3Hv4KENv4G3maiciYQvgI3307QW80QBlf7s/MR1wjMIF9e6URJmFXt3qXIV0
         HzbSKN34CER9YGUmr1Ss8m0vamwJ1D0UdYK7z6oRJpSwS2Wp6JZxqmvBtTzS4N/zNkp0
         tdPOioT+EtQy2W1ahacMeVqtdKhudpfjQoOnC5eaCmO7VY87VE3f8p2sC3BLjWL2q3RA
         0MPtUb/CieTlIBd5l3YZEA3xcz+/bXbZ7XmZx5ya2aeOr6jZ3Yb9De45qFGyyj+FK1fI
         ETwXVf8qFfy9dSirBd7FIgSn15LH3qQz1NoXN6GIRm9uCHYBsiXdd9zTNGYL5maj3p3K
         Y/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d1hsLx9O+J232x7Va7evyWOyMeY9nohOuUXZB0Ufhio=;
        b=OnbUJWGqQjUxyzocCl+qqXsGbkcYdbVmvGc9T6RMHkohM5IZaXX82K1qE9qEnzCjhO
         V/gzg05apRkBUx8uCjW/Aybgjt7JXKk97zJ6uPWB8zYWUaD1JYsEiw15fpBIypostW5v
         Ex+kWooZw2FfgFr57Dyh7njcBTFMTkcz0TDY6VqbjYBUfoqbkWG8oWvpZEUDzOLh7c7J
         zWXGktbwi65TpcJnU78xtUW5zCuPFgyEY/5EEXh5ptpVHboy2q0gdpT8x5pEIxQAbvOD
         I8h7Kmk4z1lxWwcUqusIwVhm+L686gPDjWSMEMiZHilW0SpYdfUHXrH0rMMgLGTGr0+H
         sPfw==
X-Gm-Message-State: APzg51Dz4v9nDFFoDsQezEOanzpI2jvriA9fXuM8lsZ/PSA/eKZcy1sv
        bCaYqgoExrfO1MbYtStIW1JXN61H
X-Google-Smtp-Source: ANB0VdYpEY/+xAPhC1mNrYq9scyvl10T7UlYeGRW09RsYlvRVj0Nvwtyuv9+Txjqoy1YnV2GvWt2Gw==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr36061663plo.100.1536098396801;
        Tue, 04 Sep 2018 14:59:56 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id r1-v6sm9731pfi.17.2018.09.04.14.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:59:56 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:59:56 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:33 GMT
Message-Id: <83bb27750972a39c90d78ecebd07ac32745ab6c4.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/18] builtin rebase: support `ignore-date` option
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

This commit adds support for `--ignore-date` which is passed to `git am`
to easily change the dates of the rebased commits.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7490d215ef..42ee040da3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -527,6 +527,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
 	int committer_date_is_author_date = 0;
+	int ignore_date = 0;
 	int ignore_whitespace = 0;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
@@ -550,6 +551,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &committer_date_is_author_date,
 			 N_("passed to 'git am'")),
+		OPT_BOOL(0, "ignore-date", &ignore_date,
+			 N_("passed to 'git am'")),
 		OPT_BIT('f', "force-rebase", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
@@ -779,6 +782,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (ignore_whitespace)
 		strbuf_addstr(&options.git_am_opt, " --ignore-whitespace");
 
+	if (ignore_date) {
+		strbuf_addstr(&options.git_am_opt, " --ignore-date");
+		options.flags |= REBASE_FORCE;
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
gitgitgadget

