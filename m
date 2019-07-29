Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3363E1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfG2UIL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39310 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbfG2UIG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so44215609wmc.4
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tou9s6+lKBEd+336v5AuGx7s+2YDAAuPHyoFqMGnXRQ=;
        b=d9kjRB2z0lacLrPurqVL56LvL/rS7gkUsvRPBk3xeV3usNEHFVb6Frdlbv9ph2DNt4
         a+ZADv4GNuF9MHqtnGzFm+LDCW1rVrqbyuqB6rhiL44ssfekb75a9hv+z2tc9RDYQNv6
         ErulMqmPBh/2RnScWi5nRX+gJEdPsrzus2FQ4diNbSM4B2/4lrfJ6lx7XEkwIWa9wZYD
         cq0Lzlvzq6MQOxeZoHQY8f820WHMX7x7TC/a2psgzfYgsMcjyU9DhppqW/5kPicKFf3U
         LWO2VKdU+5cjN+NljYTKeiN4NKwTZBkJi50R0NOvnNXtbvV4i3WHabzkjU/Sk0k4eyfC
         ntZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tou9s6+lKBEd+336v5AuGx7s+2YDAAuPHyoFqMGnXRQ=;
        b=SgHtbiYlRwiHuYPPbg8nIzF3iM0Fq67WjzjGSTMQfuMf39zGvDQorGcZdqhqLM0y9I
         2+soNJIZh7G40/uexmY1ZNTrATVbYjUnbhHxFZ980xazroLXMY+80h8C+tu7Lgev07M2
         5Zdi6mrdsGPAh03fwMcYryteAysrR0BQWPOMugjRi+N9ti8TBdExg89IfoSiUpIKKz+Y
         4FCjUJIqOf1BXbiflEHohw18MncN7/Gr/CxRDWDfXUn0IOQi/5OA/Yf+7V8mFJeRhLIr
         kaYpaD4lxUVa2kqQSwYJE6nI3B0ppy5xXQ+f/MtCD3tZQGIuiAyDDQnm2xwvNIAVXy+c
         ZuCg==
X-Gm-Message-State: APjAAAUYl/YVTsrsHOsdbZbkxLw/gLM77wCOXi60zB4qyk23DVKmnvzX
        +Ww/rqysw9Kay+j+ecLr8F+Ow1ZX
X-Google-Smtp-Source: APXvYqydEIpJHxDCAON9TbZoowcxkHAFvVn3JVZG3Ap9ZRPrW9Pv53awM5VGbOl6F7EipWAvX+nklw==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr104040407wmg.138.1564430885040;
        Mon, 29 Jul 2019 13:08:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm80614454wrq.83.2019.07.29.13.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:04 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:04 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:42 GMT
Message-Id: <60a45f26948989f928ca439a2860433c0f08f412.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/23] contrib/buildsystems: ignore irrelevant files in
 Generators/
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Generators/ directory can contain spurious files such as editors'
backup files. Even worse, there could be .swp files which are not even
valid Perl scripts.

Let's just ignore anything but .pm files in said directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/Generators.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/Generators.pm b/contrib/buildsystems/Generators.pm
index 408ef714b8..aa4cbaa2ad 100644
--- a/contrib/buildsystems/Generators.pm
+++ b/contrib/buildsystems/Generators.pm
@@ -17,7 +17,7 @@ BEGIN
     $me = dirname($me);
     if (opendir(D,"$me/Generators")) {
         foreach my $gen (readdir(D)) {
-            next if ($gen  =~ /^\.\.?$/);
+            next unless ($gen  =~ /\.pm$/);
             require "${me}/Generators/$gen";
             $gen =~ s,\.pm,,;
             push(@AVAILABLE, $gen);
-- 
gitgitgadget

