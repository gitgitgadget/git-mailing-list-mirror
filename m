Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01FE82488
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214345; cv=none; b=B/Q8ca6/dq80al+sX5wW8VDBD8gieOQJUOcsaxuK3eHNSPMAK/vpJXvTv8i7H5Hro1Tk4h+OssZA0DsA63kl3qNnvSLmt7HZWpuuI/myMvgQbPYh9K91dEI5nkuTabnGQ1MN9kaSz3iAPjhRkhgtcD35h799zHZXfvFzf85R3NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214345; c=relaxed/simple;
	bh=mm42NV7lMOtp7apk7VJaRj2F+9Ma8Eo791nGXYwTVRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBpuFC9j5A67vHXh+pqI/67JKw8IV3Y0Lrj8eM//t4ocaNe8O78sdsO8qvKhfODqqpVU7YxvOseA0CZomGta/GzJaeLic8dPChdgF3MVM//Mf3a+Q9YvTNDItU3f6xl+8vqLoOXfT4stGS/P/n6/TJRHg+wYhg6QrtrWAwMpp/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=miQzngsQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="miQzngsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727214335;
	bh=mm42NV7lMOtp7apk7VJaRj2F+9Ma8Eo791nGXYwTVRI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=miQzngsQrTbkNIk+teKGT3NsenQypVijKXM7sqMzpI+/sbAVpHW1KJGQSBgXgSvQe
	 +qKNnrI5aRh69U9Lp/eQEhyVGnDzW3mxCsQ7B0GPHnbFXMsrQHM0bl6AMROdT7C4wf
	 hMf4JSBynkl8oIvEr1RpgM/0EsmxYXJrXsRq4GpzX4+HFLBXFy9qdsIKdV26VPZvp2
	 WqjPwmQ9CzSTk+mui5I5nmhV/v+6aMRr0g8w6pFXfLFC/7mWOaCzFj1SbY8dRhCtCQ
	 o/WclpLV2QIj+a2MQwVL78VMPHXPs538kg51gqqWFPWToUDFg5WOhNTIX0evkCNF9q
	 bkt9dhAnmHQoEl5hD8T5mLqQKXCztX6I7Kjmjy0w2TKhmo9taX6itY+OkY3nxfRIgD
	 KKyO6ar0zkWbpaaNLVi6Vtbt01A1XNw4nwlagA34xKmR/6s6ZXQIKVzu6uXPP2RUTs
	 7dqdvR/7mA3rpRARY6QPO5XNPD/Ktav8BsEUim2PF4/l6j+374J
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8400620073;
	Tue, 24 Sep 2024 21:45:35 +0000 (UTC)
Date: Tue, 24 Sep 2024 21:45:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git clone failure
Message-ID: <ZvMy_gAL96v8ahfz@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Krishna Vivek Vitta <kvitta@microsoft.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SI2P153MB071833367C62DD94C96CF1F7D46F2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UCx1j1l4ZimLJPEq"
Content-Disposition: inline
In-Reply-To: <SI2P153MB071833367C62DD94C96CF1F7D46F2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--UCx1j1l4ZimLJPEq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-23 at 10:47:08, Krishna Vivek Vitta wrote:
> Hi experts
>=20
> Need your help in identifying the root cause for issue.
>=20
> We've seen multiple reports of git repositories failing to clone / gettin=
g corrupted in p9 file system. The mount points under this file system are =
marked for FANOTIFY to intercept file system events
>=20
> When we remove the marking on these mount points, git clone succeeds.
>=20
> Following is the error message:
> kvitta@DESKTOP-OOHD5UG:/mnt/c/Users/Krishna Vivek$ git clone https://gith=
ub.com/zlatko-michailov/abc.git gtest Cloning into 'gtest'...
> fatal: unknown error occurred while reading the configuration files
>=20
> Any reason why it is failing ? Any help in this regard would be highly ap=
preciated.

Can you tell us more about what environment you're using?  Is this
Windows, macOS, Linux, WSL (1 or 2), or something else?  What version of
the OS is it? What is backing the 9p file system (and what file system
type is it), and how are you mounting it?  Is it a network file system?
Are you using any sort of non-default antivirus, firewall, or monitoring
software, and if so, have you tried to completely uninstall it and
restart to see if that fixes the problem?

Also, are you using any sort of file syncing service for the directory
in question, such as Dropbox or OneDrive?  Those are known to corrupt
repositories and the Git FAQ is clear that you must not store
repositories within them.

The reason I ask all these questions is because I have an open source
tool which allows mounting 9p file systems from a remote system by using
the Linux kernel's 9p support and I don't see this problem.  I don't
think there's anything intrinsically problematic with 9p file systems,
although you definitely need 9p2000.u or 9p2000.L (the Unix or Linux
variants of the protocol) to make the file system suitably functional
and POSIX compliant.

My guess is that there's something else about your environment that's
causing the problem.  It looks like maybe you're using some variant of
WSL, and maybe you have an antivirus that's preventing the files from
being read, which is causing this error on the Linux side.  However,
without more information, it's not really possible for me to say more
about what might be going wrong.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--UCx1j1l4ZimLJPEq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZvMy/QAKCRB8DEliiIei
gWvNAQCMfor/eSQpyo90Qg15k5N3Er/BxIlCsepGxamyMlpVfwD/ZjKl2YFfDkt8
TVih0L0j/ihpLSN9+DqRGH7jC1rMtgQ=
=Luyo
-----END PGP SIGNATURE-----

--UCx1j1l4ZimLJPEq--
