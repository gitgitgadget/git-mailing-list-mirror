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
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F561F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390510AbfGRNTP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39775 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390482AbfGRNTM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so15308858wmc.4
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1/ePF9dc8ys6tF+gVCZz4s2sJE19gkqnhPeIJjYhB9w=;
        b=eFIMgwwrmktgmPztkkrvGw6MUhcqKVpmvHPOavxH4U04BLqyIpSkgFGUEpr+zN3gR3
         yrLdEF7zDSeZUxRCI875lwdWmS+96ngy0jcKT6bZ0O+7BW/MvSBqZ2UAiZ8m6965amGp
         NmDnOvNJAlIkKbIW5IY3o8zOCExRsCRh7K6hvfza1TXQLxtLouSOGjVF+/AO1DsxP/TO
         9h/A1AtiqRQS7qsi2+4gYOmNeYz+94lU8HwVhBJEL+vcdQvvluriD4OMwnQbK98Rcz23
         Q2o3eWo/9kBKr3I3L30UQ5RHyttJb/NUAOnEbFyh3Fc/T7AOdCCuM0pmcAmZJHHSGZgG
         HPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1/ePF9dc8ys6tF+gVCZz4s2sJE19gkqnhPeIJjYhB9w=;
        b=oJ8kgZJBXhRmMD7lotl+AD1xVC9JknhgRVgJ2+fszTxmqu5lNIXIx+ZA6xIjtUnmH6
         AxyfV32+HhwhJPpwsk8TlGfL01TxWrFuhMBG1r+3WLWT7Ai1fqxAV+OgOg2GFeC3M6BC
         wFy4jsiTi2Y9NFfFiF6aW7Fq/UYULlvUnlm+rfSHH9C4d6h61swyE4etgG6ZwATOFrxr
         1bIYKr0EQf70x21E6R+fPeUtC1N9DBghvKeuhVhCbj5MwShNqEywfT8Us+2HwzQB+lMO
         FVGCtJZgUHVKalLRZJo+5G2IR5IZP3/UKAZr0t4gb0j99reeyMbR0JBDMGsZwZrHLkjG
         a61w==
X-Gm-Message-State: APjAAAVuBR4CVFHx9UKM+w75b4gAOIormtFFpOieJv/N28frGPzFvbqa
        sfHGg9Kn5G7unhubFuM81fLByd54
X-Google-Smtp-Source: APXvYqydgZ9AR6JH6KvVAjLlcnOAPfidCuPcryEhZ6C1Ut0KRHiSOyXSMpYKukeqk2SdCqt4AhJXGQ==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr41392867wmb.66.1563455951124;
        Thu, 18 Jul 2019 06:19:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm23564564wml.41.2019.07.18.06.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:10 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:10 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:50 GMT
Message-Id: <5c9702ea50fa2eac880e5a3d02b4e6734593d445.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 15/24] contrib/buildsystems: also handle -lexpat
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

