Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8071F462
	for <e@80x24.org>; Thu, 23 May 2019 21:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfEWVAk (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 17:00:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:51029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfEWVAk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 17:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558645224;
        bh=4XkHciln9jsZ/AHtUlNv+JSh4f6iBB+ujoZr1q2uy0E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ferPWgnIx5DDzLXDpYmrX/xUq4vC772wX9EyEQQT3WEmC72rKuSiEuJK5fcbnRtkQ
         NhPmFgQqN3UiGolgcse71kvM6tuGe/QDzeIFrd5YHb7YU2Vg2DecRrToMhZOmJ09FR
         4HpybfIoxH2FVE0k+6PHu+k08O2b6cVhKfDrWA/8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1hDCkk3qN3-00LI33; Thu, 23
 May 2019 23:00:24 +0200
Date:   Thu, 23 May 2019 23:00:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Git Mailing List' <git@vger.kernel.org>
Subject: RE: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
In-Reply-To: <004e01d511a1$c521a120$4f64e360$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1905232258280.46@tvgsbejvaqbjf.bet>
References: <001501d5101e$db98dfb0$92ca9f10$@nexbridge.com> <20190522004825.GC8616@genre.crustytoothpaste.net> <004e01d511a1$c521a120$4f64e360$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3IeaEBNBfQK6fS5QAnEfFed8okHjVKrmEZ2AnqNKrzFGHhoGp3k
 2ZRAEGIjHN1Exbef9SMRrjH9XcWvOjiwHJJyvlp3XSoeO6lUBRbADFXUg0Ib35njCw0Wua0
 TIn2k9eb3dkVCQx1p/dWsXG/rzSih8/lo2M0hKt4MiZCKrV7vmKUH55/wd9fMnAsdm02NPS
 /4yXzrxQXNs6TVujzX5NA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQpfo2Kt7VY=:3a3RhDX/ZvAh7Euie1idGD
 yqfCXhL4ZSdvqEwKb/5VIALkHNDQUVn1EsoHY0Ob0QZ+wx2K/UCr3Mvi1kz/CCLNIOShGjQkO
 j/TfevWVmStORTYvUiKofuph/Y5ighjQQ8hZKcOFH7/woF9NGZis0mNhI9oQwbChsxWCcRnKd
 46QACO6ZVoCCSL2TdBzvfeTbLGg38lYSr89VfTFqjF9liMPZVQwFi73xNVPjxt7jJWDiqQPPF
 1SGAYPek31Xe4u0Wqys+xORZ07/JJCJZFFkWAKiuEssXm9ZAphVddyPpPNaHAdk7vRnMPbawS
 N5z6Jp1S0culN07HxY90KSNzC4J81DGxRcIuifkXAFZzxIuvEq4jclDyXiji0dvLoRKC3BiDW
 voJ1YCba0jcNb+kSGiz2Z+j9akH5wNersTgskcPeKLU4b+rzpZoWVUFhIEQ+rcpc4C6DOPeVO
 XVjydy3Fi7VUJhKP/KKvJPbPAxx3ZzxT1RUDvB9TlazXEaz0XMZ5OraxUlJEqPjvyA+kRYu2M
 Dy89dYJIvQqYbh8fgNJAF1UmyIqsOKRTj3oS4ZEVGkiH9PEiC5kyhXJjQjqYr7lUxB8WMjhFB
 Wa3fAEQ39lfqcWD4eupLjv5tSMTEbGG/+H4w/SdUCgMgLIh0FDLHASDGeP5KWgg5A3kSloHj1
 MMua2CuB87nv7k0I5b7KQFO7UaA4kH0P/HzBFfPt1wNFMDL7M6G/6HxDLUmREBxB/vwlSEoxR
 io36jYDQ0TXr4Fr4dAXejrB9RpNlx8P1lBwB2FzaU4pkJMKzHVYwLBpCGrnmCnAapPGK1+h2h
 dWsqFB4Ot4JuH5yIdGUbFd7pIkiiWryQbmZGb/t/C4Bea0zE+BqpolNCPB/Pt/vqxrO/a6DCp
 WbXpELeYNyaDQZIiiEn4bVjMWYRWcG5zeCJeSvG8XLMPa8PR4IJISAVc8AZqYcj/DEWm2QUnJ
 hMG4A43gbTSZ3IQ7QlHX2mH5Iwc6How4APz/kl4pKLQdABShQRyNf
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Thu, 23 May 2019, Randall S. Becker wrote:

> On May 21, 2019 20:48, brian m. carlson wrote:
> > To: Randall S. Becker <rsbecker@nexbridge.com>
> > Cc: 'Git Mailing List' <git@vger.kernel.org>
> > Subject: Re: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
> >
> > On 2019-05-21 at 21:47:54, Randall S. Becker wrote:
> > > When running the test in isolation, it passes without incident
> > > whether or not --verbose is used. So far, this only occurs on the
> > > first run through. I wanted to report it, based on the inconsistency
> > > of results. This is not the first time tests have acted in this
> > > fashion, and I realize it is difficult to do anything about it
> > > without being able to recreate
> > the situation.
> >
> > Does running git clean -dxf cause it to be reproducible?
>
> Made no difference. t5401 passed cleanly after a the clean -dxf. I don't
> know where the breadcrumbs are. I guess it could be something funky in
> the file system on platform or with bash.

FWIW I do not see any of the major platforms having any sort of regression
in t5401:
https://dev.azure.com/gitgitgadget/git/_test/analytics?definitionId=3D4&co=
ntextType=3Dbuild

So I guess the only way you will find out more about this issue is by
instrumenting the code and digging in. You will most likely find that the
`--stress` mode will help you recreate the situation rather easily.

Ciao,
Johannes
