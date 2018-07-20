Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9AC1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbeGTRRd (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:17:33 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33806 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732826AbeGTRRd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:17:33 -0400
Received: by mail-qk0-f193.google.com with SMTP id b66-v6so6539021qkj.1
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/E2BP69F44/1cplJXXh16p08/8jCrqJbIM6otVYTzns=;
        b=pH6YFzqICWKCU5bHIJWTCZHPp1d0Qleu3u28TLHEve4qr8QCpOeCgiLLvzHxPRa4QM
         bzyAL4Yqz1Hn8jBFnN85O4dW4Mwly5/QUlETYapysbF8pk1QLwYcsfhbUxdS1rEbi14T
         FmvXDae8f9q/rM+SkLFYZWZb2c9y1KNB2kWsoqSfTSlbxoBnxrGSAEO0sEpXqNy727H5
         vkxKoNY2Dv0qL4jMBYhEnhEyTGfBOsmTppRsJxQgJ1gOoWXUzd1YSP4SslvbL+wy4mCR
         dq0MJWeprK0RvFTys2LqIBZ7ZTObMFDu55JmDdQ8hijWdy5joxls4VHk4wFPanAwMQVc
         7/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/E2BP69F44/1cplJXXh16p08/8jCrqJbIM6otVYTzns=;
        b=HZeSmKycEdUJNtQoHDbb8Zv10I5nNyzJPoB9gy4ptqxLVyQdFLle1HxX2NVn+5ZnDr
         c7ZHVzk2VUZCJv3tneQ7drBfDMsVUk2lC/J/szF5JD2moOFLRELMla4mmfnJAm2+lwux
         N/Qa6jmo7DzX29/FYAn3Fjb1QfQnFiktuuLjYZlfm5lNpd6VMfRazOJIBqpwyPPwJk/Q
         zNEPI4tcabCGzAfdvz/7hUOrWwJK8vMURK5pajLH//otI+fb7hb+L6rgcsZSwPsX36HA
         dlpRSCqcH9GVjI7n4qUU9p1+kavLC0DQivXX03Gnu6iXblT69a2oJZsx/+SNKfA88Jal
         UQog==
X-Gm-Message-State: AOUpUlG0fUKoZtfkxeKeH50GsYkqRER58lWmFnxiub4VnkvY/QYDu8H1
        MiWGO0qzSdERvMVWL4Ytzvs=
X-Google-Smtp-Source: AAOMgperbgQW7WLhvgOWCfNYdHdAVh5Dik1Ntq/VNfNy6yXpo5wzF5DXQ1Lp08WSctDIM32npn3hbg==
X-Received: by 2002:a37:6b84:: with SMTP id g126-v6mr2406865qkc.231.1532104111843;
        Fri, 20 Jul 2018 09:28:31 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id t3-v6sm1333936qto.26.2018.07.20.09.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:28:31 -0700 (PDT)
Subject: Re: ds/multi-pack-index (was Re: What's cooking in git.git (Jul 2018,
 #02; Wed, 18))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "avarab@gmail.com" <avarab@gmail.com>
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
 <c1a697ed-a060-1901-073f-7c8d5d5d0f10@gmail.com>
 <xmqqzhylc2jd.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6ca7212d-c898-a850-101d-13c43a94151e@gmail.com>
Date:   Fri, 20 Jul 2018 12:28:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhylc2jd.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2018 12:09 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>>>    What's the doneness of this one?  I vaguely recall that there was
>>>    an objection against the concept as a whole (i.e. there is a way
>>>    with less damage to gain the same object-abbrev performance); has
>>>    it (and if anything else, they) been resolved in satisfactory
>>>    fashion?
>> I believe you're talking about Ævar's patch series [1] on
>> unconditional abbreviation lengths.
> Yes, this is a total tangent, but what happened to that one?  I did
> not queue because I was led to expect v2 to follow soonish [*1*].
>
>> Lookup speeds improve in a multi-pack environment.
> True.  I recall that years ago there was a discussion, but nobody
> came up with patches, to do the consolidated .idx for exactly that
> reason (not the "abbrev" reason).
>
>> That's the best I can do to sell the feature as it stands now (plus
>> the 'fsck' integration that would follow after this series is
>> accepted).
> Heh, 'fsck' intergration is not a 'feature' to sell anything, I
> would think.  Nobody wants to run fsck for the sake of running
> it---it is just having one extra file that must not go corrupt
> _requires_ one to have a way to check its integrity and fsck is the
> logical place to do so X-<.

Yep. I didn't mean 'fsck' is a selling point, but that it is an 
important thing to build for anything that is going in the objects 
directory. I mention it only to say that I'm committed to providing that 
functionality.

> In any case, we've had this for about a week in 'pu' after 4
> iterations, and review comments seem to have quieted down [*2*], so
> let's consider merging it down to 'next'.  I think at least I need
> to "commit --amend" (or something like that) 16/23.

Right. There is a commit message error and some spaces to insert. See 
[2] if you need a reminder. Thanks!

[2] https://public-inbox.org/git/xmqqin5kupu3.fsf@gitster-ct.c.googlers.com/

> [Footnotes]
>
> *1* <87a7s4471y.fsf@evledraar.gmail.com>
>
> *2* That does not indicate either of these two:
>
>      - nobody is interested in the topic
>      - the topic is now without any flaw
>
>      It only means that keeping it in 'pu' as a dormant topic would
>      not do anybody any good.
