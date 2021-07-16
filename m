Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF8AC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE4860FF3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhGPPPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 11:15:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:42347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233094AbhGPPPB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 11:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626448314;
        bh=zOdZEfg5wzKsk7Ok4xbKlz3JjvK8vDGLGrfWgIsW8yM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GGLtAbigaAj3HLjBtGduC7mEsTjbakP4Se1Lk2jegRbHzRtcfQvM4M4zQW39pCWnG
         xUIZKSYNms9AxZ+sKcYO4HGNibCbG5aLXl5DmBA6EFCSII8cjY+NvRSn/265s7ITW5
         iaIxyvF9GNby6VmSuKGyqKgHHNdAxvU/VYo6FCB0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1lV4gc0b3o-00ZL5I; Fri, 16
 Jul 2021 17:11:54 +0200
Date:   Fri, 16 Jul 2021 17:11:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: recommend gender-neutral description
In-Reply-To: <2bdd27b7-cbe1-6952-eca0-f6fcecdaec8c@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107161709310.59@tvgsbejvaqbjf.bet>
References: <xmqqmtqpzosf.fsf@gitster.g> <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com> <87czrl0wob.fsf@evledraar.gmail.com> <xmqqk0lrtuh4.fsf_-_@gitster.g> <CAPig+cT24=jy65C1cQ4WarakJHKm4F8_78nDm=jWOnHxfhtcRw@mail.gmail.com>
 <2bdd27b7-cbe1-6952-eca0-f6fcecdaec8c@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6voU4sEd8BU707KJQIQRZH1MsoZUZ4qoPpRzm/PM1q8xS3w9LAy
 XdNYjKSrXJCif0SjCTAbKLiQ/iHhWmkvq41/WgqKCmSp69I6lH/AO6/RYU/OJuRcsO4BzSo
 lHq71aMHD50UvdBm1K7b5y8sZB0v63oEH0lZYfzpv99w5RG/1JhdKdg91VifXRwaM+PraH0
 Qc7mcrpTUUicX3ut9KqyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9HJFe+nQuH8=:5IJcaqK1BD6p6glYudCtm9
 FfrLSY9Nh8zFRKJycfg+ilTrhgGblJWkphBChP0VJcrOUKHy14E5vwtJAt4ESB90Ap1A6hhzf
 6mJ0HhOrjPm6Gysv8pL7C6ZCPHoitc+/zOwgBpWIA8Wg5rI+7Konbh3acra3u7dx2z161BsRl
 6n3pM4P7xQ2sAkjYGCvsuII084wHJu+TWe7SUwTKKYHv8jxvXjto8qTkltefVjc7HC3a/8KSi
 s0RiSdgdipPtgTSI5+cYn+5y1T9uAhityn3ra2O/CmknNNqfJy5r1wuHsVMAsEO3YRzaYl9kJ
 20eShZMZw4g4rUphyy4cyNKUtdMT+hsBN9zNVJ9xe8wiW1UXrVRWzt2gFgeNYx5UgQM2q72fK
 bpidfQ7+rByUCUxhOFR62LwlpC8QZSVRI+GHg786pVYcEe0nyUxWiIbrKku0btRIqd4GW7cNQ
 DB8fdXWPi8Ja1Jw/jNE7z/h7BmnYaQXYuExMyYQGw9rQRnOdSOIUKvZfCrhrjjEL+0lQSeecL
 Dd3tvO2gCHAFEe3jjkrcYJ9QbOrJSjAJFuah0CcUHi9MdnBZFLvEKtlpiaVk4/lyFkH1e45Ob
 RrLLT6mtji67g1KzQpiS4/jo/Rf+MJZG62hTn2NPguR/uLgnFyfXtiHLzwYuZSW6e/NHkYVAN
 eL4VdqmxKWZ9PFuO8Duen4cmRpmlpiQbh8AEPjjLELahqRuD3C7wNBnWbmZ6Tlt1RA7MivQ6y
 A4T0ffDLOANiWPRvrpYLoRqxtfHWKoIugEDt4HjoeoMxxxT2bcEmY2ne4Q5nzI3TzsszLCP+c
 3raytwv7DpZ9m9TxMBqyHKSTweJkz8K3ZJj9+Uh85vqg6RoJx9RwKq3k2Ia2CumYpP2dMblAd
 26v3ATy79N/+XuoqE1aZWoYTxp/1wphiXpxBoppHdlJqrDYGc2AzrmIVXOjPNamK/0eH9vncs
 t4uWYQNg5gkBiZYWQJyI7YWn3ZAfJj+8x2Bwd03h2z/UOTjS0frD8S+7YhaRW0gqdMZtaLJu2
 J3iI6gEIYgLm+bCEX7I3HJqi+XZ4Y1Msjh8XGiqy7Lsx35a+covYoXQHxFkVfIdudBJX6sNSN
 Sh/gX2D93GWXwEN8AuFjTLmiIoJbbmsYjd/aihbZjOcug9euPE3dA3vqw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 15 Jul 2021, Derrick Stolee wrote:

> On 7/15/2021 12:35 PM, Eric Sunshine wrote:
> > On Thu, Jul 15, 2021 at 12:25 PM Junio C Hamano <gitster@pobox.com> wr=
ote:
> >> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGui=
delines
> >> @@ -541,6 +541,49 @@ Writing Documentation:
> >> +      A contributor asks their upstream to pull from them.
> >> +
> >> +    Note that this sounds ungrammatical and unnatural to those who
> >> +    learned English as a second language in some parts of the world.
> >
> > It also sounds ungrammatical and unnatural to this native English spea=
ker.
>
> A way to adapt this idea more generally would be to pull a phrase
> from my commit message in v3:
>
>   Note that this sounds ungrammatical and unnatural to readers
>   who learned English in a way that dictated "they" as always plural.
>
> Learning English as a second language is one example of how one could
> find it ungrammatical. We could call it out explicitly:
>
>   Note that this sounds ungrammatical and unnatural to readers
>   who learned English in a way that dictated "they" as always plural,
>   especially those who learned English as a second language.

I like the latter form.

Ciao,
Dscho "who will never stop learning English because learning never ends"
