Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9A4208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbdHIVt4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:49:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:59750 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752412AbdHIVtz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:49:55 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhOSG-1dJTdj3g8m-00mdYv; Wed, 09
 Aug 2017 23:49:48 +0200
Date:   Wed, 9 Aug 2017 23:49:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Coppa <dcoppa@gmail.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t4062: stop using repetition in regex
In-Reply-To: <CABM=MFLYkVDjpeVKbErbX+szv7_NXre6U_Z_cOtKakcPDR5U3w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1708092349220.11175@virtualbox>
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de> <alpine.DEB.2.21.1.1708081648130.11175@virtualbox> <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de> <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com> <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
 <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de> <xmqqtw1h8g1u.fsf@gitster.mtv.corp.google.com> <50c2eaab-d1d8-3376-6e7a-1c898d978d12@web.de> <e3e65635-2dc8-de58-5662-3eab619aedb3@web.de> <CABM=MFLYkVDjpeVKbErbX+szv7_NXre6U_Z_cOtKakcPDR5U3w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-417446568-1502315387=:11175"
X-Provags-ID: V03:K0:er9ZaOfTqVOuJ6tMW2NjpAkDGKTQ8eWHbJ6wDOnOzJjUBcr4/fO
 mEbdoTikxxsVWwob33etRyXMUc3zao1BHQuU5RWn4M8RRjkFAOmJigkFgdIcNcnWm6FBnVG
 1FMvGGNsjac0G3lgBvhxmb+6aFH8JY1n/jio0woqY8vpLse6I6pA/fj+T7aw3IldCkR0WOx
 CVuM2OCh+vyXhXVkvlFkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Td5K6DGJ2wM=:Rf1ClNjCNIN8Q+fwW4+kVb
 nBOzsX1MKX32zcQTu+FzCZlp9khWHsEPq9Hh7VmNfHNCszlinl/7KZp1bWwMXyMo0fFC57lnE
 h/1+ZD47eVDxlLUTmN0kKPiM7algauu7WauqZA/zTrQEpjqKsV5v2Ea0E4LdcsvcMsmHLv4GY
 Cc/ViugWCYiiq+W9p457Xkj7vBbmeFHIAfsTgQhqvG2196FceqTRIMVAd5ew5B5qJkyFQFBjv
 4H8ssVhibLHaHj1gn1rZmdeFOgrdQdHR0AWJZ0XZ6C43NNui0HzGpHEQJq6ETBhhE0/CTsNUZ
 /IRFVeadntVmHCVuYrpSreQ8QrurVuxTiZfF1BCLcC54AL/cvGfXlLTIMcjLePd59KyzQSaBK
 9xo0PKt071xzwsr3XHozt1/TSPvzR5sHwTJHNcG93kHsdRAGpXCbhrIWpFBlQpHmk9JtLrlYU
 R/cwdU03RJnG03wTEzSFGouAVRZwCvHCUJMaW7g4Q87WoUU2EgALCHnAgObzAQqlm4iuJL+XD
 2xUIVMoqa7wtYeKGxefLsrq5Cc69axD3uEgyMphVnB27uFY4bpDlmvjuzaYQNz1lk7C/4RmT4
 vPVxqKiYHR7bgHZTrUsRmL0DB5wy7AD3rNqVkRW7UDQwtsr2tRsUwQLKVWcFe4SLYMnrRxLMZ
 C8eRRZ/gDKp6EFbnvtHTnCUZsoMJ39q+qSRjpy0JWMYfAP8lkwlJXml0XmLPP3peHlaYLifO0
 Jwpwaacxz33x9qCy/M+/S2lIsuL8+UuvzC03OostfGaFqzI09rOMIlubzq6yTQbMBLqB8CJ/j
 Aly3d2M6SY026x5ga2euUuq6R/mR3iagaA0bC2B8KDvUvZn/Hk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-417446568-1502315387=:11175
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi all,

On Wed, 9 Aug 2017, David Coppa wrote:

> On Wed, Aug 9, 2017 at 4:15 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> > Am 09.08.2017 um 08:15 schrieb Ren=C3=A9 Scharfe:
> >> Am 09.08.2017 um 07:29 schrieb Junio C Hamano:
> >>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
> >>>
> >>>> Am 09.08.2017 um 00:26 schrieb Junio C Hamano:
> >>>>> ... but in the meantime, I think replacing the test with "0$" to
> >>>>> force the scanner to find either the end of line or the end of the
> >>>>> buffer may be a good workaround.  We do not have to care how many o=
f
> >>>>> random bytes are in front of the last "0" in order to ensure that
> >>>>> the regexec_buf() does not overstep to 4097th byte, while seeing
> >>>>> that regexec() that does not know how long the haystack is has to d=
o
> >>>>> so, no?
> >>>>
> >>>> Our regexec() calls strlen() (see my other reply).
> >>>>
> >>>> Using "0$" looks like the best option to me.
> >>>
> >>> Yeah, it seems that way.  If we want to be close/faithful to the
> >>> original, we could do "^0*$", but the part that is essential to
> >>> trigger the old bug is not the "we have many zeroes" (or "we have
> >>> 4096 zeroes") part, but "zero is at the end of the string" part, so
> >>> "0$" would be the minimal pattern that also would work for OBSD.
> >>
> >> Thought about it a bit more.
> >>
> >> "^0{4096}$" checks if the byte after the buffer is \n or \0 in the
> >> hope of triggering a segfault.  On Linux I can access that byte just
> >> fine; perhaps there is no guard page.  Also there is a 2 in 256
> >> chance of the byte being \n or \0 (provided its value is random),
> >> which would cause the test to falsely report success.
> >>
> >> "0$" effectively looks for "0\n" or "0\0", which can only occur
> >> after the buffer.  If that string is found close enough then we
> >> may not trigger a segfault and report a false positive.
> >>
> >> In the face of unreliable segfaults we need to reverse our strategy,
> >> I think.  Searching for something not in the buffer (e.g. "1") and
> >> considering matches and segfaults as confirmation that the bug is
> >> still present should avoid any false positives.  Right?
> >
> > And that's not it either. *sigh*
> >
> > If the 4097th byte is NUL or LF then we can only hope its access
> > triggers a segfault -- there is no other way to distinguish the
> > result from a legitimate match when limiting with REG_STARTEND.  So
> > we have to accept this flakiness.
> >
> > We can check the value of that byte with [^0] and interpret a
> > match as failure, but that adds negation and makes the test more
> > complex.
> >
> > ^0*$ would falsely match if the 4097th byte (and possibly later
> > ones) is 0.  We need to make sure we check for end-of-line after
> > the 4096th byte, not later.
> >
> > Sorry, Dscho, I thought we could take a shortcut here, but -- as
> > you wrote all along -- we can't.
> >
> > So how about this?
> >
> > -- >8 --
> > Subject: [PATCH] t4062: use less than 256 repetitions in regex
> >
> > OpenBSD's regex library has a repetition limit (RE_DUP_MAX) of 255.
> > That's the minimum acceptable value according to POSIX.  In t4062 we us=
e
> > 4096 repetitions in the test "-G matches", though, causing it to fail.
> > Combine two repetition operators, both less than 256, to arrive at 4096
> > zeros instead of using a single one, to fix the test on OpenBSD.
> >
> > Original-patch-by: David Coppa <dcoppa@openbsd.org>
> > Signed-off-by: Rene Scharfe <l.s.r@web.de>
> > ---
> >  t/t4062-diff-pickaxe.sh | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
> > index 7c4903f497..1130c8019b 100755
> > --- a/t/t4062-diff-pickaxe.sh
> > +++ b/t/t4062-diff-pickaxe.sh
> > @@ -14,8 +14,10 @@ test_expect_success setup '
> >         test_tick &&
> >         git commit -m "A 4k file"
> >  '
> > +
> > +# OpenBSD only supports up to 255 repetitions, so repeat twice for 64*=
64=3D4096.
> >  test_expect_success '-G matches' '
> > -       git diff --name-only -G "^0{4096}$" HEAD^ >out &&
> > +       git diff --name-only -G "^(0{64}){64}$" HEAD^ >out &&
> >         test 4096-zeroes.txt =3D "$(cat out)"
> >  '
> >
> > --
> > 2.14.0
>=20
> I think this should work w/o problems on OpenBSD:
>=20
> $ uname -a
> OpenBSD open.bsdgeek.it 6.1 GENERIC#54 amd64
> $ git diff --name-only -G "^0{4096}$" HEAD^ 1>/dev/null
> fatal: invalid regex: invalid repetition count(s)
> $ git diff --name-only -G "^(0{64}){64}$" HEAD^ 1>/dev/null
> $

Perfect!

Thank y'all for being so thorough,
Dscho
--8323329-417446568-1502315387=:11175--
