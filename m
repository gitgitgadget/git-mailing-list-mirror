Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3A15EA8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z4JG31gz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebZf67fJ"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F12C9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:15:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id BADCE32009BA;
	Mon, 30 Oct 2023 08:15:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 30 Oct 2023 08:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698668104; x=1698754504; bh=jK
	Qrnie4M5x5j1pDKTv4+KP5ezHU70EmoEkBjqL1qUo=; b=Z4JG31gzM0PMqmjMJ4
	R3spjewP5Aod6wEd853gy7hh8gfJK/7Y0qMrH8bloLAoSSp3C5OvtiibFuel2/6C
	uuWia8r8GeOwJpHw9Ii6s5ecjwbYEaLf7NAPy4bKbxbqcFH4b1LSOVtSNtaW97IG
	62/CxG6tGEohAr4rkq/2yVnwi2cXMc9482ma4bXVgpJHy8uZxs9iK2o1REnoylBY
	GJeeQJG+cDa0sr8ZT3sJna6DqwuuMVbhM5WPzLXMsrweMby8dMpxyGE08GFmSRKq
	OKdKtVUHonNCuxtauaHlWxLE49Px3ySBLBjUmHJjSvgIbgYuJI+tgMsMyqqDE4Vq
	FmXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698668104; x=1698754504; bh=jKQrnie4M5x5j
	1pDKTv4+KP5ezHU70EmoEkBjqL1qUo=; b=ebZf67fJDKk0YDXIXcx4VD0Hyp9TR
	1764oOv6XFrrIjKp/JQpmj3HwbtPrTe+ywTfqeTwsk4wwMKXgVGt4TBXYulgcng3
	IMIXk/1tSJH7vp1pX2lW2d8EEFan6SnB0Ge6Lh9Xlku0722SwOcdYW5wwgjh4Ozd
	KMzk7luvGuehmoPLj4dpUYNbj3P3nJn+HHeT5BS+jGRcQNL6s3c5KUU3eqnM8xJw
	ad5bMGGV6F0JzN4rwXcCLq3XhBTSaZuPZfaithP/cwLAId5x2n8eNyJHTsYzsK7Q
	GoqigXJIP2H84zml/g1hwEWLXKRTf6+lyrOouSBmcm19/fkQJCHRnCPuA==
X-ME-Sender: <xms:R54_ZbUKTIaFfx7k4du8G2l_iI1BgIo9jy4qiPvfbU_mQaQHJodVBA>
    <xme:R54_ZTlJ0ZwGkU9C9SXUdpEuIOScJkH2SsPx4S8McHP1GcSrZY9ugcYOyy2lwRezZ
    tqhbB8my9ECwqCb3A>
X-ME-Received: <xmr:R54_ZXa70bI3zunmS31lepZnhYH6Y23-5M0fZpMY-ypQzKGZlJGPLO_NAN1FY_gsUIz5xWBLM6ITU6ZIw8LmVurm9Hjyb9VR9AFS6drnc6FRnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:SJ4_ZWVBZPtdnVqT4Wn3LKl43DfFjtJDFYdAlI8_FXf66a2YUX48uQ>
    <xmx:SJ4_ZVla0Df3XoP7YoV5iwQzIHsYfIfj55uijPstQNYlIEPcMS21Zw>
    <xmx:SJ4_ZTcK1e1lohw2VuLdo9Z-tqEQmddXHd_oNDjwcSvmxKE_KvTQZg>
    <xmx:SJ4_Zaz5oKyLAK1TdM9pBcYrafM7QwUiaE5g-I0OgR2eChjm6YoiGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:15:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e0edf0dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:14:57 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:15:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 5/8] ci: unify setup of some environment variables
Message-ID: <6af0075fd875f176e7fdf6c219e7117dac5cd71c.1698667545.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9k3+mFJvGTdTMS3z"
Content-Disposition: inline
In-Reply-To: <cover.1698667545.git.ps@pks.im>


--9k3+mFJvGTdTMS3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both GitHub Actions and Azue Pipelines set up the environment variables
GIT_TEST_OPTS, GIT_PROVE_OPTS and MAKEFLAGS. And while most values are
actually the same, the setup is completely duplicate. With the upcoming
support for GitLab CI this duplication would only extend even further.

Unify the setup of those environment variables so that only the uncommon
parts are separated. While at it, we also perform some additional small
improvements:

    - We use nproc instead of a hardcoded count of jobs for make and
      prove. This ensures that the number of concurrent processes adapts
      to the host automatically.

    - We now always pass `--state=3Dfailed,slow,save` via GIT_PROVE_OPTS.
      It doesn't hurt on platforms where we don't persist the state, so
      this further reduces boilerplate.

    - When running on Windows systems we set `--no-chain-lint` and
      `--no-bin-wrappers`. Interestingly though, we did so _after_
      already having exported the respective environment variables.

    - We stop using `export VAR=3Dvalue` syntax, which is a Bashism. It's
      not quite worth it as we still use this syntax all over the place,
      but it doesn't hurt readability either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 9ffdf743903..c7a716a6e3f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -175,11 +175,7 @@ then
 	# among *all* phases)
 	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
=20
-	export GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
-	export GIT_TEST_OPTS=3D"--verbose-log -x --write-junit-xml"
-	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
-	test windows_nt !=3D "$CI_OS_NAME" ||
-	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	GIT_TEST_OPTS=3D"--write-junit-xml"
 elif test true =3D "$GITHUB_ACTIONS"
 then
 	CI_TYPE=3Dgithub-actions
@@ -198,17 +194,25 @@ then
=20
 	cache_dir=3D"$HOME/none"
=20
-	export GIT_PROVE_OPTS=3D"--timer --jobs 10"
-	export GIT_TEST_OPTS=3D"--verbose-log -x --github-workflow-markup"
-	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
-	test windows !=3D "$CI_OS_NAME" ||
-	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	GIT_TEST_OPTS=3D"--github-workflow-markup"
 else
 	echo "Could not identify CI type" >&2
 	env >&2
 	exit 1
 fi
=20
+MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D$(nproc)"
+GIT_PROVE_OPTS=3D"--timer --jobs $(nproc) --state=3Dfailed,slow,save"
+
+GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
+if test windows =3D "$CI_OS_NAME"
+then
+	GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
+fi
+
+export GIT_TEST_OPTS
+export GIT_PROVE_OPTS
+
 good_trees_file=3D"$cache_dir/good-trees"
=20
 mkdir -p "$cache_dir"
--=20
2.42.0


--9k3+mFJvGTdTMS3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/nkQACgkQVbJhu7ck
PpQTHg/+MBuQoCfF0eK63pAqz/muLFNxwJrJs6p1mpXFZ/TmdiTiFPjTv76K5evS
J3aI3ZAkSfbhJhenxwklRCJxTSHO6wX/DFqh8A9tcgVzpWze6xBDT3/KzI7Pxjo4
kR1PaUTShCwapx3GzJn2KiefPXsgK7WDectLNrFRZbOZrMW3f6lQ+qe0u+cTYdiX
C6UY98rAt9njWDqe/moNBKWzNE4MhwoZ7L3NwXsEXJi30piFlrnadGVTfxO9b3lX
wllxU71wLVhvCCiSo6dWFUdwZn24/0ve3dqKwLkGh26/6RxLUfacpLf+jCkhlQyc
tLVfA5i5BOTHVYq8vV1/yxZNiBKztfAI/MFq+CLxhfEfPlKdJahh93YxI5k0x85U
mJghj5fAjQ7ByGDahoi+52kPNiS0hMW3Gl350j5E7M3VRgHo85vjFdM47V304v7Y
q1av0yb1icSotL4SkVSwx9tU+T2e5wuvAtQ2sngd1d/h7olNfqlgGmndxOz+44H5
kpI5N4S2HpwfUV08gIR+BQ9bPRE5BPV6ETVpt8pxHGvuyYe2n1DggJ7zke5lOvnp
CAyxSdMQYJOxdQhT+m/Ye42UAVOh2/4R4j5BnJU+k0pxuuXl29zHyPvNA6m6U515
dySIriOOKzzf2Jf8UTFfWiwVjoBeIF84gbTLpB098Zgi3jMnbdw=
=aDzw
-----END PGP SIGNATURE-----

--9k3+mFJvGTdTMS3z--
