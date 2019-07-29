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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4E61F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfG2UIX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36851 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfG2UIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so63284915wrs.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hku9jaOYCPh/VIAjzFkLvA7T0bv0+a/Vv/In5VsUblU=;
        b=m+PGQ7pS6gBX31+xSm6c2iHH5LZuoTCW8nnedPxak25qGW9XoaETcC/Tk8MtGde7KK
         zfI4VtCYuGRyW0hDn5YeF+vgpBHcJPCwE9cO05F+t2hmyPYfd5AP89BcYhc/BTTfJCrx
         JpNi0Hn49HkrXQzS2mwGpy4xQqGUK+T4b3cf3meR1H0b8A9q0a1KyrLEMuKs85b2mlvR
         Z8dE+XCvTD9Jnnpa0zR2I9NxrtBo8vi3b2GZk50t+fdji24wLYlPW63Iu2Q5ki1FXmHD
         JASweWNOR4TUQqlmh99jX/lEsf9GNloiaiV510eoFwy6Xt21Qou1lz7P3A4pY1e88/yM
         Zi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hku9jaOYCPh/VIAjzFkLvA7T0bv0+a/Vv/In5VsUblU=;
        b=EXtrsWbnjMGtdEzt8S+QrY3xSYuuc5amD4FlUspCNtyaAGRZR4NPJZ//PMqm7QN6Mx
         ut66xAduUgXTHA8YDaaaxne4F2ZPcRmkZFalz/IwfX8p0UGo9HPsD0UvEm+O8IuVsAEu
         I/z+WczUvUQFE99ndbmgy5EzfvByeZadTNBXpRqvSRtFX3NVnOPNiCI3dux9ifQzxmn2
         Erd4ENKzlTMEaFaSewmbzKHL+anXjG8/tZQ2wdxMRlwtgEM9LXd3jEt9xPb29Hs5n4mA
         HYZJitv5nFwqiOu0fTtbDph7LPM0/Kcb5sZYh1+91IJw4LTg7AFTPAEp1x2NUMc/7Ov/
         LIpg==
X-Gm-Message-State: APjAAAWqXctojGp6+lbOXvdN8+y1Agj2yDvO952yNVfJbpUVePs0XyBz
        TG/v8WNQ2sOmjrWbwU+HoRLyu0C8
X-Google-Smtp-Source: APXvYqy9cFnOTbCpVCzo5hdXhPfbCr1iVMK2ecsC81Xhz2rEpFj7Lkt4pTXc/GpbkKzl3mgSQ3ATPQ==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr709001wrx.325.1564430895066;
        Mon, 29 Jul 2019 13:08:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm62270413wru.24.2019.07.29.13.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:14 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:14 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:56 GMT
Message-Id: <dc4a9cc6205afac03d1154ca935e4334536fa693.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 20/23] .gitignore: touch up the entries regarding Visual
 Studio
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

Add the Microsoft .manifest pattern, and do not anchor the 'Debug'
and 'Release' entries at the top-level directory, to allow for
multiple projects (one per target).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index e096e0a51c..e7bb15d301 100644
--- a/.gitignore
+++ b/.gitignore
@@ -230,6 +230,7 @@
 *.ipdb
 *.dll
 .vs/
-/Debug/
-/Release/
+*.manifest
+Debug/
+Release/
 *.dSYM
-- 
gitgitgadget

