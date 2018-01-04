Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6A101F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeADWkO (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:40:14 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42634 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeADWkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:40:13 -0500
Received: by mail-pg0-f68.google.com with SMTP id q67so1261785pga.9
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yyKJONnt25N2DUBH4L3eKySRKuvpJedNqL9PlzlCMpk=;
        b=HRiZQAdiNTxuIFsPJ5i/VNUcL0CYii4kEIkq/PPVAu/qZQrKU8ZJYqve1Kze6HtlJa
         Zrc756Ne3mfoyMMyxwPIaPT7EetkAYGSHyYspMURcSpw7D6FbopO+aeUg/W3JwZecYAU
         Fa2PP61M6AslGyNnWkEWhUxzuWZDTcAO2mDCV06yrbWU6NLD0TAp5iFOjTlnJaAkyhbt
         9CCcauCR/F6DN/uVJeCkYuZbypd19q+KiD7/hJClif1ydQzqPDbFqwk3fzF8g5gANysE
         tbbS3l1HNC8svfg0aJy9Oy86B3Pk4fG1BbHK1MnsFQHSXAMYGJwACuTpr/CHxCRer6et
         Jrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yyKJONnt25N2DUBH4L3eKySRKuvpJedNqL9PlzlCMpk=;
        b=A+ut5xWdnOJn2yySrjS3DWZy/Os1a1ufhRVbtzpen1qj/TWeGD5dhIdZ8O4BsM5gxf
         Rvzn4ncfYr9UALhzfUw2M2LHOG/phuD7UikssB/9OWU99SdU0cOsXF99WbFcQydGS/ct
         idVTe2BzBH+1fhRIsOf/aLv/nYs84A7nJSVcu5lFDnpdvh6wl5k7i1O+gH0nmvuIVtvW
         42I6z7OuDObrPs/Jh8PGAF3T0qKJK12wcbySrBQCtSQxpQSUgEPGfNmWiGPTt1p7H7PD
         uAlEeC3Kc5EoLiiWd+T57/WCyl7oocsJJZeaVTv2WAJdlJPQqHihSybAOjzSYAlb5Xm9
         /H7A==
X-Gm-Message-State: AKGB3mKFaw9/MgZYmbHDplD0uyr7X1941CVAocpFRYfISl/Qu9Pb9KKv
        9VdQ9ovQLxFCOh56P+7k0dxVn3nzZOk=
X-Google-Smtp-Source: ACJfBosbtMFd145zCFdbgakvU4Py2dBrTv5GMrfzeuHS54OGADhZBxVq11W7Lrsj90B+x7QVT2bHdQ==
X-Received: by 10.98.16.134 with SMTP id 6mr941867pfq.234.1515105612320;
        Thu, 04 Jan 2018 14:40:12 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b6sm9652208pfe.57.2018.01.04.14.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:40:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, sunshine@sunshineco.com
Cc:     git@vger.kernel.org
Subject: [PATCHv3 1/4] color.h: document and modernize header
Date:   Thu,  4 Jan 2018 14:40:04 -0800
Message-Id: <20180104224007.214548-2-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180104224007.214548-1-sbeller@google.com>
References: <20171110011002.10179-1-sbeller@google.com>
 <20180104224007.214548-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation explaining the functions in color.h.
While at it, mark them extern.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 color.c |  2 --
 color.h | 58 ++++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/color.c b/color.c
index d48dd947c9..c4dc1cb989 100644
--- a/color.c
+++ b/color.c
@@ -399,8 +399,6 @@ static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 	return r;
 }
 
-
-
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
 {
 	va_list args;
diff --git a/color.h b/color.h
index fd2b688dfb..2e768a10c6 100644
--- a/color.h
+++ b/color.h
@@ -72,26 +72,56 @@ extern int color_stdout_is_tty;
  * Use the first one if you need only color config; the second is a convenience
  * if you are just going to change to git_default_config, too.
  */
-int git_color_config(const char *var, const char *value, void *cb);
-int git_color_default_config(const char *var, const char *value, void *cb);
+extern int git_color_config(const char *var, const char *value, void *cb);
+extern int git_color_default_config(const char *var, const char *value, void *cb);
 
 /*
- * Set the color buffer (which must be COLOR_MAXLEN bytes)
- * to the raw color bytes; this is useful for initializing
- * default color variables.
+ * NEEDSWWORK: document this function or refactor grep.c to stop using this
+ * function.
  */
-void color_set(char *dst, const char *color_bytes);
+extern void color_set(char *dst, const char *color_bytes);
 
-int git_config_colorbool(const char *var, const char *value);
-int want_color(int var);
-int color_parse(const char *value, char *dst);
-int color_parse_mem(const char *value, int len, char *dst);
+/*
+ * Parse a config option, which can be a boolean or one of
+ * "never", "auto", "always". Return a constant of
+ * GIT_COLOR_NEVER for "never" or negative boolean,
+ * GIT_COLOR_ALWAYS for "always" or a positive boolean,
+ * and GIT_COLOR_AUTO for "auto".
+ */
+extern int git_config_colorbool(const char *var, const char *value);
+
+/*
+ * Resolve the constants as returned by git_config_colorbool()
+ * (specifically "auto") to a boolean answer.
+ */
+extern int want_color(int var);
+
+/*
+ * Translate a Git color from 'value' into a string that the terminal can
+ * interpret and store it into 'dst'. The Git color values are of the form
+ * "foreground [background] [attr]" where fore- and background can be a color
+ * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
+ */
+extern int color_parse(const char *value, char *dst);
+extern int color_parse_mem(const char *value, int len, char *dst);
+
+/*
+ * Output the formatted string in the specified color (and then reset to normal
+ * color so subsequent output is uncolored). Omits the color encapsulation if
+ * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
+ * the color. The `color_print_strbuf` prints the given pre-formatted strbuf
+ * instead, up to its first NUL character.
+ */
 __attribute__((format (printf, 3, 4)))
-int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
+extern int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
-int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
-void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
+extern int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
+extern void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
 
-int color_is_nil(const char *color);
+/*
+ * Check if the given color is GIT_COLOR_NIL that means "no color selected".
+ * The caller needs to replace the color with the actual desired color.
+ */
+extern int color_is_nil(const char *color);
 
 #endif /* COLOR_H */
-- 
2.16.0.rc0.223.g4a4ac83678-goog

