Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08C81F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbeHMOP0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44557 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbeHMOPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so7515029pff.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MKju9e4l1X++IXWH4UPatMfOTU0Fe+qKzB5qoZgdA/o=;
        b=n3MTbkQ2Z8vcUBiRfKAxlK8oJrBgimV333ypqH18owSQd8s/J+7pigp6oLS++3UuZm
         0wYkODDecD/sAEL252fNUVKwtIxOPLm0pAJ18qXb7FF2A0AZkPqSoiCmkOcAA7bWzQsO
         y07m4p7LORzvNKkTGnauQyIoyBqtq8ZL4Lh3tMEF+zlJhpmoT4sFtdlSpfnV++2DopZQ
         Or+1va/bW/54cnEvRtFPKadihQmuwjhlpeL/WGIa5fqiSIfpBwQfMPoq3vWxexGnuHwM
         5h/hotAnSrBT/Tko/j7dNqhy0V7prNHwspqXu9gRUVp2qamCz5utxIuKzxMy1m2khvJ3
         ZANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MKju9e4l1X++IXWH4UPatMfOTU0Fe+qKzB5qoZgdA/o=;
        b=dIWaDNUd7vkNfw5z9ovDMaM1ybJAhwqX5A+WenxrOOpvmCnp9NOxmRNzBFC1AtdBTN
         DcAWIg9xcoY82k0YT+gudXt0BECzVyOgpuboQ4Z0peRgTYD8MxsbfcieZvc/nvM61KWW
         pUaZxNzmE7INFlIqWzRIgYTQw2MIAwKjwlbSH8EVurkBCwyrdp4Gi0d8S77dkGwvOL93
         +m6OufT+YjQzmwTx+AGjF9/E6X/kFzTK0ySxCujgdH+Ydyhkw1N3hWP0wvIYo83gjZ51
         nAa5wLdLSepHAsQ5zwSp70fSSQq7l4cUM/tTIH5a6hAl8UtCz9UWry4uHqrlgPTQgf5s
         DFUA==
X-Gm-Message-State: AOUpUlHXSzaj+7mRVj6BjT7AaWKKGru2RvVwWu4x66q06rQR3+8IUc7N
        J6H+GLA2BCTXND3thIgzonReSSs4
X-Google-Smtp-Source: AA+uWPzSxCVnuegfGehLMCDKe8AkNTzHIBWuYX7sNWmEMwAiXjVTDygjxlkd9oTzbBy0RArn6zI0qQ==
X-Received: by 2002:a63:c046:: with SMTP id z6-v6mr16699272pgi.114.1534160012896;
        Mon, 13 Aug 2018 04:33:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id z2-v6sm16246344pgv.12.2018.08.13.04.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:32 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:32 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:56 GMT
Message-Id: <699cd712e2aa56ad7bb1356b72caf8d4738a18e5.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 21/21] range-diff: use dim/bold cues to improve dual color
 mode
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

It *is* a confusing thing to look at a diff of diffs. All too easy is it
to mix up whether the -/+ markers refer to the "inner" or the "outer"
diff, i.e. whether a `+` indicates that a line was added by either the
old or the new diff (or both), or whether the new diff does something
different than the old diff.

To make things easier to process for normal developers, we introduced
the dual color mode which colors the lines according to the commit diff,
i.e. lines that are added by a commit (whether old, new, or both) are
colored in green. In non-dual color mode, the lines would be colored
according to the outer diff: if the old commit added a line, it would be
colored red (because that line addition is only present in the first
commit range that was specified on the command-line, i.e. the "old"
commit, but not in the second commit range, i.e. the "new" commit).

However, this dual color mode is still not making things clear enough,
as we are looking at two levels of diffs, and we still only pick a color
according to *one* of them (the outer diff marker is colored
differently, of course, but in particular with deep indentation, it is
easy to lose track of that outer diff marker's background color).

Therefore, let's add another dimension to the mix. Still use
green/red/normal according to the commit diffs, but now also dim the
lines that were only in the old commit, and use bold face for the lines
that are only in the new commit.

That way, it is much easier not to lose track of, say, when we are
looking at a line that was added in the previous iteration of a patch
series but the new iteration adds a slightly different version: the
obsolete change will be dimmed, the current version of the patch will be
bold.

At least this developer has a much easier time reading the range-diffs
that way.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt         |  6 ++++--
 Documentation/git-range-diff.txt | 17 +++++++++++++----
 color.h                          |  6 ++++++
 diff.c                           | 28 ++++++++++++++++++++++------
 diff.h                           |  8 +++++++-
 5 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 63365dcf3..90241ed77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1193,8 +1193,10 @@ color.diff.<slot>::
 	(highlighting whitespace errors), `oldMoved` (deleted lines),
 	`newMoved` (added lines), `oldMovedDimmed`, `oldMovedAlternative`,
 	`oldMovedAlternativeDimmed`, `newMovedDimmed`, `newMovedAlternative`
-	and `newMovedAlternativeDimmed` (See the '<mode>'
-	setting of '--color-moved' in linkgit:git-diff[1] for details).
+	`newMovedAlternativeDimmed` (See the '<mode>'
+	setting of '--color-moved' in linkgit:git-diff[1] for details),
+	`contextDimmed`, `oldDimmed`, `newDimmed`, `contextBold`,
+	`oldBold`, and `newBold` (see linkgit:git-range-diff[1] for details).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 82c71c682..f693930fd 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -35,10 +35,19 @@ OPTIONS
 	When the commit diffs differ, `git range-diff` recreates the
 	original diffs' coloring, and adds outer -/+ diff markers with
 	the *background* being red/green to make it easier to see e.g.
-	when there was a change in what exact lines were added. This is
-	known to `range-diff` as "dual coloring". Use `--no-dual-color`
-	to revert to color all lines according to the outer diff markers
-	(and completely ignore the inner diff when it comes to color).
+	when there was a change in what exact lines were added.
++
+Additionally, the commit diff lines that are only present in the first commit
+range are shown "dimmed" (this can be overridden using the `color.diff.<slot>`
+config setting where `<slot>` is one of `contextDimmed`, `oldDimmed` and
+`newDimmed`), and the commit diff lines that are only present in the second
+commit range are shown in bold (which can be overridden using the config
+settings `color.diff.<slot>` with `<slot>` being one of `contextBold`,
+`oldBold` or `newBold`).
++
+This is known to `range-diff` as "dual coloring". Use `--no-dual-color`
+to revert to color all lines according to the outer diff markers
+(and completely ignore the inner diff when it comes to color).
 
 --creation-factor=<percent>::
 	Set the creation/deletion cost fudge factor to `<percent>`.
diff --git a/color.h b/color.h
index 33e786342..98894d6a1 100644
--- a/color.h
+++ b/color.h
@@ -36,6 +36,12 @@ struct strbuf;
 #define GIT_COLOR_BOLD_BLUE	"\033[1;34m"
 #define GIT_COLOR_BOLD_MAGENTA	"\033[1;35m"
 #define GIT_COLOR_BOLD_CYAN	"\033[1;36m"
+#define GIT_COLOR_FAINT_RED	"\033[2;31m"
+#define GIT_COLOR_FAINT_GREEN	"\033[2;32m"
+#define GIT_COLOR_FAINT_YELLOW	"\033[2;33m"
+#define GIT_COLOR_FAINT_BLUE	"\033[2;34m"
+#define GIT_COLOR_FAINT_MAGENTA	"\033[2;35m"
+#define GIT_COLOR_FAINT_CYAN	"\033[2;36m"
 #define GIT_COLOR_BG_RED	"\033[41m"
 #define GIT_COLOR_BG_GREEN	"\033[42m"
 #define GIT_COLOR_BG_YELLOW	"\033[43m"
diff --git a/diff.c b/diff.c
index ea8ecae04..ae1314952 100644
--- a/diff.c
+++ b/diff.c
@@ -70,6 +70,12 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD_YELLOW,	/* NEW_MOVED ALTERNATIVE */
 	GIT_COLOR_FAINT,	/* NEW_MOVED_DIM */
 	GIT_COLOR_FAINT_ITALIC,	/* NEW_MOVED_ALTERNATIVE_DIM */
+	GIT_COLOR_FAINT,	/* CONTEXT_DIM */
+	GIT_COLOR_FAINT_RED,	/* OLD_DIM */
+	GIT_COLOR_FAINT_GREEN,	/* NEW_DIM */
+	GIT_COLOR_BOLD,		/* CONTEXT_BOLD */
+	GIT_COLOR_BOLD_RED,	/* OLD_BOLD */
+	GIT_COLOR_BOLD_GREEN,	/* NEW_BOLD */
 };
 
 static const char *color_diff_slots[] = {
@@ -89,6 +95,12 @@ static const char *color_diff_slots[] = {
 	[DIFF_FILE_NEW_MOVED_ALT]     = "newMovedAlternative",
 	[DIFF_FILE_NEW_MOVED_DIM]     = "newMovedDimmed",
 	[DIFF_FILE_NEW_MOVED_ALT_DIM] = "newMovedAlternativeDimmed",
+	[DIFF_CONTEXT_DIM]	      = "contextDimmed",
+	[DIFF_FILE_OLD_DIM]	      = "oldDimmed",
+	[DIFF_FILE_NEW_DIM]	      = "newDimmed",
+	[DIFF_CONTEXT_BOLD]	      = "contextBold",
+	[DIFF_FILE_OLD_BOLD]	      = "oldBold",
+	[DIFF_FILE_NEW_BOLD]	      = "newBold",
 };
 
 static NORETURN void die_want_option(const char *option_name)
@@ -1294,11 +1306,13 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 
 			set_sign = set;
 			if (c == '-')
-				set = diff_get_color_opt(o, DIFF_FILE_OLD);
+				set = diff_get_color_opt(o, DIFF_FILE_OLD_BOLD);
 			else if (c == '@')
 				set = diff_get_color_opt(o, DIFF_FRAGINFO);
-			else if (c != '+')
-				set = diff_get_color_opt(o, DIFF_CONTEXT);
+			else if (c == '+')
+				set = diff_get_color_opt(o, DIFF_FILE_NEW_BOLD);
+			else
+				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
 		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
@@ -1336,11 +1350,13 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 
 			set_sign = set;
 			if (c == '+')
-				set = diff_get_color_opt(o, DIFF_FILE_NEW);
+				set = diff_get_color_opt(o, DIFF_FILE_NEW_DIM);
 			else if (c == '@')
 				set = diff_get_color_opt(o, DIFF_FRAGINFO);
-			else if (c != '-')
-				set = diff_get_color_opt(o, DIFF_CONTEXT);
+			else if (c == '-')
+				set = diff_get_color_opt(o, DIFF_FILE_OLD_DIM);
+			else
+				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
 		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
diff --git a/diff.h b/diff.h
index cca4f9d6c..e1e54256c 100644
--- a/diff.h
+++ b/diff.h
@@ -248,7 +248,13 @@ enum color_diff {
 	DIFF_FILE_NEW_MOVED = 13,
 	DIFF_FILE_NEW_MOVED_ALT = 14,
 	DIFF_FILE_NEW_MOVED_DIM = 15,
-	DIFF_FILE_NEW_MOVED_ALT_DIM = 16
+	DIFF_FILE_NEW_MOVED_ALT_DIM = 16,
+	DIFF_CONTEXT_DIM = 17,
+	DIFF_FILE_OLD_DIM = 18,
+	DIFF_FILE_NEW_DIM = 19,
+	DIFF_CONTEXT_BOLD = 20,
+	DIFF_FILE_OLD_BOLD = 21,
+	DIFF_FILE_NEW_BOLD = 22,
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
-- 
gitgitgadget
