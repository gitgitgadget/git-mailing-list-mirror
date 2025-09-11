Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D57DDA9
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757549387; cv=none; b=TlbgH9DIpEMM7Ag5ddDN0uqQeqo6cMUkyrkNG+hZEW5dvR+JQjJfzMNJHUGI3e9qOZJz91rsFl/aiaFOq578a8sxG6dwYoQT2FBjTEeQ55VlDRNY97GxKnSmqPVGb9m0LoB4iFG1pra9fbzuGATN5s658aiEaeZCTfSY/I8UkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757549387; c=relaxed/simple;
	bh=r9cJi9SMiPmU1updfVYWQp2w/IModHakbvlSOXjAhIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYTl3jc5rV0r11o9iL+gvB15yhMOyZHhnJR6JB/bOUCsFu51BxR92Y+qLCKwtxEiaAXJ4FC6JZcgNudt02O0uNt8u2HNc3CG1oabp6xvhhu4vTyLzDYg394nTfnhQzaASCGvWg0W9uLPTJqExkG72pP0aDBwGN2H/afHvVMBCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qWOU0s25; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qWOU0s25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757548861;
	bh=r9cJi9SMiPmU1updfVYWQp2w/IModHakbvlSOXjAhIg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qWOU0s25uljy0kp00pYwOs+FspjYk7AviDOmWaiBkD8+nDc4iwIeGjRzAyXEEZTwR
	 D05+khYVEkBfk9GCaTDz7xv7ar+ixroqF1rbdoKtatcFpYo3oD99abKbqHZeMJDTTr
	 FRRcZi55cFTiWbsBHrooaPqi8pzoRg0731nTKgFu9/fBNmaR6lPRL7az21YnoLIHac
	 cJp1jEQ/MAKpDgNAxhO3UqAXykXruHfwzbyJpsXfgaeK/uLsQyAmJ3UxqJt/5gjHfQ
	 lB8o4F+XR+V/3NdfGS3PNUR/Glcfabn5U5dtYBYzrPCTeNZn7VHGHfI2hMpgv3jJla
	 ksgXtQEyWvI62jcHi6EWy6++L99Lz3l2RXWo9Y+Pyp3awVT8+JMXHo5qnZSlZbbkvj
	 7vUzvJ3wd8wPX4mUAfx2GC/roPTQBx+1xKtJQLBmMsSQluChhThJCMEpc4KYMMj/oa
	 4+yre0sX1wNP1s1Nr2VQpqIyxUHSjBPSKmqXlepQ8QYyvxuUMGI
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:af06:f98c:b6c2:9ddd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 25DEF20105;
	Thu, 11 Sep 2025 00:01:01 +0000 (UTC)
Date: Thu, 11 Sep 2025 00:00:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: ynckz <yanckezcs@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git private branch Feature Suggestion
Message-ID: <aMIRO83CyG_qtKez@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	ynckz <yanckezcs@gmail.com>, git@vger.kernel.org
References: <CAGyVUB5QLV+HQMWT+0kDu1_H0uXHK7kTy35WqhXQaETZ5if5EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Di6tLfYVR7XEb/X"
Content-Disposition: inline
In-Reply-To: <CAGyVUB5QLV+HQMWT+0kDu1_H0uXHK7kTy35WqhXQaETZ5if5EQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--5Di6tLfYVR7XEb/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-10 at 23:28:54, ynckz wrote:
> Hi Git developers,
>=20
> I have a request for you. Could you please add private branches? This
> is a really useful thing.
> Imagine that you want to publish your project as open source, but you
> need to hide the .env file in a separate repository. It's easier to do
> everything in one repository, but in a different branch. Maybe there
> is another way, and I'm just dumb as fuck, but here's another example:
> Say you don't want to release a new feature yet. To do so, create a
> private branch, make the feature there, then merge it into the main
> branch.

The reason we haven't added this is that it isn't secure.  Git has a
feature called namespaces, which basically implements the feature you
want.  There are different namespaces and references can be stored in
any one of them.

Here's what the gitnamespaces(5) manual page says about this:

    The fetch and push protocols are not designed to prevent one side
    from stealing data from the other repository that was not intended
    to be shared. If you have private data that you need to protect from
    a malicious peer, your best option is to store it in another
    repository. This applies to both clients and servers. In particular,
    namespaces on a server are not effective for read access control;
    you should only grant read access to a namespace to clients that you
    would trust with read access to the entire repository.

It then goes on to explain the kinds of approaches that can be used to
exploit this, but basically, if an attacker can find an object ID that
it thinks the server has, it can acquire information about that object.

Now, you might say, well, the object ID is private.  But it's very
common to leak those in issues, build logs, or as part of a version
identified in a build, so in general we can't base security on that.
Cryptography tells us that cryptographic hashes of general data are not
secrets, so we cannot rely on them for access control.

It could be possible to allow this _if_ Git had some way to know that
the client was only allowed to access certain refs _and_ Git were
configured to only allow access to objects that were reachable from
those refs.  However, Git doesn't have that information and that's in
general expensive to determine, so it would make things like partial
clone perform really terribly.  It would also require a lot of changes
to Git's internals and security model, and nobody has so far volunteered
to do that.

I will note that in general, secrets should never be checked into a
repository.  It's too easy to accidentally expose a repository, and when
that happens, you leak every secret in the entire history, and then
rotating them all is a colossal hassle.  (I know, I've had to do it.) If
you use a secret store, which is a security best practice, then this
doesn't happen.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--5Di6tLfYVR7XEb/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMIROwAKCRB8DEliiIei
gSgiAQCDvmecAix0NwksItR5bWUZHxfT/x4mr8qMKN4zzax0sgD+OuYUoycDwHX4
yzL877EGz2GZyy1PgcDQweZ04/duBAI=
=Mzfs
-----END PGP SIGNATURE-----

--5Di6tLfYVR7XEb/X--
