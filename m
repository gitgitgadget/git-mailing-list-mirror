Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C923C8A0
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764286091; cv=none; b=A+6HT9iBFEKNVeEqIxKRhG16zD1KPjh18AtlYaaYwbwqua6QggBBw+QXL2EIluVyVGkrtbouAqcAFRJt3FObjmFsq8ZST5Y89iIDxRfjlHxO0Fe8Vp4lKSQ10PRx3LWBOT9dinHtVLogYAnrB4tjkCihRc48zGOaHCbt1lLz5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764286091; c=relaxed/simple;
	bh=R4y3LGAxHzE4OWH6A8xYmWQq3hbMs1iEV296srIv26U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hSDuuTMJvFF4wY94n5Q5rsu/MGcLViFtGqW6e4cNFlq/IbaO11N2hP4YssLQwELjLGL1b/gldj3nSU965HrD99m43ms56Dxl574FRRn4o5DtefEueU+ZUL79Vz/HU1M6wJBjawItA9R1yqH3JnM3cXYxUhcdtQD0NvJ7v1SdXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=p2UorBRe; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="p2UorBRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764286086;
	bh=R4y3LGAxHzE4OWH6A8xYmWQq3hbMs1iEV296srIv26U=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=p2UorBReN1jm8MAyOtwL55Zwng0wrGC5NU3eGiq40p2tQ1ocdiDPJpZBxhray/1ao
	 2in+73h2Gih+KlGDHecSY52L0iX5LtWqMpe/oODJ9NlaMwFL0788ISwvO+ZQ5bDZTR
	 5iZGilwguFPehivMe8/U7ODof1YOW39aGS97HxT0Tzo0pHTid8Yoo6OGXNfo8hc17w
	 LU1OU057yFhF310Mp/wSTQZnxytbGHSkzNiiQ0cwdbrWHkmnaxFzuQ42bUK4FZdwxF
	 qV5j1heDuhDctQrQK/iudvPdiAIgXWlQZS4Ari0GmxbIRuKGNwlWNJX5iBgPj0u+8K
	 0xL9kRQ8TjSN+Wur43/o4F3Tqvmq25lzWC0DJE6eVFRnC1C25gKYaaeqiZQk+q511E
	 J07U1YyAnw8hXWed9FzwjaaY/EHQMhIskTfkyQf0waLRESNVa3W1wjfdR+z6WSlksM
	 lQj8xGNAztOiHMNWHFGhXYwD8Z9DGiKqPiAs5l+5zS+bJN8NeWR
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d48d:a8fd:1e1f:2dee])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 42E5B2003B;
	Thu, 27 Nov 2025 23:28:06 +0000 (UTC)
Date: Thu, 27 Nov 2025 23:28:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Cc: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Possible German translation bug
Message-ID: <aSjehThPX8-WeQR7@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vPXkr/RHYcRgqhG"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)


--5vPXkr/RHYcRgqhG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have the following string in Git, which is translated as follows in
Spanish, French, and German:

----
% git rev-parse --verify nonexistent
fatal: Needed a single revision
% LC_ALL=3Des_MX.UTF-8 git rev-parse --verify nonexistent
fatal: Se necesit=C3=B3 una revisi=C3=B3n singular
% LC_ALL=3Dfr_CA.UTF-8 git rev-parse --verify nonexistent
fatal=C2=A0: Une seule r=C3=A9vision attendue
% LC_ALL=3Dde_DE.UTF-8 git rev-parse --verify nonexistent
Schwerwiegend: Ben=C3=B6tigte einen einzelnen Commit
----

In Spanish and French, we use the translation of the word "revision"
because `git rev-parse --verify` can permit referring to an object of
any type: blob, tree, commit, or tag.  For instance, this is a blob:

----
% git rev-parse --verify v2.0.0:strbuf.c
ee96dcfb816625436582833d812a7156513d5d39
----

But in German, we use the noun "Commit".  I admit my German is not very
good[0] and my technical German is effectively nonexistent, but I
presume "Commit" means "commit" and if so, that's simply not accurate in
this case.

It looks like in other places in the translation we use "Revisionsgang"
for "revision walk" and "Revisionsliste" for "revision list", so maybe
"Revision" is a possible option here, but that would be better decided
by someone with a much better command of German than I have.  Of course,
I could be wrong altogether, in which case please accept my apologies
for the noise.

[0] I do hope to improve it in the new year, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--5vPXkr/RHYcRgqhG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaSjehAAKCRB8DEliiIei
gVSmAQD9t53X4/Q/3GJD5jLP6bhZvMgGBjBLcRWQQHx7C7gpoQEAn6ueAXQLjtdv
8GJUh74CzhgCoUsrmSFw4AsQXRPbiQ0=
=5KVh
-----END PGP SIGNATURE-----

--5vPXkr/RHYcRgqhG--
