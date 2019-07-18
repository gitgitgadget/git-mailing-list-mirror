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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5364E1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbfGRNTR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36351 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390469AbfGRNTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so21559613wme.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s8x/aF7+M7okFuPWVldB+ez6mGXAol2RuujBgyVBXLU=;
        b=t6LErc1o3BaitAkrEBAitXv/E5EMbe6nk7ZWR6q/nnE602NTTDP9aFY4aNwEVLfpUK
         EH++9SzwNhXl4asP3J6k5TUiouUrC4mJjlLSMo7l1AEYjcURtHzPCUZ0x2bhU3TrPcew
         nAAkasUgmIIvqASM81dCQ+4QJTAQ78fyV7x1CqweRjwAdE/PMm8WndfPdg/dz3mDa+23
         xVYCqs3n+FONcKdL65PkBs2lhukRWAFpCr072I5lAKhWSkeOdpyOtSt/4IcZiebiqide
         x9LIzXcjsKsT3VYCw2NPu4hzQ/um7YypVrEu3zwEn1A/9lnAx7zWPlW3O86tk27KgrcN
         8wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s8x/aF7+M7okFuPWVldB+ez6mGXAol2RuujBgyVBXLU=;
        b=DNnUyLDhH0et/XCi8eATAvcYmSMMP9wFBAO3d/2+Qflypci0ohbwSApDhtugpWVS9C
         7lSN93sj5tCgcLo0Y/q7Rb5Z6Gc/bp3U99Dlp1040CTI+oC2ze+aO7VlvkGx31Pm+Sf2
         K8Fw4gOWBPjy0YmHinhoAhdku/m7Ym8DgKR1wW8ngtDUFaYubPsKXUEqf/r5XXgN8M8E
         nRhTV8Pmse0ffv+4uDSrSoCIdpyl77+93fKWHhdTiGT6UP2gqVgt+zgvz9GZlDhXevj9
         jAb+9hZa76ZNTK7+QrY1218hBHmDPsfOT2Gdc396wFD0+Tg4pfB3wk4Tr+6rofPLyR8a
         DBWw==
X-Gm-Message-State: APjAAAUrt+HY8JC93GbO5698McusL9RrzENr9XFV4h2HWh6qRYMkW2Tu
        mRSr2tGwk8wx4Ayxr0IcVIPUo3LU
X-Google-Smtp-Source: APXvYqz6mVwzSvvOylKQ5tBUDkQq07MmSQuzfNwFjMPnHht0OIqapCzHyWkmNHM+BG5ObfPt+BStsw==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr44007732wme.81.1563455949871;
        Thu, 18 Jul 2019 06:19:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm20981529wro.89.2019.07.18.06.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:09 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:09 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:48 GMT
Message-Id: <b07e83440d10da5116ed8507efdef87c02eba32e.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 13/24] contrib/buildsystems: handle the curl library option
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

Upon seeing the '-lcurl' option, point to the libcurl.lib.

While there, fix the elsif indentation.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 1a12f4d556..d613277595 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -341,10 +341,12 @@ sub handleLinkLine
             $appout = shift @parts;
         } elsif ("$part" eq "-lz") {
             push(@libs, "zlib.lib");
-	} elsif ("$part" eq "-lcrypto") {
+        } elsif ("$part" eq "-lcrypto") {
             push(@libs, "libeay32.lib");
         } elsif ("$part" eq "-lssl") {
             push(@libs, "ssleay32.lib");
+        } elsif ("$part" eq "-lcurl") {
+            push(@libs, "libcurl.lib");
         } elsif ($part =~ /^-/) {
             push(@lflags, $part);
         } elsif ($part =~ /\.(a|lib)$/) {
-- 
gitgitgadget

