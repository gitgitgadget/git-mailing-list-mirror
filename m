Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31E71F597
	for <e@80x24.org>; Thu, 19 Jul 2018 15:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeGSQLV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 12:11:21 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:39912 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbeGSQLU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 12:11:20 -0400
Received: by mail-ua0-f182.google.com with SMTP id g18-v6so5443001uam.6
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rMeAm1jdbhChQCAkSd4BatCnhaP/tmXnTM4Byt8nvDk=;
        b=pEyWSVC7ljxVyQVO47CI+5FXOquFGqNFXDhJ9FpgdVlYQ0HLU/2sM3uJHqrlP3Q7wK
         zayXRTlREAu/OpleNiRRfoPP3QZ7C4lI/EatxOkNmSokhf2Tc+oGwxS2mne/zwZ/+6lA
         s89KBS3IfYR8IYz2m+BE398bK9uv7eL+vqYLfOMnTIOxM2gXs5DJUpwmoTPMaUVYjrRj
         dPKvU5NbgAfnJmI34/EbII9eKNGwwp1X8mQwOhHvuA7q2VXYDvrOSZ63m+/AbGvuCAAx
         yr/UHR7lgVG9MrjtoJeyp8CS2nV4XpXYxJDXpiVBW6q48JoyT6kAcbXv5fa/G1CsrCaV
         Yv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rMeAm1jdbhChQCAkSd4BatCnhaP/tmXnTM4Byt8nvDk=;
        b=YKkcaGk3iNgtRL/1WUmFnfDs7BFDAp6EZz5+bLFC/jnA2u7vFFleswchxX22MjWFg2
         RKsH0HoXQXtNkqP3pq5j46qSYDnxcwvbUsIXniUaDajlc68h3tkdokVFcT1tUgFzRZLX
         +Yb4qvUjQuMfAOILw588oXTj62t9dRd6G50a/tJDFn3AtQ7Wxu/l9y8eKpT81/mJoLEh
         epOY+rljPtWr7fBC5uNcSOc6UU5s8IQn8EIACDrVi9lj/GrQ88FlgMgO2lZ9vIxQP2vf
         V+PMtvOK224qqLSmf2Pk7tSetnoITDV1uCJUXYVAkNEkzi8NaUimUI8DySQgt1v8jk3V
         9LRg==
X-Gm-Message-State: AOUpUlEBZ6kF2boSzwqFfg0XXggqRkVjtT7NK4wvmhi8h2UdGMOaX/bR
        5PP9h2LBGzaa8krQWDp8z7BCUfcr1yXx8Vkz/AHBWUXs
X-Google-Smtp-Source: AAOMgpfvRsBQhvIImGR8ZCAZfZOqaZfUpGYTa85RUgPGT3meBqxkE/eDG5Am3Krd9W/fam9+/7d7enxULxZecOTSQeU=
X-Received: by 2002:a9f:3666:: with SMTP id s35-v6mr7359934uad.94.1532014058698;
 Thu, 19 Jul 2018 08:27:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 08:27:38
 -0700 (PDT)
In-Reply-To: <CACsJy8Cc=h3ptDaW=oUGXqRZAvNU8-pUCe1cVFpRd0t8O1a0Gw@mail.gmail.com>
References: <20180718225110.17639-1-newren@gmail.com> <CACsJy8Cc=h3ptDaW=oUGXqRZAvNU8-pUCe1cVFpRd0t8O1a0Gw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Jul 2018 08:27:38 -0700
Message-ID: <CABPp-BGbFSv3uyHusgKqaFAW4acXdf2Cj-s4FyZLiDU_brpK1Q@mail.gmail.com>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 10:41 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 19, 2018 at 12:51 AM Elijah Newren <newren@gmail.com> wrote:
>>
>> I had a user report some poor behavior of 'git gc --aggressive' on a
>> certain repo (which I sadly cannot share).  Turns out that on this
>> repo, this operation takes about 60% longer and produces a pack
>> roughly twice the expected size.
>
> The intention was to make life better for weaker machines but
> definitely should not slow down beefier ones, so yes this is
> definitely a regression.

Not sure if it matters, but the original discovery was on a laptop.
Probably 4 cores and 16 GB RAM.  I duplicated on my workstation (8
cores, 24 GB RAM).  However, since the original patch was memory
related and I noticed the repacking using all available memory, I
repeated the testcases while measuring memory but did it on a machine
that wouldn't be memory limited.

> Is it possible to share "verify-pack -v <pack file>" output of the
> pack produced by 2.17.0 and 2.18.0? The only sensitive info there is
> sha-1, which you can replace with just "SHA-1" if you want. I'm more
> interested in delta sizes and distribution.

For the deltas, assuming the size-in-pack field (4th column) is the relevant one

Number of objects in repo (lines of verify-pack output): 4460755
Number of deltas: 2831384
Number of deltas greater than 1MB: 72
Min: 14
Median: 47
Mean: 586
99.999 percentile: 11366280.6 (10.8 MB)
Max: 141664210 (135.1 MB)

If the size field (3rd column) is the relevant one, then the numbers
change slightly to:

Number of deltas greater than 1MB: 101
Min: 4
Median: 33
Mean: 660
99.999 percentile: 12245551.7 (11.7 MB)
Max: 144658342 (138.0 MB)

I checked out the blob which had the biggest delta, as well as the
blob it was a delta against.  One was a 280 MB file, the other a 278
MB file.
