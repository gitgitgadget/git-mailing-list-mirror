Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1273D1F4C1
	for <e@80x24.org>; Wed, 16 Oct 2019 12:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbfJPMG6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 08:06:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33940 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbfJPMG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 08:06:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id j11so27769205wrp.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=iI5VI+0lKQc3UKwM4Gc7CeBNVJTaOZnmwGZxYSqOkqE=;
        b=V7bgj5RQcVB+pnRDYCtMfH4hOB0/RV1l0tgcu8Ql+uu5QRxpzgKZQ1vkDKxeSJHwrY
         pue+4peLjf08PwFLMxDAe2IPpakyWaEhFIX6rEEH/7fYmqtC5SAwkHaCL9aV2gpnifFR
         KOqe0DZgu2qv8EgVKLgq510NCYEbFl29UREIRgGV4yjnYKIQuyVwQbFp71PTUaG/mlH1
         4Pc2yf2D3TmZ6o0k+IwQvFU3DHN7o+ouSk+FIQkM+4hBNF6KUnh7irAA7RIWTbxj+/Hq
         gfezbPUCTJcDlSxXndcCxPYr/F4CozTPSdB9sawlWoTB4DQHOcEO94Qz28JVnqgUa90u
         5OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=iI5VI+0lKQc3UKwM4Gc7CeBNVJTaOZnmwGZxYSqOkqE=;
        b=ZKTBkwK+LnFB6VHB65IpycSd1//KcZzZa6exlYrKqYZSs+ygky1GfZqz/pxO6uJrMU
         BAyYv+bN3Pw2OxQD6pL/oeLZf56Stc5Qf0ZzLZ52Kx1K2nwHhAESAfQrfZGxC77laJEt
         cnrmO1ry29MGCqbkM3/L0v4sEzO/kbOgaaNBXmg+Tx31tLgz9x12w1I5tOIIuR1xhHyI
         TypC/s19xCPGV1kwunWqCqBoVLDpNX8t1htM5P7FSkpdiXT4y/OHs3b8QLPCoKPnTISh
         XsB0402zKOeqqOnFMalu18679k/+wWP4O/8UHqOoXfQAB09Srxkxcl1/L50uvMaH/7wj
         aLJw==
X-Gm-Message-State: APjAAAWytdgI7tp5D97gBP1XWqOFeUg39ntwkHq7KWlkivksvqSyxmuV
        F6uU0rWEEgPe35N4q2Nh01DvwecA
X-Google-Smtp-Source: APXvYqyzdTEHJKUYdiGbs14my4QJTM74wbrhsHL4gJ+pwuOBNzsrxGKr/coDwnxU3XfWznuUCudH+Q==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr2417466wrr.93.1571227615720;
        Wed, 16 Oct 2019 05:06:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t203sm2828900wmf.42.2019.10.16.05.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 05:06:55 -0700 (PDT)
Message-Id: <4feb8cc83a6d0b73bd7e47a513b91ce193c6ed6f.1571227613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.402.git.1571227613.gitgitgadget@gmail.com>
References: <pull.402.git.1571227613.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 12:06:51 +0000
Subject: [PATCH 1/3] grep: make PCRE1 aware of custom allocator
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

63e7e9d8b6 ("git-grep: Learn PCRE", 2011-05-09) didn't include a way
to override the system alocator, and so it is incompatible with
USE_NED_ALLOCATOR as reported by Dscho[1] (in similar code from PCRE2)

Note that nedmalloc, as well as other custom allocators like jemalloc
and mi-malloc, can be configured at runtime (via `LD_PRELOAD`),
therefore we cannot know at compile time whether a custom allocator is
used or not.

Make the minimum change possible to ensure this combination is supported
by extending `grep_init()` to set the PCRE1 specific functions to Git's
idea of `malloc()` and `free()` and therefore making sure all
allocations are done inside PCRE1 with the same allocator than the rest
of Git.

This change has negligible performance impact: PCRE needs to allocate
memory once per program run for the character table and for each pattern
compilation. These are both rare events compared to matching patterns
against lines. Actual measurements[2] show that the impact is lost in
the noise.

[1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com
[2] https://public-inbox.org/git/7f42007f-911b-c570-17f6-1c6af0429586@web.de

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 grep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/grep.c b/grep.c
index cd952ef5d3..db6e0d895f 100644
--- a/grep.c
+++ b/grep.c
@@ -150,12 +150,20 @@ int grep_config(const char *var, const char *value, void *cb)
  * Initialize one instance of grep_opt and copy the
  * default values from the template we read the configuration
  * information in an earlier call to git_config(grep_config).
+ *
+ * If using PCRE, make sure that the library is configured
+ * to use the same allocator as Git (e.g. nedmalloc on Windows).
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
 	struct grep_opt *def = &grep_defaults;
 	int i;
 
+#ifdef USE_LIBPCRE1
+	pcre_malloc = malloc;
+	pcre_free = free;
+#endif
+
 	memset(opt, 0, sizeof(*opt));
 	opt->repo = repo;
 	opt->prefix = prefix;
-- 
gitgitgadget

