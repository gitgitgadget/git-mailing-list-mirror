Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D707299944
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157149; cv=none; b=OGMvTVPMo457fZSrMMj2opph1sen6oezqdqN4SBpYH9m7khrdTuEnIPmTdJhXBbfmIsJcThZwkFNV/Q0J6RUb0pxtABKExNia1R0qCvqGP9wwKD9XNQcjIx3g6gA8I7Kle7iZz3oMhpyFEwNi2n/SOvjILk4MlTzbhGtGzejWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157149; c=relaxed/simple;
	bh=com1k1N1pIbEdM5N7NfXOiAE0i+DXwj79Bce19R9rEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjfAp94FxPZDr+AC5IrX9MQLsHHmxhO/etPW/O1oHikg7uGM8cNAyiOGfd6HhIzlJmk4I+PWiRAFBrgL/Net1Br0Jg0sWkNweLFhmt5LXORRHDLM1iUiM/8idznyGksBRU4DXEB/JPI45ez2dc6dQqojD5+vqyrZyNrUrEkrcXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=rUW/j/E7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rUW/j/E7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756157137;
	bh=com1k1N1pIbEdM5N7NfXOiAE0i+DXwj79Bce19R9rEU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=rUW/j/E75SCeo1kThbOiB1YO0RSHQxcDfT4bFmhqTdQt3ONw0iMG7IjxYa8NqTs7o
	 F3KVi1JrT/6RYkPErDkhOwXDl13SYw1PgfZOGJCk20psrOgiLrWMFsF7GasFpWgRJx
	 v+7W9yukTFPmkuwL58vjAGqQDwz4UoH8sVVfcQhimIAF3F8Yt+n5OGBWkXDzKTWK9X
	 pnNZrEGY5JdKpOe+F11mXGLPcTeSlQK0u0+iVhEMTHBLVK8a8kIGXZYnDDetCfUktv
	 hZ+q1Gfsc/97SiftoPGRJDlPHiRO3GdV+92PNXaVsYkPEoU53VWDymopX/yu9KJHqS
	 vXmGG1MkJirVDX7wjJxIRCNlYMo6CNArCRq8CLDrJJErG+7fDscHJTxy8RPAKlGvDm
	 ek5qZd7+LPO3bz2K0RUwomh3Y2O+JX8f0SaP1f7USzCLYeCCH7MWBvcd0SKyPO/V9u
	 38sEdYv7DLbBhrmPEtGkh8vz1Q8Igsq6K4b6KUMLRP7NpXEvZwL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5044:243e:8019:42f0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 941E7200C3;
	Mon, 25 Aug 2025 21:25:37 +0000 (UTC)
Date: Mon, 25 Aug 2025 21:25:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] docs: note that extensions.compatobjectformat is
 experimental
Message-ID: <aKzU0IP8muy-j1TV@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20250823220601.336079-1-sandals@crustytoothpaste.net>
 <xmqqo6s3qpne.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvWCqc0aD2EY948U"
Content-Disposition: inline
In-Reply-To: <xmqqo6s3qpne.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--nvWCqc0aD2EY948U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-25 at 17:25:57, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > The compatibility object format is only implemented for loose objects,
> > not packed objects, so anyone attempting to push or fetch data into a
> > repository with this option will likely not see it work as expected.  In
> > addition, the underlying storage of loose object mapping is likely to
> > change because the current format is inefficient and does not handle
> > important mapping information such as that of submodules.
>=20
> It is "experimental" in the sense that a developer who is interested
> in making the feature work end-to-end for the first time can use the
> code behind the flag to prepare loose objects to prepare what is to
> be transferred; it sounds more like this one is "not working yet" ...
>=20
> > diff --git a/Documentation/config/extensions.adoc b/Documentation/confi=
g/extensions.adoc
> > index 9e2f321a6d..292e95ddae 100644
> > --- a/Documentation/config/extensions.adoc
> > +++ b/Documentation/config/extensions.adoc
> > @@ -14,6 +14,9 @@ compatObjectFormat::
> >  	compatObjectFormat.  As well as being able to use oids encoded in
> >  	compatObjectFormat in addition to oids encoded with objectFormat to
> >  	locally specify objects.
> > ++
> > +Note that the functionality enabled by this option is experimental, in=
complete,
> > +and subject to change.
>=20
> ... as the only end-user-perceivable purpose the compat format
> serves is to exchange data between two repositories that use
> different hash functions, no?

It works if you want to do `git rev-parse --output-object-format=3Dsha1
<some-sha256-oid>` (or the reverse) and all of your objects entered the
repository as loose objects.  Otherwise, it isn't very useful.

It definitely does not currently let you exchange data between two
repositories that use different hash functions unless you use my
in-progress branch.

The eventual goal is to let people do something like `git rev-parse
foobar^{sha1}` as well as interoperate with other repositories.  Neither
of those are currently in place.

> The word "experimental" to me implies that it at least lets you
> complete a minimum end-user journey of the feature end-to-end.

I definitely don't think that's what it does.  It has extremely limited
useful functionality, pretty much entirely confined to rev-parse.

> There are different degree of experimental in this project and we
> may want to do something about it, but in any case this is a welcome
> change in the right direction to steer those with mere curiosity
> away from hurting themselves.
>=20
>     Note that the functionality hidden behind this extension is
>     incomplete and the extension exists solely to allow us to
>     continue developping it further.
>=20
> might give them a stronger discouragement?

I'll re-roll with something like that in v2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--nvWCqc0aD2EY948U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaKzUzwAKCRB8DEliiIei
gS1wAQDAHWYudKxzkg9JL+LSc+fOCwyIkDB920hluEUFI6H/QAEA1vSgLHNWqT5x
u9evR92/zgFwHMPUXOttxmGkqr3sKAs=
=tiag
-----END PGP SIGNATURE-----

--nvWCqc0aD2EY948U--
