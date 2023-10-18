Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3914AB2
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="z0HgXSsV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1H0RWD4"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4488A181
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:41 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9AAF03200B3A;
	Wed, 18 Oct 2023 01:35:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 18 Oct 2023 01:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607340; x=1697693740; bh=ZN
	0s8cpLORyMUOSR0o1dZPgGpdx3IRQztpSSJYDj9J8=; b=z0HgXSsVTq/PEqov0c
	6vUCbdWa2iONxgdy+phkpUChqhlz8MYHuNgOkfU7/oSVuu48STKyZzbJ1SGOcevy
	qP8RUGg+JEjh/zo1it641bFdhQl4eCxkI1sxptDdUgxAJL76+6Gqn41o4I8YKLrc
	tO1EFyPpA3horwraMcBXnUFTl1cpyuaDFTLsdeHHhsKIUqU3oVTeUcDZtxtpiuoV
	FgU40/1W/pKDEREylB+lCjNAqILvKgKSstqT7B16AP6KqBHlzsdYXAecqI5qeJCx
	Qq87X95wlm5P1Y7Sf3i3Z2+kEjC/Y52kv5FWnd57OV0b2kXdIdvqTZRGenE3qiU8
	WBMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607340; x=1697693740; bh=ZN0s8cpLORyMU
	OSR0o1dZPgGpdx3IRQztpSSJYDj9J8=; b=I1H0RWD4KPMphwU/D3EfJdC5vLGqy
	eVa/DTZuWk8gQhiYrSKxZxoFtPfiaILc+ZZkqj+w0yHmV0dl7daWodnD9FkzDdlz
	VqLDAbsgTC4H+1ax74xyziOOOE/BK1/ip/DcfdLaYmb980/hK/NFjhTPkoYZfKVT
	0Zc2h8WVMs+0V+UT9nCCUHTpXOfcsFlMG3MCwqQi9LStEkbh825+ejlYS3p2w3Ro
	dwX4LS6Emxkxm6N8pK4KbG+7idXa0HIjQx1ERgCt4KrUXEagDNsI4NLjwCXl7zGP
	smvI3n5KznPYLsyL1FXUSnCAN54e7DyrwNidQgt1JFQlcSskPP9Xiw6aA==
X-ME-Sender: <xms:q24vZaCzuDCc7fjpfgNiLDWIiE_4MuRMwtABGP6vSTb-U6Dc_5eZCA>
    <xme:q24vZUhXfE8eUXMoUuk3L0_KMtnF1rYKoVt0tckHFv77Fnak9oWKDjcFkhkl73wqm
    FEhLfbybXdHAf50KQ>
X-ME-Received: <xmr:q24vZdkxHGwlfqplFCveDug3DHtdwYdLkt_TRextq4PpjRQBoR7EckS1avI0VRSYRGiu40_rhFxvu6X5XgfUChmKWSy1ua-2gXJyHOSfelNHlQT7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:rG4vZYybucPBwr0Qfn6psp-6Ay8Vmx5o4yz-O9apfwpij-0PfivIBw>
    <xmx:rG4vZfTGGiH_OUVIfm4X6p4oA-EcbblNWACcHIq4SAXQsb6Jxj1qwg>
    <xmx:rG4vZTaK_KhKskZpmDgDFgRtRa-gcMp0Sv5tOxmDBXjWFt_8I2H-6g>
    <xmx:rG4vZQ5RQpb31yeBXS-ECyoT7mXqH_ynkCg6iYziHgWPuJdfz2D9Xg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a0febda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:38 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 08/11] t4207: delete replace references via git-update-ref(1)
Message-ID: <c4d09e3e5dbd11221cc4d229b815434d441cdb4d.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PxGozpenGUBspIZt"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--PxGozpenGUBspIZt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t4207 we set up a set of replace objects via git-replace(1). Because
these references should not be impacting subsequent tests we also set up
some cleanup logic that deletes the replacement references via a call to
`rm -rf`. This reaches into the internal implementation details of the
reference backend and will thus break when we grow an alternative refdb
implementation.

Refactor the tests to delete the replacement refs via Git commands so
that we become independent of the actual refdb that's in use. As we
don't have a nice way to delete all replacements or all references in a
certain namespace, we opt for a combination of git-for-each-ref(1) and
git-update-ref(1)'s `--stdin` mode.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4207-log-decoration-colors.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colo=
rs.sh
index 21986a866df..d138e513a04 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -71,7 +71,7 @@ ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c=
_reset} A
 '
=20
 test_expect_success 'test coloring with replace-objects' '
-	test_when_finished rm -rf .git/refs/replace* &&
+	test_when_finished "git for-each-ref refs/replace*/** --format=3D${SQ}del=
ete %(refname)${SQ} | git update-ref --stdin" &&
 	test_commit C &&
 	test_commit D &&
=20
@@ -99,7 +99,7 @@ EOF
 '
=20
 test_expect_success 'test coloring with grafted commit' '
-	test_when_finished rm -rf .git/refs/replace* &&
+	test_when_finished "git for-each-ref refs/replace*/** --format=3D${SQ}del=
ete %(refname)${SQ} | git update-ref --stdin" &&
=20
 	git replace --graft HEAD HEAD~2 &&
=20
--=20
2.42.0


--PxGozpenGUBspIZt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbqgACgkQVbJhu7ck
PpQA9A//erPwFSCotubFRWS76pchv+nFL1FRKN9l3ujdomQa2vTNyUplSVlt4Tx4
IbHda9tQJOoZdLdukvg6yOgu4Y99I4ooSfLW+21St0n/lH48W9it+V8BjXiPTxty
1cWv5Kyqy+cnUvS/kcr6+nkz2LPsm58VkK+EvCfXS1p9LkgK9+yH56AVC1et31Yl
AGg7ZnoVKTrAkazXrPpLQsJnMQ6YCbFC1GSfGBs6seL5swy3CU2O2mVMKG7V3lVn
KJGXV5WWsH90M4CedY/znURA69y0WzbT2AQmqAHSYXI9L8y6Ijgslt/v508+EdDE
O0u0LXsmbJUsjRgWU1apy/ydluTxRgFaFKAMCWUtU39+pc1qxke0ZBA7tZv97Xg7
BRvXJn3w6bNys0GMYMNYQHCfPacjVpENMLoLQwTyn+HHn7qlUYvtpPXw1tAUCH3u
QiwjmpY64kM4PBPiBMJ5NxXckTcvwpcUBUKlVbFLnlRn6HI5j3M7uVDQ7XgLu3Tw
3sR2Rfcgm4XBlLpumiXHJpZ1sCLigk+15ILvy0GpEJIehcW90l0mIL6dw4ISuGkM
RNl2RWddTpteTLEi56NQ2AhhiXHoillcl3rOpDHF7E2VPQoNVhHApQgDkCVQiOK9
GEoef2RB4r34AhRrCXd0yDzY5nVhlhuDJCQMgO0Jkhe9u0hA/jw=
=EyjI
-----END PGP SIGNATURE-----

--PxGozpenGUBspIZt--
