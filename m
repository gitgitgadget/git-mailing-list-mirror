Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FFB1F428
	for <e@80x24.org>; Fri, 29 Dec 2017 07:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755076AbdL2HRe (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 02:17:34 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35903 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdL2HRd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 02:17:33 -0500
Received: by mail-io0-f194.google.com with SMTP id i143so20327423ioa.3;
        Thu, 28 Dec 2017 23:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FiWuSJsymATG12HIqbC4gD0bkZ6sf4pbdm0YPkjrW7s=;
        b=nyh3+Zm7nsyglVV4LAoSCtxGRXCCALCCBsVcWYE6fDZBi6Ae91WLnnepKFlY94YJfR
         CZjBARX8QILs0CKffwh5rBM1hdV99yAT5shqyeyBcLmCMDmvKkbaGavOGdA9SEg2HgOt
         diCREZguCwtCE2iZt1o8BIRg/slKEPjRkGi5ELuZ4Io9/H+yJtVc1bm+MY1ll2YgWK64
         1gGwae1GO/vMl4/v1Dv8+Utnt4IFchYcvKhiYS/pfaPBJQY49IT5c2XbeV9LfyA8+Pnt
         Rpb+eLvoRPPOAKmF1SWlykC9PD5uPBNkIFQG/9oUZLpeDvCIVYewm8melgPcL1wEtq01
         SFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FiWuSJsymATG12HIqbC4gD0bkZ6sf4pbdm0YPkjrW7s=;
        b=OU7xIta/mpZT3o0ceQLjnnbLfJCXQCUJFMNKxaXf5Pt+9sVQ3/PcnSrbFShBEo24Yg
         O3xMmnT4cn++AmwIVvOHWNaXE2fynKBDezehjM3yvYGELIfXYKyzVN98H3E8rAaawHDI
         /P9e2PwSdWkHNBVVYKHDCui9AjG/uct2RBt25wQj+NO2sViilO/Ut+ManqyyiuekmN8x
         oyx5q7JmrR7wsv2sbyxlV63a6K8HTEhebYJedqwur4AKBMifYoyajpDrgWyojQp81N55
         bnMQZigDf6PQWyS2GS9byWd0QAyDw2YSP0Jgv9HeAxwbb3vRl9+9qvnaQOCD5SCWg82l
         AQmw==
X-Gm-Message-State: AKGB3mLypl90YRxbDCB33b/KAciu9N4M6ZB6qBAcokfYityfE42uF3eP
        dN/jl+0DgS/dNLZEVcVMKGI=
X-Google-Smtp-Source: ACJfBosLM+TDChGxqhSYMPToET060zKNmSsT3CyCJH51EMsocUQVix7MauzJSx5EBfNK6j+EHIE1KA==
X-Received: by 10.107.212.11 with SMTP id l11mr20331666iog.2.1514531852637;
        Thu, 28 Dec 2017 23:17:32 -0800 (PST)
Received: from [192.168.206.100] ([117.246.65.32])
        by smtp.gmail.com with ESMTPSA id p132sm66961ioe.18.2017.12.28.23.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 23:17:31 -0800 (PST)
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <52672e8e-7ffe-a520-5f50-9e7fd15f28c5@gmail.com>
Date:   Fri, 29 Dec 2017 12:47:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 29 December 2017 10:00 AM, Junio C Hamano wrote:
>   * "git branch" and "git checkout -b" are now forbidden from creating
>     a branch whose name is "HEAD".

"git branch" already forbid a branch named "HEAD", didn't it? I thought 
we just made "git checkout -b" to reject "HEAD" as a valid branch name, 
recently.

-- 
Kaartic
