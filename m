Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1E01F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeGCL0c (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:32 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38367 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeGCL01 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id j17-v6so879037pfn.5
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=u4i4A4EyzsEFDis/9O1em9+tU+KwWTWqI0OqK2V/ow4=;
        b=KxrIFrHeLUiRieztEMqhkz4CQhp3i6ZptEwmVhjSvOFcjwS6I0GHmmv3HbTMLS1iYg
         0GKqTiaNCqRw8BWv4yhA55ATE1I3rAC4CkDzWyIggK5hlXXZSrcUVceotjBvFX/nok0K
         on+MB8UwEZ/d6pYTAmTJzRW4L9XJdMq+oz7tw7cJquWGZp5+iBjdYWSUYG+MPCCN2Zyz
         oSOPgcMT074VVRK4unDF25hRgJffH2Nv6SVHHg9X+d44hMUACSyf0SiOOfkv97243Fig
         AkR0X315jtLZ2BdfqezvcaeOOpPqjWnZvPYfgjrXbl/S2moe+PtAlbtXv6yACFU5k0qZ
         yrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=u4i4A4EyzsEFDis/9O1em9+tU+KwWTWqI0OqK2V/ow4=;
        b=WxzR/j50O3PH2DfyFA6fCyj27BuKIoacULhTeYmzvRiKObv8mM+RGqYiKJC15x0JUD
         f6InTjlgppM/XXGDFSb4p3LdVWS5rEcQVOKjcup6KcfOt1i3BOUa31/D1pLYfXTpnZJI
         JlMoMdGmzB6NSGRxgvXDLW0kSKeImwxMjMtVrYzfOP9wApfkGSqgW14gvTIiizW+idRn
         iMeGlY+dec65Gqkdm8fh0l9jb/OJ5Nn6/d9H+HdKXJmX4gjpt2laqmj7mDN+ayPnXWFU
         weMN3le9eYtYvpHjT03rgofVblpLUV9jztJKrxlNFjYG+89BBdAGHODCjImhfG5oCor2
         o2zA==
X-Gm-Message-State: APt69E2npPZBxUeZ2BR4PpVuyj/ipTzHvljehqaVgMdAnpmLBb6YGXae
        8nlRlhbJtGHSC/e+MJ0Da/urSg==
X-Google-Smtp-Source: ADUXVKJOxtnN8+Er6KKYr1T29Q4/lxGnjtMCAvyWsJcRZ433lxzOtdlQ1BFpdB4J59S/aV1/wguqFw==
X-Received: by 2002:a65:61af:: with SMTP id i15-v6mr25506146pgv.349.1530617186784;
        Tue, 03 Jul 2018 04:26:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id k10-v6sm2142673pgp.55.2018.07.03.04.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:26 -0700 (PDT)
Message-Id: <7273cc647971368d087b2bc76d3f44d8ca166123.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 3 May 2018 01:32:19 +0200
Subject: [PATCH v3 12/20] range-diff: use color for the commit pairs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
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
 range-diff.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 8df73da4e..870c3680c 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -254,13 +254,19 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	free(b2a);
 }
 
-static void output_pair_header(struct strbuf *buf,
+static void output_pair_header(struct diff_options *diffopt, struct strbuf *buf,
 			       struct patch_util *a_util,
 			       struct patch_util *b_util)
 {
 	static char *dashes;
 	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
 	struct commit *commit;
+	char status;
+	const char *color_reset = diff_get_color_opt(diffopt, DIFF_RESET);
+	const char *color_old = diff_get_color_opt(diffopt, DIFF_FILE_OLD);
+	const char *color_new = diff_get_color_opt(diffopt, DIFF_FILE_NEW);
+	const char *color_commit = diff_get_color_opt(diffopt, DIFF_COMMIT);
+	const char *color;
 
 	if (!dashes) {
 		char *p;
@@ -270,21 +276,33 @@ static void output_pair_header(struct strbuf *buf,
 			*p = '-';
 	}
 
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
 		strbuf_addf(buf, "-:  %s ", dashes);
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
 		strbuf_addf(buf, " -:  %s", dashes);
@@ -297,12 +315,15 @@ static void output_pair_header(struct strbuf *buf,
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
@@ -360,21 +381,21 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(&buf, a_util, NULL);
+			output_pair_header(diffopt, &buf, a_util, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(&buf, NULL, b_util);
+			output_pair_header(diffopt, &buf, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			output_pair_header(&buf, a_util, b_util);
+			output_pair_header(diffopt, &buf, a_util, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, diffopt);
-- 
gitgitgadget

