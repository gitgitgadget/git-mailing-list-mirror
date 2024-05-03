Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8012E646
	for <git@vger.kernel.org>; Fri,  3 May 2024 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714766735; cv=none; b=Lb2XUotIT24SIn/ttyA+y3Wj4NLH6lNpWb2Vs1S+gnIOkK7g/8rfQzu87O6AxMqUirWehLVJxgQ5StvDrCtqM2B2kxeMzH6cW+U+8uEQY1VKMMVJlk7udnyovZ3WQfRpWuODnSmKL6Y+zzejnOTn/sap4A3TEdRjjUmYS58ZShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714766735; c=relaxed/simple;
	bh=eGRG9JkVO4aw68NzPc1c+w5yO04qRGmyZEzX0Ogwc8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBXbCAMtSwwN+8BFd8WESP2PLDCLi76pxgq9f9JDIDs4XXaYdaP0kfVJKJcS5WexpLEca8gP3ltn0h2keE9o9FT3KDHUXxpSxZmAZyDDdTl6f/nW5YfUsSq5r7RLWWpsTJuEkloFQHzJtJjzhxeZYmEoqSCnj0LigZsYfCP0lMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vt0OrEEG; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vt0OrEEG"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 45B995B2E9;
	Fri,  3 May 2024 20:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1714766726;
	bh=eGRG9JkVO4aw68NzPc1c+w5yO04qRGmyZEzX0Ogwc8M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vt0OrEEG+5Y6nZGat1shKSTN8ikVF+wMSIiYCuS6rfjfnPyUOZSs4V0x9/qOCN662
	 lXJZICQ79e1ySEHpLvx4krFD/vVpAGHwvvTM5u2Ltb44Ecmq6teaE93Azfpb7qsg5d
	 lrlTnGJtnzyVq8iFILbTzx1KwnRTq4NQWXugUuZKtmflRTe3Mkw9LPUG1yLp3g4qNP
	 tF4jTcMOurGzMO3hFqB49+hV7uAg/8buCAOP7lBjumuTlhvYXuW626rJJB21B244/x
	 C9XB4ceHZ1HGSewNtvRdaMvovLaVoksGSbLHxNu0f2dJ1nq/TT5sEU3FCkSq73SseV
	 ozMtm5hfJRPkgpkVNarnQzSAIdOGSk4+HhI5dQ4DfYv2wxVFtz8pTVlnH8WC1TuFcp
	 r5rE3qib0hQJ3MZGm0gEqh9XhvUHeKh8noPKr3pGzWCP2YD9GsQIgk2Vsg/WH/WCrw
	 p65Evl8SxOfQUQjKa7Jwg14UkBmjdoFfPt7Rn/KC2IQpX0AcOmM
Date: Fri, 3 May 2024 20:05:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?Q?L=C3=A9onard?= Michelet <leonard@lebasic.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Spelling mistake in git-gui in french
Message-ID: <ZjVDhAvfrR8d_Hok@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?Q?L=C3=A9onard?= Michelet <leonard@lebasic.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <PR1P264MB1728F9D69ECF4026725143B5B91F2@PR1P264MB1728.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D+39K51VeyWXFHrW"
Content-Disposition: inline
In-Reply-To: <PR1P264MB1728F9D69ECF4026725143B5B91F2@PR1P264MB1728.FRAP264.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.12 (2023-09-09)


--D+39K51VeyWXFHrW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-03 at 16:19:14, L=C3=A9onard Michelet wrote:
> Hello I've noticed a spelling mistake in git-gui in french.
> Details below in french.
>=20
> Autres remarques :
> il y a une faute d'orthographe dans un message de git-gui.
> Dans le fichier source git-gui/po/fr.po, il y a la phrase 'Fichier binair=
e (pas d'apper=C3=A7u du contenu).'
> Aper=C3=A7u s'=C3=A9crit avec un seul 'p'

Thanks for the report.  I can confirm that this is indeed a typo.  I'll
send a patch shortly to address it.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--D+39K51VeyWXFHrW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZjVDhAAKCRB8DEliiIei
gSIsAQCqpdJ4dFe2gmOGUm0EetDPy19qFMypOWwH07GrrpIRDwEAp8EQWt9lWFmE
zi+kPE8qEVQVyEHuwfapEGJUKdc43A4=
=1ZMM
-----END PGP SIGNATURE-----

--D+39K51VeyWXFHrW--
