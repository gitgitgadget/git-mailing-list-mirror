Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560C51F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeHMOPQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46375 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbeHMOPO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14-v6so7368871pgv.13
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QskaeRksTPD0DWmgRnd+x3euVP2fFo2wA4NsQhYbCbQ=;
        b=Py2Nyh8ZfYSj52PE2TIR121jBhcYUCUxzx7Guoh5pHaCDGcreZ8kzGdcqlrUkdaCRi
         mQ0v3ZkWNEzXtSrZAgWU3JaloFB4wK0xARR4yhrT2d/pPDf0xOP+HOHOp6bni9Iz3V23
         sBQz5o76I7pWFpkDM7bJsHg252WttP8IY2FksbpTCM8qoSL362NXew5r+nO6n+5SxQGF
         nyRIdJSucGaKBGQezsDaD2ockPbSr4qm68KRuuO6pu0qBYvCI6nB4GHFFIa6xILSSVhq
         kWj3FruaQADa76S1TXVpCTNxHEJ7PaYAoIytNWwl/rcq4Koy+7iKeZqpRgyKNzDGF+jK
         xJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QskaeRksTPD0DWmgRnd+x3euVP2fFo2wA4NsQhYbCbQ=;
        b=h5D4+cTE51xTOEGtYYA8bNdCv6m0K+dy4g+TS6Wa+0vHUzmPEe4lEMuqlRxJSTTz6W
         xRecgTuf8ISi1qhVFcEo7R8s8XboTKCuTwdd0x7LSQzPi7BAH4yVMAucxgVxHJ+MmjQr
         EaDwPtrl1LNuj8eWxMa/48uGUellW+ZsBQkKH/XsfpEsfAhtJngA6yudDMT+hVuAZQs/
         ZEv1pTiBxku9Jae3u/DAe83gJTv43/LN/kgmH1YeaCd9kdcMmH2/dmAH6cpTh0cKOz+o
         ZE2c1p5Een1AQSlklcLgg4GP2F9+UqIcU17cxT4Tax9p/GDfbPMCQP6T9uahku97Fe8J
         gYHw==
X-Gm-Message-State: AOUpUlHRqEdm/mj32IAcHECWt1J7Acaq5eNnbktr5iXHtj7tmHNwIzoC
        +ZAUb1RfzbSo1G2DR1+pM4bTya5q
X-Google-Smtp-Source: AA+uWPxcy/vvKyqbPYArj8xLIOL/yFVJTQvaHVNbpf/KtitQVcNOjvnVdbKo+COWnIfgBjvtZV+V5Q==
X-Received: by 2002:a62:5302:: with SMTP id h2-v6mr18785394pfb.183.1534160001920;
        Mon, 13 Aug 2018 04:33:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p66-v6sm37965085pfd.65.2018.08.13.04.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:20 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:20 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:49 GMT
Message-Id: <f1c86f606e018c34230dc016ffdc25a3c70bf840.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 14/21] diff: add an internal option to dual-color diffs of
 diffs
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

When diffing diffs, it can be quite daunting to figure out what the heck
is going on, as there are nested +/- signs.

Let's make this easier by adding a flag in diff_options that allows
color-coding the outer diff sign with inverted colors, so that the
preimage and postimage is colored like the diff it is.

Of course, this really only makes sense when the preimage and postimage
*are* diffs. So let's not expose this flag via a command-line option for
now.

This is a feature that was invented by git-tbdiff, and it will be used
by `git range-diff` in the next commit, by offering it via a new option:
`--dual-color`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 diff.h |  1 +
 2 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 9c4bd9fa1..e6c857abf 100644
--- a/diff.c
+++ b/diff.c
@@ -609,14 +609,18 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
+static void emit_line_0(struct diff_options *o,
+			const char *set, unsigned reverse, const char *reset,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	int nofirst;
 	FILE *file = o->file;
 
-	fputs(diff_line_prefix(o), file);
+	if (first)
+		fputs(diff_line_prefix(o), file);
+	else if (!len)
+		return;
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
@@ -634,8 +638,10 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 	}
 
 	if (len || !nofirst) {
+		if (reverse && want_color(o->use_color))
+			fputs(GIT_COLOR_REVERSE, file);
 		fputs(set, file);
-		if (!nofirst)
+		if (first && !nofirst)
 			fputc(first, file);
 		fwrite(line, len, 1, file);
 		fputs(reset, file);
@@ -649,7 +655,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
 }
 
 enum diff_symbol {
@@ -1168,7 +1174,8 @@ static void dim_moved_lines(struct diff_options *o)
 
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
-				const char *line, int len, char sign,
+				const char *line, int len,
+				const char *set_sign, char sign,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -1179,14 +1186,20 @@ static void emit_line_ws_markup(struct diff_options *o,
 			ws = NULL;
 	}
 
-	if (!ws)
-		emit_line_0(o, set, reset, sign, line, len);
-	else if (blank_at_eof)
+	if (!ws && !set_sign)
+		emit_line_0(o, set, 0, reset, sign, line, len);
+	else if (!ws) {
+		/* Emit just the prefix, then the rest. */
+		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
+			    sign, "", 0);
+		emit_line_0(o, set, 0, reset, 0, line, len);
+	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(o, ws, reset, sign, line, len);
+		emit_line_0(o, ws, 0, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set, reset, sign, "", 0);
+		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
+			    sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
@@ -1196,7 +1209,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 					 struct emitted_diff_symbol *eds)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set, *meta, *fraginfo;
+	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
 	struct strbuf sb = STRBUF_INIT;
 
 	enum diff_symbol s = eds->s;
@@ -1209,7 +1222,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, reset, '\\',
+		emit_line_0(o, context, 0, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
@@ -1236,7 +1249,18 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	case DIFF_SYMBOL_CONTEXT:
 		set = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line_ws_markup(o, set, reset, line, len, ' ',
+		set_sign = NULL;
+		if (o->flags.dual_color_diffed_diffs) {
+			char c = !len ? 0 : line[0];
+
+			if (c == '+')
+				set = diff_get_color_opt(o, DIFF_FILE_NEW);
+			else if (c == '@')
+				set = diff_get_color_opt(o, DIFF_FRAGINFO);
+			else if (c == '-')
+				set = diff_get_color_opt(o, DIFF_FILE_OLD);
+		}
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1263,7 +1287,20 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			set = diff_get_color_opt(o, DIFF_FILE_NEW);
 		}
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line_ws_markup(o, set, reset, line, len, '+',
+		if (!o->flags.dual_color_diffed_diffs)
+			set_sign = NULL;
+		else {
+			char c = !len ? 0 : line[0];
+
+			set_sign = set;
+			if (c == '-')
+				set = diff_get_color_opt(o, DIFF_FILE_OLD);
+			else if (c == '@')
+				set = diff_get_color_opt(o, DIFF_FRAGINFO);
+			else if (c != '+')
+				set = diff_get_color_opt(o, DIFF_CONTEXT);
+		}
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1291,7 +1328,20 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line_ws_markup(o, set, reset, line, len, '-',
+		if (!o->flags.dual_color_diffed_diffs)
+			set_sign = NULL;
+		else {
+			char c = !len ? 0 : line[0];
+
+			set_sign = set;
+			if (c == '+')
+				set = diff_get_color_opt(o, DIFF_FILE_NEW);
+			else if (c == '@')
+				set = diff_get_color_opt(o, DIFF_FRAGINFO);
+			else if (c != '-')
+				set = diff_get_color_opt(o, DIFF_CONTEXT);
+		}
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
@@ -1482,6 +1532,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
 	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
+	const char *reverse = ecbdata->color_diff ? GIT_COLOR_REVERSE : "";
 	static const char atat[2] = { '@', '@' };
 	const char *cp, *ep;
 	struct strbuf msgbuf = STRBUF_INIT;
@@ -1502,6 +1553,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	ep += 2; /* skip over @@ */
 
 	/* The hunk header in fraginfo color */
+	if (ecbdata->opt->flags.dual_color_diffed_diffs)
+		strbuf_addstr(&msgbuf, reverse);
 	strbuf_addstr(&msgbuf, frag);
 	strbuf_add(&msgbuf, line, ep - line);
 	strbuf_addstr(&msgbuf, reset);
diff --git a/diff.h b/diff.h
index d88ceb357..cca4f9d6c 100644
--- a/diff.h
+++ b/diff.h
@@ -95,6 +95,7 @@ struct diff_flags {
 	unsigned default_follow_renames:1;
 	unsigned stat_with_summary:1;
 	unsigned suppress_diff_headers:1;
+	unsigned dual_color_diffed_diffs:1;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
-- 
gitgitgadget

