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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB491F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfG2UIh (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54795 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbfG2UII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so54948081wme.4
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XPn/tHCgwc2NQ5JCW3FcsauVSFsTJYzJ8/MQzYnX054=;
        b=KCf02VTUiRQdKJs4pgusfmmqc+GNILxHGgE0KjU1C3E/v1uwyZjz5uWeKzOwLt4iIm
         vuVlcGZWKcveKufcE7qUo7eY9RlnuvOnamSS3i45kNzLaPwp8TeAZWPVILozR9oDQPfP
         yWyaXY+tyUVEXQcCRaSAL0skOyRXPF4uZc1FI/jCmC3rH5UdqosxPUzNGr8CgNS02Oz4
         HCTkM70KK7z9H8XyCb5PnP900jjfXnjP0LKExDNRNOIYvAUS5yDXCTRkcocB16cgG/Wv
         XN3UMMLL0UI2KoZkXFzeoC4BjFySno6JImqufBXLQrlzpOCiLQpz+wTnXDKeVbnfVlUh
         UpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XPn/tHCgwc2NQ5JCW3FcsauVSFsTJYzJ8/MQzYnX054=;
        b=KETuo7KLboWtaNz2jRQzVM5ub++Trj4nHgmbMfUO0vbGcSmIYjfV/2U10oaimsXgv+
         HkZlAPx62W6f2TsMwU4NwqPpYdpIn6eEwl0sZUxOt0qrioBWGlXSRAhpi08YLUigZOlW
         udUy3FzcQF68V9lx9Y0A3P/xXn14z2IPlO91Uk40om1T3lsrYIjcoCLnC9mG1ZEncX5G
         oir4elUPhPb35fpBNGt0FlNH4B7ZTSZRXPyE6WDG+PfiFSzl4WhyQ1+3ox1WPN3VyjVr
         0y1jCbO+PSzhm+VKoOi34nYVeW95aiEQXeFZEcRQhNNhVjDS0K1H8IhyOcVhnVftd5MF
         Bgxg==
X-Gm-Message-State: APjAAAV6zz5/YLx7p5Ax7vezYKnIEImstoBUXIpz9ugpkHo7p1q/BYEI
        Mo3J84GpVLG8UIz+pCzrQKUtxzaL
X-Google-Smtp-Source: APXvYqwjxGK6giYDAF80V7vrsvgQMBtLgInaI4bwQshMKT0WGT1M48zeM26cr82Ck128DzqstBf//Q==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr19831699wme.167.1564430887039;
        Mon, 29 Jul 2019 13:08:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f70sm80789013wme.22.2019.07.29.13.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:06 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:06 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:45 GMT
Message-Id: <e908d01f076e5954d4c2af4fb3e297c5762aaf48.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/23] contrib/buildsystems: ignore gettext stuff
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

Git's build contains steps to handle internationalization. This caused
hiccups in the parser used to generate QMake/Visual Studio project files.

As those steps are irrelevant in this context, let's just ignore them.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index ad6a82c30c..9db3d43a1e 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -141,6 +141,12 @@ sub parseMakeOutput
             next;
         }
 
+        if ($text =~ /^(mkdir|msgfmt) /) {
+            # options to the Portable Object translations
+            # the line "mkdir ... && msgfmt ..." contains no linker options
+            next;
+        }
+
         if($text =~ / -c /) {
             # compilation
             handleCompileLine($text, $line);
-- 
gitgitgadget

