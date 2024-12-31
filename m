Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6C18BBB0
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735679032; cv=none; b=EpPww5axcSTaG/cJxX+M5o67AZC2KN5OahsORWbBMAyayA6bxGMBGcUL2lrs3X02R0JpwAWiY0FNvaQPYbGGQbjGo2vmCDdAHiDW0jeYo0QPaUwR6f6Fd5M+i/4Me32V327J8Gi7dt6n7c/8tFwTDBdpTUbO7JG3YjW3GzvV9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735679032; c=relaxed/simple;
	bh=LmtRDa1iCAreftfA+PhcpdQeCR2U7DJi/vwauUVfkIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axibB2qxyfEM+wnzCA97erypDKirCWo4Fzmi23XG5nyecEFMZDqgh6+tcIdcTAFOKLMv7q4PQ5oNc/HhvfXnl5LcKihiEyOalioE+4bsUSK7iU11QGAWyIS8E2usEXEsVdBio/lILvdMnDpcC/GzRHPKEt6mpnVM08CIKwpVr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUqzGnXy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUqzGnXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C5DC4AF09;
	Tue, 31 Dec 2024 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735679031;
	bh=LmtRDa1iCAreftfA+PhcpdQeCR2U7DJi/vwauUVfkIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUqzGnXy6DxPMg+dVSGzYTBjm4BWRYaOHOeBcP1hBNP/GKHPrdeVouer/AnppopN/
	 cR57z28Y6iPcZxJTvcYkrIAWOrwu03sWIwyQxLQOH/OyCQMB7y0DgRv2y26IXAaz+2
	 4wRvM3Y3u7VSem2T6BodAOoOZ2ZlpZwdJ/4FUFWmglqkLdf5qIVEwSY53jqZyJevQk
	 BgkLui+Rq/YUNd07CDMMMe7bl2CoMjvY0DiKhwyNrrOSod0rjyKYJjUfnnsGxvZ0rh
	 j+PdhpQ7glYWYqH2STtgrvbmN7tu9ZEVtYZO/G1ki0+/Z/+bDNy0Nbiwffj02PiEuD
	 b5KXpNoyZ9S3g==
Date: Tue, 31 Dec 2024 22:03:50 +0100
From: Alejandro Colomar <alx@kernel.org>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: /etc/git/
Message-ID: <mxnhqas7uhg3iq4ftxygur3555dqmnortun4dcwls554qfppg6@fq4zsubda6ay>
References: <lwjb3p4mqv6h3mewyh4b5gm4gs6omfapmbd34roexs7yujnswv@xwn6oriqdt62>
 <015f01db57ba$7c9e14f0$75da3ed0$@nexbridge.com>
 <brgripo67yq43wzti5tpsxqezwfrurt2qpaiugnxuuksjvmmab@eeugej54ncxm>
 <016801db57d7$40a7b740$c1f725c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mcn2ulxss4rhaxlz"
Content-Disposition: inline
In-Reply-To: <016801db57d7$40a7b740$c1f725c0$@nexbridge.com>


--mcn2ulxss4rhaxlz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: /etc/git/
References: <lwjb3p4mqv6h3mewyh4b5gm4gs6omfapmbd34roexs7yujnswv@xwn6oriqdt62>
 <015f01db57ba$7c9e14f0$75da3ed0$@nexbridge.com>
 <brgripo67yq43wzti5tpsxqezwfrurt2qpaiugnxuuksjvmmab@eeugej54ncxm>
 <016801db57d7$40a7b740$c1f725c0$@nexbridge.com>
MIME-Version: 1.0
In-Reply-To: <016801db57d7$40a7b740$c1f725c0$@nexbridge.com>

Hi Randall,

On Thu, Dec 26, 2024 at 03:46:29PM -0500, rsbecker@nexbridge.com wrote:
> >So, I prefer /etc/gitconfig over /etc/git/config + GIT_CONFIG_SYSTEM, bu=
t I prefer
> >/etc/git/config over both.
>=20
> One possible thing is to have your central git config, wherever you put i=
t, use [include] sections.
> These allow flexibility to pull in relevant configurations depending on t=
he qualification
> of the include. Maybe something else to think about.

I had forgotten about core.attributesFile and core.excludesFile.  I now
have /etc/gitconfig, and then everything else under /etc/git/, and have

[core]
	attributesFile =3D /etc/git/attributes
	excludesFile =3D /etc/git/ignore

This seems quite decent.


Have a lovely new year!
Alex

>=20
> An enhancement like this is high impact and would touch a fair amount of =
code. It is not
> Just for --system, but --global and --local also. The semantic of specify=
ing and resolving=20
> Configurations and attributes (inherited in repositories) are significant.
>=20
> --Randall
>=20
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--mcn2ulxss4rhaxlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmd0XDYACgkQnowa+77/
2zLtpw//RA0ZaNbzT6uMVE+YOaHkEQMIf3wXBuFcZcHz+pTdYQpqL93IkQdyZqZ0
QDuVpNc9Ew/OQf5KaOh2E0y92QdxRtqd753vSvtn3ncZAv+Z4l3Yp2YGJ3nxPBbJ
Qm5Grdyh81P5ZDy7jvYMZJ9ZeC2K8ig9ZAjHLQXLqsoh+D+oFvFiPl9yC63/REW9
rjAQa/UVPqPggtl8U+J3QGFKgwKpv5CxeTY0W0GZiCVlEWFzV+1KLG7ryH6mwpVp
2A91r5IiCnr0pnDNfY1gBPfFbW76gmuvT+cLXcvViTDtoSt4kI81AX3p/rDkYi53
KZFeBImrf6XL+TgF+euchoJG9qjB0FtaqF17hBV7U/CZaLKDueqQ6BiEbvtAOALE
qpZmBSSfEK6gky/QOFvi2mdaGiClZuOk0+hPxmwjc1U6aERqEchlR5S/MJ89L8Q+
gv51cCHNXGUi7bGAl0c1O1PRjTjdewaegBOkQ5yDxyGjYR61POq6j8HwF9MW2Bfk
m6yN5qdLal0vKdfJemlw7szrYyi+ia0Zt8g+p0ErHuG6w9iLaJ/sDIVYzsEbbSDR
i4wA9SKrwqnWWar7TYS7dzuF4VUW+6epqlb6AYlim/gcAdAzb8vxSdJG+H7Gt5+r
7/kM97s1uSR1FOys/jU8+ei9Bk1nhxiXuVOncPQ1J1ryBGKZ6qE=
=xiPs
-----END PGP SIGNATURE-----

--mcn2ulxss4rhaxlz--
