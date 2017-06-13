Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C8F1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbdFMU3Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 16:29:16 -0400
Received: from mout.web.de ([212.227.15.3]:52132 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752168AbdFMU3P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 16:29:15 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPYMT-1dPZGD1Een-004lXS; Tue, 13
 Jun 2017 22:29:04 +0200
Subject: Re: [BUG] add_again() off-by-one error in custom format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Giuffrida <michaelpg@chromium.org>, git@vger.kernel.org
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
 <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
Date:   Tue, 13 Jun 2017 22:29:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:q6Riz7AzCyVWaic7u2y3xm+g/dN+qVD6Jz8smQ76GjNMUgXqUOz
 A+Y2gdciflsWK5kvwFQxFY4kInmyRW4ZrZYL8HdNNqZwfCH7IrKqycU7vHDvsOL/QIyLoRs
 LjgRo30HhIluvCgJbW+vhz6msVVG+AEFrZsFhLeqJ24hDVVpduBh+SE3VWA/wo61g/aavvd
 f5BTLllNOxezLxMszfBKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ed23LOMULp8=:2xCbnAmkJWWb4LRiGc27TP
 Ngu4YLrBFzorZ86dJRRaDP5cJtJBMZdEF/cZxe779EyX9S8A/s60UiZXwwcd7GCOH7FbOy6Zl
 2nTm1CJHfMiWHbkejcsOJyGqle22EGrQUXSzVSvSgnoC3C7R279k3o/ZGxUr+YZzg+Hn3AVPm
 sWSIIUr23wCHzXIC9LK1JRc1KeIFb7kUBtdvpcvqM2dOrORL8OW5HLSnwVCbnVlc8t64TbQXp
 EtJZ8tGlnClh0d13pv056tRt79ZDzz5OZf9TA4xoIpI1Q4YlQUAwgReg2xO9cmQL42Rh2k36o
 vARR+q7jf9frZbpvi6m4rLtonLCXvM9a8UZ4t7J3FfktSnL6MvcGa3JRlSzTJM9t6edVjTt4q
 K1jaFqDq73OhFI4XQknbYQpFtp5XVDaykGcmOspSkAs0kz2j2Askgx99SMgeOUONYnkcajhgS
 pIX+udkYHGtxm9mpzRQhZRjHTzUfdw2q3ctymcS2y6qdR5vCFRtNHyE6f5pczOyZGv7tkSAwv
 c72MDdWL/uPRCZInhMws3sTwmTfC3D3zYB6quWZs3wROVqdLQb9M0yXgdKzKNhjYgCmyN0EN0
 2h6lPnBOksQ6lin7HeDi4JiIpP6QkRQ8UtlP3i9S67QWjUytRok4ImoOTRWWvZxkEl5L6kSGS
 NFE9dgdVgQYeAl9ZlRIonmoSOm9e2CZf6WByQhGFU+QtPgBtHOH4xyab8nq97staH78Agtg1E
 MrXFjFwwNTj3IgrFAapK/mtbwMelLP5MlRFu7bS2Sx75VvgIu78RMZivVEDuUEm1h0d7OrDTy
 LOwfGOF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.06.2017 um 20:29 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Indeed, a very nice bug report!
>>
>>> I think the call to format_commit_one() needs to be taught to pass
>>> 'magic' through, and then add_again() mechanism needs to be told not
>>> to cache when magic is in effect, or something like that.
>>>
>>> Perhaps something along this line...?
>>>
>>>    pretty.c | 64 ++++++++++++++++++++++++++++++++++++++--------------------------
>>>    1 file changed, 38 insertions(+), 26 deletions(-)
>>
>> That looks quite big.  You even invent a way to classify magic.
> 
> Hmph, by "a way to classify", do you mean the enum?  That thing was
> there from before, just moved.

Oh, yes, sorry.  I didn't even get that far into the patch.  (I'll
better go to bed after hitting send..)

> Also I think we do not have to change add_again() at all, because
> chunk->off tolerates being given a garbage value as long as
> chunk->len stays 0, and add_again() does not change chunk->len at
> all.
> 
> Which cuts the diffstat down to
> 
>   pretty.c | 40 +++++++++++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 15 deletions(-)
> 
>> Does the caching feature justify the added complexity?
> 
> That's a good question.  I thought about your second alternative
> while adding the "don't cache" thing, but if we can measure and find
> out that we are not gaining much from caching, certainly that sounds
> much simpler.

The difference is about the same as the one between:

	$ time git log --format="" >/dev/null

	real    0m0.463s
	user    0m0.448s
	sys     0m0.012s

and:

	$ time git log --format="%h" >/dev/null

	real    0m1.062s
	user    0m0.636s
	sys     0m0.416s

With caching duplicates are basically free and without it short
hashes have to be looked up again.  Other placeholders may reduce
the relative slowdown, depending on how expensive they are.

Forgot a third option, probably because it's not a particularly good
idea: Replacing the caching in pretty.c with a short static cache in
find_unique_abbrev_r().

René
