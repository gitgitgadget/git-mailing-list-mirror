Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6564D1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 11:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeHVOg0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 10:36:26 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:45820 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbeHVOg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 10:36:26 -0400
Received: by mail-qk0-f179.google.com with SMTP id z125-v6so873940qkb.12
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=ppwFQmJ6JBLjkbdEfrykL2AHEiKOdZ53n+6SPGPyemM=;
        b=FA9V855fBIDw4CBF3mCslAxidGX5cA226fsDOgnOpC9Iss7SIvBz9l8dTf2/uv0LfJ
         EzuDKUYJPyar318qZS8yj9Y/CPIaVFZC2w/c+3kLz1vG5yeIYRbT36UmfFeLNiDvrvo8
         rzRuVplOfZOU4d2c+gHasulqpS6GT6sBHTl68zSBHYsDFoyPQZGFmMymYgPjdZjMUfEL
         5YdcZ/+wE2uqZLrr+si/QO9VHL5mqGSQ3tp1rDS5QJg03FTiCK4Rewx5Ip/mlENSBrfD
         iYFUDHtYb4F4U+Enzt1hiURYYWw5LjSANEhiNe9Y8y22o+Ojkx0sA3sjEwqtO4y6rQP2
         Ziqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ppwFQmJ6JBLjkbdEfrykL2AHEiKOdZ53n+6SPGPyemM=;
        b=pSkycVKSrMe/2c6lG9rdCU3SgVVnNWJC9Sw1uxFTLXm8kfJ/TWP8ad+t5/8g7kIJEd
         ZrbpfwD0KJRH3bcSl/RxRKfTPJ3bHMMkkYEoHpHMNkKXHsUlVbMBmCfsuV5PGLgYhgJD
         /gdHmKAe+4IG4ixv9YxGiWevHgPT287g5vkGvdAd0cBJoV6Ml2VsCEpw/v5VoEu9fVjb
         RhGEMbru/lwm+s9hN+x0xbB77Kx2fH/MkcySIn0m9TvgqXRpsx8hoULb44XCniB3vj8y
         dgKjbVaP0Q390Tz5Ks4bAaJzTYlwAuO9ZqxAi+0mAU4H930gec/TUXz/mWO1Y2erFkzt
         aipg==
X-Gm-Message-State: AOUpUlGeJKI4ZygEN1esdcxrTJnTF0jsJmfbiyKDtBJS8I+5DvA+kxgN
        hphiZVqbtrWhz9B8FCIe7+Xb8nI1
X-Google-Smtp-Source: AA+uWPxi9fsUOEGJoJtJbkw3ftIVyZNowmEdy/es7joP2FhirpUqoMFzHTHhssUbVQBFvLV5IROhdQ==
X-Received: by 2002:a37:ad07:: with SMTP id f7-v6mr47050342qkm.114.1534936317217;
        Wed, 22 Aug 2018 04:11:57 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id s66-v6sm808908qki.24.2018.08.22.04.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 04:11:56 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822033654.GA30196@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b60e8d18-261c-c86d-b5e0-b06a5d46d9ea@gmail.com>
Date:   Wed, 22 Aug 2018 07:11:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180822033654.GA30196@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2018 11:36 PM, Jeff King wrote:
> On Tue, Aug 21, 2018 at 11:03:44PM -0400, Jeff King wrote:
>
>> with the obvious "oideq()" implementation added, that seems to get me to
>> 2-3%. Not _quite_ as good as the original branching version I showed.
>> And we had to touch all the callsites (although arguably that kind of
>> "eq" function is a better interface anyway, since it obviously allows
>> for more optimization.
>>
>> So maybe the branching thing is actually not so insane. It makes new
>> hash_algo's Just Work; they just won't be optimized. And the change is
>> very localized.
> Hmph. So I went back to double-check my measurements on that branching
> version, and I couldn't replicate it!
I'm actually relieved to see this, as I couldn't either.
>
> It turns out what I showed (and measured) before has a bug. Can you see
> it?
I had rewritten the section from scratch instead of applying your diff, 
so I didn't get the sha1-sha1 error. I decided to sleep on it instead of 
sending my email.

> So the assert() version really is the fastest. I didn't test, but I
> suspect we could "trick" the compiler by having the fallback call an
> opaque wrapper around memcmp(). That would prevent it from combining the
> two paths, and presumably it would still optimize the constant-20 side.
> Or maybe it would eventually decide our inline function is getting too
> big and scrap it. Which probably crosses a line of craziness (if I
> didn't already cross it two emails ago).
I appreciate your effort here.

Thanks
-Stolee
