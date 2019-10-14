Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9015C1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 11:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfJNLq4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 07:46:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:57185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbfJNLq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 07:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571053611;
        bh=+rCw0dPMoUbZjv6lhFTEXJVC3SBFZ8qWseN6v8BUfD4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IYsVs6NMFUCyLv2Vgh0DyWxMIVoxH5O5SxhFA55/7srZO5+kw05k+tBH3VdSZ4uyg
         h0oOtjJkG2l2RjjIUm0OKkvmpqfzm2EvJn+UHaIqN+fENghd1ryjq8ua4oEick8a+6
         bjZbUjupE65CK+1ajj3jQxJrOMLSylthq67QRKZg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1ifexw2POp-00Nw23; Mon, 14
 Oct 2019 13:46:51 +0200
Date:   Mon, 14 Oct 2019 13:46:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] mingw: bump the minimum Windows version to Vista
In-Reply-To: <xmqq8t35gfw2.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910141344160.46@tvgsbejvaqbjf.bet>
References: <pull.44.git.gitgitgadget@gmail.com> <2b127d9669aa7b73ced7611b6e77044f5efed11d.1538595818.git.gitgitgadget@gmail.com> <87zhvlevxt.fsf@evledraar.gmail.com> <xmqq8t35gfw2.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1583907793-1571053612=:46"
X-Provags-ID: V03:K1:K7ySxDQ6QGC58v4uVuafWLtWqFz1oSU1Bytex5Qc/gMo2bd8Vle
 GUlgfhGQKMn4HXGd5WLA+1gXWvhsyh0y2GPtfRrGgo4eefnmHaVVlyH/dP8ol/4ekyPNVmb
 +FyCad024fTUr2jz3rLLu/3t48I5FG4rjQXBKVvn7eGjg6euv/as77AhRZLGuQ8oGYOvcY2
 uy5wf0Z7kRG9uYiVln12w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GGYVaTCumbk=:e+YuulSYK9j5Ygmz1/5YYu
 FHD9ylohE2hZxf0Zw8fnSW43mG+t9Oj/PjI3b5bzx2V7Byo8P8Y/i9nRAnDhST6M6b1hEap6q
 En6Ya4LQ81YM/g1tqU0evb9Aeqjq+pmmHjTEu5xuPCqzlG92NaNwxB0y90tksgIc0+mZqck13
 iyyqGraiX3vDPxjYAtKk21rOses0MrIXh52M6nca+IDEMOEyMDe1HaJp+EjGzgUJfSUO6DZE8
 dFL349gmw63p9poQLzmlmBl4cVM1epAPDz+pZAtpAxOABU5bK+Y1oCG3F/SoQQ43uOtAQEAio
 pB2uqttG/lj/gRmUfSi+lI0hYKfKnSAjPzYnuH1/Gz6tLFNEMZgKbOc+UeUkmLQ6kdov5UkTx
 3zP4KrAAAHefjcvkCtGRZkMSpJ5VBAsH4zyAwRyEdA1jVci/Dj0h9Q6htr/KJGHwIW1ozZYQw
 rMmtI18ufUpkNGmgm3ykg/Oau3uCob+abNHlBX+lzMRyz85mzYUuh5a3zTxo5f/zVuaPP+GUo
 0d0IpqsKHxXBqXjvP4JGSBACc/0oxeEbLMyG0OYJKMS/0PulUkBjjrZmJwZn+jwM1rKidsW+m
 DAC4uD07XYKkkUldz6eF63ex1VC+d0jY8rZfDPL76CKYJfjkoYYm56jnSppKUUm+6NJjwkpq9
 MJCNEqwRiyYw3/uW/7wkJ9x2+GwR0hR03UofaR2mk0H4SpFVBUWNgSICGS9yxY/oGpshT3OEx
 FNjqcxa6IIRBLwUKZAeXxk6NdffFmAOlnOAiYZkHVVm4UntNmtvCzEIJcdI3MUJct4OUawkW9
 tgIpyfax5Ky/C5gsRrFet5zIGdhf5SQawClQ2AzpLauoYtGlSAKSEcKI0alZKVNMJZVCQfhSa
 vAB27+p7c6oYokq3qwOYIeZhLycKFod9eqxixtHE9gTNClZWW6aDU/nIL3+/OOJnEyNes+z/U
 9AmaPlLwjhHV1NrVObY++pWYnAOK1PDQTFjYfaoN2uT/+PPA0+wpr46D6pnAHIikE31zwqq7E
 Ew9pafEaA1YNuRVwrmdxGGfWN+Hq7uv0790FJS9c0OyjcpKh4IoqEYZLI8tenDRnxE5TPpijp
 Y7TGcdoU/6V7bybTNtVUTqFdlePTy5LXzHFRfoWYXyJPOBplO92NvmasVbVDpYgJGthWNOwi8
 uAg3erHNbN4gmFsvBClERehMgdqWpiFXAfx4k3icjHyD2I6/9tlKUXHSpnwpHL38cvXOBTz14
 QcggCTMkOwZPh7cGiUJ57E3VE9mesQQX146I1MAB4Y5Hg4QluovYcPRqqS9Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1583907793-1571053612=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

[sorry about the blast from the past, I just noticed that I had not
answered]

On Thu, 11 Oct 2018, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> >> It also means that we no longer need the inet_pton() and inet_ntop()
> >> emulation, which is nice.
> >
> > Earlier in this series you add a:
> >
> > #if defined(_WIN32_WINNT) && _WIN32_WINNT >=3D 0x600
> > ...
> > #endif
> >
> > Shouldn't that now be something like:
> >
> > #if defined(_WIN32_WINNT)
> > #if _WIN32_WINNT >=3D 0x600
> > ...
> > #else
> > #error "You need at least Windows Vista to build Git!"
> > #endif
> > #endif
> >
> > Or do we catch users building on non-supported versions earlier someho=
w
> > (i.e. not just with a flood of compilation errors).
>
> That sounds like a reasonable thing to be curious about.

I specifically wanted to leave the door open for people who might want
to put in the effort of keeping Windows XP support alive.

But I guess this does not make any sense anymore, what with Windows
_Vista_ being at its end of its life in 3 months.

Thanks! Will prepare a patch,
Dscho

>
> > Both of the above are just questions I was curious about since I saw
> > your <nycvar.QRO.7.76.6.1810101502220.2034@tvgsbejvaqbjf.bet>, and
> > shouldn't bee seen as bumping this to "this needs a re-roll" or it
> > should be delayed in getting to master.
>

--8323328-1583907793-1571053612=:46--
