Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A11C1F15
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804040; cv=none; b=XubVUzjU12EZIJpbgqlqVD5rPziIW98YLaq6+UUyANRMyOmwCvjYFfXXaNpC7hcTFFfToyUeYLSJq/STiq/FiuMX8jDT7IGKsMo1sC4zyFcWAtBBqgBNiIcWZIOtbgjLIX3bzBV2fHnOjwZP5Qry5t2YrkUdA9d7yJq7BIqgGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804040; c=relaxed/simple;
	bh=UJRjSiEegXRqyr+c0MGlm8rvMlCxJZSlwF8ApyBktNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQj7hgR7Aqjvd34e8/YbBxiL7AiXKlZSz3DV0RyKW+XHgDB0qNgJ5vLmgJ2K7IeMKnlSFdKd4xhUHgp30B3ftRZl2FUjgz83ZwXDyG4mUGLATt81Msu5CtGUs/fdeM6h83J21fvXxQCYaBP4k+Ddwxf6Coyl3crksqhupHFDOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hih4EoBZ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hih4EoBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736804035;
	bh=UJRjSiEegXRqyr+c0MGlm8rvMlCxJZSlwF8ApyBktNo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hih4EoBZ9pdZJTaiLvFyp/XiBmAzUi/rGCUtH0gFuHEko/2/vRxc+T9kVCXce9jMB
	 uBTbLRydF0LUw2Y3UHGy45H9mtMy7vwWvi2mMA1YNYt5p74M0dF8aJY/pLDs1W/67E
	 b71r6FlXhouRBDSrKfbuGLWCarSGVKo/Nwyrb+Rr+xWs9eh7LqLU2zf48h5SmowAMO
	 Or6hJ7CUZ5XMtxp2tDOSW4Ne7/1FgXDklVn3GJiCh3EPTNCtT6RZQyC/DSgRY7lgcL
	 uccUxuJnCfoI+hrXMDAWe8brujbRTS7taHPwyC9QpLT75lBZJUJt1eHfEl1FHx9qDD
	 ARuzcpSg0jM8KBSyZz9OYCPN5R1Sm3LDoCLn1IYeVXnWnGFJyb5xM4Jdr0cICQLhhb
	 E1n0GQfj48K/rJZto4W+LVhfWcXERniVawEMtz4yWJ5VUV/1EACpJExETSkjGxqgCh
	 pzLt6rbWA3m3r15F7ik3CBDXdlfhDq6cEBsib8eSee0PTUi0qnm
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 50A8220008;
	Mon, 13 Jan 2025 21:33:55 +0000 (UTC)
Date: Mon, 13 Jan 2025 21:33:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] docs: add vim syntax modeline [RFC]
Message-ID: <Z4WGwCwnNj_XeHiI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
References: <pull.1874.git.git.1736802194760.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udisH1diOUXcTylz"
Content-Disposition: inline
In-Reply-To: <pull.1874.git.git.1736802194760.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--udisH1diOUXcTylz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-13 at 21:03:14, M Hickford via GitGitGadget wrote:
> From: M Hickford <mirth.hickford@gmail.com>
>=20
> Git documentation is written in AsciiDoc. This format is easily
> mistaken for the pervasive Markdown.
>=20
> Add a vim modeline to help editors identify the format and provide
> syntax highlighting, rendering and autocomplete.

I don't think this is a good idea.  To be clear, I use Vim and Neovim
(mostly the latter), but I just don't think we should litter our project
with editor-specific contents.  I know Junio uses Emacs, and other
contributors use other things, and there's no uniform syntax that works
everywhere.  (Nor could there be, because different editors have
different names for different languages.)

We also don't set editor-specific ignore files in our `.gitignore`.
Emacs users are responsible for ignoring backup files in the global
(per-user) config, Vim users for swap files, and so on.

> This makes editing the documentation easier for prospective
> contributors. This is particularly important because new contributors
> often start with documentation changes.

I suspect prospective contributors who are moderately proficient with
Vim and its descendants know how to do `:setf asciidoc`.  If this were a
different editor that were easier to start with (say, one that didn't
have tons of Internet posts asking how to quit it), such as VS Code or
even Emacs, then I would be more convinced by this argument.

> A simpler alternative could be to rename files *.adoc. This would have
> the advantage of being recognised by even more tools.

This I would be in favour of.  I use this extension on my personal
AsciiDoc files and already have appropriate configuration set up.  In
conjunction with appropriate settings in our `.editorconfig` file (to
configure indents properly), I think this would be valuable indeed, and,
importantly, helpful to users of all editors.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--udisH1diOUXcTylz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4WGwAAKCRB8DEliiIei
gRgSAQD/7+06IDw8tPEOD2s2jWADL1uevB20GyVRjWv7N4nRmQD/WBTfQl0R6eJ4
A3ZgL0fSS3nIAUKhALt1+jAv4/UeGg8=
=P0Fu
-----END PGP SIGNATURE-----

--udisH1diOUXcTylz--
