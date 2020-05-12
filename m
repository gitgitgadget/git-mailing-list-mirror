Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617DEC2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4DF206F5
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vdgs2QJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgELXhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 19:37:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38070 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgELXhs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 19:37:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5C13B60427;
        Tue, 12 May 2020 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589326666;
        bh=KRV/8DNBkssS9W6XXxpwv/0m+Dtob4jmJMSFBSIofns=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vdgs2QJXKnqFgesJYtTnCV64pdsyZCCX8xgnizY1rNqB2z/U1jGj/nLqBYjI/xw4I
         8RSkXJ5oheKEYrh0Lud95ifP8W5N5LSYnwhGjYYW9nOwDYNuuDPNLmzy7csP9lB4UZ
         +qZWMkfmWtxBXAxVJH+TwG4ALB4pq89gwE0Yt9l850Ess22YOL3r9vkPLs7GjNZFQK
         /4p5/ry+ujf/OR/6kei1p+OxLfpv+NFpfHSTPFwqWRGg2MGvUYYzECs5cDiw6luYnh
         seUiU8cOG0alkmD32Zm4gk+D+Uyx5KV0qh5PwH2Otn28KhNNWRwMF8dcoaZGEwIalY
         /jIwtESTKUcdWiEqJ4lCsJgHBt3qvhbWPAqHMat80wH8XyWBha+2BhkoX9pGQof8sZ
         0B9jIlC1FnaDBlOr5cYgitdWX5yeJ1zJ1IDcc3KRUwvQkHDsAyKYGdfKgmHubAK7Xx
         fWgquMQH4bIAC/YVLHrovLy1AltPu7Ieg05560XBrQ3j5UKfkz5
Date:   Tue, 12 May 2020 23:37:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: How to move forward with Reftable
Message-ID: <20200512233741.GB6605@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Patrick Steinhardt <ps@pks.im>
References: <CAFQ2z_Ne-1TWMRS88ADhzQmx4OfzNEkVUJ1anjf57mQD4Gdywg@mail.gmail.com>
 <20200511183602.GA141481@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20200511183602.GA141481@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-11 at 18:36:02, Jonathan Nieder wrote:
> Separate from the integration aspect is that this is not yet
> battle-tested code.  One benefit of sharing code is to be able to share
> the benefit of users testing it.
>=20
> Since the ref system is fairly modular and this is about a non-default
> backend, it's likely okay to integrate it initially as "experimental"
> and then update docs as we gain confidence.

If we're going to integrate it, I would like to pass the testsuite when
we do.  We can certainly do a series of preparatory patches (e.g., to
the testsuite) to get it ready, but once people can turn it on or use it
(via config, I assume), it should be fully functional and tested.

Having said that, I agree we should mark it as experimental first, at
least for a while.  I'm interested to see how it works both from a
functionality perspective as well as a performance perspective.  For
example, is reftable a win with a relatively large number of refs (say,
tens of thousands)?  Operational experience will tell us that and help
guide us to figure out if and when it should be the default.

> > Johannes had suggested that this should be developed and maintained in
> > git-core first, and the result could then be reused by libgit2
> > project. According to the libgit2 folks, this what that would look
> > like:
> >
> > """
> >     - It needs to be easy to split out from git-core. If it is
> >       self-contained in a single directory, then I'd be sufficiently
> >       happy already.
> >
> >     - It should continue providing a clean interface to external
> >       callers. This also means that its interface should stay stable so
> >       we don't have to adapt on every update. git-core historically
> >       never had such promises, but it kind of worked out for the xdiff
> >       code.
> >
> >     - My most important fear would be that the reftable interface
> >       becomes heavily dependent on git-core's own data types. We had
> >       this discussion at the Contributor's Summit already, but if it
> >       starts adopting things like git-core's own string buffer then it
> >       would become a lot harder for us to use it.
> >
> >     - Probably obvious, but contained in the above is that it stays
> >       compilable on its own. So even if you split out its directory and
> >       wire up some build instructions, it should not have any
> >       dependencies on git-core.
> > """
> >
> > (for the discussion at the summit:
> > https://lore.kernel.org/git/1B71B54C-E000-4CEB-8AC6-3DB86E96E31A@jramsa=
y.com.au/)
> >
> > I can make that work, but it would be good to know if this is
> > something the project is OK with in principle, or whether the code
> > needs to be completely Git-ified. If the latter happens, that would
> > effectively fork the code, which I think is a missed opportunity.
>=20
> There's been some discussion about use of strbuf versus the module's
> own growing-buffer "struct slice".  Is that the only instance of this
> kind of infrastructure duplication or are there others?

There's duplication of the hash algorithm stuff.  I don't know what else
because I haven't taken an in-depth look at the code other than for
SHA-256 compatibility.  I think Dscho has more insight here.

In general, my view here is that if this is going to be a part of core
Git, then it should live in core Git and use our standard tooling.  If
this is going to be a logically independent shared library (like zlib)
or an optional feature that one can compile with or not, then it can
live outside of the tree as a separate project (and shared library) that
we link against.

We've already seen a bunch of compatibility pain from sha1dc, which has
a much smaller, more well-defined interface.  I'd like to not repeat
that behavior with the reftable code, especially since Git runs on a
wide variety of systems and has significant compatibility needs.

I also don't love the fact that we have an update script that overwrites
all of our changes with the upstream code when there are some of us who
have no intention of contributing to upstream (e.g., for CLA reasons).
Barring some way of addressing those concerns, I think we're going to
need to assume that updates require some sort of manual rebase work like
with other code that we import.

> Yes, I'm *very* excited that the series includes a knob for running
> the testsuite using the reftable ref backend, providing a way for
> anyone interested to pitch in to help with the issues they reveal
> (both in Git and in its testsuite).

I think this is a good feature to have and definitely the right way
forward.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrszRQAKCRB8DEliiIei
gRtnAQCQ2Q/qUphNjb0Bre5gr5vphXR++IIxCtxMFK6tbNktSwD9GZDOKqopMgvI
yk/RMZpuSkZgpbX8/VEFxv5LhdeGeAg=
=1oYU
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
