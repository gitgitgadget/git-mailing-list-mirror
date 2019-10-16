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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3421E1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 12:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392889AbfJPMKb (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 08:10:31 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37787 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392880AbfJPMKa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 08:10:30 -0400
Received: by mail-wm1-f42.google.com with SMTP id f22so2501581wmc.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=gUrs+mtBumQYWX2akyuDAViVag77XGlQLFjzguGgofQ=;
        b=irLeYNcgrSYa/L5ZSBeEhfc8MIbHmYk/xyATYxlpmAz9hpYGvU/eNfvDOGE0A+FLYW
         KafoYTzYgIC0LBE1vcKEqzluCOSEMjipDyE88yG++cq3YjsP8QUad9daIaIiCb9p3jAL
         K1LvoBMEhom1C1EMvjOIqi7skFhOHKoEA++iRlWV57bJ1KhgbZSvHPvglvs4F1BNLPjH
         jnzcSHPhrg20AN9QdrNoJPuu+ck3MOuIuNI2ie5c09lT36WpyjSJPMR7TfVnGE2cjiz/
         CEur4BkTLj3fE19zSgjCKfySr3dctdVSiXNoJHsN2y9t1F3rNln/jx88u4iapvG/loI5
         wMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=gUrs+mtBumQYWX2akyuDAViVag77XGlQLFjzguGgofQ=;
        b=lhoc2wFZjmz68yvtospqUF8nC4IbIuYkvYND0rHhLYfRwq1/BQDyGWRjPUx29qcWMY
         W+xwddtxanCPE4IET+2+LTMp3+hClextLzVLqBXkrFOMcKIxh9BF4e8FYOWK7OGj60q6
         HEw6t4RdLfRFXowt2FBf6FqRU/fJaZXki0f20hIkiLsSuWNBjYBrmzqFu8qpwXsVGAYq
         A+ieHwOTaGKgnxg4G5rmpXVvTwLkCSH6XwKmUJoMMaPaVF2lzoo/ik7uEBlhv6bYF6O6
         Oe4R5QP+zOAkVFx2zDr8rOHnFNZcKAs7EbUakcY8DNLXI17rzto5idDmIhfZETZZzEqm
         tRlQ==
X-Gm-Message-State: APjAAAWLAGEnBZHjIdgzXwGY9gJnQes2JiVrBpIq2qAtV1l3/PdzQGUU
        lPomxN29WoNvN5HCfHU4BBTiPSyO
X-Google-Smtp-Source: APXvYqwYbJlwd0KVMYh/HP98bhUXXKxepQKO+yLCi8cWynOkB1xCH4d1gtW/pBYK00xJjo/AZe5aXw==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr3421370wmc.0.1571227827748;
        Wed, 16 Oct 2019 05:10:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9sm7876480wme.3.2019.10.16.05.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 05:10:27 -0700 (PDT)
Message-Id: <f8724fb267a1629712db742f1e06a452f6b69d3d.1571227824.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.402.v2.git.1571227824.gitgitgadget@gmail.com>
References: <pull.402.git.1571227613.gitgitgadget@gmail.com>
        <pull.402.v2.git.1571227824.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 12:10:24 +0000
Subject: [PATCH v2 3/3] grep: avoid leak of chartables in PCRE2
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

94da9193a6 ("grep: add support for PCRE v2", 2017-06-01) introduced
a small memory leak visible with valgrind in t7813.

Complete the creation of a PCRE2 specific variable that was missing from
the original change and free the generated table just like it is done
for PCRE1.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 grep.c | 7 ++++---
 grep.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 296edbb56f..9556d13dc1 100644
--- a/grep.c
+++ b/grep.c
@@ -525,7 +525,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	PCRE2_UCHAR errbuf[256];
 	PCRE2_SIZE erroffset;
 	int options = PCRE2_MULTILINE;
-	const uint8_t *character_tables = NULL;
 	int jitret;
 	int patinforet;
 	size_t jitsizearg;
@@ -539,9 +538,10 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		if (has_non_ascii(p->pattern)) {
 			if (!pcre2_global_context)
 				BUG("pcre2_global_context uninitialized");
-			character_tables = pcre2_maketables(pcre2_global_context);
+			p->pcre2_tables = pcre2_maketables(pcre2_global_context);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
-			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
+			pcre2_set_character_tables(p->pcre2_compile_context,
+							p->pcre2_tables);
 		}
 		options |= PCRE2_CASELESS;
 	}
@@ -645,6 +645,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_match_data_free(p->pcre2_match_data);
 	pcre2_jit_stack_free(p->pcre2_jit_stack);
 	pcre2_match_context_free(p->pcre2_match_context);
+	free((void *)p->pcre2_tables);
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 526c2db9ef..533165c21a 100644
--- a/grep.h
+++ b/grep.h
@@ -96,6 +96,7 @@ struct grep_pat {
 	pcre2_compile_context *pcre2_compile_context;
 	pcre2_match_context *pcre2_match_context;
 	pcre2_jit_stack *pcre2_jit_stack;
+	const uint8_t *pcre2_tables;
 	uint32_t pcre2_jit_on;
 	kwset_t kws;
 	unsigned fixed:1;
-- 
gitgitgadget
