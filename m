Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cWwkk3fh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6QHFopM"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5010F8
	for <git@vger.kernel.org>; Fri,  1 Dec 2023 00:02:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 92A023200B47;
	Fri,  1 Dec 2023 03:02:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 01 Dec 2023 03:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701417733; x=1701504133; bh=9D
	i8qqsxvAaeKMn8bWMt+EA2zCYFdNsYIz/FG4HTNOc=; b=cWwkk3fhDhaHpD1Z/W
	OaJTqlP8GRiDq7/aFdejfsYh9VghqNhBIW+JnO2rqwaUbxjWObnhaBYMuGY6hDlQ
	evXE6uQIRma3ksYvZOSr3tJDRDM5ogn1Kj7F/O0CoeetQUWzlXR794XmGwU59hDs
	ykrweqUy9V3dn1muT10NUXALrI05Lxgk6lFeXx49vU2l4hwwn9Bfv0zMaLlkT6Jj
	Kq2diGr3bisu/BvdLcrHKeYk+OsR8UAKONXiE+DQv1NrVWQzn740H2nQVg/oKRAc
	PgmXRE7vDQD+rNfgaVZF5CXiY0l/oadEfzbd6f/12zt8tn3C0b0pCLdY+A6RwfAv
	/3/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701417733; x=1701504133; bh=9Di8qqsxvAaeK
	Mn8bWMt+EA2zCYFdNsYIz/FG4HTNOc=; b=n6QHFopMM7hEUgm7aX69Fw71i8n9K
	N39kclJyUvNtEnT4dZ0ulE4dOoHm8k44rQfdpEXJgTsGItx+YOg2WgrIgxG1Xsvo
	h/xVR00r7VKDrCY074iZacUe6W1GTXbQ3poBLAqrHjD46a2/5G/EB/46NmprQ5JA
	nUYfK+UTZnV+qYZ/LaDmGrf1LWiMUw6kekyl1TLhtTHQDJd33pO8ltKO+Ms5yOPw
	n97BDS2NextAfKh96fIL4+b493b4w73duGGd/2x/FVsk1DXZbye57huvBRu2BXmv
	R3W6eUH0DuMkvM1cdI1D1L1U/Oszjn0OueR2B6+ekJp2WS+8A9Nv1tPQw==
X-ME-Sender: <xms:BJNpZVYfzcPe4hwBfR-j2AGyIeOu1A6_eWUmngSb68utbcq_22ELDw>
    <xme:BJNpZca3u2fv1h2gPqBZ0M--o5owX0Vn2nQfA9t4g_--GhmNGYc3hl-wDKYs7-ZB6
    umrtnAyPpwqlLNelQ>
X-ME-Received: <xmr:BJNpZX978edoYhVo18fFd5ay5Npey0ob2eqy52ySeP2X7fdBmfDHhfqsV48czybHLt3RA-uHumu3ktWmohLgFeZv3TGwOCReROA7Dw9LjVagJGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BJNpZTobvfaFyrG2giiuty1Wgln8s9UBENqYunE_jPMoULjzL7fVqw>
    <xmx:BJNpZQp4tpbWVZ-NwfQZInDRYRH-P18EpsoFjgiMiPDFLdSR7MfZsQ>
    <xmx:BJNpZZS0qPGD7M8dRAOzxpQcN8nXbEL346rFgbM05sImdtZLyAdW6A>
    <xmx:BZNpZX28UA706OhKJKKYVy_m8jQHimuxQdnbM78xwnoc6PVBFDOKzg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 03:02:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 91c3214d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 1 Dec 2023 08:00:55 +0000 (UTC)
Date: Fri, 1 Dec 2023 09:02:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/24] midx: implement `--retain-disjoint` mode
Message-ID: <ZWmTAO_OfR_g3-3p@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <3019738b52ba8cd78ea696a3b800fa91e722eb66.1701198172.git.me@ttaylorr.com>
 <ZWhhi15VpeCRflDB@tanuki>
 <ZWjisIgiuziMvBph@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xTE5iXfl1DUMr/F2"
Content-Disposition: inline
In-Reply-To: <ZWjisIgiuziMvBph@nand.local>


--xTE5iXfl1DUMr/F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 02:29:52PM -0500, Taylor Blau wrote:
> On Thu, Nov 30, 2023 at 11:18:51AM +0100, Patrick Steinhardt wrote:
> > > diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/g=
it-multi-pack-index.txt
> > > index d130e65b28..ac0c7b124b 100644
> > > --- a/Documentation/git-multi-pack-index.txt
> > > +++ b/Documentation/git-multi-pack-index.txt
> > > @@ -54,6 +54,14 @@ write::
> > >  		"disjoint". See the "`DISP` chunk and disjoint packs"
> > >  		section in linkgit:gitformat-pack[5] for more.
> > >
> > > +	--retain-disjoint::
> > > +		When writing a multi-pack index with a reachability
> > > +		bitmap, keep any packs marked as disjoint in the
> > > +		existing MIDX (if any) as such in the new MIDX. Existing
> > > +		disjoint packs which are removed (e.g., not listed via
> > > +		`--stdin-packs`) are ignored. This option works in
> > > +		addition to the '+' marker for `--stdin-packs`.
> >
> > I'm trying to understand when you're expected to pass this flag and when
> > you're expected not to pass it. This documentation could also help in
> > the documentation here so that the user can make a more informed
> > decision.
>=20
> I think there are multiple reasons that you may or may not want to pass
> that flag. Certainly if you're not using disjoint packs (and instead
> only care about single-pack verbatim reuse over the MIDX's preferred
> packfile), then you don't need to pass it.
>=20
> But if you are using disjoint packs, you may want to pass it if you are
> adding packs to the MIDX which are disjoint, _and_ you want to hold onto
> the existing set of disjoint packs.
>=20
> But if you want to change the set of disjoint packs entirely, you would
> want to omit this flag (unless you knew a-priori that you were going to
> drop all of the currently marked disjoint packs from the new MIDX you
> are writing, e.g. with --stdin-packs).
>=20
> If you think it would be useful, I could try and distill some of this
> down, but I think that there is likely too much detail here for it to be
> useful in user-facing documentation.

Yeah, this indeed feels too detailed to be added here. I was hoping for
a simple "Never do this if"-style rule that points out why it is unwise
under some circumstances, but seems like it's not as simple as that.

Well, so be it. Thanks!

Patrick

--xTE5iXfl1DUMr/F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVpkv8ACgkQVbJhu7ck
PpQkIBAAqBLf6Y+vwm9OPiFVT6K5iiDNw6zwpyzLrCwaa3zEPNxrDevr++faENhN
AwjBNRNX7K6F+xhuh4fjplDRPjn/zQeSabNW0rxFtdDShqlBsdtpamwm/MgQ58ZF
tnIwQS0CtiPElxThcDrTyIiwredAXWg/NaZqHrMmM1f9OymNuuL4sG0NUFKbnO1x
4jp0QliLx1MJ0m4a42IaYVZP0fHWNBeyJB8kVPSTZUwwylqa8VA23kqCAuxLWXAt
ByP5TTbm+R2CVq9E/ozEWCT7m2tTq6SVG5TU9WQvRKPBWuGMLgqft3zMldUcXYPY
bVx8WAEQUJk14dVnTXqNlEE9MQ3tSE+fKAACCBL9g7iZyGxMaveQBhp0nz4mQ4XR
Z8hf9QUEW2XkfCOmCAaUwZ2GqmZxlWfxkal4R8NpbF+khxntgfTn8GeYwePhMtAg
Nx7u90Ec66jrPfECnyao2gHAPREYpH/Oa5sszelVO0GD5SFL/08ciFE3BFarvg8/
IuH8SJ+r9JcjgBZKitzD6k5krLFhodpGZbCw4BnKulvRQuYRWUg+TrG+XwbBn6Fj
AnG/iDydy3BSTKtIhfkjFnA1HWeo8agPS/ER0a/E0ds15kULPy65RwroWrWjQWF9
2oXRWISJmleCnzUlv+w5Nc5fR6iq32zCMHQJPjnQyHJkYGV5/tI=
=x+hl
-----END PGP SIGNATURE-----

--xTE5iXfl1DUMr/F2--
