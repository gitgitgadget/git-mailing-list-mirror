Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC981F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 23:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeJMGwb (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 02:52:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50412 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbeJMGwb (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Oct 2018 02:52:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c8b6:8cda:9f33:1bf5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D32361B73;
        Fri, 12 Oct 2018 23:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539386267;
        bh=q+WTRNXLc9EqN7FDTi5Xn8pz3SZVqbSHSEGiQEKG7Ik=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bGqXgchyGMiVh0MamomPSpBbaBLBN5ny1hselBCpW8Vv9tO/ixQ+QgSWf4QaE4R8J
         NkBaXdlVFPBgNZnkvrP6WRFGDtJWGRjz4m+Y/QZeAlrikKlLGBknakqH3yQ1zztU0u
         ifYktH7hJS5vARP49dNoGQJhIHBKQedViVgzhHPnFUF5f3sC/WbfQTNTGd5Dxyb3sc
         7lzsCtvJIw3lqCVB2yq79s7wFQjxNfX2CBRjKXoyfyeZXzxAMxRAg6j03rhEC0uRy2
         NuEaCZHRVWWpqkgO2fzbx5dgRiBB3wwfn/dq0gyW1GFNSf8pZ9g6JhvnjqWKmmpcWp
         fvONPJSn7u1dneSBpnyLA9+UHFH0elQprGA/Q//jmZxiauPfkpdnDOUhz28Im5IqGj
         NhEfpNgsw18VLdPSAUd2Q6oEhfIiEg9YvTsXK0F0Sg43TNKSfr7hOZ9NCV5IfLufWW
         Np2cE51+h8+wEES75ICCexLN0nKDu+Z47dp0V1zHWiP1cww0HZZ
Date:   Fri, 12 Oct 2018 23:17:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        git@vger.kernel.org, t.gummerer@gmail.com, sunshine@sunshineco.com,
        gitster@pobox.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
Message-ID: <20181012231742.GZ432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>, git@vger.kernel.org,
        t.gummerer@gmail.com, sunshine@sunshineco.com, gitster@pobox.com
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
 <20181011000233.GX432229@genre.crustytoothpaste.net>
 <CAKi4VALL5nnLfo4ZxtifKE1JmcmUQ6F-9GSAQEMxXLjKsCtSmg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1810121122260.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/3zO87W6OPidGKTZ"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1810121122260.45@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/3zO87W6OPidGKTZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 11:24:43AM +0200, Johannes Schindelin wrote:
>=20
>=20
> On Thu, 11 Oct 2018, Lucas De Marchi wrote:
>=20
> > On Wed, Oct 10, 2018 at 5:02 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >
> > > On Wed, Oct 10, 2018 at 08:09:16AM -0700, Lucas De Marchi wrote:
> > > > Do like it's done in grep so mode doesn't end up as
> > > > 0160000, which means range-diff doesn't work if one has
> > > > "submodule.diff =3D log" in the configuration. Without this
> > > > while using range-diff I only get a
> > > >
> > > >     Submodule a 0000000...0000000 (new submodule)
> > > >
> > > > instead of the diff between the revisions.
> > > >
> > > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > ---
> > > >  range-diff.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/range-diff.c b/range-diff.c
> > > > index 60edb2f518..bd8083f2d1 100644
> > > > --- a/range-diff.c
> > > > +++ b/range-diff.c
> > > > @@ -354,7 +354,7 @@ static struct diff_filespec *get_filespec(const=
 char *name, const char *p)
> > > >  {
> > > >       struct diff_filespec *spec =3D alloc_filespec(name);
> > > >
> > > > -     fill_filespec(spec, &null_oid, 0, 0644);
> > > > +     fill_filespec(spec, &null_oid, 0, 0100644);
> > >
> > > If we have a system that has different mode values from the common Un=
ix
> > > ones, is this still correct or does it need to change?
> >=20
> > From what I can see this would still be correct, or at least git-grep
> > implementation would be broken.
>=20
> As you can see from the Windows port: we are stuck with the simplistic
> POSIX permissions in Git, and platforms that have a different permission
> system have to emulate it.

I think I may not have explained myself well.  There are a small number
of POSIXy systems which have mode bits that differ from the common ones
(e.g., a plain file is something other than 0100000).  I think one
person mentioned on the list that they have a homebrew Unix that works
this way, and I think I may have heard of some minor commercial Unices
that work this way as well.

My question was intended to ask whether we should be using an
OS-provided constant (e.g., S_IFREG) that represented that value
differently because it was a system value or whether it was the internal
Git representation.

I hadn't intended to inquire about Windows, as I was fairly confident
that this syntax does indeed work there through our compatibility layers
(because it has in the past even when we've had these kinds of issues on
other Unices).  But I'm glad that you chimed in and confirmed that it
does.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/3zO87W6OPidGKTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvBK5YACgkQv1NdgR9S
9oskNBAAlcG8tyHAWFPxdIFlnR7ltOdAcL9uHhzVtYHyw9Jl3MJIXn0wKjW+WMT6
6frBFqi7l6WkWBEq71xi7/FrcSITEovE7XlWhspH1FhWyNfldBKeVbdrG147ReUN
XlXRWznVRI7BPENBSZEPXaOdy/5cUGUdx7BaFYHi7C0M4DTTtrsl44s+7R0uBljb
c70emXC7uiYbDqryQWI+z3s+VNMY/1mse3fy4oNwAKchGlXWUn6HSXZGYp23nm5q
9AwqixvaJsGHvw1+6jX3G9ImlT8GmL1JLR5SCzDS5af2QmnVbZz6YTzzz4FrqPVb
PRZmNp45at/mKUINj+4ubWh3T3YlbKc+IIcWqPj58ev2PbovixiQiu7SY03pEA1c
8clPqOjOle+B8vMDpIo3Yvvcbc6EgNLfTtY2eMlTZJqZR8cK+5sbjgBV2YBuKslc
/aYc3jgaA4zrADj+QaE58a9JGZCA9XqzXyOHnVQHwghTB59Tv1cjgNsMxAFSrPj9
7wDuQVCRY1u/NVKB0xlrjLEpfZgGkoaBPR52X+kc8f+WPZwlaKl/AZo7yV/NPj0N
kRgXwQz96XwIPGa+lEY4B8K54TcXpglptaxndO1XBmnXpTvdAhExyBQwNSwrgu9+
S8oVvfzJ2ea3A6GV6Gb2xR8w/kjOsnc+5Y7QxwhOI0XJokFTcxo=
=Lpiz
-----END PGP SIGNATURE-----

--/3zO87W6OPidGKTZ--
