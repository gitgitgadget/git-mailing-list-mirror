Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D5E1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeGUW7V (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42920 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeGUW7V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so9541244pgp.9
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BlnjFAXgdA4hFZoM9TeRl4xGAb+UxacdkFNMnJMNNQ4=;
        b=LMgR72F6PAxk+ndi/Ts7uWh5YzPaIcfSYdJLvwLifjTSR6ZOjy23+H/s8KHHV/VCZN
         zDcAFse5sDrLiPcyBCVpSMHBM+JgSd13sC1ZDkWijWLGdtSoAZYlSH7x7fa78RvxBMil
         7c7IpUoDtH8fyY92+x+3+13lgNCDP26TrQ404z6R7FrF4QQD1w511iJyoDpA5p5XILKi
         I9XeG9A462vrAWD1tgKccYVPNOnv9kWyPCxi7NeYpzJy2zuf/jo4rwZMicIokXrVkhio
         cGcQiMauVot/4cm4V5kBP6/rqFb1vBwabEAATewV5UCKN2LwSOdw/l+5Xh2baMtwYit0
         ozqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BlnjFAXgdA4hFZoM9TeRl4xGAb+UxacdkFNMnJMNNQ4=;
        b=X9XBDcF/Vt0HpOdmqVcp/AOhEHi6fMrQwKhQL1wiIjlDwbCMosDKPkDxnBcGAiqrIj
         3EqKiTK8JjgA8oFCVOhQe6NzcLsI4Rw6pEccL9jvqDXIMKG7DWNQzGtMufoPgYP/xLPq
         N87k58O8oJ0chovd9d+CvYnt6MylXBf0kIHq2YEixt8h7NNCpNINbqU0sz67n20yQ55h
         Q+DUdmYykkfT8vZMZ7qcFJmNKp8TTAWUpAOC4P0Ph7NscaxDipHw+VfbBjCoN1k9Pkd1
         +jbactt99ijHoMGydRBWpX3LkYx8oOA+FNswonSgDUXu4rIKAZ15pikfOyLhpbUX1Riu
         t7VQ==
X-Gm-Message-State: AOUpUlHdrwhbitaoXqH+9i67V6nOBUXhQ0QjTTNS5uCPP1d7TYUDXs6x
        nKP3ihGwe+WxqyDTdLTkKeh4utHu
X-Google-Smtp-Source: AAOMgpcuXoF/k1pd1GRCD2GVLwigdFTQR+6riXT7Ks2C5XQtfxzdZW92ss4xDpLAQAWN1j41znq8YQ==
X-Received: by 2002:a63:b256:: with SMTP id t22-v6mr7025338pgo.101.1532210705074;
        Sat, 21 Jul 2018 15:05:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id m1-v6sm5998319pfm.4.2018.07.21.15.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:05:04 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:05:04 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:35 GMT
Message-Id: <9de5bd2299eedbc78494cadc9dd8bda59430b2df.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 14/21] diff: add an internal option to dual-color diffs of
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
index a94a8214f..e163bc8a3 100644
--- a/diff.c
+++ b/diff.c
@@ -563,14 +563,18 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
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
@@ -588,8 +592,10 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
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
@@ -603,7 +609,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
 }
 
 enum diff_symbol {
@@ -963,7 +969,8 @@ static void dim_moved_lines(struct diff_options *o)
 
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
-				const char *line, int len, char sign,
+				const char *line, int len,
+				const char *set_sign, char sign,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -974,14 +981,20 @@ static void emit_line_ws_markup(struct diff_options *o,
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
@@ -991,7 +1004,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 					 struct emitted_diff_symbol *eds)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set, *meta, *fraginfo;
+	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
 	struct strbuf sb = STRBUF_INIT;
 
 	enum diff_symbol s = eds->s;
@@ -1004,7 +1017,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, reset, '\\',
+		emit_line_0(o, context, 0, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
@@ -1031,7 +1044,18 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
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
@@ -1058,7 +1082,20 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
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
@@ -1086,7 +1123,20 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
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
@@ -1277,6 +1327,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
 	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
+	const char *reverse = ecbdata->color_diff ? GIT_COLOR_REVERSE : "";
 	static const char atat[2] = { '@', '@' };
 	const char *cp, *ep;
 	struct strbuf msgbuf = STRBUF_INIT;
@@ -1297,6 +1348,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	ep += 2; /* skip over @@ */
 
 	/* The hunk header in fraginfo color */
+	if (ecbdata->opt->flags.dual_color_diffed_diffs)
+		strbuf_addstr(&msgbuf, reverse);
 	strbuf_addstr(&msgbuf, frag);
 	strbuf_add(&msgbuf, line, ep - line);
 	strbuf_addstr(&msgbuf, reset);
diff --git a/diff.h b/diff.h
index 928f48995..79beb6eea 100644
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

