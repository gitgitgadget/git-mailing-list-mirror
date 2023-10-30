Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B17156DB
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jim0uzko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZAe4T5w"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED45A2
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:14:56 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 1DB1F320093A;
	Mon, 30 Oct 2023 08:14:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 30 Oct 2023 08:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698668095; x=1698754495; bh=Lk
	QAu2zM6yIi8eCNUjGipyHY/7oos4+Ssxi0pY25KFs=; b=Jim0uzkofBOcYtX6mE
	gofHEDkwOzGt371Mvlts8yKCjJrlrzVQM5D+ty6F1Vu4tqdbfB4w7SugTu9SNL28
	5OCqObk692nX27HuskOyAyVytkr3l5Y7h9ucl+VjzYpuNLw8vBe+9LuE9wiwTEEQ
	S23PU6KJCSdhaLTbBsURM+FUU/nZqJE1f1Jw3zCw5z0AJoSa6TECaWg2B90qlB7X
	ln4j1lTjAH0IK33u9KeuQ6lGULC2DaTuwWNS2YgfLv81pwS39FXqy67Z6hqA7rfJ
	tpxufRwvJC7Mz0YP2Oa/5Kpn7g3G91/87pZ4CvM2Y0tnGYsK36IetW0IpeX6vwUN
	Z8jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698668095; x=1698754495; bh=LkQAu2zM6yIi8
	eCNUjGipyHY/7oos4+Ssxi0pY25KFs=; b=ZZAe4T5wkpkG4IlcLYHo9gwKoco9p
	lks3r1Hr4v088WZcwoYqCwhyJ5nyiL2o0WGn/bT2lRUBLgwNjb4Vd07v6PYFP+H4
	6IzKmmWYk0qIR3jhf+5CqgpyE6TVZiTeBJfFSFdGYTDegcbgyAqkBGl6nP4RoEKT
	asqgeRXPJmVGp0Y1lTEp0Scv3Lmxtyve/8aWNo4nYlEyZg5A/bCJmLN3N5ez5oZC
	jK2iJw9EfLr6zJsUpCsJ4eZjO4R+TVGLygXAZlUD1cwF1v/f9xgsMgYPxorpq+HC
	tFz88lp1websiZhqaHAMpJhW6UvZ4Lwfz/k1tEfNKgnn54RUqufLkyX9Q==
X-ME-Sender: <xms:P54_ZTHBL9qIdZCpXi0Ok-l9X2-lKKHPKWGr3voDTpnxf-50ObAZ5A>
    <xme:P54_ZQVkCa2pZZNtdpGhfwg76h2Hemr4cDBcg4UvtCXD_LHT_EGcPUvdvS0etSV87
    E9sRvnryYu83c_17g>
X-ME-Received: <xmr:P54_ZVJs2J4D5lskueth8PQSpsO0yQp-5EhHftRJZ0-SwMkgJOfl4IueJCPYirxKn0q_IqI7_n_-AzXxMI1H0FHFcsSOGBOtbnRUej1Ai8OAGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:P54_ZRE3808HhfhiwXifoqzYmBEiSN0_rPKtsN_bLr54HcxVpgUZPg>
    <xmx:P54_ZZV890tzHtcB8O9HT2Ag7STp12d5V8GDhmeMXEr2KvJIebTqug>
    <xmx:P54_ZcOFkELvqZfGZIVfoUUYeMVkr9tMQLSOAqoCF6TrGVseWxc9DA>
    <xmx:P54_ZWinm8rZrJVrDA4Add1qZiFlVvNJM2QbvXoUA6jlpAXcFsJBkA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:14:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 555056a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:14:48 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:14:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 3/8] ci: group installation of Docker dependencies
Message-ID: <4542bd38dc270735f5a2674cf058f008746adb53.1698667545.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S7RxsPh5WTo4TUph"
Content-Disposition: inline
In-Reply-To: <cover.1698667545.git.ps@pks.im>


--S7RxsPh5WTo4TUph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The output of CI jobs tends to be quite long-winded and hard to digest.
To help with this, many CI systems provide the ability to group output
into collapsible sections, and we're also doing this in some of our
scripts.

One notable omission is the script to install Docker dependencies.
Address it to bring more structure to the output for Docker-based jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-docker-dependencies.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index 78b7e326da6..d0bc19d3bb3 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -3,6 +3,10 @@
 # Install dependencies required to build and test Git inside container
 #
=20
+. ${0%/*}/lib.sh
+
+begin_group "Install dependencies"
+
 case "$jobname" in
 linux32)
 	linux32 --32bit i386 sh -c '
@@ -20,3 +24,5 @@ pedantic)
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-de=
vel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
 esac
+
+end_group "Install dependencies"
--=20
2.42.0


--S7RxsPh5WTo4TUph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/njsACgkQVbJhu7ck
PpTOWQ/7BozbQVMfDm/cchDksJmqAr7PC3foimM7DPxKdqC/YZST7QDyYJy6RiWz
2iu9UpavtAfdZog2xWbNN9cTMHn1aPIWfw2UkB+HV50fkNR1p6bSXY8sLfDrrRXI
S5R6kDOhTuIW3gVAatYZRVScejCoqtGFyuuL0SjqL4kwXw6GM+SWc7B3H0EWj/u5
js1e6EAMAqgNwYzWi7b1rCnepdc24C2/JiK2dntEnAZif8CrPtwsSesBPRHqwOpZ
bxwRKV18SMphYsqsS60/Hc5M6iQNhV7fMmg6/uN3F8XeYAxOHdVnrFR+xoHmRI2C
HYiCD7m7/kza8f0PU30VS7U/HFIKug6xUbvPwL7T897izWxJsXoZLqzlMGkvlarL
vyG33EBPKldEFmOjiRn5U4Q9ryAUZhs7Pa+LlOhxS2F3K2xvRQx/v57N0/sScK1W
HyvGPCwoqsRRUs8j94mDjYrs8REAS/jjXOODuXG4M2MW07kLwto1MQsATWGn9KTm
s4aqdJHmg/Exi/fMj8NNYlhQXjqXodtW3Lz8QXcIxNYu1APf7T3VefFmuAb3Eaz9
s7ztb6lSDInRMp3avJWSJcq46hiRIkGL3GLKM3ZhmRfRLtpsZoVdtYoBVN3ttEgu
/HPvmgs1XJ9Qsp5PVT0n2GorGMOzWViWKokI8ssEdSX00wYWHPQ=
=VHUP
-----END PGP SIGNATURE-----

--S7RxsPh5WTo4TUph--
