Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0CF61FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 10:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbdFOKiy (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 06:38:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:60140 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdFOKix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 06:38:53 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjZn2-1dwzqn2ua0-00bbpQ; Thu, 15
 Jun 2017 12:38:45 +0200
Date:   Thu, 15 Jun 2017 12:38:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests
 for console output
In-Reply-To: <CACBZZX7JRA2niwt9wsGAxnzS+gWS8hTUgzWm8NaY1gs87o8xVQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706151235480.4200@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net> <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox> <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com> <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox> <20170602175455.GA30988@aiede.mtv.corp.google.com> <CACBZZX7JRA2niwt9wsGAxnzS+gWS8hTUgzWm8NaY1gs87o8xVQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-649084676-1497523125=:4200"
X-Provags-ID: V03:K0:cG8bQ0sme2ny5kjlW6Km1s5/0cpN4r93RGOPjzBB7BBbRsg9KFY
 St/JbD2Z3Ta08pf7Z0F+20eomEa1JQ7zrzOvq9htcbeQNezpjR6ongfcAM0y8hY7lYDxZus
 9QsyS0rIglij2GcTzR6HUxo59hOiGScCENTjsz54anX+otlB1OTWjiYjt+OsqoCMdXWQkL0
 bKL4IrTfrlSEkPva6Baew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:442uJBO4REg=:y1by2P/jtqKdl7RmR6Lszh
 VMH8y1iC/uZI37urafonP7cl2A8Zh0/viOzrpjgu6ChgMVVMAd75q4GYhe3FY5PyfIvDzPaNp
 TRJnuDgm//es0LmNiINuKXW3h5fUlyXLMRRQBcZV5mld0kR6JsJeXInNcOVO17pofHP3Ybpt7
 nwwMl0PRKNe6aaQi1oZG0RWVlLz+V9/nf/ojqjF1Kbjr8Kms8I9248mN4wHlDSXiq+gxOlEiW
 erTsdkiH0JyDkFACG/NuZ/9cyUw5dhPlCo9C2L4gTcXYq3wTf9LjeTmGZ8DiLbAcBQtl1+IVr
 pF8V9yrOADNnxu0zuVA5E9a7zmXJDIHBU6ZoVLCYXtHVvnooicCMMid3N69ISm8GTmLlh2vOX
 0ytTQHPKIphldy/uL23DhZSb3fYauPOJR6TyfVMp/O7n0j2C+vkJvHuzs3jE+qgwY2grGNT+5
 ckM/6wq8veFiq4yxvXMiWPH/988DFLS6HLuM9zCMafD5i4wv3L6qsj1ybVk1GzoxZEoT6mX1E
 7gT6hpElRaBu75F64/BeqhWnWcjxPQyQ3oXRMQ5mhZ/KTDsFGPEdu1tJ+0ydfBFjYG6E3dBfS
 MtGOppt/bZ1timW5lRRpl7/94mZP7FRpM75lp+5s2JpL6rNpdvLZbL3nE3LDfWlJU2JQBR+Nc
 fWYOSaH2cDH/3+NN7MlCGatTUEhsN5fRXeIM5yKHnxadectOFrCcP1msejcr83TzNAm37SNEw
 aqSjp6DDu6wdNDkPudN/IVcW/SqhmNpH9kgsndZn90Cn9XCZIpzomUXARi9jnVUqdfkDXPHDx
 oLvYBQh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-649084676-1497523125=:4200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Fri, 2 Jun 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Jun 2, 2017 at 7:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> >
> > Johannes Schindelin wrote:
> >> On Thu, 1 Jun 2017, Stefan Beller wrote:
> >
> >>> We had a discussion off list how much of the test suite is in bad
> >>> shape, and "$ git grep ^index" points out a lot of places as well.
> >>
> >> Maybe we should call out a specific month (or even a longer period)
> >> during which we try to push toward that new hash function, and focus
> >> more on those tasks (and on critical bug fixes, if any) than anything
> >> else.
> >
> > Thanks for offering. ;-)
> >
> > Here's a rough list of some useful tasks, in no particular order:
> >
> > 1. bc/object-id: This patch series continues, eliminating assumptions
> >    about the size of object ids by encapsulating them in a struct.
> >    One straightforward way to find code that still needs to be
> >    converted is to grep for "sha" --- often the conversion patches
> >    change function and variable names to refer to oid_ where they used
> >    to use sha1_, making the stragglers easier to spot.
> >
> > 2. Hard-coded object ids in tests: As Stefan hinted, many tests beyond
> >    t00* make assumptions about the exact values of object ids.  That's
> >    bad for maintainability for other reasons beyond the hash function
> >    transition, too.
> >
> >    It should be possible to suss them out by patching git's sha1
> >    routine to use the ones-complement of sha1 (~sha1) instead and
> >    seeing which tests fail.
>=20
> I just hacked this up locally.

Would you mind turning that into a patch? I figure this could be a
compile-time switch and applied to Git's `master` so that it is easier to
find those assumptions, as well as verify fixes on multiple platforms.

> > 4. When choosing a hash function, people may argue about performance.
> >    It would be useful for run some benchmarks for git (running
> >    the test suite, t/perf tests, etc) using a variety of hash
> >    functions as input to such a discussion.
>=20
> To the extent that such benchmarks matter, it seems prudent to heavily
> weigh them in favor of whatever seems to be likely to be the more
> common hash function going forward, since those are likely to get
> faster through future hardware acceleration.

Exactly.

As I just mentioned elsewhere, the cryptographers I talked to expect
SHA-256 and SHA3-256 to see the most focus of all hash functions, by far.

> E.g. Intel announced Goldmont last year which according to one SHA-1
> implementation improved from 9.5 cycles per byte to 2.7 cpb[1]. They
> only have acceleration for SHA-1 and SHA-256[2]
>=20
> 1. https://github.com/weidai11/cryptopp/issues/139#issuecomment-264283385
>=20
> 2. https://en.wikipedia.org/wiki/Goldmont

Thanks for digging that up! Very valuable information.

Ciao,
Dscho
--8323329-649084676-1497523125=:4200--
