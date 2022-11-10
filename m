Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2857C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 13:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiKJNcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 08:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKJNcY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 08:32:24 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732ABDC2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668087137; bh=1OBv4U1n9y6l6d4WI9/SlC8HGm9SCZ3mWX/21aHoIi0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OmG0mWXOiE0RYk/llBS0I2wbI+YEQsrDNXudFtMOhWFIUlCW9U5cW6Hfi4I5fDVh5
         i7x64GjcyQZ+x5BNvxf5L7tIHYV2clppcAdj68jT6YBRgLnc93govvw5CejcZ5Pszo
         MYduufJDWonh+mbNBHyKk5S4zm9g7r+3VyLembWh3c8Xv+VKNI/MwN3hgYXg0qDs6O
         N3qR4D5Lk0NukjTrtzIY+Tk0/gyV8+wGwbF53sSuKVA/ixRSpaysst9wZakLni90eU
         2jrjR+wm6PeqdZ2EMKJ9K5O1Z60SBwF3ZsPmKYWfhflOSrEtg7RH4UU13Dr6OkDwfk
         krd6CTvInRTwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.27.167.171] ([213.196.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1oqMVr0sXu-003ucs; Thu, 10
 Nov 2022 14:32:17 +0100
Date:   Thu, 10 Nov 2022 14:32:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: js/bisect-in-c (was: What's cooking in git.git (Oct 2022, #09;
 Mon, 31))
In-Reply-To: <221102.86cza52rt0.gmgdl@evledraar.gmail.com>
Message-ID: <s024qpqn-0roo-3rr2-nr4p-74p9296r6p02@tzk.qr>
References: <Y19dnb2M+yObnftj@nand.local> <221102.86cza52rt0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1457152789-1668087137=:16139"
X-Provags-ID: V03:K1:QPtgHLpOOUZwYg0jOt1j8y+lRx+2mxOPoa36sVci3rJ4pL9AvYE
 6vnkpB5liYM9uYj+DCz5CNAHhgZT71eP3pdyCKbIx1ZOrmRiaJJbUwm+DEhYGJ5coGruHdj
 ciNbQk63/a0Dxxy98MtN1Yl6JY2DZA/cWA1ZDIqbLBt4Crnmxv0ppSxg1GpzFZp09BehFbo
 rMI5BJ5SqD/IoFyHamVbw==
UI-OutboundReport: notjunk:1;M01:P0:p2DHpWTfeF0=;mQ8eD6TaGQjzyOlFWHlRw7wbN3q
 ek0L2c/pmIc/Np6rFrtailLkx+WcoK+8xdzieT+CmNIE5uT4tjIZoSCqm5RkWCmw7F/yiwn67
 zNYd99W7mRjI9tBJtNROBLfp1E8IJDxw7UfPPd5yGaIQk5TJbzVqJPuUcGOnTs42vXSKE5m/6
 TS+c3oYVmvS4uvhj2YXC/oIw1npNtzApBeBRvjyOVBh114AThUBPthfO4BnY5VsGqZmLg9Kkd
 BOdjkx4XVChp5WYSPDHAABAiqmdoVehhvTSieFjyTEXUFL8ls4wIueW5b7B/tpE+bBI7416ns
 eO1iqg8ciww4SI8lpL112S09L7OoHtiSRAg6Vs6HlPXiVyIiTfwEmpjv0WFha9CySirEP2TVy
 jVR11U3PJ0bbkN6Z1H/LMO7Eo/TSQbRuPc6+Pmbsj/tv9SPEw88Yb0aqflN6DdXbVBnMyY9Ql
 5rbnrz1PtlAfG2cqm2+xVvBVyY7uasx9ERSnrVPAylZTX7gRCILdqTXXmbIfW0Jgtk8wljlPY
 sEn6MFQ6dO2pN7j6LKNuY1ioYZ9/Rv1pi+kWf0w0hbaC2C4hnAid4EfJ0Qc85aoJiteo/z2dD
 gqkaONbYh3+aPt8CcvGEmUHBKvej1IOBGNDHQwvLpODz0XQrDd5OLY+2vPtRqnrewR7rbrACu
 AKy8NxB4v3WITcAelsS6r+OIACTUbqVgq0QMkA8mPW2qZU/gEqNiziFsColCXMubj7nUliuNz
 sof6m0y7eNFtI0+fLxXRVYp39ZQeLRm0NOAZs342453xpqc01HA54RQa/x80RugEYryIpy4hU
 RhgcBjjIkV2VpHiYC/BH5Q9vQze/v5CRX+B6ca2/jOyc8g2DovY+k2iQDFEzHsXcPwfJFwL9D
 CVMygmJH+kDCHu+qOAvNoNzGjNBf/vfLKjg66idvLgNquZvvCkqrQZAi3HcZYXMoShvEB71KZ
 fffeYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1457152789-1668087137=:16139
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 2 Nov 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Oct 31 2022, Taylor Blau wrote:
>
> > What's cooking in git.git (Oct 2022, #09; Mon, 31)
> > --------------------------------------------------
> >
> > * js/bisect-in-c (2022-08-30) 17 commits
> >  . bisect: no longer try to clean up left-over `.git/head-name` files
> >  . bisect: remove Cogito-related code
> >  . Turn `git bisect` into a full built-in
> >  . bisect: move even the command-line parsing to `bisect--helper`
> >  . bisect--helper: make `state` optional
> >  . bisect--helper: calling `bisect_state()` without an argument is a b=
ug
> >  . bisect: avoid double-quoting when printing the failed command
> >  . bisect run: fix the error message
> >  . bisect: verify that a bogus option won't try to start a bisection
> >  . bisect--helper: migrate to OPT_SUBCOMMAND()
> >  . bisect--helper: make the order consistently `argc, argv`
> >  . bisect--helper: make `terms` an explicit singleton
> >  . bisect--helper: simplify exit code computation
> >  . bisect--helper: really retire `--bisect-autostart`
> >  . bisect--helper: really retire --bisect-next-check
> >  . bisect--helper: retire the --no-log option
> >  . Merge branch 'sg/parse-options-subcommand' into js/bisect-in-c
> >
> >  Final bits of "git bisect.sh" have been rewritten in C.
> >
> >  Needs review.
> >  cf. <xmqqv8pr8903.fsf@gitster.g>
> >  source: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
>
> I see this has been ejected out of "seen", presumably due to the
> outstanding conflicts.
>
> To the extent that Johannes doesn't have time I'd by happy to re-roll
> this & look at it/fix whatever outstanding issues I spot.
>
> I gave it a once over a few weeks ago, and didn't see any outstanding
> problems with it worth rewriting in that iteration, but didn't have time
> to give it stress testing to see if there were still some lurking
> unexpected/untested behavior changes.
>
> Johannes?

I saw that this was marked as "Needs review." for quite a while. Seeing as
this patch series has been kept out of `next` for quite a few iterations
basically solely due to your concerns (others have said they're fine with
it), I kind of expected you to give a thumbs-up or a thumbs-down (combined
with clear, concise suggestions how to get this moving again).

So now you say that you did not see any outstanding problems? That would
proabably have been good information for Junio to use to move it along
while it did not conflict.

Ciao,
Johannes

--8323328-1457152789-1668087137=:16139--
