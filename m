Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4189E1F406
	for <e@80x24.org>; Sat,  6 Jan 2018 12:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeAFMv4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 07:51:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:51959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752960AbeAFMvy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 07:51:54 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LeMij-1fEtfK1jCf-00qCxM; Sat, 06
 Jan 2018 13:51:47 +0100
Date:   Sat, 6 Jan 2018 13:51:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
In-Reply-To: <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <20180105221222.28867-1-avarab@gmail.com> <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-632289364-1515243107=:1337"
X-Provags-ID: V03:K0:KJCYnJpDZbUFt7dlTI0YFFXzD4/t0Gty9NDMHtwZitgd99K1dON
 ZB0LxN3d5Hyw9G7JI9TCEFFXrr8fgQIzMdenkKrAwEtczUWhPAdpyljsfrjHr7UEpjUwgyT
 7i2hU/a6y3bq/Fdgxk5Kfmc4KycuaqVpC0abgxh7490myNR5pA80brbncKuBsFUw5OwnOGd
 BFO1tDJDFxrLcfKZR11Tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NAgUMhAgxP4=:8SbiF8YlLVcUcqrUaldDNh
 i1TFlMtIwmasZaq5pqt/XqhgxPStfl/fkAtx5FZlH0aytGoE0LWhTd1dLLYQo6zC2pNwbMzfx
 rPFfliCq+2lE/7pjsVchUKbg5t2V4FUmOg0VnZdd2zyKkgFPjIHN4Of4+hfxOg2y5u5eySTTD
 AePmbIVM2yMwNumzM8Uogwaf04MpULA6VCLYLjVM8PEwyiayvDw5fnrNaB4rpMsxYUkZX/XXe
 zDHtFPd+bfLCc4zZm0HXtnQ2NHZ5bahlWvXY7olcDk+LLC3PWU2As46Ods+uEDnO/13YBVkO/
 nuKdU5Wxi9TIBCiucoAsltE8bQ/V0NZIMuc7Ifs/shZJqMEuD+xWHleQDR37KSI7e6fHdsxKO
 FdJkttAsFSjfH1krZpsTM+kqL+ufSyXrZhTQw/5M9BmFcriR0p5Y6D9YTsA2k011e8CfImWf/
 rRcNxA8BmmqtHuNppAqIFoh/HUJDgUaNzOg5qxg/Kmr+bVEjcSMS78+ZsT7ACNB9ihrnYkggb
 Svc0IpuBZ36mdmK1C7UBxdo3dK+Zp+ycabF6QURY98gFq54/wjaKY2VFeXybMVwZb1Osky3XB
 2jhMygJ1jD9JnyJ2K3/KnoH4f0KG04ErpQUHEcGswpaLOndDFuvjPYd/TA2XoZ11sNCI/uKB0
 kS684XSvQs5MDZrPnr+g+ei39u2X+66yCorGt5Xj9KHSNSNrSSn50HTPwzYBXNMBXH28KnUPL
 K652qsCtEq8YD0C5LUeQjYxE5lWjiq3tLA0jqMc2TLdThur6QxOiKJ93FVodiqa52DrhhcbOG
 Bjn9IxXwSkNRwPfsnXuPi19Cuk8JKHXybrvH3b3aGTilaLLCty9TzdlvkFVqKycxKc8+MdW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-632289364-1515243107=:1337
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Fri, 5 Jan 2018, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>=20
> > Skip the newly added file creation tests on Windows proper, these
> > already work under Cygwin, but as that involves a significant
> > emulation layer the results are different under Windows proper with
> > MinGW.
> > ...
> > diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> > index f606f91acb..50a53e7a62 100755
> > --- a/t/t3070-wildmatch.sh
> > +++ b/t/t3070-wildmatch.sh
> > @@ -7,6 +7,14 @@ test_description=3D'wildmatch tests'
> >  create_test_file() {
> >  =09file=3D$1
> > =20
> > +=09# These tests limp along under Cygwin, but the failures on
> > +=09# native Windows are still too many. Skip file tests there
> > +=09# until they're sorted out.
> > +=09if test_have_prereq MINGW
> > +=09then
> > +=09=09return 1
> > +=09fi
> > +
>=20
> That looks to be a nuclear option.

Indeed:

=09# still have 84 known breakage(s)
=09# failed 52 among remaining 1428 test(s)
=091..1512

Let's just switch it off completely because 52 of those 1512 test cases
break only on Windows? Pretty heavy-handed.

But do read on.

> For now it may be suffice, but somehow it feels that it goes directly
> against Dscho's wish to treat (or pretend to treat) Windows as
> first-class citizens and/or just like other platforms.

It not only goes against my wish to treat Windows as a normal citizen
instead of like Rey's parents, it also goes against my wish to have a
focused and meaningful test suite. Nobody likes to run tests that take too
long. And look at this:

=09...
=09ok 1511 - ipathmatch: match 'Z' '[Z-y]'
=09ok 1512 - ipathmatch(ls): match '[Z-y]' 'Z'
=09# still have 84 known breakage(s)
=09# failed 52 among remaining 1428 test(s)
=091..1512

=09real    5m51.432s
=09user    0m33.986s
=09sys     2m13.162s

Yep. It takes *over eight minutes*.

And this is a *fast* machine.

Why? Because of the completely overboard testing of all kinds of
*potential* breakages *at some point* in the future.

I understand that =C3=86var wants to increase test coverage. I am sympathet=
ic
to this cause.

But I completely disagree that increasing the test coverage beyond reason
is a good thing. Tests *can* take too long, and they do, in practice, and
the results are always problematic: every developer who has to deal with
test suites that take too long... does not run them. As simple as that.
And then you have *zero* test coverage. Pretty stupid, eh? And contrary to
your intentions, too.

So yes, I think that it has been proven beyond any doubt that t3070 takes
*waaaaaaaaaay* too long on Windows, for dubitable benefit.

I could see a reasonable compromise where

- an extensive test matrix is hidden behind an EXPENSIVE_WILDMATCH prereq,

- the test matrix would be written in a much more understandable way, i.e.
  using English words rather than "1"s. If need be, there could be blocks
  ("test this with case-sensitive matching", "skip case-sensitive matching"=
,
  you get the idea),

- these magic skippings of certain test cases (where the (non-traced)
  `create_test_file()` function returns 1 for certain things) still would
  need to go away, in favor probably of prereqs and/or blocks where flags
  are set accordingly in a preamble,

- by default, i.e. without the EXPENSIVE_WILDMATCH prereq, it should test
  a *tiny* subset that is indicative of the most likely bugs.

As it is, I like 8/7 in the present form for all the wrong reasons: it
protects me from the damage a full t3070 would do to me.

Ciao,
Dscho
--8323328-632289364-1515243107=:1337--
