Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B23F1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 17:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHVU3x (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 16:29:53 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:40288 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeHVU3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 16:29:53 -0400
Received: by mail-qt0-f172.google.com with SMTP id h4-v6so2926994qtj.7
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MyR6wxpeWrBH0uUkWH5elv+KEo0TAJlHFzfzaKRNRI0=;
        b=q5X9xG/42wgPM/EBh8Bj348ZT4a7a5wRb/K+XiUDw9B7LJJ6fZ346GfkHFiCJylsfD
         LmGxH2Zv4MjfhMKWhQZu6V32m8+wmQEonsUqsB2zP9l6H/1cnfy6Ac++3SV/WFzGagp4
         RBEOdFLu+IWKl4Jgtyf6+U/iX7nFOVDcGu9hkq+hIkepC618oYISkzqmkGbpoA0AgM8k
         e3a1wex20EI4Iqvnm5PhO4kTOKaHeO9svIp5nqCnAggkhoER8EJrBJpcdoUYAN02oeM9
         NKIy5jGfo3CQkm+F36cHnHPc/+5Y3QvqF3JEuM2sF4Po05xdlrif14sXLh6gehTr0WL+
         lBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MyR6wxpeWrBH0uUkWH5elv+KEo0TAJlHFzfzaKRNRI0=;
        b=nECxCmrYN2cO0MzTYHArFube12KjxuNoE2mQwq6Dzz51QerwYJ3IN6vF9mr+zxupim
         Z5vmOb0jJ0KhyTVTgJNOY0HRlQc6KT3oJsIXmQFOV0UIOrqm1e3SV90XmsCRQBiimkva
         h14ovKbaU1rVRNCi/4wzCaevcjPY98hXLXT9lOv/ChxGqpcPoxGdFF/TXe8AijFmB35K
         rFyATAFTX/oNxDD3i8mCrUOoymB+yYc/M0do9UfDHlC8be8odONt3YXMgmefz653BqoP
         4/I9DLohwppWSY+i2qmMKKBQJKWKMitQp4fMREeXrtZFoUW+APQ9ufVHXH5a/611BKoI
         lZ8Q==
X-Gm-Message-State: AOUpUlG2wyA4YaHDD4grkmZ394lp1BhWP149EKmhgK+ciS+hP1J3REtI
        YdLfT128riESFg1z4DnlbUq6i8SN
X-Google-Smtp-Source: AA+uWPxzomKH/gMIq9OajKlkATB0sfWRbqJ4sG7xt9crU2fJplndJIXG+e1Jf6DGzrDTtnBbx2wzpg==
X-Received: by 2002:ac8:198c:: with SMTP id u12-v6mr10047906qtj.86.1534957451092;
        Wed, 22 Aug 2018 10:04:11 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id p57-v6sm1373721qtj.42.2018.08.22.10.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:04:10 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net>
 <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
 <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com>
 <20180822151703.GB32630@sigill.intra.peff.net>
 <CACsJy8B+FN6W32ZUgetXbEJ=Ld5ZDHHhNWVz2aiZLZG1_qA+FQ@mail.gmail.com>
 <CACsJy8DifmYtDE4D58yVM7rYhfJFe8p-t9bXgMmMsw=txxmzHA@mail.gmail.com>
 <20180822162609.GA11904@sigill.intra.peff.net>
 <7ea416cf-b043-1274-e161-85a8780b8e1c@gmail.com>
 <CACsJy8By49nz6-q78GuMYP8ssrjhWYyhYrJcL8eWpi4-mZzzxA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <387295e3-3112-ed09-d988-3d8156e3c7ce@gmail.com>
Date:   Wed, 22 Aug 2018 13:04:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8By49nz6-q78GuMYP8ssrjhWYyhYrJcL8eWpi4-mZzzxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2018 12:58 PM, Duy Nguyen wrote:
> On Wed, Aug 22, 2018 at 6:49 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 8/22/2018 12:26 PM, Jeff King wrote:
>>> On Wed, Aug 22, 2018 at 06:14:24PM +0200, Duy Nguyen wrote:
>>>
>>>> On Wed, Aug 22, 2018 at 6:08 PM Duy Nguyen <pclouds@gmail.com> wrote:
>>>>> On Wed, Aug 22, 2018 at 6:03 PM Jeff King <peff@peff.net> wrote:
>>>>>> On Wed, Aug 22, 2018 at 07:14:42AM -0400, Derrick Stolee wrote:
>>>>>>
>>>>>>> The other thing I was going to recommend (and I'll try to test this out
>>>>>>> myself later) is to see if 'the_hash_algo->rawsz' is being treated as a
>>>>>>> volatile variable, since it is being referenced through a pointer. Perhaps
>>>>>>> storing the value locally and then casing on it would help?
>>>>>> I tried various sprinkling of "const" around the declarations to make it
>>>>>> clear that the values wouldn't change once we saw them. But I couldn't
>>>>>> detect any difference. At most I think that would let us hoist the "if"
>>>>>> out of the loop, but gcc still seems unwilling to expand the memcmp when
>>>>>> there are other branches.
>>>>>>
>>>>>> I think if that's the thing we want to have happen, we really do need to
>>>>>> just write it out on that branch rather than saying "memcmp".
>>>>> This reminds me of an old discussion about memcpy() vs doing explicit
>>>>> compare loop with lots of performance measurements..
>>>> Ah found it. Not sure if it is still relevant in light of multiple hash support
>>>>
>>>> https://public-inbox.org/git/20110427225114.GA16765@elte.hu/
>>> Yes, that was what I meant. We actually did switch to that hand-rolled
>>> loop, but later we went back to memcmp in 0b006014c8 (hashcmp: use
>>> memcmp instead of open-coded loop, 2017-08-09).
>> Looking at that commit, I'm surprised the old logic was just a for loop, instead of a word-based approach, such as the following:
> Might work on x86 but it breaks on cpu architectures with stricter
> alignment. I don't think we have a guarantee that object_id is always
> 8 byte aligned.
You (and Peff) are probably correct here, which is unfortunate. I'm not 
familiar with alignment constraints, but assume that such a word-based 
approach is best.

Thanks,
-Stolee

