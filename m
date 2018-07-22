Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658811F597
	for <e@80x24.org>; Sun, 22 Jul 2018 14:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbeGVPSq (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 11:18:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34942 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729291AbeGVPSq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Jul 2018 11:18:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9FF6660739;
        Sun, 22 Jul 2018 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532269314;
        bh=Ftj0x+ouX0tXqmNs4v1a69mvTI+QSPPA1ECHrQxPFFA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yfq+fIbFvbbUIZxUIbUVKPL5frqio+7MaFMzH1urQgjgrheH6WjO9Z/L1waxIJNs1
         OU371fTGYm0e7clpXUE/VmihLobgSWKWBSJC2kjQaNt2b3sbrEHhgowDmkCEOfLReW
         boDzzPzICeJNji3VxJsLsnulY1pEGNe/a+MqN4WwivxuCwCSb+o/0MXjCKfqI3C9cv
         jV3GJJICZq/uA/Jm2DSlttW2VMJhQ8APh54WhdLxEnkaFnydAclopqOvUJ8YONodAH
         j0j4rjP5gSe1Of+U9/eaNwHXs4cREF11p6CLW7BurpuzwyL7GrLUKa3JgxencwTe+f
         g1M5hY6rzbFilK8yQBUub246gnXopMBb2pLg9wU03UKnAXKhk0+J9C52z3VtV7xzBD
         UWSeWnPHOmgBat+pxngrMPGeWREfQw7vGj+N2WLbo0c8pPed96NQXlMrWOyTHfSguc
         32/TvHXh+HHHDjIj1fBfCGvcXxTIUrrbjTeGRJATF71nBA7ZYA/
Date:   Sun, 22 Jul 2018 14:21:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Deplagne <Eric@Deplagne.name>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180722142148.GH18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Deplagne <Eric@Deplagne.name>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>, The Keccak Team <keccak@noekeon.org>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net>
 <20180722093442.GK11431@mail.eric.deplagne.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FLPM4o+7JoHGki3m"
Content-Disposition: inline
In-Reply-To: <20180722093442.GK11431@mail.eric.deplagne.name>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FLPM4o+7JoHGki3m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 11:34:42AM +0200, Eric Deplagne wrote:
> On Sat, 21 Jul 2018 23:59:41 +0000, brian m. carlson wrote:
> > I don't know your colleagues, and they haven't commented here.  One
> > person that has commented here is Adam Langley.  It is my impression
> > (and anyone is free to correct me if I'm incorrect) that he is indeed a
> > cryptographer.  To quote him[0]:
> >=20
> >   I think this group can safely assume that SHA-256, SHA-512, BLAKE2,
> >   K12, etc are all secure to the extent that I don't believe that making
> >   comparisons between them on that axis is meaningful. Thus I think the
> >   question is primarily concerned with performance and implementation
> >   availability.
> >=20
> >   [=E2=80=A6]
> >=20
> >   So, overall, none of these choices should obviously be excluded. The
> >   considerations at this point are not cryptographic and the tradeoff
> >   between implementation ease and performance is one that the git
> >   community would have to make.
>=20
>   Am I completely out of the game, or the statement that
>     "the considerations at this point are not cryptographic"
>   is just the wrongest ?
>=20
>   I mean, if that was true, would we not be sticking to SHA1 ?

I snipped a portion of the context, but AGL was referring to the
considerations involved in choosing from the proposed ones for NewHash.
In context, he meant that the candidates for NewHash =E2=80=9Care all secur=
e=E2=80=9D
and are therefore a better choice than SHA-1.

I think we can all agree that SHA-1 is weak and should be replaced.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FLPM4o+7JoHGki3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltUkvwACgkQv1NdgR9S
9osE3hAAvWWm/gwob35NvuZobr0tWYLD9kL4C7eJ+wSvRxzna5CbvRjjB0ORo2/a
c0lMpO3CU4g20CcWg9wl3i1t0kqfTa2n6U38eJ3Y0wHv+nj5/5NW/cY9cHGtV14a
0f10Z154nYWWh8lpruCTjlfxHRg2JKjmUq7QALEKvA7cFsPorGjASzHJ+Jep3c9W
xeQ5/wtHTEHelhM77wWFjsZ+/Z0weOjna1Jao/vZadGUZOak+qau4WOz4YgkNWBx
mb1ZvpJr3TID+132eu+V7+n9Y9KeFbfiQDuqhs5fAfFasQzt9QK8R9ZM/p1awR8x
Gw8ltz/r49HpxCKnx2JrXml4OPYzIP1lhdW6vU2YMKh1URQB+TwCS57C1KieCqaZ
Rq0+akEORGRIYLNQMMtpK0M/uvKzd7OEDT/UWlZgo/w5PrXMNb/k7bk8XL9Jgmqu
cJjoeEs7BUt5S0L6fgQjffxUo9hnjTcCnYM7ZKCXvYAKiS7LAeSKi56zVSr/SjLB
rEXIaugaQT9UsUv15XEpC5zqOyzaFgCCQoxZzvG1o09FfcVzy5WDu5GAd0+iF4/s
BPHjcCk9FnGQzU2y7SpOrh/97mrDmg6zfgivdq6C+MfqMPey4LzD5U8KMoc3AHDO
fPwQz1sh4ZaYYsZbVfwpe6gP97JBeYxB3+nNa19TJr/KttlHtkk=
=RqY5
-----END PGP SIGNATURE-----

--FLPM4o+7JoHGki3m--
