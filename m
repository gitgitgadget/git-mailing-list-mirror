Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0791E1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 09:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFZJCj (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 05:02:39 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52827 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 05:02:38 -0400
Received: by mail-wm1-f42.google.com with SMTP id s3so1236431wms.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PdSnOMr8ElbaiOCmeWo9D3OVZSfhTPOOeTdZ8I/rbeI=;
        b=s9ZFr7jL1hLxNHwmnWrESW6OkR3ndHSNdH1tl+TcKfFaGgTLPwns9fqLHBBCHMmCHQ
         p/j5qSuPoe2ztPHBicsgsAKiMnv8F5Pz+j5QNttxmfZiFVF1RVH8recFCCbfQ+jBvc4Z
         qv6Bp5H4TDKKMoRLi+vwJ/rXBRtoddW9wN0ClLUWsNx5wqXSSCn0clxwetRCZcDNE6Qn
         ntuoeMV11JjZKHKsJAoO1P561jn3LrZLLeTzktYfpH4XKEJJVbDSDWmNkO9Lpr9PpivG
         Sld3TyxWjladwifmyl27mn8CNiDW80G8YakbrgWipSVWcdrbOFPkDkLwF/WxAhhE7wpn
         y9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PdSnOMr8ElbaiOCmeWo9D3OVZSfhTPOOeTdZ8I/rbeI=;
        b=JQFYCRU3mCi/Goic3ZN/augdYjeG+8/hRIF+/UIdNXIEQ4r4vnH+f7wSdJbClyqygR
         WrAwQIrqgXFM9J0OWz1ToKg9//oMe4aqvkKP2jKiUKFdkWA0qmZHmrXtuW1giLNIdDeQ
         xePueO0mhvh07Y7BNIfbPpDqHRhVQEWVc1xyAf48oWd1kLyiAFnjbVUw9Fsr9CUd1GKP
         t6X4c9U3FO78BPMRpsDAEvq4I1e4Ig8j2nfgOF7GmdOOr6vMKI/YODBLxuE/Fx5FDcZk
         Q57FApmk0CHajSAo8JkTIDfORpcCxn/eWkStM0EJDWjDydprkaMcMb8kxQl2+EcU8u8X
         xZOw==
X-Gm-Message-State: APjAAAV6Xtnhco/Nxm/iWEdy/vH44rq6uafHN+gZo/OgY243rxpyIj7O
        EnOSh922n4vT/rrAPiKStkDdDZIb
X-Google-Smtp-Source: APXvYqwRnyuqFrCj9vnsF788uMM5erDZoEzYK1skbiHjLkoSjWJSrSN7CxKFLZBwCLwEq4oKPTjwNg==
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr578719wmm.83.1561539756698;
        Wed, 26 Jun 2019 02:02:36 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id x8sm1131344wmc.5.2019.06.26.02.02.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 02:02:36 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jun 2019, #05; Wed, 19)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0fa8f3ce-b1e4-7501-6a65-8628d8a46989@gmail.com>
Date:   Wed, 26 Jun 2019 10:02:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 20/06/2019 05:35, Junio C Hamano wrote:
> * pw/doc-synopsis-markup-opmode-options (2019-06-17) 1 commit
>   - show --continue/skip etc. consistently in synopsis
> 
>   Docfix.
> 
>   Will merge to 'next' and then to 'master'.

Thanks for fixing up the commit message an this one

Best Wishes

Phillip
