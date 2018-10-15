Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A72D1F454
	for <e@80x24.org>; Mon, 15 Oct 2018 09:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeJORbi (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:31:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46768 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJORbi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:31:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5-v6so9024967plz.13
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=43gwBEROkVOEMySW+ruZYZjCsi4NBCf9Fq8Q9f7KDik=;
        b=BKLKRrFnqkTfWs/cmnxW2IBGxNt/1Xp09diLoja95fXSxN2Oey6SKfPqkgwPNMCwRr
         UtrPA8Axu5GZJtpTuasoeNrGpafOxbvdJbrO/ZZqKxD7nGBAM/xXKhkrbfPYCOgfo+JC
         EHjrk8yUzAVvXtjhrSj/0oKl6CIwLGN0JXLF81oK3NNn4Mx3Zd+jVwMlvYBSroBEyClD
         Yx53LuKhhe0fhfqzGcuvi7lSEEz/QeqEQfKtlFZCD8Xv+G1UH/5p+wrRMP9R9HCyWC2R
         np+DudFrXvcYHqW0g/c3QNNTYZOfO/lYOvW+ODtNC4fzH32WiITt0kLqS0+TfhTRYySg
         NRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=43gwBEROkVOEMySW+ruZYZjCsi4NBCf9Fq8Q9f7KDik=;
        b=AjQVLpr1nDs85GQAQQHkXrTBaJ2SoYhvX/V2N/Obw6FgGhpCXRiXtT8KN9vaBC+qsE
         EDUTzzofYS2IxWewCP4s7AtK2q2PzkoblYrhMD2UkMW+LpV6rcutzHJmwIflBOYRr/pu
         cHWg4YR47aKPzd1VODhlMoyISDJa0xvEhFKVEcdoxChAdLlWSmkbWWspbsJbBmG4zepV
         ZHEIbsh9qFA680i7RhRJoGPGLp9LiYVNv9sRDeIwFl4QvYx8Tx2U/PqyFLqr3nXhdAQU
         CaZYcQggdyIskenpkRDl743bhDL9ZYDCLe/Nai8Avh8v4u1ZOaq0cEtRNSXi6p6aBFhk
         FU4g==
X-Gm-Message-State: ABuFfoh175evLT7UyZHfTdXlnN1K1T+YC3KQtx67s4JgW7NacYcGAKBP
        xXA4zGSmqIZlZf4vMmPmJc2KiWOS
X-Google-Smtp-Source: ACcGV617l7lP0kUQoWc9bzxomHMctid+bFoOwgAwFoik+VGDRxkHAQnIGFSo0G1Xl//t0iv0vuOpGQ==
X-Received: by 2002:a17:902:447:: with SMTP id 65-v6mr16269287ple.325.1539596827458;
        Mon, 15 Oct 2018 02:47:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h75-v6sm9076830pfe.146.2018.10.15.02.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 02:47:06 -0700 (PDT)
Date:   Mon, 15 Oct 2018 02:47:06 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 09:47:00 GMT
Message-Id: <11025b1639785577924b2020fb20d076308e9c69.1539596822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.45.git.gitgitgadget@gmail.com>
References: <pull.45.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] getpwuid(mingw): provide a better default for the user
 name
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

We do have the excellent GetUserInfoEx() function to obtain more
detailed information of the current user (if the user is part of a
Windows domain); Let's use it.

Suggested by Lutz Roeder.

To avoid the cost of loading Secur32.dll (even lazily, loading DLLs
takes a non-neglibile amount of time), we use the established technique
to load DLLs only when, and if, needed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 597781b370..623ff5daf5 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -5,6 +5,7 @@
 #include "../strbuf.h"
 #include "../run-command.h"
 #include "../cache.h"
+#include "win32/lazyload.h"
 
 #define HCAST(type, handle) ((type)(intptr_t)handle)
 
@@ -1798,6 +1799,33 @@ int mingw_getpagesize(void)
 	return si.dwAllocationGranularity;
 }
 
+/* See https://msdn.microsoft.com/en-us/library/windows/desktop/ms724435.aspx */
+enum EXTENDED_NAME_FORMAT {
+	NameDisplay = 3,
+	NameUserPrincipal = 8
+};
+
+static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
+{
+	DECLARE_PROC_ADDR(secur32.dll, BOOL, GetUserNameExW,
+		enum EXTENDED_NAME_FORMAT, LPCWSTR, PULONG);
+	static wchar_t wbuffer[1024];
+	DWORD len;
+
+	if (!INIT_PROC_ADDR(GetUserNameExW))
+		return NULL;
+
+	len = ARRAY_SIZE(wbuffer);
+	if (GetUserNameExW(type, wbuffer, &len)) {
+		char *converted = xmalloc((len *= 3));
+		if (xwcstoutf(converted, wbuffer, len) >= 0)
+			return converted;
+		free(converted);
+	}
+
+	return NULL;
+}
+
 struct passwd *getpwuid(int uid)
 {
 	static unsigned initialized;
@@ -1816,7 +1844,9 @@ struct passwd *getpwuid(int uid)
 
 	p = xmalloc(sizeof(*p));
 	p->pw_name = user_name;
-	p->pw_gecos = "unknown";
+	p->pw_gecos = get_extended_user_info(NameDisplay);
+	if (!p->pw_gecos)
+		p->pw_gecos = "unknown";
 	p->pw_dir = NULL;
 
 	initialized = 1;
-- 
gitgitgadget

