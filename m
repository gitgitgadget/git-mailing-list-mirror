Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6EA1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 01:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeKHLII (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 06:08:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41288 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeKHLIH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 06:08:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so2535407pgh.8
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 17:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LNZMhKlfrAQX+xT84qOrzO8agUCG35LSD7aXqa1Azg4=;
        b=d1O4yJlHpOaN7f7ZFqV0Ov4lbLTriiDvessq9R0fy08RYRinelCltTIA4U4r9xRnY8
         F09RONwe+3GJJNw5+j/klUTHwhE91nx8AvRVkg6QN88bE8rdP4jRXWJcAPt1mIb68D/9
         3zQaNHhGOp9qxazoQfVoSQiy1SiUfbvPNZLBX93Y/K44Errg7oYbakR0BdXBYGTez2VG
         GhlEwRiOeh4eDA6VeLRY6dHDBH1THYOqhuxW3HgyswScKfCwOeRtO1sc5AK56RRPlLgX
         vmHXe2pm3HWcdA1kGNeDWQwy4l5w0nZNLo2Lfo6pYICs3tKhMiAH81Z28rGVX7cW7OJk
         I36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LNZMhKlfrAQX+xT84qOrzO8agUCG35LSD7aXqa1Azg4=;
        b=jaqxgSG9KMdW5FtQyUynLT0HJxVwi6zhjBmvs7rtolGHBK+og/p06XaDdTk6TzC7Ku
         2DPyxuoa0483/e0AUEKq7wLptw2E6PVhEk59yQZaySqJz+uswrhdnsikiwqPVL8G3HhQ
         yXP8Hx93MaPQ/6xt6JR/+q6+G9gsEcr8IOsm5DYmVdfIZChPVtSFzcXHmNhXX9AQxTU8
         4AaD/pPRyal4Qo5z6+acuqJjtELBLGQgw2c/kYftxx4Cgk4v9Sd4sNBD9LRtgsdx4Oe+
         Qwm24f8NLa6l4Td6r8gN61KViUWxDLmXNp3CTDN//a1TBj/YEswT3ikWYuFaB5RqQNsT
         AV+A==
X-Gm-Message-State: AGRZ1gI+XyGeTunK9Wnk6O2hib6gp+hzl6b1RPqAgR77drlxZGDiBPdM
        G3pahoOK8T2SChX5c1kgZ09y3vYA
X-Google-Smtp-Source: AJdET5daRnltorg4X4E2C6J9ygv6qH889+dBV7OABNnnnqEy1uwr4v0phCbWEueCnPEZWzKgcDyXXQ==
X-Received: by 2002:a62:6981:: with SMTP id e123-v6mr2639854pfc.104.1541640906537;
        Wed, 07 Nov 2018 17:35:06 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id q11-v6sm1752011pgp.62.2018.11.07.17.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 17:35:05 -0800 (PST)
Date:   Wed, 07 Nov 2018 17:35:05 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 01:35:00 GMT
Message-Id: <eee67d835653a3902e7f788e4dfb1c6ba8132b8b.1541640900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v2.git.gitgitgadget@gmail.com>
References: <pull.69.git.gitgitgadget@gmail.com>
        <pull.69.v2.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] fix curl version to support CURL_HTTP_VERSION_2TLS
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
