Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC9250E6
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LEje/v80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EjsTv4yU"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD612F
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 04:50:52 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3C5235C03FD;
	Wed, 25 Oct 2023 07:50:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 25 Oct 2023 07:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698234649; x=1698321049; bh=RL
	Dkt9mgdrbw3k3fpRS85PbBmX4zBCBMDs6jzKp0/L0=; b=LEje/v80ZQoCMP1p7E
	awugPxq38V770fdmsUfLj1F1MdsJB4gJ1WP/t0+wpCft8jT6uRJxHYm2eZwmGofB
	/zf76V5ENUqoWIUdvhCG1kwvaVbIe3Ck61vdEvaIsgQOPWwec3sfTcCb8LXw+KTi
	DaMN2Iad4t8nm2fEVedGVBQHCT72HH8wSR0TANeVHk67b4IT6bj1GG/uFc9b5m6l
	sBKE5CI67XwbImkUZ9E4Ku42kr801YF5O2kNtQi03DoEcAZRiAn4TfviKN625wpf
	5DlASvkoAJo3+3Tmldkf82ti0DxBZ2ZZxpRBjphvYbYUH7kjgKuAkrw+90qSvhGp
	ob6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698234649; x=1698321049; bh=RLDkt9mgdrbw3
	k3fpRS85PbBmX4zBCBMDs6jzKp0/L0=; b=EjsTv4yUv0vlmEFe+OQwc6k1oXR3i
	tFu9vl1C6irhiVFKCZL5rvLl/9TKN+O/WWUYZGBT7UlvuLQAR7tFKVxb0xsJkOgp
	sTGQHpcLkmJZghz+GuG04SlvpXiDPnO7YHxP7RpYAs+MAVmK7ES5o9YA/yBA9J+M
	VwqbJTClogIxKaqCWieP3Umagazy2k4PpMSt3/4vtBiLb2T7TFUVGvjeuOcqbQRL
	W7cXz1Qtbl6ZWgwYclyOctPiyekN9Rz5D9+wuNUq8xx9vj+wbEH24Enk7gBlyXRT
	K0qyEGtUMUS/+rzIMq3SNiJQBdX+Kfl0t5OyZpXa7aUVTmb2MvMyQekMg==
X-ME-Sender: <xms:GQE5ZWOMAtERLsn2M3lGSKt0e5AIaMEmr9SSK0w5F69AsMUMaPn9Lw>
    <xme:GQE5ZU_UcNWhsCNV6nf0jN9NfN6DAyTzDljhTX1ySisUUYwOr-8xM-ldNuLlbJL8g
    GZ0Kj5SneCmWVq70g>
X-ME-Received: <xmr:GQE5ZdS3_XFFn6j2X9oXWVzHkO3DeCBmybtoQeTuP64nCy99UhjOfwLUQjJHV8xm0CsA5zp11YuHd2Jcu9AsWzzdFKx5pZ8ZLkTrctWLFsF2TEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:GQE5ZWspgxDY8rYLjlzfVxQqBR456JJ8jX58hi6qlAACYqpG_KKQ_A>
    <xmx:GQE5ZeeI9hM7ceflQKudEnuR9NlzfrXHv8SMJHqfxnnw36R5xSVLCA>
    <xmx:GQE5Za1w0gaZ_QkiIXw_99vjt27MQQdVGxpcMajCWFocciJgB000xg>
    <xmx:GQE5Zfor_bAAiIzn0FwYPM7ZzfSiQ6OSDuI1eQXHlPh9HxT1kS8C_g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 07:50:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff58bd9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 11:50:39 +0000 (UTC)
Date: Wed, 25 Oct 2023 13:50:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 05/12] builtin/show-ref: refactor `--exclude-existing`
 options
Message-ID: <ZTkBFD7Iffe2bTOE@tanuki>
References: <cover.1698152926.git.ps@pks.im>
 <8d0b0b5700c7ffed6b3a74760d0d9155b404bb4f.1698152926.git.ps@pks.im>
 <CAPig+cQrD6uh65UzaKbwryv=wcdymKrjqXsAKgrKHYpQNWqSYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x44PRnulJNW0t7bM"
Content-Disposition: inline
In-Reply-To: <CAPig+cQrD6uh65UzaKbwryv=wcdymKrjqXsAKgrKHYpQNWqSYQ@mail.gmail.com>


--x44PRnulJNW0t7bM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 02:48:14PM -0400, Eric Sunshine wrote:
> On Tue, Oct 24, 2023 at 9:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > It's not immediately obvious options which options are applicable to
> > what subcommand ni git-show-ref(1) because all options exist as global
>=20
> s/ni/in/
>=20
> > state. This can easily cause confusion for the reader.
> >
> > Refactor options for the `--exclude-existing` subcommand to be contained
> > in a separate structure. This structure is stored on the stack and
> > passed down as required. Consequentially, it clearly delimits the scope
>=20
> s/Consequentially/Consequently/
>=20
> > of those options and requires the reader to worry less about global
> > state.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> > @@ -95,6 +94,11 @@ static int add_existing(const char *refname,
> > +struct exclude_existing_options {
> > +       int enabled;
> > +       const char *pattern;
> > +};
>=20
> Do we need this `enabled` flag? Can't the same be achieved by checking
> whether `pattern` is NULL or not (see below)?

Yeah, we do. It's perfectly valid to pass `--exclude-existing` without
the optional pattern argument. We still want to use this mode in that
case, but don't populate the pattern.

An alternative would be to assign something like a sentinel value in
here. But I'd think that it's clearer to instead have an explicit
separate field for this.

> > @@ -104,11 +108,11 @@ static int add_existing(const char *refname,
> > -static int cmd_show_ref__exclude_existing(const char *match)
> > +static int cmd_show_ref__exclude_existing(const struct exclude_existin=
g_options *opts)
>=20
> Since you're renaming `match` to `opts->pattern`...
>=20
> >  {
> > -       int matchlen =3D match ? strlen(match) : 0;
> > +       int matchlen =3D opts->pattern ? strlen(opts->pattern) : 0;
>=20
> ... and since you're touching this line anyway, maybe it makes sense
> to rename `matchlen` to `patternlen`?

Yes, let's do it. It's been more of an oversight rather than
intentional to keep the previous name.

> > @@ -124,11 +128,11 @@ static int cmd_show_ref__exclude_existing(const c=
har *match)
> > -                       if (strncmp(ref, match, matchlen))
> > +                       if (strncmp(ref, opts->pattern, matchlen))
>=20
> Especially since, as shown in this context, `matchlen` is really the
> length of the _pattern_, not the length of the resulting _match_.
>=20
> > @@ -200,44 +204,46 @@ static int hash_callback(const struct option *opt=
, const char *arg, int unset)
> >  int cmd_show_ref(int argc, const char **argv, const char *prefix)
> >  {
> >         [...]
> > -       if (exclude_arg)
> > -               return cmd_show_ref__exclude_existing(exclude_existing_=
arg);
> > +       if (exclude_existing_opts.enabled)
> > +               return cmd_show_ref__exclude_existing(&exclude_existing=
_opts);
>=20
> (continued from above) Can't this be handled without a separate `enabled`=
 flag?
>=20
>     if (exclude_existing_opts.pattern)
>         ...

See the explanation above.

Patrick

--x44PRnulJNW0t7bM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU5ARMACgkQVbJhu7ck
PpQRlg//evyC6lN/fZMceMVx5jxY2Fm/1lvimQoQB3PLCePu6einJfl86hOJdXL9
+N2wZ80hDim2Kr3HJe/a5LbWxrum+EBfEHIbJq4yK38Mc9iNsjxmwu6dEM+d14Ih
1oFgIj7j3ScHrD7YZSJkXOrDjXIUfdJLLtDFWVenq7CFA44yfMhhl6EM1EU22nJ1
ZnUWPGFiruzsi9Lbf11CdJWN/WZIgOG/VIlexwZ8ykVmZUPRpL6U+GeigXoi0ypI
nC8z4YiY4+Fe11vsb5Mp/SSdGs2Bouo6uqhN86tbfckD2qnrC5ZTi57UAWlejCXe
6ZNwIZno/4V/iVGfko6cs0y8iGndRZs0MOQju4GLUtSPQsjD8VYt27xlMen8vANv
Cp51KK/csUyu/+FXUeTrgvMO/2ZmSpsDYFaghveBB2gLgZMtijgq/Ms9a8PO89ZH
EOg+DS1zAuK7VTLQ0gHsaCYfITT5lMdZxXk5fulsf00yhN3+QKUxH0pBgJqG0ocz
QncrtHtMId8x74OQg74sI1Vf58PKkTRIS1pCbbmaiQ8vshX2RW2XDaTYoVjwWXef
PEJPyoM4aSvlzTI1OEFOeWByH1razSDp8muZtuh6GgNZd4krlf7XEKkrkydCAgYS
dHx4u0gljp3/DqIbbH14KlOeKvqfynwzyiHSLH9dvnPzhY8VP1s=
=JKuj
-----END PGP SIGNATURE-----

--x44PRnulJNW0t7bM--
