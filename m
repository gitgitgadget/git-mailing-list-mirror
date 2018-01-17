Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8105A1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 20:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeAQUYJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 15:24:09 -0500
Received: from mout.gmx.net ([212.227.17.22]:63953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbeAQUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 15:24:06 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhhr5-1eF8Yz0aqh-00Mrm3; Wed, 17
 Jan 2018 21:23:46 +0100
Date:   Wed, 17 Jan 2018 21:23:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Michael Haggerty <mhagger@alum.mit.edu>
cc:     Kim Gybels <kgybels@infogroep.be>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Supplements to "packed_ref_cache: don't use mmap()
 for small files"
In-Reply-To: <cover.1516017331.git.mhagger@alum.mit.edu>
Message-ID: <nycvar.QRO.7.76.6.1801172123020.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180114191416.2368-1-kgybels@infogroep.be> <cover.1516017331.git.mhagger@alum.mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eqU/Bs76f6dOrtzD3hHFoymCEHDtjoVOc2fVe4ggT7Md8JbJ9w0
 vDp8CixSUB/wKkXWEG5nYJv1opW1O/SPgkDD3wOWZwHBu6orolan+9wijHE7hYiqA3b8ikY
 Ie8T/pVlm1x7jIpaWK8/4J61bHUodlC6VRKIeY7BRpU2lohDm2yR7SuRL1ic/D46OJ9gFzS
 WRYkpcGzp6WlU3kjK3Opw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ni2HGcL7EbE=:B9ToCzUeXB9JBS0fluNQA7
 2E9a/S+uLpkM2UTOMiaBJds9KIJGQ+awnDDwU6/JfwG/OdUIHMfL5crkHXQcI+YaYk89VQBCV
 MjHSCzRHUAQPlIzR5xqCDyhsZDHJgw1f+RGis2KeZrFBU5fJthrAODgSwrkAvsx2+y0KBriK7
 eXOyQIVeCdRWEZUzy79BEJymomOQ92ljJi8BEca+xaZ9XubDWghruLv5wRx1FQB2TwJ7qzX8m
 wBhwZNhUVqmC8ycUQRLVe+xnehqLzxhOTaUjGzLfN4OitycIIrxt4lDThrTjg1wWs1UuNasLA
 5JfQJVAT/OGc6ARVvwvsnE4nPqE7NwWTf4MCXnIq2ZcpGTwMZSJVilTtnM7nntlk+wMTlsMik
 Joh8EDLTPsQbY5kQ17zvc9YRsF7zR2tMYr6Z/Kfwt5kUf4YEauuIYYoezpTVjJEIwhgO1Fs0l
 Y/u52DJBVRD5eub0vLGI7zL9UP7wMlKgWRgUhLD4ZSIXRIQh42DllHhBMrNkgGkklFRxNn1l6
 6JRLZwARQCEUIeYBhZgqkkYKsuD52YfRKkPXrhDyufkhQuoczp6OwrE0cqIupSw1MttbQts+1
 suQNhd9IMh/8nmxj3a16EC5JnQkRHmmGND4jMatcyQ9T0zrbvqC4xhGbEowL44zibO88Iv1Le
 7gUb53ENg6BTazCA+rsISH8HVugc/jjwjI9V6zifx7g6rlk/+QXeyheIp8XMEzjt7Mu8YGeJ4
 HAPDHViYUfr4j8zuo/qtwFisKoST/49ff3keh/cUgMmkfh7k1MnymEkqVJLcQfaCV1siBuRsT
 Cgeq32gBj23tAIvR8wnE1F7tkyy6bPUnQemSmUGqnNrBArfbUw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Mon, 15 Jan 2018, Michael Haggerty wrote:

> Thanks for your patch. I haven't measured the performance difference
> of `mmap()` vs. `read()` for small `packed-refs` files, but it's not
> surprising that `read()` would be faster.
> 
> I especially like the fix for zero-length `packed-refs` files. (Even
> though AFAIK Git never writes such files, they are totally legitimate
> and shouldn't cause Git to fail.) With or without the additions
> mentioned below,
> 
> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> While reviewing your patch, I realized that some areas of the existing
> code use constructs that are undefined according to the C standard,
> such as computing `NULL + 0` and `NULL - NULL`. This was already wrong
> (and would come up more frequently after your change). Even though
> these are unlikely to be problems in the real world, it would be good
> to avoid them.
> 
> So I will follow up this email with three patches:
> 
> 1. Mention that `snapshot::buf` can be NULL for empty files
> 
>    I suggest squashing this into your patch, to make it clear that
>    `snapshot::buf` and `snapshot::eof` can also be NULL if the
>    `packed-refs` file is empty.
> 
> 2. create_snapshot(): exit early if the file was empty
> 
>    Avoid undefined behavior by returning early if `snapshot->buf` is
>    NULL.
> 
> 3. find_reference_location(): don't invoke if `snapshot->buf` is NULL
> 
>    Avoid undefined behavior and confusing semantics by not calling
>    `find_reference_location()` when `snapshot->buf` is NULL.
> 
> Michael
> 
> Michael Haggerty (3):
>   SQUASH? Mention that `snapshot::buf` can be NULL for empty files
>   create_snapshot(): exit early if the file was empty
>   find_reference_location(): don't invoke if `snapshot->buf` is NULL

I reviewed those patches and find the straight-forward (and obviously
good).

Thanks,
Dscho
