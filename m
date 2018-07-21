Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46061F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeGUW7T (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:19 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:35530 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeGUW7T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:19 -0400
Received: by mail-pl0-f53.google.com with SMTP id w3-v6so6625182plq.2
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Uwd+SewtQYzXRPK+y7acusgM1Xp5zD9+EVHucwfv20=;
        b=UVGmpTLKkHyPbfzsdbp0qtaHeeIONrMPm7cRPG6zG0YVaYIIrcDw64Th4l1DTTdOdb
         Vg7TTzULmb75AeAbWnAHWWjzcJn472bYCuoorWrvF9hCbOkDgLml+WorXewnc0l2KCWo
         3c4Wck6+B9EpiZ1y1zEZ3R5g255qtX328lT2WXeqUKJK9+bT5zWr2dOreZjl9bdu1sH0
         jMOM00y6rrhqS0+6lGKE9uUdzRfpBEUjiRR3lM30MwmuGNaE+MZcypwyeCniibP9x7QM
         sQk4PiX69kzfQIEOtxvyTOTiJAp5hvxvralurAkvt5Gx5cNoVHrQz8ff2uMGt1qBJ5b1
         1sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Uwd+SewtQYzXRPK+y7acusgM1Xp5zD9+EVHucwfv20=;
        b=Mym1Pw478NKA2QC9ospIfsAnY8NN4mz8CI08ENclM6DtMN3RmnCiZpo0v+LXd2CUN+
         e1E3vhxg9wUhp9mNas4mNuxzHfTuaVru4OOczpNPvYauft4HQzDx6yWaFzwNqJVip2rQ
         WaNjbXEomxqxDnUXNw7ewM8Xf7/7NpUdwkMp8TLDY1bWdiwWvzU29jriusZ4KrBLwf8K
         8+4nUWT4NjVwDUBQ6mhFXE/UbeeOMCpau6CwwYCLSbxbz7AcWoVbuSNgR6/E2VbGDytF
         ujINEcAeS0YgUSQm60/3aAyHbOKaf8tFw93Trr5CHktS166WV9NmVCPCjQYcyrttnkMS
         ylOw==
X-Gm-Message-State: AOUpUlGRiISg/Lbo9XMey0kSEKk9svBrFcXHTaK86Zxswn6y8TkvzKvt
        MbDTmR/VNsfoVKZhlm6VE1isNuuZ
X-Google-Smtp-Source: AAOMgpdNs2FnydKGSWaAXZkIRzAqLcXVN9hxVqyojTofXM6rv7W2HCjZdm8hCWo1oSr6etNFNnxbmw==
X-Received: by 2002:a17:902:64c2:: with SMTP id y2-v6mr7098292pli.53.1532210702351;
        Sat, 21 Jul 2018 15:05:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id b192-v6sm8078736pga.2.2018.07.21.15.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:05:01 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:05:01 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:33 GMT
Message-Id: <fb83ce71af8aa6266c082dad0604e5cb2b9f61d8.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 12/21] range-diff: use color for the commit pairs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Arguably the most important part of `git range-diff`'s output is the
list of commits in the two branches, together with their relationships.

For that reason, tbdiff introduced color-coding that is pretty
intuitive, especially for unchanged patches (all dim yellow, like the
first line in `git show`'s output) vs modified patches (old commit is
red, new commit is green). Let's imitate that color scheme.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 3fc3a4018..ab1e71e10 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -258,34 +258,53 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	free(b2a);
 }
 
-static void output_pair_header(struct strbuf *buf,
+static void output_pair_header(struct diff_options *diffopt,
+			       struct strbuf *buf,
 			       struct strbuf *dashes,
 			       struct patch_util *a_util,
 			       struct patch_util *b_util)
 {
 	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
 	struct commit *commit;
+	char status;
+	const char *color_reset = diff_get_color_opt(diffopt, DIFF_RESET);
+	const char *color_old = diff_get_color_opt(diffopt, DIFF_FILE_OLD);
+	const char *color_new = diff_get_color_opt(diffopt, DIFF_FILE_NEW);
+	const char *color_commit = diff_get_color_opt(diffopt, DIFF_COMMIT);
+	const char *color;
 
 	if (!dashes->len)
 		strbuf_addchars(dashes, '-',
 				strlen(find_unique_abbrev(oid,
 							  DEFAULT_ABBREV)));
 
+	if (!b_util) {
+		color = color_old;
+		status = '<';
+	} else if (!a_util) {
+		color = color_new;
+		status = '>';
+	} else if (strcmp(a_util->patch, b_util->patch)) {
+		color = color_commit;
+		status = '!';
+	} else {
+		color = color_commit;
+		status = '=';
+	}
+
 	strbuf_reset(buf);
+	strbuf_addstr(buf, status == '!' ? color_old : color);
 	if (!a_util)
 		strbuf_addf(buf, "-:  %s ", dashes->buf);
 	else
 		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
 			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
 
-	if (!a_util)
-		strbuf_addch(buf, '>');
-	else if (!b_util)
-		strbuf_addch(buf, '<');
-	else if (strcmp(a_util->patch, b_util->patch))
-		strbuf_addch(buf, '!');
-	else
-		strbuf_addch(buf, '=');
+	if (status == '!')
+		strbuf_addf(buf, "%s%s", color_reset, color);
+	strbuf_addch(buf, status);
+	if (status == '!')
+		strbuf_addf(buf, "%s%s", color_reset, color_new);
 
 	if (!b_util)
 		strbuf_addf(buf, " -:  %s", dashes->buf);
@@ -298,12 +317,15 @@ static void output_pair_header(struct strbuf *buf,
 		const char *commit_buffer = get_commit_buffer(commit, NULL);
 		const char *subject;
 
+		if (status == '!')
+			strbuf_addf(buf, "%s%s", color_reset, color);
+
 		find_commit_subject(commit_buffer, &subject);
 		strbuf_addch(buf, ' ');
 		format_subject(buf, subject, " ");
 		unuse_commit_buffer(commit, commit_buffer);
 	}
-	strbuf_addch(buf, '\n');
+	strbuf_addf(buf, "%s\n", color_reset);
 
 	fwrite(buf->buf, buf->len, 1, stdout);
 }
@@ -361,21 +383,24 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(&buf, &dashes, a_util, NULL);
+			output_pair_header(diffopt,
+					   &buf, &dashes, a_util, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(&buf, &dashes, NULL, b_util);
+			output_pair_header(diffopt,
+					   &buf, &dashes, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			output_pair_header(&buf, &dashes, a_util, b_util);
+			output_pair_header(diffopt,
+					   &buf, &dashes, a_util, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, diffopt);
-- 
gitgitgadget

