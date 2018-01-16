Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C6B51FADF
	for <e@80x24.org>; Tue, 16 Jan 2018 07:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750822AbeAPHWZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 02:22:25 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:39596 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeAPHWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 02:22:24 -0500
Received: by mail-qt0-f175.google.com with SMTP id k19so17128485qtj.6
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 23:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jt14vSFDyKgTPqiwrP5aOnB2O5lRH21d83MQ8YO2M0Q=;
        b=QJsLOuxf3HAtxNSBM2KP81xyFs+DcYsf4KB514Y/PAO5De9L4rjBkT59c+FX+t0gd1
         n6U/9tEn2V7d4e5j0iyOlis/4JDqz/RKr18y7E9fF6IFIhYh79dzlGlnoIWAYKq5SmVJ
         o4RipSROSR1uK0tZJR9NqzU7JTou3fdGU6meX5YwRqW2cq/uYoj+KecxMc1hYhnETvq6
         mPYXUVB8OVbARXlQBt0/GoquWxohdH3UYjOioowch/zv/yu7YH7dmVMxshLeGqPkiSTq
         h7yM0hzJgURGtKdp+HKskurMiRezDB6RrJ1KWgp00GHgDSx+1nB8pKnXSwIXWnMVpVYv
         0sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jt14vSFDyKgTPqiwrP5aOnB2O5lRH21d83MQ8YO2M0Q=;
        b=Hz/nY6wLr4gKDuwXh1LXwycR9XETcaDWIxG0HEibtC2IGYG4mBMmXt42OinK2+2ZQk
         iytLIZMRxlLJLs2wd4uwH0Jo8tiSpFHuhg4Tw0D6ZEBht5iPZb3sC55EcvURJCbCTwPm
         LKxF1vfeb9DJMFzLD86MkRvJQGfJKKcUAZUVtVcYUm8Eh711/6V8WDqIQWUzp0KKmBPz
         gKzhmfkFIiruoLxM6ETZUqB8YDaQxJvcIgBn/yCE2103yBs3+M3wc0OZ7XpvQ04lhoVz
         jZ/dE8Xgap1VYGzhVRFIMp8cMlbeH5DvMB5lcwU8bwstnymyt10W32SOysngJK3DP64z
         UlwA==
X-Gm-Message-State: AKwxytetHvmJ6c8YEcU2VP+D8pN0AbJrNz90pUSj3L2e9p3+NBeO9ZP6
        zU/NvhfsoD1yyuuYGjDuudtyjPT8Wx9VzH8XJ1M=
X-Google-Smtp-Source: ACJfBotURk59GLE//8dKBV/h6mzumswm0XpSHGP91QQgqPfVq05Akdc3dUsWL4AirBIPQwWwqgwQbGwDfJ2J/zLmcqg=
X-Received: by 10.237.58.132 with SMTP id o4mr28595033qte.207.1516087343689;
 Mon, 15 Jan 2018 23:22:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Mon, 15 Jan 2018 23:22:23 -0800 (PST)
In-Reply-To: <20180115220946.GF4778@sigill.intra.peff.net>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
 <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <20180115213335.GB4778@sigill.intra.peff.net> <20180115220946.GF4778@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 16 Jan 2018 10:22:23 +0300
Message-ID: <CAL21BmmmX5-uisj+_=sDHwJO=fpXc41Wriw+uuxtR=gOio-HZQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] cat-file: split expand_atom into 2 functions
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-16 1:09 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Jan 15, 2018 at 04:33:35PM -0500, Jeff King wrote:
>
>> That works, but I don't think it's where we want to end up in the long
>> run.

I absolutely agree, I want to merge current edits and then continue
migrating process. And hopefully second part of the function will also
be removed.

>> Because:
>>
>>   1. We still have the set of formats duplicated between expand_atom()
>>      and the "preparation" step. It's just that the preparation is now
>>      in ref-filter.c. What happens if ref-filter.c learns new formatting
>>      placeholders (or options for those placeholders) that cat-file.c
>>      doesn't, or vice versa? The two have to be kept in sync.
>>
>>   2. We're missing out on all of the other placeholders that ref-filter
>>      knows about. Not all of them are meaningful (e.g., %(refname)
>>      wouldn't make sense here), but part of our goal is to support the
>>      same set of placeholders as much as possible. Some obvious ones
>>      that ought to work for cat-file: %(objectname:short), %(if), and
>>      things like %(subject) when the appropriate object type is used.
>>
>> In other words, I think the endgame is that expand_atom() isn't there at
>> all, and we're calling the equivalent of format_ref_item() for each
>> object (except that in a unified formatting world, it probably doesn't
>> have the word "ref" in it, since that's just one of the items a caller
>> might pass in).

Agree! I want to merge current edits, then create format.h file and
make some renames, then finish migrating process to new format.h and
support all new meaningful tags.

>
> I read carefully up through about patch 6, and then skimmed through the
> rest. I think we really want to push this in the direction of more
> unification, as above. I know that the patches here may be a step on the
> way, but I had a hard time evaluating each patch to see if it was
> leading us in the right direction.
>
> I think what would help for reviewing this is:
>
>   1. Start with a cover letter that makes it clear what the end state of
>      the series is, and why that's the right place to end up.
>
>   2. Include a rough roadmap of the patches in the cover letter.
>      Hopefully they should group into a few obvious steps (like "in
>      patches 1-5, we're teaching ref-filter to support everything that
>      cat-file can do, then in 6-10 we're preparing cat-file for the
>      conversion, and then in 11 we do the conversion"). If it doesn't
>      form a coherent narrative, then it may be worth stepping back and
>      thinking about combining or reordering the patches in a different
>      way, so that the progression becomes more plain.
>
>      I think one of the things that makes the progression here hard to
>      understand (for me, anyway) is that it's "inside out" of what I'd
>      expect. There's a lot of code movement happening first, and then
>      refactoring and simplifying after that. So between those two steps,
>      there's a lot of interim ugliness (e.g., having to reach across
>      module boundaries to look at expand_data). It's hard to tell when
>      looking at each individual patch how necessary the ugliness is, and
>      whether and when it's going to go away later in the series.
>
> There's a lot of good work here, and you've figured out a lot about how
> the two systems function. I think we just need to rearrange things a bit
> to make sure each step is moving in the right direction.
>
> -Peff

As I said, I am sure that I will continue working on that, so this is
not the end state. So I am not sure that I am able to write finalizing
messages for now. But, if we merge current edits, it will be much
easier for me to continue working on that (next patch would be about
creating format.h and I am afraid of some merge conflicts if I will
develop absolutely all process from start to finish in my branch, it
takes time. It's not a big problem, but, if we find final goal
worthwhile, so maybe we could go to it step-by-step).
