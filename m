Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CFECF
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144208; cv=none; b=erER+nrRTK2wsTS/e5VKMlzhVKatR7Iv6Qdz/bCklgByr5ZIbAEPhxEDtUNlNgs1zRUQHkGwtqx6fB6qWlUfgM92POE43L/QX6xCGSP/fHfUoxxwKN7DGSJiLhDJtpwRtr5VQub+u/hxSVsMBe4dbl8g5srvgE6MVpJXHEOrYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144208; c=relaxed/simple;
	bh=sPgM2BmYH3+/oz10Hxqs2rIv3FkNdG8WzCdvOMfZa0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh3E7wZ64BkHLTcyjvzgMAHC201hVp+amqdvm6nXP7kGeWJH7I3BsRTStGOR9BrrKZIrdwX+Fu5O6dABEPT0s9enjgQPjMzbIIJrhHTYWKUHTuj+X9Lz0qTpILRJgBbtshhTDQ8Btyz9yXhdc4CvoD1HitXailxcIkEzpoR0h34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=eZZg3GDP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eZZg3GDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720144204;
	bh=sPgM2BmYH3+/oz10Hxqs2rIv3FkNdG8WzCdvOMfZa0E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=eZZg3GDP9Agwen5GjO6MbKP+n08+5hndBQrsXdnNIYDZdFic7jAclWXeqQTt1tc6b
	 9S0+Qz8wdSyKe2qQH9q0CQsRm1A5lQombJ2ZjUw1K6rf4hR1j2PUKlvgTuzO0S/zjK
	 FPM3bm/QDhWKnq5r0lZ8kvsB8SNaDzhcwLRrylZXsHVKidZOs3BjgBHNN4X6CPJArB
	 O1WSAUZ0jAWSDKB0kIBMW2FuLt8f4QLd+HYIvKjIfeS62nRWMcOTWd08+gphtEBOK+
	 W6BWNCS8TUul6Q8vJetCvSh3R7x9hnSE+RAmRZXEni8xx6XO2fiRhFNVVlUi413xVq
	 2UXUvlTki7Sc/XT9PMOwbzDBXYJ7HFTW/5wYHJ9ipbS0VksTWYTSXrUneR6qp1EzJS
	 PQd6pkXyHbmeKmmQfLWvTJJ2zeKffUBKfQ3yrykm4tJzGEvuKUItCnLGdHnirgXtdw
	 ILUR75MvPJrwnphML5bz8aQSiQ+2qgZwJC1lVlKbQ4JI/xXsRrR
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9E7B620993;
	Fri,  5 Jul 2024 01:50:04 +0000 (UTC)
Date: Fri, 5 Jul 2024 01:50:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Abraham Zsombor Nagy <abrahamzsombornagy@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Unable to push to git server
Message-ID: <ZodRSw9LEwLa_nOG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Abraham Zsombor Nagy <abrahamzsombornagy@gmail.com>,
	git@vger.kernel.org
References: <CANoqcKYwgA5sT0fAgSp4atpuPOaUSDALRVcf9XoajOe0g6xibQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M9kA6evIOEWr423e"
Content-Disposition: inline
In-Reply-To: <CANoqcKYwgA5sT0fAgSp4atpuPOaUSDALRVcf9XoajOe0g6xibQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--M9kA6evIOEWr423e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-04 at 13:56:15, Abraham Zsombor Nagy wrote:
> Hello Git Team,
>=20
> I hope you can help me.
>=20
> I'm trying to push my code to GitHub, however I'm unable to do so:
>=20
> abris@dell:~/Projects/maradandohalo/server$ git push --set-upstream origi=
n main
> Username for 'https://github.com': nazsombor
> Password for 'https://nazsombor@github.com':
> fatal: protocol error: bad line length 175
> send-pack: unexpected disconnect while reading sideband packet
> error: failed to push some refs to
> 'https://github.com/nazsombor/maradandohalo.git'
> Enumerating objects: 31, done.
> Counting objects: 100% (31/31), done.
> Delta compression using up to 16 threads
> Compressing objects: 100% (22/22), done.
>=20
> I use Debian 12. I tried this with the git installed via apt as well
> with the git compiled from source code. Git version: 2.45.GIT
>=20
> I also asked this question first on StackOverflow:
> https://stackoverflow.com/questions/78670914/git-fatal-protocol-error-bad=
-line-length-173

I know you've got this working with SSH, but I'll just mention that
usually this message "protocol error: bad line length" means that you
have some sort of proxy (such as an antivirus or a TLS-intercepting
device) that's tampering with the data.  TLS, which is the protocol used
for encryption on HTTPS URLs, has built-in mechanisms to detect any sort
of accidental or intentional modification of the data, so if we assume
that both your version of Git and GitHub sent valid protocol data, then
this means that if it came out bad on the other side, it was tampered
with in the middle by something that can decrypt the data (which would
have to be something trusted by your machine).

That's why SSH works for you: because the types of proxies that
typically know how to process HTTPS data don't know how to decrypt or
intercept SSH connections, so your data doesn't get corrupted.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--M9kA6evIOEWr423e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZodRSgAKCRB8DEliiIei
gXVLAQDRcF7310c9BjgtCuXEekrqb5WbWo2D5AERaIeFincozAEAufZDigF+TBUU
5994BRaccGtOpK63xnUg2EK/UbgC1QM=
=yWTr
-----END PGP SIGNATURE-----

--M9kA6evIOEWr423e--
