Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289173E485
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516709; cv=none; b=AcMUQQ/Eka//QGq2ijMbpGDSrVtWkgUys509VHBlfa8G1KeC3b0ZbN5XSAjGRpBIYd/jXR6oyLkTZ/xspVNZJsmbUwCBDP+AmPCyw74kw20C+O1XuuqwzpdyikE/gO//6pcmNyDIu/IIwzrxyGlWbBbwb6QyJFDGFPXCvTETtBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516709; c=relaxed/simple;
	bh=jX7Ml22obqNMvopY6VsukKpmpRN7pnjcuHCutR90aP8=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FAsDtJ0EG6zhRMGarB6cqaHPbJo9HlzjFsXUDMRFFX0QyrWmlJsKtM2H73zNAqp3eKYkuk1WJ5rIt32lAFed+Fbxqku21vigT8p3XcSuDAyE+Kh2IzJ+7mnhh99B4PQbBZXP61O9+2gDruZI7fPa9XTdUVr+rUImgdSzNSRgT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cmpwn.com; spf=pass smtp.mailfrom=cmpwn.com; dkim=pass (2048-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b=ucgx2f8H; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cmpwn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpwn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="ucgx2f8H"
Content-Type: multipart/signed;
 boundary=ee65ca31caca9fac9517faa17794653e1966cca30ac92e31730ee19cf15a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
	t=1713516703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jX7Ml22obqNMvopY6VsukKpmpRN7pnjcuHCutR90aP8=;
	b=ucgx2f8HXrLni08tNmQKG9BF/VoWwKh+zSl8yFoSQFjfWZIJQWT0phkvjPp3GGBzCP/IMx
	MunnQqtwGEoKAUKndQ6Lk0FnbIhI38ktPczINpqoCkBa/zRs76wTWH7cPyxqa3D9K7WVHo
	t3Ga/0VmbU3N/QDJPVNMXBIzASbUymtDQT22GwwvxMYhz5rDh7EqZu16cJeN4ZyivjCaF5
	sfMP1E5bKfX8lZV1JacPK8l5K7xQRY1XsjybTqlqhL5AGXa2VEQP7+1RMFfkVf8Bi7rzTM
	HjwWf0QGN4UAF4gc/yOioVj1Bd3DUhXdcEXlMLDbaDcpMEImkUyN+pYw+gaKmw==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 10:51:38 +0200
Message-Id: <D0NYZ4A0TV6M.CF19YB1PFRSB@cmpwn.com>
Cc: <gitster@pobox.com>, <sunshine@sunshineco.com>, <code@khaugsbakk.name>,
 <phillip.wood123@gmail.com>, <ps@pks.im>
Subject: Re: [PATCH] format-patch: ensure that --rfc and -k are mutually
 exclusive
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Drew DeVault" <sir@cmpwn.com>
To: "Dragan Simic" <dsimic@manjaro.org>, <git@vger.kernel.org>
References: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org> <b4c6cbf5f3246ecd0cf27c7e87bf6dfc@manjaro.org>
In-Reply-To: <b4c6cbf5f3246ecd0cf27c7e87bf6dfc@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--ee65ca31caca9fac9517faa17794653e1966cca30ac92e31730ee19cf15a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Reviewed-by: Drew DeVault <sir@cmpwn.com>

--ee65ca31caca9fac9517faa17794653e1966cca30ac92e31730ee19cf15a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEQQCSmzPusP0duFJ5e8eUBwkAR8oFAmYiMJoACgkQe8eUBwkA
R8rYEwf8CUFXumsQeV98Oua6QX1JsU0sXEHwyhY2ba1yx1CRVTWLk+Yn6CSVYEZC
/tp3egNajuPbEf3rMJR3cMshntbi/jS2KccfJcrRlfOQmeMSJlrJewJlnj4yuBD2
tWB5iLmWKc5Xqkzy6bqL2zfjttFqtmU4/v+p8gn0zY6GzJ3vRFu8YiEG7ScEI5to
E/t0EnWrAw4gn4o/TXNQhEEsghyq5nGZ0wYTqZHWfIliNFWm3pt9NPHZmhmReEVx
NKovcj/PuiNYCIyZ1oMl9P+O/x4YlhC9ARuh7OcGatVKKlsWq3F3s0enAuhRylUY
6kGWjClNZjMHAAqxAkKRkE4NaDjUlg==
=IiQh
-----END PGP SIGNATURE-----

--ee65ca31caca9fac9517faa17794653e1966cca30ac92e31730ee19cf15a--
