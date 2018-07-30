Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349F11F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeG3RSa (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40225 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeG3RS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:29 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so5737055plp.7
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TcpzX51ayKRPlRIaSggbOWah8Pe7Yv/jaZRZECg7kxk=;
        b=AIWpTAAWFRkPK6c66kV2+ftfV1XawaXvtczPKteiKr2CuLUc3aJ07+xI61MWUE+3OJ
         YdZEZ3YmTWHG0wcb4BI+zsYz3k+gNd4AG9Ul6TVUu2OFi+Pjn37SuCUcZ2NsfptgitXo
         /5xdoVSLY+7thzRarTM2tmEz3vLYHscFHZFIoYcVVfvPVyNEdwbhuupIVd/vhg3fxhqY
         jFIzJ+6TqE3HcAMdR4idkj4+XNrCy0gd02t3chH9bR6mbZ7jkvGTmvyk5pDN5xKENqn2
         uUtnkBYf5zrbqdLvu/LCA//WDbpFgPN/zC1Mg5T62XZ/XRN1DWK4+S6T2nLoNUAhrKLp
         JfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TcpzX51ayKRPlRIaSggbOWah8Pe7Yv/jaZRZECg7kxk=;
        b=P47ei2M3r9ZD19dsKEPOoso2x7eHgqkX69XjflBAGBGY7yI34anlYK8eTWz5QqbWW1
         qA5wN7fEeCNrJFzt1jOCm1pAVi4FuXhggZa6gS65FH6Yd6i3zCD4bD0rAknOzGj6raUv
         hXloY5w9OM4x0ZF0djmojFr/7xx0WPM5zqd7Hp+vFqTvQbOo2ICTL7N2u17moi3daz5e
         rxqxltVfMYqVCQx89ufcGdJwUyIalo4ve11mG9xHnzKNbVbSF47BW65cNRFsckhTeeJG
         IrDm+PXu6m35SKHoIahGz352tPSZdFho/CPFBIYaJyGGie/gPL16oATf98q+Blf/4pK3
         ii5w==
X-Gm-Message-State: AOUpUlFVKWDITiZwZjsS3AKatvCLRAQbM0T705DRd0CvzIphQcmqheXJ
        xU30m+Y7D6qThwNQRmAPaQ1dhr45
X-Google-Smtp-Source: AAOMgpc/pyvQgh8FBL7GvSpG7ruBigwOBiPAbZkjSXXl2ncLKNU3bI/48QaOCRFjv/UOzSO/hwCNpw==
X-Received: by 2002:a17:902:7147:: with SMTP id u7-v6mr16702460plm.154.1532965376421;
        Mon, 30 Jul 2018 08:42:56 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y85-v6sm18819970pfa.170.2018.07.30.08.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:55 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:55 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:40 GMT
Message-Id: <ba78af756bac56d2c4436a1de924fc72e6887a47.1532965363.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.v2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
        <pull.2.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 7/9] vscode: use 8-space tabs, no trailing ws, etc for
 Git's source code
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

This adds a couple settings for the .c/.h files so that it is easier to
conform to Git's conventions while editing the source code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/vscode/init.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index face115e8..29f2a729d 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -21,6 +21,14 @@ cat >.vscode/settings.json.new <<\EOF ||
         "editor.wordWrap": "wordWrapColumn",
         "editor.wordWrapColumn": 72
     },
+    "[c]": {
+        "editor.detectIndentation": false,
+        "editor.insertSpaces": false,
+        "editor.tabSize": 8,
+        "editor.wordWrap": "wordWrapColumn",
+        "editor.wordWrapColumn": 80,
+        "files.trimTrailingWhitespace": true
+    },
     "files.associations": {
         "*.h": "c",
         "*.c": "c"
-- 
gitgitgadget

