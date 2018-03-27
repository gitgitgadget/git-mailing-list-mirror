Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B961F404
	for <e@80x24.org>; Tue, 27 Mar 2018 13:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbeC0N5p (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 09:57:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:38023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752937AbeC0N5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 09:57:43 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9vnQ-1epqkh26LA-00B3nS; Tue, 27
 Mar 2018 15:57:35 +0200
Date:   Tue, 27 Mar 2018 15:57:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/36] t/helper: add an empty test-tool program
In-Reply-To: <CAM0VKjmCKmQisLZcBw7ZROQmg3bVTXTOK6auo6DjjkOfKdPv1w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803271556170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074505.19100-1-pclouds@gmail.com> <20180324074505.19100-2-pclouds@gmail.com> <nycvar.QRO.7.76.6.1803261722350.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CACsJy8Dz87YHiA48m_X7OmJXioKorUDNSyPy250jaqU7xt1JXQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803270007550.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAM0VKjmCKmQisLZcBw7ZROQmg3bVTXTOK6auo6DjjkOfKdPv1w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-888637613-1522159055=:77"
X-Provags-ID: V03:K0:XY2yto6IWV8QPhb98pKoYzutzFPIEpHu9fp2Tldf5OyXfsSMhfp
 EepQpq20O88aFHzzroobROk+A/m+TmLeMw3HKwlycBZOGmrFnXDW6vYyrP7297TxujCTwG/
 iDV1d+pjNEwXaDoAwQVVr6w1YsQCTtItLcQkVHmTcU/Iry5uAHy+aw59d7jJBi8WWxp2qC7
 kYXaJFKFiMjv5wgP9xDYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/Wk3x2ktK4s=:ZpJ1hIE6YBKgEonn0VUsC3
 AhRvG2HOM/ByIqZJqiUur9IWZSxNnTgFd93aiiDl6v8MqV+XXSFCIveP1ciWEERghHdIA5wxn
 LS/wgLINo4x+JCNCoespuHyjD173+rgZaISEYvoM76iZ8EMVC9m5rMsGB4/Z+c7W/1wTzmH0i
 UWkWK4NdCyqrigsrZdPFDZWr1Z1fvz9u99QCv/5/VR87QkLtLjnfoWH1D4Jd/mBYk1A++iwpj
 fRavsR6a7Z2I7QxUBaCjhD65DHa/PERwcIgX8N1+MFlW+mFmbC1jTT+4w/HEO3JPChhVvFAsR
 ABrLxV1owVKWpOKmG5Sny0ZxCD1xLX2JRB8eo25feXV+Ck4phFCCiXf6BC8vA+1wgZGzoB0Vm
 VdrANt9HsEv+eHRnNm2AnB074bjtIUOKLO+9cWUcjNv8sttC4FeV2wlMnUhPzi9jLv6jgkFzm
 2KwS8b6UADwTnFHb95yoSloB7Mmp66vn1FUp8QWsw/c4zL9JOvcayP7+oU61Ek6chkNvbLS3l
 kab42qwroRsElxxN33PlHzct62Do/j0JUtUGYojV1EIJMsFDgSPSa9877rVswEmZzUQniNNmc
 OZs8GtfwHrhWmXa2FNPGwxj85shqDbk592OF/kTtuY2zpaOT3PvDyP4qqjJSfQ3ACpjxNhDik
 aof21yW5oOBLuHw5lcUBDHrFxveiz7UaHGrmgKAs4oK8hKAEnXAI3JrT9oInv5Ouk0DU6fL+6
 H+SiN3GSiS7iOW8CEOcXZp1/ew9Wg/p0bq/6W1NXxLSO3sEuQn0XDBjFcy/3NPirUUnXmwni4
 Mp/R6XZOjkYeHP2TLo3pt9j9oLSbX0cpHzKi4uCkKCdph1bQ2lpnL1BLvpk/poze5NQh0xe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-888637613-1522159055=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Tue, 27 Mar 2018, SZEDER G=C3=A1bor wrote:

> On Tue, Mar 27, 2018 at 12:14 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > However, it seems that something is off, as
> > ba5bec9589e9eefe2446044657963e25b7c8d88e is reported as fine on Windows=
:
> > https://travis-ci.org/git/git/jobs/358260023 (while there is clearly a =
red
> > X next to that commit in
> > https://github.com/git/git/commits/ba5bec9589e9eefe2446044657963e25b7c8=
d88e,
> > that X is due to a hiccup on macOS).
> >
> > It seems that the good-trees feature for Travis does not quite work as
> > intended. G=C3=A1bor?
>=20
> AFAICT it works as expected.
>=20
> When a build job encounters a commit with a tree that has previously
> been built and tested successfully, then first it says so, like this:
>=20
>   https://travis-ci.org/szeder/git/jobs/347295038#L635

But what if it has not been built successfully (as was the case here)?
This very commit that is "succeeding" on Travis fails to compile on
Windows.

> and then skips the rest of the build job (see the 'exit 0' a few lines
> later).
>=20
> In case of this Windows build job we haven't seen this tree yet:
>=20
>   https://travis-ci.org/git/git/jobs/358260023#L467
>=20
> so the build job continues as usual (see the 'test -z Windows' two lines
> later).
>=20
> Unfortunately, I have no idea about how the rest of the Windows build
> job is supposed to work...

Maybe Travis timed out waiting for the result, and marked it as a success?

Ciao,
Dscho
--8323329-888637613-1522159055=:77--
