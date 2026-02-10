Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8432FC004;
	Tue, 10 Feb 2026 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749077; cv=none; b=JiorSuABnD+AfYWfj3Xo/1ZbBMDr/KmJrPlANNltDGcjP1DCIVt7cxNCXvdbqzeOH3Fg766jaQNursDnHx5/Exbh9VBy/ZZ8SwwSO20rBiXq4nKx83AZMJIiDUkn3VgWPBmh64Z4EB7nb+a+YDmEgUHX5mNu6Qez1IbqV77te64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749077; c=relaxed/simple;
	bh=afLwYPyTKZCdm4dpPBlSE3FzRf8GrP7fnLrK+695bos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnhOh9FH7Hbe1LfOsM/uZqdAPT3+tBJd4XDQpMq+ALj563fIMh6oPAoVnuGP58OwfQD7mi15sAQl/dYsQTk6FLTPxa9aj4tRPuaGY2xr/o/3p0QeQecp8dZLg2Qu3pKgpDSfKtcspTGLKmI1zRYsdtg50L47Lzdpurz0Iyaq5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbxZSCD0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbxZSCD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B844C116C6;
	Tue, 10 Feb 2026 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770749076;
	bh=afLwYPyTKZCdm4dpPBlSE3FzRf8GrP7fnLrK+695bos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbxZSCD0zD2vBKuZwedNgg5UM/AIzHv7T1ovlCj4IGpIZXm/qJrLVGTxvJaRASi09
	 GhzQ7bLVi23G4whOZmFDcIzEsI1VX6wFSp0FRMwOGdj48JlU2CUS15BTRh3QcvbCgp
	 QVmfRF1ddyVRU4TZN3Xy8aLI3nDLW8TzRIc7kmjQUEWGp01M32KjFQ3v2OJo+sCOCg
	 gpdi1fp4v/gBdHEhDGdq9MgL9HsVCGDqeYryXORxk3I02AyOub2sYkp12+cR9WTHKr
	 62OVo8Rbx6OIo3BL8qGW08Csk3mhg+vjECxxpATJNXMu9E919A78el0By+sK6EVYvk
	 08bx7QN20KJBQ==
Date: Tue, 10 Feb 2026 19:44:32 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	=?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>, linux-man@vger.kernel.org
Subject: Re: [PATCH v2] futex_waitv.2: new page
Message-ID: <aYt79QGo9u9KHvNd@devuan>
References: <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
 <aYtAknObJpjszCaj@devuan>
 <xmqqtsvozgi2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jlaktbqwucvhu7ib"
Content-Disposition: inline
In-Reply-To: <xmqqtsvozgi2.fsf@gitster.g>


--jlaktbqwucvhu7ib
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	=?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>, linux-man@vger.kernel.org
Subject: Re: [PATCH v2] futex_waitv.2: new page
Message-ID: <aYt79QGo9u9KHvNd@devuan>
References: <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
 <aYtAknObJpjszCaj@devuan>
 <xmqqtsvozgi2.fsf@gitster.g>
MIME-Version: 1.0
In-Reply-To: <xmqqtsvozgi2.fsf@gitster.g>

Hi Junio,

On 2026-02-10T08:54:13-0800, Junio C Hamano wrote:
> Alejandro Colomar <alx@kernel.org> writes:
>=20
> > Junio, do you still have this queued?
> > <https://lore.kernel.org/git/xmqqy1o5op1i.fsf@gitster.g/t/#m6f42ff4f0cb=
2d6dd1d68f12a533d04c822b68a80>
>=20
> Still queued??  Not very likely.
>=20
> It is a topic from almost 3 years ago, so it is either in an ancient
> released version, or it was discarded long time ago for some issues.
> Given that it is from Peff, it is very likely the former.
>=20
> https://git.kernel.org/pub/scm/git/git.git/commit/?h=3D15108de2fa0&id=3D1=
5108de2fa0cd8f002a0551d14c84505a853071c   =20
>=20
> That's v2.41.0-rc0~141 if my "git describe --contains" is counting
> correctly.
>=20
> My secretary will bill you for 30 minutes of my time and for making
> me miss a meeting with external folks with this ;-).

Ohh, sorry!  :)

The problem seems to be still alive in some stable branch, probably in
oldstable distros.  I guess I'll have to deal every now and then with
those, depending on how many people discover diff.noprefix while still
using old versions.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--jlaktbqwucvhu7ib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmLfJAACgkQ64mZXMKQ
wqnS/hAAo9IriEn7gmGJnTzHbE8VmcKiZu8HdllXG3g5br25ZimAIKCfvxUFjKlP
1lG3AD0J9WwR0ijt//ifdz/oMLY2DhP3XHyrUkBt5myJb3iod2snaFKXnsoEwqfq
GxRUD6F9P0znpHQMWqGt/gOLLFALNxWyl5e8Sq+Q/XvggY7Ig/ulUKFuaq3hQ/JO
GmDqp98pzVE7tqrwYg/cM93+BteLiATw8zD7NoqVL3JS42IAd9pw3rTvpu/JSnS4
2eSDQnM7ZeG+L5rKQYIh8smWNFmuwt/6dj7cSvrYZOymNgDIPBqtpl1bNU1hBKXt
gdVNemCQB3u40hPwk1RnN0+AL+KrgI4waxPFKvtN05EA88C8YbpkF51kxgWmVL+p
G1h9c55gnDq+/nDfZEme0zY11cddUZ03kKYqnn/K/HqA88XWAXQ58oNpucH8vo1o
6FwAU6lppb6gZZnPYVIJTBHzxdQlX3ghjmhhjfb1UWu3G+vHL4XZKPKap1VMKx4c
mVxzi8GWkBXj3tkslQM/tCsnQp3LYBOco45/rNHoNkpnt2XEbdvip2+VkhHkbn+w
LPjz10F2yqKkoIsc81A1QzaRb5B1YG5DwlQF6fLZa6FbWOYL8PlSNuVs73aQSoho
Dti7hv8YBv3QRGVCctPkTGMlA1Tq+DHAPpHBYeDRRLrA+TfRs9U=
=EeRs
-----END PGP SIGNATURE-----

--jlaktbqwucvhu7ib--
