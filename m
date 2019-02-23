Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EC720248
	for <e@80x24.org>; Sat, 23 Feb 2019 14:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfBWOt0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 09:49:26 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:40881 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfBWOtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 09:49:25 -0500
Received: by mail-ed1-f52.google.com with SMTP id 10so4151295eds.7
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sSEa/OV0lpnE8IDFvPgSAYBiIenonmUzbVEZ9QVdyNI=;
        b=l/auQIeuCspYTCodoeWFZ2N05MDHGX20BvJ8FtwF2hV7HuhleSH8+gc5ZWCcg6+Hmn
         2xotdV3hJe1COCMEyUZJ9rZHvTapviNmr9W7sBTpoO9xd1P6Qg/0duj1g5nkhgDIBSVK
         o7esO0YA/Jx22tzGdLezlL/HJETXa88JyxJRjXNl7NniShh6m+qMb3n6wlwPEZxtdbpb
         XuVw1joEQBkK2ggXTb6MLwG4EFkG+DBOXhnb7ihu43VxRxfuMJZrFwOppKfvsQPzhb5g
         d+9G5qsiEFKLeZiZtsCt+y3ka0WuSqE6wnTZb4PaWMDIU2Dwhj9c/DiVAia14o2a9ILE
         bNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sSEa/OV0lpnE8IDFvPgSAYBiIenonmUzbVEZ9QVdyNI=;
        b=gYmx5i9qCY8BOE3ZrgcybkK/6PrUahZ5DdDAWo/0YarIPd6i8P4381kJY3XcqP9pbO
         I9IOGy7zsZct0QtJw5E73mHPCETER+amtajzKH6NxcjgZbCO7aWGdmPvvp23jtOPkt8O
         YC3zkYYSASKQZSLGkkeX3mr0buFnzCKtV7vBrykpaASNMuYZR+qpK2yHWZJ8wcec1Frq
         kU+8QJKH71QfhD9v3smnw38SlhiJns9nx4jSBRjtFhNR5DgBanfTt8LF107pgiiVfuUV
         4vAWMlAzv5VMWeJE/Jsz3dY/KXQtu+1dflnt75FEomFi/xt/t8ZMUtvEcG6SvBPJYRRu
         aN5Q==
X-Gm-Message-State: AHQUAubi431XYx/7A4dm9ZHO9msT7i/Vt0ETTOjdJcHhkwWkJe8sRCm9
        6arGi6S8NVN6KmjXbZ8mDj399tN1
X-Google-Smtp-Source: AHgI3Iay+UIl1bl7D7Yml8Vc25WDWuci+AMzXIFGJ4mB3xAEBo89cDPenuINnw+/ZKcU8MprFpGv1Q==
X-Received: by 2002:a17:906:eb95:: with SMTP id mh21mr6725905ejb.220.1550933363622;
        Sat, 23 Feb 2019 06:49:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 57sm1199217eds.14.2019.02.23.06.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 06:49:23 -0800 (PST)
Date:   Sat, 23 Feb 2019 06:49:23 -0800 (PST)
X-Google-Original-Date: Sat, 23 Feb 2019 14:49:21 GMT
Message-Id: <b9997a4a3c7577d745a6084ca007d188ba9ff6c4.1550933361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.128.git.gitgitgadget@gmail.com>
References: <pull.128.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] README: adjust for final Azure Pipeline ID
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

During the six months of development of the Azure Pipelines support, the
patches went through quite a few iterations of changes, and to test
those iterations, a temporary build definition was used.

In the meantime, Azure Pipelines support made it to `master`, and we now
have a regular Azure Pipeline, installed via the common GitHub App
workflow. This new pipeline has a different name (git.git instead of
test-git.git), and a new ID (11 instead of 2).

Let's adjust the badge in our README to reflect that final shape of the
Azure Pipeline.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 764c480c66..88f126184c 100644
--- a/README.md
+++ b/README.md
@@ -1,4 +1,4 @@
-[![Build Status](https://dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)
+[![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)
 
 Git - fast, scalable, distributed revision control system
 =========================================================
-- 
gitgitgadget
