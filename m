Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B53125A4
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mWzW3I/f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dd/3JS7T"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C710C
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:02:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 0F2815C0429;
	Wed,  1 Nov 2023 09:02:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 09:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698843767; x=1698930167; bh=Nn
	BHNOi9hucY5UlSonC3hhtnCN1xzlDiHCccJM2fuWE=; b=mWzW3I/f9QA22qWdn6
	bNxH2JgTGOM/WA0rf3PZfNAk+HClww+F64a90C+H8FOfVgFfs7PVuX1B2z2mibv5
	d/loSn6KTci6zSYxsUldHs0rQ7wo3MjmLm/cOPiODfHfAmgfm+mzmtE94s3Tra2E
	RUj6E8e7BhJUONsnMR1HLt3IscO+gcVgy3YhYdHjqjTKO+s7sgE11kBNGGQ/Ygb7
	UUJaqjDZyJeDgll+hAY+K2xh4L+KGoGQJLFJLOJwcnM6mKg1C+SuXhQvR9CfWyxi
	92hoeeUA/5ZWkG6LSGealm40ywSN4x2MD7ADRKZP03w8P3/X1DlvMEiJlkaPJxpE
	HzWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698843767; x=1698930167; bh=NnBHNOi9hucY5
	UlSonC3hhtnCN1xzlDiHCccJM2fuWE=; b=Dd/3JS7TGOTG9kN3kFx4DFpeBDY9R
	ttpd69Is6TLNqixDhwG2aD4ycWVNC+ShaOWFH2u/4izaCJBg7VHbRdN3rHs6YErm
	rn/8A9jD+Qys2zdrHJvRSPIR9bR8Dj6He6hvVbGhpngCuCvq2sNkBCButqO+UmM5
	fyKTpA5Nc0aUfy4vwTTz4Gk2TbGF/jp3YSreyXAFIsCAHlt4a5m9LLV8VRpJHABu
	Sa9IVuXf57ohScUpHN35yKVyRnmkwF8nx0+ZGLEAJYzPUXImEhxuELbqJRP0wOTU
	6AMnUJAxv5230jql97Btplp8hHLRc3XekUK09MDCvpn4l32Lg9/scIIlA==
X-ME-Sender: <xms:dkxCZV81W81Ud8G8Sx44OqxA0YDljMHozxswYGtZKkGw159k-n903g>
    <xme:dkxCZZsvUz8cKyQZmDzkfByzrcs4u1Yk0XpWBsDghC-jyZYd0aWgZ5k_Hnf-qu9Iy
    jC_BBMJfdIe6grCLw>
X-ME-Received: <xmr:dkxCZTDfdPdUNLzt_ZH2do_rAZL1M2V27lRT436Ij8ntfTRDinhVKWCum1SqlA-4liahUilgoX7VToTEEixHzLFStc0fO3uMgIqqr3PF_Prptg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:dkxCZZeTawK5wiIpm_h5SDY2Dt8Q55bArv83c9KQ2gB7nWyjW65ajw>
    <xmx:dkxCZaNF3-tlsV-q1iZV4J3rrsBQLsVGZP0ssYqDw3iFDDcp5oUhCg>
    <xmx:dkxCZbm0yxOGS5fY1244ERse0pGZwEvfz09p0kyL4ORg77GXI1BtWQ>
    <xmx:d0xCZXonOH0Y-WIzVHXan0GAGrX29WPDHRXc35SRz5FdcspF4lnXSA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 09:02:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e736688 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 13:02:34 +0000 (UTC)
Date: Wed, 1 Nov 2023 14:02:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 1/8] ci: reorder definitions for grouping functions
Message-ID: <0ba396f2a331ce1e9f7e7122e13dc683e3ecc752.1698843660.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698843660.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A3PSJ4HlG0Tp7FCA"
Content-Disposition: inline
In-Reply-To: <cover.1698843660.git.ps@pks.im>


--A3PSJ4HlG0Tp7FCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We define a set of grouping functions that are used to group together
output in our CI, where these groups then end up as collapsible sections
in the respective pipeline platform. The way these functions are defined
is not easily extensible though as we have an up front check for the CI
_not_ being GitHub Actions, where we define the non-stub logic in the
else branch.

Reorder the conditional branches such that we explicitly handle GitHub
Actions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 6fbb5bade12..eb384f4e952 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,16 +1,7 @@
 # Library of functions shared by all CI scripts
=20
-if test true !=3D "$GITHUB_ACTIONS"
+if test true =3D "$GITHUB_ACTIONS"
 then
-	begin_group () { :; }
-	end_group () { :; }
-
-	group () {
-		shift
-		"$@"
-	}
-	set -x
-else
 	begin_group () {
 		need_to_end_group=3Dt
 		echo "::group::$1" >&2
@@ -42,6 +33,15 @@ else
 	}
=20
 	begin_group "CI setup"
+else
+	begin_group () { :; }
+	end_group () { :; }
+
+	group () {
+		shift
+		"$@"
+	}
+	set -x
 fi
=20
 # Set 'exit on error' for all CI scripts to let the caller know that
--=20
2.42.0


--A3PSJ4HlG0Tp7FCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCTHIACgkQVbJhu7ck
PpR3jg//QDGXt7XHoIx31gh62/jvHh+5ioyNlBUAPY/0Q07L0IcMzvmCcmr5KTC9
e2BJox2OTdo5L6HX8ZDjOw7VH40Opowzg8t8XwOq6puMPa+6lu5OXJ/xWqVT/oFL
KhjBekWEFRNlvxmvDuE5kuauWpa4eLzOMSDT17NEXGrthm1c+RecoZn8RMtb+p4c
haQyQ0JmIeSCuoZ5QSz4D4fqZn+bmIgUhYNcsvrOeIDtrOBhFgfa+hrn/10PNP8B
Uy7m9xlnAFr5FOowhYM2tbqakE8ARoDopkkfK9GS2CY1vm7g52r3YurThJu0JgGO
mF8R5IiPXD6IaA/unyEHYbWWOG4H5KJ0+loKlOCL1xagUvmDkP/hb+8QG4OvI5DR
Eul0fs9oZkLI3cXqS35V2zNiA2jY8yERni6xra1cDI/BCQz2d3s+XZ1YAcsg7iev
gNwglwtAZEN4bM7KI/W38i4PGZJKnns3ENtdPIIiUB5CMe0TGeXBnAe7x4F35snX
8IgjsabSiQVp4zaLwcOcxng9RERmNGWlufm2Unj/XcYkE0UKscMoOkkgAxSnn2P0
001KIhAJBdYT9PU+ipzFQvEKyPYvhSXblj1JURQDLR74qrrae35OvWqpi23Hb3YG
XmLkuiUfI/R1xZxS6P72jBe03p4xLaaRnFi8MTanXnAUTKsgb9g=
=J6vs
-----END PGP SIGNATURE-----

--A3PSJ4HlG0Tp7FCA--
