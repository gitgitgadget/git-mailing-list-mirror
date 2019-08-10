Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4111F731
	for <e@80x24.org>; Sat, 10 Aug 2019 19:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfHJTsF (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 15:48:05 -0400
Received: from mout.web.de ([212.227.17.11]:54575 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfHJTsE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 15:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565466477;
        bh=nlPq19Pmd3d3m455LOtqlBiZ2T4kG+p0tJFRJ0S/jrA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CsUHciRaQERc3AM+BrFU5clbGqTqRsiLktX7mPhZ8rYyeh4IbXhsV8GLy4vbhIu3G
         0q9Z5wC6bgkaFrCpos+Yd7hxbv52QPQ8I7KFQePy22oUJqfCtikiCWkEvSXScsbxC8
         siED8yJQULe+4pgGZ0WvzXporhheGOy04pAhWvXQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiUG8-1iSYlt1GQ8-00chsu; Sat, 10
 Aug 2019 21:47:57 +0200
Subject: Re: [PATCH] SQUASH
To:     Carlo Arenas <carenas@gmail.com>
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, michal.kiedrowicz@gmail.com
References: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
 <20190810030315.7519-1-carenas@gmail.com>
 <f78b57a6-9ede-c87c-fc42-292851d79fad@web.de>
 <CAPUEspjtZhhynEmJu_weROaao=1zL+De1h50R-grG36ok+EAyw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <501f946a-1f18-7c6a-2d15-8ff6375c4192@web.de>
Date:   Sat, 10 Aug 2019 21:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspjtZhhynEmJu_weROaao=1zL+De1h50R-grG36ok+EAyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g8Ajqsy3PNXjVCEHzBxCIDVMrU9q20w0W7SmgWLNwLR0PxSp+Hw
 LrWHyc8GznInDd30Ksl6WTxB46VEDeECVtAOCg/fjlh8OSGvSfkEYmQ1kMO3p+9sNT2eN1T
 e/cHRPZGOWFDpc1+xUulcul7sq1UoNH3evOFtijiohwfQgqv/69ut5F0vsmLnpZsd9FKmx4
 Yx+Ll9vA6PNLQIGRygjHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B/LRvldm+80=:DYvWjkB/5GrSONPhB+gVQe
 QHUWnn5W0kjTckVD4F3zq7d6r+9TNHX4V7i/D6mZOJWfygfYkR9G6qS2zQ+GTRzrvlKAb7MTv
 Lne+IeXFOgyul/ccVX8DWKbZBiW1inN6PHBm4BG2XohqKZMzvRgcWGIVd2qXlKFYrx37JjA1J
 +BfibhZI98rOvlx0PYxeZYC1iV++NOdfUKkVDh4aVjY8bTYClkJET7OGQoc3lzWjIwU0vbilT
 SBhHZupnGm1e9c7RlYvj6RF5IHZqnf9u1bgymYX/uFxZdSpYLNeDQN7gI1HdGNEeh828OEIbz
 E67QVGgg7V6zN9713yM/LUVj3s4sKKzVKTRIHaFmzHRQ23FnuuBgNbAkxHdBZUzQFIIvBVyym
 Lauv63WIr76pv95XiUt3GjJ6iELTc1BEIreQAMafvuLSpVVf/CUwJzUhNntUuEaiRcc4XUg4x
 rkLuczKC1b8r59qkTNBKcUHFw1AvRIbSbxQK1xSmP36r3cD8RY+kZ5Yla+LBf3ZL9G7ll1OYD
 6S56ePpNaublxAqJCqxhptnwselZK8SG9pITZKuAdJufPJg82MxPgI7YuoWr/NSmNVAI1ziCY
 e373/Ds7U5GUtvw7io8X+JJfUxdbFqFWOmlDLs2KR72YF9uWAIzF2hgRWymVATUb+HEiIt4bv
 dQngb5PF/UiYPKB550RhmXQnODXqOFooai+9W4c++5Of9gPDkaRq76sbDV6E0a9TN7rRsdvqk
 CRI0BO1JplgZW6XXReWl1bshbjW7TVnD/sQVBk59BBZFNQ+tvMoB1NIHaOXc1Aca/tAaPvhGv
 wB3qTfa3178CYtW6/ZpDlAd4n//cSdMFJi7SkDDKVFi1JaQUU1XUHB+6tsBlcxJ6/woFHZOC1
 ZiovLOmZCZz0G10+nxgI7+N5BPmBrQvo877lfTL/9i7lzNQlkOrBh8xj5AkSymrmq4aqvtk5/
 wTM85m9IjOSlHkgC1SgCVW1yxhDhu+DxMQLOvZoNOjANoD6d4DuvOlc+eI3xQo9sgXeQ+56+p
 jP2hfo1PySja05xmCbAumrAfUR1z1bOWSIhQIheNSNjcoQsrCbmY2x5frdXp311LmEi9MPHIk
 Ir9y6hHNnUBq21HoaS+LSh70GS6EzM0M242VeKy6P64GUA7vzEVzRwKQIrObzlgiWFc0chNGs
 pJS20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.19 um 10:42 schrieb Carlo Arenas:
> On Sat, Aug 10, 2019 at 12:57 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> Am 10.08.19 um 05:03 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
>>> Make using a general context (that is only needed with NED) to depend
>>> on NED being selected at compile time.
>>
>> A custom general context is needed to convince PCRE2 to use xmalloc()
>> instead of mallo().  That is independent of the choice of allocator.
>> So this change would be a step backwards?
>
> My bad, you are correct.
>
> Do you mind then if I "adopt" your patch and submit a reroll with it,
> will also add an "equivalent" one to fix PCRE1 as well then, and we
> will tackle any performance deficiencies or other issues in a future
> series.

I don't mind, sounds good.

Ren=C3=A9
