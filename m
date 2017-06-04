Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E094820D09
	for <e@80x24.org>; Sun,  4 Jun 2017 18:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbdFDSpp (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 14:45:45 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:49382 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751169AbdFDSpn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Jun 2017 14:45:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F1259280AD;
        Sun,  4 Jun 2017 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1496601941;
        bh=njJnMPKIgEBU6isaTyWmntMUdm+ydhsaS5l3+dCAXgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d02Xm0Yu9wThB22dvJYuOqxz85ErfGiDSKFNikc8OH4jdfVGkYLT0FY9j0RVJzCFJ
         RVFhBOsWHDUYi/6hcMNaI/5953f0YXHiMrSxjznmmydly2OBCyVVJB/qi831oW22mu
         9NNO561Fl7ktj1heUV77KRwIzX75FJlf1O/+POtXcaIziIVT31h8DemqklOu9ky96Q
         /ohVBdS63aYWXxUh9Yjhj9CqrUvM7/vf2JFeAua/ycTBl8a6ZMWR4wBmQd3fyHwRk9
         7gbFI3XEMq7LxzRjmEB7pP5YXlpAmZm3bNh/PEXaEtOX5zYmlsaf7dIaCDfV/cvYP/
         vO9iTQ/3NbqM6dnoMopMXauEqATLzLTASIfag0zjYvydgO7P4fxUq22mVYs8wGL3Dt
         Q46YqCbNyNoGA9FrQAHj///l2xzip7yl1yiNwyoa4uKYp93pf5eIOuYq7YxKfatXz4
         OIg0pKTKJ6S/gt8G/X4Tj4BabX/k5bTwuWZB0cM9CStp9xNCqyc
Date:   Sun, 4 Jun 2017 18:45:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jakub Wilk <jwilk@jwilk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] git-p4: remove obsolete version check
Message-ID: <20170604184533.ztsmvbinfytrhl4x@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jakub Wilk <jwilk@jwilk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
References: <20170603133120.715-1-jwilk@jwilk.net>
 <CACBZZX7Sz6VPLQgzyQ1Dk+-899y0NzqMjVYL5ry0n-0axmR35w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3wug756mlf2qbus"
Content-Disposition: inline
In-Reply-To: <CACBZZX7Sz6VPLQgzyQ1Dk+-899y0NzqMjVYL5ry0n-0axmR35w@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--h3wug756mlf2qbus
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 03, 2017 at 06:55:22PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Sat, Jun 3, 2017 at 3:31 PM, Jakub Wilk <jwilk@jwilk.net> wrote:
> > The file is syntactically correct only in Python >=3D 2.6, so the
> > version check never does anything.
>=20
> [CC-ing Eric who added that check]
>=20
> Your commit message doesn't give an example of this, but with e.g.
> python 2.0 you get:
>=20
>       File "git-p4.py", line 469
>         yield pattern
>                 ^
>     SyntaxError: invalid syntax
>=20
> I checked the various other python files that had similar warnings,
> they all work correctly with python 2.0.

The yield syntax was in Python 2.3, so this isn't indicative of the
problem.  You'd actually need to test with 2.5 itself in order to know
what that version complains about.

> One workaround to keep this would be to make git-p4.py import some
> library to do all its work, and use some subset of python syntax to
> just load and defer to that library. That works for me when I change
> it like that locally. Alternatively, does Python have something like
> Perl's BEGIN {} blocks where you can execute code right there before
> the file has finished parsing?

TTBOMK, Python doesn't have such functionality.

> Or we could just remove this, just wanted to note the above since I
> dug into it, and the commit message light on details.

As a note, Python 2.6 has been around since at least 2009, so I think
it's fine to drop support for earlier versions at this point.  But I
agree an explanation in the commit message of what exactly makes it
syntactically invalid would be beneficial.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--h3wug756mlf2qbus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlk0VU0ACgkQv1NdgR9S
9osO6g//R/jqe6jE7R/YvY4d0RaZwa8k+2mgrGH1rYhNOuRLnyCkn/KRPTnuRC0S
JrUE2rWCioNfNbXqCtXg4whOViFLRTxsfxBz3csXQ6UV8AqDLuskJ93Sd0M1Lpv5
cM6sIyAZJu/6F0LisqG3EU+mt73E0YwreuySRXNg8UiQyMfJN1ck+EVCDmo7XTE1
szLGpQlUY7G+F8sqGWFk6MWx7hDWlakSZ6w6yMQfLXl+5rzy+m17yWwkkuYlfcpm
ERPt/hE+WiEDlAdVg2dZ4iHHaSn6g/la6qdUPRS4QskNJosEdAv6sSS7db+5U2HZ
hdREHsTRypDGjx7tsuCKP2ousX0kdTjZ+kxp3xrDD/owBJCSUJ/jtJlh/5qJKPj3
pzgdciYHPXNdYoElvQ9DQdiI5MktFlxnEQbx2g6KCrB5r7tqMlVYeKYmpY22J6lP
IwZvA1fkVgf6u4k04rv2dTaU26mK4f+FubIsiI/dG+6Hs8sWp4FXIwsPCvKRN31V
hComvFTOMkUqCxDDRIOLeL519FWrr+W12cDQnFW6jTp92uAPiYDHk7m8kbhJgIWD
FVaDm5//XQQjkf2Df/QjUJfiq1HcpH0n0GPO3/+P59M6QGd0Z2D5sJlWpIYNIVqC
xm9me7e0Y3CGTZgGdfLfUIDhS3hUKJnl63kwn5CR47wP0cYyWJo=
=NZ2Q
-----END PGP SIGNATURE-----

--h3wug756mlf2qbus--
