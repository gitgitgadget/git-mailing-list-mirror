Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28895107A7
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I5i+fAEk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSV0GASA"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CBA2737
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:05:46 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 2E5C35C00AF;
	Thu,  9 Nov 2023 03:05:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 09 Nov 2023 03:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699517146; x=1699603546; bh=JH
	pYKYqWshZemfp3O4IOsX8EMLCvaeb3zpp1pDgysvQ=; b=I5i+fAEkJFKNsQsAVu
	odtlJ5xphV4Fu4LXmvj7KxmBVAHE8UW388FUS7l2xi40aAFA/UekYERbd9uPVxKk
	wxTNd6+Trmv1nkioLe3m1K8r9gnI8W14/2bwP8VnkfIU+vcwAOwsAsyOPfaGqE3a
	tBesJB0qmeLXvKEWp9++n+CHQ++61f3qprLTKG21D1IKkynv0Etsk9UbMJWxenQo
	Mk9iHI7a7qSEqI+8N/KiFC1XCt7MHbS3AYsMepEgG0F6XqnkaLnVqI1J4HUkt61A
	ajy9b2MRAuhy2lSsTllB2OQ80w760S8U1HV2KW9W1BQRyA+QEaqlu+8IRcNBnjzR
	GC7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699517146; x=1699603546; bh=JHpYKYqWshZem
	fp3O4IOsX8EMLCvaeb3zpp1pDgysvQ=; b=SSV0GASAyTMzt3A/59l+ipfA8ZzXn
	gIkUyNutgGcPDvL3wyGwa/nvODs63o1MgCFQhdnPLLEkmVxYhGLSF3PNBMW4iTw9
	HcPKd+0jfZy9+B8/FGZDXVgWv/PS05+kET+ehEzV2VAamJCoVRL+/IFV5tpfSnRk
	JNpRghfRRfPBAXAGj0iHD/c5vx1p6TijA6M+leAFyJzee1mf107znnKyY2RMXjvf
	iXnHXuRAmRQvfMg2KTUTL+XbmvfFwS9WA3CVzjLO/A/t9wpcDzbL/C06WNBy9hbu
	T7RYI3YuikamMNKefi5kUgc2I+EyvJjgUvToWPKrASoJeiNGJAUuq0bng==
X-ME-Sender: <xms:2ZJMZe7LAFIJDRVQdGq1gFKyYcq02wszH3wd-dhT_b4BmXXb7Gxeew>
    <xme:2ZJMZX7E7EwQ-i9cQdo0IL8g1l3z_gu-kG0c_OM-IhaD3kWx0PPjIeZonx7uzHV1F
    e2VhX-C7MQuiMODiQ>
X-ME-Received: <xmr:2ZJMZdc14dhMkP57Uqq-Jb3fLZ0vml52JusOOK8QeiNkWQoPq2hFUa2BqXXCl1bR8wajTw3-uQO3f4SXWFpB6mNnMxOHBphNWN0kLuIxB-WTaDi2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:2pJMZbKCWge4fonyF5UWwNDQTUwHl1rrP6t-PdxozX6hiMxxS3yKgA>
    <xmx:2pJMZSJWUYeZprzFnuWzhEsAA3fSvr5TpVHF-VbHZZPPT_2raISysQ>
    <xmx:2pJMZczUQhVroP9HH28VODGqG5519aFGSAUl8e_hmsuOgc9PITMpQQ>
    <xmx:2pJMZUgVC3O5RcIcL1wghucWN3tyMgz2Xul4DN_WtDFn_tVzKHnv-g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 03:05:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ef5b2c82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 08:05:17 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:05:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 5/8] ci: unify setup of some environment variables
Message-ID: <486d4bbf8b085d98326fd1fb1fe82d463ef7af7f.1699514143.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1699514143.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xg23xdfdSK+5jAW/"
Content-Disposition: inline
In-Reply-To: <cover.1699514143.git.ps@pks.im>


--Xg23xdfdSK+5jAW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both GitHub Actions and Azure Pipelines set up the environment variables
GIT_TEST_OPTS, GIT_PROVE_OPTS and MAKEFLAGS. And while most values are
actually the same, the setup is completely duplicate. With the upcoming
support for GitLab CI this duplication would only extend even further.

Unify the setup of those environment variables so that only the uncommon
parts are separated. While at it, we also perform some additional small
improvements:

    - We now always pass `--state=3Dfailed,slow,save` via GIT_PROVE_OPTS.
      It doesn't hurt on platforms where we don't persist the state, so
      this further reduces boilerplate.

    - When running on Windows systems we set `--no-chain-lint` and
      `--no-bin-wrappers`. Interestingly though, we did so _after_
      already having exported the respective environment variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 6fe3c08be83..8357ad77e4f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -174,11 +174,8 @@ then
 	# among *all* phases)
 	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
=20
-	export GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
-	export GIT_TEST_OPTS=3D"--verbose-log -x --write-junit-xml"
-	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
-	test windows_nt !=3D "$CI_OS_NAME" ||
-	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	GIT_TEST_OPTS=3D"--write-junit-xml"
+	JOBS=3D10
 elif test true =3D "$GITHUB_ACTIONS"
 then
 	CI_TYPE=3Dgithub-actions
@@ -198,17 +195,27 @@ then
=20
 	cache_dir=3D"$HOME/none"
=20
-	export GIT_PROVE_OPTS=3D"--timer --jobs 10"
-	export GIT_TEST_OPTS=3D"--verbose-log -x --github-workflow-markup"
-	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
-	test windows !=3D "$CI_OS_NAME" ||
-	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	GIT_TEST_OPTS=3D"--github-workflow-markup"
+	JOBS=3D10
 else
 	echo "Could not identify CI type" >&2
 	env >&2
 	exit 1
 fi
=20
+MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D$JOBS"
+GIT_PROVE_OPTS=3D"--timer --jobs $JOBS --state=3Dfailed,slow,save"
+
+GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
+case "$CI_OS_NAME" in
+windows|windows_nt)
+	GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
+	;;
+esac
+
+export GIT_TEST_OPTS
+export GIT_PROVE_OPTS
+
 good_trees_file=3D"$cache_dir/good-trees"
=20
 mkdir -p "$cache_dir"
--=20
2.42.0


--Xg23xdfdSK+5jAW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMktUACgkQVbJhu7ck
PpQVLRAAi9dv7Mm30fQDwQO4R1lsTeaw8U5p2C924yJY0Ae0ByL6Vrx/dN2iiztF
X1y2OsYh3v6ZPOHZbvrCgYuQjlV1InEI5SYWrrkeSs0j4d41fbnIGzljLJoRGhDi
xSsw5QXdCq2RiiZWVboQ+MSGITwxs0HCZj1Yg/ASiZfysnbFo3q2/7A4oHnZpkD9
x9km2lIb2ix/yJZnDF5sl9Oa/KHAgiCRpM41B6AV5k0Fi8+mQUlEFk/U283t4ze+
sSBQ0JPxYtbhncdvSQyzxPDJwRX3aUUIdQqTgcaShRxRWHkH+UszbUmCnuZ4ze9I
x5flOR+obOdKrXuPsZPgrfx4s0P0rRXQZu65xCcujMKe9miqF/z5WUtJKXYbmvhJ
bpGcuuE83NSM9874XoPOgcc2aHkqnak/TaQf8l/3hHPYaUFo2tXXwr/VCxsRdoRK
hh5hERaX7sFv8HuA6EmvvIYKjBCWULzlui5dcyFb65WNulMAdepIkAf7tmVxZssK
Uwo1ct6wWmdHA8r/kqRYPOgkUc9noZY/PbJmfZZWE0uNDr1J+Ey6URUzXDyACfwW
IgxeIaQ4NzViUZHcjFibglRT1OkklNgm92mRqvH3qXhpiLXXMtqcr2DmZc1EYmpU
1Ihg3PinUKek0J3HaCq2kdBtVMRo9bo4awdd+Rps6kItUCUY5Bk=
=UIIr
-----END PGP SIGNATURE-----

--Xg23xdfdSK+5jAW/--
