Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2517732
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dSuz4hL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RC2ok5j8"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD12DC4
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 04:57:30 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 54B075C0125;
	Fri, 27 Oct 2023 07:57:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 07:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698407850; x=1698494250; bh=ls
	ur+kFJtsjlzYKVkt2Ig8yz9P/JDzhYYiiZq5t8AsE=; b=dSuz4hL1gKMQTmepmU
	jrxUdO9PmjvsjlPmKB1aVP8mVfD5lbVCygV09gIZHKC8qB4/sk664T4HumAQW/2i
	QHSpbgaO+MmcoTiyOwk21M/FvbqEBS/e9CUtVdQOOMPCoouw6gaAWhSQbgJOMboS
	rraFzndDTr4HyCakHfwqzPspVSaOxzkCL84gJpOwEouWeX6dhYEbnNv2kQtWa/u5
	mEBKwqDBJCz1PI3npVb0S0eYvPnH6xpxizcnof6KjKMdAQKYqVwPFfaPfkesiXNs
	PxjAZx5pW7BwaCVVrtWo09v0u/Zpc/PYNlYi4bEYKaRAMW8XEUw1Ns+KVt2VDYv0
	HRsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698407850; x=1698494250; bh=lsur+kFJtsjlz
	YKVkt2Ig8yz9P/JDzhYYiiZq5t8AsE=; b=RC2ok5j8Orj6xEGESbYeGA++trIDc
	bDum9fz/ILKqgOyR9Cyth30q+cPxeM1BQkGSWjxTL5cTBKNH4r3CczaaoiQQnkJs
	AN1tCwhjn/23ruecsZ5rfyLiR+LgTpYHvSLlWROGkhFlxdLevnVD0rAOPdxYW8qd
	3f3NQIiDI/n5oXmoCpC0piPCzHNaJid0JzT0K0fBrK1EeZlU9u7QDuTQfbjZs3lP
	QGBBr/COVk1cD+s2odv5GsoGCvm5KERIV2PpAa7FZVr4jeDvHp6G8J2K7sHY6un5
	oyGs02EwzRDk+EoEVJqfcYiHgGpi3w0r9v2baxADFDQP8CVG/s8vjW9cQ==
X-ME-Sender: <xms:p6U7ZQEU6o6ohu4R8zrMqVYklCUggcyIJkMx8TgN-4qhzxoi8711ug>
    <xme:p6U7ZZWGhb7n8rgQ7ucJ2_z2Bme2tI4RQKH3-n-nd_3Jx5ApkmUgO2O_4AGmRDMrY
    ypavgyDEoGJXZQ9Tg>
X-ME-Received: <xmr:p6U7ZaKDgFSA801_uiLvdGH97Ac1ZJOHDEVhWM7T0DLPGNV8bgMJSuiXYqI1QjN7TEqCs8wWFc7VgZz9Jfy15FS53BQh1pRwyFYkVA5yQAhatg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:p6U7ZSEEN4sUjHHPEqexLrRsWoe9VmcSeATwEmwf96HhOBvyYo6bTA>
    <xmx:p6U7ZWUs0lzu0ZhouosmklAR2w0-HN06vpFftfSZpVzV9VcT69Vgzw>
    <xmx:p6U7ZVNBYl0duFpovqcHMlQuwsfFn47IwdpHwsExQAt3V6ewTDndjw>
    <xmx:qqU7ZZcSxFCNRnWSO_s7hHumiPP9TGwChBBGmRq2NilKInwm9z1vIA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 07:57:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01fe5dcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 11:57:14 +0000 (UTC)
Date: Fri, 27 Oct 2023 13:57:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Message-ID: <ZTulo_rh_G-lfICQ@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com>
 <ZTucxlBR1VrJPuSK@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9IfYibZD2R2iqPDh"
Content-Disposition: inline
In-Reply-To: <ZTucxlBR1VrJPuSK@tanuki>


--9IfYibZD2R2iqPDh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 01:19:35PM +0200, Patrick Steinhardt wrote:
> On Fri, Oct 27, 2023 at 11:19:04AM +0100, Phillip Wood wrote:
> > On 27/10/2023 10:25, Patrick Steinhardt wrote:
[snip]
> > > diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-de=
pendencies.sh
> > > index d0bc19d3bb3..1cd92db1876 100755
> > > --- a/ci/install-docker-dependencies.sh
> > > +++ b/ci/install-docker-dependencies.sh
> > > @@ -7,6 +7,9 @@
> > >   begin_group "Install dependencies"
> > > +# Required so that apt doesn't wait for user input on certain packag=
es.
> > > +export DEBIAN_FRONTEND=3Dnoninteractive
> > > +
> > >   case "$jobname" in
> > >   linux32)
> > >   	linux32 --32bit i386 sh -c '
> > > @@ -16,9 +19,13 @@ linux32)
> > >   	'
> > >   	;;
> > >   linux-musl)
> > > -	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
> > > +	apk add --update git shadow sudo build-base curl-dev openssl-dev ex=
pat-dev gettext \
> > >   		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
> >=20
> > It would be helpful to explain the new dependencies in the commit messa=
ge. I
> > can see why you're adding sudo, but how were we getting away without
> > installing the other packages for GitHub Actions?
>=20
> True, that part is missing.
>=20
> - Both sudo and shadow are now required because of `useradd` that we use
>   to set up the unprivileged build.
>=20
> - Git has been required all along, I think. `save_good_tree ()` is used
>   in our CI scripts, and Toon (fellow GitLabber from my team) has
>   noticed that the CI job warned about missing Git. The warning was
>   mostly benign as it seems, but still, doesn't hurt to fix it while at
>   it.
>=20
> I'll have a look at whether I can add another patch on top that adjusts
> `ci/run-docker-build.sh` to do rootless builds, which would also make it
> more obvious why we now need to install sudo and shadow. And I'll make
> sure to document why we now need to have Git around.

Hum. After having a look at `ci/run-docker-build.sh` I don't feel like
it's sensible to update it. It's not even used anymore by our CI but
only by `ci/run-docker.sh`, which seems to be more of a developer-facing
script?

As you said, this smells like rotting bits that might rather be removed.
But in any case, as they don't relate to our current CI infrastructure
except for being in "ci/" I'll leave them be for now.

Patrick

--9IfYibZD2R2iqPDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7paIACgkQVbJhu7ck
PpQVZw/+Kf0TnfID/YdW/qquzUjR9eJ2HWOvS0NGtKgpCZaZxv53yPRtArrACc6c
qE+4QyjddiQtABmhr/CjoCo/rVH7mdvcjPXKuOt5YL5YRVxA/4Xt3PRo8d7gmyBT
lL7XrdgEVfICmVilpPbAUlI3uVRffOumwTRxQ0ngNx0n44J1gYVF8xV23XOpP/iz
Xcqfkvzc2+kuR0rezcXQqyKCXWuL3DOKBFBy48JhssG6ndyOv0C3uRtXTZ8hOIGK
nXkbXaPUORDht/huAPkv5hXAJwNbIUWtSyTRBJEe9RmxYbGWSeNGOUuz7d/KNe5i
D2ZPsFqU6MPoDM1frhVPzO8XWCghqFU7/wswBi+mip0HqcIooV/8kpUZ0NAavZZA
42P6Q3Cb+D0IvvlSS/VcEZZf///5x7hBs/XuHD/jyvyIn5F8ZEcIcSDznkZNHWIO
52jXtYjBv9mEezhfIKB//G4YJRUtvH3zT0vpcexIkH/vL7RZi8ZRDpVB77TCyHpr
mnCDS1r3tNyGtcgrnIVw1JCzaXtgc9nPDSPTztPMt5FYVGyEt/PIFDw+VWExIxv5
NKiEHEc4D4QJ+fvpN9s5JBOOWB59aOpbLlitv3JoSdNpk7FgmMWMGDtO50u7nzLo
D4lkKconxGtDkz4xaaHTNBYmfh8IN83loV3WwAbOhR2r10BJGXU=
=kt8i
-----END PGP SIGNATURE-----

--9IfYibZD2R2iqPDh--
