Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F3561FFE
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734989014; cv=none; b=OfGN97MKmWMQ1USO1LsbaFfugQOewWLtZb5dvYFUeNH0ge5AUoy8PoSVBXIIJTR1/F+YOB/981PHsmYkx9a7a2Qs/5wv+0mWmn5vAGWqcNWxTTy4EiHJ8KqSQ6zi3sBZ8bOjQFlFQGIMnVzQP0sBsEmzLYxCIZAVGMDuwk06ei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734989014; c=relaxed/simple;
	bh=8eDkmNP9wSd1PDmssywIqqqmwR20IY3b4/fq1MzQ4tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYrQwwPOILrJfOTqFFu6oxhh0x1J+uc9VcTz0zlZ0gSJY4vgvIKkZ9HBTQnHzVLKaNpfPtjV9T1iPhPiFwQbcOgsh4s3q2UKQ6R3730xNJMJYMXKS21KhrbaYndpFqVpEoGESoYo3DvTkMWVu3Uj75cMToJULlW+IR8pPZm/NCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAqraiCs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAqraiCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA71C4CED3;
	Mon, 23 Dec 2024 21:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734989014;
	bh=8eDkmNP9wSd1PDmssywIqqqmwR20IY3b4/fq1MzQ4tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAqraiCs+5ZpQXNRu2L67yncxvUbvoNsHpQKgeKtSgz76BBnje2BL6sv3QfyKpDRL
	 upgEG3QM1RVIIHsJK7f3Xs5s2ZJo6GcEMwTT3ZOA7mlf4Pue/+qulR9iub6jVmjI09
	 dUw9D0Mj24tCqSEbqYvi/YxwZZWoWMdO2mrD7jSyx5voTXyaih75gQQF9asb1mfOKB
	 KiUR+vACGjd0qmzNW0nO1OK6iTSuOJ0hdXAO8Hli1gVcfPp9FTs5xrg/dJpZNTzSQf
	 BIpJyXqIiJ17ifBTIFnkcU6zOmQHVbv4eF0XUk2TtCIKlUe9zx4tYc6QOTA3oMrdnz
	 Wd7eJpEp7Fm2A==
Date: Mon, 23 Dec 2024 22:23:31 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	git@vger.kernel.org
Subject: Re: git-log --format missing trailing newline character
Message-ID: <elrdfos3fkzjdmhvyxbshsbt6nw723mr3m7blw7ghghnresxi6@vvj7u6jwlgur>
References: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
 <d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>
 <5aib7c6x5m6e4muutjuoqp3f4lvpeh3hz5qkwpayi2usm7b6yi@af2oucx5j4w5>
 <8734ieyumd.fsf@igel.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7gzbljpinvgdakjf"
Content-Disposition: inline
In-Reply-To: <8734ieyumd.fsf@igel.home>


--7gzbljpinvgdakjf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	git@vger.kernel.org
Subject: Re: git-log --format missing trailing newline character
References: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
 <d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>
 <5aib7c6x5m6e4muutjuoqp3f4lvpeh3hz5qkwpayi2usm7b6yi@af2oucx5j4w5>
 <8734ieyumd.fsf@igel.home>
MIME-Version: 1.0
In-Reply-To: <8734ieyumd.fsf@igel.home>

Hi Andreas,

On Mon, Dec 23, 2024 at 10:09:14PM GMT, Andreas Schwab wrote:
> On Dez 23 2024, Alejandro Colomar wrote:
>=20
> > Anyway, it feels awkward that git-log(1) skips the last newline whith
> > --format=3Dformat.  Should that be fixed?
>=20
> If you want terminator semantics, use tformat: instead of format:.

Thanks!

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--7gzbljpinvgdakjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdp1NIACgkQnowa+77/
2zLoOw/9Eo0qDoQDAdJMbUHIkSmcwXnrwI8GzXbzFxlsSF3QhMEbg8IbtENzasro
2Wxq1yvLV4vvsVmTUVZzFlmOcvTy/H/0+m/8T7EsgAvYwhi5Pjz/v0e2i/bfMUsF
kraSbvQH4Xp0TgZ8qsU2iCjQbOgwiz6vYFkmlkDtZ1fh9oTaCKBqH3x2bdClt5Qk
+4PhBC912oZ6APEbI3EzuXKUvr5z6h6wIl6vA8SB3vEMOQYx8dZUQhIACgBsusbf
KuWu0bL7kwWFumDhk2kUOtB9dxnRrC8TzYYMzeStjxtt1CUH0zUOso6AN7LKaEAO
4wyRoC9QEn5pykKjGeVkLyLAxNPifpXGbikD6q5q5kFuRe6siK4rzN9GUqsQQc2D
EDHtnMD3Ku7WS9SlRV2z3goBayGPGoQFEOBfAa4HG83gzn4rFdkhvp68Qow59anG
1VEIJ8AaMJjwE5qVm7ryRplKlRbpJxayCN0Hkkga6MujM0zFAuZlyJlXL0/PqDhb
IqBblns6+x875m99K6xuPnRzc2c7LpF/j9R36DswpXwZBRRXq1b5gbqTzaduJusc
Na3KplA4P3J+ekb/lEBz5Tw7/UC+u5Idnk8ujpLPJsgiKXJU7C82Z5gxaRGDLrnB
F5GuVjcuC4admhFX5UdhA4Fm1cbhavleSK6Ykn02Bgvjat+JcG0=
=my1K
-----END PGP SIGNATURE-----

--7gzbljpinvgdakjf--
