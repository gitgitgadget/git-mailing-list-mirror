Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CB571F516
	for <e@80x24.org>; Thu, 21 Jun 2018 08:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeFUIVS (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 04:21:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:39611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932430AbeFUIVO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 04:21:14 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Meduu-1fpcTN2pyK-00OK4B; Thu, 21
 Jun 2018 10:20:37 +0200
Date:   Thu, 21 Jun 2018 10:20:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Adam Langley <agl@google.com>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Hash algorithm analysis
In-Reply-To: <87bmchvx69.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806211018480.11870@tvgsbejvaqbjf.bet>
References: <20180609205628.GB38834@genre.crustytoothpaste.net> <20180609224913.GC38834@genre.crustytoothpaste.net> <87bmchvx69.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2077807226-1529569249=:11870"
X-Provags-ID: V03:K1:vgl6h3Qb+4iAJhBt9q4RGjgCbPLmiAEU7PSSk36Lw5KZE8YYNTz
 JHkeZJXrzwt9WXOUrZXw69m0P4vQMBldGxfdAnhl67dAjh4iPdx67sIBZRD5Ibpg/fdz4Hs
 cSGHVyOB2zPZJHiSr1/X/rNYzPMLKjOKcHzD07VMMdVomkPWjZUPnXRIy44il33CY+thXxH
 2IIjysDVset1CRqWbZ25g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dm1pZ66TLHQ=:9zC7ajmCVrVT4Yh+uEUpnv
 i7VO6dDfBbbZrrz8qXWLK64OhZWig9GYxiarPhJ07jvtRbDycr69OBQBTfORLhpbxuat1zgmZ
 ZQA+R1+QIHBr73DrJiX0b5Ydfq09INkOI2sghUC7GJ0jhZpr+gBgI8L5R1r1zKvwnDEVBNxSn
 DQHFuhSTgSne8NuNbGpm9r3uJ6zZqCqvcwX7BgVm6JZca/mudnhHK09nH49BpEQ7t1Gt77eE/
 Fxm+rkfx/GfhYRie3GqQ7GX6acKuRZ4guwTkyvwYapstq3AKRZxRPfBNR225jYbMxwYx2Q0qO
 4dn+dX42hs2IV8IxEhi+RYgnLnnCcgHpnQAK+cEMsLcgMJKFC2qfN8RV795No4wYdtMtYQBaK
 6ciK3r4Jk0RWEWivnPikxgrqGb+45Co9YumwGzxiwRYH7Cp52xEoTNuGA+63GTpKvzPg/LT7E
 Ry29S6b3vOprCC4jRJE+U691PLo2jWClQKLk9wgS1oe3PtGWGXAYNE2/OpWdvMzOdlvCTc0Bv
 7fmAhPubGscQ8MPuIKj+Z0HLFld0CUEPuN/Gkt5jgG+2q/WdbkDim1XbFNi4L7+yXIjp7dpLR
 uVfhWiJ23Z0ZXCgUIHFxXgq2gv8YvJbTqUkBRRMyqXtE8zZE/nzbiagiuNqDMOObKQgHSRXHm
 dX6Q55YU6d6PdF7Gcu4n70jhnJS4svWcBBCfhPEsBKG4LMhJeiQndLSIhVaK8RxiLZJqtQv6C
 pnYbvQe7w8XB/WfbJR0AmKzm5jYxx+ksyskDAcGHv2/jZi01oFAracMW/odRl1IumAXWfoaD6
 KckTo+u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2077807226-1529569249=:11870
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Mon, 11 Jun 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sat, Jun 09 2018, brian m. carlson wrote:
>=20
> [Expanding the CC list to what we had in the last "what hash" thread[1]
> last year].
>=20
> > =3D=3D Discussion of Candidates
> >
> > I've implemented and tested the following algorithms, all of which are
> > 256-bit (in alphabetical order):
> >
> > * BLAKE2b (libb2)
> > * BLAKE2bp (libb2)
> > * KangarooTwelve (imported from the Keccak Code Package)
> > * SHA-256 (OpenSSL)
> > * SHA-512/256 (OpenSSL)
> > * SHA3-256 (OpenSSL)
> > * SHAKE128 (OpenSSL)
> >
> > I also rejected some other candidates.  I couldn't find any reference o=
r
> > implementation of SHA256=C3=9716, so I didn't implement it.  I didn't
> > consider SHAKE256 because it is nearly identical to SHA3-256 in almost
> > all characteristics (including performance).
> >
> > I imported the optimized 64-bit implementation of KangarooTwelve.  The
> > AVX2 implementation was not considered for licensing reasons (it's
> > partially generated from external code, which falls foul of the GPL's
> > "preferred form for modifications" rule).
> >
> > =3D=3D=3D BLAKE2b and BLAKE2bp
> >
> > These are the non-parallelized and parallelized 64-bit variants of
> > BLAKE2.
> >
> > Benefits:
> > * Both algorithms provide 256-bit preimage resistance.
> >
> > Downsides:
> > * Some people are uncomfortable that the security margin has been
> >   decreased from the original SHA-3 submission, although it is still
> >   considered secure.
> > * BLAKE2bp, as implemented in libb2, uses OpenMP (and therefore
> >   multithreading) by default.  It was no longer possible to run the
> >   testsuite with -j3 on my laptop in this configuration.
> >
> > =3D=3D=3D Keccak-based Algorithms
> >
> > SHA3-256 is the 256-bit Keccak algorithm with 24 rounds, processing 136
> > bytes at a time.  SHAKE128 is an extendable output function with 24
> > rounds, processing 168 bytes at a time.  KangarooTwelve is an extendabl=
e
> > output function with 12 rounds, processing 136 bytes at a time.
> >
> > Benefits:
> > * SHA3-256 provides 256-bit preimage resistance.
> > * SHA3-256 has been heavily studied and is believed to have a large
> >   security margin.
> >
> > I noted the following downsides:
> > * There's a lack of a availability of KangarooTwelve in other
> >   implementations.  It may be the least available option in terms of
> >   implementations.
> > * Some people are uncomfortable that the security margin of
> >   KangarooTwelve has been decreased, although it is still considered
> >   secure.
> > * SHAKE128 and KangarooTwelve provide only 128-bit preimage resistance.
> >
> > =3D=3D=3D SHA-256 and SHA-512/256
> >
> > These are the 32-bit and 64-bit SHA-2 algorithms that are 256 bits in
> > size.
> >
> > I noted the following benefits:
> > * Both algorithms are well known and heavily analyzed.
> > * Both algorithms provide 256-bit preimage resistance.
> >
> > =3D=3D Implementation Support
> >
> > |=3D=3D=3D
> > | Implementation | OpenSSL | libb2 | NSS | ACC | gcrypt | Nettle| CL  |
> > | SHA-1          | =F0=9F=97=B8       |       | =F0=9F=97=B8   | =F0=9F=
=97=B8   | =F0=9F=97=B8      | =F0=9F=97=B8     | {1} |
> > | BLAKE2b        | f       | =F0=9F=97=B8     |     |     | =F0=9F=97=
=B8      |       | {2} |
> > | BLAKE2bp       |         | =F0=9F=97=B8     |     |     |        |   =
    |     |
> > | KangarooTwelve |         |       |     |     |        |       |     |
> > | SHA-256        | =F0=9F=97=B8       |       | =F0=9F=97=B8   |  =F0=
=9F=97=B8  | =F0=9F=97=B8      | =F0=9F=97=B8     | {1} |
> > | SHA-512/256    | =F0=9F=97=B8       |       |     |     |        | =
=F0=9F=97=B8     | {3} |
> > | SHA3-256       | =F0=9F=97=B8       |       |     |     | =F0=9F=97=
=B8      | =F0=9F=97=B8     | {4} |
> > | SHAKE128       | =F0=9F=97=B8       |       |     |     | =F0=9F=97=
=B8      |       | {5} |
> > |=3D=3D=3D
> >
> > f: future version (expected 1.2.0)
> > ACC: Apple Common Crypto
> > CL: Command-line
> >
> > :1: OpenSSL, coreutils, Perl Digest::SHA.
> > :2: OpenSSL, coreutils.
> > :3: OpenSSL
> > :4: OpenSSL, Perl Digest::SHA3.
> > :5: Perl Digest::SHA3.
> >
> > =3D=3D=3D Performance Analysis
> >
> > The test system used below is my personal laptop, a 2016 Lenovo ThinkPa=
d
> > X1 Carbon with an Intel i7-6600U CPU (2.60 GHz) running Debian unstable=
=2E
> >
> > I implemented a test tool helper to compute speed much like OpenSSL
> > does.  Below is a comparison of speeds.  The columns indicate the speed
> > in KiB/s for chunks of the given size.  The runs are representative of
> > multiple similar runs.
> >
> > 256 and 1024 bytes were chosen to represent common tree and commit
> > object sizes and the 8 KiB is an approximate average blob size.
> >
> > Algorithms are sorted by performance on the 1 KiB column.
> >
> > |=3D=3D=3D
> > | Implementation             | 256 B  | 1 KiB  | 8 KiB  | 16 KiB |
> > | SHA-1 (OpenSSL)            | 513963 | 685966 | 748993 | 754270 |
> > | BLAKE2b (libb2)            | 488123 | 552839 | 576246 | 579292 |
> > | SHA-512/256 (OpenSSL)      | 181177 | 349002 | 499113 | 495169 |
> > | BLAKE2bp (libb2)           | 139891 | 344786 | 488390 | 522575 |
> > | SHA-256 (OpenSSL)          | 264276 | 333560 | 357830 | 355761 |
> > | KangarooTwelve             | 239305 | 307300 | 355257 | 364261 |
> > | SHAKE128 (OpenSSL)         | 154775 | 253344 | 337811 | 346732 |
> > | SHA3-256 (OpenSSL)         | 128597 | 185381 | 198931 | 207365 |
> > | BLAKE2bp (libb2; threaded) |  12223 |  49306 | 132833 | 179616 |
> > |=3D=3D=3D
> >
> > SUPERCOP (a crypto benchmarking tool;
> > https://bench.cr.yp.to/results-hash.html) has also benchmarked these
> > algorithms.  Note that BLAKE2bp is not listed, KangarooTwelve is k12,
> > SHA-512/256 is equivalent to sha512, SHA3-256 is keccakc512, and SHAKE1=
28 is
> > keccakc256.
> >
> > Information is for kizomba, a Kaby Lake system.  Counts are in cycles
> > per byte (smaller is better; sorted by 1536 B column):
> >
> > |=3D=3D=3D
> > | Algorithm      | 576 B | 1536 B | 4096 B | long |
> > | BLAKE2b        |  3.51 |   3.10 |   3.08 | 3.07 |
> > | SHA-1          |  4.36 |   3.81 |   3.59 | 3.49 |
> > | KangarooTwelve |  4.99 |   4.57 |   4.13 | 3.86 |
> > | SHA-512/256    |  6.39 |   5.76 |   5.31 | 5.05 |
> > | SHAKE128       |  8.23 |   7.67 |   7.17 | 6.97 |
> > | SHA-256        |  8.90 |   8.08 |   7.77 | 7.59 |
> > | SHA3-256       | 10.26 |   9.15 |   8.84 | 8.57 |
> > |=3D=3D=3D
> >
> > Numbers for genji262, an AMD Ryzen System, which has SHA acceleration:
> >
> > |=3D=3D=3D
> > | Algorithm      | 576 B | 1536 B | 4096 B | long |
> > | SHA-1          |  1.87 |   1.69 |   1.60 | 1.54 |
> > | SHA-256        |  1.95 |   1.72 |   1.68 | 1.64 |
> > | BLAKE2b        |  2.94 |   2.59 |   2.59 | 2.59 |
> > | KangarooTwelve |  4.09 |   3.65 |   3.35 | 3.17 |
> > | SHA-512/256    |  5.54 |   5.08 |   4.71 | 4.48 |
> > | SHAKE128       |  6.95 |   6.23 |   5.71 | 5.49 |
> > | SHA3-256       |  8.29 |   7.35 |   7.04 | 6.81 |
> > |=3D=3D=3D
> >
> > Note that no mid- to high-end Intel processors provide acceleration.
> > AMD Ryzen and some ARM64 processors do.
> >
> > =3D=3D Summary
> >
> > The algorithms with the greatest implementation availability are
> > SHA-256, SHA3-256, BLAKE2b, and SHAKE128.
> >
> > In terms of command-line availability, BLAKE2b, SHA-256, SHA-512/256,
> > and SHA3-256 should be available in the near future on a reasonably
> > small Debian, Ubuntu, or Fedora install.
> >
> > As far as security, the most conservative choices appear to be SHA-256,
> > SHA-512/256, and SHA3-256.
> >
> > The performance winners are BLAKE2b unaccelerated and SHA-256 accelerat=
ed.
>=20
> This is a great summary. Thanks.
>=20
> In case it's not apparent from what follows, I have a bias towards
> SHA-256. Reasons for that, to summarize some of the discussion the last
> time around[1], and to add more details:
>=20
> =3D=3D Popularity
>=20
> Other things being equal we should be biased towards whatever's in the
> widest use & recommended fon new projects.
>=20
> I fear that if e.g. git had used whatever at time was to SHA-1 as
> BLAKE2b is to SHA-256 now, we might not even know that it's broken (or
> had the sha1collisiondetection work to fall back on), since researchers
> are less likely to look at algorithms that aren't in wide use.
>=20
> SHA-256 et al were published in 2001 and has ~20k results on Google
> Scholar, compared to ~150 for BLAKE2b[4], published in 2008 (but ~1.2K
> for "BLAKE2").
>=20
> Between the websites of Intel, AMD & ARM there are thousands of results
> for SHA-256 (and existing in-silicon acceleration). There's exactly one
> result on all three for BLAKE2b (on amd.com, in the context of a laundry
> list of hash algorithms in some presentation.
>=20
> Since BLAKE2b lost the SHA-3 competition to Keccak it seems impossible
> that it'll get ever get anywhere close to the same scrutiny or support
> in silicon as one of the SHA families.
>=20
> Which brings me to the next section...
>=20
> =3D=3D Hardware acceleration
>=20
> The only widely deployed HW acceleration is for the SHA-1 and SHA-256
> from the SHA-2 family[5], but notably nothing from the newer SHA-3
> family (released in 2015).
>=20
> It seems implausible that anything except SHA-3 will get future HW
> acceleration given the narrow scope of current HW acceleration
> v.s. existing hash algorithms.
>=20
> As noted in the thread from last year[1] most git users won't even
> notice if the hashing is faster, but it does matter for some big users
> (big monorepos), so having the out of purchasing hardware to make things
> faster today is great, and given how these new instruction set
> extensions get rolled out it seems inevitable that this'll be available
> in all consumer CPUs within 5-10 years.
>=20
> =3D=3D Age
>=20
> Similar to "popularity" it seems better to bias things towards a hash
> that's been out there for a while, i.e. it would be too early to pick
> SHA-3.
>=20
> The hash transitioning plan, once implemented, also makes it easier to
> switch to something else in the future, so we shouldn't be in a rush to
> pick some newer hash because we'll need to keep it forever, we can
> always do another transition in another 10-15 years.
>=20
> =3D=3D Conclusion
>=20
> For all the above reasons I think we should pick SHA-256.
>=20
> 1. https://public-inbox.org/git/87y3ss8n4h.fsf@gmail.com/#t
> 2. https://github.com/cr-marcstevens/sha1collisiondetection
> 3. https://scholar.google.nl/scholar?hl=3Den&as_sdt=3D0%2C5&q=3DSHA-256&b=
tnG=3D
> 4. https://scholar.google.nl/scholar?hl=3Den&as_sdt=3D0%2C5&q=3DBLAKE2b&b=
tnG=3D
> 5. https://en.wikipedia.org/wiki/Intel_SHA_extensions

I agree with that reasoning.

More importantly, my cryptography researcher colleagues agree with this
assessment, and I do trust them quite a bit (you know one of them very
well already as we, ahem, *might* be using his code for SHA-1 collision
detection all the time now *cough, cough*).

Ciao,
Dscho
--8323328-2077807226-1529569249=:11870--
