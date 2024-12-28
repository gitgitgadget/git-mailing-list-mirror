Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A843EB644
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735350847; cv=none; b=qXbSxPuVI7AH/hcJc45wyccnk3IuWcQR36Q+sqJXW0PkCphSlHehff2dIHXQsQGqxh5PaXHeHzov+tNchc0H+h0iNaJdPM1m/89QbgYwCObNMf5wvVOPXw0TqI/Po5myvde/tw2rfNCv2JE9H5XFdvSIznoopAMEJ/uPBCnDdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735350847; c=relaxed/simple;
	bh=vi24ZVxV5IZ4EA2PGK3BxQuu4+77+9FObc3T5TElv/U=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=f/rX+mmqsKdZ+KVAfniVzzE90ArU4UKn9XKNxoVUIncNXkr32YA7pNNSGtlmb1yxbdtfVWPVQ17RAu2opYUYq9/hp5vEwchdpt9vrdbDHbBI5u/EBu7OYoS9BqsLOoUp116jjxNVagAU50bDCWyeTeDE2R9C0IcFgsmgODfqdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Kt8uNvef; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Kt8uNvef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1735350842; x=1735610042;
	bh=vi24ZVxV5IZ4EA2PGK3BxQuu4+77+9FObc3T5TElv/U=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Kt8uNvefCjK3oN31ucLgXYzO4UJc34Z67DdU1w7xqTf/QS9rmXUFssOhI0r+fIXum
	 qTqxVHVHfABE36FExHjVBzkxoS19O1vI2xUk1DNZAQThZc5z3aVRmRFwuNlsC3Ammj
	 exwH5s4mtmy68uAIJ50PhdI/zDPshNjDx+gekiYQvxJOCMUhfuqZzR8JVhjpbTGhX+
	 VEc2ZZTmyUPnxstwwZNTolh7lT6xiGuMs0YhIfTgMQyJ9Mvr/+WcPLYlUWpO3RMS7r
	 jYnDgR5TLv6DB7t0nQYZrit61OzSCxL3v6VssnshnO9nUiY+TtzgPOkhd8CZrRI1rX
	 2BKzUIrghmtjQ==
Date: Sat, 28 Dec 2024 01:53:56 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Cc: "test+unsubscribe@vger.kernel.org" <test+unsubscribe@vger.kernel.org>
Subject: UNSUBSCRIBE
Message-ID: <fgjwj3pOTqfKdP1Ue4s_wORJpjefdZLub3NZSXGEJo-IU4tOsg6sHJOA7FxDMI5Ovib4PcowHtc7XXj5oylfYrunH5nVwh7ZK73qCXrYF1Q=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: d0f181611a88beb72d48d5723ea57f364e596641
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------bb3ba46f8fa85988e082c583bf739900bdb2e61d153a8ed97b9accec16b53144"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------bb3ba46f8fa85988e082c583bf739900bdb2e61d153a8ed97b9accec16b53144
Content-Type: multipart/mixed; boundary=-------------------5eb906a36c45ee5a501b25feffbb88d7

---------------------5eb906a36c45ee5a501b25feffbb88d7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

UNSUBSCRIBE
---------------------5eb906a36c45ee5a501b25feffbb88d7
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
---------------------5eb906a36c45ee5a501b25feffbb88d7--
--------bb3ba46f8fa85988e082c583bf739900bdb2e61d153a8ed97b9accec16b53144
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmdvWjMJkKkWZTlQrvKZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmd1bc9xS2iZhFz6gtCAQw7rFiEEZlQIBcAycZ2l
O9z2qRZlOVCu8pkAABnhAQD+9V/ZKb3GqTVpTiD/t7/A3OO4PQMxPWaKDsF4
KdNI4wEAxGuAcJ+6a4USU+XxO9gqRRhJwiEgoImL1SlPrsN5bgo=
=Doax
-----END PGP SIGNATURE-----


--------bb3ba46f8fa85988e082c583bf739900bdb2e61d153a8ed97b9accec16b53144--

