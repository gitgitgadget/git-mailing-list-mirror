Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BC27450
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="grHt7wQg"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E309FF3
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:31:40 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DE26E5B0B9;
	Tue, 31 Oct 2023 22:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698791499;
	bh=/rHzX76dKqLd3m97Sxi9mBv9uy0Qrhw+SY66ahl4EeY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=grHt7wQgEQ3mSKL2/RmTcmBJJeaMs84vIYF0iQZtrKCmhjGWvwbRxk2n6Z1nqyovh
	 pfnAntyBs8dMZqUrdnTQhlHTHhcnytBeXpVb1plLIfPeqy3zGgOt0puPDseOYe24hW
	 RbuO6YfcZXDYVRI4rgXt+iI/je2N/Ya1hS4yDCef9v5nF0QI8OoqZFx34yhKVuAsJK
	 +6kfqX1hS1XECckK5wrSnHoTpwoLBdHktj//5gZPK9XKFx99RVgWCXLJJkwuDWWlci
	 b8CH9XYFyL3lLVtdhWyDj7dZVqlVPpP+y6up1PaLG0yDjOTHaDfqSMSWAxKFJoGG9r
	 mIUE2f27Xn1O+OKw3UaMYSfY3os1jZhDhnlMuQsNd1/YyWg0qM/cw2McumNk98pM3g
	 P8XFGJ0DedlNRoTEuh3ordJrJqdHdIfUi712eTDaswUCr2jZ4x48NEKRNnFBfF8Nqc
	 Oa0KiuIVY6qMNXd9GCZSjfHgvhGENKF1yFwUqhbX4U3AUmKoGEG
Date: Tue, 31 Oct 2023 22:31:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/1] merge-file: add an option to process object IDs
Message-ID: <ZUGASkMgoAbe7RjR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
References: <20231030162658.567523-2-sandals@crustytoothpaste.net>
 <20231031214859.25293-1-martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IxtK62bwujjSktCk"
Content-Disposition: inline
In-Reply-To: <20231031214859.25293-1-martin.agren@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Level: *


--IxtK62bwujjSktCk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-31 at 21:48:57, Martin =C3=85gren wrote:
>=20
> On Mon, 30 Oct 2023 at 17:37, brian m. carlson <sandals@crustytoothpaste.=
net> wrote:
> >
> > Since we obviously won't be writing the data to the first argument,
> > imply the -p option so we write to standard output.
>=20
> This paragraph changed from v1, but this doesn't match the actual
> behavior, from what I can tell: `-p` is not implied.

Yes, apparently that commit message snuck back in after it having been
edited out.

> -- >8 --
> Subject: [PATCH] git-merge-file doc: drop "-file" from argument placehold=
ers
>=20
> `git merge-file` takes three positional arguments. Each of them is
> documented as `<foo-file>`. In preparation for teaching this command to
> alternatively take three object IDs, make these placeholders a bit more
> generic by dropping the "-file" parts. Instead, clarify early that the
> three arguments are filenames. Even after the next commit, we can afford
> to present this file-centric view up front and in the general
> discussion, since it will remain the default one.

This seems reasonable.  Junio, do you want to sneak this in and fix the
commit message above, or do you want me to do a v3?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--IxtK62bwujjSktCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZUGASgAKCRB8DEliiIei
gYT+APwMZW8IEBxrQfBECzuIu99f6sPLsAbfV2t3RayP3ePiHgD/TIXBOn2qMQOk
i/1jVSKqMwl0hlvyOcoYh952oa7azgE=
=Jr8b
-----END PGP SIGNATURE-----

--IxtK62bwujjSktCk--
