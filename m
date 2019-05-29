Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7FC11F462
	for <e@80x24.org>; Wed, 29 May 2019 02:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfE2CS2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 22:18:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36800 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbfE2CS0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 22:18:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5881:abd5:52a:5d54])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7763060443;
        Wed, 29 May 2019 02:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1559096304;
        bh=9rgHcznqDB/Nzu3mSxxY6CyYYiqvaWXs7XkXtbmD8R4=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wScC8LKWq4FaXNdOA5IWqXL+AWU+rNuZ0Z0Wr1bLB5xhjerHY+49zHguRiAQKcRBB
         +5Pu4ahu8s8YqDTt/nr4ygImBlMcv0jn5fWccuDc6JDzGaGMeBQgatUrfdeb8uAD2U
         b8ZCSy0O6GQdH3v9UZaDTKbeDFYNRD00lDr5upViq9B80lBs9ZpDwJ8jxKIDae+mR7
         Hk9HIexbmmNDHgjHzO9NCADs3gPp0YStHEHmF5tNRFKJmAGhDji8CIolYV1BZHLbsh
         z1KQzfBGRr5UjGjLW9QsH+3J38UGlu6hp0i8G7OGyvEmjAYoeOl7Ilj4E45iE6qSl2
         S0YINtbCIgYWsZQiQiQMXZ/h6NsNsGu5JYD6RYba4+v6LnQteAGccMqZp3qu3V3P1r
         fnloMk+O5bjZERRO03d5qiJ/SJj8MnQ9+wR0cRoKfUvmY+w3ittAR8A4M27jouX/Q8
         1kWFDB9S1y7ye30IihdtMsRQHDB1YCfec+N2jE0HcDFc+zVoJB1
Date:   Wed, 29 May 2019 02:18:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/7] run-command: add preliminary support for multiple
 hooks
Message-ID: <20190529021816.GI8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-2-sandals@crustytoothpaste.net>
 <CACsJy8Ba98baQ2wZnMZyEva6gxO1ROZ4qJFTOdrCUXDMwrHnXA@mail.gmail.com>
 <20190515222756.GJ7458@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline
In-Reply-To: <20190515222756.GJ7458@genre.crustytoothpaste.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-15 at 22:27:56, brian m. carlson wrote:
> On Tue, May 14, 2019 at 07:46:17PM +0700, Duy Nguyen wrote:
> > 'struct string_list;' should be enough (and a bit lighter) although I
> > don't suppose it really matters.
>=20
> I can make that change.

One thing I noticed when making this change is that we're going to need
the definition of the struct string_list in a later patch in the series
(originally to define a variable, but now to define a struct). So
knowing that, I think it makes sense for us to just include the header
up front, since we're going to be using it a few patches later.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzt6+gACgkQv1NdgR9S
9ostUg/9FXfr7vE/pZRz3OnCftYBoYIvuBGT8QGHzgrN3E1j9Gj0J3RHReJSxhM+
1iSB/iUu3vGzQWpJnmMlid2DOS0nzEhmY80VYJgO9ITFldyIopK+n+56ay+THjyl
RzM9chJv5XTebaU5Fyle+qcPdxrW6xfY36WJfxh2CxpFb7YDr9bCcGFrqNjoURyE
g8Xr2BUXOZMXrKiM0a70kQGxj9lj66BA4z8GJSSj3az1Cypaa1cOvsTudqUqExgh
MboVa+VfnEQdK7WPZTFYVdfHbro5Z+/6edUPv2FpqhSSk3dJl9fz/ujIXbdRg/qD
zP7EUlmLCcBcW4rz5t+uITSbrViX0cJFQEbAsSh37Xk42eTdghHGWMIwoulOMl8U
GF7XbHQrwpReo/xFFIuXsqMDqyHysmNeLiHLdJkag/G6YHOemO7OJaOkJxT0A6ow
KLdrfb/cxkjUz/OLnm70tFtMGISa6XQ/bBgWMFLznp+RO60tSp+tapc20SRma+zI
zLFhijg9paPoUVkJDbL+6uHAx6O7LTAMYHWG63eyxaIW8Mk+dvuwLbHFbUpvxSiX
a8dYTjbZFyvFYKzGM+0ASqxqNP+9UBvkWtzwz6GLi/vW+OxAF23i0yKldyYo1Wwl
FbmknemMsGL8G39Wt8jcz8aMFfi7sVR4WX8cdi9O4yf/y0eo21M=
=N8um
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
