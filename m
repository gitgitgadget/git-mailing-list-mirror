Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FBD201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbdB1Uqs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:46:48 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41716 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751332AbdB1Uqp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 15:46:45 -0500
Received: from genre.crustytoothpaste.net (wsip-98-185-58-71.no.no.cox.net [98.185.58.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F3A9E280AF;
        Tue, 28 Feb 2017 20:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488314733;
        bh=5/KIZ10rdOKhGx65Vsqb29/Wmh4fFchvdHVVpvFH7Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eh7rxww85yfxTcf695VfZsuGOi4nsIg5p4t6fVRiy1Ik1bGkz4Ysb70phVSyjQ7BM
         8w9nTH1sI2jfDOkCu5WZvdlzQ1T6ROa+AQDEOSUxwJ3GKuRXKQV/nDamR7DLn9ySrF
         6KDMh1BZruN1cILpjwdyahFd3/FWQtHnkgDJW2Ecb3KcchAyq6sw1WK/02W4Vn3V6i
         onXzt7mkOdyMzY7J7mF++oEJI9B74+EaYkitBvRJWqPrDuKR3B1fhb2C5AKpUMpLEb
         wdYiEde3OxP+py33DpfTvVq1HM9b7Tqlml9jsR/gKVe5qkoATFUrZNQZLjo2EABOtM
         qF7tdrmT1Xb5Kxny+Rnc1F9NZTDDizYzU+SulUhHI4Q9TH7HhCzoS9v60Mr9dyNj9v
         SHQBi6bkt4Bs6yKHzGBDj/pm3mk/WClmk9OR38KOd8d6jHGi4/Nvo+xHnq65aUcr0i
         z8fYHwiEfoj07WjeAUUkgPQTXGLRJvYnaBEjLSqHCHdmYIExc8t
Date:   Tue, 28 Feb 2017 20:45:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Typesafer git hash patch
Message-ID: <20170228204528.glpmouvcx33zma65@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+55aFxYs1zp2c-UPe8EfshNNOxRVxZ2H+ipsnG489NBsE+DLQ@mail.gmail.com>
 <xmqqvarujdmv.fsf@gitster.mtv.corp.google.com>
 <CA+55aFzUhWinWqK30GBc1BKy-v6QtDdO2BLUODkiqg9XoKLrwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iwxshhduhrn27bbm"
Content-Disposition: inline
In-Reply-To: <CA+55aFzUhWinWqK30GBc1BKy-v6QtDdO2BLUODkiqg9XoKLrwA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iwxshhduhrn27bbm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 12:25:20PM -0800, Linus Torvalds wrote:
> On Tue, Feb 28, 2017 at 11:53 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> > Sorry, but at this point in your description, you completely lost
> > me.  I thought "struct object_id" was what you call "hash_t" in the
> > above.
>=20
> So what happened was that I started out just encapsulating
>=20
>    unsigned char sha1[20];
>=20
> as a
>=20
>    hash_t hash;
>=20
> and that made sense in a lot of situations. I always thought that code th=
at used
>=20
>     struct object_id oid;
>=20
> is just too ugly to live, so I'm not actually all that big of a fan of
> the oid approach.

There was some discussion on the list about the best name to use, and
object_id seemed like the most popular decision.  I don't care if we add
a typedef for it and prefer that typedef, but the existing code avoided
typedefs in favor of explicit struct definitions.

I'm certainly not opposed to having less to type, because =E2=80=9Cobject_i=
d=E2=80=9D is
awkward to type, but I've generally tried to defer to existing uses in
the codebase and what list regulars are comfortable with.

The only problem with using hash_t is that it's then not obvious as we
transition (assuming we don't take an omnibus patch) what is converted
and what isn't.

> But the two approaches really are pretty much equivalent logically,
> even if they don't look the same.

Yeah, I think they are.

> So I wanted to unify things: "One type to bring them all and in the
> darkness bind them".
>=20
> So I just basically made this:
>=20
>     typedef struct object_id {
>             unsigned char hash[GIT_HASH_SIZE];
>     } hash_t;
>=20
> to create one single data structure that doesn't make my eyes bleed.
> That "struct object_id" still exists, but I don't generally have to
> look at it when doing the conversion, and any current users "just
> work".

There is nothing that prevents us from doing a nice global
search-and-replace in the future if we think the status quo is bad.
That's something that could be automated with Coccinelle.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--iwxshhduhrn27bbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAli14WgACgkQv1NdgR9S
9otcZhAAi3Qk+zb+kNLVlka7QQACkVTKI5+j//dhuM3e4P8Hf5cM5WdaaDFNJ4mN
5FwhhuvG9q452FuV67UBQlUiI05DIeN4cH5U3Be1soTLlhv1p+4clja+0HBamv84
A708eolMI+OWtp3UvifQ2yipfp1omOgp4bvXuITgmWy20V2U7MnGwFYnYl4ca9Gg
tVsf832aFittLrplUXSw5xeO/FCV2OqVA3JBZ4MPzorKNYRJp0hrJnuH6vVcleC8
BwjrMfaLE3GO1oBB0TdF4x5fEceYrxCvLFnxbpYGvtLYTv/vEptXKmjwPiT1Dagf
7JcZ5yFdvftZ+t8layMnCi2WdnSfxKJoeYGJ96CNHWXLwQIXf0iA4f2oH2pa/HI3
lrsRGVPeLbT0jzstsWDsidFk5oja6GldkysbU/8QRNQDMUtBsb2iwQiUhF7vNZ86
jJzhK8DkQ/7cLmwJKZaXiw0/Z+2kZFz/G8k+8LLo0mGt0GxxQ96QC11aNt0xmv8+
UMTRKcqym8TJwUB1gaC7b89z8MsxCTp1+6NEeUEwt6H7LQTBNvmt2OUrW8A2PzGN
3uf5R8CXjiHdEslzaXyleQ6BEn71C4arh5t90jQFAiFGp9uQOPcwbOIePLXYTuNu
j1hKsEXMh61vS4qMbbb6tI7+QZcHJ3AV6D5sie2j78OSqBPwe9Q=
=IC7S
-----END PGP SIGNATURE-----

--iwxshhduhrn27bbm--
