Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257291FA1
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hFXkyyTS"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66929132
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 02:18:20 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 173615B0C3;
	Thu,  2 Nov 2023 09:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698916697;
	bh=D3Lknum3ZtCZBxmx31bdcwC7xArR707aRRe4vNXICuU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hFXkyyTS4V5lSoRQkvcTH/SRPYPWg/zx7jnSyWfVeQebs5N4o8HrKysIbu27wt8KW
	 QfBfcVrDKWPESEjyM+bUpVJ4yQ1uCp+zYZGay63xlY0ad0CGIUd5uCpyVwkBhqsBAT
	 c6STaPy1/ntxmGCWiEXKRC0zAuW3k3/ssdGLcq9ZJdeK52s8CrXBRh8PZ9trxBXzfA
	 rmZTAri4JijT9NtXix3qmMGwJTovJR1tpqt9J0hwOmKbEWbOiZDzoy1F4K8CNssCGG
	 ZbA0pqrkuj9yHytQhXqgbuhbUjb8fBqfXgrDa5UT1hqF6cY10C4qIJbSrP+ICa3fW8
	 GTSzAKVeUQGiCukteAB7MWU1y2+bCw7YsQzFV76hFDx+xDrHTVBEmpkRQqxeDsrZb7
	 ICZluCnU6xJ8ANLMrg+2L1l7pe0o1+XH13WxqWrFsDQ/RndsMLmkwNkkxIb0hc++ZN
	 nypthOmdx10tnRyNYcI6I2TfCOdrJzuzA3J7C0QPONlPNrfxFhP
Date: Thu, 2 Nov 2023 09:18:15 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/2] git-merge-file doc: drop "-file" from argument
 placeholders
Message-ID: <ZUNpVyQYUT8TA6An@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231101192419.794162-1-sandals@crustytoothpaste.net>
 <20231101192419.794162-2-sandals@crustytoothpaste.net>
 <xmqq8r7howsq.fsf@gitster.g>
 <CAN0heSrv7MPcEwkq4uEtv9uBbqm4FLKQLE3gdsEbqKkxPXOj5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uIRGgvOPPj0GX8/P"
Content-Disposition: inline
In-Reply-To: <CAN0heSrv7MPcEwkq4uEtv9uBbqm4FLKQLE3gdsEbqKkxPXOj5A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Level: *


--uIRGgvOPPj0GX8/P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-11-02 at 08:53:36, Martin =C3=85gren wrote:
> On Thu, 2 Nov 2023 at 00:53, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> > > From: Martin =C3=85gren <martin.agren@gmail.com>
> > >
> > > `git merge-file` takes three positional arguments. Each of them is
> > > documented as `<foo-file>`. In preparation for teaching this command =
to
> > > alternatively take three object IDs, make these placeholders a bit mo=
re
> >
> > Minor nit.  Don't we want to say "three blob object names"?  Unless
> > we plan to grow this feature into accepting three tree object names,
> > that is.
>=20
> Hmm, yeah. Or just "three non-filename arguments". I do wonder: doesn't
> this mean that the second patch could/should possibly move away from the
> notion of "object ID"/`--object-id`? (That's not trying to shift any
> blame from one patch to the other, that's my honest reaction.)

Not specifying an option would make this ambiguous.  What if I have a
file named "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"?  Is that the
empty blob, or is it that file?  Normally we have ways to disambiguate
this, but those don't work here because of the positional arguments.

> Ah, yes, I thought I recognized this. Quoting your response [1] to v2:
>=20
> > I briefly thought about suggesting --blob-id instead of --object-id
> > simply because you'd never want to feed it trees and commits, but
> > the error message from read_mmblob() the users would get mentions
> > 'blob' to signal that non-blob objects are unwelcome, so the name of
> > the optionwould be OK as-is.
>=20
> Maybe you having a similar reaction a second time makes this smell a bit
> more?

I think the name is fine.  We don't typically use the phrase "blob ID"
anywhere, but we do say "object ID".  We'd need to say "--blob", but
I'm not sure that's an improvement, and I fear it may be less
understandable.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--uIRGgvOPPj0GX8/P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZUNpVwAKCRB8DEliiIei
ga/sAQC18K4MVr6olcu/FA2Emef5U9xVWfxH6FbrPBCtbKYlUQD+JmFt1S3SMocm
IKf2CS46gq3O2+PG3/RGP0Oqw8irLwA=
=4Hw2
-----END PGP SIGNATURE-----

--uIRGgvOPPj0GX8/P--
