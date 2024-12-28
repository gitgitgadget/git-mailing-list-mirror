Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F193770E2
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735350601; cv=none; b=dt+YZu5D9y9Z2QngeF2TaOCwy1/DRCiIczI+R9F5LvFWEvnqYt25u2DFL0YkCt3kLOvg9+cji3T0Ywb1tUjhR8JPXkCzpVf09VBNwua25dTrlQPib0OoQq8ZhQzpgdGlhUuK8d/dulqCW+TdBhfbA3p8q3cgBhFcF0teJs3s09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735350601; c=relaxed/simple;
	bh=ybQjoXrdNU7k7Bs57WrIzAJNYZedO0J+M9dEfoEo92c=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=a9X6D4pAHgRxnkXr68PYxu8kYCQTEkvgCbZhVVliK9rT/GPsBC2mgaBK155/3FutD/+oBcUiu5RKWFjZVbb/zqT0ctNEktJWN1UEwTu7dizevi9wBDrF93feHkiZcYLcW15xpbw0Ohx0gy7vzcaMkKyCjQpRUMg07b1MQ3TUSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iII1gY28; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iII1gY28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2q6hxntcj5fwvduxpug5g63mqm.protonmail; t=1735350592; x=1735609792;
	bh=ybQjoXrdNU7k7Bs57WrIzAJNYZedO0J+M9dEfoEo92c=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=iII1gY287vEnji6Yqu0jNApNmSAWWzZoL0llK+z1AwD9blJTjx1T7IgGiqIiRKIXv
	 frIVGauC7PuoP0L1Tes1K23qRDeo2pNPYb50ED+6SAcl5dEKNsYC9TUNWv2jvjRFfj
	 Jw6oLMvVAhca1ZiahFgcRgAJitIigLtGqgRLJb3OZTv9XXos75Prg4FCyc8IHMF3/D
	 WCUrbhiVXkAGTsGzcBAysBqZtRrBiEdyj4xDMSjeS9TmHDvrx91qBYfy5bquXZfSyT
	 fzeWeGD84GEBAsDxyJhx6Pmehl8zerbTW8LjONaYJq31mphyy6YkA30nAfmsLXqjfr
	 HtaURIsCZciAQ==
Date: Sat, 28 Dec 2024 01:49:48 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: UNSUBSCRIBE
Message-ID: <thCuYDojPSKiZRI6YraCZDd2hWhoa637c0kUbWicSqbSqyAVS-KQEqkdj8PMfP1HqKSN00JdHI1bq4MKC46pBTUCscArPIF0ytBKb_KrZus=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 9c3142b1da61cca55a589178c6f66ae8537ccfba
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------bc2b8f62aa8cf8f1c8fb537a64cae8b25fc8acdf04ab44cd630a4ffd950c4700"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------bc2b8f62aa8cf8f1c8fb537a64cae8b25fc8acdf04ab44cd630a4ffd950c4700
Content-Type: multipart/mixed; boundary=-------------------7f5cef08fb075be3fa876a5622c82143

---------------------7f5cef08fb075be3fa876a5622c82143
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

UNSUBSCRIBE
---------------------7f5cef08fb075be3fa876a5622c82143
Content-Transfer-Encoding: base64
Content-Type: application/pgp-keys; filename="=?UTF-8?B?cHVibGlja2V5IC0gQV9
 idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="; name="=?UTF-8?B?cHVi
 bGlja2V5IC0gQV9idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="
Content-Disposition: attachment; filename="=?UTF-8?B?cHVibGlja2V5IC0gQV9idW
 dodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="; name="=?UTF-8?B?cHVibGl
 ja2V5IC0gQV9idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29
 wZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOC4wCgp4ak1FWnUwWDF4WUpLd1lCQkFIY
 VJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0h4YTh5CjArZG1ONWJOTFV
 GZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBY0hKdmRHOXUKT
 G0xbFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRV0FBSUJ
 BaGtCQXBzRApBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkV
 DY1NkdrYTlOdE12bWRvWTVrCnROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXR
 iY1NlMVErM2N4WUx4TmhqVTdteW5Rc3B2OWQKeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQ
 kFRZEFuZnAvejJGd1JrcHZVZ2Y3bXFZSTlSS25UVmFkd0dmZwphUUxobXdnM0x4TURBUWdId25
 nRUdCWUtBQ29GZ21idEY5Y0prS2tXWlRsUXJ2S1pBcHNNRmlFRVpsUUlCY0F5CmNaMmxPOXoyc
 VJabE9WQ3U4cGtBQUppOEFRQytmbk9tNFZqOVFtSDRIMEdWdDdSdU9RSyt3T1ExUFJ2cHltU2o
 KZXlCSk93RDlHWXV2eE9BVks4aUF1cEorcHB3TXIzNlZ1a0llMXBYdUhvOVJoanZlQXcwPQo9R
 lFGdwotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0t
---------------------7f5cef08fb075be3fa876a5622c82143--
--------bc2b8f62aa8cf8f1c8fb537a64cae8b25fc8acdf04ab44cd630a4ffd950c4700
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmdvWTsJkKkWZTlQrvKZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfWryou7ZoU6diD0Pys914LFiEEZlQIBcAycZ2l
O9z2qRZlOVCu8pkAAH4gAP9JCY4f2y6jKGes5PhoFbm3AVpc7bcoy1rVFUV8
W5wXowEAxqwHwP2h/xwt9q42Oqns5dR3rn5z+I32DvKvneVIEwo=
=yJMQ
-----END PGP SIGNATURE-----


--------bc2b8f62aa8cf8f1c8fb537a64cae8b25fc8acdf04ab44cd630a4ffd950c4700--

