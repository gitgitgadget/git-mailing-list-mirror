Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A632B1F407
	for <e@80x24.org>; Sun, 10 Dec 2017 14:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdLJN7s (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 08:59:48 -0500
Received: from mout.gmx.net ([212.227.15.18]:50314 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbdLJN7r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 08:59:47 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqylH-1f21is3bwB-00egFa; Sun, 10
 Dec 2017 14:59:45 +0100
Date:   Sun, 10 Dec 2017 14:59:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] check-non-portable-shell.pl: Quoted `wc -l` is
 not portable
In-Reply-To: <20171210105013.3984-1-tboegi@web.de>
Message-ID: <alpine.DEB.2.21.1.1712101458150.4318@virtualbox>
References: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com> <20171210105013.3984-1-tboegi@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-706629426-1512914385=:4318"
X-Provags-ID: V03:K0:JJod2G1+RR52MMNyZ/nz7r5PrAZgS3HVuvx94z9KUZY3Rvd+AUC
 ctyl+TKTm6bI1/tXomju9D28yBBKoqi1cUHyRgMA0ZeuHQIvsB+Gb6xfpF589QhSZTIFVQJ
 hh7SiJjnN2jBNbBT2q9/CXg8+3F5E3iXdxGtxWrsuFvL2vIR0jMOoGrljyBuD9Kak+dG0gg
 F0Z1CTtko722ugHaCJPRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m7orG3HY8M0=:URdAj9HfR+v0U/l7uj8qIL
 Y0TfS5oDLc30zp95A9+wPFr9ORhVgtiHPHbhUFoPU+3d22z3z28gR4GX/+RFe/TU04aMxUTyu
 fr5nCZFIaKcz1ijIRyjSqrDDNRpbhb7/9VZfuMhEWra2UOjTwAz9N9mU7fwvk56XEuQyy+Uev
 iuVYY570UnHAbgFzYzEWmdGKB341YTYRMvZtd3UlQwnHMESr82XD1tL3Ye58O/oZquGi/JYbr
 qMgSa4p12rQ58uou43uVXGM3nazIJD/qNGG4kTUbKbGtYmx2Hzev+gO/thnL51nxdjikyfXUD
 7+UN27JKxuvO3K0qLR0OsJPPnUOFqfadatP7llzxv9JNyxabRjxjz1brrotakWxnUgvWybhvb
 Ukg8fzThtK+TbOE4FEPmXS/5KczX+9m7SGpxebqQmZ8cuaWch0qJ72X5sut66BM3dG1lw8xjP
 TMAV7feRm4W7QIJ8VbZ6Hj/AjNE/d4c4kZTPJJhkNk9wjW4W6BIUdKkm8LnSV4lAiVbrcBLlG
 vCVTfW4msGu9cJkO9f9iPoFtuFX7RkpSCbgOV1WGLqw6ACgcbf5ORdkmBPdmGeWy9Vj5Yo88B
 TSMEYzlx1pKRT1pBMXDF43fD5M3h/ktRl6pxXnLwIdQVqGGjSSiQUzETiYqNBhlhUC8rspLM4
 72SaTQdzZTkphZCwwk48jbg2h7ceZSnIjkEiTtqD8k4jBM0it3CdNh+fTXIGLs8bFtiKmHKBp
 M3Pa322yDZo7g4pfLo9S2y5PGlNbiox0qgmfhK7ksuZ/SaTzKQ1e2mMdAbpfoNnDzigU8Azc5
 y+EzYBZzLYG6wI78GtJRTPXRFum1OnMuG7HD0gcAweWW9Sr93Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-706629426-1512914385=:4318
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Sun, 10 Dec 2017, tboegi@web.de wrote:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> wc -l is used to count the number if lines in test scripts.
> $ wc -l Makefile
> gives a line like this:
> 105 Makefile
> while Mac OS has 4 leading spaces:
>      105 Makefile
>=20
> And this means that shell expressions like
> test "$(wc -l <expect)" =3D "4" don't work under Mac OS,
>=20
> A portable way to use `wc -l` is to omit the '"':
> test $(wc -l <expect) =3D "4"
>=20
> Add a check in check-non-portable-shell.pl to find '"' between
> `wc -l` and '=3D'
>=20
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/check-non-portable-shell.pl | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.p=
l
> index 03dc9d2852..9ebf65c26f 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -21,6 +21,7 @@ while (<>) {
>  =09/^\s*declare\s+/ and err 'arrays/declare not portable';
>  =09/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
>  =09/\btest\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (=
please use =3D)';
> +=09/\bwc -l.*"\s*=3D/ and err '`"$(wc -l)"` is not portable, please use =
`$(wc -l)`';
>  =09/\bexport\s+[A-Za-z0-9_]*=3D/ and err '"export FOO=3Dbar" is not port=
able (please use FOO=3Dbar && export FOO)';
>  =09# this resets our $. for each file
>  =09close ARGV if eof;

As noted elsewhere, this should suggest `test_line_count` instead. After
all, that function is not only guaranteed to stay portable (even if we
should ever start supporting systems *without* `wc`), but it also has a
semantically-meaningful name worthy of the current century.

Ciao,
Dscho
--8323329-706629426-1512914385=:4318--
