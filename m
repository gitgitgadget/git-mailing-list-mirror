Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qardKwj6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NNVID/O/"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A42D1
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 23:43:40 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 594355C01DA;
	Thu, 30 Nov 2023 02:43:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 Nov 2023 02:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701330220; x=1701416620; bh=jz
	C0ypUDKfQAqrAePeqFkvPUI3VbwemWypzq5CzRWd4=; b=qardKwj6X14RqehguE
	cZ1skgFfS1JB235cFxkuctqtGxkUp144cBJM8L1uyVgTE2NlGF9I/ebtAWlXJtmn
	yRP1WEyHvwu3nTSnThpZB1wJkJQhqjjpRWh8KMvObPzwJ4iqXkssWdyW3yjq7fB8
	YlIf5bWq8GLMwo6g+fZpQqe4+WveDLBeVqlBgT14R7U2gtx36kx4Zoq4E0jJP3RM
	Btb33B2/M3uEMzrign2szdizV6FrJkp1xiJuT0ai0ic2c2VQtm7WYV+vSAl3c1T1
	A/L/HSIaV2Ps1s8jKU5BxRCMMYiLBzBGWowTsOO0ruCB/DshASrtPrtxZpLodRbZ
	2R0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701330220; x=1701416620; bh=jzC0ypUDKfQAq
	rAePeqFkvPUI3VbwemWypzq5CzRWd4=; b=NNVID/O/2wRwGFW6muWswUeBcfeNr
	jQZ1apI1IiMYdGp3wjsA1ZhRn3ce8mBOfasC07dF1dpIoUitjgbX4Ji24M0vJTAy
	GgwM2YQVoNxcXBhfoT54+U4ovK+m6mqizwjXQr+bmX4DhvcSFRiJagON27x3e/Ge
	pAf/7mfu+iaBvv9A7S7tHxS7/hwEfG0ff2ioBImOCUT6yKQARLbL9o+X03DlKVKr
	VazA+GVFrJKdjr3qslgS4ZkEqSLZXTXHH88790tQqFtMyKt9IRPfCsYHKm+UXaEL
	FbsMvtXo93QU3llY/nSYgIpOVyoKsDgJkZA9KaFsFXQUWRIo+4rRDyY+Q==
X-ME-Sender: <xms:LD1oZQAkhgTtiAbHuqX8SEifvqVk5ngG8M5PXxvcDXVdhq8l2-wdiw>
    <xme:LD1oZShwa-mMP0GVM5sa0d2tAvFaZG06klS1l0I-hM8U1-StBEkzMDOUCENPJjQBs
    xE6sGsmiKAXYcvNaw>
X-ME-Received: <xmr:LD1oZTkJw_Wf4ybOxziJ1aA6rdCvm0LcAN8bBsdBqWu6LH0yXQW3TlFklgc8uCYCWqMwL81ljf0iawaY8VgjlW1E4-nHoZBg838m_nsbZ9JVHIpt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiiedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LD1oZWyPwxE9UUDyH2VS9zNQQ6AgOzjKh78cdd8vf8iZV5Y23VJfUA>
    <xmx:LD1oZVTd8l6Lk0qKNJ4vaY-J3AgkHEWR9XSRNfOyD-8qkLSvVNDctA>
    <xmx:LD1oZRZRmAJLcZg0YMcAHLNIueeJkKlanVLJc-7DWYSiWx_Sv9J9Cw>
    <xmx:LD1oZUKcPKr4dJzkDPZn8Erq4N5WnNRAYInjStI_0bmMVB3Z7lQ_CA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 02:43:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4044be7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 07:42:26 +0000 (UTC)
Date: Thu, 30 Nov 2023 08:43:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 2/4] refs: propagate errno when reading special refs fails
Message-ID: <ZWg9KfpeyLRdX1b8@tanuki>
References: <cover.1701243201.git.ps@pks.im>
 <691552a17ec587b0c03e758437c33d58767803aa.1701243201.git.ps@pks.im>
 <ZWeyUU/NqmGUvyOL@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AHwbrh6nAZ9kgYM5"
Content-Disposition: inline
In-Reply-To: <ZWeyUU/NqmGUvyOL@nand.local>


--AHwbrh6nAZ9kgYM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 04:51:13PM -0500, Taylor Blau wrote:
> On Wed, Nov 29, 2023 at 09:14:16AM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs.c b/refs.c
> > index fcae5dddc6..7d4a057f36 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1806,8 +1806,12 @@ static int refs_read_special_head(struct ref_sto=
re *ref_store,
> >  	int result =3D -1;
> >  	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
> >
> > -	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
> > +	errno =3D 0;
>=20
> Do we need to set errno to 0 here? Looking at the implementation of
> strbuf_read_file(), it looks like we return early in two cases. Either
> open() fails, in which errno is set for us, or strbuf_read() fails, in
> which case we set errno to whatever it was right after the failed read
> (preventing the subsequent close() call from tainting the value of errno).
>=20
> So I think in either case, we have the right value in errno, and don't
> need to worry about setting it to "0" ahead of time.

True. I'll drop this when rerolling.

> > +test_expect_success '--exists with existing special ref' '
> > +	git rev-parse HEAD >.git/FETCH_HEAD &&
> > +	git show-ref --exists FETCH_HEAD
> > +'
>=20
> I don't think that it matters here, but do we need to worry about
> cleaning up .git/FETCH_HEAD for future tests?

There's so many tests where I wish that we did a better job of cleanup,
so I agree that it is sensible to clean up after ourselves. Will drop
when rerolling.

Patrick

--AHwbrh6nAZ9kgYM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoPSgACgkQVbJhu7ck
PpQZTw//aPIfy2nA+X0m4xDx/El5+4WwtXGN2JYqiwG9Py4wO1VxMpPBFoKzHfU0
+t9ai/cUW8VB/0DbMMrK79JS2aZ19eSAvTPl00iijJKsD8KqkQ9cS5CAvSMGV2Wa
524DMA65pgC7Lk+Ok0ZeSIjfhR1i7OxGeFyKa2V7sPdPGOAV6tye0y3qKZWZMDWh
Ue1IPWX1NFkw5NBdbf8ZuSPY1h73F0NG66Tyqr/G5QevpZGo7rZkWNkAIwhHQA4Z
MMn6CITQes+YDIWpxPNB12m8KNvEbgvoiZuTW8UI5QgLbbvhcc3MTS2KQI2u1OGT
91fmnPEJtcbi9hTkCJbBiS23Ch+AQdFxEdg+m4z6yRBjzv5UNFF1FHWKqQpujSpL
9VVvuyfI0AZHD4ewQ3zv8b2rJw+ssqKGf1b9ddYguhTXoH3UMRT2doHKcUfayn4s
2aoDgW5cojrO5WFDOloZYgWNdiJnDAA9MxQsxDVNXU1bZe+R+ui0/S0p2u768jo5
VNEybFCzdWhpf/hgPpunRIk5GtICborlwgSCO89G4E6znLClDyX+T+yROP4Qj/fU
a3oeCzCE6/oKPYuAoid+TTKgzOyd6MAGF/Dx75Jezn+fUolA2ksZBE6HN311Q8ac
fU3C679745GMglCryuhcGiPMs+VyTrc02wuUUKmvRGYcP3zo/g8=
=X5Mb
-----END PGP SIGNATURE-----

--AHwbrh6nAZ9kgYM5--
