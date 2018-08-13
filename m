Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9818C1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeHMOPM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:12 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:35239 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOPL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:11 -0400
Received: by mail-pl0-f43.google.com with SMTP id w3-v6so6783048plq.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sRMqHtlMQ5ZQATggfNs99hbRDo94e09DemqL5J2+GA8=;
        b=qPeAp/7YvgUFlZBOES+Jo7wmGSoRusxbq7+2w3LnwYqs371vnAPkoOAxDSABtuqlq3
         +kqjgSep4ysMcc9Lodd0c/DdrLIdGJaFWNL0m5QBZxKMHbj3HhOxCR8gIU+3d0LTcLfM
         YhZM/YozjRmjBBfrPDRlsdeucXxNnTRZbnudx6jJKiThNYt1YmUMwK6s82rRdRuWmHgT
         lWmOVjR1kfp4Ak734bHcpJZNz3wOJEMadY74BqiEb7r1wwu5GjKAY68K56XtIYMmqrZU
         69ea1MiGkXvV1FovFpDkvPquTnpnf+I9P0W9dd6b5lAy1V/ZCBi1zjSiRFncbmunX7Bw
         RwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sRMqHtlMQ5ZQATggfNs99hbRDo94e09DemqL5J2+GA8=;
        b=MX7JxrYfKvE0wqNhlpdq5TqIp/jZHZNPnDYvFd9iLiB7nIH5RQ73/9yZhcOXHgwHcV
         xayIpzAcwzUGj5VuvLul2PA1rjOFMhjRM5V2XuVXT9ou3ue/P7dXvjxmvzeoc4lIs1yj
         8m6FjI3sTIoXRcEijegsahcd9t6MwjVacOaisFQyVwbYRcJpRPAoTvJHKxd+LS3DSPTK
         8aIMW6w+qgrbKlqYHdlGW9nkZyI6aCiQ6ikLdbTYxK/6K/yu5tQOx1z7JUClGEDL9Bja
         /x3/acX0EBtZ+mNUquuSeNrLzmrIlcMwlLCEq0SOhKPcjlflFOHls8VZkVVQ9/KRmYk9
         0v8Q==
X-Gm-Message-State: AOUpUlHPKIwgvVqFnFZXVrf52PIMs/VOHTHYgYLO45ZLsuRyEi/O6e9n
        ZFmXariDHARifNobHN4HLVqTLa+4
X-Google-Smtp-Source: AA+uWPxmXX2Vsj3s1pHB1AUVX+JRLkBDDc3KYjhSWfb0R7FALxVyPoKIx1/8HPFkepbmPL9O0ILv9A==
X-Received: by 2002:a17:902:9893:: with SMTP id s19-v6mr16173160plp.130.1534159998812;
        Mon, 13 Aug 2018 04:33:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id g11-v6sm41450392pgi.90.2018.08.13.04.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:18 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:18 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:47 GMT
Message-Id: <32492c159b4fc02d690a3034d1a5deb21fcdd2ed.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 12/21] range-diff: use color for the commit pairs
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
index 6d75563f4..b1663da7c 100644
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
@@ -295,10 +314,13 @@ static void output_pair_header(struct strbuf *buf,
 
 	commit = lookup_commit_reference(the_repository, oid);
 	if (commit) {
+		if (status == '!')
+			strbuf_addf(buf, "%s%s", color_reset, color);
+
 		strbuf_addch(buf, ' ');
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
 	}
-	strbuf_addch(buf, '\n');
+	strbuf_addf(buf, "%s\n", color_reset);
 
 	fwrite(buf->buf, buf->len, 1, stdout);
 }
@@ -356,21 +378,24 @@ static void output(struct string_list *a, struct string_list *b,
 
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

