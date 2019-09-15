Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E7A1F463
	for <e@80x24.org>; Sun, 15 Sep 2019 21:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfIOV03 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 17:26:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725270AbfIOV03 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Sep 2019 17:26:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4d4d:a9ce:2c0a:3d66])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 17FB66074C;
        Sun, 15 Sep 2019 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568582787;
        bh=E1PiwJxAxvVpSRDMXDgUhA4QBGoLBBvSCl+kJpoNzXI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ymnWf6tTtGb9k17bFff94D9iui+2GJ1SaSlj2yXOiw8F1zLpbE5tBrxjtKmmUZYfI
         7dddSkqVaYQa12sL1tTT34RQF9yCaim6YK2QmXLKP3lz/2S+xNliCf/4G8tR7VUl5G
         WfWjO5KB65mzoQhYbfhWDKilXJejkPPYllaDwqKqLEL9g/C2PTLWEfoEo3QUu+Ppch
         cIBBpQ8zfvlvXLISN3gykHEQ8AaOrJDPdo37hhwpCIWMCsNy+/BBZWkVHL4Ah+2bUa
         z8sMspofn25tlQnr2uljHtxToNvQ5UK4d7Ek6liQ3rJ1JYLq7SFO8jq9B6sYmAjgz1
         upEh3uhVdmLUHE8PYEc1IQlccxz6GKmvEpCzmg4OqDuZ5e7R7Q61vnt9lwwtPBEue+
         cO4uwaU9YGQQpU9rC/IPDHNGEupFIOcGvyJE6LhavgUP9oMUJ7mB6MUyMOXhiBN6w7
         XyNrmDdZuxhrKGKKMOyuN+CH10fs6BnVJNkuu3wuXsIWEUV25Gn
Date:   Sun, 15 Sep 2019 21:26:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation: fix build with Asciidoctor 2
Message-ID: <20190915212621.GV11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190914194919.748935-1-sandals@crustytoothpaste.net>
 <20190915095952.GA6190@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ptMYGWplstB9CqWP"
Content-Disposition: inline
In-Reply-To: <20190915095952.GA6190@szeder.dev>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ptMYGWplstB9CqWP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-15 at 09:59:52, SZEDER G=C3=A1bor wrote:
> On Sat, Sep 14, 2019 at 07:49:19PM +0000, brian m. carlson wrote:
> >  	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
> >  	gem install --version 1.5.8 asciidoctor
>=20
> So, since the documentation can now be built with Asciidoctor v2, is
> it already time to remove this '--version 1.5.8'?

I think Martin was going to send in some more patches before we did
that.

> > diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> > index d49089832d..b3e76ef863 100755
> > --- a/ci/test-documentation.sh
> > +++ b/ci/test-documentation.sh
> > @@ -8,6 +8,8 @@
> >  filter_log () {
> >  	sed -e '/^GIT_VERSION =3D /d' \
> >  	    -e '/^    \* new asciidoc flags$/d' \
> > +	    -e '/stripped namespace before processing/d' \
> > +	    -e '/Attributed.*IDs for element/d' \
>=20
> I haven't seen this latter message in the CI builds, neither with
> Asciidoctor v1.5.8 nor with v2.  Do we really need this filter, then?
> Where does this message come from?

I see it and it definitely fails on my system without it.  It comes from
libxslt, which has been patched in Debian to produce deterministic IDs.
I suspect we may not have seen it on Ubuntu systems because they are
running 16.04, which is likely older than the patch.  If Travis updates
to 18.04, we may be more likely to have a problem.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ptMYGWplstB9CqWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1+rH0ACgkQv1NdgR9S
9oscihAAh2l2fbWX43oKAL6wFFUuez0HWZ7fRkgAUm/WFLwcfFdeRtDhR+7qXIhr
CKwLz/gGZ69dMVRFwWT8/Y55BZQJltBZg5EQ85H74WqwOf0ST5gjr0Oxd8Ef+FH7
1M71bx8hT91IPqaSJPluoAAuMWvH4mbxTj1ii1/dmijZ1c7oBRq2DpuCTO1h3mGO
8ROI3nHFDiYUzmXa002uSj/h0siUqXHCoMCM7x7ZI/M0zs2o7VJV1xa0Gl8eEv2J
Kj3Q8q+lTbQjgoDAUoLp/EyFz0Zag8/ozNDIG5LA1VAvgIxA8PKwxb9+SD/D6gmm
OKinZ/NfKyq74GAYFQb0CnvGAZRzBfcIa6i/vuGwRO3VOd9f7j7APIw/9lGhf951
yklUMKKatwrNsKwmRElA0jS+APz+c8nAcqGpubQYjJE5QiJuYB2KrPDjYwsgKZzC
kW0F7xgJ2z1qvtT8MPrRLDYm7fdezI6MQlop8i1vu7wGZtEu+JSehpN94fq9tOEl
pzfkT0MnS7pWWDNiEoYY+v/As9LSk1v0IiI0FRx99GwQuDavESrllOGzYd/l2JfM
lZ+CZ88JGqIbt15cHd8R4sPFSE29LxXvlyqM+0aByB7za8y4fsChJGb0AwfUSFRJ
kCzKpnwQ9zpyq4yiveLXtueFOxY2YJr1lwKSExx0JsbOVsuVQHQ=
=LFhR
-----END PGP SIGNATURE-----

--ptMYGWplstB9CqWP--
