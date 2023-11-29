Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZV5LvgRS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KMvYqXy4"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D3519BA
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:24:51 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id D136D5C018E
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 29 Nov 2023 02:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242690; x=1701329090; bh=Cd
	L6mEdQJaSsM64DtWDEpNGcLBixOFCGfys/46PM+h4=; b=ZV5LvgRSx30WqN0l7R
	Sr97yKfUFPxVepEGPLc5oDCohNHbAunoJ1m3VvQhDRCVsJ5vlZg8qM7TlUFZmquB
	+vNviy9JyFG8X8CJbXP4+dbayqgmA0kxWKykoykyqfkM2isxLX/iTYtpHI1BnLgx
	w8Oz2kaAMuOhMO9EQxYfi4ExEd+v5LE68USfxLlPmY28mlpVPRZLXK/7piCasUYN
	8T4qEjVDmCBoWJORSyhcS7AhIdKXMv0UaKDEYAagA38SEK+PXoi/aIGuExjns+mI
	/157r64JugDoUZciJsdfPcuZZiffXI8CmICyhjfRvkEhzRihbgn+nHtwJfzYXUTL
	eTDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242690; x=1701329090; bh=CdL6mEdQJaSsM
	64DtWDEpNGcLBixOFCGfys/46PM+h4=; b=KMvYqXy4Zcyh/hKYxVZUy1yZfCv3q
	y3l1LyS6oTjREvJMLtIMebw000Bq47gTYFSuJfWo0jXWWXJMVQCFXWwqaci5qzSU
	66laIBSArOz83aJZx5oLbO/NUmCSJuXQ8mpVSg2ROiV0rZyn84pRSVj9dJv6+67w
	8Bb3CD1GTtlu97OjbkFVvIWRbc9lORM0G9hSfJY8oopKUlzcHzUnKiPvDZ5sJZVn
	FPtgV9Pk8aCPjBOETr8N0Qirxpte4mKl4zlz28TYGp2WQzeDEqd153WvIfgkv87e
	yPjSrD3qxz/yThbU3YSHckqzOjH7/TTTnWjSTzmSQ+PhwNEEm5iMRvRcg==
X-ME-Sender: <xms:QudmZaqmlk-GwhtvETy1NxIXkdPqp9dcQD7bS_6cUN24Y9i4kdJD3g>
    <xme:QudmZYrOj5WPnSgKVMdysS0PggRwIMufC20hG8ELfNbIehhqzG1Ps82H9rDLkO5-k
    2z-XO8MbF1ZhvQTbg>
X-ME-Received: <xmr:QudmZfNEY-wNgea0SRLUsNoJde6IJ0jmNe--0aBd2JNu4z0UoGsABvev8-bakhveSW1-t2tGY4b5lMpxHoItrBKFOQj6DY1sWkBJoNzRfJ9QjIMK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:QudmZZ4ZHmUoKq7keVC6C4b7JOK6JftSa4QCAkxUqK-Pbj3YrztsRw>
    <xmx:QudmZZ6gwPY5HgI__Nji5_pk1NDuIauHmAH3m5d98Mgvzbfry0Mzvg>
    <xmx:QudmZZjz4Lb7rNzVgpx92Wizop8TM1AvNoRH7QJ1aZK325lmhXjUxQ>
    <xmx:QudmZaWIh5iV2vG9ryUVbRS0hqsLgW0_pUhdWY-0ChcMFMDPnl8egQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4216036a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:23:32 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:24:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/10] t0410: mark tests to require the reffiles backend
Message-ID: <53c6348035360912a9d720448dceb17895703da2.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m3LzK9Med+dTvGtS"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--m3LzK9Med+dTvGtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Two of our tests in t0410 verify whether partial clones end up with the
correct repository format version and extensions. These checks require
the reffiles backend because every other backend would by necessity bump
the repository format version to be at least 1.

Mark the tests accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0410-partial-clone.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 5b7bee888d..6b6424b3df 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -49,7 +49,7 @@ test_expect_success 'convert shallow clone to partial clo=
ne' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
=20
-test_expect_success SHA1 'convert to partial clone with noop extension' '
+test_expect_success SHA1,REFFILES 'convert to partial clone with noop exte=
nsion' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
@@ -60,7 +60,7 @@ test_expect_success SHA1 'convert to partial clone with n=
oop extension' '
 	git -C client fetch --unshallow --filter=3D"blob:none"
 '
=20
-test_expect_success SHA1 'converting to partial clone fails with unrecogni=
zed extension' '
+test_expect_success SHA1,REFFILES 'converting to partial clone fails with =
unrecognized extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
--=20
2.43.0


--m3LzK9Med+dTvGtS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm5zgACgkQVbJhu7ck
PpSEHw//R6H7QfBT7d50j26Kbl+KcRGhJmITwG4GFJk078i74JDFPyEmk4/dGdvz
OCxaErMJ66ggdkK4dir9Ajsb/bYCglgSlfVRTZ9Wh8f9KLqTkrmS5Vov5stsVaL2
NMrmkoSvsGTzZi2wMQrcOxza9CcyDrLnzYZbv1++bLMgvCP4jzZ3vhRvagSub/H0
4Wml+wF9dUgQelUvzbYZjdmjSyjwiANx5OSprCDjsqNetY++EJxW1drZug0QIeir
yrQBNb+EmcpleRJFk8OX62sp61uEEzs0QllGMGAFJdXBF6IfUC8optgeAoxbASQS
S8moJdzeFf+aKXlVpW2MbjJKqeyDjn8kKyvs1sf/xN5zLsBqlb13hGppMOsRxeXj
1OsHlmnlelX3Ouzx6kctmaRVdsLOgujnkyn80xm2RCnVSo63lnKGOqxFW0x2Cgyz
Vznn4ufn41smGlEsaiCKrAQ3+kFKh0fVGMnfATfQctqqBCOH56ed1mQQTyJxsqqE
qdjqTgotHfT94eA4wgD3UiS9G7TiS+RI+AbwRkojPZgzAYglSFRxKWjv0Y7DmMLx
tQSFqLzqdgVAJnLjc1UyOs63kBlyrZJTcGFoZJAmjR9/Rsd17gcDp/OZbzgOO0wo
h3CcSoGgKpzwBvIc2OP4Lpi2nAz2pX1Wmg1Lc/hcHwRcqA6Nbf4=
=QqUh
-----END PGP SIGNATURE-----

--m3LzK9Med+dTvGtS--
