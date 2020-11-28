Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED9EC83012
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBB7221FD
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgK1Vtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49704 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730568AbgK1SmJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Nov 2020 13:42:09 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A9DD660743;
        Sat, 28 Nov 2020 18:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1606588888;
        bh=6GOUGCfXCwrL8SSNMbmffspzlpuYiiak/XwA1JeGj74=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gFieqphErq0tPNkrTC6VwAkua0Iq8Nf/8ZFifqStVGzwriYoifIKNbIZQBWrMknOS
         LWXxmuwLIDygkdBdKf7LQVNczp/ZGvElv4bhjRpvF0CQCYDK/5/p6LJgCu6ADQlpLH
         0dpv/6psmp8bwd7bdKyhoNMf1PI/anB7PIKVkXh0zI7bKxgI8tGb6wpkHyRW5qUl+k
         9IDD2Mt4HTKUP7+vCfqCztpAz+dtHEFVub4LQgukFrNl3pHc/IkPbgV1UNpq2ZCZ1k
         e2jKi8bkonVAvGXwjrZKLuarUDC3KXsqSWk/Z8xcqXXrzgDIEUG/zzXsPbu2JAQvSB
         dZhBXlUPZXhhWow9T8zlhM7Td04klGsHzysl9Kr0YuZd286QfE0zM2uBNCzNlNqgfI
         AqddIjqqYrgu5bgUCxXsRetD67P4Q0iQfiMwX/YcjsyqTLFQf0oS4WiBUFQ2+SoibG
         Nv48Smm80ZpVrjDKNAAawyIAwlaky+TlJYgJESPQlfOCQUbfTzM
Date:   Sat, 28 Nov 2020 18:41:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 1/2] abspath: add a function to resolve paths with
 missing components
Message-ID: <X8KZ0gd85g7fhqm5@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
References: <20201127231916.609852-1-sandals@crustytoothpaste.net>
 <20201127231916.609852-2-sandals@crustytoothpaste.net>
 <374553d7-6027-0152-bf56-9395e8268fa9@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SAF/HeR/vxgAPYdH"
Content-Disposition: inline
In-Reply-To: <374553d7-6027-0152-bf56-9395e8268fa9@web.de>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SAF/HeR/vxgAPYdH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-28 at 10:08:09, Ren=C3=A9 Scharfe wrote:
> Am 28.11.20 um 00:19 schrieb brian m. carlson:
> > We'd like to canonicalize paths such that we can preserve any number of
> > trailing components that may be missing.  Let's add a function to do
> > that, taking the number of components to canonicalize, and make
> > strbuf_realpath a wrapper around it that allows just one component.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  abspath.c | 33 ++++++++++++++++++++++++++++++++-
> >  cache.h   |  2 ++
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/abspath.c b/abspath.c
> > index 6f15a418bb..1d8f3d007c 100644
> > --- a/abspath.c
> > +++ b/abspath.c
> > @@ -20,6 +20,7 @@ static void strip_last_component(struct strbuf *path)
> >  	/* Find start of the last component */
> >  	while (offset < len && !is_dir_sep(path->buf[len - 1]))
> >  		len--;
> > +
> >  	/* Skip sequences of multiple path-separators */
> >  	while (offset < len && is_dir_sep(path->buf[len - 1]))
> >  		len--;
>=20
> Stray change?

Ah, yes.  I pulled out the old code from v2, but left the whitespace.
Will fix.

> Nitpicking: Do we need both empty lines?

No, we don't.

> >  /*
> >   * Return the real path (i.e., absolute path, with symlinks resolved
> >   * and extra slashes removed) equivalent to the specified path.  (If
> > @@ -80,6 +97,16 @@ static void get_root_part(struct strbuf *resolved, s=
truct strbuf *remaining)
> >   */
> >  char *strbuf_realpath(struct strbuf *resolved, const char *path,
> >  		      int die_on_error)
> > +{
> > +	return strbuf_realpath_missing(resolved, path, 1, die_on_error);
> > +}
> > +
> > +/*
> > + * Just like strbuf_realpath, but allows specifying how many missing c=
omponents
> > + * are permitted.  -1 may be specified to allow an unlimited number.
> > + */
> > +char *strbuf_realpath_missing(struct strbuf *resolved, const char *pat=
h,
> > +			      int missing_components, int die_on_error)
> >  {
> >  	struct strbuf remaining =3D STRBUF_INIT;
> >  	struct strbuf next =3D STRBUF_INIT;
> > @@ -128,8 +155,12 @@ char *strbuf_realpath(struct strbuf *resolved, con=
st char *path,
> >  		strbuf_addbuf(resolved, &next);
> >
> >  		if (lstat(resolved->buf, &st)) {
> > +			int trailing_components =3D count_dir_separators(remaining.buf) +
> > +						  (remaining.len !=3D 0);
>=20
> Hmm, so you actually want to count path components, not separators.
> Perhaps like this?
>=20
> 	static size_t count_components(const char *p)
> 	{
> 		size_t n =3D 0;
> 		while (*p) {
> 			while (*p && !is_dir_sep(*p))
> 				p++;
> 			while (is_dir_sep(*p))
> 				p++;
> 			n++;
> 		}
> 		return n;
> 	}

Yeah, I think that's nicer, and simpler, too.  Will reroll with that
fix.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--SAF/HeR/vxgAPYdH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX8KZ0QAKCRB8DEliiIei
gePwAP9RnHtZbFom7ak1beJxbtlcYku/ctk3KOSwp9FB01jhQAD/cvZqX+GWeKd8
Nx0tw1u6TwK3wLzi19a9QbH/wVlCPg8=
=n1vz
-----END PGP SIGNATURE-----

--SAF/HeR/vxgAPYdH--
