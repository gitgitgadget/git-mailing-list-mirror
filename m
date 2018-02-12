Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1D51F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBLUT3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:19:29 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38932 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeBLUT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:19:29 -0500
Received: by mail-pg0-f65.google.com with SMTP id w17so8233100pgv.6
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 12:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P+Kj5rKh239CNo3MVfyhrCAkwY7fJTGTI5L/tJW7xR0=;
        b=m/V5Vxw5BxrAEWGtSmfBTSG0k3Tj3GCvHCxZRHPoedvPX1Zj+gmTAeqkDF8VhXEtns
         C2a4VJK5C2nqJuGgKsnWVOOrxfUgpJTMFsAf4XDavfC+Exr52erEZKcuc1ACFbroMVJs
         MAzvXhNqLp8zZ8BYUxQcaIjQnvDUkvcByHn23HRePdeV3WLyaldWkvfoYEPL/vrbrYs0
         gcooKlFk/I4d2+l8bhJPiu8o5Se4aoG4/fWGa4Q1Fa6HBkxLFKHduB6B6utu5NUirMNB
         Wz2oa/nmGcE3q8TrTb/Wzefzt19UP6UJupx2nHmOTafIu+NYjf12LjstGUAsO7mjal7p
         x8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P+Kj5rKh239CNo3MVfyhrCAkwY7fJTGTI5L/tJW7xR0=;
        b=QK9vk4m9cTTEdbg7+9g4/6Rb3b2VHME4sgFasMuD9Wt5eJbldFoqf7DeWCCD9LZGSx
         V5EHTrg+/GOSjxuwReh0ByMOYMTl3uFhJ0rpVuW5l/FC71rM6aPd9z2hKgmIGUJ5FVWH
         0MgVbyD0B/m97kDuJIfzkFQGOOQ+cEC/lBf4Jsq92wmYaSwzGXegi7Gd9OsmHplnw9P0
         61MGa1qYH2uTpX3L6R0v/TFPv5Js8/AoykyCYUtzknD8GYZN49dOUuopb6ucBAjeouhg
         ZD8jhUQb7XuIiuoBF/gVZpbpxx26hTszHPP++jtYp0vyHtZ4Xhngz5vK33c6blsUjH5p
         MEyw==
X-Gm-Message-State: APf1xPB34Z42bKVMfQIuGCsFQ6FKbFS0D0HBTkPF+AsJ3o8am1ZLrHKR
        rH+b3jqkiUdeOKLLH2NR8m8keA==
X-Google-Smtp-Source: AH8x227tF3W2ItJzsu6Zl1ZRtiL7I1OeokI7fSprqgPMTEcWipl/LPQ9i0qmbs6uFiub6P2/yGs+lw==
X-Received: by 10.101.68.82 with SMTP id e18mr2645532pgq.329.1518466768117;
        Mon, 12 Feb 2018 12:19:28 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o135sm29205394pfg.45.2018.02.12.12.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 12:19:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH] color.h: document and modernize header
Date:   Mon, 12 Feb 2018 12:19:22 -0800
Message-Id: <20180212201922.74051-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180208222851.GA8850@sigill.intra.peff.net>
References: <20180208222851.GA8850@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation explaining the functions in color.h.
While at it, mark them extern and migrate the function `color_set`
into grep.c, where the only callers are.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

* removed the extern keyword
* reworded the docs for want_color once again.

 color.c |  7 -------
 color.h | 35 ++++++++++++++++++++++++++++++-----
 grep.c  |  5 +++++
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/color.c b/color.c
index d48dd947c9..f277e72e4c 100644
--- a/color.c
+++ b/color.c
@@ -161,11 +161,6 @@ int color_parse(const char *value, char *dst)
 	return color_parse_mem(value, strlen(value), dst);
 }
 
-void color_set(char *dst, const char *color_bytes)
-{
-	xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);
-}
-
 /*
  * Write the ANSI color codes for "c" to "out"; the string should
  * already have the ANSI escape code in it. "out" should have enough
@@ -399,8 +394,6 @@ static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 	return r;
 }
 
-
-
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
 {
 	va_list args;
diff --git a/color.h b/color.h
index fd2b688dfb..40a40f31a4 100644
--- a/color.h
+++ b/color.h
@@ -76,22 +76,47 @@ int git_color_config(const char *var, const char *value, void *cb);
 int git_color_default_config(const char *var, const char *value, void *cb);
 
 /*
- * Set the color buffer (which must be COLOR_MAXLEN bytes)
- * to the raw color bytes; this is useful for initializing
- * default color variables.
+ * Parse a config option, which can be a boolean or one of
+ * "never", "auto", "always". Return a constant of
+ * GIT_COLOR_NEVER for "never" or negative boolean,
+ * GIT_COLOR_ALWAYS for "always" or a positive boolean,
+ * and GIT_COLOR_AUTO for "auto".
  */
-void color_set(char *dst, const char *color_bytes);
-
 int git_config_colorbool(const char *var, const char *value);
+
+/*
+ * Return a boolean whether to use color,
+ * resolving ambigious settings such as GIT_COLOR_AUTO, which is returned
+ * by git_config_colorbool().
+ */
 int want_color(int var);
+
+/*
+ * Translate a Git color from 'value' into a string that the terminal can
+ * interpret and store it into 'dst'. The Git color values are of the form
+ * "foreground [background] [attr]" where fore- and background can be a color
+ * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
+ */
 int color_parse(const char *value, char *dst);
 int color_parse_mem(const char *value, int len, char *dst);
+
+/*
+ * Output the formatted string in the specified color (and then reset to normal
+ * color so subsequent output is uncolored). Omits the color encapsulation if
+ * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
+ * the color. The `color_print_strbuf` prints the given pre-formatted strbuf
+ * instead, up to its first NUL character.
+ */
 __attribute__((format (printf, 3, 4)))
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
 void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
 
+/*
+ * Check if the given color is GIT_COLOR_NIL that means "no color selected".
+ * The caller needs to replace the color with the actual desired color.
+ */
 int color_is_nil(const char *color);
 
 #endif /* COLOR_H */
diff --git a/grep.c b/grep.c
index 3d7cd0e96f..834b8eb439 100644
--- a/grep.c
+++ b/grep.c
@@ -18,6 +18,11 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 	fwrite(buf, size, 1, stdout);
 }
 
+static void color_set(char *dst, const char *color_bytes)
+{
+	xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);
+}
+
 /*
  * Initialize the grep_defaults template with hardcoded defaults.
  * We could let the compiler do this, but without C99 initializers
-- 
2.16.1.73.ga2c3e9663f.dirty

