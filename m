Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56041C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhKVWLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:11:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:39739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234198AbhKVWLp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637618907;
        bh=Nu9EBs0AUIFucIEIIxveug79byjW62F7WeoTf79bp8Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lDFLA4eEYLUzCjPn56sml1ipmt3QSl+Wfd1NXpj4XrM/uFVm4RvwAWgPFFyPU7qjK
         unIkpFQ6G33j28O4i4givokVJhLAWJE3cJC/obEDpBlMGm7eJ2aB060474PjInGizZ
         S1xh8PkO9Y78HCcMHWVz5A3JyKqOrOqaY00+9THk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1mEa5R0J10-00cC1O; Mon, 22
 Nov 2021 23:08:27 +0100
Date:   Mon, 22 Nov 2021 23:08:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v8 00/17] Upstreaming the Scalar command
In-Reply-To: <211122.865yskyw25.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111222304070.63@tvgsbejvaqbjf.bet>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com> <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com> <CABPp-BG=fcKq2Ng2gan3HbBGcT7WCMhtZCP6m2xjA5BSuTekOg@mail.gmail.com> <nycvar.QRO.7.76.6.2111221317390.63@tvgsbejvaqbjf.bet>
 <211122.865yskyw25.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1944441444-1637618907=:63"
X-Provags-ID: V03:K1:jpAZC8BGTX1izOUDtNtTkSHRII5ZFRJtRZUqF2e0Yvqfp8uNSWn
 KZIpsGjqgxBbP3ipsIUh9jNOy+eRE/+FnPlAXM/FDR36j79Ma1gWgnD6W5dfxoqQ26b8zwA
 euLWSld6zId4940CF1pWDVkjNCnuxvc9N0HQHpIjqyj+B6QMpV5Ycv1xfqGPk3uwS92MGFq
 cqC5fP8Fs/YEqRoaJ51ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hktV18Y+xIo=:AqXfyEKsL4pC/JlKBeBOxE
 jzoH1Yx6RLpKHEMGeMWfY+EvwT7+AxTBMy146l/9wvwRcd5yoixyOaeUbE5EoFaH+XKgE4C+l
 seJVVJztr+wGpTX+LB2jgLVe9OZLUWh2UCfcdA4Ki4MF1cRLY3RNsfcsJzKNbyXTVxZlnuAw7
 U072omntnr4CzeghO9aP2SXfKTataS80hJh2K+xE4HyKQQhLS5b1mDPvJpNRvBdrPmQUjIds0
 6MQ/IDKBTIOORIezGEh0jF9mEpLfYdrxTqoeeW3kpxmeLCh0W4qHiwMIZYen/nfXqp8cN5Yic
 BxDExFlBCdFFhQaQbRMj+zcx119etHBaO6GEvXZ0i80edFg3z6+gNeM3Tw6biGZ90PZuMFDpW
 YRzztfZqQhGUpY0F2607J8jUvzVTED2S1+mL+rOwTlQ5XJVTmFqbsffg0ZdCPyyt2shBVaPyg
 IaDZ6PubVd42kzrBQOcKugrC57wENJZloY/g+x/UwNYsMl5WH9/nMXdmGTMOYtuej1L37XsNj
 DWNvm+vE9/LXSZOg5cL6tyVIbnCCFdzPJIIwLW1PO0Zx38Hjcmb98mMTfdzXEtsBPEWvq1d/0
 DLJg2JAB/4KLNrV6SKdTjIWcuVbPKXT+0R3gtau9U/3ZU37kDPkRhXhBHFUkjOHVmw7qcZyrR
 ZUF7rmqX3xCRkbuPyzB491WlJjlHYa+pRfOnAXdEW4esazyP5i2PC1271oOh22hCaXyR0uptt
 g09UhNDoSRVZcZLnUj5D+cMByMeuo3LCyzN/G32N8Z+/PapTsp7P0bKbNs8BQWXP8i93QgZU1
 E3oCMv6Tk8HYPCMFHdLtUiqFBjbrL5In2a4aVxVIGqX1i7tbKmHH2F3segaeyfqWqb6NJRGha
 q/9W+1l5CdX+3OsA61rTLxo6a0bMGz/8ditGPXhKe1UcBhdEicegHrcd3frzC9SMdC42IfD6J
 vLXWzobVLbqnHp0S3g4QbpxR4XRolqefsBdH6Nme4KQktdyv8aHipbYoNv0BkKHIllYuRwZuB
 gnfdIDx+4uOAKUsg4vQDAJf9kwOhlgXFmMA4M1tPZ+TNjYZU1c0ZPAVr9Gp2dW5CamhDP83xB
 sTUcn2eWSuBbIE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1944441444-1637618907=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 22 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Nov 22 2021, Johannes Schindelin wrote:
>
> > On Sat, 20 Nov 2021, Elijah Newren wrote:
> >
> >> On Fri, Nov 19, 2021 at 3:03 PM Johannes Schindelin via GitGitGadget
> >> <gitgitgadget@gmail.com> wrote:
> >> >
> >> > tl;dr: This series contributes the core part of the Scalar command =
to
> >> > the Git project. This command provides an opinionated way to create
> >> > and configure Git repositories with a focus on very large
> >> > repositories.
> >>
> >> I thought after
> >> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110062241150.395@tvgsb=
ejvaqbjf.bet/
> >> that you'd update merge.renames to true on what is now patch 7.  Did
> >> you end up changing your mind, or was this overlooked?
> >
> > Oops! Thank you so much for the reminder.
> >
> > Will fix. I do not plan on sending out a new iteration for a few more =
days
> > because I do not want to send lots of patches to the list right now,
> > reviewer bandwidth seems to be stretched quite a bit already.
>
> Bandwidth which is further stretched by continuing to send updates to
> this topic while ignoring outstanding feedback.

The feedback you are referring to is probably the repeated demand to
integrate Scalar deeply into Git's build process.

As I have tired of replying, it is not the time for that yet.

Repeating that demand does not make it more sensible, nor does it
magically make it the right time.

Nor is it credible to call the build "broken" when it does what it is
supposed to do, thank you very much.

Ciao,
Johannes

--8323328-1944441444-1637618907=:63--
