Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD2C1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 11:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfGCLta (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 07:49:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:45509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfGCLt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 07:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562154557;
        bh=FDpJtJcF5CLCOFolsXPUdwYc31T0MHCNfRj9jayP/40=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bTicczqsX4+vWm8jCvFZYTQIcma4awy42Ioh2ke1ZJ/ByvVALMauCitpYvkrFLtMO
         hXMZ2TS7YMwZhVjHdhKr7K0qPQfPLIyCa+4C/ZFmZ8h42qN9JokWgYp+N4uAYxs83j
         BeKiHFnd1tVH8elg/5/x8oLIqkKGVkJnCCajefpI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjIBr-1iFEHq0mv1-00dask; Wed, 03
 Jul 2019 13:49:17 +0200
Date:   Wed, 3 Jul 2019 13:49:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: disable Homebrew's auto cleanup
In-Reply-To: <20190703104748.32533-2-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907031349250.44@tvgsbejvaqbjf.bet>
References: <20190629170108.GF21574@szeder.dev> <20190703104748.32533-1-szeder.dev@gmail.com> <20190703104748.32533-2-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-647684965-1562154586=:44"
X-Provags-ID: V03:K1:y7j/li7i+9tJYzFcwim3MiCbLW4MubWZ/2yrxbEtHyY9NbgzU8f
 t8rNFance6KMTdShCIDcoBzkUPtyYVdTwMUycaW93lzBCZS6JQ+wQzTZODbKppsZG5opDJs
 5hVYu2YLc5UKmwxUuniDa1va1YGJYVdsp8BXLpuop9QuZW7JerobMCBiPlHOgEKcORMby7h
 pnzL0UZsU3+TUtEodu8/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KZvg1713yyQ=:c2pmcSErPvd532qTBzoETB
 v5ZoGLl+L6ed3GAgcE0MbdNSZ+8g3GpSepqeloxfFrYrCjK4KO4XFGGCM5xIUghXxD70CwZCm
 8ZJdQLGWCRcsfzg2vCfx0PUFeu80eis/4mF+YT0X5uOzpfBWK3jKf6sbrhsNY0eSmM40Jvoeh
 tr71xPdb31k2UKrn+3oGDui8znoMQf/PLW+5H/369i01dVOtG9Uwl9My9lY0mWUktyGcC9xeA
 KAbd9RhwzvyMzxXKOblQ6WEyxZl603e0gLPH+CkulJzs5ios8lo9jOJM4UJgCzCnNsCxp7lQI
 h74R9gy9Zf7YAuezjqAd2x4PoOT9YbRw6wHbrqD106OfA8ybvjcgfQ7/AD4g4VSAUB4W/NzID
 VfQgltpM1Ye7G8InVOovxM2Ax46xuq0m2hh8Krx64XktKD6B05JmgMjGn4vyL7kpzr/289iyG
 kQC6kcnJmtS7TNOiqHDl2a2qgWM9hZ4TNqfopK9Jyaupcw1rYMCNGEafpKadrQ5qVtMCcGX2B
 fjjHxom+/Jd3GMSieo7kb9u5sWHsMBWFiOHixa0/uMlRWRjIDRfayUxRaYn/YSFTzw5V0bVuN
 OKRljnM8YsN2i86901bt1aH7pMYlpSSjZ6WnCDVY93AbnmgHpLhKhKuKaxnZyAy6dZJpLPPhG
 Wg/vCKCVn0ftJNFjdBwwfjEcPbyk7Dh1MbthWO5kBj2KmQDapmo23A3hz51ICYoxBTcXMdGMz
 mK3cMcXDZi7a3Ixvk/Dk01/d+GDv3/nVmfKE9BVJZHatilnssc3DhpX1GqlFdh83Kk9gJRcLU
 W/BWe+ucq/L2eqa1f6RFIqwCs1wUxiWCxGTpHBrqC8SmC7U/kexOJkTtjuh5HVjp+IG2gPEFA
 FDH/CBt0CKQpl38CYWosMLfUwOHc9Ii9dWJkfyRsimFxUqtfMRQCVz8sdoHLeO74Txoonk/ky
 SyFG6TLPvEmtTbuicyaiYFUlGEs65p/+9B3/Nvx2KOyCLB+StyObdHAj4e37wZveUzOmfI4/4
 yD1RhFHAY3s0+/wS9HS4yECc+w06nQnq7PPxzEEx7OMW1SkBqGGDb3wV263Uvif2AkSGDuLGU
 GuxyHP+tRleSQIDYqmG9qsl+Ovbz2tyCC39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-647684965-1562154586=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 3 Jul 2019, SZEDER G=C3=A1bor wrote:

> Lately Homebrew learned to automagically clean up information about
> outdated packages during other 'brew' commands, which might be useful
> for the avarage user, but is a waste of time in CI build jobs, because
> the next build jobs will start from the exact same image containing
> the same outdated packages anyway.
>
> Export HOMEBREW_NO_AUTO_UPDATE=3D1 to disable this auto cleanup feature,
> shaving off about 20-30s from the time needed to install dependencies
> in our macOS build jobs on Travis CI.

I am very much in favor of both of these patches.

Thanks,
Dscho

--8323328-647684965-1562154586=:44--
