Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="poigMU2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfQIiHWE"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF8219A
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 00:58:07 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 297643200312;
	Thu,  7 Dec 2023 03:58:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Dec 2023 03:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701939486; x=1702025886; bh=b4
	YMTk5wiixeVQRBO8NvtC3qenp4aNtQRvhY5W2kBRI=; b=poigMU2pP9CL94Qnrm
	aP+XRCsA+/7u0Bsanc8A1w0rtnK2W0T8k6+E4cST9f8HaoZM5L11WHbfjkM3hrfK
	JoyCmWxSfOxYMVS2VUjh4WpDD2fp225EOKV8t3Esqtk30JI0HAaYivFTm2zzFhWj
	4W8WMjsFNukspO5DYqvtCvyo/Y4QKLcba9drXCBaIl/8tcI6wwS1bU/4JUjQ7vcA
	TepM1/KHRakDAJ26pgWQsrw3FZ+QbaHbsBPKwx6szaRiVLCCNk7Ep7wt79PLWZq2
	zskr599+n/4a4+pJF7sENFo+uaF4w/JThdRDFPBPLNj+7WlqPvMF8Zgkb+L2vEvh
	xQSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701939486; x=1702025886; bh=b4YMTk5wiixeV
	QRBO8NvtC3qenp4aNtQRvhY5W2kBRI=; b=lfQIiHWE66RZ4HZ8ehqYmt2yshycO
	uttAAVdukXJZqlfmQWymYIkkB4spuYPP9TWiBEiFBITU75q9spoNQ+LMBX8prgba
	abqxCUIQTHMXVpSEx0ZoafF6+Jd/UVtN3LV29usB2C3mx6N3dEEnyz5d7aHG3s3i
	L8MDBSstkaUq2KynZKtGIhn58UhqeCIBvEkjdvagL7NJvGN2Kih1niOo35609SHY
	1h68YEpRpoQ5ep7FbneGVXJURdOXIzb6ApqyY505WlRb8Gsqj+Ee5PnCNUWB6gRb
	69edFrZRmbos0ZZNav3ogXljGuRUGf4nP+ciyj09YpF6CVDUH8zzMAkIA==
X-ME-Sender: <xms:HolxZQ4tUfXfeWQAdI_cTfh02fKHCpaGdlmbLB_GTXB6rBtf76nLow>
    <xme:HolxZR7f6FbRWjF5P7jmB6k0VfCSmYE7Kn19hBakpzyQSVUG1dtasQUIAkjajUfjp
    HKJffrA8dzr8_feUQ>
X-ME-Received: <xmr:HolxZfdLpOSyWLD23_I1t2VjtmoB190HFCTIeWECgBZzQ291aY3_euNsj3NON0Q_2r5xX6Yc7gqI49poCOIEOvFwkGVZ1qm7mKdDlOUjCCUlRkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepieevkedtgffgleeugfdvledvfedthf
    egueegfeevjeelueefkeegfeffhefglefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:HolxZVKuy3SLNekgSMo-XoFoU3cNXUi-BMg_q2tWGMmSffHdoIacTw>
    <xmx:HolxZUKpMsXah_OxeQ4IUm-ZyGl2ebuQ2DgnguHWlnVysGWsdAlnhQ>
    <xmx:HolxZWz5YUCxyMJ99V52GB4yEtiAYogFOIkk9o2h9_6myXFaMeVZpA>
    <xmx:HolxZexQXBCN4HX_OZp9lSJWzzZ65_gHN7mg4aBZiQ719Hot8MsBRQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 03:58:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c357342 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 08:56:37 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:58:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] bonus config cleanups
Message-ID: <ZXGJGv2i1WQRjVOl@tanuki>
References: <20231207072338.GA1277727@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOT1Gv6Ia59JTS/C"
Content-Disposition: inline
In-Reply-To: <20231207072338.GA1277727@coredump.intra.peff.net>


--BOT1Gv6Ia59JTS/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 02:23:38AM -0500, Jeff King wrote:
> While looking carefully at various config callbacks for the series at:
>=20
>   https://lore.kernel.org/git/20231207071030.GA1275835@coredump.intra.pef=
f.net/
>=20
> I noticed a bunch of other small bugs/cleanups. I split these into their
> own series here, which should be applied on top (it could go straight to
> "master", but there is a small conflict in patch 6, as the option it
> touches was fixed in the other series). I'm happy to prepare it as an
> independent series if we prefer.

The whole patch series looks good to me, thanks!

Patrick

>   [1/9]: config: reject bogus values for core.checkstat
>   [2/9]: git_xmerge_config(): prefer error() to die()
>   [3/9]: imap-send: don't use git_die_config() inside callback
>   [4/9]: config: use config_error_nonbool() instead of custom messages
>   [5/9]: diff: give more detailed messages for bogus diff.* config
>   [6/9]: config: use git_config_string() for core.checkRoundTripEncoding
>   [7/9]: push: drop confusing configset/callback redundancy
>   [8/9]: gpg-interface: drop pointless config_error_nonbool() checks
>   [9/9]: sequencer: simplify away extra git_config_string() call
>=20
>  builtin/push.c      | 31 +++++++++++++------------------
>  builtin/send-pack.c | 27 ++++++++++++---------------
>  config.c            | 11 +++++------
>  convert.h           |  2 +-
>  diff.c              |  8 ++++++--
>  environment.c       |  2 +-
>  gpg-interface.c     | 15 +++------------
>  imap-send.c         |  2 +-
>  merge-ll.c          |  2 +-
>  sequencer.c         | 21 ++++++++-------------
>  xdiff-interface.c   |  7 ++++---
>  11 files changed, 55 insertions(+), 73 deletions(-)
>=20
> -Peff
>=20

--BOT1Gv6Ia59JTS/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxiRoACgkQVbJhu7ck
PpTMoBAAnbZ9fHtwfOYY7XF3Ka8Cv0adW40qlWBFyUtFKuhIBneNytjmO9DbkRgd
+0waKVm2pHCss+xgY/PliEvpSIb8q6JG1fbGgAOPQPHTQM0gDmniTlOLll2p5eOa
uh3Psft48BhiNtLnIbTt/bYFamubBP09cHOyfu9qoy/Q3KV9Z/yK9QxqHJzYAgtP
c7Th3MulaxRK1VZ+rV7ZHOWrWq5fDzy0AeH3xCNBwvhmnjYzvOwAc3fFoB7M9we7
jNc9SzormNVNyS/ZEKSMF+H6J5gSUf6Rw5Is89YZPcKtAgVsBLhoh5byBrbSXvv+
OQJqkODYN6mmrnoBwv1O4ZojymaB8WtJsm7/M24218E+eVmPoPPQw+6YtOnFhepG
Ap0U4OwcjVHF5MaB32vaCWkGSVkZEGT8WYeCE4E1cMnTatxzW0VsmTR1V4GQHH0T
dfGx5rxiSJY7cokUoXGDyOJeQh9W+hK8kYA1G/EEZOouO8TxKZnnHBYv4J7eMsAH
QgMZcORgoZkMZxJlZlZDBACoGSTWZI+UtwkzurJSAbNV1c2C9R0oRvIsouW9RYRE
+dYiR2VsUZ5qa9ysz9Abx0SNkX5O0ckYDUBpCs7/B/sVDIfcsSIAk+bo5mFsCW0z
Xte9BLc32KZ/NNAZhqdofT7d2+uhFaWP7MOZ6lvT1C3qXvEFDyQ=
=FVrI
-----END PGP SIGNATURE-----

--BOT1Gv6Ia59JTS/C--
