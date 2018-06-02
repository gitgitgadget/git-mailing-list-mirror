Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AE91F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 00:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeFBAmD (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 20:42:03 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:45314 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeFBAmB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 20:42:01 -0400
Received: by mail-qk0-f180.google.com with SMTP id c198-v6so21243088qkg.12
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 17:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dSkFq5CRNl70E7GhkCPH0R1iF/qe33y9pGXsdnV9RqQ=;
        b=TQ2MDVK4iNh/68S8fOiuZy2dJ2ZcLCbWqFYK6ADAnFoli5Y8IYw2pu2sm5J5h8ETMR
         8/r4RUc2M1ykiMF7+zgdNr2tfo8SoVoc4efjYC8+zGkUvdbX32d3zBdv0KVV9Ak/qeDV
         zasNUtd3LQ2qiuUzgewZSVVLEdQuQF4GBQ7bwDCcu/FZGMjl0iOjtNbOC91PrgN0jg/2
         Fjpb+CHD0agUrPT7uUON5UYEEteHDxlZVs4hIBYb9RkTGsjVB9vm/CshZbrNaArBeP4e
         KmyaLgZPqHu/nwbu3oZPLP3kfX8Y4RXFgcJNx0cI16wMYqkvOK49mDlrOLqBGCckVQek
         TE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dSkFq5CRNl70E7GhkCPH0R1iF/qe33y9pGXsdnV9RqQ=;
        b=aIdXhXx8jNXSDjA2JXktALU9hS3NYU/w1a0yeH1R/b6G5+TGKf7fLGuT4JX6he31Ac
         86xRV0Pil9z5cElNKKttvMx63u9dyPgqp3ejgCGBJTltSR2iHh/aNC2gIc+AaS0wD9YQ
         o5BdashmyX0BWW1Ve0eR5vheUwb9ST5wSo50Rj0CLybitP6d/NA3ajFiPkpu5bgafNxn
         HA+xA4cUAbL8w3SqE7P96EDJB4+XyXNzELCtBml9jZSjjkxzyNL2BcECgUimIOkjcytF
         NYLIFVbKS9u6Lru1nlKrn2LvWBJ8LN+cIzx0Y8GKmfh3o4IlXbjT0QDsfQ4ROXw06Kwc
         QGcg==
X-Gm-Message-State: APt69E0ydttwU7Ok4H0imsV8a4nBmanT2NdAyFY+NujEDoEIUx3wh4qm
        5NV/jfssfMFea9U++zixA4983l3L
X-Google-Smtp-Source: ADUXVKKebvYrGGqDAe5WgcYz0b6xp57vyYdIWcq3lS2aRb/LlIXEmr+h5L5zV+Pr6C7vvN589VWTHg==
X-Received: by 2002:a37:1193:: with SMTP id 19-v6mr12581218qkr.379.1527900120680;
        Fri, 01 Jun 2018 17:42:00 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id w15-v6sm31686459qkw.28.2018.06.01.17.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 17:41:59 -0700 (PDT)
Subject: Re: ds/generation-numbers (was Re: What's cooking in git.git (Jun
 2018, #01; Fri, 1))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqa7sf7yzs.fsf@gitster-ct.c.googlers.com>
 <4a7c6695-52cf-46a1-5a21-bf2e03a85f6b@gmail.com>
 <xmqqy3fy6qu8.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1c770f29-9e80-b54d-b9d6-2fc73a5ae62a@gmail.com>
Date:   Fri, 1 Jun 2018 20:41:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3fy6qu8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2018 7:15 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>>>    A recently added "commit-graph" datafile has learned to store
>>>    pre-computed generation numbers to speed up the decisions to stop
>>>    history traversal.
>>>
>>>    Will cook in 'next'.
>> On Wednesday, these were marked as "Will merge to 'master'" What changed?
> Nothing has changed.  "Will merge to 'master'" means "This is now in
> 'next', and unless there is some blocking breakage found, this topic
> will be merged to 'master' eventually".  It does not even say if
> that eventuality is before or after the release the current cycle is
> working towards.
>
> When it comes near pre-release feature freeze, things in 'next' need
> to be sifted into various bins, and their labels are updated.  The
> ones that are too big to be comfortably merged to the upcoming
> release after -rc0 has passed (i.e. biggies are better merged early
> to the 'master' in the cycle to give it full cycle of larger
> exposure) will be kept in 'next' so that it can go first after the
> final, the ones that are low risk but with higher importance will be
> merged to 'master' before the release, the ones that are trivial,
> distracting and lower value (i.e.  the ones that force i18n teams
> extra work) may be held in 'next', and the ones that deserve a
> chance to freshly restart are marked to be kicked back to 'pu'.
> Etc. etc.

Thanks, Junio. This explanation is what I expected. I suppose the small 
extra bit of information of "Will cook in 'next' until after next 
release" would have answered my question in advance. Thanks for the 
patience as I get used to your workflow.

I am a little disappointed this didn't make 2.18 because this gives some 
of the biggest speedups for typically painful computations (like 'git 
branch --contains'). The generation numbers are what give us more than a 
constant-multiple speedup; what is in master only parses commit 
relationships faster, doesn't reduce the number of commits walked. It 
also means we will release a version of Git that writes commit-graph 
file with GENERATION_ZERO and so we will never be able to deprecate that 
logic in the code.

Thanks,

-Stolee


