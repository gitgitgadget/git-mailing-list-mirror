Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA315B99E
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738880625; cv=none; b=G25JLAV4jX98jl2vHoBAWMKEqdI0wJpvJOk0nRN+vfbfdxXJcHu7FjmKr8MaJZgu4qiiCLK+kawNDz9/okuPZyW5uDknYScXBwyKoY8DV6dStwGd2vHHTZFeO1l1LjBMzsJEJCWSGfBUpvm7GECuk+L8AHaLjj0iTFvpvTN+EME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738880625; c=relaxed/simple;
	bh=Qhp7XJYLd33m3VsTrjIB3E312+U7pmnwwsEY780uFgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on8sN/4dTmQopwGQ2jKNr7thB/9b4BqTkZ0K+lWn8Bong4jtP1aHxPy/ePbW71ESWDuFaCddV1G8zXu+sK2lbYgame7Iy7s915Hz/gKAEe/GmkWf97B82EqnwwOKjchqC/EBAbuDuq0Ddq8C/7YwIgrxeIx5TSA8Pnl+XBS0g20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZY8LfZVq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZY8LfZVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738880620;
	bh=Qhp7XJYLd33m3VsTrjIB3E312+U7pmnwwsEY780uFgQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZY8LfZVqdzJ1+0eIOIY7vrvMutkCkbCqEaQip3Sb0914Xxq9PHuQnfge1DKgLHRoh
	 AC/uRRBBzGY7TR6GeKm3COmK1WXie3xZO+xGd6Duw0Beiq3ycWycfVTiOwVgfenVXF
	 FJWAWdNifk6UQrfe9VQ4WDaO+86K8i6vuRkC/kNKup6ln/HBOerRhRAjZUTib0HVsI
	 PCHo1su6s3AGaj4gu9a91ENJbiM5xp+HIFjNxOfVYfouLgR04FMiTlhM5/I7IjQB5b
	 o26ZELFlaJZYsjy2+P/RM3RNOiD02/L3DEJquhq2iGLewajOBipncCnHuNBz0zb4Yo
	 8AfuzU/sPfEdwk0dagcQnNr2fD6SvTT+ELvbfg+YKWuxnkAoqJHaI0IlOYim8tjAAV
	 cIxEQ0YkdF8jJKRDaMeNqU+NcuWRjODUBZIoKmDUaIpwU40rn0za3xtMNogVpwzR8n
	 fTVMzfTIufL1/FqPCwZP8wiqUnX5B5Wo0y6ut7xPFazTf1QD2JS
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D109B20076;
	Thu,  6 Feb 2025 22:23:40 +0000 (UTC)
Date: Thu, 6 Feb 2025 22:23:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: USA Linux UAE <usasoftwareengineer@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Managing one github repo with Gitignore and Submodules for two
 different remotes
Message-ID: <Z6U2a0l0kX0MmNFN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	USA Linux UAE <usasoftwareengineer@gmail.com>, git@vger.kernel.org
References: <CAOXJ2J-StZYg4E9eGug=wHNjBu3aPdoy0x17aS9jLn14SyfJkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P7dS4CdBvyW0mLiL"
Content-Disposition: inline
In-Reply-To: <CAOXJ2J-StZYg4E9eGug=wHNjBu3aPdoy0x17aS9jLn14SyfJkA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--P7dS4CdBvyW0mLiL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-06 at 14:10:44, USA Linux UAE wrote:
> Hi everyone,
>=20
> I'm hoping to get some advice on managing a GitHub repository with a
> slightly complex setup. We have a main repo that utilizes both a
> .gitignore file and submodules. Our goal is to push this repo to two
> different remote repositories (let's call them remote_A and remote_B),
> but with a key difference:
>=20
> remote_A should respect the .gitignore file as usual, excluding the
> files and directories specified within it.
> remote_B should effectively ignore the .gitignore file, and include
> all files and directories, even those listed in .gitignore.
> Essentially, we want the opposite behavior of .gitignore for remote_B.

Unfortunately, there is no easy way to do what you want because you
essentially have two separate, independent, and diverging histories.
Git doesn't offer functionality to push only part of the history, and
`.gitignore` is honoured when files are added, not when pushing.  Once
files have been added, `.gitignore` has no effect.

> Additionally, we need to ensure the submodules are handled correctly
> for both remotes. Ideally, the submodule pointers should remain
> consistent, regardless of which remote we're pushing to.
>=20
>=20
> Could anyone offer advice on the best approach for this scenario? Are
> there any recommended workflows or tools specifically designed for
> this type of setup? Any insights regarding submodule management in
> this context would be greatly appreciated.

The best way to do what you want is to put the extra files from the
second case in a separate submodule, which can be pushed to server B but
not server A.  You may want to add a script to handle the case where
they do or don't exist and place them in the proper place via copy or
symlink if they're present.  You'll want to ignore them in the main
repo, though, since you don't want them to be checked in accidentally.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--P7dS4CdBvyW0mLiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6U2awAKCRB8DEliiIei
gVKFAPwN0MLMd58U369AT4daqu954U/aPI2jMhuZ9/7E5GemHAD/fKB0Lx1NrQRu
DuWoaKD2XLFQ4bl7QmcF0/ehMaZzJAk=
=Wcv+
-----END PGP SIGNATURE-----

--P7dS4CdBvyW0mLiL--
