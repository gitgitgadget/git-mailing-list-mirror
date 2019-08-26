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
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E931F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfHZOos (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:44:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35218 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbfHZOoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:44:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so16160735wmg.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PfX5lXyHVCgPbTeOC6y5fmyNjYXJC+hUD8JhI36FLlA=;
        b=D4bn3UWiczjaV+c/v68DVTugNAXfqRllpQUYyndY1SKHLOJ0A3J3UMHE+ZJgkdmSLr
         ZTIuHR9y2r9MGvbLNPHDnUj9z3yCBrsHS/j3Hdho8YoE1Ve1RmKD3m0UJBfiQSYvUJ5u
         WHbQuIL/zSIdf6Prgn+T0zvH+6ADLoe4OumaN269DbJykUE5+v6juKSEwdz2Ga/fOH2C
         TV6ue8o1lSsF6YftWIoxpgYFV5Upy3OcRDS9XlGqznHQb/jkS4PmjlpgFArOs4fzU7Gt
         iCiCAkNHVLAm+l2ikCA4XjX1nP59BOJNuyV8O/fPgrlCUtazmn8/H0XV1lNVmc0J9yo6
         xYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PfX5lXyHVCgPbTeOC6y5fmyNjYXJC+hUD8JhI36FLlA=;
        b=sigLriynkW6VLs+fps4cru18kUwLrzAJlZL4C4GnEcI67MyJ744gNNOg4HhVRfQFVx
         iqzh/2RQf4DCpcNvR/i+XAjAPuNODgv0cSgyfDR8Y0CRCA8tzJgjvxi2ZtNyQZoyzdR1
         GRa6FUb2rEu1Y3girTE+6nqHi7hWpyNySAmWX0cxuqX1jSFn6hujLl6j1MpI2UI70ASv
         Nn/ASW9DUDgwQGseNskHIUBvzQAN6w/xLli8a9YhBOS51n8TXsZGAEy9dazcK1Sfw4im
         /IDIlX9ZcTkxNtcJ1x7rAsh3aFrVSj7n/JMC0j6xk+CP1Qe2ffZ7+kQiqVHrXS6Ut3IR
         /uwA==
X-Gm-Message-State: APjAAAUaKHEJC4f9oBKTj/nb7Benv6RKzu0Q11p1r0R0mE1dyX5kZV5L
        8ORFjbHFTraDklpGXX7sKlnprJ2N04A=
X-Google-Smtp-Source: APXvYqwkl5x3VPLO0OSlpFhefxXL382EqFoJNFGo4welmRIS/vGbwHEvVkwp82QeHDojl5yDqlxH+Q==
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr13881489wmi.10.1566830684560;
        Mon, 26 Aug 2019 07:44:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm14497311wmj.27.2019.08.26.07.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 07:44:44 -0700 (PDT)
Date:   Mon, 26 Aug 2019 07:44:44 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Aug 2019 14:44:42 GMT
Message-Id: <b9a68598d79724849995283e6967f1c52843c048.1566830682.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.314.v2.git.gitgitgadget@gmail.com>
References: <pull.314.git.gitgitgadget@gmail.com>
        <pull.314.v2.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] quote: handle null and empty strings in
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

The sq_quote_buf_pretty() function does not emit anything when
the incoming string is empty, but the function is to accumulate
command line arguments, properly quoted as necessary, and the
right way to add an argument that is an empty string is to show
it quoted, i.e. ''. We warn the caller with the BUG macro if they
pass in a NULL.

Reported by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 quote.c          | 12 ++++++++++++
 t/t0014-alias.sh |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/quote.c b/quote.c
index 7f2aa6faa4..6d0f8a22a9 100644
--- a/quote.c
+++ b/quote.c
@@ -48,6 +48,18 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
 	static const char ok_punct[] = "+,-./:=@_^";
 	const char *p;
 
+	/* In case of null tokens, warn the user of the BUG in their call. */
+	if (!src) 
+		BUG("BUG can't append a NULL token to the buffer");
+	
+	/* In case of empty tokens, add a '' to ensure they 
+	 * don't get inadvertently dropped. 
+	 */
+	if (!*src) {
+		strbuf_addstr(dst, "''");
+		return;
+	}
+
 	for (p = src; *p; p++) {
 		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
 			sq_quote_buf(dst, src);
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index a070e645d7..9c176c7cbb 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -37,4 +37,12 @@ test_expect_success 'looping aliases - internal execution' '
 #	test_i18ngrep "^fatal: alias loop detected: expansion of" output
 #'
 
+test_expect_success 'run-command parses empty args properly, using sq_quote_buf_pretty' '
+	cat >expect <<-EOF &&
+	fatal: cannot change to '\''alias.foo=frotz foo '\'''\'' bar'\'': No such file or directory
+	EOF
+	test_expect_code 128 git -C "alias.foo=frotz foo '\'''\'' bar" foo 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
