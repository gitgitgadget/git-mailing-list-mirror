Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381C21FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 13:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbdFPNZP (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 09:25:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:61574 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752566AbdFPNZO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 09:25:14 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIMQR-1dOK4o1wHH-0047xg; Fri, 16
 Jun 2017 15:24:21 +0200
Date:   Fri, 16 Jun 2017 15:24:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Langley <agl@google.com>, Jeff King <peff@peff.net>,
        Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
In-Reply-To: <87y3ss8n4h.fsf@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706161438470.4200@virtualbox>
References: <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net> <20170306182423.GB183239@google.com> <alpine.DEB.2.21.1.1706151122180.4200@virtualbox> <20170615110518.ordr43idf2jluips@glandium.org> <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
 <87shj1ciy8.fsf@gmail.com> <alpine.DEB.2.21.1.1706152123060.4200@virtualbox> <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com> <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net> <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com>
 <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net> <87y3ss8n4h.fsf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1306072282-1497619461=:4200"
X-Provags-ID: V03:K0:fnMFm86qY/sO/Xz69ed0OuA8h20ZV5ZMITPvf1HS2dzfPU6NDC9
 Ls60g5DB56gbu4uLUytYbWuODKqJ+3Txy7FpxHKIpaIPmR0hBMGPTpuy3UEmZsT5JIJllTu
 SrhlnuLHdwV8EJlLCa/6BQeFSFCIzPs6w2krvPxBllHxHlLMVbuO3bdyaxS0Q19dV9ijyXA
 U8JV73aw+qT++yjQpL4bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CFCWgxhCkjw=:j1Q799xSugmGs2+iuY360/
 DC8CA2DoXJObL9bixwALGdSGS66vrH/2NQ/CprLDm6FVtKszwLqWINgCK0B9gJwWWTrHUP+8C
 Dx90GJdFQmhQOtbRJtmeLGpTdbuLQTG0jfOr0Tqf64csNBDHLUjJLnMJ1K5CoCa1rmiXFX1Hl
 uBJZI2KFNGNhxeEYV6QnadmaZSqtlRIIJQG+B3dyB0BjQ5YXTH5lY0O1ISc7GIEj2GvoDiPnq
 5BPAlIy6Qpq8H9ExK+QFRo5tKNJ+5v6iqkVYhCgF27fYfcu9EKlsTBJNWJN85gw7czn51VICv
 T9bUE/h7L7Vbi/F+b5ZOzK2qV4FNngvQZIMUG3bR6VM8s6YvAMDlP5DCCZddGHZHQvx5cT44p
 AhAfzpRyablpEEFRdO5dgzdrZ3VocJmbSfEUUNW5fP05C0xvUS4gAMwKqBvoBZf2vBd5m7ZQX
 pVcCGPAlljQv31P4uLqeCaAZNxgMRVMMR60G8uGn/wf+64Go4CU+FDjEEsNGxGlKQ2JESAdTn
 xhM4qSlNgLcA+EHwWLZAnjPI/WWtXYXP0IUyP2q6l6vQB2KOeaAg/iyc9kNWuqTl7c4Bikzw9
 bhBxHenJQurQI5vQRotKFe1lOAamGCs5jL9MIixLfDFr6NHKG7F95tCPnvWUfu+5c7lRekVwl
 Ny53K8kjoxeCwOtfuu5VrPBS5Up6534dkFDYqpKmxcFVDdo2un7oS6+ejNLWOz2a5d91Yibhw
 GrGEbs0ZMR9Mw2aIgq/bffaqcl8qq3jkvXQmovO8eJn80JlaeQyVQn3WWJU3RaY8wLE7dydBq
 m8cQGvT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1306072282-1497619461=:4200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 16 Jun 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Jun 16 2017, brian m. carlson jotted:
>=20
> > On Fri, Jun 16, 2017 at 01:36:13AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> >
> >> So I don't follow the argument that we shouldn't weigh future HW
> >> acceleration highly just because you can't easily buy a laptop today
> >> with these features.
> >>
> >> Aside from that I think you've got this backwards, it's AMD that's
> >> adding SHA acceleration to their high-end Ryzen chips[1] but Intel is
> >> starting at the lower end this year with Goldmont which'll be in
> >> lower-end consumer devices[2]. If you read the github issue I linked
> >> to upthread[3] you can see that the cryptopp devs already tested
> >> their SHA accelerated code on a consumer Celeron[4] recently.
> >>
> >> I don't think Intel has announced the SHA extensions for future Xeon
> >> releases, but it seems given that they're going to have it there as
> >> well. Have there every been x86 extensions that aren't eventually
> >> portable across the entire line, or that they've ended up removing
> >> from x86 once introduced?
> >>
> >> In any case, I think by the time we're ready to follow-up the current
> >> hash refactoring efforts with actually changing the hash
> >> implementation many of us are likely to have laptops with these
> >> extensions, making this easy to test.
> >
> > I think you underestimate the life of hardware and software.  I have
> > servers running KVM development instances that have been running since
> > at least 2012.  Those machines are not scheduled for replacement
> > anytime soon.
> >
> > Whatever we deploy within the next year is going to run on existing
> > hardware for probably a decade, whether we want it to or not.  Most of
> > those machines don't have acceleration.
>=20
> To clarify, I'm not dismissing the need to consider existing hardware
> without these acceleration functions or future processors without them.
> I don't think that makes any sense, we need to keep those in mind.
>=20
> I was replying to a bit in your comment where you (it seems to me) were
> making the claim that we shouldn't consider the HW acceleration of
> certain hash functions either.

Yes, I also had the impression that it stressed the status quo quite a bit
too much.

We know for a fact that SHA-256 acceleration is coming to consumer CPUs.
We know of no plans for any of the other mentioned hash functions to
hardware-accelerate them in consumer CPUs.

And remember: for those who are affected most (humongous monorepos, source
code hosters), upgrading hardware is less of an issue than having a secure
hash function for the rest of us.

And while I am really thankful that Adam chimed in, I think he would agree
that BLAKE2 is a purposefully weakened version of BLAKE, for the benefit
of speed (with the caveat that one of my experts disagrees that BLAKE2b
would be faster than hardware-accelerated SHA-256). And while BLAKE has
seen roughly equivalent cryptanalysis as Keccak (which became SHA-3),
BLAKE2 has not.

That makes me *very* uneasy about choosing BLAKE2.

> > Furthermore, you need a reasonably modern crypto library to get hardwar=
e
> > acceleration.  OpenSSL has only recently gained support for it.  RHEL 7
> > does not currently support it, and probably never will.  That OS is
> > going to be around for the next 6 years.
> >
> > If we're optimizing for performance, I don't want to optimize for the
> > latest, greatest machines.  Those machines are going to outperform
> > everything else either way.  I'd rather optimize for something which
> > performs well on the whole everywhere.  There are a lot of developers
> > who have older machines, for cost reasons or otherwise.
>=20
> We have real data showing that the intersection between people who care
> about the hash slowing down and those who can't afford the latest
> hardware is pretty much nil.
>=20
> I.e. in 2.13.0 SHA-1 got slower, and pretty much nobody noticed or cared
> except Johannes Schindelin, myself & Christian Couder. This is because
> in practice hashing only becomes a bottleneck on huge monorepos that
> need to e.g. re-hash the contents of a huge index.

Indeed. I am still concerned about that. As you mention, though, it really
only affects users of ginormous monorepos, and of course source code
hosters.

The jury's still out on how much it impacts my colleagues, by the way.

I have no doubt that Visual Studio Team Services, GitHub and Atlassian
will eventually end up with FPGAs for hash computation. So that's that.

Side note: BLAKE is actually *not* friendly to hardware acceleration, I
have been told by one cryptography expert. In contrast, the Keccak team
claims SHA3-256 to be the easiest to hardware-accelerate, making it "a
green cryptographic primitive":
http://keccak.noekeon.org/is_sha3_slow.html

> > Here are some stats (cycles/byte for long messages):
> >
> >                    SHA-256    BLAKE2b
> > Ryzen                 1.89       3.06
> > Knight's Landing     19.00       5.65
> > Cortex-A72            1.99       5.48
> > Cortex-A57           11.81       5.47
> > Cortex-A7            28.19      15.16
> >
> > In other words, BLAKE2b performs well uniformly across a wide variety o=
f
> > architectures even without acceleration.  I'd rather tell people that
> > upgrading to a new hash algorithm is a performance win either way, not
> > just if they have the latest hardware.
>=20
> Yup, all of those need to be considered, although given my comment above
> about big repos a 40% improvement on Ryzen (a processor likely to be
> used for big repos) stands out, where are those numbers from, and is
> that with or without HW accel for SHA-256 on Ryzen?

When it comes to BLAKE2, I would actually strongly suggest to consider the
amount of attempts to break it. Or rather, how much less attention it got
than, say, SHA-256.

In any case, I have been encouraged to stress the importance of
"crypto-agility", i.e. the ability to switch to another algorithm when the
current one gets broken "enough".

And I am delighted that that is exactly the direction we are going. In
other words, even if I still think (backed up by the experts on whose
knowledge I lean heavily to form my opinions) that SHA-256 would be the
best choice for now, it should be relatively easy to offer BLAKE2b support
for (and by [*1*]) those who want it.

Ciao,
Dscho

Footnote *1*: I say that the support for BLAKE2b should come from those
parties who desire it also because it is not as ubiquituous as SHA-256.
Hence, it would add the burden of having a performant and reasonably
bug-free implementation in Git's source tree. IIUC OpenSSL added BLAKE2b
support only in OpenSSL 1.1.0, the 1.0.2 line (which is still in use in
many places, e.g. Git for Windows' SDK) does not, meaning: Git's
implementation would be the one *everybody* relies on, with *no*
fall-back.
--8323329-1306072282-1497619461=:4200--
