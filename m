Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D00F1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932181AbeGCL07 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44867 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeGCL0a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id j3-v6so870493pfh.11
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=x0wo1SQ3kz9VyXbOBz5ZUmM2sY8wI1KlnUwYgvUZCaU=;
        b=GouDUeXQi545KP31DaFA0oyJkU52khRTIz1GhJnTGYEUBQOSWNRye8nI9SeH2wKZCF
         SaAG17CalOHho3QR4ZrPxXBqfT5TipZSZQa99zYTIksc7uO3PduXtypd/yhIjthBzwtW
         aCLof9KHsmiSNIO1clRobXTi59HHbPwt4yceo7XFy+aM/hyZDIbyPx5QvnARNo9YQ0py
         S3J8XhZbADGbn2HZjYk6rGmXcT+qZl303pDj55MLnYOGpAF2OW56OwB6KnbGUy+QreJI
         cihez/H7pLWHY3i1LyHsimwJFni6jL94QgiuV2T1BJxk7MzH8ur2zLlNe0NggQuJHZAK
         NYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=x0wo1SQ3kz9VyXbOBz5ZUmM2sY8wI1KlnUwYgvUZCaU=;
        b=AMgap89IPnJjC/yrLqmdj6OPPQhS3EyjvmrHjHDhYB7WTWqbXeFDF1mxKe61FBP0oF
         X9cpvcUWujCNoJClKj/krXSr5MnG9/zSWjplV7iNHH4Oc81dAxHBOszgIQXQfAWdJKNo
         pVh8OjaSFZaerkyRB45nbCPdMtNdixMgmk4LdhwTvxMdmEOOr6NQRtBCz8Iu0sD39PP6
         n9xwWPEThS5aKSWMuZigGU7N/2Kxqc38/G6FJ1fwHnyWYH7KZwAZ1M+izKZoVnIvvjkt
         PazTy8RE+unkfuiIqAqfszYeeeVMsmyvmfcwzEHvWQVYZOEY92nHWQdmNf6of4F+fA7l
         wkSA==
X-Gm-Message-State: APt69E0zPUXIYbDz7E7oYxYsiHMRgsymJ9VMfxyTK5HfrK3gvxdYRtBY
        eSxQzSA9zyxtDkwxLjvI5iOTTg==
X-Google-Smtp-Source: AAOMgpcSBo+r6CDa97gD9gM9s46lkOsODvjaeWRUxExKVBQhdM05kAqm4x9DFSZt7HKflUSZlwdAcA==
X-Received: by 2002:a62:ccd0:: with SMTP id j77-v6mr24297171pfk.22.1530617189662;
        Tue, 03 Jul 2018 04:26:29 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id i12-v6sm2118096pgr.64.2018.07.03.04.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:28 -0700 (PDT)
Message-Id: <6be4baf60b0376e77ec164cedea2b58fc21d16ee.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 3 May 2018 02:17:02 +0200
Subject: [PATCH v3 14/20] diff: add an internal option to dual-color diffs of
 diffs
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
index 8c568cbe0..26445ffa1 100644
--- a/diff.c
+++ b/diff.c
@@ -562,14 +562,18 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
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
@@ -587,8 +591,10 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
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
@@ -602,7 +608,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
 }
 
 enum diff_symbol {
@@ -962,7 +968,8 @@ static void dim_moved_lines(struct diff_options *o)
 
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
-				const char *line, int len, char sign,
+				const char *line, int len,
+				const char *set_sign, char sign,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -973,14 +980,20 @@ static void emit_line_ws_markup(struct diff_options *o,
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
@@ -990,7 +1003,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 					 struct emitted_diff_symbol *eds)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set, *meta, *fraginfo;
+	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
 	struct strbuf sb = STRBUF_INIT;
 
 	enum diff_symbol s = eds->s;
@@ -1003,7 +1016,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, reset, '\\',
+		emit_line_0(o, context, 0, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
@@ -1030,7 +1043,18 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
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
@@ -1057,7 +1081,20 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
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
@@ -1085,7 +1122,20 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
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
@@ -1276,6 +1326,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
 	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
+	const char *reverse = ecbdata->color_diff ? GIT_COLOR_REVERSE : "";
 	static const char atat[2] = { '@', '@' };
 	const char *cp, *ep;
 	struct strbuf msgbuf = STRBUF_INIT;
@@ -1296,6 +1347,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
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

