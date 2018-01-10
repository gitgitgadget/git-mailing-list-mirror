Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183621F404
	for <e@80x24.org>; Wed, 10 Jan 2018 20:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeAJUYk (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 15:24:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:64543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbeAJUYj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 15:24:39 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MADqP-1ekcPJ1txB-00BNTM; Wed, 10
 Jan 2018 21:24:32 +0100
Date:   Wed, 10 Jan 2018 21:24:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
In-Reply-To: <20180110090724.GA2893@ash>
Message-ID: <nycvar.QRO.7.76.6.1801102057110.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <20180105221222.28867-1-avarab@gmail.com> <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <CACsJy8CDz57RR+VHpaPb5YMhKG5kUgb9rt5TWKL8n+e7Xart3g@mail.gmail.com> <nycvar.QRO.7.76.6.1801081319520.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180110090724.GA2893@ash>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-270528733-1515615872=:31"
X-Provags-ID: V03:K0:hPdJZrKIh01v9WrHywIuXNbmOnYoUso84otObN5/03kfIhaQk9W
 wtaMZTkpEy0l0YvR2kg0+nqV936r6mMI7gSh1cyvvW/SIh3aHahdwx9Oz9SrRkvEWUOZ5az
 rA+QhEFkaBZLC5ES6OKGx+xLIqsRlfPU2JAZEdXETe+xILLre1PhSWothz0OcKk6qpjZ4le
 z57mATmMIfjf2UTKGm9WA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9pxl6LAUML8=:soCP6HcCg0myKNavxJnUsA
 nRAEotaRBwytgwMrP2DqnFP39Nn416VfV64d1KndWlvDJMfHZ5gFsI8hU6m7NIazGAKN0R4Xp
 eCBA9sxGufXqvCRKqpMTFY9kJrrq3kVyI90JRi2gjU9wQAEgi3mbKkneGe7NZ9iTJYHuDWeX4
 D0+NruoFKwWGA0r3gh2a1iuW+Ayqi7gfIR+zmP2TvZswUksMJUDmKZ68A0khve4Dyx06eEzN6
 IdKGV6TBfN/LZRzCjiW5BW+UqeWB0BVINb/zH0LMtZA/kMRm9rYi3jv8PRm316oeEac7bpLvP
 J8TwJXIdxmpSLtkE2/Cdo4Nnst/0v+EQqpAL1YFHnwMfw2Fq0AEzUDbIMzTQNzB6fhsU/r1/I
 o69ojJMTloqN8Ha6DzUTYNmkPiIgjEw86552eeJRw9xLdko5iFkmhDnT4WtORiXfvrGuMRZq/
 prIC1eXVGG41jXPh3jPro0wpUkXpl9wepPNWKkMBSd5TtmcUyYZ+4nn/bLMTw4SE+uUmb1adn
 Aep9p+m8nMCtq8MnrNaWQ994Rpm6r97eSnJ9pMvg/IfHk54J2tzOSCQz0S36fOLRuGNISRB89
 PIrgNs9LQNdwqahNBurAsWD2pJ7TT+RYbUrxglwbJSO+e6Cr8L5B9J8hNY4VNJDU/697wgGPs
 lCKX9tsO5Fy7l1mtaZh5SgxTVg6Bgpp2hAVIH9hCe5qmhSS4IA9yshreIWUY5V8HKGhfzw2Gt
 jIGUdGTZYMDseYm91pP5KlmSBN/nKpXOu4gVp5FLQCTNRY/Dw7C9yj7Vc665k9FqIk74AYmYO
 1lFtd5U1Fwr5xheC8KQdkrFBU+bMl721UgHnbKFXFEVXB1NEnI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-270528733-1515615872=:31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 10 Jan 2018, Duy Nguyen wrote:

> On Mon, Jan 08, 2018 at 01:25:04PM +0100, Johannes Schindelin wrote:
> > I agree that it would make a ton of sense to use a proper, portable tes=
t
> > framework written in pure, portable C.
> >=20
> > However, this ship has long sailed, hasn't it?
>=20
> If you meant converting the whole test suite, oh yeah that's not gonna
> happen. But it's still possible to have some tests written in C.

True.

> I played a bit with this. The assumption is if it's agreed that we can
> get something bare bone (but functional) in then we could start having
> more and more C-based unit tests in future and also improve the C
> framework to be on par with shell one on the side.

We can also start with something small that does not contend to replace
the entire test suite, and evolve from there as we have time.

Your initial patch looks very good, I will give it a cursory review (only
cursory because we are technically in a feature-freeze...)

> diff --git a/Makefile b/Makefile
> index 2a81ae22e9..567387b558 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -644,6 +644,7 @@ X =3D
> =20
>  PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
> =20
> +TEST_PROGRAMS_NEED_X +=3D test-3071-wildmatch

I guess I can always work on unifying those gazillion of test executables
into a single one later.

For testing purposes, I have to bundle them (BusyBox-based MinGit is
supposed to be stand-alone, yet I want to test it to verify that it works
even if it ships only a subset of Git for Windows), and they dominate the
payload of any prerelease, as you can see e.g. here:
https://github.com/git-for-windows/git/releases/tag/v2.16.0-rc1.windows.1

> diff --git a/t/helper/test-3071-wildmatch.c b/t/helper/test-3071-wildmatc=
h.c
> new file mode 100644
> index 0000000000..24a657202d
> --- /dev/null
> +++ b/t/helper/test-3071-wildmatch.c
> @@ -0,0 +1,273 @@
> +#include "cache.h"
> +#include "test-lib.h"
> +
> +struct match_input {
> +=09int expect_true;
> +=09const char *text;
> +=09const char *pattern;
> +};
> +
> +static struct match_input match_tests[] =3D {
> +=09/* Basic wildmatch features */
> +=09{ 1, "foo", "foo" },
> +=09{ 0, "foo", "bar" },
> +=09{ 1, "", "" },

These patterns share the "magic-ness" of =C3=86var's test cases... although
your version is certainly more concise.

BTW IIRC =C3=86var explicitly said that he needs to use `ls-files` in order=
 to
test the interaction with the index, so that would probably take a little
bit more work.

> diff --git a/t/t3071-wildmatch.sh b/t/t3071-wildmatch.sh
> new file mode 100755
> index 0000000000..6e83b4d684
> --- /dev/null
> +++ b/t/t3071-wildmatch.sh
> @@ -0,0 +1,3 @@
> +#!/bin/sh
> +
> +exec helper/test-3071-wildmatch t3071-wildmatch "$@"

Should it not be `exec test-3071-wildmatch "${0%.sh}" "$@"`?

> diff --git a/test-lib.c b/test-lib.c
> new file mode 100644
> index 0000000000..8e8b7cd6df
> --- /dev/null
> +++ b/test-lib.c
> @@ -0,0 +1,97 @@
> [...]

Lots of good stuff in there. Definitely a good start.

Ciao,
Dscho
--8323329-270528733-1515615872=:31--
