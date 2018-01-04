Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A4F1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 17:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeADRfn (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 12:35:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:55320 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752036AbeADRfl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 12:35:41 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MY7dI-1eSfII1pi4-00UofB; Thu, 04
 Jan 2018 18:35:30 +0100
Date:   Thu, 4 Jan 2018 18:35:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com
Subject: Re: [PATCH 2/2] Windows: stop supplying BLK_SHA1=YesPlease by
 default
In-Reply-To: <87k1x7q800.fsf@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1801041833410.31@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20171227230038.14386-1-avarab@gmail.com> <20171227230038.14386-3-avarab@gmail.com> <20171227234237.GC181628@aiede.mtv.corp.google.com> <87k1x7q800.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1482691442-1515087331=:31"
X-Provags-ID: V03:K0:Hvu62ZyqwLq26tULkKuYpX4GiE00YX8z3e9FlhPI0gqHDz1sxvn
 zMO4PJsJ02v60G/UJQS4+AExYmwSfYDZLDXiOm6zjjoa47e7da2bv9wMHZ8VUIxi+1f0SZ2
 RkTb1jvnvjFI6B1QSWwq5WzJZdzjzNYef0wl1zMkFjIFq+qoZnfh+mdMOZ0Hvh76JtBMQ7Z
 xEaY5ovxWXOOP1Vej4tIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W7wZR/Q2iRs=:pL7OuQvlPTg9Tbs7xgnZY2
 V9C8QyWtmLo8RaaftF3ThVVv66r8HdGsz1cEnQZ9UawwwWKD6f4JZhKpU9dprf/OQFR4gaBQa
 Ns3C020TyMA3zORUKHkccFBud6GJFHnta3MNK+QmiC4TsLrE7begwciqeIhJhFjORLlk0Cm0p
 BF3zA1SVSV4q7m52xN10uAcyE0O8voRZ4aAgq+AFJy2DKfCTIg5EfMj3Ze9uf1B+mOV8JWT9r
 /2upUQ89ckJIAy4GKi3BlgbszwjDQjCSVyaOpfPwB3jCp7JLmf9aczeTOz8+qe5Xe2FcbFXdj
 sMZk+28zXeBxs4WcTjt5I53/kAH6TSBFr1inwpiLks1LJlCCRy+krxAVNb8P+6Z5ImrPy/7fu
 gHlBdr8khnsnQFwq41bG/JGGW6tzPyAs2EOOxMjdUg20dTDM90DNj8HfWVYNYaeEN2zrhQvaM
 31ieq8Bcbh+YwyhKfBw23q+mTTM+cbjW8v+lrjezlCAqDtE6df2GW/mFYyWbwUbNr6lSph8WH
 5Zu2gri0SqOQpjg/82InmQ2WdOUYBvDAivhGR4BHzDP072RNSPrwgCC9GmdRpZPD3RkxLvFDV
 e2uRZyFU4YN/tVhD3K49/TjuWzFLwNnn5FxSVLHF/HRMkHaiAC3VnYKc/oa32vB3acLmVrhdb
 l+/ST+N4ZMr2hWBBSy2B8vEZdoKJG/aeKgLbliGsLDEUIHc+jXs9jYoRWiJRfncVQa2VxuDMr
 fGa/eh+6XUypyLhelKGjKz+FVD3Z65+AiZBGDF7FGQcZ3DB7exQYbfSol2zW4eGOVNzZuLkfi
 Q1EJ/NJURoxljsQcNMaJ9HEP891HpxXAwUtOpU/z12joqHRdKnNU/veGZTEd3xz47QirynH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1482691442-1515087331=:31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 28 Dec 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Dec 27 2017, Jonathan Nieder jotted:
>=20
> > +git-for-windows
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> Using BLK_SHA1 in lieu of the OpenSSL routines was done in [1], but
> >> since DC_SHA1 is now the default for git in general it makes sense for
> >> Windows to use that too, this looks like something that was missed
> >> back in [2].
> >>
> >> As noted in [3] OpenSSL has a performance benefit compared to BLK_SHA1
> >> on MinGW, so perhaps that and the Windows default should be changed
> >> around again, but that's a topic for another series, it seems clear
> >> that this specific flag is nobody's explicit intention.
> >
> > I have some memory of performance issues on Windows when DC_SHA1 was
> > introduced leading to interest in a mixed configuration with DC_SHA1
> > only being used where it is security sensitive (e.g. for object naming
> > but not for packfile trailers).
> >
> > Did anything come of that?
>=20
> This was Johannes Schindelin (CC'd) on-list when the sha1dc discussion
> first came up earlier this year. I.e. it's slower, so we could use
> openssl on trusted data and sha1dc on untrusted data, but nothing came
> of that.

The performance degradation is noticeable, as far as I can see. And no, we
have not yet worked on the hyprid SHA-1-DC solution, as we expect bigger
benefits from trying to avoid unnecessary SHA-1 calculation to begin with
(read: we will try to catch bigger fish first).

All of this may also become moot if we ever get off the ground with
SHA-256 (or whatever we will use then).

Ciao,
Dscho
--8323329-1482691442-1515087331=:31--
