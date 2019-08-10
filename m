Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F9B1F731
	for <e@80x24.org>; Sat, 10 Aug 2019 03:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfHJDDV (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 23:03:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38865 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfHJDDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 23:03:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so1661911pfg.5
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6+qwPozw8dQk7LX+lFnG1TZpoATC2pth7ermpjAyCE=;
        b=Vj/D/J0tlE+ggW/Y6N+UXnF5oo/i5jyuNFdX+mAXQf8fCW214XWkUDjGrl7AP2ogYW
         oLBEQjhUbHY8u/ASinqGrQyCc1pMB7RjJ+RmONHtkT7lRYhjXHW8qUDXyt5qJ7mUv8wY
         zfvTIiythwQzeBE3FOO2yZCUAuxONmaZ3qh9FC4VccsQBE0X0ex63LM5kSOnroteBqfZ
         4e8enpoCN/EJj09ymdHMdW4kmf1QPI1kAGSPHF3hb25CEIn7oV5yWGW6z7zvMun34b4Z
         Pq6CercwALx8gG7r+AmHU8pqOK7JifIrdT9Epk65LhTBlCS/pe2URlosIJxJj8OZqzBG
         ZrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6+qwPozw8dQk7LX+lFnG1TZpoATC2pth7ermpjAyCE=;
        b=q3/6ZiCwKAXTnon1v5/Bo4KqhgvtWLJ8gHdcGQl5XwJsjvZ8PfWADvYyHrckZV0fbT
         kaLQxJXyMCSNmP1H0HW3bePOlFdpZvJSVyvjzZGq4TP1MmFMw1I5zHEj8QBzZ8kU+8XN
         wLgpTTh7ud4SIWg6icur4IKjdn9Zmpk7Tsqh+4OYT/fjfzXlVqTgcLNblAh2/2VE1dU1
         4/5i0feestKA77aMgmYIPrv1rz1tNs1VN+GI2ehSiFBze3nwxfLgWe0tYbo+cXhcIIDN
         V7QhYWyW6arNxLySN2ATePjwHwkEMt5paRSl/FfmmR+dPSkawUV1Q2e5EnP2PdDWCx+6
         BckA==
X-Gm-Message-State: APjAAAWimItW+iPQ0D3kxk362k/EGdSkkRsTgXTThKoukPNOLdDuZISv
        MHbzGwZ7PhUXiMsQFsT4edc=
X-Google-Smtp-Source: APXvYqyL0s5Z+8/KjI5mdK1bxsqJiTnvrKZIy25dQzKv8KVnTnauUm59L3KU6ebwIgbIPdCGrTve+g==
X-Received: by 2002:a65:4505:: with SMTP id n5mr18270055pgq.301.1565406200505;
        Fri, 09 Aug 2019 20:03:20 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 65sm106731280pgf.30.2019.08.09.20.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 20:03:19 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     avarab@gmail.com, carenas@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: [PATCH] SQUASH
Date:   Fri,  9 Aug 2019 20:03:15 -0700
Message-Id: <20190810030315.7519-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
In-Reply-To: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make using a general context (that is only needed with NED) to depend
on NED being selected at compile time.

the compile_context could be also make conditional but it gets ugly
really fasts with #ifdef
---
 Makefile | 2 +-
 grep.c   | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8a7e235352..995e6c9351 100644
--- a/Makefile
+++ b/Makefile
@@ -1774,7 +1774,7 @@ ifdef NATIVE_CRLF
 endif
 
 ifdef USE_NED_ALLOCATOR
-	COMPAT_CFLAGS += -Icompat/nedmalloc
+	COMPAT_CFLAGS += -DUSE_NED_ALLOCATOR -Icompat/nedmalloc
 	COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 	OVERRIDE_STRDUP = YesPlease
 endif
diff --git a/grep.c b/grep.c
index 8255ec956e..233072ed80 100644
--- a/grep.c
+++ b/grep.c
@@ -482,6 +482,7 @@ static void free_pcre1_regexp(struct grep_pat *p)
 #endif /* !USE_LIBPCRE1 */
 
 #ifdef USE_LIBPCRE2
+#ifdef USE_NED_ALLOCATOR
 static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
 {
 	return xmalloc(size);
@@ -491,6 +492,7 @@ static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
 {
 	free(pointer);
 }
+#endif
 
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -505,7 +507,9 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	assert(opt->pcre2);
 
+#ifdef USE_NED_ALLOCATOR
 	p->pcre2_general_context = pcre2_general_context_create(pcre2_malloc, pcre2_free, NULL);
+#endif
 	p->pcre2_compile_context = pcre2_compile_context_create(p->pcre2_general_context);
 
 	if (opt->ignore_case) {
-- 
2.23.0.rc2

