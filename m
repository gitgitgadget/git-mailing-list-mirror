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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD1B1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 11:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfIZLFO (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 07:05:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:51601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfIZLFO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 07:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569495903;
        bh=rSKQ0rneJLh2M49dJ84orkHftepng7B02hsZMRKnMa8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cPhEHxvZIKfPC8v+Dh+wrrOZP2+9OlawQNuldIWPCka2sllEJcCcoz/bBXM8C0O5y
         k1lthvAwqxtXsw/Y99O1PWlC2rtru3j+z4WMoLkQRswg5bnGlIUm/ODH1Fz03MIqKF
         OCYrfMEbeUeulaIjGP1w/JGNRmhQbj+ifH2yJxmc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1iXYj033UX-00OTip; Thu, 26
 Sep 2019 13:05:03 +0200
Date:   Thu, 26 Sep 2019 13:04:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <20190923165828.GA27068@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1909261257160.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190913200317.68440-1-jonathantanmy@google.com> <20190913205148.GA8799@sigill.intra.peff.net> <20190916184208.GB17913@google.com> <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev> <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet> <20190923165828.GA27068@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-504890335-1569495904=:15067"
X-Provags-ID: V03:K1:NxmKfvLpoQ/9HwECIO4LcadWZKoTG51L5hOTSWOxB0ieIlyUL5w
 xanqtA1Mj/i1W193sVz6ekM8FyxNdDjGgtzkyXvcIqoUol7wCxTUa9gsc2e7pdlwJotM0LQ
 2eCIuJyMcmSxmlQtN6Tf6OgZTPNJm469bX4SOW/B9uHdgyYF4WGpiytkTluB6eJE89VvYmn
 giDhHEkn8p8utwi17RZuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PZ6FaFMt5jY=:Tze6GEHb7sFA3W3IZBbAr1
 lh9xVrdTKTTqO8I7PubSlzJAvsp2EtS7w3mFH9qekXPG4XY6WFuPJtj46EED/iKAUPLxcXUGU
 8QMCmaG4OY2Dc+L06vpgMweRNHxY16DAV0552KHJovapaE5lwjuS0thhu3CpF5LdBvaMNWKsO
 /ZzsHctkMyIvqOBDT6ld3mL3dWUDLSdfbnxcPTAyNytamvP5ROrJpSOS/iIWUPD9Dt0XlhPTO
 DVGRLOy0TuQwcR5FF7ODRxHAJRb2S6OQT/M1JbtsSngzjMinTc1zd7Yaoeu0/hgh2UyA6kToI
 x411yXbWL2dbRCi38Ni3WUu9KYCGgLwKRlAyTZP5B5+yWpkFN6V3Y2vV0yjsj9fG9qerS28EG
 cRT4RqCgpWgx6zCPrxQEdccjYtH5SEPaSyhS8bVwQ3KqdczFhc213x70TxJR9tq/50DfSL0YC
 j1d9EUezLoNFixoL6ncpXSh+RsALtZG85hYz7qGldkI6cVWpkv5ksNFpwF5o1Kkoc7cRNv1M+
 LsQV0htYb0Rl7KKLCJD2Guvgqzn9k546niEq4VyNKxKOQFe4sSiaCZ278vaxaBkiYWX28i7VN
 sdTo2abXtEyaPhlkTMJrP5Hdwnv/fktsGmlesxJAatZNw3ip83HomeDVQblV1oHqeEafZ/XaD
 lnGU1VnJ7xuQB0I6REYtwkRZWPHheahPyW0UtM30JwxNdKfaqLV2mWY2ujtRlAT3gmfACqqzx
 CKqqCP5caX/GFyPovAK40klEaHbqzuqFV+n3T+Zr0Gqv2Z6vQWl519OpEU7m/bMJausnl+SLh
 56nTDwBcl/QgUIzBpcvL1RVfNGNRHP1K+hsX8u9eCUYFNfYPPvksVpitjJgBdpY7D73PkN3/X
 /ZN4t5nf91srt1VBD67ZYt5tr/H+dDfC1ap5Gj0xiriiuV6hsdVTfJFK9sZTMAu9hAktXiv05
 f8qAB9dl4qbixyveC5Lwu8+Bm9Fb52mtkETOXfNUKDrGCpp9KOCf/XCJcL+f1PmD3eaf9odKe
 jJ2YUMdZ/MEZRHuyIaNIqg6KCF+KQA/+xdL2DyOnqqzhPkVw+FDL0+LMkYCr9r/2xP2NR/WGW
 sq9w206fD5OQ4VxzNhlWREqHd3ZI9RnL+ok8OEKean6dLmQ/P1sBZHdQd9T6o0ylv8biQ8XYv
 891uRgDKonv7z889ZdX2+Tl7EFBNdq+zKvrBX7N6YlfqD1o1IVRl56kkI/O6t2xo1P9DqGX2t
 +dx5Gv0tJO7VmYdn4vpiT0KVnWpc0jrxeTPK3Zk7FS6d8lQySVgwF2+Hta20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-504890335-1569495904=:15067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 23 Sep 2019, SZEDER G=C3=A1bor wrote:

> On Mon, Sep 23, 2019 at 02:47:23PM +0200, Johannes Schindelin wrote:
> >
> > On Tue, 17 Sep 2019, SZEDER G=C3=A1bor wrote:
> >
> > > On Tue, Sep 17, 2019 at 01:23:18PM +0200, Johannes Schindelin wrote:
> > > > Also, things like the code tracing via `-x` (which relies on Bash
> > > > functionality in order to work properly,
> > >
> > > Not really.
> >
> > To work properly. What I meant was the trick we need to play with
> > `BASH_XTRACEFD`.
>
> I'm still unsure what BASH_XTRACEFD trick you mean.  AFAICT we don't
> play any tricks with it to make '-x' work properly, and indeed '-x'
> tracing works properly even without BASH_XTRACEFD (and to achive that
> we did have to play some tricks, but not any with BASH_XTRACEFD;
> perhaps these tricks are what you meant?).

It works okay some of the time. But IIRC `-x -V` requires the
`BASH_XTRACEFD` trick.

However, I start to feel like I am distracted deliberately from my main
argument: that shell scripting is simply an awful language to implement
a highly reliable test framework. That we need to rely on Bash, at least
some of the time, is just _one_ of the many shortcomings.

> > > > and which _still_ does not work as intended if your test case
> > > > evaluates a lazy prereq that has not been evaluated before
> > >
> > > I don't see any striking differences between the trace output of a t=
est
> > > involving a lazy prereq from Bash or dash:
> > >
> > > [...]
> >
> > The evaluation of the lazy prereq is indeed not different between Bash
> > or dash. It is nevertheless quite disruptive in the trace of a test
> > script, especially when it is evaluated for a test case that is skippe=
d
> > explicitly via the `--run` option.
>
> But then the actual issue is the unnecessary evaluation of the prereq
> even when the test framework could know in advance that the test case
> should be skipped anyway, and the trace from it is a mere side effect,
> no?

I forgot a crucial tidbit: if you run with `-x` and a lazy prereq is
evaluated, not only is the output disruptive, the trace is also turned
off after the lazy prereq, _before_ the actual test case is run. So you
don't see any trace of the actual test case.

In any case, I really do not want to see this thread derailed into
specifics of Bashisms and bugs in our test framework.

My main point should not be diluted: a test framework should be
implemented in a language that offers speedy execution of even
complicated logic, proper error checking, and higher data types (i.e.
other than "everything is a string"). Unix shell script is not it.

Ciao,
Dscho

--8323328-504890335-1569495904=:15067--
