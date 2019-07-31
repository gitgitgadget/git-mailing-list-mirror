Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BFF51F731
	for <e@80x24.org>; Wed, 31 Jul 2019 12:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfGaMnR (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 08:43:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:42567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfGaMnR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 08:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564576989;
        bh=6R2PytL2Oi4A3cZoPJHTwZ2QZ2vBfxVd842OkpuDaog=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=l5J0C+2ObRKJKuVW42tB1rXPizI3CtQt64rbQL8ObxzKStT02JpK/nkCoUoVkOa50
         OldorAehHm0Qy/xVXbRsYULW9g1N2HLlfUq0K5p939hjG0mSOT19kmP5WnnhPke+0Z
         qYfFWqB1Y9LnhIKtyId7BCu/GCccaGIiQ27ENclc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M243n-1iCnry2E6l-00u30k; Wed, 31
 Jul 2019 14:43:09 +0200
Date:   Wed, 31 Jul 2019 14:43:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
In-Reply-To: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:moHph+oTz+VUo03GCDQYU7Xd6YSvGursxLgiGxrvbe77TUKpMje
 qe7yTMJv5t3Tkg7TdwJlEDqIxVA9btWDSNn6cQGbh9buZjhlGlmutlZQmmo9XXkkHBDkneL
 y7YdVAQjFVPNNYdfVmrRcTDi5TEF6N9AAq11tAjsUbFJfl8gDQHGcJ2zC5c2plIsOeLeM1c
 WrOJ0ncNeEqXuEP92LJKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UmP0Z0KSnY8=:RF4i1u2q1Km08KX/crmt8B
 6p7HuT7eQjnT2FhrQn324olz9ym4ePqU4ePCuLP6mPJiWcXDrbsrVQOH9lOLEapA+HXcEpYiv
 Qe6Ny+TLtFObXJNSW6es4JjBY1kmb0b+UIbrXXJTgL5zBFzFVYmQjvIShlLCF1ZWqiBCyAn4N
 94WlT5CzM+rc9PCOd5amPJNG7VbU9i7lbR9SelMVtYgh+ciRG+S/mVdyVZrrd8WL6VLXAIC3F
 DP4LpaSJXVJFGXSeZdOsd7IYmBK8K33JWh7xTIxDqQRaNKSpAEFsCUB8SIZ/+fX714XSFZfoC
 qG5dGmZv/HZ9AH9p/UPXYDVc7124eszLVbY9j+In15WWMw4d08iekvYXt5Ca5WWQ2K0JKbaY3
 TC1o7PBcoSeHMTCd6GYCokE2GEByKKAN/UPcGE36KUmpbClCw4nFGNFe5DN5Fy8aM3hVZ56Vf
 lQu+dVHZIPyTZ0mdfh/CV0WNX50Ks+6DhIUciPao+prxh9cHyaKBGNDWuPsudUAtMgLXud+Ds
 A7o5hXdG20m2eXDVpSzxo9y0fTQCZATcEpwXS6+NTBce1eu90OEv4+2ZyELMhTrNIa6kmdVo0
 s+Qbt+LKtavgBKyM+IxOLtPLkBhvdr5B0qBrYWlMWQ7vnPk7s+Jqqn3siLC7SlUBnC3cVmFLi
 IMDHWp4A0UaDeMgJ6c7ueUkHs5mm7/WyH9FIwWyGxgMPc4REa6Luo0iXYwL8fWJRNqM+Kgkul
 R4+myrd8pJyILDji+spIROvXoFfp5CLhBFbtbGn8fUP64uR/EISybAzfsoHLt/wE4R7tPT1qB
 DIFn5YIKsYICsn0J6+PMIh2h4rnnYLRC8wzNDESVBeLXCaO9oSEQ6bV3w+SvJKTt692QKF2Zg
 Nz+AaAegfd9ha+zEU3hhYPy1lmtx60t4+wdXM9mpaG1Oc937oGpeo7tHbrSFIeJLLMa+rl3AI
 GpJCF0yvNZGyUsN86mSB0Z4JUpb+ilODvrFUIpZtLrdwLfbGPiOB/DTtyN16D4rm10TMDGqna
 JlXLesxyUZxwrt5iOsIFw7Bh9G2lPVoVesHAP7uGXkmuznvTYAb8sAUY7iA1kisD1MK84dZ5+
 9OMZfU8IpM2JmvMeNBgBKA0t87fvQVvmHfu
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 29 Jul 2019, Junio C Hamano wrote:

> An early preview release Git v2.23.0-rc0 is now available for
> testing at the usual places.  It is comprised of 420 non-merge
> commits since v2.22.0, contributed by 62 people, 23 of which are
> new faces.
>
> The tarballs are found at:
>
>     https://www.kernel.org/pub/software/scm/git/testing/

And a corresponding Git for Windows v2.23.0-rc0 can be found here:

https://github.com/git-for-windows/git/releases/tag/v2.23.0-rc0.windows.1

Please test!

One (slightly annoying) issue I found already is that a `git log` will
print out a blurb about `log.mailmap`, but most of the time, you cannot
see it because the actual output of `git log` is shown in the pager.

I plan on working around this by setting `log.mailmap =3D true` in Git for
Windows' system config.

Ciao,
Johannes
