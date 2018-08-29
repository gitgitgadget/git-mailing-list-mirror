Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D3D1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 13:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeH2RGM (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 13:06:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:51541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeH2RGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 13:06:12 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9vnQ-1g61lc3RSC-00B5bl; Wed, 29
 Aug 2018 15:09:08 +0200
Date:   Wed, 29 Aug 2018 15:09:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
In-Reply-To: <20180828171113.GA23314@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1808291458480.71@tvgsbejvaqbjf.bet>
References: <878t4xfaes.fsf@evledraar.gmail.com> <20180824014703.GE99542@aiede.svl.corp.google.com> <nycvar.QRO.7.76.6.1808281402510.73@tvgsbejvaqbjf.bet> <20180828171113.GA23314@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-24825337-1535548148=:71"
X-Provags-ID: V03:K1:nyAVUDk+BlzUyoyRtG3IArSEYFcP43F2/aqUYshxSDXfBb2ESxj
 R4u2whAq2/6HMGob6PC/rhjfDHYAo29hnG+TOjUHPXVW0z8PFx1katYEBaIFADi+Rw9SLb1
 f9+e78tCWhEgrEexz2HiaTQXKjHiXT2c3krFu9kmYr8oZucFrjh7Rf5bFUb74/7Bs0VD+2S
 20Qva1kPSTLrQm6tf7Ivg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/v4HSk4RnVo=:Y8Tb3Cxr9D+kVOJ4SMrP1J
 5hGKGULz2UwQsPbKCiZVvvfCaLH8oi0B9sZqAkCrhznZ9N2+7apk4GIwviS53aRLoLNQXXUmw
 ts+dU06CStREnYqa/8xx8pKxZ4umxGIScjsDiXZqwOrCJj7ZOgDfBH73J0aoPLfbACiXBHBAd
 j1p4A0Qp/Hb1+SfE/RMnXAG4SX5dRAjWBeAy24tIVDfIUR1EKShBnkOFLFAGZEoEZT+HZvO06
 8BNILBNlbwrX0x29L/7aCE8gcDaY7F73coaY0aOhzt1kErZ6DEqOp6Y++zZYYS+lcqslQ6DWG
 fG0TYcVrRYjpihuLd9T0VrgKBdVnae9mUe95SdfqT3Y4cTVyfswe6t6G0y5DBNIwLlKJb4htt
 1AFzZE43J+OhSJMgqwcz7JPvopzVn0WDeJyAn1omkeVf2Tav3/QaJQBMt5pOgPpewQTW6FO+f
 amKTUZy6uFQ3s2BsmsolbilI/oDzfhKx28QoMeMCBTDXpdMYtaya/nI1QBP4TGtu0OMh+22XE
 Q5QhcPTeXFU16cc/5VpfAoF+SAeYgm8z0WIoUtDEImSbtGMxxZowpTsQSYOeuMmWKH6vcr9WC
 3jeYBfaiATVdU3EnSOTiaS45SiDkKzgV28t2pIBtT/aOKpQVQ9XlgNBDykzs4vFYlT/C/KIQV
 R9l+1vQ264Re1cCbBDH4VNSvZl6Fkn5iG49uv6kqrCsgjiYIpDDQAM+v+/0LGdMvX5I6qpTkk
 3ZQBAal+az1HyCNYrf75rQolA4aHtpVj5YcWvLRfJd83dFMFFBMrukWU7U6xvf2BMhNQ8wLck
 1Ec+qUa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-24825337-1535548148=:71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jonathan,

On Tue, 28 Aug 2018, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Thu, 23 Aug 2018, Jonathan Nieder wrote:
> > > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> >>> Are we going to need a midx version of these mapping files? How does
> >>> midx fit into this picture? Perhaps it's too obscure to worry
> >>> about...
> >>
> >> That's a great question!  I think the simplest answer is to have a
> >> midx only for the primary object format and fall back to using
> >> ordinary idx files for the others.
> >>
> >> The midx format already has a field for hash function (thanks,
> >> Derrick!).
> >
> > Related: I wondered whether we could simply leverage the midx code for
> > the bidirectional SHA-1 <-> SHA-256 mapping, as it strikes me as very
> > similar in concept and challenges.
>=20
> Interesting: tell me more.
>=20
> My first instinct is to prefer the idx-based design that is already
> described in the design doc.  If we want to change that, we should
> have a motivating reason.
>=20
> Midx is designed to be optional and to not necessarily cover all
> objects, so it doesn't seem like a good fit.

Right.

What I meant was to leverage the midx code, not the .midx files.

My comment was motivated by my realizing that both the SHA-1 <-> SHA-256
mapping and the MIDX code have to look up (in a *fast* way) information
with hash values as keys. *And* this information is immutable. *And* the
amount of information should grow with new objects being added to the
database.

I know that Stolee performed a bit of performance testing regarding
different data structures to use in MIDX. We could benefit from that
testing by using not only the results from those tests, but also the code.

IIRC one of the insights was that packs are a natural structure that
can be used for the MIDX mapping, too (you could, for example, store the
SHA-1 <-> SHA-256 mapping *only* for objects inside packs, and re-generate
them on the fly for loose objects all the time).

Stolee can speak with much more competence and confidence about this,
though, whereas all of what I said above is me waving my hands quite
frantically.

Ciao,
Dscho
--8323328-24825337-1535548148=:71--
