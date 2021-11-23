Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A598AC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 13:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKWNJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:09:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:45587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231255AbhKWNJD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 08:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637672744;
        bh=HlEgIM5Kn9NGPFqnJdMlkDYbPicwLeed0ZObf3ZRtV0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ShCCwtZJGBNkHEslWhrjHYX+IVNWZqMnCxb+1l+eP+nizEnfBaL7MvwdCHTIcipj0
         r/9Hu29+vJNNUigXf2oJtqv8MKTjG8qhgUjxlc8xGUZjhoZ6/Sr2i+HiBo3FWdek3K
         1TLMEvRNI36yko50yfG1KAMywMTgwMI2hFXYW4os=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1m9bAO2qaW-00g0ye; Tue, 23
 Nov 2021 14:05:44 +0100
Date:   Tue, 23 Nov 2021 14:05:42 +0100 (CET)
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
In-Reply-To: <211123.86ee77uj18.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111231403030.63@tvgsbejvaqbjf.bet>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>        <CABPp-BG=fcKq2Ng2gan3HbBGcT7WCMhtZCP6m2xjA5BSuTekOg@mail.gmail.com>        <nycvar.QRO.7.76.6.2111221317390.63@tvgsbejvaqbjf.bet>
        <211122.865yskyw25.gmgdl@evledraar.gmail.com>        <nycvar.QRO.7.76.6.2111222304070.63@tvgsbejvaqbjf.bet>        <211123.86y25fwxup.gmgdl@evledraar.gmail.com>        <nycvar.QRO.7.76.6.2111231249080.63@tvgsbejvaqbjf.bet>
 <211123.86ee77uj18.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1328822684-1637672745=:63"
X-Provags-ID: V03:K1:mpS8tUee8ojmXfG3MB2UOtFBEuP9UaGZG+7U4m+xci2GUBf+mBk
 IXIsIpaRKIK3BZCJf2oYGkBSoZPtjH9XzpK24JgtBAMtdIU/AL6cUhnSgwYS5fz7H8AhvD7
 TBErDf8ZNu7LvHMkn9gP7LQGHO63H9CqrcvhcYLgrtJ1D1YoMRNrDV3uzyRUrzomH1mu8CS
 hdRf/RIiKqTR+3SQawRcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XL1rGTiwvm0=:RIS1Empg1hJccXlrAkJ5tM
 yszY3ZZVywVgRuw3iMaH7FFi+aV8oYUdhs6aB01JI/GQ1mfzIq0iuhNLm4bw9IGQC4Kbp8Gjc
 BtMxy+XiA9mMKZOZJZ3mdAPjxLo3VV30e1xjmcxnLTiAPv0jEmLjnmN7q5fy9A0zv5udRihl3
 kWs6CEGFagQ/CGnPAd/adJRn0xC6fGAaeGCKE9m59ICbjjg+im1XPxg6USE1AV8gA+KKZSZXm
 JnsnWnJP/xwehe03ytGR0YBLuzNJgIb79+bOfZCY72wIKP+etDLGJ17NdXIgtBDwWcsvUhRLQ
 NZFJydwMPaTpd1A1T3BAl1kcpuqoAu/noaOk7tJjDVy+VIgZpFX1AWhFpL/Sr/rT0Z2dVgaKw
 +0I5AX3LKoxklAMaiFw0XlUnBrNEAVydIorwbvSmRzHyGTemimI/RzEAf13s87Ker4ZW/ier5
 rrZP8+FPOn26l5hiMpz3iWHQyLNYbX4me1a7perGPHNoNxVZpXh+Xs/giisTsPanI3k3xrWaE
 Xgc+6gnpo4Usw+Fo2zYpUfMhMnQbViQeyrs09u9g+v3B4MLx4bz1ShGv0kikeG9MofK2tryDn
 Mt6iZWExN4ugQVOpenxdjivyMHRfoKDJ2+rXMrAuzzQH3pOGmj9hWgso5kwsUIR68dl6he4+O
 yOl+M1HU1ore5PAG8pIa2u6m2u1WuQSEaGYXGBCnjM6tvNihy+A2FKgD74Ov/iV7E/oXpE5Yj
 ruwLgcBHw3zrdiY0hTL1vhnneA+ykhHT7GJ2JELw/vn9K3yCawNdzTcvGlgvqoWau+gTfx/Me
 Pm04T1/BAj7D5AI+yGKkk4tt5f4ksRuxhBXswHlwRWNpU3Viwfd/35Gw5YxYc1bbvVFqM3v0r
 Tye3WV89P5b8QoeqpHsB5P+ImYPQ+hfMSQ5zGBHsVJM2cD5WWWE8E6JsVarMm98fQ3dwldOKW
 sb/u2dDUa1pFQm3C4aqe1O/kDTQkymhPDl5rvmewN+1VXqJBrdkIghCkQ41zySOTjpd4o1psD
 3hnz9gHoY62ovOOULhgrlG7QwMRm38Sz5tydpqFs1fcBGEdL9U3NyBwOOemrJIv+95xrW7PoI
 Ox62uFJZPw5YXU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1328822684-1637672745=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 23 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Nov 23 2021, Johannes Schindelin wrote:
>
> > Hi =C3=86var,
> >
> > On Tue, 23 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> [...]
> >>     $ make clean; make -C contrib/scalar test
> >>     [...]
> >>         CC hook.o
> >>         CC version.o
> >>         CC help.o
> >>         AR libgit.a
> >>     make[1]: Leaving directory '/home/avar/g/git'
> >>         SUBDIR ../..
> >>     make[1]: Entering directory '/home/avar/g/git'
> >>         * new link flags
> >>         CC contrib/scalar/scalar.o
> >>         LINK contrib/scalar/scalar
> >>     make[1]: Leaving directory '/home/avar/g/git'
> >>     make -C t
> >>     make[1]: Entering directory '/home/avar/g/git/contrib/scalar/t'
> >>     *** prove ***
> >>     error: GIT-BUILD-OPTIONS missing (has Git been built?).
> >>     t9099-scalar.sh .. Dubious, test returned 1 (wstat 256, 0x100)
> >>     No subtests run
> >
> > That's cute. You seem to have missed that this is `contrib/`? The
> > assumption of pretty much _everything_ in there is that Git was alread=
y
> > built.
> >
> > Try this at home: `make clean && make -C contrib/subtree/ test`
> >
> > Yep. It "fails" in the same way. "has Git been built?".
> >
> > So if that was all the evidence in favor of that misinformation "Scala=
r's
> > build is broken! Broken, broken, BROKEN!", I think we can now let it r=
est.
> > At last.
>
> No, it doesn't fail in the same way. Really, it seems like you're either
> not fully reading through E-Mails before replying, or entirely
> misunderstanding what I'm saying.

That's really... fresh.

I told you half a dozen times that at this point, the build works well
enough, and that what you keep insisting is a problem simply isn't.

Yes, you have to build Git before building Scalar.

Have you actually looked at the design of Scalar? What it does to allow
working with large repositories?

_That_ is what counts.

That you are told to please build Git before running Scalar's tests is
maybe a minor annoyance, but not worth the dozens of mails and the weeks
of delay that you caused over this.

Ciao,
Johannes

--8323328-1328822684-1637672745=:63--
