Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JxOLS5op";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDSsWPXr"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C62AC
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 05:08:12 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id C7EC05C027F;
	Wed,  6 Dec 2023 08:08:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 Dec 2023 08:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701868091; x=1701954491; bh=YY
	+93QohqbWyOLaFhKbb50BImB/tgbYTBKLgiPDGvSs=; b=JxOLS5op7lm5OWycsq
	KNQtKfnI5hy8f/iX7jHlQn9ezuutT98xdP54PmfFpU+NBuLxAe6JXbMZ4sOqTXOM
	wta7hJnfHXCZW+lhcdVPVTkSusvcOxzFRRU4aPyq8VZktZPN4JWF/qctq/ILXj50
	k9n9B99O+ZX6dOXIFgSwxZ2vWv6pgXmX+8316jttGmwytKRQrxvG/Lv+mK3FjdxD
	ZaTKvrIEfHvix/9OGbbDFTcGVX963iQ6Ik7X8bdqHzsKh2oOu4obSHilJlBUYNft
	4/xYeyFFq5voEtCMRP08KHzpsGNT7wfuhBWqxuudo0xQxRgQudoElBPMmoh7lzmo
	kwmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701868091; x=1701954491; bh=YY+93QohqbWyO
	LaFhKbb50BImB/tgbYTBKLgiPDGvSs=; b=qDSsWPXro6o5t+yW0UbZdu45Rnf7M
	4QWbuEvIFbtgdjHHckh1WFvHzfE+3yrq0VlpAwyUgyfz4gmwEP6pxMhidmVxMOwo
	ysBLASsnQ5bzxXmrmc9RhrxrV8UhubV5K1WynMuAZo8UvXkiBF1dVE3HwI4u3ikM
	lzMrHaxmTisIRlBlC8eDs5EEkIzuDhRlaguqjK0/pPGUMCyu32Xeo9v3jr9FwQa6
	Lo1rjcMhLn7L0xO6WnJi/JgGo4vgLJduLlU8wuqAHbf1HuiUsURyZeNTPSKMmS/y
	8/ciaL3o1VxALEUlMhCX4vBKBs8Qrimv3mmqo9TANnb3DWXUThZwoBHKQ==
X-ME-Sender: <xms:O3JwZWK7YeWiogR8VdMy9qDxfXLKMjtSFa--CdM7c78MjFezd3i55A>
    <xme:O3JwZeLwRHsGsNOZkJxC09R8THSURWCVASiKeK_wIfw0a3HZ_4oFACI0IvVIarM1f
    ncPN94mccgZCTpTsQ>
X-ME-Received: <xmr:O3JwZWv0fXAs0NyG5h-KpxHv6XEUJL1myCvSm10FrIf6BagbD0WVDEvOVSM4qaH0s5BhwMwq18gOeKbhY1qZ5EWe5Jok1FZ5UEbUDxEuk1qpEtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:O3JwZbafwHC4eKTz3-ROr6sK6rWo9_6s_26o_1g2mMV6aAY3W09pvw>
    <xmx:O3JwZdZIjV1N3ne2HJ-9zwJGEVpJqry-aw1PErrMSKUNduNVb3sGzw>
    <xmx:O3JwZXDjxv49T-Hj00lqT87Sfn0Qdu14gjFWYh25PixlXuRyJNj2mg>
    <xmx:O3JwZeATz6s1mp3Ac1TVK13gpmCeRe2B9bNfQyjHeI41LnI0p8j8kw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 08:08:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2608b0a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Dec 2023 13:06:44 +0000 (UTC)
Date: Wed, 6 Dec 2023 14:08:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] revision, rev-parse: factorize incompatibility
 messages about --exclude-hidden
Message-ID: <ZXByOXWo6cIy71s2@tanuki>
References: <20231206115215.94467-1-l.s.r@web.de>
 <20231206115215.94467-5-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mOOsWb2q+9G2ovVu"
Content-Disposition: inline
In-Reply-To: <20231206115215.94467-5-l.s.r@web.de>


--mOOsWb2q+9G2ovVu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 12:51:58PM +0100, Ren=E9 Scharfe wrote:
> Use the standard parameterized message for reporting incompatible
> options to report options that are not accepted in combination with
> --exclude-hidden.  This reduces the number of strings to translate and
> makes the UI a bit more consistent.
>=20
> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>
> ---
>  builtin/rev-parse.c                |  9 ++++++---
>  revision.c                         | 18 ++++++++++++------
>  t/t6018-rev-list-glob.sh           |  6 ++----
>  t/t6021-rev-list-exclude-hidden.sh |  4 ++--
>  4 files changed, 22 insertions(+), 15 deletions(-)
>=20
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index fde8861ca4..917f122440 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -893,13 +893,15 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
>  			}
>  			if (opt_with_value(arg, "--branches", &arg)) {
>  				if (ref_excludes.hidden_refs_configured)
> -					return error(_("--exclude-hidden cannot be used together with --bra=
nches"));
> +					return error(_("options '%s' and '%s' cannot be used together"),
> +						     "--exclude-hidden", "--branches");

The repetitive nature of this patch and subsequent ones made me wonder
whether it would be useful to have a function similar to the
`die_for_incompatible_*()` helper that knows to format this error
correctly.

Patrick

--mOOsWb2q+9G2ovVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwcjgACgkQVbJhu7ck
PpQ6hA/+OwQrMAfWqxFJO3OxuepICQ9GirrfzldQI77HU+DwrzVB81tMZP/9bkdm
V7DbKf5sduVthcuPZDeE/CG4AW9Vxf8INVDBKCKRrrrzSX8Ry3DBAo6vuOQ9/RAA
3dCiT3M6VDPlfa7z+Pwsn/vSn82CwY6O+rukJCVmFEDE0Mk1hYQf6VxCPY5W6cLP
Ii6gC1jL57Why1QGzmoVQI1sFSlM9M/ba3O0y9/3KchdsS0hRD4n2iF3s4lzcLnd
BdRq5xtNA6VGGcC19FvQmFjZ2TDhiOch+wi9nmxJtHV+SawQPIfpcj+w+Z9STUbm
wzzA2HLanC+KV6Z10jGzOJaSy4ZmXGaFQf4IOtRAbqoKghx6yibxRDmQz+9sXi78
UdaWNXLp/WNSAEK5keY8qDQZUEWPXHW9/w7Pco8FHPHQ+8xwR4fxkTalh2C735p3
TpG/MdkEnCrvr1BiuCZzCiigNbmQuU4i8Tf0hfVjKDxC8A+dfEJqCO8h99+7u56f
cSiWP18ttEkry2XccHt6/ViTJxzrK+f4sHVqqvHcU/zauD/rDuyvUUX12u5jrOqt
HxKQkqDDrOEcYmjqazicqS5b/NXgfAa/kJOqwpjjDLTe3efc3otNDzuLbSvWTezZ
T++sKc6TKKsrzPFiWJNTgcxIB08IAamqUu2rM4PitWLnNQR2Wsc=
=3y8+
-----END PGP SIGNATURE-----

--mOOsWb2q+9G2ovVu--
