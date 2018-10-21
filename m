Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6691F453
	for <e@80x24.org>; Sun, 21 Oct 2018 15:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJUXnF (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 19:43:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43010 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeJUXnE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 19:43:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id m17-v6so637702qkk.10
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fjMq9WOF6+O6nn+1RIqAPbwNYHZ9vBLfOHi3lMD3GA4=;
        b=AWGpTvNRIujIWQmRf44Jm5Rnf6s97eWjyA+TBjkL84n5nFgS2ejORSOMB4i0IJjgpV
         ta9DWEdbbs/Lprxs2xXUAOSa/PWVXLrAelIrgU4s5Xj1hW79H1mq5vQKnQqG5OHPs6IR
         co8VPQQE3DIrfDaG8TSqqzxIqUV61GzaJULEfRDs7943Sh+zeFM6BGxIq1TxSL4IOXnJ
         bMHargslveSr6D96wa9RP+jssoEOKd+KTSGUc0ISGG9y+NZUcY6vDluinqoeheTERkdp
         Qb+mS06lpFJWTsLbQQGJzrHGUiekYLg4o/Jcwm+DysDVzij/Xx/RxAins+DvuEcUMIsI
         cM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fjMq9WOF6+O6nn+1RIqAPbwNYHZ9vBLfOHi3lMD3GA4=;
        b=jQN2mGo7xqokdVhSx23oGHQWi38nBRfvJGBm7S2va8lMqXN0keg1qld5+nAOPnLrR+
         ZsL6z5ZnzSmEyAvpS20domUE2LD4OcGQGLVF3TlnVqtHCUWi0sl0jax3zorv691ee/Yd
         dS/hoVbkM4U4Hc/ZaXPFyRsPrHDRy8tYZV4ITbhh/T7o46bLc5gSUEqDCH+CIf1w2Qra
         jIGKanO0AL1aztvAU+CPqHctFGU70JePjpWPJ1hW0RobroQzur6soSGxNF3fhpijUBMY
         ybazgZ0qvZnov3jK/rKIjD2jeuIgfioKxuOrskoNrumqC4S5Gb9Maqh2zryPEB7vnzwA
         VPNA==
X-Gm-Message-State: ABuFfohbSD54svVvYjH8YuP1BHWBK6uZhXDBvWkUOJAvO8i8L4GHakq9
        AiT8Wen4/AKXjFJJwGK4uvU=
X-Google-Smtp-Source: ACcGV60CViV68pzkGAfKk4/cPtPkzAqKcWEfY7J4/zkjyJnYIRyC25vgwMVdlPFhb8DLtMz8iEZ1fA==
X-Received: by 2002:a37:4787:: with SMTP id u129-v6mr40888366qka.301.1540135703053;
        Sun, 21 Oct 2018 08:28:23 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b11-v6sm3252920qtb.41.2018.10.21.08.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 08:28:22 -0700 (PDT)
Subject: Re: [PATCH v4 3/7] test-reach: add rev-list tests
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
 <pull.25.v4.git.gitgitgadget@gmail.com>
 <12a3f6d3670834f19b38f5e23ef83cdf80a58c33.1539729393.git.gitgitgadget@gmail.com>
 <865zxvior3.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d0587d1-d204-2507-3ac4-20358ed70ad0@gmail.com>
Date:   Sun, 21 Oct 2018 11:28:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <865zxvior3.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/21/2018 6:21 AM, Jakub Narebski wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The rev-list command is critical to Git's functionality. Ensure it
>> works in the three commit-graph environments constructed in
>> t6600-test-reach.sh. Here are a few important types of rev-list
>> operations:
>>
>> * Basic: git rev-list --topo-order HEAD
>> * Range: git rev-list --topo-order compare..HEAD
>> * Ancestry: git rev-list --topo-order --ancestry-path compare..HEAD
>> * Symmetric Difference: git rev-list --topo-order compare...HEAD
> Could you remind us here which of those operations will be using
> generation numbers after this patch series?

For this series, we are focused only on the --topo-order with a single 
start position. The versions that use a compare branch still use the old 
logic. In the future, I would like to use the new logic for these other 
modes.

>>   
>> +test_expect_success 'rev-list: basic topo-order' '
>> +	git rev-parse \
>> +		commit-6-6 commit-5-6 commit-4-6 commit-3-6 commit-2-6 commit-1-6 \
>> +		commit-6-5 commit-5-5 commit-4-5 commit-3-5 commit-2-5 commit-1-5 \
>> +		commit-6-4 commit-5-4 commit-4-4 commit-3-4 commit-2-4 commit-1-4 \
>> +		commit-6-3 commit-5-3 commit-4-3 commit-3-3 commit-2-3 commit-1-3 \
>> +		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
>> +		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
>> +	>expect &&
>> +	run_three_modes git rev-list --topo-order commit-6-6
>> +'
> I wonder if this test could be make easier to write and less error
> prone, e.g. creating it from ASCII-art graphics.
>
> But it is good enough.

I did lay out the branch names in a grid layout similar to the 
commit-graph layout. It's easier to see the purposeful layout in the 
comparison sections where some commits don't appear in the output.

Thanks,

-Stolee

