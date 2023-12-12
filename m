Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r9A8yoBb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Znan7oWF"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E77D5
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:01:03 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id C64423200B0D
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 02:01:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Dec 2023 02:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702364462; x=1702450862; bh=1oDmlO4RnC
	2daqv6a+51TrDOvMyYKIJZYHwIXe6EiJs=; b=r9A8yoBbGLaOmDUefPwecxk6Qj
	Cx7UH0IN5007Isw7v+h3jKw+l1RVl3dJ5n3qUPf1LSph4G9QNJzwNF1VwawPuy5y
	9e1OE/Z3zIRK4kVedqG/PpCPaknoDxoYhpYaotMvn+UYFExJG9UYFImU8S2zyqkC
	I9u9TfAj7tFDlTT1urBr8LdpONkqFV709eRVuHiy/9dIr/9f6GSEgFJzbLzKjCJG
	rAOmOAJ6oBKabcHsu/0JtKeqC4ukb83MEHUVKYE+Y/m9EBoN0m3yNKLP+zWbgX7U
	HOX2ZnUndDwEdQssgCMdcf38dWka4gvnphrSgFfoM3SUhVfqt7DUE4vfPLsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702364462; x=1702450862; bh=1oDmlO4RnC2daqv6a+51TrDOvMyY
	KIJZYHwIXe6EiJs=; b=Znan7oWFbeHIVHe4ywlUPgaZC9DKmASzQm9d9Q9e80pT
	Jz5UY+Khi8YlrAs7sd7oOcYBreO2fgY+sY2wLEloGTTpVkwI2/AQv++zO5+Peth2
	RC3QrjhXhrULlsCSJWy+big1Hi0G2A+e+WKjHM3/W1gwZLqk+PMsFfkhtW7BTf97
	2CY64/d/qE6pw1+Aw+Ss5ibO0xHXrIDiyOfVDOM3pRvox6znz6HQEMmIPI3MJDtu
	3pZ8DpNAH4G1N0Fddd359vWq3tl6rMyLED6F0h3HgwUzvLYxfPDJlxM5DjnKaN/i
	iEhhzHSZft5zLSdNcQZUn8Hij1A5hFHkhEj7HL/wAw==
X-ME-Sender: <xms:LgV4ZYMITM3zUawCSqIVfB5XUZDoVRTiHaWI0roe0cn2m-58H7BReg>
    <xme:LgV4Ze9tv3NH417Fu1X2CQn-Yo_8MwEg3najNaDB4xYBDPhJswd4I3NqkWKYPClUT
    RIQT5pwTUHsUdmd9Q>
X-ME-Received: <xmr:LgV4ZfTg-tbq8QOi2E7cAW_oVYfro5M8QN82OTzqlvCtHmPIkhBV_stHfmizdvN6GPik_mVdi4ihPCBmqiCtopSXQ4T6o856x9NrJ0iuuu_bkLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:LgV4ZQtswCy1tQh0w1vHEO5njyLALarFnG1-EhVAA_gyCVoyujThoQ>
    <xmx:LgV4ZQenZ0_tm_KBfErykb19oqs1j5rBOD2qjP8JiE2IYtieuelY0w>
    <xmx:LgV4ZU0EjXzy92kS6Cl4Sx8PrdtmoBEj_VxZgTSDpRtqVG60Rk0Alw>
    <xmx:LgV4ZarPQ5XPYufHfW0SIFcveZy6iRBSUI2iPLE7uvpru2XskZpwZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 12 Dec 2023 02:01:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82a4889b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 12 Dec 2023 06:59:22 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:00:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 5/7] builtin/clone: set up sparse checkout later
Message-ID: <917f15055feba4847927edced71454f0faa3da7c.1702361370.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
 <cover.1702361370.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MJKs1y7oUprsa+n2"
Content-Disposition: inline
In-Reply-To: <cover.1702361370.git.ps@pks.im>


--MJKs1y7oUprsa+n2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When asked to do a sparse checkout, then git-clone(1) will spawn
`git sparse-checkout set` to set up the configuration accordingly. This
requires a proper Git repository or otherwise the command will fail. But
as we are about to move creation of the reference database to a later
point, this prerequisite will not hold anymore.

Move the logic to a later point in time where we know to have created
the reference database already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d188650881..9c60923f31 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1185,9 +1185,6 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
=20
-	if (option_sparse_checkout && git_sparse_checkout_init(dir))
-		return 1;
-
 	remote =3D remote_get(remote_name);
=20
 	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
@@ -1426,6 +1423,9 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 		dissociate_from_references();
 	}
=20
+	if (option_sparse_checkout && git_sparse_checkout_init(dir))
+		return 1;
+
 	junk_mode =3D JUNK_LEAVE_REPO;
 	err =3D checkout(submodule_progress, filter_submodules);
=20
--=20
2.43.GIT


--MJKs1y7oUprsa+n2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4BSoACgkQVbJhu7ck
PpTd1A//ZaA5RnyKBjUOiI8rPjJMSesi754OThfWlFFMeJqlh6JEYGCOz9GMa6ln
h/ys1trUrWFhVWrV3tu/ImSjE7bNntTGyznO5HCRG1TkBZwCq05YqseCPm3x52yq
RL35MK83Mn1vz+HYrLZ8wG5iHV/afpuRtsW86nEoKhSvzSUgAs5COc3iDZFYaXxR
UBRhVz+vqYHN2S2g/lQAw2+l8qXmhOaUdFtS8udR0rHuFszcIpiruAUei3g0R4ko
jla3jAdgJcZIWKfuDl/F60U1WeS/lWce8NdGsl2iKB6CLjiQU4I/1bbiE7/RjcjF
l53iC8Y03+bn0nk/yNFoLuduoYzixsUduLALst6nI7Ey5h/OSAsA7F/1V005bP3u
S/QhFd5l1GYmhxzFPsA5InK7FMY41kvc6jiWn4SxO3zEbkULbpVcewpC5RYLOZcR
iqFDObe458fk4yrOTZCfKYQiKsWe2Z0rB7rlZfv7Om/nzrDkO33Vt/Kw7YQEggha
ZLlpJlKAk543DmKmcIEGl5l+fxQbwNO3YJr0roAPMsNa19gZccorH0lkAx0qwVdM
lRq1Vo6f+McYBLPbPUYv6hviFTaXFOmzmMF9xBP8TjZMS5Y4hH3xOxFdZck+MqeR
bNVlmlm4w5N379+zqmXz5MKGCZi86EatyY3+jRwKzB2KYF3t7d4=
=ymPw
-----END PGP SIGNATURE-----

--MJKs1y7oUprsa+n2--
