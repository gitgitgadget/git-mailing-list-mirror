Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF061F516
	for <e@80x24.org>; Fri, 29 Jun 2018 13:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936019AbeF2Nz5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 09:55:57 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:42174 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935466AbeF2Nzz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 09:55:55 -0400
Received: by mail-qk0-f181.google.com with SMTP id u62-v6so4934808qkf.9
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/7YGwymDYz4/76FODpRWdHgawmcTnMWq5hSGt9n3ikI=;
        b=n7KG5bLXFWuSXfGaJz2ZOGRUcFGsNAKN6s/zbYohQNFKfjzLimIhCGzpccR1js3vnF
         RecdvKajezhPu11PvjmQAN5ZCZaf2mLAjirpmTAvMalIo9TLCobAMj1iGYi+60xn9Gra
         S40D0EVMYsYrAlcfnRwOIAl03aTz9yRN+dugRxtdTgwQMHRDCuc7ckDw2pno+i4ZlxQI
         n65NxdHXGRiB2mL7dN8YfK5gwU29X1hYjNGw0DFyTLtj+eSnkA2AOskLI4SKIkFJ1uWw
         WsVrvD6uMYCtXPxfML68xf7mbG6B+jxnHiD840zt4gXiE3Z/xyl7ExvXcMk+TTe+VO5A
         o2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/7YGwymDYz4/76FODpRWdHgawmcTnMWq5hSGt9n3ikI=;
        b=ZJLDoFooskGqAMJDodWIMwylafUHkVRY9lYoVw26EGVV+lVWQmRbdPZBhgIKbj/NU9
         6khtWl7Sgi723iDfZnnJQbyr8VSuxizQJwefEBSQn8blV5/hZgXv9JHNGFXlL440+l46
         EGea1bK4zZYgJAxCB1KqKD14exQe6VmH0Jl2Rtz7Mvwa+thLZoFo8e4Z3n6juWXrcU8k
         x3f7cA3dZtFA3HPpMggHtMJ7h9IcuM4+D0d0CDT8jlKqFCMu7cSSQJp0wUu3AOmSGmnh
         whZwhOdeRN9F1pwD/y/tMFLdTOSqhbEwTSwLhhnFX4LJjEEr/T46vZC08Ms0jboqUV87
         IQBQ==
X-Gm-Message-State: APt69E2ypRWK5PkZg77acI1u48pUvEaflaOo1DFvYaEWr+RfysBXH9Dy
        HdlIC+uV41v50zeIrNtqB2DbCz6m
X-Google-Smtp-Source: AAOMgpeUjqs06hCmORdNTAU4RXXSa6Ku4yxm8EAO4jJszVBhuyShAfgPZlitk3ZsDm4VexMv4adL8g==
X-Received: by 2002:a37:7441:: with SMTP id p62-v6mr12982761qkc.262.1530280554529;
        Fri, 29 Jun 2018 06:55:54 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id q15-v6sm686988qtl.39.2018.06.29.06.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 06:55:53 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbKrDu8iW+867c73OMhgqEYA1H3-zQpejxq5jMMNRb2Bg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9e583346-2865-231e-04bf-670a36fe1aa7@gmail.com>
Date:   Fri, 29 Jun 2018 09:55:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbKrDu8iW+867c73OMhgqEYA1H3-zQpejxq5jMMNRb2Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2018 6:42 PM, Stefan Beller wrote:
> On Thu, Jun 28, 2018 at 2:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> * ds/commit-graph-fsck (2018-06-27) 22 commits
> [...]
>>   "git fsck" learns to make sure the optional commit-graph file is in
>>   a sane state.
>>
>>   Is this ready for 'next'?
> I hope so, as I plan to reroll the next object store series based
> on it. I'll also review that.

I think the series is ready. The only new feedback in a while is your 
style comments on "commit-graph: add '--reachable' option", which can 
hopefully be squashed in. I'm also open to sending a new series on top 
for new feedback.

Thanks,

-Stolee


