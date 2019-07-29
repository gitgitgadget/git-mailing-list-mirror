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
	by dcvr.yhbt.net (Postfix) with ESMTP id 355FF1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfG2UII (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:08 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46976 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfG2UIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:05 -0400
Received: by mail-wr1-f41.google.com with SMTP id z1so63182698wru.13
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bSwfkqEvi1VIklZAWl7sQi5JjPiQoxI4fZFH4WoHeuY=;
        b=u/L5dhwpj5JrClO4fex+132E1lExSyhwh08gQ9Vb50z/7RGI1R1prdU5LG3KVcINGS
         mOpnunP0uvUvJXEOZ+5mn9RWajNRsgY+MY7zRUtxRqk2zBwLs3PlhUJTKoF2oza0p43A
         +Oy+5PR6omw9xkgbiFaAEcT2Vwpy9uhxNDnf/vSx139IM18XnYgzhROsGZc7lZ0wmyo4
         ecztkFmS+KNMUzeeZuNEaIQMlUVDsXxbel9dDMi6L/45P/hpNu1zUZ6r2uaRoSoYfbXU
         k5YN+LL4bA7X/aYUcLtiUPpqGEz5nOcQNIZcKQs6HCI+Wf03YjYGX2Q75GMdYGwoiRCo
         /dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bSwfkqEvi1VIklZAWl7sQi5JjPiQoxI4fZFH4WoHeuY=;
        b=YzB5eq/fehelkhRr2ZDiqHTaQkdqOCQnby3OCqpGJZ2IgxjMC5w9KU5mQvQuotX14w
         FLdNsy2EXrM6vh5hk/VxZqn/IZ+23fSIdzaZEubMyWHbFIRAmfE0zLpa9vE1AERpPXVU
         cc3ASYpi774Pc5pvJuI3PnU4msm0vtwsd3/i2QFH/sgnvqPy1o3S3ZM+Zn38Uu4V3vRw
         g/PzYL6eOVi7BjxN6XgHi/YJ6HfiwPJjPvvnBXLh6REjR/6d7phztJ48OzYJ2btxpnnk
         uL3R3N6vsig96FkpYS1B0IazArR2rjg8Fjovs37scL75RYRzb6qqjfX/IfNmq6cRx/uU
         WxWw==
X-Gm-Message-State: APjAAAVo3Y9WuBqTu9PL9cTArNx/0npPwsagIpmOjrzNU4QLM1HIOKbt
        jgKyUom+7b3Plz55XU5vj8VTfeOf
X-Google-Smtp-Source: APXvYqwUFq5F89IZtjBAW0QmbFL7AOBBgJ+/L+a2f75jZ+qsolj5sMYAU5WbX6Zv3NtBS6wiF8s6Cw==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr27286904wrv.40.1564430882929;
        Mon, 29 Jul 2019 13:08:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm33164274wru.58.2019.07.29.13.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:02 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:02 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:39 GMT
Message-Id: <d42fd0fe2e8433b14b8efe4e788cc55e53c5c06d.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/23] Vcproj.pm: do not configure
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

