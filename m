Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6841171C
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735352775; cv=none; b=plYUvjzoFO4GCUjRXGnkhSxqaTsLSIEO17f/0wAWWooqGQRKQdRIX2OkemgDoDvQcmdJZ82IykJzp5xDnFjKHFDfNYsZXh6m4R2XtiTLcsUC6tC3/WwUftmMUGxveg7DH630THbUJynFMevODjWpjfBC7W+c2cxT0LdlI1ia3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735352775; c=relaxed/simple;
	bh=wC2MI4tmt/iSo3NP14sfJgESWMf8BrOkxEsnstQjejE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZ5RZzZKsPfmr1mixgJuiqhrSQlcfqTRWQXRNa+Ee0tjTvPR1UcyUqLT5FhKvvmDwie4lS6reOLCzvXKXCdwrujWGDtNOi3PQ6lrtaJA4hsawetaG8quiqx7FUVf622qhrQd0IoX+36ZbYSLK5hTaH9vU32omQ11oxxb1sTwmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TvC3fUJf; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TvC3fUJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1735352771; x=1735611971;
	bh=6+KWhYCyyVW1siBEE1F6IbI8hT9O7TYq1qLQpIAakZM=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TvC3fUJfWgm1m3Pr4iL7+a1WvITrfIthbJPAP7E1X37Pwtb+Pukc48aJyoQEJJhjW
	 dgDIkKr4HkpkQQPrfJJXgRlq0XfvX38mxxJ8eut2wqvN3g83uI4NmLHpPf5sAXrc3B
	 NfUVeYLHoSn8ORYtjFTK4FWHbM0T2Xk9Dvk59F8vRBesspuzfTiNFfvh+TWlanlsIj
	 S2mnTqfhIsqLBOcWCyI4Ux6xBGDe8zyjMklb1LQI/zgE9R4oYvrsAkLrisE0a2KAfU
	 cjx7KA+pTMHAJTNJMRGON2Rf1vg7BYo6KwHerx9N9gPm/m0IPlN9tfWHVAg+u9+6z5
	 ANeY5n6SshbTw==
Date: Sat, 28 Dec 2024 02:26:07 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [help] can nobody get me an email
Message-ID: <WowjCFyxf88-vm7_kQgAegfZFn-OSe2K4-eel3ZeVaWViWrjO7V1hC__TNOHWWZeUnVkkzRKfNHaMsGeF4IBVRlo2g18S51vIoSoNBqEB80=@proton.me>
In-Reply-To: <qetDcle2uCEeW-HVPrm9v-8uK6TrjIo6HJ--Mhg9852mWg3bv_w2J19eLHJMZZnQ_Km63OfxglVYwQPdLD8dtKBxF2wPG4VT87ckIf31uTo=@proton.me>
References:
	=?us-ascii?Q?<4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j=5FnBtiatlTpqp5xfTXnz-kX0Jw=3D@proton.me>_<hzyhvw4pe42yqbuqdbgl5bgnxz2kd5mxxh6jnklnqwvembueqv@b6oaetnegprl>_<s44De1e7kjF5OIY=5FYVaSJ0DdAavD-4WeZ3XrrA7XJLJO67ShZWLM9Sb1ywSUq58wmCWOTkRfhBBOvw1qCpiiUyygy53wFTetUECruyO1SEw=3D@proton.me>_<TpuMiCTLZ7JDXxJPgVNqcYXWFavK4asar9Gk9uJiiYp1nbqmKlP22mX6xiDOKHKr5yaN7ZH7jXoISqIY67wmbFfz8i8MsYokeomQu=5F6Ytis=3D@proton.me>_<ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF=5FI6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=3D@proton.me>_<20241227-positive-cyber-guan-b3891e@lemur>_<ZdbN-WEAvzrUFGmH6BlSKp8gAbRpXe8afMWdR3cD5eR8mlYzxp4ICi0kuSlptzYjj0qMMpz1zgbtgM1GHSLGWq8ciWR0jxnvONPmx3F647o=3D@proton.me>_<01fd01db58cb$a85b1b30$f9115190$@nexbridge.com>_<XiNSbr-K=5FfEBDY9HZcGbCBHp7-BmN1r0cVMKu1dimssvL4hua=5FmVAA4nfjUxGuY25dnDNu0nFntAvR83D6zH=5FRx8luim4VNGRDuxiP2cnn8=3D@proton.me>_<qetDcle2uCEeW-HVPrm9v-8uK6TrjIo6HJ--Mhg9852mWg3bv=5Fw2J19eLHJMZZnQ=5FKm?=
 =?us-ascii?Q?63OfxglVYwQPdLD8dtKBxF2wPG4VT87ckIf31uTo=3D@proton.me>?=
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 76d01471289bce1963a03a46a70410d4029815bf
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------b45fa527592f18016a9f0adbce965eb1e4e1af6b4bdd182fe3130c286827bf0a"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------b45fa527592f18016a9f0adbce965eb1e4e1af6b4bdd182fe3130c286827bf0a
Content-Type: multipart/mixed; boundary=-------------------29a8e3ad3f689e880c3b6faeb2159d04

---------------------29a8e3ad3f689e880c3b6faeb2159d04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

=0A=0A>  >  You can also subscribe with a nomail post only option, see the =
instructions in the ML greeting email.=0A=0Aand:=0A=0ASubscribers can retr=
ieve message number N from the list's archive by=0Asending a message to <g=
it+get-N@vger.kernel.org> (change the N to the=0Anumber of the desired mes=
sage).=0A=0Asince my new acct is digest how would I pull this thread and s=
ay hi to continue from another dev work Gmail
---------------------29a8e3ad3f689e880c3b6faeb2159d04
Content-Transfer-Encoding: base64
Content-Type: application/pgp-keys; filename="=?UTF-8?B?cHVibGlja2V5IC0gQV9
 idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="; name="=?UTF-8?B?cHVi
 bGlja2V5IC0gQV9idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="
Content-Disposition: attachment; filename="=?UTF-8?B?cHVibGlja2V5IC0gQV9idW
 dodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="; name="=?UTF-8?B?cHVibGl
 ja2V5IC0gQV9idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDI
 uOC4wCkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWnUwWDF4WUpLd1lCQkFIY
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
---------------------29a8e3ad3f689e880c3b6faeb2159d04--
--------b45fa527592f18016a9f0adbce965eb1e4e1af6b4bdd182fe3130c286827bf0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmdvYb8JkKkWZTlQrvKZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmd38jMueETZGDiTw0i8OTfSFiEEZlQIBcAycZ2l
O9z2qRZlOVCu8pkAAJhWAP9FdFWgzEjNpgzlJjsgDRLdknqBfv9ZuUJJdat4
RSAxHgEA5YZKKxbjaPq/nBQtoFYIm1xBuB9oAgsp277gIaCh7gI=
=KJZV
-----END PGP SIGNATURE-----


--------b45fa527592f18016a9f0adbce965eb1e4e1af6b4bdd182fe3130c286827bf0a--

