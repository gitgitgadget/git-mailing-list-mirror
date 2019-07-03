Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5F61F461
	for <e@80x24.org>; Wed,  3 Jul 2019 20:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfGCUqK (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 16:46:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44338 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfGCUqG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 16:46:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so3339928edr.11
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5IhkPZJdzuMZ+IDMReM0Xr4Ch/oQq90xrcOf/H9VtJQ=;
        b=tiFOBEFU+t+jt1irPyn1E5R5k2fyYeKzCA2fl8SAobwzL8i3CfzRotkowWKkMKuhZd
         uy4qPBgcaI1mipb+B3e6tk+h5qReVXPgLs3FA2nbsAXQNVEpbVtroIWqUS+77p9nSwuR
         EQ40dlR0DP9eHvq2H6ldIQDdcAOYuGiIa3egJf6+4Ha8d10NZs1nr1vmhkPbCS9dZpGw
         NJ5aVFrLyzvuo9Wm73Q92YK+I5+BridLqtnCIDsuaU0uhV9pzAXjaQal20o09QWqRccG
         o7FQjv9SRwrpWRstbli12WQWaPSBqZW4jj5PsPOiaAxBIFvXaQiEHK14o40La4MSwHLl
         x9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5IhkPZJdzuMZ+IDMReM0Xr4Ch/oQq90xrcOf/H9VtJQ=;
        b=a7TbXpnMelVrjBtd4bUgSHsopciiw2kwFGBh2Gx2N8K/hp2CDGYqfR8SPV7jJ/Ymhx
         dIaWJmwYXfpr+rRU7c90PQK6Q032mqcBOQtPZLcGXGiUkqBMeq8tvFME13LIOPj3hnMq
         ki7OURbGneW26K2O5/z8BONKwmhqS8+MRxJx5ooqxRHAo0dKDTuC2bqgYhV4qx5vtmWv
         KcGQx8gX3t/aG1v/0dBxNRz4BiLxw06seCn+LiKb3DR+yITGXhoLFJw9NISHIk7Bmknf
         htCRyF7T7u0FPQoQrehpJdhgS1HRsNRbfkDS2DTHVeqI28KIvrbWGGENXYzcTIkExxo0
         LBsg==
X-Gm-Message-State: APjAAAUbCYLHLH4m5RguYr9dv3JZZnlXdg3kgN0oGWCZhZU3fD7ji3P+
        9XdRUwXhj+X1Axd+bOrQBp75RMuE
X-Google-Smtp-Source: APXvYqxGCizfvK1UGE+bC5RyhA56TtTOlbWYW36netvbb2/VlrkIkt/5Vjq740ZmufPU77IaRcGIWw==
X-Received: by 2002:aa7:ccd6:: with SMTP id y22mr45005723edt.274.1562186764589;
        Wed, 03 Jul 2019 13:46:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p43sm1034862edc.3.2019.07.03.13.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:46:04 -0700 (PDT)
Date:   Wed, 03 Jul 2019 13:46:04 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Jul 2019 20:46:02 GMT
Message-Id: <2d2253faef14e5157f8aac4534d9ac9640f3d5fa.1562186762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.217.v2.git.gitgitgadget@gmail.com>
References: <pull.217.git.gitgitgadget@gmail.com>
        <pull.217.v2.git.gitgitgadget@gmail.com>
From:   "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] gettext: always use UTF-8 on native Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Karsten Blees <blees@dcon.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karsten Blees <blees@dcon.de>

On native Windows, Git exclusively uses UTF-8 for console output (both
with MinTTY and native Win32 Console). Gettext uses `setlocale()` to
determine the output encoding for translated text, however, MSVCRT's
`setlocale()` does not support UTF-8. As a result, translated text is
encoded in system encoding (as per `GetAPC()`), and non-ASCII chars are
mangled in console output.

Side note: There is actually a code page for UTF-8: 65001. In practice,
it does not work as expected at least on Windows 7, though, so we cannot
use it in Git. Besides, if we overrode the code page, any process
spawned from Git would inherit that code page (as opposed to the code
page configured for the current user), which would quite possibly break
e.g. diff or merge helpers. So we really cannot override the code page.

In `init_gettext_charset()`, Git calls gettext's
`bind_textdomain_codeset()` with the character set obtained via
`locale_charset()`; Let's override that latter function to force the
encoding to UTF-8 on native Windows.

In Git for Windows' SDK, there is a `libcharset.h` and therefore we
define `HAVE_LIBCHARSET_H` in the MINGW-specific section in
`config.mak.uname`, therefore we need to add the override before that
conditionally-compiled code block.

Rather than simply defining `locale_charset()` to return the string
`"UTF-8"`, though, we are careful not to break `LC_ALL=C`: the
`ab/no-kwset` patch series, for example, needs to have a way to prevent
Git from expecting UTF-8-encoded input.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gettext.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/gettext.c b/gettext.c
index d4021d690c..3f2aca5c3b 100644
--- a/gettext.c
+++ b/gettext.c
@@ -12,7 +12,25 @@
 #ifndef NO_GETTEXT
 #	include <locale.h>
 #	include <libintl.h>
-#	ifdef HAVE_LIBCHARSET_H
+#	ifdef GIT_WINDOWS_NATIVE
+
+static const char *locale_charset(void)
+{
+	const char *env = getenv("LC_ALL"), *dot;
+
+	if (!env || !*env)
+		env = getenv("LC_CTYPE");
+	if (!env || !*env)
+		env = getenv("LANG");
+
+	if (!env)
+		return "UTF-8";
+
+	dot = strchr(env, '.');
+	return !dot ? env : dot + 1;
+}
+
+#	elif defined HAVE_LIBCHARSET_H
 #		include <libcharset.h>
 #	else
 #		include <langinfo.h>
-- 
gitgitgadget
