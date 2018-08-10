Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC751F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeHKAqa (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:30 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:41918 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeHKAqa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:30 -0400
Received: by mail-pg1-f169.google.com with SMTP id z8-v6so4983438pgu.8
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sRMqHtlMQ5ZQATggfNs99hbRDo94e09DemqL5J2+GA8=;
        b=Udzzir7PJ3Xr9zEBbPeu/+xz29u1ErNwlCBDVrRmGkuVU8cxO5hNv8+rjPes2dGrE/
         snK5IBavNB81jMgu/NnxI14W8IH6PXq8NVb6geFyRIgyBivJ4dhrNanAvOwhJC1PIyQj
         QDSIKfVctXY1IAdYSx8QCt1WJ36EkIW63MtoWUCiC8if3PbqzrsRtvAYrhNN5rcP0WUO
         dWh+MyqjL3z+vlFbIXn/EBShskCfAvpcoWHmQvsKAO3RV6B/w1d3YKN2bZMBj6p8MTIY
         HnjllqyQ1Bbtgwz5RRLPH51VMB/vvLGTeBhrMnKHFO8oouexdIeRHe2a/m4F2nBThvsk
         OfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sRMqHtlMQ5ZQATggfNs99hbRDo94e09DemqL5J2+GA8=;
        b=DKGakFb6fQnKGHZWCTPIXVwxBSk4hgZr1VKQKDP1W/JACHvd2KGt/5a8bT8hZythbD
         FZ+vXFcyWkfdbFPDefFSedo+epZEExaabkYQplX07xq1AzPlgZbq0pBVVgy8lKmEi3Yh
         YqSH1f4znkv1zf1NXsDuxN6PbdqeR8TrWxJPzciCsrWuTPNLA1IJ3Z44zw+9GKpSbETN
         OzIEfQoF/KvHDCz53Hu8H04cUfaYoAMdW5FjyDOuJg3IKPNPY/8u+v/7mJrKPOPIk48e
         AaAdCq32JPQv4lcSQu7t+tRHKXfxZ9doV8z8n8eHLbEj845YS5VApjfdPyJHXlCbWb+M
         qBzA==
X-Gm-Message-State: AOUpUlEyluuXUX+qcRKsCgGg+ePDlMiumD2lBHEjfOjnNqM+9uBKo1od
        3oDwcyrqfkEqGReUDUbGB/7IlNnq
X-Google-Smtp-Source: AA+uWPzcx2inX3P+D3kPVY6rd4AqBACLGPY/7q5lJXNVWtemd8P6EsjKHxwyEi6dtG7EAlD0TX2fjw==
X-Received: by 2002:a63:e318:: with SMTP id f24-v6mr7935843pgh.175.1533939283919;
        Fri, 10 Aug 2018 15:14:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id f5-v6sm11467182pga.58.2018.08.10.15.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:43 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:43 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:14 GMT
Message-Id: <f48b62644bc9cd7a65cbcc522501e37359385089.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 12/21] range-diff: use color for the commit pairs
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

