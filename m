Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06BB81F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfHTTfG (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:35:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54918 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbfHTTfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:35:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so3622058wme.4
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S/k6EGCWTfwmFXjxApWj7S6r4k8X2Q30EWbmDWrsRp0=;
        b=M2EDfhAAUM9h/bi8F1fzAKj1U81zG3OF3UEewAPDxwSOidFUGANOI1/bcALYDIiNmr
         diHXoB/0EWzPBlNKTwMCg/dWVVFal49aylI9iaxamNnISvUG9J/eW62dSElrBa56/Q07
         2QStptjDD8B/p8C/vilatfzMTGQf6Ub0Pmy/UFatg+bDAMJaNurQcqctDDlaDmXrl+bf
         iv4MTcyX7IPIUC2PRRQ/sNjj1qp28ORBBvD0/sj78OtsfH5t/Of4rBPgBW4kyCa8j+Iq
         bc1pP9QsuOS5tBn7nFdAikYl5hwRzo/NRA1bHdZMzdS+6Zff1WWHhy1JYiH8maNlsXws
         RRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S/k6EGCWTfwmFXjxApWj7S6r4k8X2Q30EWbmDWrsRp0=;
        b=s5kpXlwUtNwFVTKD7tlBB6NV4RMaCg0dLTqnj6Mz3v7wnQF5kzK/whoHcPQwreeDng
         pQioq31zYSums0+9hGRWDzktCNgvyp0jYvWgWEVug5NefYgUSPge99plxur5ftV7EiwE
         R2E1nGJfXKSYaSxLSK6LC9NcRb2HPFJkPe/dJRz8yP+sRMfvo2FX/PpdxOdgspTYPJZa
         QLqoDAG2Kb0M70luVrAL5dAyeOufvraMOxpdNz/4YzEptLO5ckFxcjYyGPA9xkfIe7rl
         AOJQSpNjsGdH6lf2Il9YiLPsHTb6X20VhJDybex59iIAlWNy5l49hNNzyGt9NVKl22eg
         qWOA==
X-Gm-Message-State: APjAAAUTbMwLMHNGGtpC7FpPop4Q21aZXaMusVbx7hMUVnSKmpNCtwoI
        Zb3fpVfppDSI7MZfEZL1CIV4mecJ
X-Google-Smtp-Source: APXvYqzqNreGWARcXKDG1Ag+zxxL0mim1CJvk4EIyvnq9YZu6qi2nrSpijA7DIm8BbcJsQ+zS3lb1A==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr1780038wmj.86.1566329702193;
        Tue, 20 Aug 2019 12:35:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm18013631wrn.70.2019.08.20.12.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 12:35:01 -0700 (PDT)
Date:   Tue, 20 Aug 2019 12:35:01 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 19:35:00 GMT
Message-Id: <9d2685bdb2e193986bec8cad88795963977d41fe.1566329700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.314.git.gitgitgadget@gmail.com>
References: <pull.314.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] quote: handle null and empty strings in
 sq_quote_buf_pretty()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     garimasigit@gmail.com, jeffhost@microsoft.com, stolee@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

In [1], Junio described a potential bug in sq_quote_buf_pretty() when the arg
is a zero length string. It should emit quote-quote rather than nothing.
This commit teaches sq_quote_buf_pretty to emit '' for null and empty strings.

[1] https://public-inbox.org/git/pull.298.git.gitgitgadget@gmail.com/T/#m9e33936067ec2066f675aa63133a2486efd415fd

Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 Makefile              |  1 +
 quote.c               |  9 +++++++
 t/helper/test-quote.c | 28 +++++++++++++++++++++
 t/helper/test-tool.c  |  1 +
 t/helper/test-tool.h  |  1 +
 t/t0091-quote.sh      | 58 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+)
 create mode 100644 t/helper/test-quote.c
 create mode 100755 t/t0091-quote.sh

diff --git a/Makefile b/Makefile
index f9255344ae..2d6a12db57 100644
--- a/Makefile
+++ b/Makefile
@@ -728,6 +728,7 @@ TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
+TEST_BUILTINS_OBJS += test-quote.o
 TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-midx.o
diff --git a/quote.c b/quote.c
index 7f2aa6faa4..84f61380fc 100644
--- a/quote.c
+++ b/quote.c
@@ -48,6 +48,15 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
 	static const char ok_punct[] = "+,-./:=@_^";
 	const char *p;
 
+	/*
+	 * In case of null or empty tokens, add a '' to ensure we 
+	 * don't inadvertently drop those tokens
+	 */
+	if (!src || !*src) {
+		strbuf_addstr(dst, "''");
+		return;
+	}
+
 	for (p = src; *p; p++) {
 		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
 			sq_quote_buf(dst, src);
diff --git a/t/helper/test-quote.c b/t/helper/test-quote.c
new file mode 100644
index 0000000000..0266cc4fec
--- /dev/null
+++ b/t/helper/test-quote.c
@@ -0,0 +1,28 @@
+#include "test-tool.h"
+#include "quote.h"
+#include "strbuf.h"
+#include "string.h"
+
+int cmd__quote_buf_pretty(int argc, const char **argv)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	if (!argv[1]) {
+		strbuf_release(&buf_payload);
+		die("missing input string");
+	}
+
+	if (!strcmp(argv[1], "nullString"))
+		sq_quote_buf_pretty(&buf_payload, NULL);
+
+	else if (!*argv[1])
+		sq_quote_buf_pretty(&buf_payload, "");
+
+	else
+		sq_quote_buf_pretty(&buf_payload, argv[1]);
+	
+	/* Wrap the results in [] to make the test script more readable */
+	printf("[%s]\n", buf_payload.buf);
+	strbuf_release(&buf_payload);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index ce7e89028c..55ee1402dd 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -56,6 +56,7 @@ static struct test_cmd cmds[] = {
 	{ "sha1-array", cmd__sha1_array },
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
+	{ "quote-buf-pretty", cmd__quote_buf_pretty },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
 	{ "submodule-config", cmd__submodule_config },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f805bb39ae..8c0affe89c 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -46,6 +46,7 @@ int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
+int cmd__quote_buf_pretty(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
diff --git a/t/t0091-quote.sh b/t/t0091-quote.sh
new file mode 100755
index 0000000000..a5515973c7
--- /dev/null
+++ b/t/t0091-quote.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='Testing the sq_quote_buf_pretty method in quote.c'
+. ./test-lib.sh
+
+test_expect_success 'test method without input string' '
+	test_must_fail test-tool quote-buf-pretty
+'
+
+test_expect_success 'test null string' '
+	cat >expect <<-EOF &&
+	'[\'\']'
+	EOF
+	test-tool quote-buf-pretty nullString >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'test empty string' '
+	cat >expect <<-EOF &&
+	'[\'\']'
+	EOF
+	test-tool quote-buf-pretty "" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'string without any punctuation' '
+	cat >expect <<-EOF &&
+	[testString]
+	EOF
+	test-tool quote-buf-pretty testString >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'string with punctuation that do not require special quotes' '
+	cat >expect <<-EOF &&
+	[test+String]
+	EOF
+	test-tool quote-buf-pretty test+String >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'string with punctuation that requires special quotes' '
+	cat >expect <<-EOF &&
+	'[\'test~String\']'
+	EOF
+	test-tool quote-buf-pretty test~String >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'string with punctuation that requires special quotes' '
+	cat >expect <<-EOF &&
+	'[\'test\'\\!\'String\']'
+	EOF
+	test-tool quote-buf-pretty test!String >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget
