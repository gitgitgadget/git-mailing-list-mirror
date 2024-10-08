Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2021E0DFB
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414587; cv=none; b=T5+CG90Dpe+pBhzAIzkr4rTTetAn9YRf26x90CweyAj5qg0fGaVNnieAEm9YXcnxdj4oo0M7ptN7MNmXoi47/cwWxwz0732uwws/f1yhPISsiZKEc9ZF834aW8BHbrNP9NzcqhJ86MkVtfkOQ5LvxNyAklwTLZU7fsJ49mzLvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414587; c=relaxed/simple;
	bh=JD93eMkUJadKXckKmbF3+dDxOBS0/82tx0LPChtcFIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/5smWNSCx91iFEjgMe3p2DAvS9RRo37JSxnWUeYFsd1EO/uQc/jwuxrOWbPTkl8hk6ds7yUCspvzDy8OFKeh79E8zWtmD/75w5URGm24X0mj6HFj/5SHBCODFC0CmfFdEiNd0cNTQYjo3emvD2LyO/tehYFkgBpMo5WiZ4/XdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=nagdr0tv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nagdr0tv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728414584;
	bh=JD93eMkUJadKXckKmbF3+dDxOBS0/82tx0LPChtcFIc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=nagdr0tv0EDtAx7Q798O/QZ5sFoqsNI0RJ9Th9XT/A/V7mQ4DIAuRXzLJUY9D+JZv
	 Uzw6j0Flha+ytjOJ90ZLfwVWXv7y+e7lfMm+8HJALKCqohLiyNnE02SpVb8Rei0ZV2
	 xJhBpvsrSnJ9AoL4w0UvRCZWSkQ7+LLVf72+UPQcAu+AdK+Ll5R5T5mcGyMqVtuW9a
	 OaAxwFM8MRC/mx1JcJ0LdR/C6xA4L7+EYfO3wdb4qDdXs8+RuyXNVcLCV3BkPC6X36
	 CHEJALam3YJPnoGQjjoTFeM6LaLDHitbVmTr/jUWg2mkZ7yv+Ypu+NEAdCiy2EwLo7
	 2vaz/F3qKDMLiW+TAJhZF+QNn/j+iVB2Qz1UsjPkbojia5gZ0DWIiiU9R9kv16udCS
	 nz9KwryaczIZA1OYxQM1HU9lSpEMMji9FyzoNFwTE/pNPZlI9R1AH5WnGM/0yYp3Rm
	 gdJtu58TaAbF9ZrnuKr6S8paMPaCQUradxNIfyXVBz9fmLrgmB7
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7BA0F20081;
	Tue,  8 Oct 2024 19:09:44 +0000 (UTC)
Date: Tue, 8 Oct 2024 19:09:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Spencer Fretwell <spencer.fretwell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Verbose Commit Ignore Line Fails via CRLF Line Endings
Message-ID: <ZwWDd1_76Z6zH4mP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Spencer Fretwell <spencer.fretwell@gmail.com>, git@vger.kernel.org
References: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
 <CABa71BwtEWS79CZwPOa_Nrh1iMrXRo+hyxNBc5F8GsQiwjdapw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="grdIryJEQiWVo9sv"
Content-Disposition: inline
In-Reply-To: <CABa71BwtEWS79CZwPOa_Nrh1iMrXRo+hyxNBc5F8GsQiwjdapw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--grdIryJEQiWVo9sv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-08 at 18:37:47, Spencer Fretwell wrote:
> On second glance it might involve having a file being committed that
> has CRLF endings in it.
> Committing files with LF only does not produce issue.
>=20
> I suspect git either needs to add support for a magic ignore line
> ending with a CRLF,
> or has to sanitize verbose output when that output has CRLF (less ideal)
>=20
> Bug originally seen as early as
> [2018](https://superuser.com/questions/1367811/sometimes-git-includes-the=
-diff-to-commit-message-when-using-verbose)

Ah, yes, that would probably explain it.  Your editor is seeing some
lines that are CRLF and assuming that the entire file is CRLF, which it
should not.  In Vim and Neovim, you can do `setl ff=3Dunix` when loading a
buffer for `git commit` that will force it to always use Unix line
endings, and there's probably some functionality in Sublime Text that
lets you force a particular line ending.

What might also help is that if these are intended to be text files, you
can set a `.gitattributes` file as outlined in the Git FAQ[0]:

  # By default, guess.
  *	text=3Dauto
  # Mark all C files as text.
  *.c	text
  # Ensure all shell files have LF endings and all batch files have CRLF
  # endings in the working tree and both have LF in the repo.
  *.sh text eol=3Dlf
  *.bat text eol=3Dcrlf
  # Mark all JPEG files as binary.
  *.jpg	binary

You can customize the file patterns as you see fit.  Once you do that
and run `git add --renormalize .` (which you should do in the same
commit as adding your `.gitattributes` file) and then commit, your text
files will be stored in the repository as LF even though they may have
CRLF endings in the working tree, and your diff output won't contain
CRLF.

[0] https://git-scm.com/docs/gitfaq#Documentation/gitfaq.txt#recommended-st=
orage-settings
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--grdIryJEQiWVo9sv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZwWDdwAKCRB8DEliiIei
gU1AAQCZZejHqwKKT6T7h0mAhFIcMZTMP/0QtsaSdf9iQIRgggEAhf/PSzZ/SzLJ
o+YmM2G6B2G/dNGS5D/uDmIZa7D4jQk=
=4lQE
-----END PGP SIGNATURE-----

--grdIryJEQiWVo9sv--
