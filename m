Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B41C1F732
	for <e@80x24.org>; Mon,  5 Aug 2019 11:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfHELvM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 07:51:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36161 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfHELvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 07:51:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so68589887wme.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=STvBARYV+SjBVkQx82mIRGj3GXAnGmQ9t+Q9zU/8fQk=;
        b=aaGmstqiA3Zs1KEQqKU7whljnjE9oz7nLws61WY4sdg8D5oG3q5jR1OSbXhROop5FA
         vUUtvrRTvq3ZdryuwCNRa5z5YWacD+CjMn72bCGFH86yQQ5U/J4p0/DKv3uxQkH9Opj3
         6A24rEtkVLahODj7E5I2aNfjWZAcofUpGLvvDH4/F1AXnBO4gMevmd2Qpk5K/TDc4TXb
         ZHhYg3JB9VW6T3RAzA2OFoxcFuYN31xhnWEumQ8OrrbO/foouW5e58R1RsVR4ql33NHY
         4dLZ/vssvldm1jSygYFMHNYTGr2Zl9Zkwld6FII+PTbcz/nNzjPcE3upv+fRoBUrRZes
         SlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=STvBARYV+SjBVkQx82mIRGj3GXAnGmQ9t+Q9zU/8fQk=;
        b=lUGFR29CIKOVQ6c/Xlq/iHY8YkjHBM0ZHxbpg03UTHKYOyyChgvylGQ0PmpKpqXKi6
         jBNw1eaQZaCLt+2BJ5I8n8XswCfLjqRn/wXrTag1DwwqT9toYSeDKZacqbAmY7yJFd4M
         r2WIC7YTb4OC4WQcfgyQHYw7J9px1oICDqsJRN51wOfH446GWrgy5x3VnwbtR2X7bGQI
         9Z/krAoMJIeOddwqrcEpz8WrO4/ITdbCNEkBa/qPLgd2nG8jOM9v+RI6wkL5w3LCFpUe
         wajDikUBciIFzEc8tN2Qx2ggvHEEaotpibGf1L/4+wpleSPkv3Y+QKKVnR26N6TZGlCI
         qItQ==
X-Gm-Message-State: APjAAAVjL409SxF5VJHW4zQxOpEi1n2J1sYj1izn9ZUFP+7AUu6wCvfq
        O1X8UDB2t3TpeQRJIdyh96yrgDbJ
X-Google-Smtp-Source: APXvYqwMc+3udeCNj885efr+JekWGC9O3+jjWR42g4A1kc7GndNFCflK0hrxMc47DE14altYR4d9Nw==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr18146444wmu.67.1565005869764;
        Mon, 05 Aug 2019 04:51:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x20sm189686748wrg.10.2019.08.05.04.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 04:51:09 -0700 (PDT)
Date:   Mon, 05 Aug 2019 04:51:09 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Aug 2019 11:51:07 GMT
Message-Id: <3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.306.git.gitgitgadget@gmail.com>
References: <pull.306.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] pcre2: allow overriding the system allocator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 7d3bf769994 (grep: avoid leak of chartables in PCRE2, 2019-08-01),
we try to release the UTF-8 tables obtained via `pcre2_maketables()`. To
do that, we use the function `free()`. That is all fine and dandy as
long as that refers to the system allocator.

However, when we compile Git with `USE_NED_ALLOCATOR` (notably on
Windows), then `free()` actually calls `nedfree()`. But
`pcre2_maketables()` allocated the tables using the system allocator
because we did not tell it to use nedmalloc instead.

This leads to segmentation faults when the UTF-8 tables are released,
most notably in the `t7816-grep-binary-pattern.sh` test script.

PCRE2 does have an option to override the allocator it should use, and
this patch calls upon it.

As there are other ways to override the system allocator than
`USE_NED_ALLOCATOR`, we choose to specify the allocator we want to use
specifically, even if we still use the system allocator.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 grep.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index d4c5d464ad..d6d29fc724 100644
--- a/grep.c
+++ b/grep.c
@@ -482,6 +482,27 @@ static void free_pcre1_regexp(struct grep_pat *p)
 #endif /* !USE_LIBPCRE1 */
 
 #ifdef USE_LIBPCRE2
+static void *pcre2_malloc(PCRE2_SIZE size, void *memory_data)
+{
+	return malloc(size);
+}
+
+static void pcre2_free(void *pointer, void *memory_data)
+{
+	return free(pointer);
+}
+
+static pcre2_general_context *get_pcre2_context(void)
+{
+	static pcre2_general_context *context;
+
+	if (!context)
+		context = pcre2_general_context_create(pcre2_malloc,
+						       pcre2_free, NULL);
+
+	return context;
+}
+
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
 {
 	int error;
@@ -498,8 +519,9 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern)) {
-			p->pcre2_tables = pcre2_maketables(NULL);
-			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
+			p->pcre2_tables = pcre2_maketables(get_pcre2_context());
+			p->pcre2_compile_context =
+				pcre2_compile_context_create(get_pcre2_context());
 			pcre2_set_character_tables(p->pcre2_compile_context,
 							p->pcre2_tables);
 		}
@@ -513,7 +535,8 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 					 p->pcre2_compile_context);
 
 	if (p->pcre2_pattern) {
-		p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, NULL);
+		p->pcre2_match_data =
+			pcre2_match_data_create_from_pattern(p->pcre2_pattern, get_pcre2_context());
 		if (!p->pcre2_match_data)
 			die("Couldn't allocate PCRE2 match data");
 	} else {
@@ -550,7 +573,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			return;
 		}
 
-		p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 * 1024, NULL);
+		p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 * 1024, get_pcre2_context());
 		if (!p->pcre2_jit_stack)
 			die("Couldn't allocate PCRE2 JIT stack");
 		p->pcre2_match_context = pcre2_match_context_create(NULL);
-- 
gitgitgadget
