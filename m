Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D680A1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 19:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfJGTjA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 15:39:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38846 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfJGTi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 15:38:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so16707089wro.5
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VocqdbL6h0UnuapOO3+DykIQ2umjgdGekUgwhVxJ8y4=;
        b=MjQBuKJPmBhEvq7DvGEduurnevwZXGlOngJbi42EBqF28zQM6uz+vaeMMGrq2Ygait
         3zy1UvjRSvd9Zqo8dwo5cDOHVODtzLc0TRRnTXijLTDi6VPrJXR7oQAefMcPL3ysrXZL
         2daXiew7aHZn2cJoICaROWZub2ZjeLbv5LeYANMALdpLqJzq8C1hsPh9jH3oVVrqRZV6
         82J0CrAXcC9upjhMtJXnZ+AJ91uqG+CBxL7Nu5K1/TzU4VcJiOabZxpGr+HbJmdaR8J8
         zdJJJ/drWZ9R5i+9GWF2gSCHoIbwudBK9C8pEtp6bDmLrTR8WxrZapwGYnW6Ip6kuw4m
         pJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VocqdbL6h0UnuapOO3+DykIQ2umjgdGekUgwhVxJ8y4=;
        b=p6799AxPFXjKGZC3UBD6/WUtM7H09yu1M1nqjUyYMRdF3o3/rX/b/8GiEBCtbOxV6v
         62lauzkvUvFJ+dg0/w17X8FuBDV4vcnXxZzc+30OqL8FMt7VUV43//5NuW02Zk7t3D1M
         fuq9tN+p4gmUFT/Lj4hzvdlK67MSlOBv4qCkAQdY1LKbySxDPiJqEjJsBQLVXgHuV0+s
         LfrOSpuH3lLa/YS0irGsLB+QXTn5Uf0WPO4AdAQx8DfHAdBxReYXmekAIujqBSbDsYg7
         xMqFuPEJi47JvvWA0xJ7q2ImeQxhWV9UZ1+DQbsc8VZYhSXGcRP+4SenkI6XBeNkSScu
         aipA==
X-Gm-Message-State: APjAAAVd0Rm/8+xpXzGCkAHyshPE2LzYISn8zont98XeGJwyIuFrx+dx
        BDfwJAeA1pXu9AVSQ2t2lOuIWZfe
X-Google-Smtp-Source: APXvYqw9eRdU0xok8SAA0GFYuLKTz2QJfIgqOABPir8vcETQl6i4ZKkmKUbWZR/M8VZjEriNCiKUOA==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr6400624wrp.172.1570477137310;
        Mon, 07 Oct 2019 12:38:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26sm382196wmf.20.2019.10.07.12.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:38:56 -0700 (PDT)
Date:   Mon, 07 Oct 2019 12:38:56 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 19:38:54 GMT
Message-Id: <a6a0217ce6fa2a7436724d76fc50fd6f8b925de5.1570477135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.314.v4.git.gitgitgadget@gmail.com>
References: <pull.314.v3.git.gitgitgadget@gmail.com>
        <pull.314.v4.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/1] sq_quote_buf_pretty: don't drop empty arguments
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

Empty arguments passed on the command line can be a represented by
a '', however sq_quote_buf_pretty was incorrectly dropping these
arguments altogether. Fix this problem by ensuring that such
arguments are emitted as '' instead.

Reported by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 quote.c          | 9 +++++++++
 t/t0014-alias.sh | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/quote.c b/quote.c
index 7f2aa6faa4..26f1848dde 100644
--- a/quote.c
+++ b/quote.c
@@ -48,6 +48,15 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
 	static const char ok_punct[] = "+,-./:=@_^";
 	const char *p;
 
+	if (!src) 
+		BUG("Cannot append a NULL token to the buffer");
+	
+	/* Avoid losing a zero-length string by adding '' */ 
+	if (!*src) {
+		strbuf_addstr(dst, "''");
+		return;
+	}
+
 	for (p = src; *p; p++) {
 		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
 			sq_quote_buf(dst, src);
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index a070e645d7..2694c81afd 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -37,4 +37,11 @@ test_expect_success 'looping aliases - internal execution' '
 #	test_i18ngrep "^fatal: alias loop detected: expansion of" output
 #'
 
+test_expect_success 'run-command formats empty args properly' '
+    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
+    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
+    echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
+    test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
