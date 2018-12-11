Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C28B20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 17:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbeLKRYm (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 12:24:42 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:46623 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKRYm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 12:24:42 -0500
Received: by mail-pf1-f171.google.com with SMTP id c73so7422316pfe.13
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 09:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+//9RZGV9mzhZzDnN4k1mnlMnrGLhW2jtnpe2ZWrNsI=;
        b=SAILAYXWKZPxqEOtEz67zPHm2pxUzfprFeCISukStLHkwhazgWYTXhkzyQVWrWorol
         o1IUI9SD3g78ghnbuGpbLGNe3S4K3qR1dQ61GI4jFVNlmWSU986xg/dbxeXrzvdZ9Lnn
         v3EThhetWUR+/clnT+ExdlSx8kwizZOYWWQfYtwTWZVTzE88B6l1Qk4Jt14S/HnPoIvt
         zLUNl2RrJFxpMoIuO2T9vYsxVPKHtf6tukKMABiki3tkavwo0K3JXcDCYivsDh5BgHBg
         CGQohLp49cxei+Rs5uAGD/bU1FX9IWf/UPKOOZDoaNFTxLpfq2fLFRfn3kdrOy4JIbc/
         EIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+//9RZGV9mzhZzDnN4k1mnlMnrGLhW2jtnpe2ZWrNsI=;
        b=sWRcVKX2rADEbZhPpQhtl4ow9lNe/KFjAO3cMbbkeEbcxevsoMralHGF4iHgYLfEz5
         ePJkU8axeSed6cCFAJwxaEPJJuKMBTRhRe3YhAfmHtN9Rcxf7jQ2bjhxMRG2zcpNv9jK
         0gQapPSdlvHgjrM6Wsv64KQYM6nfeP2Xyk5EWpLWz8bcOUU2/qT7O8JXsBD5cRbQZrtI
         szAV43AP8SQqZLShsHIrR/Ezro5MOcTLxVzywIbavtN9WA3cls9orv2UChzbBMNM8aYd
         EA8Cp7Ta9Zr/9gmnqJZlCCjIowZXMlhQBT/rk6w+2ZqSu04mzIkPfZ+8eBM/kW4isuvw
         HfIw==
X-Gm-Message-State: AA+aEWYUb36XEF34OGx7gxXd4rUDpEfY6kSMlkrNw0ecbTfnZrur1U3+
        cuuYtv2P7P7ypj3sWdoxkCZwG0lg
X-Google-Smtp-Source: AFSGD/WzDMLTcOu4F313Zar7xkcmpl6lfij+7A+y1d34WQV/fqgdFfm6rB7ZVMTZq0oIT58EKThZaA==
X-Received: by 2002:a62:5dd1:: with SMTP id n78mr16824834pfj.58.1544549081043;
        Tue, 11 Dec 2018 09:24:41 -0800 (PST)
Received: from [172.25.16.176] ([50.226.67.250])
        by smtp.gmail.com with ESMTPSA id d25sm24057703pfe.40.2018.12.11.09.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 09:24:40 -0800 (PST)
Subject: Re: Announcing Pro Git Second Edition Reedited
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
References: <pujni2$ulb$1@blaine.gmane.org>
 <20181211105007.GD7233@sigill.intra.peff.net>
 <a1941151-9453-5830-7175-7c8e27425274@gmail.com>
 <CACBZZX6g7TaxNHN=3ApV4wV91ZuVV8eoemMurS=WMt4mG8Q67g@mail.gmail.com>
 <55838db9-4f08-b77e-bc95-5c7dce4024d2@gmail.com>
 <20181211171553.4mnd66ngqvcxb6me@tigra>
From:   Jon Forrest <nobozo@gmail.com>
Message-ID: <972839aa-c1de-2ec2-b047-44e5df65bd13@gmail.com>
Date:   Tue, 11 Dec 2018 09:24:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181211171553.4mnd66ngqvcxb6me@tigra>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/11/2018 9:15 AM, Konstantin Khomoutov wrote:

> I think an uspoken issue here is that while you're indeed free to "fork"
> this book and maintain your fork, having two books with almost identical
> contents may not be the best option as it simply may be outright
> confusing for those at whom your fork is actually targeted.

The coverage is almost identical, but the content is different.

> That's just my opinion, or — better — feeling I gathered from the
> discussion, but to me these friendly nudges to maybe consider
> reevaluating your work for inclusion into the original's book proper
> look exactly as hints at that having such a fork may not be the best
> of all options.

You might be right, but the reception I got when working on the
first edition led me to make the fork. In retrospect, I probably
should have tried again with the new crew who did the second
edition. As I said, I will try again if there's a third edition.

> Another problem with the fork is its visibility.
> The go-to Git website links to the original work, and I assure you
> novice users do not casually read this list — let alone search through
> its archives for the mentions of an alternative book's version.

I agree, and I don't know what to do about that.

Jon

