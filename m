Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD2F386541
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930596; cv=none; b=MeQKK2lRM7AhAtGy+ahnTeYPg7yICDy2WF1QY1sBe/ia+X0Y7WmdgN+CWOxAjBCEQDBUeez1ZMcxyfCgBI88KCbq/mXUqxq308tOjaRzVVLp++4VB8UPxlFQxO1puUtfzNPGlvpEV91R5RCp23viOnFv5wbKqwpaGW8vMgdXp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930596; c=relaxed/simple;
	bh=LO6EDhpVLmY8MQqutEwRieeIBZH7zTomCAXTQRndgQ4=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=BvNTXGQTMCGGOdip/2EvS7uep62sJom6/VP1PxzIEyu0+k7U6/u4xYymUjg2wTj1OWNf8PPKOdVryR/AB20WE1KZD/dYYj9a4UvRtyDNPS0p9+n6BxmvarXIpxeXoiz4IQt4pq7BfI1fG3FDthzLxSR9GaGtsEbci2HE5nX78DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=brozkeff.net; spf=pass smtp.mailfrom=brozkeff.net; dkim=pass (2048-bit key) header.d=brozkeff.net header.i=@brozkeff.net header.b=jOaDxbC4; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=brozkeff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brozkeff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brozkeff.net header.i=@brozkeff.net header.b="jOaDxbC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brozkeff.net;
	s=protonmail; t=1782930575; x=1783189775;
	bh=LO6EDhpVLmY8MQqutEwRieeIBZH7zTomCAXTQRndgQ4=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jOaDxbC4BGH61QRgY9eo+zEGNeAivj+lxVc/qbmMaQ2CjyJy3uRyzpEQflTCdAfXd
	 sJJ0D3wRpnMoW7RDqLdTUvQGmWOGB11b5mQV9Dhf6V3oGEz/XuFWqtixMh3edEzSw1
	 d9MUu/BvUtCfBKLxIhXUf2tQJGr7P1+rv6Emd4NojREHJ65yS7aqL+JS6t8thJh0gQ
	 Lp5avfSepHskaHs49RQ8Og2eWS3yBAItdjexSw8VFgLKETtOc1miW3rWxn0ZaFhIvl
	 Z5ifyQ/2+B1/n/hw7lGZumcwHooP9Bg+nw2NTAHgDr/LTWZmjstJ0+j0HqddRCwqbf
	 A+glnDztjy7FQ==
Date: Wed, 01 Jul 2026 18:29:34 +0000
To: git@vger.kernel.org
From: Martin Malec <martin@brozkeff.net>
Subject: Bug report (2.55.0.windows.1): git gui: "configuration error" when home directory contains non-ASCII characters on Windows
Message-ID: <d715b56a-2c39-4634-b304-c003df2e8c43@brozkeff.net>
Feedback-ID: 4758433:user:proton
X-Pm-Message-ID: 64c0ffc243451a84db8816fd8e92baa2baad222c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------018c3bc4252eafa84f03efe1dcf6c09aa8fe5aad252560cd22d831f89c6d3c84"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------018c3bc4252eafa84f03efe1dcf6c09aa8fe5aad252560cd22d831f89c6d3c84
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-ID: <d715b56a-2c39-4634-b304-c003df2e8c43@brozkeff.net>
Date: Wed, 1 Jul 2026 20:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: cs, cs-CZ, en-GB, en-US
To: git@vger.kernel.org
From: Martin Malec <martin@brozkeff.net>
Subject: Bug report (2.55.0.windows.1): git gui: "configuration error" when
 home directory contains non-ASCII characters on Windows

V2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkP8KgIEluc3RhbGwgbGF0ZXN0
IGdpdCAyLjU1LjAgDQpvbiBXaW4xMSAyNUgyIFBybyBDemVjaCwgdHJ5IHN0YXJ0aW5nIEdpdCBH
dWkgdmlhIFN0YXJ0IE1lbnUuIFVzZXIgDQpsb2dnZWQgaW4gdmlhIEVudHJhIElEIChBenVyZUFE
KSB3aGljaCBjcmVhdGVzIGF1dG9tYXRpY2FsbHkgaG9tZSANCmRpcmVjdG9yeSBpbiBDOlxVc2Vy
c1wgY29udGFpbmluZyBub24tYXNjaWkgZGlhY3JpdGljYWwgbWFya3MgKGhlcmUgDQpgw71gIC0g
YWNjZW50ZWQgYHlgIGluIEN6ZWNoIGxhbmd1YWdlKQ0KDQpXaGF0IGRpZCB5b3UgZXhwZWN0IHRv
IGhhcHBlbj8gR2l0IEdVSSBvcGVucyBmaW5lDQoNCldoYXQgaGFwcGVuZWQgaW5zdGVhZD8gRGlh
bG9nIGJveCB3aXRoIGVycm9yIGFuZCB0b2Z1IGNoYXJhY3RlcnMgDQppbnN0ZWFkIG9mIHJlYWwg
dW5pY29kZSBjaGFyYWN0ZXJzOiBUaGUgZGVmaW5lZCBzaGVsbCANCignQzovVXNlcnMvUGV0cmFL
QTEvMm92QcKhL0FwcERhdGEvTG9jYWwvUHJvZ3JhbXMvR2l0L3Vzci9iaW4vc2guZXhlJykgDQpp
cyBub3QgdXNhYmxlLCBpdCBtdXN0IGJlIGFuIGFic29sdXRlIHBhdGggdG8gYW4gZXhlY3V0YWJs
ZS4pDQoNCmdpdC1ndWkgZmFpbHMgdG8gc3RhcnQgd2l0aCAiVGhlIGRlZmluZWQgc2hlbGwgKCcu
Li4nKSBpcyBub3QgDQp1c2FibGUsIGl0IG11c3QgYmUgYW4gYWJzb2x1dGUgcGF0aCB0byBhbiBl
eGVjdXRhYmxlLiIgd2hlbiB0aGUgDQp1c2VyJ3MgaG9tZSBkaXJlY3RvcnkgcGF0aCBjb250YWlu
cyBub24tQVNDSUkgY2hhcmFjdGVycyAoZS5nLiwgDQphY2NlbnRlZCBsZXR0ZXJzIGZyb20gYW4g
RW50cmFJRCBwcm9maWxlKS4NCg0KU3RlcHMgdG8gUmVwcm9kdWNlOg0KMS4gSGF2ZSBhIFdpbmRv
d3MgdXNlciBwcm9maWxlIHdpdGggbm9uLUFTQ0lJIGNoYXJhY3RlcnMgaW4gdGhlIHVzZXJuYW1l
DQoyLiBJbnN0YWxsIEdpdCBmb3IgV2luZG93cyAocGVyLXVzZXIgb3Igc3lzdGVtLXdpZGUgdW5k
ZXIgYSBwYXRoIA0KY29udGFpbmluZyBub24tQVNDSUkgY2hhcnMpDQozLiBSdW4gYGdpdCBndWlg
DQo0LiBPYnNlcnZlIHRoZSBlcnJvciBkaWFsb2cNCg0KUm9vdCBDYXVzZSBhcyBmb3VuZCBieSBP
cGVuQ29kZSB1c2luZyBCaWcgUGlja2xlIEFJIG1vZGVsOiBJbiANCmBnaXQtZ3VpLnRjbGAgbGlu
ZSA0MDMsIGBzYWZlX2V4ZWMgW2xpc3QgY3lncGF0aCAtbSAkX3NoZWxscGF0aF1gIA0KY2FwdHVy
ZXMgY3lncGF0aCdzIG91dHB1dCB1c2luZyBUY2wncyBkZWZhdWx0IHN5c3RlbSBlbmNvZGluZyAo
QU5TSSANCmNvZGUgcGFnZSksIGJ1dCBjeWdwYXRoIG91dHB1dHMgaW4gVVRGLTguIFdoZW4gdGhl
IHBhdGggY29udGFpbnMgDQpub24tQVNDSUkgY2hhcmFjdGVycywgdGhlIGVuY29kaW5nIG1pc21h
dGNoIHByb2R1Y2VzIGEgY29ycnVwdGVkIA0KcGF0aCB0aGF0IGZhaWxzIHZhbGlkYXRpb24uIFN1
Z2dlc3RlZCBGaXggYWNjb3JkaW5nIHRvIEJpZyBQaWNrbGUsIEkgDQphcHByb3ZlZCB0aGUgYWdl
bnQgdG8gcGVyZm9ybSB0aGUgZml4IGFuZCBpdCB3b3JrZWQsIHRoZW4gR2l0IEdVSSANCmNvdWxk
IGJlIHJ1biBmaW5lOiBSZXBsYWNlIHRoZSBgc2FmZV9leGVjYCBjYWxsIHdpdGggYSBwaXBlIG9w
ZW5lZCANCnRocm91Z2ggYHNhZmVfb3Blbl9jb21tYW5kYCBhbmQgZXhwbGljaXRseSBzZXQgYC1l
bmNvZGluZyB1dGYtOGAgb24gDQp0aGUgY2hhbm5lbCwgbWF0Y2hpbmcgdGhlIHBhdHRlcm4gdXNl
ZCBpbiBgZ2l0X3JlZGlyYCBhbmQgDQpgX3BhcnNlX2NvbmZpZ2AuDQoNCmBgYHRjbA0KaWYge1tp
c19XaW5kb3dzXX0gew0KIMKgIMKgIHNldCBjbWRwIFttYWtlX2FyZ2xpc3Rfc2FmZSBbbGlzdCBj
eWdwYXRoIC1tICRfc2hlbGxwYXRoXV0NCiDCoCDCoCBzZXQgZmQgW29wZW4gW2NvbmNhdCBbbGlz
dCB8IF0gJGNtZHBdIHJdDQogwqAgwqAgZmNvbmZpZ3VyZSAkZmQgLWVuY29kaW5nIHV0Zi04DQog
wqAgwqAgc2V0IF9zaGVsbHBhdGggW3N0cmluZyB0cmltcmlnaHQgW3JlYWQgJGZkXSAiXG5cciJd
DQogwqAgwqAgY2xvc2UgJGZkDQp9DQoNCltTeXN0ZW0gSW5mb10NCmdpdCB2ZXJzaW9uOg0KZ2l0
IHZlcnNpb24gMi41NS4wLndpbmRvd3MuMQ0KY3B1OiB4ODZfNjQNCmJ1aWx0IGZyb20gY29tbWl0
OiBiZjVhZmRlY2MxMDQ3ODM5N2Q3MDU5ZDA3NTczNjMwOTAyZmIyZTJmDQpzaXplb2YtbG9uZzog
NA0Kc2l6ZW9mLXNpemVfdDogOA0Kc2hlbGwtcGF0aDogRDovZ2l0LXNkay02NC1idWlsZC1pbnN0
YWxsZXJzL3Vzci9iaW4vc2gNCnJ1c3Q6IGRpc2FibGVkDQpmZWF0dXJlOiBmc21vbml0b3ItLWRh
ZW1vbg0KZ2V0dGV4dDogZW5hYmxlZA0KbGliY3VybDogOC4yMS4wDQpPcGVuU1NMOiBPcGVuU1NM
IDMuNS43IDkgSnVuIDIwMjYNCnpsaWI6IDEuMy4yDQpTSEEtMTogU0hBMV9EQw0KU0hBLTI1Njog
U0hBMjU2X0JMSw0KZGVmYXVsdC1yZWYtZm9ybWF0OiBmaWxlcw0KZGVmYXVsdC1oYXNoOiBzaGEx
DQp1bmFtZTogV2luZG93cyAxMC4wIDI2MjAwDQpjb21waWxlciBpbmZvOiBnbnVjOiAxNi4xDQps
aWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZhaWxhYmxlDQokU0hFTEwgKHR5cGljYWxs
eSwgaW50ZXJhY3RpdmUgc2hlbGwpOiA8dW5zZXQ+DQoNCg0KW0VuYWJsZWQgSG9va3NdDQpub3Qg
cnVuIGZyb20gYSBnaXQgcmVwb3NpdG9yeSAtIG5vIGhvb2tzIHRvIHNob3cNCg0KUmVnYXJkcw0K
DQotLSANCk1hcnRpbiBNYWxlYw0KaHR0cHM6Ly9naXRodWIuY29tL2Jyb3prZWZmLw0K
--------018c3bc4252eafa84f03efe1dcf6c09aa8fe5aad252560cd22d831f89c6d3c84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmpFXI4JED3R2vb7xMD3NRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfLMv1TPGpNzVuIrBOpRNZxFiEEfCTRz3uT3bC0
Ga0PPdHa9vvEwPcAAPdYAP9//Qu9/MTd28tHZ/jXmtb5LNIaPEqHkvT2eeFj
ObgCAwD/XOQSCwQhfQ+c3/jOjjpMTYCa8AyXOhiiXZZLPQOJsgo=
=n7rb
-----END PGP SIGNATURE-----


--------018c3bc4252eafa84f03efe1dcf6c09aa8fe5aad252560cd22d831f89c6d3c84--

