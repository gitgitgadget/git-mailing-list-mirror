Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15438C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E102A207FB
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TYKoJGhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgERTKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:10:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:35447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgERTKT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589829014;
        bh=xp9VA8CxUL9LlNvhkKhTbSNI7IqXxTQJ8uAvKTdPBCQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TYKoJGhyVOZm0wbNu9R6JIFnaIYgDavtSKsal+m2BQWu/X6laYMEkemzIe7daEyGz
         KxVVToWKIHUb+xnCvbIAVL26hlB7u10alONPQ32YGJAZZLyVvI2ZDKNgyBdqintiBw
         A6JiJyBsKNNGXOTjTajjdht7tMah1A7Y65/D/vDI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.131.160] ([213.196.212.243]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1jAo082sac-00jsrR; Mon, 18
 May 2020 21:10:14 +0200
Date:   Mon, 18 May 2020 05:04:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bryan Turner <bturner@atlassian.com>
cc:     Git Users <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.27.0-rc0
In-Reply-To: <CAGyf7-Fkn2uHLCqM-4qfM0YQAXoMgiMwKEaxkGkOtz=pYYKQWg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005180503440.55@tvgsbejvaqbjf.bet>
References: <20200515173242.6154-1-johannes.schindelin@gmx.de> <CAGyf7-HbnCip8WZ9vtc_KW1kXMBUoPZQ8GD7H=1DOAk45Wbjxw@mail.gmail.com> <nycvar.QRO.7.76.6.2005161044580.55@tvgsbejvaqbjf.bet> <CAGyf7-Fkn2uHLCqM-4qfM0YQAXoMgiMwKEaxkGkOtz=pYYKQWg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1078183777-1589771061=:55"
X-Provags-ID: V03:K1:G+tU2J0uhwE7ofwr7gK4IPBxa1ziCCW8OzRWhe9HObuJ6XxeiUv
 B3sQEacWa8KVEpTFzFIYaUM3vxQnbTZMbl1kTgCNmDc12dCWnK5JmkG328WDfeneZ74Dwoo
 yvcDp4rnOfTAJus8bf6FEwhH3KJeyaJbpkfoxo+mhXQ9cCUg0yxmHgmHQZ9vgvckk9inrW1
 3d30ON5F15pD8RZhmjcCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8qsvrUkSluw=:luLnXua/LS47CHfPoXHlgb
 gJUK4COJKvqLRUihCnF5nbfzNoxsSGLUtYcwlMJExG8+neVVJ6Szr/PMouukGqz5OPusRzckO
 xQtmE3zYA16OyuR6vBI1yEmbWekWnNne/LeOfnyZ4lFRXQs0+RcV9jedSRf91tyJkOtCh8bjq
 JHwA0rH93dGr1to6riLM00tpQToedJ5GhcBhvuFDFAUElsabAayIyFHA8TX0Fdz6SdcR3xzG7
 fmfhx0+SIgXeH5lZAwAajQOOTaVsU+BqGZ0tIngkJBaUSNnZQR3/DK3JPMxYfsc4xAcHvSznd
 M0QxuZf5bVVV8Js2940pZxscmHglWSJ/9EEAg8NrBTCWUrBEInUrl2wbjCuqe69J2fxS0Vx7F
 zUaCsJ4qaZvlEBBMfhETeZgVBtJswrphXlxYruC7IhDwhlh297s15ygt9HUy1svaOmejY4Zge
 8qnbmIXs5QiXChUvo8A5gzl13hC6ySi2e/79KVM3IJapr5F4z8wmnTMlOCd2TPQY5J6x38qeO
 qb/1v/hAl8J3059/PmFNSJywSQRb2mmj8RBMZErEIdhZfOGvjJ+iSv/Rk6oLcFxlZ8a5DCAiw
 746thICaFIA4hMzcSZxPJXXIK5lIdKOEzJJIEsYuxlprUOmMQHKFUUjzzqX6gCTbLJYea6myq
 PVRv+57FpfCoiNlRqxyOAbHWV/Qz1uupZnlBbD6wxUy2gncvjcqbqiP51/hZknCjxfM0Kaax6
 St68pY4vvJ7UFZdgMeZ+nggJ62Kj4uB/0/OvMXZzPn8H7IltY1KwzPiWKOCdcWokMF8cliCw7
 Uga5ADZ8QUtCnrfCHnTSyjfNzTvo8EUqWJ+tzfSwYHt1RRipREzE6NwbSUwMHQNuadsSgAcn/
 blPn7ABT+MD+yhJGp2+witC+VZA+NfygS9gWtUdnFciU6psir9tp8z6TBCB6N7KlNFJHqdDYr
 Nx1HStsLf34/wi0omrI9jKcGdfJC3Nh/U/YwJOf7iKJVbZsjM5yHHREvyaejsI/LIYDAx90fp
 FC9gPpEKVEoi2wkC6YxZInfDkWvXmttgkXCq25oITawP4bbRr3+1JeSe+fynBl/wBw0TcM2rh
 IDG65IG79zzB8kKQphd+OAhv+j0r/iXWxqymHBghE48v/AhtZ3zUe2i6Z0npl7gB2iM2y0XdS
 JMbU/9TbAYzt5J1WjZZEsYXU5SWZvPfoVMfO1JWuvYgOdYQrqlWSSlRKRsI+B/kSMJbvyScCx
 GbliPkErlP3jDEuJS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1078183777-1589771061=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bryan,

On Sat, 16 May 2020, Bryan Turner wrote:

> On Sat, May 16, 2020 at 7:10 AM Johannes Schindelin <
> Johannes.Schindelin@gmx.de> wrote:
>
> > Hi Bryan,
> >
> > On Fri, 15 May 2020, Bryan Turner wrote:
> >
> > > On Fri, May 15, 2020 at 10:32 AM Johannes Schindelin
> > > <johannes.schindelin@gmx.de> wrote:
> > > >
> > > > Dear Git users,
> > > >
> > > > I hereby announce that Git for Windows 2.27.0-rc0 is available fro=
m:
> > > >
> > > >
> > https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc0.window=
s.1
> > >
> > > I've added the 2.27.0-rc0 release candidates for Git and Git for
> > > Windows to Bitbucket Server's test matrix. No failures to report.
> > >
> > > Thanks as always for these early release candidates!
> >
> > Thank you so much!
> >
> > To be honest, this time round I would _really_ like to ask for some ma=
nual
> > testing. I upgraded the MSYS2 runtime from being based on Cygwin v3.0.=
7 to
> > v3.1.4, and the biggest new feature is support for those new-fangled
> > pseudo terminals that Windows 10 now supports. I did find a couple of
> > rough edges in my use cases, but I am not exactly a typical Git for
> > Windows user...
> >
> > Could I ask for some manual testing in particular of anything run insi=
de
> > the Git Bash?
>
>
> I=E2=80=99m happy to set it up and use it as my daily driver on one of m=
y
> workstations, but I don=E2=80=99t want to overpromise how much help I ca=
n really
> offer for that sort of testing. I don=E2=80=99t do much of my full-time =
development
> on Windows anymore for a variety of reasons, so even if I install it in =
my
> Windows machines I won=E2=80=99t get that much active use in. And when I=
 do use
> Windows, I keep my workflow pretty simple, so aside from basic adds and
> commits with an occasional checkout or very rare rebase, I just don=E2=
=80=99t cover
> that much functionality.
>
> Sorry I can=E2=80=99t offer much when it comes to end user style testing=
, Dscho.

Oh, please don't apologize. I appreciate all your help!

Ciao,
Dscho

--8323328-1078183777-1589771061=:55--
