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
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C581F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfHXWIC (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:08:02 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:56143 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfHXWIB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:08:01 -0400
Received: by mail-wm1-f42.google.com with SMTP id f72so12011599wmf.5
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=c+b2FmDF2nrqHbTQKRDVM6qULLv+LQCzvwSeLDsrPGA=;
        b=iAPYqGDUIV24bvv/sR1R8VemtKNK1850+h0k5zlLxIfxQcyLFQvLmIprPiopz8Bpwv
         /V/EyMg1KDfBw4St3Zl+fEj+aYtNwTyRHpqOxDmxj3FYZPoDYFPDo+FixFAxMcYCxReq
         MDhIL2kbk6/W+ZbwyRj1CdYWbvWNlHYv0jSHpKHjsKaVMWPFjDE6CV8D7qCo7ZZwGFhd
         e9/eho6vGq6z3JkPT/2VB/TlThbAk92reOGLSfQhHkhXjnLNh6PL/NdADuxGu36PNOr+
         urvNcFCzlsjU9Qk/JD5ZX9/xRamkWNIzBmwlwBP3aIR6jlEwo4r4r8JOvoNomShFy71c
         tTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=c+b2FmDF2nrqHbTQKRDVM6qULLv+LQCzvwSeLDsrPGA=;
        b=A9LGPFHT1UYDBKlzHlpHhFLQUdWFqaKwhzkf1HFDMn6zpMisfU7I/Lrmx6zrVZo2V9
         Kt1qaZyXf1PXU7AcOoMTSdE/nR70Ht44F82esqOyueMuhH/S6yFlDvlaiBO9jaYL51iU
         U8PIaXvr4+Sse0pmu0ZvMdJReSiBzRDytzif42P/ek1mDQ6Pf8tmHWvouuoMzYe5CJ3r
         ZD44wCwVa/9Nj8GldiluT0+UOqERF0lZkvvrPbZu8ritjmw02wrXJPio6bwBlsYSAQc3
         NGK8Aljtd7fmeLjGBNox5GEvL0CTCU8BbYnLQ/D3xwvKbcGuJxLaMAx1zP6f0FmT/pSK
         Haww==
X-Gm-Message-State: APjAAAU2ROA7oNzvlHr1lEUPAPLNpHGn9MNBMc6M9/t2mdatu6g6sWs8
        o/44hUmYrf5SjoxuvkcgyZ7XQDFH
X-Google-Smtp-Source: APXvYqyules9SCJquYL+er2qGLGhmock8GsRM2K5UVMEMh9nEOLJ/zx6Be+lHnjs1X4Z+9mN+a1niw==
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr10925201wmh.122.1566684479902;
        Sat, 24 Aug 2019 15:07:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t19sm6748640wmi.29.2019.08.24.15.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:07:59 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:07:59 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:07:58 GMT
Message-Id: <37957d08acfc053f2a13953f424b0a6b26b3c895.1566684478.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.93.git.gitgitgadget@gmail.com>
References: <pull.93.git.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Torsten=20B=C3=B6gershausen?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: support UNC in git clone file://server/share/repo
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>

Extend the parser to accept file://server/share/repo in the way that
Windows users expect it to be parsed who are used to referring to file
shares by UNC paths of the form \\server\share\folder.

[jes: tightened check to avoid handling file://C:/some/path as a UNC
path.]

This closes https://github.com/git-for-windows/git/issues/1264.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 connect.c             |  4 ++++
 t/t5500-fetch-pack.sh | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 24281b6082..d72772a36d 100644
--- a/connect.c
+++ b/connect.c
@@ -918,6 +918,10 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 
 	if (protocol == PROTO_LOCAL)
 		path = end;
+	else if (protocol == PROTO_FILE && *host != '/' &&
+		 !has_dos_drive_prefix(host) &&
+		 offset_1st_component(host - 2) > 1)
+		path = host - 2; /* include the leading "//" */
 	else if (protocol == PROTO_FILE && has_dos_drive_prefix(end))
 		path = end; /* "file://$(pwd)" may be "file://C:/projects/repo" */
 	else
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 086f2c40f6..f021db44b1 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -698,13 +698,22 @@ do
 	# file with scheme
 	for p in file
 	do
-		test_expect_success "fetch-pack --diag-url $p://$h/$r" '
+		test_expect_success !MINGW "fetch-pack --diag-url $p://$h/$r" '
 			check_prot_path $p://$h/$r $p "/$r"
 		'
+		test_expect_success MINGW "fetch-pack --diag-url $p://$h/$r" '
+			check_prot_path $p://$h/$r $p "//$h/$r"
+		'
+		test_expect_success MINGW "fetch-pack --diag-url $p:///$r" '
+			check_prot_path $p:///$r $p "/$r"
+		'
 		# No "/~" -> "~" conversion for file
-		test_expect_success "fetch-pack --diag-url $p://$h/~$r" '
+		test_expect_success !MINGW "fetch-pack --diag-url $p://$h/~$r" '
 			check_prot_path $p://$h/~$r $p "/~$r"
 		'
+		test_expect_success MINGW "fetch-pack --diag-url $p://$h/~$r" '
+			check_prot_path $p://$h/~$r $p "//$h/~$r"
+		'
 	done
 	# file without scheme
 	for h in nohost nohost:12 [::1] [::1]:23 [ [:aa
-- 
gitgitgadget
