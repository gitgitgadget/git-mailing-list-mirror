Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A54C7D
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939701; cv=none; b=nkfyhtMyKY1hqpiBZ2C3Me8GB0Qv8ggOSoiMkl9uaL1n5/AdkCm/hJFKZx7133cZSj/7WG6STyD3EP4SpATV5VE1nu26Vb9L2NqSIyY5G0W+4xsbw1rwZb4R5tNn6exe9WjTg7LNW7bW9Rq0sFdVvq4R17XJrgU9yWGdhj9Eg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939701; c=relaxed/simple;
	bh=Fa9wLjHHuBta72cibdeUKsW6AOlzJQVPdIIuXm3dOvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaMV7sP9UABHyrRImYieT0ywiNv6C2v7DbvdJP31QBSOcFzWa44XxqotxW5dUquoiReDCabtZoSRwNtCMCirx5PfEF9D4q+XO/YOKxxZgelWaIZrkTFzB0thos+jlf3IfOZpI/yfo6W6QAMsheo3BMw6F0fjirjxesROVeQJNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RK0BLZjR; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RK0BLZjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730939690;
	bh=Fa9wLjHHuBta72cibdeUKsW6AOlzJQVPdIIuXm3dOvU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=RK0BLZjRDGqqGoVJjS/sa/6KThKXKJyxT6oxMtgm5PxryxdPJKgEjGG5X56CMoKmz
	 Sa9vcK9ALsSXO3/loumkn1dkSsGl881AB0IPAER2RKuhC/SFlMz6c6xDGjEYGMXRkj
	 rFCGTFzpvgI0y/DJCPi15UnCr9NYclpY9h4SNRUhXKJEllF5cBMCah28lJ0MrUdONs
	 +MRfQNLCwUjRHDLMjq59FHq7FcuLZewAbtnBkJUJYGHvw5M9toftWzmeqygWeoHAu7
	 gSjdWZOuaMs0osAPqmkAwSsd2QooJrhzbBEfoDYsE3LdL7oMj1FXtPS8XpGehLplPj
	 19d181lmtsyCUHlSEaYmMDPvgSXmeIqP43dBEhkgYW1y/z1u46pynP+RIld1OxrY13
	 DGnMI+VNK017+Uxfs4A2zP3zjSYx4TTz5QksZVTfi2gzRK4u6wbC3BmuZ69PduWh94
	 p5pKkoQEoysh0h0WzVE3+Hp2liysEMmp+qbrTS8/CPGxcQYLG4P
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C1C3220080;
	Thu,  7 Nov 2024 00:34:46 +0000 (UTC)
Date: Thu, 7 Nov 2024 00:34:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: ilya Basin <basinilya@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Feature request] autoresolve modify/delete conflict via
 .gitattributes merge= attribute
Message-ID: <ZywLGNsTqykDFfMH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
References: <f1a8afe2-df78-40d9-9866-d49dc4057806@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4uVgSirgx9Sk7Nan"
Content-Disposition: inline
In-Reply-To: <f1a8afe2-df78-40d9-9866-d49dc4057806@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4uVgSirgx9Sk7Nan
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-06 at 11:56:06, ilya Basin wrote:
> Hi. This is also described in this SO question:
> https://stackoverflow.com/questions/58767528/how-to-specify-a-git-merge-o=
urs-strategy-with-gitattributes-for-deleted-files
>=20
> Our proprietary IDE generates theme-cache/web/theme.compiled.css and the =
contents are different on different machines.
> This file was supposed to be in .gitignore, but it slipped into the repo.
> I was trying to remove the file, but other developers silently re-introdu=
ce it into the repo. Here's what happens:
> - The proprietary IDE re-generates the file and makes a local commit.
> - The IDE does "pull --rebase" which results in a "deleted by us" conflict
> - The IDE immediately re-generates the file, clearing the conflicted state
> - Even though it's in .gitignore, the file remains under version control =
because of the cherry-pick by rebase
>=20
> I was hoping that adding a certain merge=3D attribute for this file would=
 help, but apparently it only considered when two files are merged, not whe=
n one is deleted.

In general, the recommended settings for the merge option are "text",
"binary", and a custom merge driver.  "text" is useful when you have
things that may look binary to Git, but are not, and "binary" is useful
when you have things that look like text but are not usefully mergeable
(such as some PostScript or PDF files).  Custom merge drivers can be
useful in some case, but they don't work with forges since they require
configuration, so they require a lot of setup and careful use.

You can certainly set other things, but they tend to be tricky, and I
can't think of a really great algorithm that will do what you want here,
so I'm not going to propose one.

What you could do is add something to your CI job that fails if the file
is checked in.  Once that's that's activated, people will stop being
able to check it in, and once everyone has a version of the main branch
that doesn't have it checked in, the rebase will stop including it
because it will be ignored, so even if it gets re-created, it won't be
able to be added.

This will cause some minor short-term pain, but it should be enough to
get you in the right direction.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--4uVgSirgx9Sk7Nan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZywLFwAKCRB8DEliiIei
gdW8AQD6l5syI8ODZfX3FNHVjqU7XI11jKZWJWmQzHL9J/BVfgD+IxeqXdhGs80Q
giKyhX3GSpOIn1GEEFjGPc1ueUuMpQc=
=3I6P
-----END PGP SIGNATURE-----

--4uVgSirgx9Sk7Nan--
