Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6E01F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeHNE0V (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:26:21 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:41219 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeHNE0U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:26:20 -0400
Received: by mail-qt0-f201.google.com with SMTP id l13-v6so14515565qth.8
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ndbFbPG1E8b3eOmZUNSnNrXT/4r2d9UU/xEkIeRHWbc=;
        b=AiUvc2M4kvbphUGLtK9yiwIwgHMc4ZatEz7TfXL30JKbyQYIa/3B9cwo+MJiTp5HEi
         cNpT2Ltewxv7RTxvX3h8sBMGhkj6CXn0TCvgMY97aNNwV1D4mtOJPYbb59rbO0HTPLpc
         1MjdnCiVPEqB/OnU2qpLVG0hJc2piMYpo9zf4aK1jO/pT+OJnRJr4Qy+hi08LlggElYm
         ZN9exlhaZhDaMfh7eiAfhzAr7KHi5uJA85w+DsphyvJTbAKysVqxwtAJjezMrWWzjJKc
         cce60305QT7kjhtY1xOrmuC36gOwwsyiIKyX9HPVoNvEV+P9rj3A5msSwSo2deVa0Y1z
         6saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ndbFbPG1E8b3eOmZUNSnNrXT/4r2d9UU/xEkIeRHWbc=;
        b=Y24Ej2Jcl3S91+L2Uy0cPcDp9Me/KzUlIDDOyr6nq5CYPmqvf17dqfK4wMfolVhBx3
         cDJZ4noC5wsiBd8usIw0NYUTubKWtTocADwLyLB5U6xt1nJtg0Q2sCQPQBhyRlyNJ2Y6
         Y2Vw2RdTlv9TMwsvJe0j8hctJIslVgT4yBs83EIeOFy4q7CkqSTf/PIbhzL0D0Z74Kco
         OmbDw3ISWHzxx77qrBm0ZrNAdLsEbRYOcYIdRbs3rKjhmK4y34Hux4a5nIsahTPChnpK
         02Gjr6WiXq18RoswSsN1RUK5MElIdMJj6LxNuqR/fTcOGnZ8D4hP+e1SFLuso3yyAf1H
         e86A==
X-Gm-Message-State: AOUpUlFI91lD1PPTAarpNl4x9Cg44uRjWM8eIBimPnG+KZrTCWMR9WAy
        kipRfiPOrdGnmFvZFgndyBvqXMzTq7fx
X-Google-Smtp-Source: AA+uWPxvtIr+FHFVsi8uK1wby7loi3SVDrIL6pvunZvPA3EW2IVtUtdigeZqqJKTUZojMXzYVtbWPIGfe2Qt
X-Received: by 2002:ac8:838:: with SMTP id u53-v6mr10926361qth.16.1534210889436;
 Mon, 13 Aug 2018 18:41:29 -0700 (PDT)
Date:   Mon, 13 Aug 2018 18:41:14 -0700
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
Message-Id: <20180814014122.30662-1-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCHv2 0/8] Resending sb/range-diff-colors
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is also avaliable as
git fetch https://github.com/stefanbeller/git sb/range-diff-colors

This applies on top of js/range-diff (a7be92acd9600), this version 
* resolves a semantic conflict in the test
  (Did range-diff change its output slightly?)
* addressed Johannes feedback, such as
 -> keeping the reverse computation out of emit_line_0
 -> better commit messages.
 -> Split "use emit_line_0 once per line" to have an additional
    "diff.c: omit check for line prefix in emit_line_0" as having
    these two things in the same patch is confusing

The interdiff seems more useful than the range-diff here,
both attached below.

Thanks,
Stefan

Stefan Beller (8):
  test_decode_color: understand FAINT and ITALIC
  t3206: add color test for range-diff --dual-color
  diff.c: simplify caller of emit_line_0
  diff.c: reorder arguments for emit_line_ws_markup
  diff.c: add set_sign to emit_line_0
  diff: use emit_line_0 once per line
  diff.c: omit check for line prefix in emit_line_0
  diff.c: rewrite emit_line_0 more understandably

 diff.c                  | 91 ++++++++++++++++++++++-------------------
 t/t3206-range-diff.sh   | 39 ++++++++++++++++++
 t/test-lib-functions.sh |  2 +
 3 files changed, 91 insertions(+), 41 deletions(-)

(interdiff seems to be more useful)
git diff 4dc97b54a35..058e03a1601

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index ef3ba22e297..f52d45d9d61 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -53,6 +53,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		else
 			i += c;
 	}
+	while (i < argc)
+		argv[j++] = argv[i++];
 	argc = j;
 	diff_setup_done(&diffopt);
 
diff --git a/diff.c b/diff.c
index af9316c8f91..c5c7739ce34 100644
--- a/diff.c
+++ b/diff.c
@@ -622,13 +622,11 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o,
-			const char *set_sign, const char *set, const char *reset,
+			const char *set_sign, const char *set, unsigned reverse, const char *reset,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
-	int reverse = !!set && !!set_sign;
-	int needs_reset = 0;
-
+	int needs_reset = 0; /* at the end of the line */
 	FILE *file = o->file;
 
 	fputs(diff_line_prefix(o), file);
@@ -649,8 +647,8 @@ static void emit_line_0(struct diff_options *o,
 		needs_reset = 1;
 	}
 
-	if (set_sign || set) {
-		fputs(set_sign ? set_sign : set, file);
+	if (set_sign) {
+		fputs(set_sign, file);
 		needs_reset = 1;
 	}
 
@@ -667,7 +665,7 @@ static void emit_line_0(struct diff_options *o,
 		needs_reset = 1;
 	}
 	fwrite(line, len, 1, file);
-	needs_reset |= len > 0;
+	needs_reset = 1; /* 'line' may contain color codes. */
 
 end_of_line:
 	if (needs_reset)
@@ -681,7 +679,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, reset, 0, line, len);
+	emit_line_0(o, set, NULL, 0, reset, 0, line, len);
 }
 
 enum diff_symbol {
@@ -1213,15 +1211,16 @@ static void emit_line_ws_markup(struct diff_options *o,
 	}
 
 	if (!ws && !set_sign)
-		emit_line_0(o, set, NULL, reset, sign, line, len);
+		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
 	else if (!ws) {
-		emit_line_0(o, set_sign, set, reset, sign, line, len);
+		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(o, ws, NULL, reset, sign, line, len);
+		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign, set, reset, sign, "", 0);
+		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
+			    sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
@@ -1244,7 +1243,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, NULL, reset, '\\',
+		emit_line_0(o, context, NULL, 0, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:




./git-range-diff github/sb/range-diff-colors... below:

22:  0fedd4c0a20 = 22:  dd772035ac9 test_decode_color: understand FAINT and ITALIC
23:  6a1c7698c68 ! 23:  5701745379b t3206: add color test for range-diff --dual-color
    @@ -23,7 +23,7 @@
     +	:         s/4/A/<RESET>
     +	:     <RESET>
     +	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
    -+	:    <REVERSE><GREEN>+<RESET>
    ++	:    <REVERSE><GREEN>+<RESET><BOLD><RESET>
     +	:     diff --git a/file b/file<RESET>
     +	:    <RED> --- a/file<RESET>
     +	:    <GREEN> +++ b/file<RESET>
24:  7e12ece1d34 = 24:  4e56f63a5f5 diff.c: simplify caller of emit_line_0
25:  74dabd6d36f ! 25:  cf126556940 diff.c: reorder arguments for emit_line_ws_markup
    @@ -3,7 +3,8 @@
         diff.c: reorder arguments for emit_line_ws_markup
     
         The order shall be all colors first, then the content, flags at the end.
    -    The colors are in order.
    +    The colors are in the order of occurrence, i.e. first the color for the
    +    sign and then the color for the rest of the line.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
26:  e304e15aa6b ! 26:  69008364cb8 diff.c: add set_sign to emit_line_0
    @@ -2,14 +2,17 @@
     
         diff.c: add set_sign to emit_line_0
     
    -    For now just change the signature, we'll reason about the actual
    -    change in a follow up patch.
    +    Split the meaning of the `set` parameter that is passed to
    +    emit_line_0()` to separate between the color of the "sign" (i.e.
    +    the diff marker '+', '-' or ' ' that is passed in as the `first`
    +    parameter) and the color of the rest of the line.
     
    -    Pass 'set_sign' (which is output before the sign) and 'set' which
    -    controls the color after the first character. Hence, promote any
    -    'set's to 'set_sign' as we want to have color before the sign
    -    for now.
    +    This changes the meaning of the `set` parameter to no longer refer
    +    to the color of the diff marker, but instead to refer to the color
    +    of the rest of the line. A value of `NULL` indicates that the rest
    +    of the line wants to be colored the same as the diff marker.
     
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ -30,12 +33,15 @@
      		if (reverse && want_color(o->use_color))
      			fputs(GIT_COLOR_REVERSE, file);
     -		fputs(set, file);
    -+		if (set_sign && set_sign[0])
    ++		if (set_sign)
     +			fputs(set_sign, file);
      		if (first && !nofirst)
      			fputc(first, file);
    -+		if (set)
    ++		if (set && set != set_sign) {
    ++			if (set_sign)
    ++				fputs(reset, file);
     +			fputs(set, file);
    ++		}
      		fwrite(line, len, 1, file);
      		fputs(reset, file);
      	}
27:  8d935d5212c <  -:  ----------- diff: use emit_line_0 once per line
28:  2344aac787a <  -:  ----------- diff.c: compute reverse locally in emit_line_0
 -:  ----------- > 27:  5d2629281a1 diff: use emit_line_0 once per line
 -:  ----------- > 28:  5240e94a69a diff.c: omit check for line prefix in emit_line_0
29:  4dc97b54a35 ! 29:  058e03a1601 diff.c: rewrite emit_line_0 more understandably
    @@ -2,21 +2,15 @@
     
         diff.c: rewrite emit_line_0 more understandably
     
    -    emit_line_0 has no nested conditions, but puts out all its arguments
    -    (if set) in order. There is still a slight confusion with set
    -    and set_sign, but let's defer that to a later patch.
    +    Rewrite emit_line_0 to have fewer (nested) conditions.
     
    -    'first' used be output always no matter if it was 0, but that got lost
    -    at "diff: add an internal option to dual-color diffs of diffs",
    -    2018-07-21), as there we broadened the meaning of 'first' to also
    -    signal an early return.
    -
    -    The change in 'emit_line' makes sure that 'first' is never content, but
    -    always under our control, a sign or special character in the beginning
    -    of the line (or 0, in which case we ignore it).
    +    The change in 'emit_line' makes sure that 'first' is never user data,
    +    but always under our control, a sign or special character in the
    +    beginning of the line (or 0, in which case we ignore it).
    +    So from now on, let's pass only a diff marker or 0 as the 'first'
    +    character of the line.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/diff.c b/diff.c
     --- a/diff.c
    @@ -26,9 +20,7 @@
      {
      	int has_trailing_newline, has_trailing_carriage_return;
     -	int nofirst;
    - 	int reverse = !!set && !!set_sign;
    -+	int needs_reset = 0;
    -+
    ++	int needs_reset = 0; /* at the end of the line */
      	FILE *file = o->file;
      
      	fputs(diff_line_prefix(o), file);
    @@ -51,15 +43,16 @@
     -	if (len || !nofirst) {
     -		if (reverse && want_color(o->use_color))
     -			fputs(GIT_COLOR_REVERSE, file);
    --		if (set_sign || set)
    --			fputs(set_sign ? set_sign : set, file);
    +-		if (set_sign)
    +-			fputs(set_sign, file);
     -		if (first && !nofirst)
     -			fputc(first, file);
     -		if (len) {
    --			if (set_sign && set && set != set_sign)
    --				fputs(reset, file);
    --			if (set)
    +-			if (set && set != set_sign) {
    +-				if (set_sign)
    +-					fputs(reset, file);
     -				fputs(set, file);
    +-			}
     -			fwrite(line, len, 1, file);
     -		}
     -		fputs(reset, file);
    @@ -79,8 +72,8 @@
     +		needs_reset = 1;
     +	}
     +
    -+	if (set_sign || set) {
    -+		fputs(set_sign ? set_sign : set, file);
    ++	if (set_sign) {
    ++		fputs(set_sign, file);
     +		needs_reset = 1;
      	}
     +
    @@ -97,7 +90,7 @@
     +		needs_reset = 1;
     +	}
     +	fwrite(line, len, 1, file);
    -+	needs_reset |= len > 0;
    ++	needs_reset = 1; /* 'line' may contain color codes. */
     +
     +end_of_line:
     +	if (needs_reset)
    @@ -109,8 +102,8 @@
      static void emit_line(struct diff_options *o, const char *set, const char *reset,
      		      const char *line, int len)
      {
    --	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
    -+	emit_line_0(o, set, NULL, reset, 0, line, len);
    +-	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
    ++	emit_line_0(o, set, NULL, 0, reset, 0, line, len);
      }
      
      enum diff_symbol {
