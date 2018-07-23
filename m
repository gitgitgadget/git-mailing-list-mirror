Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200151F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbeGWOyV (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:21 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:46257 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387956AbeGWOyU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:20 -0400
Received: by mail-pl0-f47.google.com with SMTP id t17-v6so253938ply.13
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TcpzX51ayKRPlRIaSggbOWah8Pe7Yv/jaZRZECg7kxk=;
        b=SegttT6EHwgt6OU5X/iBEVc03ieXRvEm3VKxph71PLxoIEkx4Wh/Eu9U8qgOYZeTaE
         DXnFkEaV19j/A6n3ieW5VQCvVTTU/QFlQTixFPzdDpnU9b7Mr9EBXFuZ9XHc4WGbZzOM
         dtPxd/OYO5ik9eet3hf8fUvwBzJ83EWF92zRgPcWp9yEN6V29QJC+utPnd4XLBVBawwM
         knw25DjaiJWbZpKznamHEtwNIUdmPFzMd21O3kCIfqZ+brrB4uK47bs8mwQH0b5xH5ax
         bvk3q9SGa5B9+8RQrK6cVXkTlQlQEe4PlmDZXYnYM996yzxITFvw5skrjHAhxCRIDfZQ
         qqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TcpzX51ayKRPlRIaSggbOWah8Pe7Yv/jaZRZECg7kxk=;
        b=G0PBkcglTAuYwPflpbnXZTKxLbu4OwxF4gXTAIducJlgTCiMidS6y2PuLp1pD6X4pO
         igpalplgF/JFjtyhuqsS8ukqU8AH+sV6/L+mM916tx0E4mnBv8auUA4uUSoQsE0BCdhY
         9Nen/j4gh/YlruH0zfTiIxVgLN5FVzyx41Xxgbmb6tzJWHRGlUDGR0pyI+iFXCrcjYe/
         7HINh3rVIwGYV9F3Bgx4URq8U5gSe5BSGcgNMmaRppA/NjgE1M2QNrRJNK51ipEOGEsI
         Hhr7uY1mXAnJmlA/f+Int/aiZOxiw+6ZowotXGLTE+eLVrXb8IqOgcDAD0TpjprnQ8o/
         /dJA==
X-Gm-Message-State: AOUpUlGrjy2+z1huOjSu9kYkwZrjZzEVQ4mox3uNqpGMA1lDwonEnPDE
        ARnN68E7aX8f4IbG2Cw88USUs6ID
X-Google-Smtp-Source: AAOMgpehijf6zg/qMCgMwcjHGz45kCxjLxJAOP4iTo9Aq1zyLZZNhpi+gOiM73hn4FunXdmzSG2g5A==
X-Received: by 2002:a17:902:6b4c:: with SMTP id g12-v6mr12876672plt.159.1532353978167;
        Mon, 23 Jul 2018 06:52:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id y63-v6sm19773890pgd.94.2018.07.23.06.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:52:57 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:52:57 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:43 GMT
Message-Id: <2e880b6f1c6d37d0f94598db408511e0e216a51f.1532353966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 7/9] vscode: use 8-space tabs, no trailing ws, etc for Git's
 source code
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

