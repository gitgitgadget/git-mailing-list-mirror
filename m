Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2531F954
	for <e@80x24.org>; Wed, 22 Aug 2018 11:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeHVOjN (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 10:39:13 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41210 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeHVOjN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 10:39:13 -0400
Received: by mail-qt0-f194.google.com with SMTP id t39-v6so752350qtc.8
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+45l7mMSNAmmrR2GCrR7/p9wrz35X5vWw6DXwnWEp50=;
        b=c+iYY35gZtL+9asxLePhBueyw3cgJybR39xnNqEW4Iw6Z7pr2AqLX+hGTVDrJtcQQ5
         jzFArq7Mt/1XSaxieWyOhaZs2Ufka2/xjVE6cH0lU8cZLEfQ8Bz70ltsdOqcLG9fgdQg
         fiC+QLtIk5D+D2gikJAKSrDCN6DmcwKu3qyYuSPIeS1cZ8qKt2+lp+2YPH7er06/1Ieq
         YeErGBWvPpqI6wOFU5Li1KXbJPFCBpc8vr0y7YZ1G1KDrwS81Z0zmIhJ8mwFim7sD7Ki
         JzUfFx4bsPGgEtz23fVXR0nrhqyoix0osX+FaHYk0SQy7gH8Fo1uIfgT30sn+0Xtn1F1
         KnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+45l7mMSNAmmrR2GCrR7/p9wrz35X5vWw6DXwnWEp50=;
        b=PpydGmhGc6z4itryrwJP6dD0FH4egoEA8PjlKi/ox3V6BsAk9RlXuaJp6joFzw1Qwx
         1m2Jfy56UAyd/R/Ak9J4bXzABJjT3iITPxq62uNNYC0ixYmmKr7dDD1FUWauuXZKeIuY
         pflXifPE81HY4veBNjLO9JDw9bUUha5nYRWQGmmJiEOCQXkyZDjehwR8fjFKE4yMSyuA
         cvAfvleZrLCaCa8rX7yk4L8MLPCbn9f8vSQPXYAXdfpiFfBOQvCdFpCi4+hG6P9BHrg5
         ZGICZwIb6Ur9oBUkIMNcc9RJgWxdkUJJIbP4Or36rYgpFllYKju9NtwIUhJtTcDo/JTQ
         wChg==
X-Gm-Message-State: APzg51DE/4d9SPQI5C+7NeUWkaVJlAe7b0vp1dWZmZtRLZDn3Nii3xrt
        1luiSDmsR4MPNfYgHHE0HuvaD4c3
X-Google-Smtp-Source: ANB0Vda2aByV/xWgM3gJaQdK8l+siq8ZmvozLrapYfsp5riIsW+WioHWQjtRO2qitA11PaS7+zfSUg==
X-Received: by 2002:a0c:8ab0:: with SMTP id 45-v6mr17724571qvv.49.1534936484516;
        Wed, 22 Aug 2018 04:14:44 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id c11-v6sm723570qkb.22.2018.08.22.04.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 04:14:43 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net>
 <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com>
Date:   Wed, 22 Aug 2018 07:14:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 8/22/2018 3:39 AM, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Aug 22, 2018 at 8:20 AM Jeff King <peff@peff.net> wrote:
>> On Wed, Aug 22, 2018 at 05:36:26AM +0000, brian m. carlson wrote:
>>
>>> On Tue, Aug 21, 2018 at 11:03:44PM -0400, Jeff King wrote:
>>> I don't know if something like this is an improvement or now, but this
>>> seems to at least compile:
>>>
>>> diff --git a/cache.h b/cache.h
>>> index 1398b2a4e4..3207f74771 100644
>>> --- a/cache.h
>>> +++ b/cache.h
>>> @@ -1033,7 +1033,13 @@ extern const struct object_id null_oid;
>>>
>>>   static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>>>   {
>>> -     return memcmp(sha1, sha2, the_hash_algo->rawsz);
>>> +     switch (the_hash_algo->rawsz) {
>>> +             case 20:
>>> +             case 32:
>>> +                     return memcmp(sha1, sha2, the_hash_algo->rawsz);
>>> +             default:
>>> +                     assert(0);
>>> +     }
>> I think that would end up with the same slow code, as gcc would rather
>> call memcmp than expand out the two sets of asm.
>>
>>> I won't have time to sit down and test this out until tomorrow afternoon
>>> at the earliest.  If you want to send in something in the mean time,
>>> even if that limits things to just 20 for now, that's fine.
>> I don't have a good option. The assert() thing works until I add in the
>> "32" branch, but that's just punting the issue off until you add support
>> for the new hash.
>>
>> Hand-rolling our own asm or C is a portability headache, and we need to
>> change all of the callsites to use a new hasheq().
>>
>> Hiding it behind a per-hash function is conceptually cleanest, but not
>> quite as fast. And it also requires hasheq().
>>
>> So all of the solutions seem non-trivial.  Again, I'm starting to wonder
>> if it's worth chasing this few percent.
> Did you try __builtin_expect? It's a GCC builtin for these sorts of
> situations, and sometimes helps:
> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
>
> I.e. you'd tell GCC we expect to have the 20 there with:
>
>      if (__builtin_expect(the_hash_algo->rawsz == 20, 1)) { ... }
>
> The perl codebase has LIKELY() and UNLIKELY() macros for this which if
> the feature isn't available fall back on just plain C code:
> https://github.com/Perl/perl5/blob/v5.27.7/perl.h#L3335-L3344
The other thing I was going to recommend (and I'll try to test this out 
myself later) is to see if 'the_hash_algo->rawsz' is being treated as a 
volatile variable, since it is being referenced through a pointer. 
Perhaps storing the value locally and then casing on it would help?
