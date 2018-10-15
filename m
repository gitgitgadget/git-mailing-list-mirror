Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804461F454
	for <e@80x24.org>; Mon, 15 Oct 2018 09:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJORbk (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:31:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42904 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJORbk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:31:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so9393878pfn.9
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pa/cNXgdw6iTHYCWMTFqFBiLlpMl1L2tnyXTlNIMxH0=;
        b=pbi95nA6ffvAY9GVLLfzmu6a9g49+vCp9xTWVoewrNhnAUBV2UyG26Mtf99Y87H9hl
         N0kfoza1A3WxMweaD7oTn9CjmQUxlI+11y/aoOw+u+qZDrC8CwG/neF/+H+6O6t00qhE
         efbsBsB9CFEoukxAyandUpc2D/Ffoks3q59B48KpDXCRv3JD/MTT4EN3en/W/AuKJkNe
         M+6qjy98FKXnL9Uxh42ixga2Hp5Zifr4c5TQe0GYuyj309m5WIAOmCjC0YasVZcvfgol
         uMTBP+Boa9sieLbN4wDzljEzCDd/YncxFdObHwIatmBmDqhURwdD6FYxOXce7CRo2HxN
         Goew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pa/cNXgdw6iTHYCWMTFqFBiLlpMl1L2tnyXTlNIMxH0=;
        b=aUGAoV6xIreTv2iqGvM2Ozf2hewsdRWOrr/eGfQL65/FmNPQiIOUjUSt2gAVRtJP6Q
         OetrUSPiWgXWfKXTw+xOeplvbJdBDVLx1tA2uOspFyDoC1+QZYuZsiZw5m/Tun21UZ8+
         l39jZ+/CwlYD1afW1F6hJXb2Luw8gsWcz0FkSZ1docfBYckQM7/THTIq4yA7gvlU8RcB
         HJkYrSTbLG6+mxdK2x825OiYdoeDSVHBF6X89rY/VIbVduEpMmQS9aMENkgJxf7caJvc
         APSYIjITAmQTpoN2yhpdsZZOj1tKxTRMpOxo3+OnapNVJBRX3ILhLnx2Bh9U3MZutlk8
         7wWQ==
X-Gm-Message-State: ABuFfoj63k1ldjgQcAIm2Bdap9XfBIz2h2Jqi0icGiLTzdBlQEPCzLFx
        Yd/xj0tg84cCcAmNyJV5uRCr5+AA
X-Google-Smtp-Source: ACcGV62RjACh/Y7o9UnsYh0lP5j9z//0eDDKea4Rb/llHpEms0t5kfTMkPK5NGjDDHWOqFRxip4T6A==
X-Received: by 2002:a63:1d62:: with SMTP id d34-v6mr15593959pgm.180.1539596828994;
        Mon, 15 Oct 2018 02:47:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h6-v6sm12864344pgn.84.2018.10.15.02.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 02:47:08 -0700 (PDT)
Date:   Mon, 15 Oct 2018 02:47:08 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 09:47:01 GMT
Message-Id: <271a5f57cef00d24ee33e99839cf3890e561efe7.1539596822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.45.git.gitgitgadget@gmail.com>
References: <pull.45.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] mingw: use domain information for default email
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

When a user is registered in a Windows domain, it is really easy to
obtain the email address. So let's do that.

Suggested by Lutz Roeder.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c    | 5 +++++
 compat/mingw.h    | 2 ++
 git-compat-util.h | 4 ++++
 ident.c           | 3 +++
 4 files changed, 14 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 623ff5daf5..44264fe3fd 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1826,6 +1826,11 @@ static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
 	return NULL;
 }
 
+char *mingw_query_user_email(void)
+{
+	return get_extended_user_info(NameUserPrincipal);
+}
+
 struct passwd *getpwuid(int uid)
 {
 	static unsigned initialized;
diff --git a/compat/mingw.h b/compat/mingw.h
index 571019d0bd..f31dcff2be 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -424,6 +424,8 @@ static inline void convert_slashes(char *path)
 int mingw_offset_1st_component(const char *path);
 #define offset_1st_component mingw_offset_1st_component
 #define PATH_SEP ';'
+extern char *mingw_query_user_email(void);
+#define query_user_email mingw_query_user_email
 #if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
diff --git a/git-compat-util.h b/git-compat-util.h
index 5f2e90932f..71779cb0ae 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -382,6 +382,10 @@ static inline char *git_find_last_dir_sep(const char *path)
 #define find_last_dir_sep git_find_last_dir_sep
 #endif
 
+#ifndef query_user_email
+#define query_user_email() NULL
+#endif
+
 #if defined(__HP_cc) && (__HP_cc >= 61000)
 #define NORETURN __attribute__((noreturn))
 #define NORETURN_PTR
diff --git a/ident.c b/ident.c
index 327abe557f..33bcf40644 100644
--- a/ident.c
+++ b/ident.c
@@ -168,6 +168,9 @@ const char *ident_default_email(void)
 			strbuf_addstr(&git_default_email, email);
 			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		} else if ((email = query_user_email()) && email[0]) {
+			strbuf_addstr(&git_default_email, email);
+			free((char *)email);
 		} else
 			copy_email(xgetpwuid_self(&default_email_is_bogus),
 				   &git_default_email, &default_email_is_bogus);
-- 
gitgitgadget
