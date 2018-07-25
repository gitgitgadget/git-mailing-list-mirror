Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265331F597
	for <e@80x24.org>; Wed, 25 Jul 2018 22:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbeGZAKp (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 20:10:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731526AbeGZAKp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Jul 2018 20:10:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 91C276046C;
        Wed, 25 Jul 2018 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532559411;
        bh=PtiWozK485gOYoKjOSP+DB7MpSR+BGZyJmTUf/dcHlQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HR4B42c6FTHBqIt3YkZRM/WZYEDei8KtZ1H5I4fEn38ltX+pg/73QSp8WIXks1dW6
         m9RogSzlka56PkBnTY2JUslYwRfrYyKxB1ujSzyz5Tli0jQMh37cA1s+9ziqumuMmq
         PE1MehQ6ZHG49pzYDahNAZT3alsB6Hh7HgLliKczPmb99G1D5AlzdrqhPZlN8mWQoL
         OOnnnrM9YJRbZT/z8oGa85ZMIGDWIKO1qKqrzTURGaylvVIZ7+fZZC9roKYMEYh1m5
         FwTKSaEAs3lhh78CLfrCfek2iE1eDzl9IvSwzsX5MvekWUqGCRSPVcD/iUZu9r+GkA
         zRbTI+/nxo+Z/bUaqql4yEU6TrFOh8/T7X8SAP04qHSXdjeqVNgk8tJc/CVSxbZM8/
         t6cZvtz/ldp+DBWHlK+hmUcaJhbNsIZS025nSrCFvIL/MZhax21CJQ4cSKMGWYzze0
         l85nJSBb0E1Xwg+eZMabaqHFi0dIVNQoDVa/uS4p4dBY/FQSiUa
Date:   Wed, 25 Jul 2018 22:56:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: [PATCH 2/2] doc hash-function-transition: pick SHA-256 as NewHash
Message-ID: <20180725225645.GK18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
References: <20180725083024.16131-1-avarab@gmail.com>
 <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
 <20180725083024.16131-3-avarab@gmail.com>
 <xmqq4lgnw9fj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6TC23+W66xmFESAX"
Content-Disposition: inline
In-Reply-To: <xmqq4lgnw9fj.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6TC23+W66xmFESAX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 09:45:52AM -0700, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>=20
> > @@ -125,19 +122,19 @@ Detailed Design
> >  ---------------
> >  Repository format extension
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > -A NewHash repository uses repository format version `1` (see
> > +A SHA-256 repository uses repository format version `1` (see
> >  Documentation/technical/repository-version.txt) with extensions
> >  `objectFormat` and `compatObjectFormat`:
> > =20
> >  	[core]
> >  		repositoryFormatVersion =3D 1
> >  	[extensions]
> > -		objectFormat =3D newhash
> > +		objectFormat =3D sha256
> >  		compatObjectFormat =3D sha1
>=20
> Whenever we said SHA1, somebody came and told us that the name of
> the hash is SHA-1 (with dash).  Would we be nitpicker-prone in the
> same way with "sha256" here?

I actually have a patch to make the names "sha1" and "sha256".  My
rationale is that it's shorter and easier to type.  People can quibble
about it when I send it to the list, but that's what I'm proposing at
least.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--6TC23+W66xmFESAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltZAC0ACgkQv1NdgR9S
9osPpg/+N1BNaP7n4vkPBn3WnhNGjci70olWX5mW62Gpb49VSKEMw25ag4LHEvPx
Jq+es2Ij+IQ5fPNcLdzW9H2tFNLxunLdv5whWqQpvykSRDQHK9vKfFQthptdwkfY
6t3Qhd7NAz/1wlVDvJVKZEZCwGIGOqmpwXMoGl8FFgpFrGWVyjFlXMQtAU4hUagU
S1l1soEerRQrhG7jOeS2oVsDzGEMd3Rn3MKnRCaBV/DX5lS6q0TyosGVCN7pqsts
gV6JshIEPY2s8FWZ+Gteak4XQ+4ax/7j9qw72jKMFuhjEfPDh6T59Yeqi7Jo7l2h
/iRh6ibiVeMNOfN+pBtKz32aeybNKzuf5IfF+HCypSbfZmhFpy9sw4NgANmD04F5
mrJCadcy90M4xNzRb7Nn1zgjiBEGoOmy2YLUN5vzCVioDbOCqdWRy5U+UME9iioC
lyDApBEiGXcuhXh6qXC4KY/thVhi1f7hn2OVafG1N+KO8Y8FRIh8KsKGBkEoCNE0
W2C6BXo2oV38JYodTRcYN3pz0MJydF4TsY0NVCxPKefqiTrRj1POqRClmEifhUIC
cU5b9Hm10wuI4bNKjMIvL6jqw5YCbAwga30Tl1ACw0VJMzSSNc94rtSbKY4pv4Ls
LpuIwqHPwmDD+xMgt9+NPa6y2k05bZtxjKfM0TMrqXCPa4JVGRI=
=yM50
-----END PGP SIGNATURE-----

--6TC23+W66xmFESAX--
