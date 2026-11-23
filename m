Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471994;
	b=09LaBbuRcvOZFWaFC0xhdSmrWFhLqaClUwEcp0/UxAfDnhdPHasJSNNRqGigLAXN2fVe
	 7UFQW1MxMzwhwbiLqDQ0hJTmxxushrQVOyA2Nd57H8S4TRF+Y5aRrOFvRiFUk3bdIUwzx
	 9qsr9p2c+8gu2RGYoQhi9iOJfdRgzHCPRHg2QsVocT7msdal6YSy1bGLt8iCcuOn2Gnl/
	 fv4+Ghc2sVzhDIPf3HjQdvdZ/pLn1Tf+JybUCRw7gt32YcDzr+pu3f5aeyLuTNQUFtsvL
	 FzjsbIIo37bat38+QOdMtZHrXlaI0W+NlzQce3tqnays3l2TnDmUeN4EHe/rhl2w3eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471994;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=9qSoeqsI4bxqeV5X3TMorqW6NoJl5KxMK572XEj3Kaw=;
	b=UrXmK+zjzoU1J6kS9sLJpSE3RkAOKWQ8N0ksrfyeVLx23Uh46Z9cG32lQYkNqnRPBtWO
	 vGz2cbVu9iEfyqgcXqOu4SvdsFDwrRLLZEjS1c7bM7ayyuPxvJvwKnYKsCK8OUYqYSqea
	 GhYqQPGkhs+Hp9vdsFTT+Fqd5PcZ0PTWd+7JZAhbXZ4Bc2wK9cgoUz3VWB2yFj+o9kWfp
	 ac+EMwnTxa5AQ3grobrq67y7ij1AiJCjfI6Fy4lXAZ7faaXyR+RIIDXXPKfOfJf1Q9FSz
	 G6fi32s5bweCQs504tA4WMbIFMxfxvaQzdz87UdhFXQ/oSfxqMUZEFp+vPz3C2OiaHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=CWcG89Rx;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2A606A321
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D2A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=CWcG89Rx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795471992;
	bh=Nx0frIADUubLuqfvVGF+cDehXEGlYqvIFroScOlUNDo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=CWcG89RxSocktXMD+5n89LOZaXkNmbdTmYQTg5toqWP0pSduyl0+DOvN1eyVt+krL
	 bTJ2HiAxFY8/jwDlAHuR2wHwr9/cxqBA/w8t5EvDai0l0ugAzrbwAU6RpwgxDn/2SW
	 Zo7SEMKRi8CIqGRQUuZgmRwQnZT7Q5kgLLNjh5oVEtyQ5zHw3gPc5dV4CKXGPHf+j8
	 wR/7KeNChtXw7U/fxOchSsvg2Tr5+iYj6VxbdCe638WktRGlSalCRaMNqYvoWmKUa7
	 GksWUOey/J5GCnZC5Go2H/eVH6pt7Y/YrmGH1w2I1c0WIJw0Mr8qVWw4DOlh5XK81S
	 jebr9f7bet1l5GiRXSSJQjuERKkUbNuv2OyM7rEIgczpMydfJi6yB6f9Qf1CSIPyVA
	 jWnbZCCrPAIIkYq8RJ0IRi++lckVBdCbaXm+yYGthricmwIY51wGsokBL+nELMWE7b
	 Jl6t4Y0s4BsmWhzDcZ6AYNA/IzO5W/tAjCfcNd5DaqxzROJoQSa
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b97a:40e5:29bf:ff1f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6AB09200D5;
	Mon, 23 Nov 2026 22:13:12 +0000 (UTC)
Date: Mon, 23 Nov 2026 22:13:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4] setup: fix hash algorithm detection
Message-ID: <awS6dogRASLU3OVx@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Adam Dinwoodie <adam@dinwoodie.org>
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
 <20261123011403.720209-1-sandals@crustytoothpaste.net>
 <xmqq4id7bjmb.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G2dlVaWPApdAnWQk"
Content-Disposition: inline
In-Reply-To: <xmqq4id7bjmb.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--G2dlVaWPApdAnWQk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-23 at 16:25:16, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +test_expect_success 're-init does not modify hash from config' '
> > +	test_when_finished "rm -rf repo" &&
> > +	(
> > +		sane_unset GIT_DEFAULT_HASH &&
> > +		for algo in sha1 sha256
> > +		do
> > +			if test "$algo" =3D sha1
> > +			then
> > +				other=3Dsha256
> > +			else
> > +				other=3Dsha1
> > +			fi &&
> > +			git init --object-format=3D"$algo" repo &&
> > +			test_config_global init.defaultObjectFormat "$other" &&
> > +			git init repo &&
> > +			echo "$algo" >expect &&
> > +			git -C repo rev-parse --show-object-format >actual &&
> > +			test_cmp expect actual &&
> > +			rm -fr repo || exit 1
> > +		done
> > +	)
> > +'
>=20
> error: bug in the test script: test_when_finished does nothing in a subsh=
ell
> not ok 62 - re-init does not modify hash from config
>=20
> I think it is test_config_global that is getting complained.  Perhaps
> something along this line would fix it.

I'll do a reroll.  That only triggers on bash and I use dash as /bin/sh.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--G2dlVaWPApdAnWQk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmsEunYJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZz6XEgLcTZ4/WAm2BIjsZmDut5Lr+JvIuAV0SuocSCiU
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAI1JAQDyfsAcIuVLNswwUhLuGSEsTMh0
vJnuxKoL9s7l089NfQEAwj9CPEL8wKSZTYBNBR6JrnIPGDdWosLR6beDcchZpgU=
=9MHj
-----END PGP SIGNATURE-----

--G2dlVaWPApdAnWQk--
