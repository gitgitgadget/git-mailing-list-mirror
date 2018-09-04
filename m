Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD641F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeIEByP (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46403 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so2302199pfn.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8HWKblpc5nkUeTNutdCBJO/4TnwgOWlARliJzU9iANo=;
        b=jEsRo1mpptK1EKEH5QnyCM1hUbZSVJ95h0p4I/UFuerOulVi/9j6krRA1+nzR0RuL0
         YAQwKfhJd9q6jkDAETnktNOz5PQ6Mu4YRYd82uy9pWpwoMPmKNfJn2y4ZNvUnwSBUhSX
         ZB3ol3yLQo7SuWdFkL+A2/7YdjPXxViVKWvu9hUXuglZulFk645WUL0NVf68DSAhgZ2K
         Wzb5p8T1MvDjpiYWXQ3TaAPg/Zab+qbCa9PTtLd118apQ1epADI0dU40JRjv9h7kI85E
         PNTjOE+Nv0M4xZSZOstnULydmmfaOaMxv/BaDZ0+0SwWWDltd4K1zHhdLu01UcNRLtqW
         PmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8HWKblpc5nkUeTNutdCBJO/4TnwgOWlARliJzU9iANo=;
        b=uQFoTlxkV8jTVyDLP3pYFlcVNXJwIGTJXLzrwVnqkl8DLHpnKr4l+Bujmo4WV+/mFN
         GVy0th4E0Acvv9VnWRrfnvgUQizlJqRqAk08c+cbFMDiDUfQEDHyl3ZkFhnl3K5UCsy/
         Z+CmcLstE87oYLJ7VTWGDEmd1eYemHkVwYaGlpz5n2f/ZBG+nzlUxRv+F8tC+o46nQzM
         ny/hX7g1cLpBudknbtXMCcDs1wjBnNWL+oPxtpVE/OSxq2D1KCXyxBZWB5vgo6IwhYc+
         07OcgFkYhkCwDGWbtO65WvdJ+g54lw2EVTerjqfwEM28YK0SqKJpCqfV5XxhY8wH9f8i
         6cXA==
X-Gm-Message-State: APzg51BuX1QYSK2pdFqt+NOU5abi5hFX026U0ji7r6vkEpFJ5zGVrMMB
        xGEPZBbtzGpFoA6mjU1GaRC1GT7d
X-Google-Smtp-Source: ANB0VdY4giUUMbj+NHtrstl+oiYZ8OEVbuIdLhEqSqEUb/sgQAFTBZH6KReHzk/9UuR+5pA/TEh23g==
X-Received: by 2002:a63:2c8e:: with SMTP id s136-v6mr33978405pgs.390.1536096438318;
        Tue, 04 Sep 2018 14:27:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id n29-v6sm37370823pgl.30.2018.09.04.14.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:17 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:17 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:27:01 GMT
Message-Id: <78d90e67de746bdf7269a1bf500852ed924eed87.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/11] builtin rebase: support --force-rebase
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

In this commit, we add support to `--force-rebase` option. The
equivalent part of the shell script found in `git-legacy-rebase.sh` is
converted as faithfully as possible to C.

The --force-rebase option ensures that the rebase does not simply
fast-forward even if it could.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d67df28efc..8a7bf3d468 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -86,6 +86,7 @@ struct rebase_options {
 		REBASE_NO_QUIET = 1<<0,
 		REBASE_VERBOSE = 1<<1,
 		REBASE_DIFFSTAT = 1<<2,
+		REBASE_FORCE = 1<<3,
 	} flags;
 	struct strbuf git_am_opt;
 };
@@ -181,6 +182,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->flags & REBASE_VERBOSE ? "t" : "");
 	add_var(&script_snippet, "diffstat",
 		opts->flags & REBASE_DIFFSTAT ? "t" : "");
+	add_var(&script_snippet, "force_rebase",
+		opts->flags & REBASE_FORCE ? "t" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -409,6 +412,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
 			N_("do not show diffstat of what changed upstream"),
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
+		OPT_BIT('f', "force-rebase", &options.flags,
+			N_("cherry-pick all commits, even if unchanged"),
+			REBASE_FORCE),
+		OPT_BIT(0, "no-ff", &options.flags,
+			N_("cherry-pick all commits, even if unchanged"),
+			REBASE_FORCE),
 		OPT_END(),
 	};
 
@@ -551,7 +560,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
 		int flag;
 
-		if (!(options.flags & REBASE_NO_QUIET))
+		if (!(options.flags & REBASE_FORCE)) {
+			if (!(options.flags & REBASE_NO_QUIET))
+				; /* be quiet */
+			else if (!strcmp(branch_name, "HEAD") &&
+				 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+				puts(_("HEAD is up to date."));
+			else
+				printf(_("Current branch %s is up to date.\n"),
+				       branch_name);
+			ret = !!finish_rebase(&options);
+			goto cleanup;
+		} else if (!(options.flags & REBASE_NO_QUIET))
 			; /* be quiet */
 		else if (!strcmp(branch_name, "HEAD") &&
 			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
-- 
gitgitgadget

