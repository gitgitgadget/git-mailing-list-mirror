Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9891DA37
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172153; cv=none; b=XVIn9mZFr2NsDlz/RYHcs/76lNoat1uS9x5tIvvQZ+FWIgEuw1npULHOFP0yw8ZPS0a/vWDcWSQQBfxwhER123OfXiD4HeT8u0ewoS7Ay92WOmikJkiShudDrAfRzxRAP+1T+zduVnIyxVgUfdT1BigYyhKnaNL9+yVKqvBIdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172153; c=relaxed/simple;
	bh=tixJVOqZQR/dNLpx9o5pzTuNri7GVTF2o45PsBY/2Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0rMZfQDw3yFWnOUR2kr3eJVvO0O0YE1SwlglLmzXhiqpOlmBXiux7AsAHexPTWAur3Y3Dsh4BKdR0j0LjpUuwSuDObbEKatyjqkComKIgCixz4WXZ2v63HGlp3Ov7vLOiYHQo/HQl8iQqdwUY6KaTmhj1BEmk4DWQVYBKheqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JIE2czck; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JIE2czck"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 3F8395A456;
	Mon,  5 Feb 2024 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1707172150;
	bh=tixJVOqZQR/dNLpx9o5pzTuNri7GVTF2o45PsBY/2Dc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JIE2czckt/GarWIkjrZiydrISPFXHGT55ccvYwOZkg0c5iW6RhC1571DirTo/jmKp
	 TTuC3dcPXRfHASEHfYZpKyopbNN21KZxt8R3Dx+N87ZBUGMn/X7l5jruV/pkcT1VAV
	 GOuHlhYeFJiSCGPT5QM+UhGv1IyZkIUbm51vXTLK4k5UYhWdmmdfhSZUcARGb2uLGK
	 MKBS1+UzBxpNwktGdnFlFGUoZ0VHIEZTuF+qBYFkrDGfNkQwhfv5savhfOYWwKW8fK
	 ukpybQQt/gVsBQwhW2ErWn+lkbuqQ/2orVftduhCKp3VYxAV1WKy3bAOjeHI3HCXjK
	 IDYVMLCnYEk7uwZodyc6XpoG4tDPwjglHjg8uyBJZZzTTYUwI9fB1s68tEwOvd9wGq
	 HEucE8+Q7/MCU6u6owZ0dizQQRtb+mTt3jVtBpbl54eelMf1fgo9Mey/+XOdB2DJyf
	 RI1BfJsXZ2XBMbzhu4Ow2TAiqAqN/qoYFDWa29ZKu3kXkX2LGRW
Date: Mon, 5 Feb 2024 22:29:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tobias Boesch <tobias.boesch@googlemail.com>
Cc: git@vger.kernel.org
Subject: Re: git-gui desktop launcher
Message-ID: <ZcFhNPRprfMqeRu1@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tobias Boesch <tobias.boesch@googlemail.com>, git@vger.kernel.org
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+kN3LJLeU40/st3A"
Content-Disposition: inline
In-Reply-To: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--+kN3LJLeU40/st3A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-05 at 20:12:10, Tobias Boesch wrote:
> Hello everyone,
>=20
> quoting from downstream issue:
> https://gitlab.archlinux.org/archlinux/packaging/packages/git/-/issues/5
>=20
> -------------------------
>=20
> "As far as I can see git gui cannot easily be used by me on arch.
> A .desktop entry is missing for me.
> I created one that opens git gui.
> It also adds an entry in the "Open With..." menu of file managers (I
> tested only with Nautilus). Opeing git gui with this entry git gui is
> opened in the folder where the menu was opened.
> If it is a git repository git gui open it. If it is no git repository
> git gui opens just as if it was called from the desktop launcher.
> Since it took a while to create it and adds value for me I would like
> to share it to be added to the git package by default.
> It is far from being perfect. It's a first working version. For me
> personally it is enough.
> Before tweaking it further to fit the packaging standards I would like
> to ask if is desired to be added.
>=20
> .desktop file proposal
>=20
> [Desktop Entry]
> Name=3Dgit gui

I don't know whether this is the official name of the project or not.
Perhaps someone else can comment on what the capitalization and
punctuation of this entry should be.

> Comment=3DA portable graphical interface to Git
> Exec=3D/bin/bash -c 'if [[ "$0" =3D "/bin/bash" ]]; then git gui; else cd
> "$0" && git gui; fi' %F

It's not guaranteed that bash even exists on the system, let alone that
it's in /bin.  For example, this wouldn't work on most of the BSDs.
This would need to be templated using SHELL_PATH and written in POSIX
sh (e.g., no `[[`).

> Icon=3D/usr/share/git-gui/lib/git-gui.ico

This would also need to be given an appropriate location based on the
build parameters.

> Type=3DApplication
> Terminal=3Dfalse
> Categories=3DDevelopment;
>=20
>=20
> I think upstream has any interest to add this. Therefore I ask here."
>=20
> -------------------------
>=20
> The arch package maintainer proposed to try to to add this to upstream
> before just putting it into the arch package.
> Here I am asking if it could be added to git.

If you wanted to send a suitable patch for the file such that it were
appropriately built as part of the build process and installed, then we
could probably accept it. Such patches are usually created by using
`git format-patch` on one or multiple commits and then sent using `git
send-email`.  You can take a look at `Documentation/SubmittingPatches`
for more details.

I think such functionality would be generally useful, and probably be
beneficial to a wide variety of distributors.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--+kN3LJLeU40/st3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZcFhMwAKCRB8DEliiIei
gcQWAQCfrX2Ufiga6OiJETBDCx683ywz5tYdoT78fjbZjj3LvgD/SKZEJD+UYN1r
f73OO7ppuz/07K2t5TH7mAVNlYMFggk=
=g8ol
-----END PGP SIGNATURE-----

--+kN3LJLeU40/st3A--
