Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4291F461
	for <e@80x24.org>; Thu,  5 Sep 2019 11:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbfIELQf (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 07:16:35 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52152 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732604AbfIELQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 07:16:35 -0400
Received: by mail-wm1-f46.google.com with SMTP id k1so2330975wmi.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9Cwh8ZyzKx3dn6NKb3HkAHIIaMjbvZ+Hqkb0D158XiE=;
        b=WZUTSedyxZs5hQNy2iQTDoxq4CL4nLh15T/wUP7y9qQn0WSD3qmGP67UPGvEZqtnXp
         vLxrVfakOsOQzfHiPcpHav41dtaMX+y2E1UlhZsS68yolutm07I+HeFlLeaK8icI1ApX
         Ot8SBgrjLGPYcaRukf+VXnAniwftt1aHCHnl5mjvkByHgo+ZtfvJLX5vUusizJvH7yA+
         wzozpX9rk2DaedzhVlUvqpaRU3QbGXp3DT1DAut1+akDrW0Lg8S18/JnTQoVsu0Q/nub
         QXE/QTEQy9I4Fas1e/+VKg247mUaoZwWPG3fCNzPGVsyvHqP6u66GVhvJOUeT+zp9aFE
         ASOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9Cwh8ZyzKx3dn6NKb3HkAHIIaMjbvZ+Hqkb0D158XiE=;
        b=pREldtYUn5NVX+P+x4eKMzqgURRm6RMLZRb2uPtlG4rjMzZBnjbTZubXWyo8qu3Zt0
         iUcP0GJ4/f9s09A5CfCTDjqz7hu4ZkCNFdtG08xO1Vzxk4a0pLUIfkBBvKQqkbLp+t3L
         tLLT+aXVh3dOjmVeFxJiF2hVLuCLBsoAjw0uXJKUMlC0vmWFVbL8DM9EglYdtPdhkci/
         DymKWEcOpJEULOuaayvMP2Vy2WC878lTBsk34Pq6l/NccsTpOKZ/C8r2XhNh0nniCr5x
         y5S7iU/LHfD4jAAdH16/d93KIDDnHdCDVg7vdOIDZ+pzgXrtwV4H2GcOKE7HT5eJNFuU
         RNFQ==
X-Gm-Message-State: APjAAAWJXRQDwIOLXcjh1/3dpVOoeRxE2rrnWqMotrwRuuMCzIKd4qWE
        XNpgPsoO5BWu7r+R8AQkxddiUy1y
X-Google-Smtp-Source: APXvYqywgHTZfxta7Nf6LaoYvgWZoFautwqC1erFw+99TE9NuMsb18tv5L6PD5W4lQwd15IfQjH+Kw==
X-Received: by 2002:a1c:ef18:: with SMTP id n24mr2486227wmh.29.1567682193484;
        Thu, 05 Sep 2019 04:16:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t203sm2900631wmf.42.2019.09.05.04.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 04:16:33 -0700 (PDT)
Date:   Thu, 05 Sep 2019 04:16:33 -0700 (PDT)
X-Google-Original-Date: Thu, 05 Sep 2019 11:16:31 GMT
Message-Id: <05b341661b7e14868af0eaa9179816b28c40b8bf.1567682191.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.332.git.gitgitgadget@gmail.com>
References: <pull.332.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] .gitignore: stop ignoring `.manifest` files
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

On Windows, it is possible to embed additional metadata into an
executable by linking in a "manifest", i.e. an XML document that
describes capabilities and requirements (such as minimum or maximum
Windows version). These XML documents are expected to be stored in
`.manifest` files.

At least _some_ Visual Studio versions auto-generate `.manifest` files
when none is specified explicitly, therefore we used to ask Git to
ignore them.

However, we do have a beautiful `.manifest` file now:
`compat/win32/git.manifest`, so neither does Visual Studio auto-generate
a manifest for us, nor do we want Git to ignore the `.manifest` files
anymore.

Further reading on auto-generated `.manifest` files:
https://docs.microsoft.com/en-us/cpp/build/manifest-generation-in-visual-studio

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 521d8f4fb4..fc445edea9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -231,7 +231,6 @@
 *.ipdb
 *.dll
 .vs/
-*.manifest
 Debug/
 Release/
 /UpgradeLog*.htm
-- 
gitgitgadget
