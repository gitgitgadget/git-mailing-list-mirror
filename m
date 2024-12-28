Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763B1EB36
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735352538; cv=none; b=g1iL55pqAyCODqDUo69U8ksb+KSdOqDQhAln3ORrmG2Goe54y5OHSJN9X00HfKGEqFK84yf5RV2/rgrDwx4kwtRTYwkcOEmNU61tKr7ukxvP7Q2vd4R38eKt1kPk7+9Qmvt3V9jTkC0ocvSMkU80J5sA5Nna1HpvPLgKbHl7Jmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735352538; c=relaxed/simple;
	bh=1Eaf6VFmB4zByRqRtJGF4iZdY8Zw/EjtLccF+MwFq2E=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7XnovqwmMUrTGlZWK7By8pO5ieCqRywWoOdryeaFb7Vqxmy8Gk+eC8gcpYFoGi+qtXRVcs8Hrg5vZPSsgqmJRhJyFW+k+QYYfrdvNULK+pWtQsDWzgxSK63Plyy22S70/JcCVEL0XzmhZQId8rdtOmBg+gaO5UgR9AHrxjHZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=O2L7ScjS; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="O2L7ScjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1735352527; x=1735611727;
	bh=HY//6qjEaOXvSnsMtm80l8N+PNUxRrKTR6qOUlEs1Q4=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=O2L7ScjSz/fWhm8rKcfTjHPmEi+9yenjksapUWkO3uCo5UKMd7jagcr60dp97ZD8K
	 m1F4+ubUz+6wi7o+HUvW48NjIrnjvyVSWpKweGaO8LjdOEBKulUnu2hXA7+Nv60OAa
	 VS5YqKB6abK94ivnItZ1u20mXPza8yvli7phNSkvxfap7u4ggyqDtE59AreK5BXB9t
	 J7lnIKOQ2og7lbFjtK1wPvB9g9P+hrNPBapN7jZ8+dk2mIl05mFbfNU84230j0qknQ
	 pEGjrm6jQDygDFW3h+/YjKNL+Oj6HKN6RfzF+cfZln08QgPm5lNkSNrYLQ2P1ajDN1
	 i7R21DlXPppiQ==
Date: Sat, 28 Dec 2024 02:22:01 +0000
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: RE: [help] can nobody get me an email
Message-ID: <qetDcle2uCEeW-HVPrm9v-8uK6TrjIo6HJ--Mhg9852mWg3bv_w2J19eLHJMZZnQ_Km63OfxglVYwQPdLD8dtKBxF2wPG4VT87ckIf31uTo=@proton.me>
In-Reply-To: <XiNSbr-K_fEBDY9HZcGbCBHp7-BmN1r0cVMKu1dimssvL4hua_mVAA4nfjUxGuY25dnDNu0nFntAvR83D6zH_Rx8luim4VNGRDuxiP2cnn8=@proton.me>
References: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me> <hzyhvw4pe42yqbuqdbgl5bgnxz2kd5mxxh6jnklnqwvembueqv@b6oaetnegprl> <s44De1e7kjF5OIY_YVaSJ0DdAavD-4WeZ3XrrA7XJLJO67ShZWLM9Sb1ywSUq58wmCWOTkRfhBBOvw1qCpiiUyygy53wFTetUECruyO1SEw=@proton.me> <TpuMiCTLZ7JDXxJPgVNqcYXWFavK4asar9Gk9uJiiYp1nbqmKlP22mX6xiDOKHKr5yaN7ZH7jXoISqIY67wmbFfz8i8MsYokeomQu_6Ytis=@proton.me> <ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF_I6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=@proton.me> <20241227-positive-cyber-guan-b3891e@lemur> <ZdbN-WEAvzrUFGmH6BlSKp8gAbRpXe8afMWdR3cD5eR8mlYzxp4ICi0kuSlptzYjj0qMMpz1zgbtgM1GHSLGWq8ciWR0jxnvONPmx3F647o=@proton.me> <01fd01db58cb$a85b1b30$f9115190$@nexbridge.com> <XiNSbr-K_fEBDY9HZcGbCBHp7-BmN1r0cVMKu1dimssvL4hua_mVAA4nfjUxGuY25dnDNu0nFntAvR83D6zH_Rx8luim4VNGRDuxiP2cnn8=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 0446fa3c6ef79fd971a5ba125efd17e35837c1b7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------cd8cf6c9a8f7a18d6d58d772a0e88357916b91ef465b3cda4a81041292472196"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------cd8cf6c9a8f7a18d6d58d772a0e88357916b91ef465b3cda4a81041292472196
Content-Type: multipart/mixed; boundary=-------------------23eef43b6f1e8b4e4ce82b260c2b65a8

---------------------23eef43b6f1e8b4e4ce82b260c2b65a8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

=0A=0Afrom A_bughunter@proton.me=0A=0ASent from Proton Mail Android=0A=0A=0A=
-------- Original Message --------=0AOn 12/27/24 8:17 PM, A bughunter <A_b=
ughunter@proton.me> wrote:=0A=0A>  >  Unless you subscribed explicitly, no =
action is required. The emails on this account=0A>  >  Will stop. Just sub=
scribe with the account you want to use.=0A>  >  =0A>  =0A>  a meno che ho=
=0A>  =0A>  You can also subscribe with a nomail post only option, see the =
instructions in the ML greeting email.
---------------------23eef43b6f1e8b4e4ce82b260c2b65a8
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
---------------------23eef43b6f1e8b4e4ce82b260c2b65a8--
--------cd8cf6c9a8f7a18d6d58d772a0e88357916b91ef465b3cda4a81041292472196
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmdvYMgJkKkWZTlQrvKZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcp1wxKpkUUxSyFRZc9JKK+FiEEZlQIBcAycZ2l
O9z2qRZlOVCu8pkAAEzEAP46vdBy9CUBjsJFQF1hfffzObZA/+M/WGkyqqUn
UOzyswEAhvosj3HWRSue8JxeMgbA71Mo6tdrOCQN7oHA92tv8AM=
=Q5l4
-----END PGP SIGNATURE-----


--------cd8cf6c9a8f7a18d6d58d772a0e88357916b91ef465b3cda4a81041292472196--

