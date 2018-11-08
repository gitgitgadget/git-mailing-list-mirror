Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E841F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeKHO2l (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:28:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33799 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbeKHO2k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 09:28:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id y18-v6so6358953pfn.1
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 20:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LNZMhKlfrAQX+xT84qOrzO8agUCG35LSD7aXqa1Azg4=;
        b=DvG4u1yttnP9MOv/Hqvp+pgFvmRFSCfPC6n8XCPr5fHpzUwteJ8/dhpzvnzRGBFZ+h
         UJa65/YMbr/PWTgXDmj18QCPm39zr7Z2nYPAT0LtoRMKk83X6tTJ87MUdXJkP6K3sbnD
         EicA0MXxKmXxmqurQ9yBU7OFSVLPCuFs525Xbn64EZzfHxHKfYAFBlOuC09QiEQ/UeQV
         yLnCCR6q2UkJARNFnwGsuHs5x9aw/WgWma+cv+X62Sjj9ZVbUr691wEDSSDwqhvasNuT
         pKsWvAOUhbF+46KrE1pUqLz5uPiCJc3NCSIy1T5hJf+qtfVFZgYeMaz883TBOTWy3++Y
         oGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LNZMhKlfrAQX+xT84qOrzO8agUCG35LSD7aXqa1Azg4=;
        b=IkywgXQ/k9787r9cgKElKmphaakLse18vLQUuH9GDAXl/s5d9c6Wan2+RhWG6y9hTE
         r8SVtYGF+GqV+nqzucXZUjk0Iiamu7FtpMj2jqvTx2TxJzbWow5jKBcctgH2uyj7lKbp
         6TPFd9fYYN9zs0r6UOdT0A1Qd37Unlq7+k7q9x6OuI49teEAipUHAIS2bS7X92vDJb/1
         J0i4zgdrwpdEfkL03//4EI1I2bZ4/hnAyUEm96Fq7e+yZaPw1tIlUtZzia/+DeOWGnJx
         csASt4fU7+xnusrMry8akXATDmTwbp9sj0ffEyfF7/rb3+3mLa+/IdP2e8ubPs0LdzYq
         fTrA==
X-Gm-Message-State: AGRZ1gKWbiHDj94nAm92hvPfyvptuXQhdC5xLmUUcOYZhhy0NN6GgCob
        fm9u1qfSPRQ16UiSr67Wwh2wQ99d
X-Google-Smtp-Source: AJdET5eDOzdKgfIC6Nkjzqi8DdaXWUzosjUx3pnQap6IDnG+cr/TOuHZill7Ds1Tqrg52KuIioXFAA==
X-Received: by 2002:a62:114c:: with SMTP id z73-v6mr3092606pfi.192.1541652902346;
        Wed, 07 Nov 2018 20:55:02 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id v4-v6sm2570292pff.9.2018.11.07.20.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 20:55:01 -0800 (PST)
Date:   Wed, 07 Nov 2018 20:55:01 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 04:54:54 GMT
Message-Id: <eee67d835653a3902e7f788e4dfb1c6ba8132b8b.1541652896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v3.git.gitgitgadget@gmail.com>
References: <pull.69.v2.git.gitgitgadget@gmail.com>
        <pull.69.v3.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/4] fix curl version to support CURL_HTTP_VERSION_2TLS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Force Charlie <charlieio@outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Force Charlie <charlieio@outlook.com>

Signed-off-by: Force Charlie <charlieio@outlook.com>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index b2ec31aef5..86e454cff5 100644
--- a/http.c
+++ b/http.c
@@ -811,10 +811,10 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x074700
+#if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
     // curl_http_version 0 is default.
     if (curl_http_version == 20) {
-		/* Enable HTTP2 when request TLS*/
+		/* Enable HTTP2*/
 		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2TLS);
     } else if (curl_http_version == 11) {
 		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_1_1);
-- 
gitgitgadget

