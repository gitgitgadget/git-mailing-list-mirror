Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B318C922
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414157; cv=none; b=Vwpnad/g2SQWMQdr9pOKb9TbdKyOpbMwgFCJkvl66yjdIsTOlUTRQfpU+miRkNMEQTP3NHRp9RZmssB7EtLoPRapoi/XCfgPOpFx1CD1FDOsnDUd72LuppHlzxqdsDFxL9vfUf6pDXxPS1BvNHfifwW9wW72nbHVKR3L159jkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414157; c=relaxed/simple;
	bh=KH/7LOHidpKT5WwfpCT0Vb0CB+NHBpbC2GMMyavyljo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gprFFGWo6aSIRGi6n6uf4CR8iDqwJQkyPYpkmzVWUWi9rUNxNlbYKJmgJPK5TXg+llRuDG2t4jWYrPPTRTpKS2TIZGUjdoPL2sTbggAvpGvt2pjcNFStsUXBx0ikWFiDpncDU4R71+wWIqxRLOvGxJXeEawKHi/jJpkOzJyqErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Xoemc+/C; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xoemc+/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728414152;
	bh=KH/7LOHidpKT5WwfpCT0Vb0CB+NHBpbC2GMMyavyljo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Xoemc+/C06fqHY4NG3OJP2s+i/gLiJrCablM8iKEGCz9B7h2BPeBBgA6y9czIIvab
	 fSQLq26e/FT2mlq8bvGD8QTaAjB0CTqj29o7pCx7mfBaa/tPIbFs6eQPtxLEb8m57c
	 aZrxJUURAxTUGXHuOF2jjitlHZ84aIKyinUqZdRpBIaL2RQOeRqfo5ChmlAOg1Ezar
	 nAbhEl+ddaxt/bcoXISVw1OM2cZawdgWgZs87jTEtjtG2OWcQvjuLQYzb3yWBh8JoG
	 sNd4G7g4P2d+KYQkp7cyJjDFZpTMUHgoq1Nqlmz9G9GnA6/g09U1rFOrsp0GWwk0z8
	 SAzNS0MSk6hQLbM4yDAZ7/orGRMJHSren7I2bCmmr3gz7vuBZehmvUwZEq3YyaNjQi
	 g2AIEs+ytjrPCp0cRpyLFVJU8XlSjeaHgV1Pa/y5OWmP54pYUzwbWOU5RTse/X0Kd7
	 HAmP7gyuV9wQDwj++10nahzT/98DWMGHgGhkhCgEG59y1cuJ8Gl
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EF38520081;
	Tue,  8 Oct 2024 19:02:32 +0000 (UTC)
Date: Tue, 8 Oct 2024 19:02:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Spencer Fretwell <spencer.fretwell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Verbose Commit Ignore Line Fails via CRLF Line Endings
Message-ID: <ZwWBxy-wx6bn5tYz@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Spencer Fretwell <spencer.fretwell@gmail.com>, git@vger.kernel.org
References: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrY/S4EJ4EYFM7xV"
Content-Disposition: inline
In-Reply-To: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--nrY/S4EJ4EYFM7xV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-08 at 18:30:53, Spencer Fretwell wrote:
> gc -v produces CRLF file which does not ignore verbose description.

I'm not sure what software you're suggesting here, but we don't
distribute any software called "gc".  I can't imagine `git gc` is
affecting anything here.  Is this maybe an alias for `git commit` or
something else?  (I'm going to assume so below.)  If so, do you see the
problem with a plain `git commit -v`?

> OSX + git-annex (pre-commit hook disabled just in case)
> using subl -w (sublime text 4) as editor, which indicated the change
> in line endings
> - committing as Unix fixes the issue (workaround, tedious)
> - leaving as Windows is the issue
>=20
> see attached bugreport

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> - gc -v
>=20
> What did you expect to happen? (Expected behavior)
>=20
> - line endings respect OS
> - gc without -v uses Unix line endings
> - line ending is visible in sublime (editor =3D subl -w)

Does this happen if you use a different editor as well, such as vi or
nano?  I don't see this on a Linux system with `git commit -v` using
Neovim.

Also, if you do see this problem when you open the editor, can you leave
the editor as it is (don't save or modify the file), and change into
another terminal window and use something like `xxd -g` or `od -tx1` to
see if `.git/COMMIT_EDITMSG` has CRLF pairs (that should show up as `0d
0a`) or just LF (plain `0a`)?

The reason I ask this is that I'm wondering if maybe there's a
configuration of your editor that's causing it to switch into a special
diff mode with `git commit -v` that it thinks should have CRLF endings.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--nrY/S4EJ4EYFM7xV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZwWBxwAKCRB8DEliiIei
gW0HAQDTgO7aTIYKifdVsNR7hSnHVDDTl4ts0u0g2GBY55Uw5gEAxXa86OQq7tsA
QAE3sbfDVjqoaCQSiR/ky+/m1mo7+AA=
=pgwq
-----END PGP SIGNATURE-----

--nrY/S4EJ4EYFM7xV--
