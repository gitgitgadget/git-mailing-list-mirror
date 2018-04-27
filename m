Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B881F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759287AbeD0VIe (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:08:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34996 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759077AbeD0VId (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Apr 2018 17:08:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB40B600FB;
        Fri, 27 Apr 2018 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524863309;
        bh=7xclddLMZzIZNVDvbHRK1z6g09kNTnIDVHMu3UroANE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Hp4mYnRaNUz5CnJo6T41u0uARGBUoTs59jET76BP6kFVxKyhNXsirjrT2Nm8jwi0t
         msIAqbJPuD/Etsy+3iUeWXkMmtKaTlMBafYNp/lg3Cw+GrNVTr6g+EJOkFBJndrfL6
         /4YSKI9UubFnV7ZHi9C3YEpEo+xSqlSPnV9vqgfGl0IFVzRyqxpIDnyPP6fpGxhCkW
         rULd63en/ajFYTKfxZxZ1pIXU98jiMYEPp2mPampAomDrpbyYYI0kF3Mxhv1PQ1YtI
         LRBiImEZPrSTpfYlHIhoSh6JL4lRxPK+aNegoebwceG3u4mOrmdc7L0lmoub/Rm3U9
         4mQp37i7MUHeXVtHof7atHO64kmrdsOoNNy13A/tGHxztLJUTGtPan1lQKDWBLycoj
         YYjOJ7bP/77IBV44bkhogCymZGdfI4zXjwRCZCiclkDxVTv4iD0IxWx6ia0TdX63ON
         YMKSAnV2v9qcRuqECX2sR/qhGgSyHU6xisEyYM5Pj82DQLtHfkm
Date:   Fri, 27 Apr 2018 21:08:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 18/41] index-pack: abstract away hash function constant
Message-ID: <20180427210823.GB722934@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-19-sandals@crustytoothpaste.net>
 <CAN0heSouHbAj8TbiROe=XRsBJ788Vi6P4a_Wvv=7OrdsXqQXHw@mail.gmail.com>
 <20180424235150.GD245996@genre.crustytoothpaste.net>
 <CAN0heSqpj9JfTrnMFRbquraxve9iTwoowgWRUhcD-gXHMg3V=g@mail.gmail.com>
 <CACsJy8DUsFLDb786FmsR+eTriXaWGXEE+ZG8kCjq7JoipN1Phg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <CACsJy8DUsFLDb786FmsR+eTriXaWGXEE+ZG8kCjq7JoipN1Phg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 05:46:28PM +0200, Duy Nguyen wrote:
> On Wed, Apr 25, 2018 at 8:49 PM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
> > Once that is accomplished, I sort of suspect that this code will want to
> > be updated to not always blindly use the_hash_algo, but to always work
> > with SHA-1 sizes. Or rather, this would turn into more generic code to
> > handle both "v2 with SHA-1" and "v3 with some hash function(s)". This
> > commit might be a good first step in that direction.
>=20
> I also have an uneasy feeling when things this close to on-disk file
> format get hash-agnostic treatment. I think we would need to start
> adding new file formats soon, from bottom up with simple things like
> loose object files (cat-file and hash-object should be enough to test
> blobs...), then moving up to pack files and more. This is when we can
> really decide where to use the new hash and whether we should keep
> some hashes as sha-1.

I agree that this is work which needs to be done soon.  There are
basically a couple of pieces we need to handle NewHash:

* Remove the dependencies on SHA-1 as much as possible.
* Get the tests to pass with a different hash (almost done for 160-bit
  hash; in progress for 256-bit hashes).
* Write pack code.
* Write loose object index code.
* Write read-as-SHA-1 code.
* Force the codebase to always use SHA-1 when dealing with fetch/push.
* Distinguish between code which needs to use compatObjectFormat and
  code which needs to use objectFormat.
* Decide on NewHash.

I'm working on the top two bullet points right now.  Others are welcome
to pick up other pieces, or I'll get to them eventually.

As much as I'm dreading having the bikeshedding discussion over what
we're going to pick for NewHash, some of these pieces require knowing
what algorithm it will be.  For example, we have some tests which either
need to be completely rewritten or have a translation table written for
them (think the ones that use colliding short names).  In order for
those tests to have the translation table written, we need to be able to
compute colliding values.  I'm annotating these with prerequisites, but
there are quite a few tests which are skipped.

I expect writing the pack, loose object index, and read-as-SHA-1 code is
going to require having some code for NewHash or stand-in present in
order for it to compile and be tested.  It's possible that others could
come up with more imaginative solutions that don't require that, but I
have my doubts.

> For trailing hashes for example, there's no need to move to a new hash
> which only costs us more cycles. We just use it as a fancy checksum to
> avoid bit flips. But then my assumption about cost may be completely
> wrong without experimenting.

I would argue that consistency is helpful.  Also, do we really want
people to be able to (eventually) create colliding packs that contain
different data?  That doesn't seem like a good idea.

But also, some of the candidates we're considering for NewHash are
actually faster than SHA-1.  So for performance reasons alone, it might
be useful to adopt a consistent scheme.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrjkUcACgkQv1NdgR9S
9otlPhAAxvIeXpcb11aIwtErhf3oEpQoCtlyxirlSatNTsmh2PSL5KaovQIdfIjb
8/pToFaRfqabC43Nx0qmt7OgYivoY81EpI4e4tQoUbLDpeHbYhUiKBSNPM8Z0TNR
biDvKAevpMdDzeuYsHlrCy4i80Oa1jC+F0j77n+7MhKSInmURWy4kJ1HRx7ZQbTp
v20AOohFEKF2QCWg4eGSAp9CKbG9NRnUIqTFNM8dxjSAg7ZfdleUIcfOQ/hgQJmd
YjYhjKWEzUBFBd6JHhzuVVDCEWBlzECMjcnm4wjWclAHot+hDpiWgpVKyhsKGyen
OGyRiVEiZAVxxuf5RYA2oqnH3qxeyGfVJQoaig/NUjTNaglsz2fbSfW2DC5BDIgf
JtCSoIIZsUdacJQlCd5UKeO7zPpL5Po2yPWOcFVpI4HVXQcsM1tWC0uCv0bBXCKl
pnJVyNyseFV7OrwM7YWTY7ZxEClaKMxb921WHb6bq3fZJsM7Biuu99h530k+7nnv
+1HkZ+A8J6DTremuvvU7pnBRef2VseSbJxS0P/VWYHC7wjQfclIy5bXaYvdRwR4C
HRNBXCWeuMGS8zosYOq37+Wmg5VhD9LUm6AQ6B4sw4WeoMq2La2QWyfPt5f8NCo9
dIsuVjUIe91JgpY7GExIU0QGI9MoN8ndY5ez2iYIP+FUppYGYPk=
=RY0/
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
