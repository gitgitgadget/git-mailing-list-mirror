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
	by dcvr.yhbt.net (Postfix) with ESMTP id 998711F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 16:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfJHQkm (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 12:40:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44146 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJHQkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 12:40:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so20152223wrl.11
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YjBKXlMSMXKeZqzPAZoo4htRB+X8Y9izVnUPbnjZHg4=;
        b=QlNiaqxJQEk/gGySeruHIxTDCgHPIUO5/c8V9zCljVpS3aynICqCvRvYrVIYzI5UKJ
         +Yn2e/cpNro5o9YdmX1IAvTsedK2nRdsGSwCD9zvMVWesCWLWzfJqNrJCZXzQx99uz2d
         +Vx5600VqtGKWGSlTPOzo4N8aCC35bzrUs6hN8jcdiwAMsFD4aXzA/cx8WimEDTkVhHm
         lLFiYxCtaPVvY2TpfqOfsei71vmPZ56kwU5DpiqdWulrP8/p+qr9y0JutDgFBq10sz/s
         sZBX9SJ3wRbZjkWJbipbaVg9zcEWyjFXjutQ41xxFqlQIwnVIOs+FJcXXZ4ee6Zk7gXI
         GYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YjBKXlMSMXKeZqzPAZoo4htRB+X8Y9izVnUPbnjZHg4=;
        b=cdtfU4vIZKpn6o2BGje8Fc2XoaudEvyOz7Z1+N/R5pkzIDGnNx8o0+ZDfi9E20/3uo
         93l+EUpXvkvLYg7eTmi3dNhs5qTa7MhpYgb2fMM+bl0vshDsGGtS6ELJfVhigZVxtg0G
         9Cje94WjDuTxpcPV+veCitFgjfNBzKJ84C7oC255qu6W5XcmlWRn0MDFcH4DIgD8Pw+K
         SLi1ipO5T8KH3X1y5R0JiosVlfLwGwgkjO8QeZcbXnr2yEmu0zzA+3rqIfZodTLKOvzf
         xMZ+6kN+bflrn4mV4Dd5dh6bEptn4YzVJmavsTt1ufayZOZAfHY6zolBaVTDEVHbBLCh
         tvaA==
X-Gm-Message-State: APjAAAU/z1lgnnsVxULjRlKmFT6MSP0Ah8Ufvz27NrP1TN2TYW5gs3/m
        CFt3/dIysn94D6j3WLnHbDFDZt/k
X-Google-Smtp-Source: APXvYqwoKcczQQDqyaHJjSKg/YPVFTLtr9GwLj57+w+yQXeAnTFEk+Q0hjBLrT/XQYFyrPE4/jQ+lQ==
X-Received: by 2002:a5d:440d:: with SMTP id z13mr10409018wrq.176.1570552840569;
        Tue, 08 Oct 2019 09:40:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 90sm26828442wrr.1.2019.10.08.09.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:40:40 -0700 (PDT)
Date:   Tue, 08 Oct 2019 09:40:40 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 16:40:38 GMT
Message-Id: <412626ccf98e687b26e26d935a2fc23154a9f465.1570552838.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.314.v5.git.gitgitgadget@gmail.com>
References: <pull.314.v4.git.gitgitgadget@gmail.com>
        <pull.314.v5.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 1/1] sq_quote_buf_pretty: don't drop empty arguments
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
 quote.c          | 6 ++++++
 t/t0014-alias.sh | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/quote.c b/quote.c
index 7f2aa6faa4..2d5d1c4360 100644
--- a/quote.c
+++ b/quote.c
@@ -48,6 +48,12 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
 	static const char ok_punct[] = "+,-./:=@_^";
 	const char *p;
 
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
