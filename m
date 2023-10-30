Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7418E00
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DDlqXNZG"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5216BC6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:14:45 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 42FFC5B0B6;
	Mon, 30 Oct 2023 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698682484;
	bh=GxxEAgyDE516vLJklO02AtFjhoRdv7mIo9CzDLJsJ1c=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DDlqXNZGC8RvWWA0sAqswHjNpq5gpjcSfDNecKbeOmsGi85B0B6z5mUYIrIyoKEYH
	 ls1+7vWAsNI55U6+fduqJXWh7tGxTXRy1ZcqaROE4tK9XBk4cVCsfgBhxXr5I/tRRf
	 /rXANxPKaEh4c/GwIiX/ZMSCFOPmlLKEO/lxOeD8otUx+jYZRv08iydTiiD6fkfxKX
	 ObXlDE7NBVMyc0V3kheksDYR9CL2ToLLU4GhhXgriaNiMRfI9VMXXXydSjNxMaQore
	 GKYljst1ZiDdFwxJmfS3a+DPAEfdKd5iGd6Ha/c+SJ55C8CChz1DeqWn5thjA42cTD
	 qtTsZB1saGK2yxbScW+MqM2stkNwqxYLF8wm/iLvEOZslGAN9Z7c1AYhUDCWOe5W9h
	 bDFLHhhrIrJTd5WrcWsSd871AJZHYnBdfOj5VV/ZfRPbuhFOulpaJJnDiMFwS5vc7U
	 Da6qM9FUCqK3iB+NZHxev5wqrFLOQwI/Q1LIdjfLwiDqJ+lVYhZ
Date: Mon, 30 Oct 2023 16:14:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: phillip.wood@dunelm.org.uk
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] merge-file: add an option to process object IDs
Message-ID: <ZT_Wcm8kwT4uWzHc@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231024195655.2413191-2-sandals@crustytoothpaste.net>
 <CABPp-BG9Y6aZ+TWdkL4QE9e12fu3n61V16G6DLtawEDe=g9F4w@mail.gmail.com>
 <fec21bbe-46da-4f1c-a9b8-6be44403d68f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f/nBp+PMjBBgnSg2"
Content-Disposition: inline
In-Reply-To: <fec21bbe-46da-4f1c-a9b8-6be44403d68f@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Level: *


--f/nBp+PMjBBgnSg2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-29 at 10:12:57, Phillip Wood wrote:
> It would be nice to print an error message here
>=20
> 	ret =3D error("object '%s' does not exist", argv[i]);

Good point.  I'll include that in my reroll.

> none of the existing error messages are marked for translation so I've le=
ft
> this untranslated as well.

I've opted to make them translatable here because I think that's for the
best.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--f/nBp+PMjBBgnSg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZT/WcgAKCRB8DEliiIei
gX/5AP9nXMs/fGBQdO4h9klApFVWXnJuiZP72E4YM2V6OoC44gD9HsgSkMv5BPgG
2sEOFNoJyPWhC1me2DnW9zA5KZ9B1wU=
=oPHa
-----END PGP SIGNATURE-----

--f/nBp+PMjBBgnSg2--
