Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636712FB37
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290396; cv=none; b=qcd92h7mIfwbUdj1JUS2cSqqW+8z+chVa8bPkaUNSaZ8Sy1csiTUqQnJEVa71Qr9ZMdBrXbdOn41rB7JJZQs06DUe0HoZZ3iC5laLBLncdnGUd7PJiDGR0uslV/gNR/C9tEGb2lP2IeqDybx9sXhnDYNUi/gDuoxfy1A8C4Ywhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290396; c=relaxed/simple;
	bh=sfxbIu9Zofj25602pD7k4wU6J4+YZVZO9lQHiky9y7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbJE/Vl/8nho5kwDBdFh6DHbmAH5QWqWUlJOljwqrIQXH3yA63GQ7yt9Br+5Y/boe/EfRrKaJAqss9LIdK3yy7uH9HCOdW+eSpHK4tvaUt8FjjW1EIyKE6Z5EtpKWlly8kOeynig+9poVJr926i5EdnoXRdbKqieWWJQZSNqJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lxyzbwXm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lxyzbwXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722289960;
	bh=sfxbIu9Zofj25602pD7k4wU6J4+YZVZO9lQHiky9y7E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lxyzbwXmRNs6BMJJdaew5Bd9jiDfGEt7jxG8BX0ypURA0CvOFGGuEVgXGsH1Own76
	 tzhBWl8nYjz0Kl7hMSz+zzubNN7sOOfBzFUXjxajRusHikXepOGqa+E6gbat19pLh5
	 MecX2HfYb6yknOxLW5NrNN0d3zPdEF7h90KJshG92/nFxsctHtOicnxpBSdtVWMPVn
	 RLPUZVI7SkfPrfdxOaa2wJ+XF2S05sNyGy5ZZ7ar1bHWDScCcwqTEel+/Fs8Oxy3R1
	 Hi1s4RaPKBRiGLCHpUzvh02tD7lbfqaEmr/jzCQbDo1COQl/Q4undF+/T5mcSZJzN4
	 YHoaz3vt+mBtDTMSg4c99D3DDALKuIUMNcMPoF9atzFMPp47RzDoIX1Rbod5MORgmI
	 O6KYIyLwoxAxuxPgmUkuJYoCWwnM5qnb5ZInBrN7WhupNtGTRwMLCTFQkrtrfR/M2U
	 +9CmeZUj9E70SIWDA9MUKGENNyABorG1Xn7RqYOYgr8yZJtKYvz
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:f30:4e4:740:45b5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 06074209B9;
	Mon, 29 Jul 2024 21:52:40 +0000 (UTC)
Date: Mon, 29 Jul 2024 21:52:37 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michael Salman <mjsalman@pathcom.com>
Cc: git@vger.kernel.org
Subject: Re: Problem
Message-ID: <ZqgPJYH190j_4ZGM@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Salman <mjsalman@pathcom.com>, git@vger.kernel.org
References: <c35ed7ff-48b6-4555-baef-cccdc926e6ba@pathcom.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mgvKScvcBCHaewv3"
Content-Disposition: inline
In-Reply-To: <c35ed7ff-48b6-4555-baef-cccdc926e6ba@pathcom.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--mgvKScvcBCHaewv3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-27 at 22:38:22, Michael Salman wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> Using visual studio created a project and initialized it. Git works fine
> under vs
> What did you expect to happen? (Expected behavior)
> Using a command prompt I cd to where the repository is and give the comma=
nd
> git status.
> What happened instead? (Actual behavior)
> It reports that this is not a valid repository. I noticed that the
> repository does not have a .git file
> What's different between what you expected and what actually happened?
> Using command prompt if I cd to a different repository (which has a .git
> file) the git status command works fine

A Git repository with a working tree doesn't strictly have to have a
`.git` file or directory, but if you don't have one, you have to
explicitly set configuration options or environment variables to make
this work.  Since I very much doubt that was done here, it sounds like
this actually is not a Git repository, and Visual Studio has a bug that
causes it to either misconfigure Git or not work with it properly.  It
should at least provide you sufficient information to allow you to
determine how it initialized the repository and where it's storing the
data so you can properly work with it using the command line tools.

In any event, this sounds like a Visual Studio bug and not a Git bug, so
I'd report it to the appropriate Visual Studio issue tracker.  I don't
think there's anything we can do here, since we don't know how Visual
Studio is invoking Git or how it's configuring the repository.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--mgvKScvcBCHaewv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZqgPJQAKCRB8DEliiIei
gdwZAQDcG7sjAizboUmEicqzzBW6WF2YJ2Gdbqz7Y6VotjjGBQEAoXtk4FXxmVbr
KnsPsxzb+UTZQKAWJo0MZovKmeF7xgw=
=aqGQ
-----END PGP SIGNATURE-----

--mgvKScvcBCHaewv3--
