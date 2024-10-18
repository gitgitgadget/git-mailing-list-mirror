Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712118E354
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729292873; cv=none; b=rZZsG+aSCOX5ju89PxmZHXFc20OkOId1jXjneWPV2BWzmYibPHAUKHXc+RjghsJOJ4Qj1XTGYpFlPi7DO4D08jVgB0bQcCVT+RNRuewoqjfz2gctQ9F+zDlzoYE/PkufxtE8rRkFZkSV/i8Ax2EH9zzb3/TdVnW+XggV5l3D414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729292873; c=relaxed/simple;
	bh=da8Mn2d27qJ9KH4mR/60Ds11r+1i81PFSoxlhr9nvg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvqfzg1Gwk7/CAHq9nr07ZJMS5WVssIgtqYOgPvRBack8nmbt+yIvDA4P9WnQJWGnwKZJJOsTXqnX5oNxYDGQVljXAVn64z/o7UJ4jyxDUY698XhvgpnW5g920+qKU/7oVS3ipVxsJirgc3TSww/Irs1jpdyb68JE2gwhvhjli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fMhFclU/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fMhFclU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729292868;
	bh=da8Mn2d27qJ9KH4mR/60Ds11r+1i81PFSoxlhr9nvg0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fMhFclU/n2chSNkgUNMWqKIplhwYEJoBznP1ER8TSRDAI0eY3cx2EKP1LaAtQ5L29
	 2pZs2AwXXS1mPNL70QmTLcTRGZmX9ALPSygjPFdv/kuX9LLff5AhpVrXfrrAwYVZK0
	 1Md7XgCVAPG54XMCGTq+WunyTG0ZkdZ6bhNahR/cuMb9NzadUcPunqvdbys/8NKaUP
	 9Vc22bKLanS0zhZRRl9qnWP7gXJZgWlBPviOaZ6Jy/+hkx81h3lbzKpA1cfYesCs+g
	 tq10wlYWUgxBTbfsEl9+3okzcJFaRegwO37KZbmzAcs8+GtNgQia+k5bAvqvnEYKod
	 R4EySV2pAO2hzDRMxhRZeDB/NKg+jZUkw6bn02j3bXRp7Tqv9TAh6e4ewOXlnAL67H
	 KxZapxKRwkMl8mjgW5P6fZCr6bF26V24d56LarYmnCzveLylV0Ex6qJAocKVJW27pc
	 aPTUDf6m4fMv+COJ8glP04kD173EEi+mAp1J3RyKzi8ffyzQet8
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7833F200B1;
	Fri, 18 Oct 2024 23:07:48 +0000 (UTC)
Date: Fri, 18 Oct 2024 23:07:46 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aswin Benny <aswinbenny.edu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Feature Request : Get repo size without cloning
Message-ID: <ZxLqQlNEPKT6CoGh@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aswin Benny <aswinbenny.edu@gmail.com>, git@vger.kernel.org
References: <CAHJ9C2JNVH6SmE5FoR7u7Z=5eynm8QfW4ZHMeA6dvP0FodxNWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awDbY7qWaRBCGWJN"
Content-Disposition: inline
In-Reply-To: <CAHJ9C2JNVH6SmE5FoR7u7Z=5eynm8QfW4ZHMeA6dvP0FodxNWA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--awDbY7qWaRBCGWJN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-18 at 09:50:00, Aswin Benny wrote:
> I would like to request the following features to git :
> 1. A command or feature to get the size of the repo without cloning it
> to the system
> 2. An option to know the size of objects that will be downloaded forehand.

These are actually really difficult to know without actually performing
the operation.  For example, GitHub and many other forges store all of
the objects in a repository network in a single alternate, but only a
part of those objects (the ones in the repository you're cloning or
fetching) are included.

In addition, to know the size of the pack being generated, there's no
more efficient way than generating the pack.  For example, a repository
with identical structure but containing 500 MB of text files (source
code, literature, etc.) will be much smaller than a repository with 500
MB of random data because the former deltifies and compresses much
better than the latter.  We don't know the size of the pack file being
sent until we've actually compressed and deltified the objects.

We can, of course, make estimations of this data based on what's on disk
on the server side.  But, just like with GitHub's API, it's not always
possible to know exactly, and some users will be unhappy with a value
that's not exactly correct.  (I can confirm there are users who feel
this way about GitHub's API functionality, and I understand their
concerns.)

Given this, I'm not super excited about adding this feature to Git,
because I think it will set us up for a lot of complaints when the data
isn't exactly correct, especially when the data is far off from the
actual value, and I don't think the utility is worth it.  But perhaps
you or someone else can write a patch and it will be accepted, with the
proviso that the data might not be correct, and users will still find it
useful.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--awDbY7qWaRBCGWJN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxLqQQAKCRB8DEliiIei
gVxZAP0VKq4eK8Aayt7V1e9kiRsaPuu0925NHR6eKIDlx7nBAwD/fMQKZ4K7gbyU
KbY1EcHgPkiw2dNp5uVqYkx1vhei7A8=
=H22O
-----END PGP SIGNATURE-----

--awDbY7qWaRBCGWJN--
