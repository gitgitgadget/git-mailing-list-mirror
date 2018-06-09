Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E411F403
	for <e@80x24.org>; Sat,  9 Jun 2018 13:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeFIN4Z (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 09:56:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40184 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbeFIN4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 09:56:24 -0400
Received: by mail-pg0-f66.google.com with SMTP id l2-v6so7645702pgc.7
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X9QiuW856+ytAltrd5eTSRjmipdBl14OhTRwqoY3m0g=;
        b=ksc37k6JMnsM3Fixlpx+ZNF2soX0qOy6mYWBW8+mUNmeSPqsNVV3vbzAAjVvt3PYo0
         XRiNzcF9gFwuv331zajpJ0J9yQxHL47OLUoESSxH0JV4umgojRq4h2VvlI3XZnwH88o1
         f20vtkgYkuGWDD7zVo7I329wrwSRMJM0NzzQABVh8WsMtcHa2IhVQnGvRINvyBmM3+0X
         4wdZk7EcpxVhWvcYoXq9YSm/nsR+Xb/AhRRIjKxrSGdSLt4HsX+csHCD+vJnytlQ9dQl
         qnjN7oWqQqchPLMKAiwZONzECHZXOwczdWlLe3myvZ+CnrdVqeL4C8xT2A86CWoVqdQ0
         PY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X9QiuW856+ytAltrd5eTSRjmipdBl14OhTRwqoY3m0g=;
        b=ofYj1GT65ec310FTtncdqnmitQFVQ8Yc72iikK8I9Ylc/u+gfLudh6gX5moYsCycvZ
         ASRR0j7pPDC888qINCD/dKg4rZhGhaAWrfCHlUFHZxt4AKQxF6N/nGNtToAgpc5h3/RV
         CNSNh5iulkyxQjNS+NPg7sPtEOqjFM4qoOVuqN7jDu9JU5lEg9PFS6gI35RRqAd8NIoh
         gOYlwAkCvxT/6Mwmn10OJT9zySDPZT8K2x2WYpfHQrG5oMP7ug6nipakX6t4XhghS4tk
         8WlhM9U35puJbgd5Auo0hde0e1Gak7H6d9V5ahZ0inbbcs0yTvNKaDAt2lOrRe/J+fNa
         5rlg==
X-Gm-Message-State: APt69E3idOvykGLBz2QLpoN81bUyuYdME226M8l/IWXTRWHRXNkmyWyB
        5K1EEmImpr1bmwJSyot2btFQpCDidpu823ONWak=
X-Google-Smtp-Source: ADUXVKIRWbjAoq+Q61LK5Jtc4EUEjfF8EDYKyiFSqDVRfTklZvgVM+b4gXoJXf2yvup1ai8+3SIUA4GUVVEGyz7Mf6E=
X-Received: by 2002:a62:da59:: with SMTP id w25-v6mr10274633pfl.161.1528552584083;
 Sat, 09 Jun 2018 06:56:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Sat, 9 Jun 2018 06:56:23
 -0700 (PDT)
In-Reply-To: <87a7s4471y.fsf@evledraar.gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com> <20180608224136.20220-10-avarab@gmail.com>
 <CAN0heSoaNotgsvbLv03tqRxC75rXzS6LvvnYBrS=f6pk-Y_x3Q@mail.gmail.com> <87a7s4471y.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 9 Jun 2018 15:56:23 +0200
Message-ID: <CAN0heSrh6kJyiAATc377sEg46O=ofEnczCrBubrSM5pxT72W7Q@mail.gmail.com>
Subject: Re: [PATCH 09/20] abbrev tests: test for "git-log" behavior
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 June 2018 at 11:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
>
> On Sat, Jun 09 2018, Martin =C3=85gren wrote:
>
>> On 9 June 2018 at 00:41, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com> wrote:
>>> The "log" family of commands does its own parsing for --abbrev in
>>> revision.c, so having dedicated tests for it makes sense.
>>
>>> +for i in $(test_seq 4 40)
>>
>> I've just been skimming so might have missed something, but I see
>> several instances of this construct, and I wonder what this brute-force
>> approach really buys us. An alternative would be, e.g., "for i in 4 23
>> 40". That is, min/max and some arbitrary number in between (odd because
>> the others are even).
>>
>> Of course, we might have a bug which magically happens for the number 9,
>> but I'd expect us to test for that only if we have some reason to
>> believe that number 9 is indeed magical.
>
> Good point, I'll change this in v2, or at least guard it with
> EXPENSIVE. I hacked it up like this while exhaustively testing things
> during development, and discovered some edge cases (e.g. "0" is special
> sometimes).

Ah, "useful during hacking" explains why you did it like this. Of your
two approaches, I'd probably favour "make it cheaper" over "mark it as
EXPENSIVE". Nothing I feel strongly about.

>> Also, 40 is of course tied to SHA-1. You could perhaps define a variable
>> at the top of this file to simplify a future generalization. (Same for
>> 39/41 which are related to 40.)
>
> I forgot to note this in the commit message, but I intentionally didn't
> guard this test with the SHA1 prereq, there's nothing per-se specific to
> SHA-1 here, it's not a given that whatever our NewHash is that we won't
> use 40 characters, and the rest of the magic constants like 4 and 7 is
> something we're likely to retain with NewHash.

I'd tend to agree about not marking this SHA1.

> Although maybe we should expose GIT_SHA1_HEXSZ to the test suite.

It seems like brian's "test_translate"-approach [1] would be a good
choice of tool for this. That is, you'd just define something at the top
of this file for now, then once that tool is in place, a one-line change
could get "hexsz" from `test_translate` instead.

[1] https://public-inbox.org/git/20180604235229.279814-2-sandals@crustytoot=
hpaste.net/

Martin
