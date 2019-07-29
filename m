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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEA61F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfG2UIT (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37824 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbfG2UIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so38119407wrr.4
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1/ePF9dc8ys6tF+gVCZz4s2sJE19gkqnhPeIJjYhB9w=;
        b=DRVS0xsHszxthR0lnQJKHG7q36Q/q45IVfDWrw4MlLbKcQM8nYIRs1SujYUonvFiUn
         /Chyx/gQeLd7dEpYzXXPThRTf2H75xZuuUnYBLRNVcLShCoCS6rMlADxqmbbx8HW/FJo
         nO3XFk+bP52dOZD+8IwG8QNe/A/qrpCJ3h5fmq2wOT5DapVvro518IHi6AHkTOyW+vf4
         DChO/KZci1kRFMhD3QlYaO7kELxjhtv8Zj8JYa2amXe9yiz0i1xJjCbJ6wiiiPJ6bq7g
         7whU368aGZGaz3nb7W04OyOaVfPro2HwhM7IyANSR8ihUgUSUIWFiJxMb1OI9s8lzKNF
         rqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1/ePF9dc8ys6tF+gVCZz4s2sJE19gkqnhPeIJjYhB9w=;
        b=ZMNxaIrRuZYAoDhdiOhxAm7Q6+6uc2HHU/Oytagxs6UqRazXs2YGosqtLq3T4a1DXi
         pa527UOzgajZixSgPCJtl86hI0umim010XmJi2i8UDoGLaYLpgwBjFKd1mFV1vM6pWLp
         L35rfbWxKfX/JZwbDFyXhYDIorfZ/aNl7IS1ypBbaPPbQu5uXBJBEx+3GpIDBpdBBFah
         VX9dR+KZdy+xSAYNIZeBwGnCLr4EgacpsrORYMpjEqIg/RmvH6DdH+n3NuR2sIYgeBI+
         LM+Nw/znw2SgWkJGY7xlS0GzTHUnnvuxFE+5j3LQBA1rsSJT+aitEdX1FnFOIYepwDnD
         jviw==
X-Gm-Message-State: APjAAAV7qUeP4tuu900HFwMotgxFaJjdQt7/S0g8u+VcXYSQ+OTN1BmM
        heirjNAALDg0t92Bh934lGko+jdH
X-Google-Smtp-Source: APXvYqz81jkiq/7Hr4YonGkDC4cf9+tj1fdZJDRLsLUZ0F9Bwdu42LkxlA4lbAzkv8vgi6zhjkOYOQ==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr68568605wrv.63.1564430891261;
        Mon, 29 Jul 2019 13:08:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm50981585wmg.15.2019.07.29.13.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:10 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:10 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:51 GMT
Message-Id: <5c9702ea50fa2eac880e5a3d02b4e6734593d445.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 15/23] contrib/buildsystems: also handle -lexpat
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

This is a dependency required for the non-smart HTTP backend.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index c35844a0c7..9bde7ae15b 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -347,6 +347,8 @@ sub handleLinkLine
             push(@libs, "ssleay32.lib");
         } elsif ("$part" eq "-lcurl") {
             push(@libs, "libcurl.lib");
+        } elsif ("$part" eq "-lexpat") {
+            push(@libs, "expat.lib");
         } elsif ("$part" eq "-liconv") {
             push(@libs, "libiconv.lib");
         } elsif ($part =~ /^-/) {
-- 
gitgitgadget

