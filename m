Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E661DD0D4
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757779875; cv=none; b=ctQ3oT86MTENgJmGx9vifbHWpEdpL++FNtJ4d43cIi+FOvDe4LFU4RPl0GWCmMT1lbBXHaMqI9gZnFflSQco2+uwZf1EeJ1ydJxJ0vhoXPDYMkedvGJjYDspoY1EaLX4GzxX2KSs1PGMeVKejnyYc1oI7QlvGpWOp9r5oeiPnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757779875; c=relaxed/simple;
	bh=Ic3+BrtA1uPjlp/y0bTPDuBjLbpPVJLX+HGUtAZrvVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOymovzJE8af24EnTL6QV69DFRS5/F8ArzHigFTdJIwD4NRCXi0qQWZ+/ujNpDRE6Ii68Wfel1KzxXKNBWDtvtglu16gEtzm/TpHU+pnOIj2RacK4vPnCdeSTjDyHaoOo2EqfciY4tx2obG3g7lJgTY2uxGNRwDrzaMHK+fRRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qJJtghBQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qJJtghBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757779870;
	bh=Ic3+BrtA1uPjlp/y0bTPDuBjLbpPVJLX+HGUtAZrvVM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qJJtghBQaWR6Xdhr0I2z9ie5n2Cqh+vS7Mt7kTxqd0dNjrgGUEZ9IlP9KBp1C0RRy
	 48aZPXLyoENjZJHyCMJFBBaplGTCkkBELHoKCfy2jDLnxjd1ePaA3u3dop9uyPPx2q
	 hi0W8vWvQv6FYodQVuAtBb2eMKFO3zuHkJHKsKiQU2IPaGj/lM/GX13gC/7v7arz9E
	 y8byb1aLXrf9KA0I4kOHbUJDdqBEX0a18xQXhpCJcVdw7Gh0bp0ZThF8uJxPF1ecX9
	 wPzY6WG2T0ljlxr8V82dpV0rpPsBLbAvr7bYX8IC1ivGHlzzWAx1gKMJO2oRPLkn9H
	 flYuPqClHqFaw4/oHJ3Vfo5BXWjeYOIzzaih7t+35pqcndY22TMSIBOlohCH3yVMpa
	 nx1Ddcr1MJyuuMnqGDPAlL3hyCYJuq1oDlHThTYtKvTIPtIQwtm/PEuS1/UCjb8gYC
	 HVlaN09Sj5oNNzJqNNnl8FVrvakinB+VlzvoVadl8re9VRAk5qM
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:15f2:efe9:8d23:8468])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EAE3820105;
	Sat, 13 Sep 2025 16:11:10 +0000 (UTC)
Date: Sat, 13 Sep 2025 16:11:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sandra Malla <sandrammalla@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Error en =?utf-8?Q?instalaci=C3=B3n?=
Message-ID: <aMWXnTWzVimEjUp8@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sandra Malla <sandrammalla@gmail.com>, git@vger.kernel.org
References: <CAFBn-2MdP=jw3mmF9G3t4hC9PnK=DxBiBzPV1smVmaFLU6FjDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e6ynt/MdvCNrZC61"
Content-Disposition: inline
In-Reply-To: <CAFBn-2MdP=jw3mmF9G3t4hC9PnK=DxBiBzPV1smVmaFLU6FjDA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--e6ynt/MdvCNrZC61
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-13 at 15:47:20, Sandra Malla wrote:
> Estimados: Segu=C3=AD los pasos de instalaci=C3=B3n de la p=C3=A1gina ofi=
cial pero
> cuando quiero verificar la instalaci=C3=B3n de git me responde lo que cop=
i=C3=A9
> y pegu=C3=A9 abajo (aunque antes hab=C3=ADa dicho que la instalaci=C3=B3n=
 hab=C3=ADa sido
> exitosa). Abajo est=C3=A1 todo lo realizado. =C2=BFPor qu=C3=A9 no recono=
ce la
> instalaci=C3=B3n? =C2=BFC=C3=B3mo lo soluciono?

[en:]

For the rest of the list, I'll translate this into English, which is the
usual language of the list:

I followed the installation steps of the official page but when I wanted
to verify the installation of Git it responded to me what I copied and
pasted below (although previously it had said that the installation was
successful).  Below is everything done.  Why was the installation not
recognized?  How do I solve this?

> C:\Users\Sandra>winget install --id Git.Git -e --source winget
> Encontrado Git [Git.Git] Versi=C3=B3n 2.51.0
> El propietario de esta aplicaci=C3=B3n le concede una licencia.
> Microsoft no es responsable, ni tampoco concede ninguna licencia de
> paquetes de terceros.
> Descargando https://github.com/git-for-windows/git/releases/download/v2.5=
1.0.windows.1/Git-2.51.0-64-bit.exe
>   =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88  61.7 MB / 61.7 MB
> El hash del instalador se verific=C3=B3 correctamente
> Iniciando instalaci=C3=B3n de paquete...
> El instalador solicitar=C3=A1 que se ejecute como administrador. Espere u=
na
> indicaci=C3=B3n.
> Instalado correctamente
>=20
> C:\Users\Sandra>git --version
> "git" no se reconoce como un comando interno o externo,
> programa o archivo por lotes ejecutable.

Sometimes it's necessary to restart your terminal because the
installation has changed the PATH environment variable which is used to
find programs.  When you restart the terminal, it will read the
environment variables again and Git will be able to be found in PATH.

I don't use Windows, but hopefully this works for you.

[es:]

De vez en cuando es necesario reiniciar su terminal porque la
instalaci=C3=B3n ha cambiado la variable ambiental PATH que se usa para
hallar programas.  Cuando reinicie la terminal, leer=C3=A1 las variables
ambientales de nuevo y Git se podr=C3=A1 encontrar en PATH.

No uso Windows pero espero que eso funcione para usted.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--e6ynt/MdvCNrZC61
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMWXnAAKCRB8DEliiIei
gZ2zAQDI/3TZIEJzPGX9+LT+hVUXplvZaT7JagdaoPi18M5UZAEA0JdWVYtC6YzT
j0ZpCQkJqsqiym8jyzGJsIycYGfoHwo=
=wuj6
-----END PGP SIGNATURE-----

--e6ynt/MdvCNrZC61--
