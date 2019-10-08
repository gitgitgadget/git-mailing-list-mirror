Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351AC1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 19:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfJHTkV (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 15:40:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728465AbfJHTkV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Oct 2019 15:40:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5ADCF61C5F;
        Tue,  8 Oct 2019 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570563619;
        bh=m67q8NcItt8esC1GXy2v36RH4VIZBBcUnwJsb3EF8jI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=chQvZXV700qbWSr1hquF5it8UiQpOlC3S6Unpj2k6PylFbibjgaLrGXQylCeeOG5V
         Ce0yIUD+6GoXu4JiCK95eyD0aNfcj9fAtYptyurY5FaaaC6RKTQhcBKiNmL3VRoj2H
         fKOy1Z5+vFWLFlmHOtrslarKpOT48hLXeMPuscwLDmcBizWCSTbzZcZNUPyiFgPplG
         J5y+KSsR4NsTFK0AYdtqm2F7JVyXlmuHtATqQY3H8yuCXFQqikHqeqbVUmxAK49X8J
         Zl+SXjrQlQbv9K4qqgcJ7hrIEfwo+69z8s5sbh5a/A9MXbXW/qpA1YCuKsn98xIXKs
         f7xGdyXvbwX1ZNmhxjp2U0TGWEEc8AR+546vL7Zh3zNANmZ2WLtuSg115mvfOlnU49
         Tle/vnuhr6Yn/a1GFfDOqlUVpFneKjD7UAjTO9LgfwVIJjmuQ+Ywyh/89jVBbWyuPR
         DbWHcbLp2kJWvohAxtNWJb4O0njmR/Zew3+JqLKmHnTqobuCrSR
Date:   Tue, 8 Oct 2019 19:40:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/15] t4011: abstract away SHA-1-specific constants
Message-ID: <20191008194012.4s35pbwbh25rblhb@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
 <20191005211209.18237-8-sandals@crustytoothpaste.net>
 <4733b8a0-bfd9-a49a-01d2-1c9f2a48cdf8@gmail.com>
 <CAKPyHN3NaBv5s9aefb8fTDeGto2tLyTa0DxTjbWO9pGRY22pPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="233i6ajl7kfkppcb"
Content-Disposition: inline
In-Reply-To: <CAKPyHN3NaBv5s9aefb8fTDeGto2tLyTa0DxTjbWO9pGRY22pPQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-trunk-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--233i6ajl7kfkppcb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-08 at 12:33:43, Bert Wesarg wrote:
> On Tue, Oct 8, 2019 at 2:21 PM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 10/5/2019 5:12 PM, brian m. carlson wrote:
> > > Adjust the test so that it computes variables for object IDs instead =
of
> > > using hard-coded hashes.
> >
> > [snip]
> >
> > > @@ -137,14 +141,17 @@ test_expect_success SYMLINKS 'setup symlinks wi=
th attributes' '
> > >  '
> > >
> > >  test_expect_success SYMLINKS 'symlinks do not respect userdiff confi=
g by path' '
> > > -     cat >expect <<-\EOF &&
> > > +     file=3D$(git rev-parse --short $(git hash-object file.bin)) &&
> > > +     link=3D$(git rev-parse --short \
> > > +             $(printf file.bin | git hash-object --stdin)) &&
> >
> > Why this change from $(git hash-object file.bin) to
> > $(printf file.bin | git hash-object --stdin)?
>=20
> thats two different things. The first hashes the content of file
> "file.bin". The second hashes the literal string "file.bin". To avoid
> this confusion, may I suggest to use 'printf "%s" "file.bin"', so that
> it is clear, that the literal string is meant in this context?

This is completely correct, and, yes, I can definitely make that change.
In fact, the fact that this is confusing probably means I should use a
suitably named shell function for this, so I'll make that change when I
reroll.

> > For that matter, why are you using the "printf|git hash-object"
> > pattern throughout your change? Seems like an unnecessary hurdle
> > to me.

I would normally use echo for these types of things (because that's our
style and it's more customary), but in this case the symlink contents
don't contain a newline, so printf is required.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--233i6ajl7kfkppcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2c5hwACgkQv1NdgR9S
9otQ8A/9HyZ15IOULiy7+nln4bxqxjnynJSSqlrOztr34kP45qVoLUyL8tsBMEIH
iReG4dj/o34Nm6ywPFOeRVm3aSNJp3O7DOnyWoPtoic1hXrUOfm2B1Sx7aUhg9sI
ADi9gJaB10+FB1QdyRTYN8BGVQXfkhsbH9OfEUA7ICBecKR16eqZQuexSULj168Q
vj+16MotHIiIHOxRUUNQidlYlQhtL+uVYf2yYqDdSk2rHYYOyD+jHhQzSnwq+DDt
A7ECymnSt5l2X8ZHU9g4/idsGP2vL31R2YCGVlOOm5nV7lVthilPqd+wgSsi7lEv
QO+q3GPoVOcpSX4dD1SdB+PSr5Xz1B7XLC3UQu9UadMPpRMNsjZuEUGRCYDIHJW8
+9aO3PoGDt6290cmP1Ln4OwjkccGpmirbncKr1Dx322qHIfqt3AWIsTqqUmnL/+F
h9hmvXsfTfdR3NPQKi0fVNUJKqkCro/5nCuACbSPRSOi5H/FPxh22m2H3bXSZPvY
8QE5yC7rHqxs0/OKmpZKbl0cOzhpiJwCQh//Ato9N9yNJVOqKZrWD8hfJhQJIVMl
eTQVbOV47CDYeF59Ns1XD6NA1lYFob3QsIvfqG9KDDzS7MCJcZAJwmLtxMqq+jD6
CxZM3UJDoX6UQ4QHEPfiqyBF4PhEj3Nq1Ra+eiqDtbHqNjY4nI0=
=Yh9K
-----END PGP SIGNATURE-----

--233i6ajl7kfkppcb--
