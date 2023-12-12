Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dppwtQzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CxT076YF"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F03A1
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:18:50 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 6E8973200AB8;
	Tue, 12 Dec 2023 02:18:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Dec 2023 02:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702365528; x=1702451928; bh=aqHc/6cBUQ
	os4Ye9XpynCF7D04X2pY+RcNVcS6VnvUU=; b=dppwtQzgERMLVIfZfJAU6OeSGT
	159yRZ/U0ft5PuUKT6PdQZ2hIsOElzALCK1a05HyJ71PAp3YG81dN9SA+igbnk25
	eKf6FmmspopAz6XtrH02/nMYRtE7Tyas4ecdv63uGZjlJ4VdFlEm+yx2JxUWHPUb
	P4B372JCxfLaMJ8BDk9bMFV0LNXbb0k3W4ST+NvyLQ5ATMvxJ/nmYOAXl4ccGaCD
	iKru+GNX0DTCy/uTUKk2imG4tYK2zq9fTbHaVBC9jyBmbIdKWSA/vpXdsZ2JHFI+
	aQODgp7XQRlCPckJwv5enmujFZ2rNetSeTto+sPQ9DUHxUtrZWq07d3puuzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702365528; x=1702451928; bh=aqHc/6cBUQos4Ye9XpynCF7D04X2
	pY+RcNVcS6VnvUU=; b=CxT076YFOgsFU6dfUq0a//EnFDSC83xBcYvY+x7gLAhu
	70DXyYYnP9p+JOtZW41v+ExMw1mXC9Wy2Eogpl38WCScFFpBrB1+AmOpmIwgazpR
	n58LI33MDoAbqJ5IX8/EIVjpRFbsCKdr9n+uTcSj6WAIr3JG1txUb+nqp09DTARS
	MS4hUGO3zZ5jI5l8n1GeTlsWWsS+T03JH6y9KwRKjB5YrGvV0NhzG7k4pS15jKSX
	wjA5h6c/T5ZzJJsBcMjamA/6TXs4TSkxCL68PLq8glPbnYlKNyg1SvFaBleOcBRg
	F448z0EeMU7EYqTY3g8AqeL5EZV6uItkehTakpeNzg==
X-ME-Sender: <xms:WAl4ZfrkwZkyaN3HLQQ38UJJZ4AUFt8O4F0bsCw-JSOLiXitwnOf5A>
    <xme:WAl4ZZo2tdXmbQhwtAi0-Ji2tdgc9Z_1U89u841LJslwvHCxJvBFvLJ-yFZjGRaV3
    XBU0pVfaHvqcc3Yzw>
X-ME-Received: <xmr:WAl4ZcPzjqbX0MTz4xr5Pd0aV2xtp4Dh8NlCSVBuRfL16KbqM0szPcmKqMwzoz1xc0hBk6xYbSM91FMjrL7zVaf6kpQewT4ZZII9QKmZHLg2wl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:WAl4ZS5ohnBQD17F1ArTBbhKDeYrtB0oWmhcsOeyWQ7W6-KteVhAow>
    <xmx:WAl4Ze5zf9UXdFRvYLYbSNo-bCJuzD1e9p2RAUBjRvMWZ4WtebRaXQ>
    <xmx:WAl4ZajMui3n24D_3xNwsUIFe3E3XCc8mPcf1W_C0m3t1lG4csWNsQ>
    <xmx:WAl4ZUQLBbhFCKwAQsk8fPdV0bXzMyq6kt4JF-5NmrfCikH7mrGMCA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 02:18:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed07d263 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Dec 2023 07:17:08 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:18:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/4] refs: improve handling of special refs
Message-ID: <cover.1702365291.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9vzXf86gJfkKFojX"
Content-Disposition: inline
In-Reply-To: <cover.1701243201.git.ps@pks.im>


--9vzXf86gJfkKFojX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to improve our
handling of special refs. This patch series is in preparation for the
upcoming reftable backend.

Changes compared to v1:

  - Patch 1: Stop needlessly resetting `errno` before calling
    `strbuf_read_file()`. Also, clean up state we create in our test
    repos properly.

  - Patch 3: The discussion with Phillip made me reevaluate my claim
    that "rebase-apply/" and "rebase-merge/" contain special refs.
    Indeed they don't, all files in there seem to be exclusively
    read and written via the filesystem without ever going via the
    refdb. I've thus dropped them from the set of special refs.

  - Patch 4: The array of static refs is now static.

Thanks for your reviews!

Patrick

Patrick Steinhardt (4):
  wt-status: read HEAD and ORIG_HEAD via the refdb
  refs: propagate errno when reading special refs fails
  refs: complete list of special refs
  bisect: consistently write BISECT_EXPECTED_REV via the refdb

 bisect.c                    | 25 +++-------------
 builtin/bisect.c            |  8 ++---
 refs.c                      | 59 +++++++++++++++++++++++++++++++++++--
 t/t1403-show-ref.sh         | 10 +++++++
 t/t6030-bisect-porcelain.sh |  2 +-
 wt-status.c                 | 17 ++++++-----
 6 files changed, 82 insertions(+), 39 deletions(-)

Range-diff against v1:
1:  35b74eb972 =3D 1:  1db3eb3945 wt-status: read HEAD and ORIG_HEAD via th=
e refdb
2:  691552a17e ! 2:  24032a62e5 refs: propagate errno when reading special =
refs fails
    @@ refs.c: static int refs_read_special_head(struct ref_store *ref_stor=
e,
      	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
     =20
     -	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
    -+	errno =3D 0;
    -+
     +	if (strbuf_read_file(&content, full_path.buf, 0) < 0) {
     +		*failure_errno =3D errno;
      		goto done;
    @@ t/t1403-show-ref.sh: test_expect_success '--exists with directory fa=
ils with gen
     +'
     +
     +test_expect_success '--exists with existing special ref' '
    ++	test_when_finished "rm .git/FETCH_HEAD" &&
     +	git rev-parse HEAD >.git/FETCH_HEAD &&
     +	git show-ref --exists FETCH_HEAD
     +'
3:  0e38103114 ! 3:  3dd9089fd5 refs: complete list of special refs
    @@ refs.c: static int refs_read_special_head(struct ref_store *ref_stor=
e,
     +	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
     +	 *   heads.
     +	 *
    -+	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
    -+	 *   rebases, where keeping it closely together feels sensible.
    -+	 *
     +	 * There are some exceptions that you might expect to see on this li=
st
     +	 * but which are handled exclusively via the reference backend:
     +	 *
     +	 * - CHERRY_PICK_HEAD
    ++	 *
     +	 * - HEAD
    ++	 *
     +	 * - ORIG_HEAD
     +	 *
    ++	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
    ++	 *   rebases, including some reference-like files. These are
    ++	 *   exclusively read and written via the filesystem and never go
    ++	 *   through the refdb.
    ++	 *
     +	 * Writing or deleting references must consistently go either through
     +	 * the filesystem (special refs) or through the reference backend
     +	 * (normal ones).
     +	 */
    -+	const char * const special_refs[] =3D {
    ++	static const char * const special_refs[] =3D {
     +		"AUTO_MERGE",
     +		"BISECT_EXPECTED_REV",
     +		"FETCH_HEAD",
     +		"MERGE_AUTOSTASH",
     +		"MERGE_HEAD",
     +	};
    -+	int i;
    ++	size_t i;
     +
     +	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
     +		if (!strcmp(refname, special_refs[i]))
     +			return 1;
     +
    -+	/*
    -+	 * git-rebase(1) stores its state in `rebase-apply/` or
    -+	 * `rebase-merge/`, including various reference-like bits.
    -+	 */
    -+	if (starts_with(refname, "rebase-apply/") ||
    -+	    starts_with(refname, "rebase-merge/"))
    -+		return 1;
    -+
     +	return 0;
     +}
     +
4:  c7ab26fb7e ! 4:  4a4447a3f5 bisect: consistently write BISECT_EXPECTED_=
REV via the refdb
    @@ refs.c: static int is_special_ref(const char *refname)
      	 * but which are handled exclusively via the reference backend:
      	 *
     +	 * - BISECT_EXPECTED_REV
    ++	 *
      	 * - CHERRY_PICK_HEAD
    + 	 *
      	 * - HEAD
    - 	 * - ORIG_HEAD
     @@ refs.c: static int is_special_ref(const char *refname)
      	 */
    - 	const char * const special_refs[] =3D {
    + 	static const char * const special_refs[] =3D {
      		"AUTO_MERGE",
     -		"BISECT_EXPECTED_REV",
      		"FETCH_HEAD",

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
--=20
2.43.GIT


--9vzXf86gJfkKFojX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4CVMACgkQVbJhu7ck
PpQceg//Q0TOOgeNk1kVjYsgvq8RFhgqpnOl52ykR569sZN9eTGu521TxB4G+45X
ad0GTKARM156LGCqtsrhQwJF2fvVUK/Ja8a41Moi9BLAnummNqqkY/VodeWPBzYo
+TRj6HJWZ/IoEsVCZDreU4ddBmq+HpD6nTLxfrWGhXmM7QOg5pFJWkKLLaaloR/5
PvdtpAOMZUXlwytyi1G9zLg7lRPYYkz+SKUagGu8VIaRrsk3H5qQEpvnKfEaWOh/
9w6T4hSadWzh1cPndQtEFAkt8SLr7mTfzY4z1ARgZ81iiicnez7JaPSOqcbHM6VS
mS7pWH2Gj3hYLqLi2JEQvGwbraGjrPxxaqOT7tATFL714rLnV/4sXx9hpBpRlGdO
oz41SLn9YAVzR5dIaS/WaggV9z/trURXKc/peyGKcd8znaQJx67M5GhLKHB2fCh9
y+9ILp+QivDHnGzAH+iOilXbylr/L5Sa8nqVsvtbNenAVry5eOZ4CruZ9VShu4dD
IBWXNtlfqLu3X/6a8dKDmAXRWLcYS8TU+knhD/A7JUVOEX1DaaQ648xcs1DgLIhA
ljS7ergGw0FH3WoeU87LiNZllQN0f/sj6K2sjFstWdSuyI9TNRUY+DBK/0HkQ39r
V9LP7AWyO6H+bDayZYxLAhOu+pnVwgGmOHL2GQX6kHVdrmmYCss=
=iZIE
-----END PGP SIGNATURE-----

--9vzXf86gJfkKFojX--
