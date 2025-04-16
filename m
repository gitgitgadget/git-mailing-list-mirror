Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39672221266
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744838260; cv=none; b=Z/VPvjOGptCLO2qmcGiOblGVl+AdVQuInGH0Hh45Q+URS4jD2UYgoLEmreEz+RVyBPCX2dEzc+Xn0LAwppkujOUeX8YjMlVGD8B075HbV0DFS4+LUx++5iLnlXD/ImzzJTXADLkzCQ2XZSa2144wOjc5qhln+4DGWzShpG0ayFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744838260; c=relaxed/simple;
	bh=ZRSCrnyczlbxsgO5IZqE/K/0oDIJ3WO5qzUYwuay86Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSUAevEA79hsNYoynUXnBg7W/aHn38+qESH2uEZlrv+OfP9kiCFzt1qkpyNgoAmkBdx7XBfeIh18wogBwKIXfHjT4WR0UNSvtEMiUPWEaqr5V4u0KnwKm0CMgcvfBk3LWoaSaR2sX9oicsEls4C5tFp9ADW1n7yoCPR/lb0pbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=rY9pwQs8; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rY9pwQs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744838255;
	bh=ZRSCrnyczlbxsgO5IZqE/K/0oDIJ3WO5qzUYwuay86Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=rY9pwQs8ptYOgVQuHKWp8JXZR2j3LFt2y/jty7z6KrduuN2J/vf1jVdHaWvDbOzPj
	 vErBTK2Dz1aQCEoZ1+ABf5iIx0WVR+3Ypg4Tn9GJQDwr1j1AWe8HoqwLLzcXUj6pYM
	 LvqIfbsSxVWOeFfLOvMnqMT5/lCqCdAhc8T0wbVyn025FU1CV+eI65VtPyt7/JhUdP
	 4OZadx9XuhiEgnQjyv9q/G1Cip6o2CEO57U7Du9FhpuofmbMZbbPzULMNJE07DZtQJ
	 XmYBId2MiKL0fNMyaG8ZKb0wxmdnOJGD6qKx+nCgq+eBKCLU17pjgEkg4B4/LCtyH9
	 xRRRUMQBtmU2v4rKJVsiHOEIw5dXcqauLqrtODmMsTI92PrtGbLA+HmskB2/luhwD4
	 sNOGFd8HjyvqYUw8np5hrz6s2H5//3X0CcZSgD59buDXV43CdPbCmQFXDAOWB+rGMq
	 JD7lrR4wY5qd/EbpO55LPhFe0un72t28IrxHqwSiSpxM5MXspr4
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AB83120107;
	Wed, 16 Apr 2025 21:17:35 +0000 (UTC)
Date: Wed, 16 Apr 2025 21:17:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?5by156eA56mO?= KITTY <kittychang@cathayholdings.com.tw>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	=?utf-8?B?6Zai6Kmp56mO?= VANESSA <VanessaKuang@cathayholdings.com.tw>
Subject: Re: Get support
Message-ID: <aAAebiStHoOnbmbX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?5by156eA56mO?= KITTY <kittychang@cathayholdings.com.tw>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?utf-8?B?6Zai6Kmp56mO?= VANESSA <VanessaKuang@cathayholdings.com.tw>
References: <1744786449-14024-mlmmj-0f30ebef@vger.kernel.org>
 <202504160735.53G7ZjeU083840@365mse01.symphox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mf3f+zYHf+xbl+1Z"
Content-Disposition: inline
In-Reply-To: <202504160735.53G7ZjeU083840@365mse01.symphox.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--mf3f+zYHf+xbl+1Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-16 at 07:35:38, =E5=BC=B5=E7=A7=80=E7=A9=8E KITTY wrote:
> Hi git support,
>=20
> We have problem =E2=80=98cloning repos from AzureDevOps via SourceTree or=
 via command line.=E2=80=99
> We guess this is a Microsoft issue before, but later we find that this is=
sue comes with specific git version. (Microsoft case: 2412240040000772)
>=20
> Different git version got different result.
>=20
> Git for Windows v2.30.2-rc0.windows.1 ~ 2.43 ---> Clone success
>=20
> Git for Windows v2.44.0-rc0.windows.1 or above ---> Clone failed
>=20
>=20
> To prevent git version 2.30.2~2.43 from reaching EOL, we need to know how=
 to successfully clone repos after upgrading git version to 2.44 or above.
> Any suggestion is appreciate.
>=20
> The Error Message:
>=20
> ----clone by Sourcetree----
> git -c filter.lfs.smudge=3D -c filter.lfs.required=3Dfalse -c diff.mnemon=
icprefix=3Dfalse -c core.quotepath=3Dfalse --no-optional-locks clone --bran=
ch develop https://cfhdevops@dev.azure.com/cfhdevops/IT-CBooking/_git/catha=
ymeetingroom "\\CFHVDIFSVIP\CFH_VDI_UserData$\00904813.CFHDOM\My Documents\=
cathaymeetingroom"
> Cloning into '\\CFHVDIFSVIP\CFH_VDI_UserData$\00904813.CFHDOM\My Document=
s\cathaymeetingroom'...
> error: RPC failed; curl 56 OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0 C=
ompleted with errors, see above.
>=20
> ----clone by command line ----
> $ git clone https://cfhdevops@dev.azure.com/cfhdevops/IT-Contract/_git/IT=
-Contract
> Cloning into 'IT-Contract'...
> remote: Azure Repos
> remote: Found 10 objects to send. (25 ms)
> error: RPC failed; curl 56 OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0 U=
npacking objects: 100% (10/10), 2.18 GiB | 6.12 MiB/s, done.
=20
I would recommend reporting this to the Git for Windows project at
https://github.com/git-for-windows/git/issues.  Some searching shows
that this might be https://github.com/git-for-windows/git/issues/4997.

The reason I suggest reporting this there is that this looks like it
might be Windows-specific or specific to a particular version of
libcurl and on Windows the latter is shipped as part of Git for Windows.

I'd also recommend trying to track down with more specificity the exact
versions that are affected, which can help the maintainer identify any
relevant changes and get the problem fixed sooner.  I'm sure Dscho has
introduced lots of changes between 2.30.2 and 2.44.0-rc0, not to mention
the numerous Git changes, and having more details will help pinpoint the
problem more easily.

Also, if you can reproduce the problem with other forges (say, GitHub or
GitLab) or not, that is also helpful information to have.

Best of luck in trying to get this fixed.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--mf3f+zYHf+xbl+1Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgAHm4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ15peoV5hwTopwGo2P2tX4suwG7aJlYcpi7iCXZDzsnF
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJOYAQDkZ8D+df7CV1rFf+18Znv6mMte
ne5A2ACZssCVIXmVyQD/e3aplB5noYTxLFMU+uYvNizw9WqUbzazmH7IjLiGkAY=
=eyC6
-----END PGP SIGNATURE-----

--mf3f+zYHf+xbl+1Z--
