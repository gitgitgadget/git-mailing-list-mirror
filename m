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
	by dcvr.yhbt.net (Postfix) with ESMTP id 543D51F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 16:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfJGQRn (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 12:17:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfJGQRn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 12:17:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so126583wmi.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eNUisPD4Ij/T9dLeoIK4bNCaZCHx6hrAdbrHEbtiKy8=;
        b=QRfl3PDOTygxcvHerVLTawbFFDC2lrI8NaFM24lgwORmZjkRQ9m2XG+JKuNj4xRfhX
         kkP8oaVDHS0FSt5horJzKwplrWFld7PXmNin5CkkQhAZpmaGzzJgbqJzKtUZ8HLjpdXk
         6muaUF8MPEiXiQ8VJvMV1duaUuE18BQrQv8kDL9PSepZVvhD76pRrRaHQU6vPSAR+e78
         +xWPePjFyjOSAVyOly5IZngZyYvaROsYRNRSdbIXePqz6rcMdx+rb3quDRCmMlMtsVe8
         R+fDTgXQqYjtKDTvPImHj9bMeJziMrhmtiKKWK/QpDPvlDWnGGQtF+Y0XLla67er2IDT
         ZFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eNUisPD4Ij/T9dLeoIK4bNCaZCHx6hrAdbrHEbtiKy8=;
        b=Xnmqu15LiIDNYaKNNjs30RAyqJQmaH5fja3CHvo8g9xDvEDD/WZ4gIC3ZH/aXWmlnd
         UbjVkllkOUrpih7J7ZHCIckkHNEjfJgBikBMMNr+6LkBR9xZ9H6uBIy2LVjkAycwLFXi
         wDZrDpdJuskO/ctbLA7AvzlG3oGRKOGO7/4iYjGaOvgVA1ltU3oODHuyLDkOArmQkGLB
         TGAWZRO/x+yCO1x1oteOv3aEXQUosdN4NlYDbcvNDDQNwgMv7ILq8vAF1r9R1+WZYxgc
         mTHpuKoXoepGGQ9Z+6g7phdVHF0STJ+qwUlGVh+ghc00dfh5zWbON4P3hYqseXag0qCp
         55Yw==
X-Gm-Message-State: APjAAAUxsD2aTdvVpKpOtXy09a8/3RIiNhyNgaAYwHQcIDM7kXn/ecBO
        n1S5JSvAlCpkQt9jdREmX/N1McLW
X-Google-Smtp-Source: APXvYqws3jAW2fuTjbzW/dQq92eb2GisawUz7+/ehiFTi2YYrHpzybNBNJgK5EZMLDtqmA/qPst/3Q==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr96262wmk.52.1570465061650;
        Mon, 07 Oct 2019 09:17:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm15923078wrt.59.2019.10.07.09.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 09:17:41 -0700 (PDT)
Date:   Mon, 07 Oct 2019 09:17:41 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 16:17:38 GMT
Message-Id: <399fe02cb155770fc2d937607014677874075458.1570465059.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.314.v3.git.gitgitgadget@gmail.com>
References: <pull.314.v2.git.gitgitgadget@gmail.com>
        <pull.314.v3.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/1] quote: handle numm and empty strings in
 sq_quote_buf_pretty
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

The sq_quote_buf_pretty() function does not emit anything
when the incoming string is empty, but the function is to
accumulate command line arguments, properly quoted as
necessary, and the right way to add an argument that is an
empty string is to show it quoted, i.e. ''. We warn the caller
with the BUG macro is they pass in a NULL.

Reported by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 quote.c          | 10 ++++++++++
 t/t0014-alias.sh |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/quote.c b/quote.c
index 7f2aa6faa4..f31ebf6c43 100644
--- a/quote.c
+++ b/quote.c
@@ -48,6 +48,16 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
 	static const char ok_punct[] = "+,-./:=@_^";
 	const char *p;
 
+	/* In case of null tokens, warn the user of the BUG in their call. */
+	if (!src) 
+		BUG("Cannot append a NULL token to the buffer");
+	
+	/* Avoid dropping a zero-length token by adding '' */
+	if (!*src) {
+		strbuf_addstr(dst, "''");
+		return;
+	}
+
 	for (p = src; *p; p++) {
 		if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
 			sq_quote_buf(dst, src);
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index a070e645d7..ae316aa6fd 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -37,4 +37,11 @@ test_expect_success 'looping aliases - internal execution' '
 #	test_i18ngrep "^fatal: alias loop detected: expansion of" output
 #'
 
+test_expect_success 'run-command parses empty args properly, using sq_quote_buf_pretty' '
+    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
+    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
+    echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
+    test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
