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
	by dcvr.yhbt.net (Postfix) with ESMTP id 57EF11F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 12:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392887AbfJPMK3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 08:10:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39523 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392880AbfJPMK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 08:10:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so2485803wml.4
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=38r/UVhjG5EsDsuddd2xDseECchSBL3SYD5WQz7alHQ=;
        b=A9R6ffTc7DYe9aY7JXbvYLCxXWZFYNkJUenmO7YpehSEw8ytfvHm3jwzlhfR6PQ050
         E47aT/cq2MfWCWnmJXOGmT39SQ4ENW7pig1+3XNhir6yPVPEQ0CfMVQNjTXZVo4adXxz
         nv239848S9YQwcsuO83z4h0rgDxP0oc6QBwM5XFUjUC6xX42V1JP8RTm9V2WLGm7eKUH
         EoE71VxbNnOxZNI1VYnmu50+jqMGKfic3NoftVZ2SeCMbsdyu4tPizVkngpZ1avffinm
         vKkMFQNBvPAI5XDyH7UwGF1eszCTLa3/MMWw0Nt5092FgmmhiWTS8vRuhDY58hkEkJt5
         KiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=38r/UVhjG5EsDsuddd2xDseECchSBL3SYD5WQz7alHQ=;
        b=dD0hN2/KozbSnWqWHBIVaQsn8H7sfbUGOzq3QBHTFjjSmCpjv8l2qG96Ype1l4GbUf
         +AFSXgHnANhfACGE+aK1SYHhPdh6ZfqQOnioAhKOtTFaDwFSsnWh+lnsxFTG7Jd2QTtB
         /SxY9OyC20zbV9I8JYuHMcZHr9NvER41ZsQh+IKKUBDA/PVGnZVqyQV9iD/dm5pJDpYW
         aCI5dzNVJ1hKR6EO1NQrpW/9EbhBeTrxXnWXjzviaZ/5lhUJfBHLs5/PDhBeEAZwJCpf
         ZoBwLNx9kOsewQyIA3AlrgGd8P3QVadkXNB8GsPapeGWSkGcyN09O+KNHPKEGZN3aPHT
         p5tw==
X-Gm-Message-State: APjAAAWibBDXC4SnMaHvuJo4H6A4ld6P+z0FJjkY3d0eCxE73/2/gf7O
        1zsXHeILvEm2ltEFmwldIRg9hzF1
X-Google-Smtp-Source: APXvYqy3qAVPOlUo8ruNNKEXQPHcLMoJqdfWPiZsYeztHUYaY8Tvu5v7aC+INvD7fn/12nJJEEPxaA==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr3248698wmj.94.1571227826827;
        Wed, 16 Oct 2019 05:10:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b62sm3187394wmc.13.2019.10.16.05.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 05:10:26 -0700 (PDT)
Message-Id: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.402.v2.git.1571227824.gitgitgadget@gmail.com>
References: <pull.402.git.1571227613.gitgitgadget@gmail.com>
        <pull.402.v2.git.1571227824.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 12:10:23 +0000
Subject: [PATCH v2 2/3] grep: make PCRE2 aware of custom allocator
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

94da9193a6 (grep: add support for PCRE v2, 2017-06-01) didn't include
a way to override the system allocator, and so it is incompatible with
custom allocators (e.g. nedmalloc). This problem became obvious when we
tried to plug a memory leak by `free()`ing a data structure allocated by
PCRE2, triggering a segfault in Windows (where we use nedmalloc by
default).

PCRE2 requires the use of a general context to override the allocator
and therefore, there is a lot more code needed than in PCRE1, including
a couple of wrapper functions.

Extend the grep API with a "destructor" that could be called to cleanup
any objects that were created and used globally.

Update `builtin/grep.c` to use that new API, but any other future users
should make sure to have matching `grep_init()`/`grep_destroy()` calls
if they are using the pattern matching functionality.

Move some of the logic that was before done per thread (in the workers)
into an earlier phase to avoid degrading performance, but as the use of
PCRE2 with custom allocators is better understood it is expected more of
its functions will be instructed to use the custom allocator as well as
was done in the original code[1] this work was based on.

[1] https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com/

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/grep.c |  1 +
 grep.c         | 34 +++++++++++++++++++++++++++++++++-
 grep.h         |  1 +
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 560051784e..e49c20df60 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1145,5 +1145,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
 	free_grep_patterns(&opt);
+	grep_destroy();
 	return !hit;
 }
diff --git a/grep.c b/grep.c
index db6e0d895f..296edbb56f 100644
--- a/grep.c
+++ b/grep.c
@@ -16,6 +16,20 @@ static int grep_source_is_binary(struct grep_source *gs,
 
 static struct grep_opt grep_defaults;
 
+#ifdef USE_LIBPCRE2
+static pcre2_general_context *pcre2_global_context;
+
+static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
+{
+	return malloc(size);
+}
+
+static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
+{
+	return free(pointer);
+}
+#endif
+
 static const char *color_grep_slots[] = {
 	[GREP_COLOR_CONTEXT]	    = "context",
 	[GREP_COLOR_FILENAME]	    = "filename",
@@ -153,12 +167,20 @@ int grep_config(const char *var, const char *value, void *cb)
  *
  * If using PCRE, make sure that the library is configured
  * to use the same allocator as Git (e.g. nedmalloc on Windows).
+ *
+ * Any allocated memory needs to be released in grep_destroy().
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
 	struct grep_opt *def = &grep_defaults;
 	int i;
 
+#if defined(USE_LIBPCRE2)
+	if (!pcre2_global_context)
+		pcre2_global_context = pcre2_general_context_create(
+					pcre2_malloc, pcre2_free, NULL);
+#endif
+
 #ifdef USE_LIBPCRE1
 	pcre_malloc = malloc;
 	pcre_free = free;
@@ -186,6 +208,13 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 		color_set(opt->colors[i], def->colors[i]);
 }
 
+void grep_destroy(void)
+{
+#ifdef USE_LIBPCRE2
+	pcre2_general_context_free(pcre2_global_context);
+#endif
+}
+
 static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
 {
 	/*
@@ -505,9 +534,12 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	p->pcre2_compile_context = NULL;
 
+	/* pcre2_global_context is initialized in append_grep_pattern */
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern)) {
-			character_tables = pcre2_maketables(NULL);
+			if (!pcre2_global_context)
+				BUG("pcre2_global_context uninitialized");
+			character_tables = pcre2_maketables(pcre2_global_context);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
 			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
 		}
diff --git a/grep.h b/grep.h
index 1875880f37..526c2db9ef 100644
--- a/grep.h
+++ b/grep.h
@@ -189,6 +189,7 @@ struct grep_opt {
 void init_grep_defaults(struct repository *);
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
+void grep_destroy(void);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
-- 
gitgitgadget

