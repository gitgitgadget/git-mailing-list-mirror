Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078CA1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 10:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeGZLV2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 07:21:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:46917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbeGZLV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 07:21:28 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWCKz-1fT2Cm0gqv-00XKRq; Thu, 26
 Jul 2018 12:05:05 +0200
Date:   Thu, 26 Jul 2018 12:05:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Deplagne <Eric@Deplagne.name>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
In-Reply-To: <20180722145506.GL11431@mail.eric.deplagne.name>
Message-ID: <nycvar.QRO.7.76.6.1807261157560.71@tvgsbejvaqbjf.bet>
References: <20180609205628.GB38834@genre.crustytoothpaste.net> <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com> <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net> <20180722093442.GK11431@mail.eric.deplagne.name> <20180722142148.GH18502@genre.crustytoothpaste.net> <20180722145506.GL11431@mail.eric.deplagne.name>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-67212671-1532599505=:71"
X-Provags-ID: V03:K1:JgdJ/xIXrGXM68MVar5XudK+nqB2fsrvs7zcmIyIO9MX8EbASWQ
 8Pr0//kha7DplHfGF8iwbYhjS2mWpivHS9BGP5GovZzi9dviHB6MXeWvBaFcY6YEQXfbL6e
 APkqqD1vcDspEOLK7Pr3xVaB3x5JyXkffhMjgCQ6pZ5DVN0caCqm7XEb2rqsl5BpR50df37
 DogodUdLetoMyYxCRb3xQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ls9KYJJTjSs=:Hu3BJ4p4KtGEW//cG0esqe
 dNgkiPsUoj9JjLSxP+RKgoYYPSx5EQLLpHVSiX9nkuIh6vNDhgw6dGeuMaWSegqfvNp4DAf0f
 rrD9dlrv7Cg7gpD0+LUKCIJYHrht3zLTCwamvxg1NfmHtTiYEUuZOJJiKbH45OmalTyiqCgVt
 gGY2awEf3e390M9piWVP2TO9MSdyLbA0IFpVpxmojJyj3AuspKoVMAt40ItVPAI8Bl1EWPoX/
 wDNDn+swBs0uUqtRzxFaopCm0NWHkRhEgO4yqOLsN2jk/8hSA8iqEs2Po3JqkTdLc+WQUEqNo
 z8SVnp1IJXgyqlG+pMpl31PCEtRS+9iNY3FT4vg2wTYZVmm0dIcPa56Uce0K32YrtDOD67Zfx
 seqOW5KU/k1yce7MhTWI+/3XnOt7lkWEkkOUeDY+293DyIPaZSg0bXxecuA1Cqgl0XH1AovbI
 agXBiTGi6OdIRMhQW2/yczMa0u/irYMYOljuigltLsSp2AVaZqxoJbFNpW5LvwR29wu5SuUWJ
 gYuYaTQmapRWqyGsFJbtPivZo8PCg2ExtDR/Ud5qHlv9gQiYdylJbOudrD+X7pbVwkedwR44r
 EL8MuNqV3UIekCHMOjlZFNTrc/4vCK4jPsJjd1mBf62MnVhH1s2zH5jDYsBE12jdjRnDJ1OfI
 wSvxbmOhXJn1Cm41lkCRHAuM/oTqW8W2jMXmyMJV7iSL7KnzmQw3jkXCq6nNWMstwsmvxehVi
 e24TYp+WpdeQa2Sc+Ko3dHzH0Nye/7zW00t5HISMkq2eJhbIyx8pRw1jKseu662lBSAtIaiL9
 AqDNK17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-67212671-1532599505=:71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Eric,

On Sun, 22 Jul 2018, Eric Deplagne wrote:

> On Sun, 22 Jul 2018 14:21:48 +0000, brian m. carlson wrote:
> > On Sun, Jul 22, 2018 at 11:34:42AM +0200, Eric Deplagne wrote:
> > > On Sat, 21 Jul 2018 23:59:41 +0000, brian m. carlson wrote:
> > > > I don't know your colleagues, and they haven't commented here.  One
> > > > person that has commented here is Adam Langley.  It is my impressio=
n
> > > > (and anyone is free to correct me if I'm incorrect) that he is inde=
ed a
> > > > cryptographer.  To quote him[0]:
> > > >=20
> > > >   I think this group can safely assume that SHA-256, SHA-512, BLAKE=
2,
> > > >   K12, etc are all secure to the extent that I don't believe that m=
aking
> > > >   comparisons between them on that axis is meaningful. Thus I think=
 the
> > > >   question is primarily concerned with performance and implementati=
on
> > > >   availability.
> > > >=20
> > > >   [=E2=80=A6]
> > > >=20
> > > >   So, overall, none of these choices should obviously be excluded. =
The
> > > >   considerations at this point are not cryptographic and the tradeo=
ff
> > > >   between implementation ease and performance is one that the git
> > > >   community would have to make.
> > >=20
> > >   Am I completely out of the game, or the statement that
> > >     "the considerations at this point are not cryptographic"
> > >   is just the wrongest ?
> > >=20
> > >   I mean, if that was true, would we not be sticking to SHA1 ?
> >=20
> > I snipped a portion of the context, but AGL was referring to the
> > considerations involved in choosing from the proposed ones for NewHash.
> > In context, he meant that the candidates for NewHash =E2=80=9Care all s=
ecure=E2=80=9D
> > and are therefore a better choice than SHA-1.
>=20
>   Maybe a little bit sensitive, but I really did read
>     "we don't care if it's weak or strong, that's not the matter".

Thank you for your concern. I agree that we need to be careful in
considering the security implications. We made that mistake before (IIRC
there was a cryptographer who was essentially shouted off the list when he
suggested *not* to hard-code SHA-1), and we should absolutely refrain from
making that same mistake again.

> > I think we can all agree that SHA-1 is weak and should be replaced.

Indeed.

So at this point, we already excluded pretty much all the unsafe options
(although it does concern me that BLAKE2b has been weakened purposefully,
I understand the reasoning, but still).

Which means that by now, considering the security implications of the
cipher is no longer a criterion that helps us whittle down the candidates
further.

So from my point of view, there are two criterions that can help us
further:

- Which cipher is the least likely to be broken (or just weakened by new
  attacks)?

- As energy considerations not only ecologically inspired, but also in
  terms of money for elecricity: which cipher is most likely to get decent
  hardware support any time soon?

Even if my original degree (prime number theory) is closer to
cryptanalysis than pretty much all other prolific core Git contributors, I
do not want you to trust *my* word on answering those questions.

Therefore, I will ask my colleagues to enter the hornet's nest that is
this mailing list.

Ciao,
Dscho
--8323328-67212671-1532599505=:71--
