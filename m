Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C72629D
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769997761; cv=none; b=nFZLYMCFNNO+y/S+MKCfpQu9/PvbnRo9yXaQfpGzTWUTLKOESq1CXPnl/V9BlMAPWfpkhF/Iq1kEjn4q2K3olsAqaLxoNJd5QK3kVBKlzU0qfGnlpC9YyrN9r/C5Bg7X2/s9iHwP35kzmq4QokPQh2R4sBwsepV1swXvXYnSH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769997761; c=relaxed/simple;
	bh=HgKoPbUqRFVme36AAB/t3GX9k0cFqlhsQBfqdZ5qyUE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zjbagvk9Df3/sy7bpC4edTbcBLELpcgrPEOXcD7P681fLY1mmRx1JJXhZ/Nv6wpge17KAW7Jg8a7WYp4RoKsD2d987meh4LX1HoqA4KvwIHtZEzdlpeS5dT9B6im8Ct6LHYNhbFVHwU8GkCJAmZ3mDHEXifc6SrKAKBu9JP6jRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=EnqjQ9e7; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EnqjQ9e7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1769997751; x=1770256951;
	bh=RFIyLtHiwJfjKbk/05ZCUOcAZnbs8QkWZMWhbHnYslE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EnqjQ9e7KCdR53ui9hKdWPDmP6Zsane82ApkUi7cZv/k72T0Dox7IioY5bl4dubCr
	 bXdNeRMsh6DJKk2DaR3Rq/4SMQLDo6NbYfW+TUPyAYklu+1xJHlDE5bTal8Jwt5Jzr
	 lCNCD7ZG9ShPb2PdWaJaJNN6sWB5DCDKJLZKkKZTOs6Ys0VQyx4sSdeAeRwffql/vY
	 RvcrIGzoB/7SEQXepffE6EMCdQEqvQ4BcLmbwAfI3p1Dc0s3vtwusRFsB+9xIzMuRN
	 Iwl1W+mpj0TTgiqCu6n98Uc38zxlWxPSUd5kggZt45f/X2syEcrRGF07nAAWz0/xcz
	 74W1u0n5Ce50Q==
Date: Mon, 02 Feb 2026 02:02:25 +0000
To: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
From: Seth McDonald <sethmcmail@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] blame: fix coloring for repeated suspects
Message-ID: <aYAFqZRz9EyI7jUQ@McDaDebianPC>
In-Reply-To: <28ac1ee6-f3e9-4789-92b7-903788430697@web.de>
References: <aX8BjoOGPIytGXjD@McDaDebianPC> <28ac1ee6-f3e9-4789-92b7-903788430697@web.de>
Feedback-ID: 171233811:user:proton
X-Pm-Message-ID: 1842783ceda4bc9300e61a04d09408e43df22ccb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------4b923b5be035e4511528ead7554294be8fa26980129d44f0a6eb4a4c23dd4c25"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------4b923b5be035e4511528ead7554294be8fa26980129d44f0a6eb4a4c23dd4c25
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Date: Mon, 2 Feb 2026 12:02:17 +1000
From: Seth McDonald <sethmcmail@pm.me>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] blame: fix coloring for repeated suspects
Message-ID: <aYAFqZRz9EyI7jUQ@McDaDebianPC>
Mail-Followup-To: Seth McDonald <sethmcmail@pm.me>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <aX8BjoOGPIytGXjD@McDaDebianPC>
 <oxHIt9sutsv9nQ3cyVxMUJnrv0xyp-0wKiT04eX-qLPDwmxdoOH3zNdoe0XTZ2uxCGn2N7mAfGPJI_SAiddKVA==@protonmail.internalid>
 <28ac1ee6-f3e9-4789-92b7-903788430697@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <28ac1ee6-f3e9-4789-92b7-903788430697@web.de>
User-Agent: Mutt/2.2.13 (2024-03-09)

SGkgUmVuw6ksDQoNCk9uIFN1biwgMDEgRmViIDIwMjYgYXQgMTI6NDc6NTMgKzAxMDAsIFJlbsOp
IFNjaGFyZmUgd3JvdGU6DQpbLi4uXQ0KPiAgYnVpbHRpbi9ibGFtZS5jICAgICAgICAgfCAxMyAr
KysrKysrKystLS0tDQo+ICB0L3Q4MDEyLWJsYW1lLWNvbG9ycy5zaCB8IDE0ICsrKysrKysrKysr
KysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQoNCkkndmUgY29tcGlsZWQgZ2l0KDEpIHdpdGggeW91ciBwYXRjaCBhbmQgaXQgc2VlbXMgdG8g
Zml4IHRoZSBpc3N1ZS4NClRoYW5rcyBmb3IgdGhlIGZhc3QgcmVzcG9uc2UhDQoNCi0tIA0KVGFr
ZSBjYXJlLA0KCVNldGggTWNEb25hbGQuDQoNCk9uLWxpc3Q6ICAyMzM2IEU4RDIgRkVCMSA1MzAw
IDY5MkMgIDYyQTkgNTgzOSA2QUQ4IDkyNDMgRDM2OQ0KT2ZmLWxpc3Q6IDgyQjkgNjIwRSA1M0Qw
IEExQUUgMkQ2OSAgNjExMSBDMjY3IEIwMDIgMEE5MCAwMjg5DQo=
--------4b923b5be035e4511528ead7554294be8fa26980129d44f0a6eb4a4c23dd4c25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmmABbAJkFg5atiSQ9NpNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmef8cM7CwcTARJxMhoHNU3lFiEEIzbo0v6xUwBp
LGKpWDlq2JJD02kAAGUVAQDBWhai5ex/SfBEtypdk32LSBN6HBl8K1Z8E/b7
BnhCZwEA5wROCNwImt6NDmgvcbktHXlBndKRYp5//cy7jVcEZgs=
=G+o4
-----END PGP SIGNATURE-----


--------4b923b5be035e4511528ead7554294be8fa26980129d44f0a6eb4a4c23dd4c25--

