Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C7D921841
	for <e@80x24.org>; Tue,  1 May 2018 11:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbeEALbS (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:31:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:55487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753717AbeEALbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:31:16 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lf0M7-1eZm2w1xmx-00qmVe; Tue, 01
 May 2018 13:31:13 +0200
Date:   Tue, 1 May 2018 13:31:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tiago Botelho <tiago@gitlab.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
In-Reply-To: <CAF2GuqvTvPPfGPXCwhBkTHJvRQcV1w9VebHkn+Kqw6dZ2b0xKQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805011330510.79@tvgsbejvaqbjf.bet>
References: <20180411225534.48658-1-haraldnordgren@gmail.com> <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com> <CAHwyqnVg83xSQHRnDVz+aMxPPMj-3bWF4P8YUxEjurxnpDhFEQ@mail.gmail.com> <CAP8UFD3j-MGY7jHQK52zVLYMB=1vhCSFKxrvQ1JsRW-Rmnn8Qg@mail.gmail.com>
 <CAF2Guqum5dak4us_HJtiW_gL0xgsihgUpidFEJzBgw-tEMunkQ@mail.gmail.com> <nycvar.QRO.7.76.6.1804121341590.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAF2GuqtooOo0P3nGXNEEu=j2XSuNZ2KRwEOAz82mMC3t3v7bXQ@mail.gmail.com> <nycvar.QRO.7.76.6.1804301330230.79@tvgsbejvaqbjf.bet>
 <CAF2GuqvTvPPfGPXCwhBkTHJvRQcV1w9VebHkn+Kqw6dZ2b0xKQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-977641785-1525174275=:79"
X-Provags-ID: V03:K1:M2RAsWjfz2rjhs5HMpGCny8XBnIVi8ucqKJA2mud7OUnzsLOkVT
 /RlHt3yrhIAhH12WbIzJi/sMcO0wfIOs0MC8yE10YlYvBjBj00QXpLdEHJM3gYvqRPz3Uy4
 cQzqhT6497bXJJkftiE2HgCAChub+JFoN0G35/giUI4OVD7Wkct8m2lF/S0NXvusmmRW7kN
 dUm2mFoeUh+gowAC7F8wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0XgOL8uAhWE=:P5NE8smjodVpFHQxHn4yV5
 ZUhfxHsQjhBK3XFAv15OQ3hEfCIEIh7k9c52Ii+BwWnpiG6xUcU+iO/wUJVbs/JeRDE9LhJsQ
 nznWPgVd+ZmeE2WO9KZCTSGNkDhCTkzxtJFRZNbjNC4QjjycuSB1Tv18CCPKpI4MWTAOBkCuS
 GaYVMWmOxO4euD8AfdaPIR5slnw1HKwyOZGC4anNBoXtISOpdVRQ210VQmrM+r+4B6IS2wyZ1
 5Ts0AZ0mlhhOrYra/VSGuNldRIOzYUtg+lap70rLC5B4k/18tNXAMqIJhbZyyF/cQuOR1xygW
 aaGt7rwsBdN1yH3dJuwZffi1g7GFObcyEcq3RynpUpbbAjb+1JJi2c6N5Dqn+FlVbMTiHRzlx
 YuFuMaGHJC7FqoC2WUlMne9PlIMsRgcZcX8E2Z3tcH2RCtyt8kMi+kjUXL451VQhjRr/qL6r4
 oDg7xjlT1cQSonUiSWzpmhOEYS2uuwXV3uIg5DN3ngcrX84GuaPXko0GxVB+Wi5FyBEW+xxyS
 MheB7KUDxha4UxuHjEf6gY2rYbPMP88y7H1UtGHmmNs5jorJHNZGEmRt0lfzgk7tQKnZkfoFD
 3RYqXMS+zQx3+NP22IQZZVsw5iY2MLdTOOezj6k6DbRxzTCvtC5cHzC/q8zNKJiQycIs9Eg7X
 +ruz5n0yIYNczfm12TJ18tsppQnflzgXfhku9La/tuP+Eo/5XwVFb+AxI2I0q5XbRJThC9/Wd
 glivUapihuTijINVrUIiMgZGqZUiXqMz8dgZ/YNt+Noyyj3SY73SaB5jCiRM/DEflaZ0hdfLm
 zILYNKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-977641785-1525174275=:79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tiago,

On Mon, 30 Apr 2018, Tiago Botelho wrote:

> On Mon, Apr 30, 2018 at 12:31 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >> > On Thu, 12 Apr 2018, Tiago Botelho wrote:
> >> >
> >> >> On Thu, Apr 12, 2018 at 9:58 AM, Christian Couder
> >> >> <christian.couder@gmail.com> wrote:
> >> >> > On Thu, Apr 12, 2018 at 9:49 AM, Harald Nordgren
> >> >> > <haraldnordgren@gmail.com> wrote:
> >> >> >> I think it looks similar. But if I'm reading that thread correct=
ly
> >> >> >> then there was never a patch created, right?
> >> >> >
> >> >> > (It is customary on this mailing list to reply after the sentence=
s we
> >> >> > reply to. We don't "top post".)
> >> >> >
> >> >> > On the GSoC idea pages (like https://git.github.io/SoC-2018-Ideas=
/) we
> >> >> > have been suggesting "Implement git bisect --first-parent" and th=
ere
> >> >> > are the following related links:
> >> >> >
> >> >> > https://public-inbox.org/git/20150304053333.GA9584@peff.net/
> >> >> > https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/
> >> >> >
> >> >> > Tiago in Cc also tried at a recent London hackathon to implement =
it
> >> >> > and came up with the following:
> >> >> >
> >> >> > https://github.com/tiagonbotelho/git/pull/1/files
> >> >> >
> >> >> > I tried to help him by reworking his commit in the following bran=
ch:
> >> >> >
> >> >> > https://github.com/chriscool/git/commits/myfirstparent
> >> >>
> >> >> Thank you for the cc Christian, I=E2=80=99ve been quite busy and wa=
s not able
> >> >> to work on the PR for quite some time.
> >> >>
> >> >> I intended to pick it back up again next week. If it is ok with
> >> >> Harald I would love to finish the PR that I started, since it is
> >> >> quite close to being finished (I think it was just specs missing if=
 I
> >> >> am not mistaken).
> >
> > It is now well after "next week". Are there any news? Or could you unbl=
ock
> > Harald by stating that you won't come back to it any time soon (in
> > particular since the PR is not quite as finished from my reading as you
> > made it sound...)?
> >
> > Ciao,
> > Johannes
>=20
> I've been working on the feature for the past week
> https://github.com/tiagonbotelho/git/commit/709e2e248ebfb1deab12fd7d3da46=
11002dfaf86#diff-118df990fd68a0929bca5441fea06fc7
>=20
> I have some comments sent by Christian I plan on fixing this week

Okay, great! I was concerned because of the long silence.

Ciao,
Johannes
--8323328-977641785-1525174275=:79--
