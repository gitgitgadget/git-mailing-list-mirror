Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF17F1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 19:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfINTox (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 15:44:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58694 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728618AbfINTow (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Sep 2019 15:44:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d92:edb:bada:18ab])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C82BE6042C;
        Sat, 14 Sep 2019 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568490290;
        bh=/wzaeeS86uSfxrHeFG0PS4oqH4AxhXj/c/dLX/3WoEM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zSw52VvEbKq3mEVY7FKbrbRgNrt0zqqR37K1JrsoR5Qzgf5eqBVQnWspL7gz1TkXr
         DNKu9viH6El0EAHBg6gF4Lczj9SBulQC286N3sSzYdDJOMvRxxwP32uczeWgPeCw+y
         2rmTAkIdx2flnKO2C8aOmd6ADdW2AfMmoI6oj3k5CPYViY7wY397AYDh5/n36s5cuq
         ci2ifPv8U3VDo4JhFmdE7TBiXSB1sK2xYFthOnukht+PxeyNr1CGz5XAeu7i/bXLdp
         HaWOC4nN15UwGrZjt4+Kwv0lB6PSCGSll/H+Lh4PZEz3AsePmHRti5ApI+FxqVuydT
         x895yO6TYrayeq0uE107RPLJg8Uz8PQeNrslzB8xZs8/a+i4OqHyOyxrNrPtMe8awA
         vO650uD+QoGwKSTvSfs420m9bRPvXXwZpsGy/jr697T8wguijbmzTAhKjIeDthcNPf
         AtlTmQkj3bMoSN3xIS+dxFhVfvsSOSyVXXTn3nzDL3vgyxBd8he
Date:   Sat, 14 Sep 2019 19:44:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: fix build with Asciidoctor 2
Message-ID: <20190914194445.GT11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190913015240.686522-1-sandals@crustytoothpaste.net>
 <20190914075301.GR32087@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N7HXVILz59yg1nI8"
Content-Disposition: inline
In-Reply-To: <20190914075301.GR32087@szeder.dev>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--N7HXVILz59yg1nI8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-14 at 07:53:01, SZEDER G=C3=A1bor wrote:
> Unfortunately, five out of five CI builds failed with the following:
>=20
>       XMLTO git-revert.1
>   I/O error : Attempt to load network entity http://docbook.sourceforge.n=
et/release/xsl-ns/current/manpages/docbook.xsl
>   warning: failed to load external entity "http://docbook.sourceforge.net=
/release/xsl-ns/current/manpages/docbook.xsl"
>   compilation error: file /home/travis/build/git/git/Documentation/manpag=
e.xsl line 2 element import
>   xsl:import : unable to load http://docbook.sourceforge.net/release/xsl-=
ns/current/manpages/docbook.xsl
>   Makefile:375: recipe for target 'git-revert.1' failed
>=20
> https://travis-ci.org/git/git/jobs/584794387#L1552

Ah, I forgot to install the packages in CI.  I'll send a v3 with that
fixed.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--N7HXVILz59yg1nI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl19Qy0ACgkQv1NdgR9S
9ouFrw/+IeE9PsmWQSZocR5e5OOkRx6slp0bjba6XlgDx5GfElDcsy9SHxGLr18v
lvD5w1+CMKeC0eOHZqJOexrml3VmLCrpi1BDIk+ab8hj6CyXCI3DcFylL1dkWWSK
d1NqNZSZRfvSPFv8LAuKwvCffZVHovgguNiZzmy3R2WxSjquZiFR+xckhMsfZtfo
YWPvei+EDBWCTvq8qoraPDpRM+qRiVBXByta2NTrztal2dAinSTBzT9m592TX01E
g29GssQEDW0SaL5A5VEC966JioOsv7hWIhE3UsH9RLM+MAY9WUtIyxmGli4eGsCW
R8Ak7kd1Srb5Y/rfhxuRcUsg5vfe3olI845Kpwq1NYpZyW90rKv4vJceF1U+cxwe
YWjb/7j30GFSsda28JiPgM2NatKNx3syjOt4aDLB1tJYfMe/2tzLQQDMbW8CrmvN
7qx7h9PyB2rvWl28glWgF/ep6PZZlw6VJlZ/l0MHrdadXJFg3GZfh64s6E+QNETV
U8ZHrQoAQjt7Fj3g/hzhMDWDStxNGNaenIwj1B/11Xjp5rzHw9Z2U4sSEeoyFC2/
c9o97EVLr4faVv+bm/tfNqri7xKQ6akKsdQxdMW4ZLsMDRoHG+FJ7uYQ78TA344q
+Zuz3PHpEbgLbZWtGiuY50de0+GIfWBS+2BjlY3JW0BZToNbLmk=
=5p13
-----END PGP SIGNATURE-----

--N7HXVILz59yg1nI8--
