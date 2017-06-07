Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192291FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 15:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbdFGPvA (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 11:51:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:56719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdFGPu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 11:50:58 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsChr-1e0Xcb2vCp-013uB2; Wed, 07
 Jun 2017 17:50:42 +0200
Date:   Wed, 7 Jun 2017 17:50:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 0/8] PCRE v2, PCRE v1 JIT, log -P & fixes
In-Reply-To: <xmqqshjfuv48.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706071749430.171564@virtualbox>
References: <20170601182056.31142-1-avarab@gmail.com> <xmqqbmq74773.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1706021803460.171564@virtualbox> <CACBZZX7yEs0U4LnULYMGM5CoDCACeh8DM=ONV+UmeM4EQsk7Sw@mail.gmail.com>
 <xmqqshjfuv48.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1190994942-1496850642=:171564"
X-Provags-ID: V03:K0:NXh66ZSt5EjB8Y24/rthv0NBzBykQ7nik3XbZOfcupoFeama7k+
 uqDtSTreqYta7ud1fOde0vQ0heQ94neyamcQx5F3ezV05K87sr1f3TXy9Ly+cGn6Fe3w3H9
 AhIRGnOQ0RoOTw3Hch4KLqo8E+X/cl+IzjEEZjqxkcYoJP0CYV3hlh6wHeENLbG+93Ywvrt
 gaq7Yi9ih3UL0tS8Cssig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NBYJxXhUhS4=:brEX6cFSl8K7G3NvSDm7mr
 65FXFG9Nn4n/0fLzCWHSRQKBE5gbFzYN5wovE9X5ljTJGSVRipX8b9OgpSGIYq1STkUNAyyh/
 r5UjdI4E097sYvwFAiWQsNYtFDVA7H+rpGbMAP0vzHBEQ7geWRMrrWmjy3mQE3i0ET9KIJwt0
 b7i/PaKFa8keDiFGi7GUJesLTzos0NMqKUEmBZ7mOT/9kdkmKMgwAfUTzQMWBZ31TU+yAR4Qm
 nzGPlZBEa5ixiHqzRM843Fk0pWW4kvBlUr8HIur+IuTAuMn6R76KK5fXrRjNvBV+2xD7kNq++
 foctDZ9DejZCv65qHnd3LW7XdCHecKX0kiX8t87NmOGrCB+ju+SpaJerC48TYs4cDTOwKr0oa
 h3ayXt6rOBr11vKgN8NoMCh8JO26w+piANkpawuqZsFdUT5/7nyH/75Cgp+1JcS2xopsMmCTV
 gLX/Uxi5QeZJTqPGGBvbsV/wsXLNrb56IZMF2PIK246FLkrg0X3D236W+Bjn8rFZ+wP9PleWv
 NfpgBBeAWao1EpEHcsWsLdfhBS9vIONehReLI5i/fsfEPFLKJQsJl/csytETb3iSXdc8cVQDI
 8G7Yxbbqnsx9cFWn0T1y//3Z4nd3bN/wNM78zu3hkFbJqD6vbJ4zaxTRrL9MUFSxTgfMAhG+X
 9XvlMU/If3D4gdUotXgrnh3LariHLKlhYEZIvUop0DR9JXbobKfAikZKegUghEUfmSwIxhKGi
 qaWqbhw2ealdFftzQFyyGL6HLhfzD4IzDSsnze7ZSN4ONVzUXIYFQBEDhPZbU0/76bhqOfX/s
 e5FitXI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1190994942-1496850642=:171564
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Mon, 5 Jun 2017, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > On Fri, Jun 2, 2017 at 6:10 PM, Johannes Schindelin
> >>
> >> Will continue with testing Git for Windows using PCRE2 next week and k=
eep
> >> you posted,
> >
> > Thanks a lot for testing it. Great to hear that it (definitely almost) =
works!
> >
> > If the grep tests it's very likely that all of them will pass, the
> > only tests I run when developing this series (outside of the full run
> > for list submission) are t[0-9]*grep*.sh t[0-9]*log*.sh tests, since
> > those are the only ones impacted by it.
>=20
> 'ab/pcre-v2' was marked for 'next' in "What's cookin" a few issues
> ago, but I'll keep it in 'pu' to wait for the above---please give me
> a go ahead when we all are happy with the topic.  I expect to be
> offline in the later part of this week, by the way.

It turns out that the entire test suite passes when I enable PCRE2. I will
try to make the packages available generally in Git for Windows' SDK
tomorrow.

Ciao,
Dscho
--8323329-1190994942-1496850642=:171564--
