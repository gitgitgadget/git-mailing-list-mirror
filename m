Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384B11182
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FTMeVlo7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZG43Ak/I"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B3FDE
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:10:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 2A8AF3200A79;
	Tue, 31 Oct 2023 04:10:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 31 Oct 2023 04:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698739829; x=1698826229; bh=lw
	CKpDZpBLxusPbn1C4HOpnGE7TCUSpLc68Bs0FicJE=; b=FTMeVlo7O3ygQvis3P
	l/ETkrP83ql13/rp1tLSFSU6vSJDocaFaY0dIgwM6sTZeMd9Gcom1g8cs2MgLZhB
	IjDCe10vIJ6raUfr/LeLCf5jeiAsmt3z09BCtKpYA/c6NY2Yxpe+bP/ffdQth+Pl
	1CU1xXpleOIgZEFHc0yMy9S4xY1Snrl57ZPayJeXVO7RcNlEHL3m5zdATkDm6wn5
	ePZ7tiXUqhjRDkYa8JSzjnb1hXHrmBR1VTPeQDqZWQGxsk3Ctzb1CYGrw5WmxnC2
	iewm3Qs6ESqTF2KrBhgHen/kJEtV5GsO9URu6AcLetH+LNehbEwbJArkBfx4VeaA
	S2/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698739829; x=1698826229; bh=lwCKpDZpBLxus
	Pbn1C4HOpnGE7TCUSpLc68Bs0FicJE=; b=ZG43Ak/I+XaLH/rzP1V084oDN5VZH
	MwbvNc4n2EX67n7BTvKRpqCzeld2XWZVvNXGsaPFlmHwcUR6venfRLGVY3+J8VkW
	U7I8KJy2V53LeiLLB1HJ6pe+ZLauv4p9s4vUYB2CmjA4lwaqtB+4vgbklECyxbD8
	OIfPJkT28l/TPgCid1VkjFrXdcPaFglKLqSx7U940lU4GLEt8GtNsDwGxxxhrGgG
	U7RbXTN1p46ucOD9MyDeLyQNxJEhOzsIj5wKCGKrvZIpHzHDgMbJILZ0rGfszDaD
	/VFknR9ai3zmwRcLP8n8vB4c4ZaIb9jfYuIXb64E/bfmQ+8+ur7CyVauw==
X-ME-Sender: <xms:dbZAZW12SnHKMybI5O6fLO0m1juXwV9LssJ-hiqx_DCPE2FwWrhZFw>
    <xme:dbZAZZF2jB2MZV1rQhT6ym8nBeuHYFgbL7Fd5z8o9k_m_G9oPR4kWJavskAVzecmT
    UtgCKkcunB_nYCy4g>
X-ME-Received: <xmr:dbZAZe4ZYcqic0Ke3COG8XhKzTgbNU-Q6phL5wyAZ52-mVl3eP1Qm9984MD9SY1m99wXeQfD6gjm15cZed7t7LmV2PzvHZ4pV2pPiObmEA4Z2Yl7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:dbZAZX1K7_gBwY5Aii-zteBOEsAs3Rvhjk3R7Gjln7WnDpva6pmaDA>
    <xmx:dbZAZZHJTkj777jnPtSr4PeWv-Css97y2tUu44aPdSmiy39AbNzuqg>
    <xmx:dbZAZQ-1NqNObenvVGVzJtO1pjDLYltIPtHpOUV_efa9LpxRgcfooA>
    <xmx:dbZAZZANVWaFeM3ocm-teU50eAqBjrFpK-SUj0r9tycufzLAuIlWyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:10:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56ae44a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:10:19 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:10:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 05/12] builtin/show-ref: refactor `--exclude-existing`
 options
Message-ID: <ZUC2cXiS949_7r4s@tanuki>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
 <bed2a8a07696371e07c0b2d1282ed51c0b1b9fee.1698314128.git.ps@pks.im>
 <ZT/32jI62GQKPlcp@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S2WkdIhrZF//32mG"
Content-Disposition: inline
In-Reply-To: <ZT/32jI62GQKPlcp@nand.local>


--S2WkdIhrZF//32mG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 02:37:14PM -0400, Taylor Blau wrote:
> On Thu, Oct 26, 2023 at 11:56:37AM +0200, Patrick Steinhardt wrote:
> > It's not immediately obvious options which options are applicable to
> > what subcommand in git-show-ref(1) because all options exist as global
> > state. This can easily cause confusion for the reader.
> >
> > Refactor options for the `--exclude-existing` subcommand to be contained
> > in a separate structure. This structure is stored on the stack and
> > passed down as required. Consequently, it clearly delimits the scope of
> > those options and requires the reader to worry less about global state.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>=20
> All makes sense, but...
>=20
> > @@ -19,8 +19,7 @@ static const char * const show_ref_usage[] =3D {
> >  };
> >
> >  static int deref_tags, show_head, tags_only, heads_only, found_match, =
verify,
> > -	   quiet, hash_only, abbrev, exclude_arg;
> > -static const char *exclude_existing_arg;
> > +	   quiet, hash_only, abbrev;
> >
> >  static void show_one(const char *refname, const struct object_id *oid)
> >  {
> > @@ -95,6 +94,11 @@ static int add_existing(const char *refname,
> >  	return 0;
> >  }
> >
> > +struct exclude_existing_options {
> > +	int enabled;
>=20
> ...do we need an .enabled here? I think checking whether or not .pattern
> is NULL is sufficient, but perhaps there is another use of .enabled
> later on in the series...

This is the second time that this question comes up, which is likely not
all that surprising. Quoting my first reply:

On Wed, Oct 25, 2023 at 01:50:44PM +0200, Patrick Steinhardt wrote:
> Yeah, we do. It's perfectly valid to pass `--exclude-existing` without
> the optional pattern argument. We still want to use this mode in that
> case, but don't populate the pattern.
>=20
> An alternative would be to assign something like a sentinel value in
> here. But I'd think that it's clearer to instead have an explicit
> separate field for this.

Anyway, the fact that this question comes up again indicates that I need
to comment this better.

Patrick

--S2WkdIhrZF//32mG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAtnAACgkQVbJhu7ck
PpRR1A//RV+7Ivb1EuGUKsqxt4wXdvj7ez0UVtHWHDkgdZRv9cNRfoCHAfJi/NGq
mQyvQXHjmfgj1ncbh4U5IVZk+AxOPkgA7Nnyt3nh90Buewchgns/zvZNX9SmXlqg
lmQ91d1s8zh+ltADWxqKmJRrhgiKsCUcqsUVdJ6wZSfI9Y18Ja3XZFb6VfG88CPA
ouFtjJZQ71HOFQ5fDpNoW51GOQ5d/tgvCAQalIVcBHQ70SgKQSRfYvyiqSqhybC7
tvw5tmibpsMyOIFNAyducWyed4ymbMp0pHqshHyJMDL37UDwpZgFeUEAEq+aguu2
4RnopOfOCQ7LLH3V0ss5ab1IbG0z1zaQv18Ir+ub26lxT6Kw7vaIto+BE5HYIkKF
G0r8/v3hH8ktQ+l+I2NQBm94RJ/W7hiFJpsFVY00G36c6iD+xiyK5IXESrqV70KR
RFmkytlpboAXlj3FnZpM7T2bmORGGlPyeWAABFkXM28GjtKn7rpw4KTrOfwmhjC0
FZgAjtPSKkoh9EcEbAPr+c1TtKgOXrY3qYlXgebJyUANMPbOw8g6uU1cwZIo0s8M
rlnwfQpY/fq4YPfw5LQz7JfvSF1o4BLTmIabTHX8E5aJgWR0hHkGAdifgseMIhCm
Hzdm8a+noTs7nzYlvpMsMY0IZmsxAP9zMqcgOGYlI9MUc1AQR7I=
=Jwcj
-----END PGP SIGNATURE-----

--S2WkdIhrZF//32mG--
