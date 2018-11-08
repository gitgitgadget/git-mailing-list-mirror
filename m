Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA461F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeKHPr7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 10:47:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42348 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbeKHPr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 10:47:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so8399939pgq.9
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LNZMhKlfrAQX+xT84qOrzO8agUCG35LSD7aXqa1Azg4=;
        b=BmbgUvp3aQIsruHTVpUzJ3jlNiBL3Y/ltCH8u/WeGPEzXlApMfBkkAZ/1LihG8hXKU
         IVi8RKWE2ac/JAxvXsBI7nl6iN5YNOk+HCgtqXBWopJUgsW3uSR6WLzJ7eTKRdhrUASj
         4MGaD36Mj2tUEJUgC/13DufiMcYX6363L/CSjetrlxnnHHr1saC2aNZ0yjfjiTFklLZa
         txtXs2LbdH6mn7JMdPhruwLIAz3CefemUVo04GcxISSuTGISppRwMwhePmps+0+zjg1g
         ORS05LGXwkPh2IcoNxjFmFAfiP5u/XPtuewKmMNvwVRFTzMw2MVpf85uZ4vDiwL4O+lb
         EiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LNZMhKlfrAQX+xT84qOrzO8agUCG35LSD7aXqa1Azg4=;
        b=IvPQj9ImrFkYI9WVLlQAfOo9ujl9XAaViGmR+RQ91YcYdnxkYwWZkmOtsioPDxpyXc
         TN1jJjl1DxmA2lngRcLXX4wmd3QPRTVbeedpn97hEfsWExOycgJ8T7s6ZX4bJo3OU6Mf
         2c0h2A7g3l6uYo+y1DjwkG/w77HuqWJjAjy/ZHiH2S3dpsILHNeQrC9U2Hpl3turlfif
         6PTA9KBmBATLuJrXhctqUROo26WDdMr+Fc4WKzJGpD0MVC/pUUPIwExEf1fae1EsYM7+
         2OSyy/1Jl8AQr9lBtOC6uYshRW70KWainh3wRt3ZdKpIi8z38Bxc4Z38U9RSjwO2nAEm
         GvTQ==
X-Gm-Message-State: AGRZ1gKKiTBh1tFwztM8OJrkLNo5F+FkdhiVo+NDltV5djerTVh/xQRI
        f4OlN62aEfNQGNghNCOHJadDogZ9
X-Google-Smtp-Source: AJdET5dMRx4pfNe40ye0Y7doP640GwH5jKm7eokZ99z8cmjy9/tv63MBwV2suC86VHZAURJnlZCuPg==
X-Received: by 2002:a63:6848:: with SMTP id d69-v6mr2861741pgc.113.1541657646988;
        Wed, 07 Nov 2018 22:14:06 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d65-v6sm4343798pfm.100.2018.11.07.22.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:14:06 -0800 (PST)
Date:   Wed, 07 Nov 2018 22:14:06 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 06:13:59 GMT
Message-Id: <eee67d835653a3902e7f788e4dfb1c6ba8132b8b.1541657640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v4.git.gitgitgadget@gmail.com>
References: <pull.69.v3.git.gitgitgadget@gmail.com>
        <pull.69.v4.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 3/4] fix curl version to support CURL_HTTP_VERSION_2TLS
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

