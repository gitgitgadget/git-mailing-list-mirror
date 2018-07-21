Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BEE61F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeGUW7Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36008 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeGUW7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:24 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so6625223plb.3
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dz1dVVT4f3ZAs+P/MHXlA2K0XNaK+v2k1SrGOpGUf98=;
        b=uhFVXCYKn1RakrZV7Asf36AEA9Ph65fvKqeW1znUk4F4C/nbCAzOIJf8QJOAP74S8V
         mhf7Fvc8bcG6MFwnyiomw7fQXV5Et840MoCBAfrnMVIHD6ZBZlWGMutyfjcKA+yn9yW3
         2XT2dKwyA3liN/rG7RVZfFWnb8qNJzbL8ADSQtPBVoMMqcwvIQA5VaLsvIqQVg5eS/Wi
         QGonMpy+oZvfIoK7GNWdbPoGr4jKyK47rk+x38dcYNeQnGPJpJOYS8RjLvXQW4xAjMxu
         QiZXfeZeWlQB5bTiqefK36GCT2ybTev501M8FkOT203lW9kFL/zrDM1fVYX0yfbeJDHn
         trrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dz1dVVT4f3ZAs+P/MHXlA2K0XNaK+v2k1SrGOpGUf98=;
        b=AqG3D6gznJVRxcokpgV5esXZKNBE1R5wFAU1UwfKXnXAkmUBuwheWBj6n00L07QMr/
         8jK9aRFIqRRdRdF+RDPK0LshjiWxfte35aRLvQo8VaFsinzz7BV5eeYuefNOoQait85A
         zvk3ZCvH4ttF6IQSSvRrsWd81I24/eIce+IJECXHx7DOYg0M/Xp36Ww/D0Zm2ZrFdWCa
         X6kE6W0H4DeTOjcdT1kUEiGYfs5/kQDHWHWE/8QU1ocBDqE0UVt4I3fDx2monwBzx7Fw
         VOYS2i8KlqFdmvxJvVkywXOe58rDQcHfphrzVcR7PHbRhuSKT0RMdNoPSiZ3EXhqETy2
         RowA==
X-Gm-Message-State: AOUpUlGQOnJr2UIqOWAFDVaCWwm+0iAYvMLgZt2ZBlhkS//2qS2KzZ3T
        rCZ4QQUUgd8//UEQg1GPKk54I4Y6
X-Google-Smtp-Source: AAOMgpcjxz7OtQlWpy4BtgQZo/YQifd72ddPn4MAEvBErQ86cqPdHYxUeKMrsTXhaVX6s5BMf310AA==
X-Received: by 2002:a17:902:142:: with SMTP id 60-v6mr5060802plb.330.1532210707945;
        Sat, 21 Jul 2018 15:05:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y86-v6sm12997479pfk.84.2018.07.21.15.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:05:07 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:05:07 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:37 GMT
Message-Id: <f4252f2b2198cf13d5b0a21c54098e2a1d8158dd.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 16/21] range-diff --dual-color: fix bogus white-space
 warning
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

When displaying a diff of diffs, it is possible that there is an outer
`+` before a context line. That happens when the context changed between
old and new commit. When that context line starts with a tab (after the
space that marks it as context line), our diff machinery spits out a
white-space error (space before tab), but in this case, that is
incorrect.

Fix this by adding a specific whitespace flag that simply ignores the
first space in the output.

Of course, this flag is *really* specific to the "diff of diffs" use
case. The original idea was to simply skip the space from the output,
but that workaround was rejected by the Git maintainer as causing
headaches.

Note: as the original code did not leave any space in the bit mask
before the WSEH_* bits, the diff of this commit looks unnecessarily
involved: the diff is dominated by making room for one more bit to be
used by the whitespace rules.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h |  3 ++-
 diff.c  | 15 ++++++++-------
 diff.h  |  6 +++---
 ws.c    | 11 ++++++++++-
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index 8b447652a..8abfbeb73 100644
--- a/cache.h
+++ b/cache.h
@@ -1681,11 +1681,12 @@ void shift_tree_by(const struct object_id *, const struct object_id *, struct ob
 #define WS_CR_AT_EOL           01000
 #define WS_BLANK_AT_EOF        02000
 #define WS_TAB_IN_INDENT       04000
+#define WS_IGNORE_FIRST_SPACE 010000
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
 #define WS_TAB_WIDTH_MASK        077
 /* All WS_* -- when extended, adapt diff.c emit_symbol */
-#define WS_RULE_MASK           07777
+#define WS_RULE_MASK           017777
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
diff --git a/diff.c b/diff.c
index e163bc8a3..03ed235c7 100644
--- a/diff.c
+++ b/diff.c
@@ -650,14 +650,14 @@ enum diff_symbol {
 };
 /*
  * Flags for content lines:
- * 0..12 are whitespace rules
- * 13-15 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
- * 16 is marking if the line is blank at EOF
+ * 0..14 are whitespace rules
+ * 14-16 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
+ * 17 is marking if the line is blank at EOF
  */
-#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
-#define DIFF_SYMBOL_MOVED_LINE			(1<<17)
-#define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<18)
-#define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING	(1<<19)
+#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<17)
+#define DIFF_SYMBOL_MOVED_LINE			(1<<18)
+#define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<19)
+#define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING	(1<<20)
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
 /*
@@ -1094,6 +1094,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_FRAGINFO);
 			else if (c != '+')
 				set = diff_get_color_opt(o, DIFF_CONTEXT);
+			flags |= WS_IGNORE_FIRST_SPACE;
 		}
 		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
diff --git a/diff.h b/diff.h
index 79beb6eea..892416a14 100644
--- a/diff.h
+++ b/diff.h
@@ -160,9 +160,9 @@ struct diff_options {
 	int abbrev;
 	int ita_invisible_in_index;
 /* white-space error highlighting */
-#define WSEH_NEW (1<<12)
-#define WSEH_CONTEXT (1<<13)
-#define WSEH_OLD (1<<14)
+#define WSEH_NEW (1<<13)
+#define WSEH_CONTEXT (1<<14)
+#define WSEH_OLD (1<<15)
 	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
diff --git a/ws.c b/ws.c
index a07caedd5..e02365a6a 100644
--- a/ws.c
+++ b/ws.c
@@ -20,6 +20,7 @@ static struct whitespace_rule {
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
+	{ "ignore-first-space", WS_IGNORE_FIRST_SPACE, 0, 1 },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -177,8 +178,16 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 	if (trailing_whitespace == -1)
 		trailing_whitespace = len;
 
+	if ((ws_rule & WS_IGNORE_FIRST_SPACE) && len && line[0] == ' ') {
+		if (stream)
+			fwrite(line, 1, 1, stream);
+		written++;
+		if (!trailing_whitespace)
+			trailing_whitespace++;
+	}
+
 	/* Check indentation */
-	for (i = 0; i < trailing_whitespace; i++) {
+	for (i = written; i < trailing_whitespace; i++) {
 		if (line[i] == ' ')
 			continue;
 		if (line[i] != '\t')
-- 
gitgitgadget

