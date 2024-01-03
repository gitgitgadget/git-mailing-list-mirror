Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01D182A2
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OnSe9WDb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7p3jSIoW"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id CFBF35C01C0;
	Wed,  3 Jan 2024 03:22:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jan 2024 03:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704270137; x=1704356537; bh=kNmsSWJ09e
	/OBp4ELSt9lb2xsyV2MfAvTn4SljgMSHM=; b=OnSe9WDbP+Rp6KIhqN9eSkkB4u
	8+qx1LiU4dDHKThvf6dHV4XEaeSZBxlbdGr0LOd5sGWg0ghh+GtT7mPyUFtatFPh
	qHx5Z6OeN6XH7LTKe6nMw9ZvD64Ve6lBxGR2AD8czvmkaGsHS0xrY3pmiGzQiauJ
	JH0L/nclykCcu28/mruhXd1BiAWfRq7IgMMHekNCB64GChqqdku0bZg/kaPacHby
	knV1hEdO7WUAxt4xSndcc4hWMwbrr4htkzjNJdZ1moWv0Rz4IzL0sqDxOHxeCgx0
	n6do07tH9xbZx3ICjxplmLNeLYOHfcaJhIfb3ldD4oma2rW5MdqK8NLbhCEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704270137; x=1704356537; bh=kNmsSWJ09e/OBp4ELSt9lb2xsyV2
	MfAvTn4SljgMSHM=; b=7p3jSIoWAjCIUXvFFwxXy2sOO9er3ktylqFNfilIZe1S
	BbvApezmrxd6S7w9lsCFHd9azoiO+LKmIXTVvOBwXhYehNg1B6fTcUQS69/hXLlB
	sPxDswG09OPmzkQbBo8Y5PhPtOmAf6CGukins47VrQ9d57ySfEJuifBY230e18mx
	t3rcdFKlh29ncagFUPeQJXTYS36oh1VLhGWhc83T42htk2eAVoMkSPImbZrfPSXY
	1NonNQvMsXhN/ZEqLZlZYDF10A6mmNUStMPBC6iXFkpQJRGdOLp4mPWTTBc0439u
	lJV16RVUZEfNMOB4Bk0FJ1sZWHDBsBuOnKJVOsTwug==
X-ME-Sender: <xms:ORmVZerWswJ0_cQAcKKlrL3UxLz7-rCeVGpVzboYw7iSBxR_8BnXBw>
    <xme:ORmVZcrZVg3C8jdcQJEzMQf7DTibRbQDsC9FXCO1T4zVOux_81LqMkHdkUQMAh-gP
    3XEsWzLYFmPwHDFEQ>
X-ME-Received: <xmr:ORmVZTOPPp961Gflq5Pz-rrthr6HMDY1se0x_miMytCpayKIbbo8XCQffofyxM6rY8g8NGO7rhbn5ye69itzlIARJe85MDb6EZ2i9p-VX6FBBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ORmVZd42MoTdN7HnyKwCfU76zvm6Cs4hS2EOY1yd7_GwrbeDFVl8KA>
    <xmx:ORmVZd6UmLvGNn2QaHgzuieWWaVV0B7ZF1MpXxMG9TluhFqbn2T7zQ>
    <xmx:ORmVZdhyRTcxz2lSAjCMNqKOu0NJz_aVLbj5goKoXM4dpE3zU_we7Q>
    <xmx:ORmVZdEfAhYY5FdRRAZ4yAkc56tNhhjo2dnVSZR7oePEa07uv5evJQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 03:22:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 68b0fed2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 08:19:49 +0000 (UTC)
Date: Wed, 3 Jan 2024 09:22:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] write-or-die: make GIT_FLUSH a Boolean environment
 variable
Message-ID: <ZZUZNQqDTx3bnveJ@tanuki>
References: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
 <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wO9kszr8PtdisSrN"
Content-Disposition: inline
In-Reply-To: <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>


--wO9kszr8PtdisSrN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 07:58:28AM +0000, Chandra Pratap via GitGitGadget w=
rote:
[snip]
> diff --git a/write-or-die.c b/write-or-die.c
> index 42a2dc73cd3..a6acabd329f 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -20,15 +20,12 @@ void maybe_flush_or_die(FILE *f, const char *desc)
>  {
>  	static int skip_stdout_flush =3D -1;
>  	struct stat st;
> -	char *cp;
> =20
>  	if (f =3D=3D stdout) {
>  		if (skip_stdout_flush < 0) {
> -			/* NEEDSWORK: make this a normal Boolean */
> -			cp =3D getenv("GIT_FLUSH");
> -			if (cp)
> -				skip_stdout_flush =3D (atoi(cp) =3D=3D 0);
> -			else if ((fstat(fileno(stdout), &st) =3D=3D 0) &&
> +			if (!git_env_bool("GIT_FLUSH", -1))
> +				skip_stdout_flush =3D 1;

It's a bit surprising to pass `-1` as default value to `git_env_bool()`
here, as this value would hint that the caller wants to explicitly
handle the case where the "GIT_FLUSH" envvar is not set at all. We don't
though, and essentially fall back to "GIT_FLUSH=3D1", so passing `1` as
the fallback value would be less confusing.

Anyway, the resulting behaviour is the same regardless of whether we
pass `1` or `-1`, so I'm not sure whether this is worth a reroll.

Patrick

> +			else if (!fstat(fileno(stdout), &st) &&
>  				 S_ISREG(st.st_mode))
>  				skip_stdout_flush =3D 1;
>  			else
>=20
> base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
> --=20
> gitgitgadget
>=20

--wO9kszr8PtdisSrN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVGTQACgkQVbJhu7ck
PpR2ahAAqOx843RscwX4mLP4hqjqyf8ISKP40T0fHBs5el0lhN4aOMvNYEbYVN8x
5TTPZKOJCZwg/EOLA+laTNvMu2I6yi5uEehM6eFg+QFf97tlnIRrhy28UNRBDNED
aBRWHGuDE5dVAnYSoC7GrbZzvK+VYOGVmyX2oUaDZafbQQ6BFMyxTvrt3t8BHk4j
LLfohML3hwuQTd163KEfm9t+eCtiu46x4QRDH9qmS2nucL12NkclG5CpXFmyGePo
d6BSXentH9WFWbT7Tjf1e1hPMzyz5R/P6ritFJvdUqb2Fw1ctqt/yb+TlClgHqvC
moIg4y8hMs9vkD7DmRgQ0f3+E0COmPF2/wGKEhyuVAP2CeAIjYGJvo+cjoSGTUBn
21/FdhBOyv8pHuLuJFMeqE9Tc7twSn7p3UI7DKMLIDvaOkuTLcc1MiwK9Tbh9gop
uRxolCNRjQfGf7ndGdgMpf8srWgC4ONolC23V/EpOhSaR8Q82M3jIHpKxWNUM8ah
YyXwN8u1Cr8eg2mulXOkc8ZYrajAIAaaaUSQL5+nsUYnaMPAmio0ebQQd/k0cRyI
S3YqWFN4ADidclux9/hZ0AuKF2UojbkWf8vtQ38plb5WUNDAfUsdYP+UtBMpSKOa
HLpAKYL9WwXnaPh/ywOmMGoT/IvM2SFJWZPRgxIiGALGKcFxh3E=
=MEaC
-----END PGP SIGNATURE-----

--wO9kszr8PtdisSrN--
