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
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E471F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390436AbfGRNTF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:05 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43538 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGRNTF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:05 -0400
Received: by mail-wr1-f51.google.com with SMTP id p13so28643789wru.10
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bSwfkqEvi1VIklZAWl7sQi5JjPiQoxI4fZFH4WoHeuY=;
        b=HSNAzMPdFFfenLI4ZQSjp92sOxFqss4wo2p1Ad5R0Ah06Qp+jBdt8zOPo79sjo0bUZ
         t4A87kiBFNCap6DA4V4hkUqrFUlKaNCnyQzRHGhkzZsMDTjOUUXb4O4Dt2NoNtqyorHZ
         jVxEDyean8FtIDFeD0KMeX325mLwqH0G+g1kzc8isoYwGOaOdRX+Kqa41ufdSIqoZtWx
         0un42UYvkSKLoCW5BCQT8Dp+UZ4YaHjRpUfIs/KNzmRp6GbS1YB9CgPu7x4G0Yw/rZEu
         F1vY7X51a/eBD1o5ef5awO8jfRfZKPMRzaJ7Du4/xK2jHupI7vzHuPHXjPl74LI/Wzzu
         3mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bSwfkqEvi1VIklZAWl7sQi5JjPiQoxI4fZFH4WoHeuY=;
        b=r0zb1XV6XB+gW4oyZghfabK2LJlR3xhCjPdg+w13amSKgH6IqpKwQv+rEPhqNFVlIh
         z+I+b30LmM+etKnkftUVCsgzMo2Dt02CleAeEGjYxDTTbDgx/f+CAmorYiJtx0/2gGk4
         ijaLb+9ePJTwvaYu5hfeVh5JOgtGVuuI6SUj/eKDlLp81AqhQt2p29DORlQFALdYdvl9
         drLgslrUpq/ER7J53T2ErkwsRKdx+ehNPZxco+nNb3oKrSTuAXZ3/K08OKuCO5X6mcph
         ew9zothMyDkfvKE3aPJOSjioRcFT6NPHT7RT851U3+n5m+JksBhXpW5j6rJboJLxEZeJ
         AQ5A==
X-Gm-Message-State: APjAAAUp1oBzgyvKlgMXj3Fl1CP1VahrT8gYBYK+7Yvw8nJGrdgIqQLJ
        Xsn9c+IOCEiHTMlWxv8Q5fpi58uQ
X-Google-Smtp-Source: APXvYqw1PwMwb1C4kkM9vHryf3qgOZu0TsXKCtYgSMyEQQZQHlBgaPbRFCclZXj6MztkV0AGadpK7Q==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr50579990wrj.118.1563455943205;
        Thu, 18 Jul 2019 06:19:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x129sm24619219wmg.44.2019.07.18.06.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:02 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:02 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:38 GMT
Message-Id: <d42fd0fe2e8433b14b8efe4e788cc55e53c5c06d.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/24] Vcproj.pm: do not configure
 VCWebServiceProxyGeneratorTool
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

It is not necessary, and Visual Studio 2015 no longer supports it, anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/Generators/Vcproj.pm | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
index d862cae503..b17800184c 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -115,9 +115,6 @@ sub createLibProject {
 			<Tool
 				Name="VCXMLDataGeneratorTool"
 			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
 			<Tool
 				Name="VCMIDLTool"
 			/>
@@ -181,9 +178,6 @@ sub createLibProject {
 			<Tool
 				Name="VCXMLDataGeneratorTool"
 			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
 			<Tool
 				Name="VCMIDLTool"
 			/>
@@ -339,9 +333,6 @@ sub createAppProject {
 			<Tool
 				Name="VCXMLDataGeneratorTool"
 			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
 			<Tool
 				Name="VCMIDLTool"
 			/>
@@ -410,9 +401,6 @@ sub createAppProject {
 			<Tool
 				Name="VCXMLDataGeneratorTool"
 			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
 			<Tool
 				Name="VCMIDLTool"
 			/>
-- 
gitgitgadget

