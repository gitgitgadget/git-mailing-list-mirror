Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34EA61F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937014AbeFRXnL (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:43:11 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32920 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935955AbeFRXnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:43:09 -0400
Received: by mail-oi0-f66.google.com with SMTP id c6-v6so16493354oiy.0
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L99esiMuIiPR6h6VgmsM1+TBb6V3XjjsHil0o+hLoO8=;
        b=EdSNtm7kgcHVwI/81gyZjj6B9PdV99JqDNuZ/xACz1uDiJ0NSaJ6b2HpNXt64w4SDw
         F10tj9jOI1Bil0VyHj2dznsoJD01Y2mHWR4u33JM6peZ8byDcox+1xbr2K8lpy8kAL9p
         2Kz+u9OIz5oMhBUz6mM8xsgQwgLvuHR12Nwm3tIichY9/pztBzuW00Ab7VgDGxhgHTZk
         4B6btaJBr0bLHdPeamIaVi38eHydD6kCLFD+G7us/HyyewgKC6BifK+rvHkgQfgmfTNt
         QZFgdLApDR9hZk+uzEfLKcoE4809JdsPNCbVch3htAtNwXT2hkQA3ZPz3lDcUHg9GnLM
         31ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L99esiMuIiPR6h6VgmsM1+TBb6V3XjjsHil0o+hLoO8=;
        b=TdIfYV8mA8COBCcfvieecQLACGprhnJX7mb+QLt6xq5m0NGdjeYbD2aWPhjPWTihMM
         lCtcDzy894crl8dqXpZ2FkE++7zvHgZqx3Wu4SjtY3qv9PZqlpgVD1aARrveCiGE1doB
         xlaooh285mGL0+jI+vzKEjh48ZU4yHOEBIs+Tr67ABHTpxdahpVaHH8Bjc3e4+EXebMC
         iBmF0S+pAAiYw6H2Ggrr/9JY/lpDkWoNVK0gMljnDa2wF3X/mDqMI9n4WpT64H1R8Uz/
         iSj3lf9VS/jruhM9hcEvLLV8hlmqyf5uZ9Xm3LXWjLZAkkIQdILw3mfEcVyJcVfTu2u4
         Vj7A==
X-Gm-Message-State: APt69E2Wnkzt9BWA7QWIVz6kGMpjNbxUSsJfGZiMliTl8qrWagiOuVh3
        Hwn62TZLr7Q1jiGXDbFI/Cp1rW+0DQE=
X-Google-Smtp-Source: ADUXVKKnI9qcr5soxT5tPBaCGYN3JatDwTjuOP1IbvCVe1UdAGdCVlhRkJaDi3+b9tkWXmS5qPAWSQ==
X-Received: by 2002:aca:3c4:: with SMTP id 187-v6mr7515096oid.88.1529365387906;
        Mon, 18 Jun 2018 16:43:07 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id 3-v6sm6625026oin.12.2018.06.18.16.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:43:06 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:43:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 1/7] Documentation/config.txt: camel-case lineNumber for
 consistency
Message-ID: <0e2a7e38aa7f23a784e3dc81296f73803b9ec329.1529365072.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lineNumber has casing that is inconsistent with surrounding options,
like color.grep.matchContext, and color.grep.matchSelected. Re-case this
documentation in order to be consistent with the text around it, and to
ensure that new entries are consistent, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..58fde4daea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1181,7 +1181,7 @@ color.grep.<slot>::
 	filename prefix (when not using `-h`)
 `function`;;
 	function name lines (when using `-p`)
-`linenumber`;;
+`lineNumber`;;
 	line number prefix (when using `-n`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
-- 
2.17.0.582.gccdcbd54c

