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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE4B1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390591AbfGRNTe (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:34 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:34942 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390487AbfGRNTN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:13 -0400
Received: by mail-wm1-f50.google.com with SMTP id l2so25677670wmg.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D4hbnnz1wl16W68xXYb3sjuP3z16WnFfPUUKFYLJTlU=;
        b=gyaKNea/PoHWNXCd5oajLXwC6GnmxfiH76UEzLYNf6Qr36vDG01/RUQXqkVAP77nRi
         vMddAVBeWOmeq/kOLbGr6+AXWmwk7NdZLjCp/SUyLVgsaEVJfU4H2QNuFjb+CJbskowM
         OpeTcxzA8K2QtNRxkjf/hwWkbteK81NB7kDmRu/2b7L0Tws4pfSjcpBkcWWX02vYyzxz
         x6Ik0hCMFXrO5ilGLTcQluoSmv79JC1GzLmgQc05auiHEI/D6MtOko/XO7hkDjODspC/
         7MKoVVUTKzsw/cdKcFpEbx4YBddVrowW1/3kROJbgDIAa9r91FQ2iaJwQk9ploFLXAkP
         Pgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D4hbnnz1wl16W68xXYb3sjuP3z16WnFfPUUKFYLJTlU=;
        b=gVw/nUMo9I5yYt15QXrvQaT/EJgxNa3CHR4y+IkTD5bR8i2TYXOEA7d0Kyc04XznMn
         vzJs473J2S+QEpcImYSC139SNHLR1qfUKaiOthgtJ1TZ2jj6eA0FhU7tuufhPGQuXy8B
         Nrh31HC8f70UW0f0sBXYXOEyUgm8XO/4fKcsHeldqyc7OQgjFVGHk85WFQVXmKJXWmlt
         bNZD5k/9pV2Fcc6Gw51EbrpFlnCKBHyen3+y6+IBggtwk2vLHQqt2HIeh6jTWCpAgaFp
         xzQnsa0UnTesqvc6Y6iuY766IbAuiFOeDv/pXLZ1aiNfcDbzHiGkpensAY34bYH2gOnW
         cU9w==
X-Gm-Message-State: APjAAAXm3cjYpG/iAmAMieANh6S2/RVR8TqxxR8gQYManyCY8kiE2fZK
        nPgE8w71o93UelV5iUyzwKYydA1y
X-Google-Smtp-Source: APXvYqyvMj/eogJyhB4RJ0HhnUlZq2+hJc9hvxOuTV0yhOgimGlUcX9x8Tf5ocAgtQCKhMpeRyJiPQ==
X-Received: by 2002:a05:600c:24a:: with SMTP id 10mr43522296wmj.7.1563455951742;
        Thu, 18 Jul 2019 06:19:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm21575843wrp.12.2019.07.18.06.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:11 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:11 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:51 GMT
Message-Id: <1d4c5539ef5e9c1e83e0ce6d641c535dabf5d242.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 16/24] contrib/buildsystems: handle options starting with a
 slash
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

With the recent changes to allow building with MSVC=1, we now pass the
/OPT:REF option to the compiler. This confuses the parser that wants to
turn the output of a dry run into project definitions for QMake and Visual
Studio:

	Unhandled link option @ line 213: /OPT:REF at [...]

Let's just extend the code that passes through options that start with a
dash, so that it passes through options that start with a slash, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 9bde7ae15b..8bb07e8e25 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -351,7 +351,7 @@ sub handleLinkLine
             push(@libs, "expat.lib");
         } elsif ("$part" eq "-liconv") {
             push(@libs, "libiconv.lib");
-        } elsif ($part =~ /^-/) {
+        } elsif ($part =~ /^[-\/]/) {
             push(@lflags, $part);
         } elsif ($part =~ /\.(a|lib)$/) {
             $part =~ s/\.a$/.lib/;
-- 
gitgitgadget

