Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E895204597
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737839827; cv=none; b=m9TCPG+IUQU8nJ832jRPgSUtTyOOCtX5svpOyfTDvbqzYS/LAYgMk4Q5sQmASHcebAryfM/ccQm9OhQbRwJG9DZmwq60WY5bQCfda/jWmYCwwPjXgIPnIocgNzQ0pn2JruGGkBjA0FVi9lPnpKPTicKBtuvwZEbe7m0ay1zAcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737839827; c=relaxed/simple;
	bh=lZqbfoVmIyd7+HAu3EoSV9eyO6oBi4xb+b1rHTDBVPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6VeQRTc7Tf+h+x+NFjTUuw93XicDColkjtobbaYXRk3eulsCanRHRmnqGQk6Rz23cqUJmQcxmHpGtFNirsu0uflDjuB843R5Lqr56xdLDKYNImuiRQ8jt3e5QcYeBXOHoJvpCS1Y/IoFHlVBsHLQYbDZZNX4/z0mB19BmqZ12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=eSPM43vt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eSPM43vt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737839816;
	bh=lZqbfoVmIyd7+HAu3EoSV9eyO6oBi4xb+b1rHTDBVPw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=eSPM43vt730uv/1g1eoh7RNecOkLME5KLruBVdfymm1eGvnEyj6IjZ8rNyWcFsvLP
	 2xKiyBFm7MyeZ3I5dgKFSIh+eWQruks0li7MJkLlK39G08X97P2BwLX/PStPG45KxN
	 bav3Rbo2jZoDuwGiwEMqx/GZ2VSDWuyXOnDLsN/GepllgrtQyDebTXzCR6KiKzfvNT
	 8PyuRet5NIZeQmsOuTdPpSP4tjd0xSqjan841O26OxFNUL9s1DYYi36GIiZhVSW/Zx
	 gCfKO5fk6VXokIIHMKJDJZL15ii7bIS3D4zcCfreTLkmZHffLaikDzQa7rSERl4RTn
	 OltS4dGx6ClpPfowT0INsxqWYEpHvgm3afrgunrv7K/EBLG5ZpiIN4QR6Kyx+ggVpM
	 +OWYmqjETlJXhMKFdmJ8+gDNOt+LRwA8BWbDIywqDtGSFaceIVLNOFL+h+ypDHcT8d
	 lisTBJLNz3hYMBazAJp4Fy5ta4Pj7MUQPVh4b+vCXagzTW/RK2u
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A80992003B;
	Sat, 25 Jan 2025 21:16:56 +0000 (UTC)
Date: Sat, 25 Jan 2025 21:16:55 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: dev oft <devoft1@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Proposal: "GitPanel" Project Contribution
Message-ID: <Z5VUxwjN4GLtZHuS@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	dev oft <devoft1@gmail.com>, git@vger.kernel.org
References: <CADfRhQ7Gcv6SB5ZYwdE1HRxkeBwrEbYMu6KcKPRuxWdDH+gZMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ba/z6ToTNDF34Oou"
Content-Disposition: inline
In-Reply-To: <CADfRhQ7Gcv6SB5ZYwdE1HRxkeBwrEbYMu6KcKPRuxWdDH+gZMw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ba/z6ToTNDF34Oou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-25 at 19:59:17, dev oft wrote:
> Dear Git Team,
>=20
> I am devtracer on GitHub, and I recently reached out to Git=E2=80=99s Git=
Hub
> page to contribute a project of mine to the community. During this
> process, I had the privilege of receiving guidance from dscho, who
> kindly explained how to open pull requests and share ideas in a
> respectful and constructive manner. Following their advice, I=E2=80=99m
> reaching out through this email to share my project idea and verify
> whether any similar projects exist within the community. For
> reference, here is a link to our prior conversation: Git Pull Request
> #1877 https://github.com/git/git/pull/1877
>=20
> The project I am proposing is called gitpanel (a working title subject
> to change). Gitpanel is designed to provide a built-in terminal user
> interface (TUI) for viewing and managing Git and GitHub accounts
> directly from the terminal. The key features include:
> Profile Overview: Displays an ASCII-styled version of the user=E2=80=99s
> GitHub profile picture (similar to Neofetch), along with their
> username and email address.

I think this sounds like an interesting project, but it's probably not
appropriate as part of the Git project.

Part of the reason is that there are many different forges, of which
GitHub is only one, and we try not to prioritize any particular forge or
implementation.  From the project's point of view, we consider it just
as desirable to host your own source code using a simple HTTPS or SSH
server, or using a self-hosted solution such as Gitolite and cgit, as it
is to use something like GitHub, GitLab, or Codeberg.

With that in mind, a lot of the functionality that you offer here is
quite specific to GitHub.  Pull requests are not a Git feature, although
most forges have them under some name.  Similarly, Git doesn't have the
idea of a profile picture, or even a profile at all.

So ultimately I think many people might find your project useful, but it
wouldn't be suitable to be within the Git project itself.  As for
similar projects, I believe there's tig, which provides a Git-related
TUI (although I've never used it, and so can't speak to it much more
than that).

A suggestion I might make if you want your project to be more generally
useful is to support a couple different types of forges, possibly by
creating some sort of reusable generic abstraction layer.  For instance,
I'm sure GitHub, GitLab, and Forgejo all have profiles, so being able to
work with all three would be useful, and if your software also supported
the on-premises versions of these forges, it might be useful as well to
people in large companies and universities, which often self-host for
various reasons.

Part of the reason I suggest that is because even though I do work for
one of the major forges (although my participation here is in my
individual capacity), some of the open-source software I use in my
personal or even work life is hosted on another forge (which I'm sure is
also true for many other contributors), so being able to use the same
tooling that works for a variety of forges is helpful.

Best of luck on your project!
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ba/z6ToTNDF34Oou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5VUxgAKCRB8DEliiIei
gdyTAQCjAgMi/bQwvHL9m4Nh4ShIqsS6C4BChEP7fAk5R8EK9AEA7fd9YVVgAzG1
kKWXQ9V5DgcGvSElpoSvp6BCEb5ygwM=
=dhun
-----END PGP SIGNATURE-----

--ba/z6ToTNDF34Oou--
