Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7429320401
	for <e@80x24.org>; Thu, 15 Jun 2017 19:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdFOTf1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 15:35:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:57777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdFOTf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 15:35:26 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgHvY-1e8w3a1XgC-00njDo; Thu, 15
 Jun 2017 21:34:42 +0200
Date:   Thu, 15 Jun 2017 21:34:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
In-Reply-To: <87shj1ciy8.fsf@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net> <20170306182423.GB183239@google.com> <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
 <20170615110518.ordr43idf2jluips@glandium.org> <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net> <87shj1ciy8.fsf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-717168033-1497555282=:4200"
X-Provags-ID: V03:K0:AjLKUYtU+LwqzXaDBr5WTAwj30qbGMczouK0rQF3K+jx2d5y+Vp
 a95N3hY/0EPbzNjLCZuD3yqrwKKkII5fl0nFiljISk2/Dv0BEQwBw5inXoXPXruVoPGtrSW
 K16Tsh3J7mhCTts7bmX1btCB6cRerIs4kXoqBDi9EnXjwOEEEUyf8Eulppx9rWauuXEjCgk
 zjwvhuf/5YU7NtFHRxR2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fMSNfLuScBI=:UNnFpTzGO9ejY5bAQ/uqVt
 2w4OZp8sJaGLCXWdmXhfe+kmoh83G0U9GB3UCy9I6MPn3dsPuQDlF27Es/WmdZQQgFOUrJa2g
 6rlFD5Wad+WMFttDG3hJ6ImjPt7U5sa5v2RVz/9qjhU3k+LgolPuxHKzkzcRRHurc4bSmYMB+
 FCMZ0ZkB5oTTpmzcO2zUXdmYGw9R1qU2u5B+KIdzNbzgDQ+IFxM7JhKxdf1p0SuhnptG/XwDq
 VzN6i1/MBfZEs3eb2POTAoNGdIGFDsCu4RV+iZYsTFlPtdyYxJtrq9zItMj/pTD43CIKRJuDw
 pf1wnKa0D3n0DzvsyeemnhZQcUlS7r3FrSpx9JjeUS3ln7q7BUOOavp23jhrht4FhvNw+xnac
 IESia9kjtCHe3qRqW0H+npxxEwx/vM6I3gEViY8ZaFf6PIdHL1wULiN/TlE/QkIWzk++gZSlv
 UdG5B1DU1fEjKkiVsaaX/MXv6ZK+rE+C2Kil46uy21ArYpz27UkJOuCONL0FqxhmNCSI/lxKQ
 +ve2AZXFs5zdr+mQw2e6LoLdLFDVEDMXkZRC4D9496XTPNI/jIhuAGUUale9NG3GgtqD7Rw33
 ughwDWlQZI6XyADynlgDw4jTRSvoE4wmImbuGjqbmb0Ba4mpehflv8BGkn0VLfcH+WeYB+rGT
 /mEBA2K1zX068XST/nrjc6svmYgjvGisd+TrRjNNLNyjk3Gx6nsqwFzlfFlcc9rhNIU5A7pQq
 OuYptp8IsTgY/YV6+Aofy7ksdjGhvqkZOju/rYAU9/8Z8hPWNGTAL7xZjGvb03J1Orap7gDlG
 yV0dQHN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-717168033-1497555282=:4200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 15 Jun 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Jun 15 2017, Jeff King jotted:
>=20
> > On Thu, Jun 15, 2017 at 08:05:18PM +0900, Mike Hommey wrote:
> >
> >> On Thu, Jun 15, 2017 at 12:30:46PM +0200, Johannes Schindelin wrote:
> >>
> >> > Footnote *1*: SHA-256, as all hash functions whose output is
> >> > essentially the entire internal state, are susceptible to a
> >> > so-called "length extension attack", where the hash of a
> >> > secret+message can be used to generate the hash of
> >> > secret+message+piggyback without knowing the secret.  This is not
> >> > the case for Git: only visible data are hashed. The type of attacks
> >> > Git has to worry about is very different from the length extension
> >> > attacks, and it is highly unlikely that that weakness of SHA-256
> >> > leads to, say, a collision attack.
> >>
> >> What do the experts think or SHA512/256, which completely removes the
> >> concerns over length extension attack? (which I'd argue is better than
> >> sweeping them under the carpet)
> >
> > I don't think it's sweeping them under the carpet. Git does not use the
> > hash as a MAC, so length extension attacks aren't a thing (and even if
> > we later wanted to use the same algorithm as a MAC, the HMAC
> > construction is a well-studied technique for dealing with it).

I really tried to drive that point home, as it had been made very clear to
me that the length extension attack is something that Git need not concern
itself.

The length extension attack *only* comes into play when there are secrets
that are hashed. In that case, one would not want others to be able to
produce a valid hash *without* knowing the secrets. And SHA-256 allows to
"reconstruct" the internal state (which is the hash value) in order to
continue at any point, i.e. if the hash for secret+message is known, it is
easy to calculate the hash for secret+message+addition, without knowing
the secret at all.

That is exactly *not* the case with Git. In Git, what we want to hash is
known in its entirety. If the hash value were not identical to the
internal state, it would be easy enough to reconstruct, because *there are
no secrets*.

So please understand that even the direction that the length extension
attack takes is completely different than the direction any attack would
have to take that weakens SHA-256 for Git's purposes. As far as Git's
usage is concerned, SHA-256 has no known weaknesses.

It is *really, really, really* important to understand this before going
on to suggest another hash function such as SHA-512/256 (i.e. SHA-512
truncated to 256 bits), based only on that perceived weakness of SHA-256.

> > That said, SHA-512 is typically a little faster than SHA-256 on 64-bit
> > platforms. I don't know if that will change with the advent of
> > hardware instructions oriented towards SHA-256.
>=20
> Quoting my own
> CACBZZX7JRA2niwt9wsGAxnzS+gWS8hTUgzWm8NaY1gs87o8xVQ@mail.gmail.com sent
> ~2 weeks ago to the list:
>=20
>     On Fri, Jun 2, 2017 at 7:54 PM, Jonathan Nieder <jrnieder@gmail.com>
>     wrote:
>     [...]
>     > 4. When choosing a hash function, people may argue about performanc=
e.
>     >    It would be useful for run some benchmarks for git (running
>     >    the test suite, t/perf tests, etc) using a variety of hash
>     >    functions as input to such a discussion.
>=20
>     To the extent that such benchmarks matter, it seems prudent to heavil=
y
>     weigh them in favor of whatever seems to be likely to be the more
>     common hash function going forward, since those are likely to get
>     faster through future hardware acceleration.
>=20
>     E.g. Intel announced Goldmont last year which according to one SHA-1
>     implementation improved from 9.5 cycles per byte to 2.7 cpb[1]. They
>     only have acceleration for SHA-1 and SHA-256[2]
>=20
>     1. https://github.com/weidai11/cryptopp/issues/139#issuecomment-26428=
3385
>=20
>     2. https://en.wikipedia.org/wiki/Goldmont
>=20
> Maybe someone else knows of better numbers / benchmarks, but such a
> reduction in CBP likely makes it faster than SHA-512.

Very, very likely faster than SHA-512.

I'd like to stress explicitly that the Intel SHA extensions do *not* cover
SHA-512:

=09https://en.wikipedia.org/wiki/Intel_SHA_extensions

In other words, once those extensions become commonplace, SHA-256 will be
faster than SHA-512, hands down.

Ciao,
Dscho
--8323329-717168033-1497555282=:4200--
