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
	by dcvr.yhbt.net (Postfix) with ESMTP id A25341F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390517AbfGRNTQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41688 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390470AbfGRNTM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so25469076wrm.8
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kXc66PEqxg+GbFYsh0oZ7XdTgPZq9GqHCXpd+lonCGA=;
        b=f93uDuJnMuWt0b+2s7SxP/zf+V4oSS9UFUEb0eIouvN5+WwqtMgD6IMMWKQpkQztNA
         qFwISXC3+4rP16unfa2SKn6WawD5pgvKvVjO5GXBKT68PNnSm5Md0tPZa+CKggSlb+F4
         2/l46NQOt2ZfJ1QKjCJM3zfXWzD/tjy/SMHToc/2CFqrLNfCT3QXPXD8GdtWRPeJ+n3l
         aCKKtzf8FjYPcscjAUDsOm/gYGEemryKy+JhFRz6DtSmHm5EnZuXODybR2xlSYe4ZVVN
         yGHEkTHOI5drIDFiCiFYysQqz51KiCOj60BFGY9T+aaZBeHLVLT6ISV529vezODaP6Xh
         K7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kXc66PEqxg+GbFYsh0oZ7XdTgPZq9GqHCXpd+lonCGA=;
        b=BDU4z+gjaCGQFj3wlbiW2T9Hr8kqt9Py9x/3D5JiFUbqTjU60WfBz/CudGQJwJZAkl
         rn7v477Ka8Kx3bCY99rh17J/n3A4Eu/2j3qM34s/Zx8eC66zWygIJZHe4srim6CkQlho
         c/rLbMD61uXeOh3w1WZeSHQW4liAPSP6LgqhXW48mApXZZSicfWoMqR8h0eEpq43mfqA
         3+2SZL61/QI8ilbV03xNqE4nHeZ9BsWsMZfmFc5nTuJrMl30aQEw6kT7QwuhbjwE81Um
         rN5oV6M6QoJdDsspL7y63Vf2SZDWi/Af0DCFJzup3/vRK7l4U2/CK7451N96gYt1v1oh
         F1Ow==
X-Gm-Message-State: APjAAAWH6DdG+Xwvog+ST4xYaw1iV3VALj+3UN17fc2bVKLqHn66F7Om
        SQLO1KF8zzLlcO4CXiyJVW4iODtz
X-Google-Smtp-Source: APXvYqzBMP8tu/wEq3Er0Hnp7UfAZ4yd2W1o3/oWSUZx6HxkvfgmELO/zi8Ors2ydCld3DQIwtR7lQ==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr50308047wro.112.1563455950476;
        Thu, 18 Jul 2019 06:19:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm22697134wmi.21.2019.07.18.06.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:10 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:10 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:49 GMT
Message-Id: <052a98b8bb8aef572cba41dbdaf15a7b987b8270.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 14/24] contrib/buildsystems: handle libiconv, too
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

Git's test suite shows tons of breakages unless Git is compiled
*without* NO_ICONV. That means, in turn, that we need to generate
build definitions *with* libiconv, which in turn implies that we
have to handle the -liconv option properly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index d613277595..c35844a0c7 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -347,6 +347,8 @@ sub handleLinkLine
             push(@libs, "ssleay32.lib");
         } elsif ("$part" eq "-lcurl") {
             push(@libs, "libcurl.lib");
+        } elsif ("$part" eq "-liconv") {
+            push(@libs, "libiconv.lib");
         } elsif ($part =~ /^-/) {
             push(@lflags, $part);
         } elsif ($part =~ /\.(a|lib)$/) {
-- 
gitgitgadget

