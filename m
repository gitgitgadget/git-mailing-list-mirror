Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0779EF
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uiFeAO6f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqW3wTP9"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85AD132
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:47:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id DA08032009C4;
	Thu,  2 Nov 2023 04:47:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 Nov 2023 04:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914829; x=1699001229; bh=CK
	rJwPRILFT44q/0sUlyIEbFfPSI19kZ55fYMkilVMY=; b=uiFeAO6f06+HttJ1tb
	mrhgZthHq/EqUmYo4BNDyjW0mOlnL36sJmiluUDt8hV7B2o6UEj3dG1RK632Ygv4
	T2GqRUd0BGpRleojwYaAc2AJMkzjdWaYQcoc0cw7nVdMN/j4eJ5JX91AJYfLOn4Q
	kLIybDu3yzG9jjDZd+DoQGfJlnk32VK9mbId8lCEG25eUNTGDiFUrb/lV/jaeQM1
	AwL/AsK79wmz+eYvFc0lAHM6oc89+f97J4xIYtJeKGnARw39Zh9cLWzFqB0XqVxT
	zUyOITC7YXxLL4Fr7YjB//8m11kxcT7bdIlpaTqy/NdwM0Rmsawl/1wjtd3VGfdy
	3G7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914829; x=1699001229; bh=CKrJwPRILFT44
	q/0sUlyIEbFfPSI19kZ55fYMkilVMY=; b=UqW3wTP99R5GtucqPqwCSlyZwZzue
	20KqvgZUdX0tXnY69lE5ofBhmdgQryXsGZa+nCtPECc4tvXVxuDk2AQ1rAPlhvWs
	5XEaXd0p3ZUApCJZ70X03qF/fF5yoDq5GFUsNswjF4qI+tL4hWSUsTqcjq6U9M2b
	DvxYxNim6Tpl38h4UaPVJqSqXReaWDaSe8zuWpBCZx23C0VxItnp7jFofAj06xOA
	8E7EXQ8wpXlx1wqIN6paGX/jERVwIKudYxPD6Oda9cjxlKEMsWdvQMV2lO5WgOs+
	rszuj51lh7NzEqEetmlnN0bzqkCGwNSJAcSa/l8i6JrIZUO3f1wTEVCpw==
X-ME-Sender: <xms:DGJDZV8pNi7i-N0WxvW0sC2xSgGEvmxkGjeY2AbQaU0cMPgS6U6ZnQ>
    <xme:DGJDZZsTxSNu2a36b9-DUC8HsT9GGfY6NUYROZbbpDhZXSAY4kn_ZiTzNznXHlCdE
    Y_trdgFP4cQFgfOIA>
X-ME-Received: <xmr:DGJDZTDzyr43L90NUyh8DSh-CwckQEFZlnQOrjB6giyJMnQiqgDesIN6LQPbmCAUc6i0nmd_D3kJ_yubPTkXXNODg_Ok54kigxbEyDzMRVVi1Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:DGJDZZcXCqg3zOYjgo7bdKRgPcibL_2Wt0k8PR_pajmhV8ov5PatuA>
    <xmx:DGJDZaN59YrFlR0fgfe_RhFZw0l6yCODYOmCwHAz1Y2L2jrnMHHwog>
    <xmx:DGJDZbnY97LGUZPbdit33wQRI2a4kAzZRb2j0k0ioNvMvMvf5EBEIQ>
    <xmx:DWJDZXo88yCuMfqFzP877CB3A82giDihxm8XrEKTlW91g05U7BwBfA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:47:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18170767 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:46:56 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:47:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/9] t7300: assert exact states of repo
Message-ID: <36e79f266c219142d105424c29eb3f1b9fad6398.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698914571.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vx6DDZVW12t/lMHO"
Content-Disposition: inline
In-Reply-To: <cover.1698914571.git.ps@pks.im>


--vx6DDZVW12t/lMHO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the tests in t7300 verify that git-clean(1) doesn't touch
repositories that are embedded into the main repository. This is done by
asserting a small set of substructures that are assumed to always exist,
like the "refs/", "objects/" or "HEAD". This has the downside that we
need to assume a specific repository structure that may be subject to
change when new backends for the refdb land. At the same time, we don't
thoroughly assert that git-clean(1) really didn't end up cleaning any
files in the repository either.

Convert the tests to instead assert that all files continue to exist
after git-clean(1) by comparing a file listing via find(1) before and
after executing clean. This makes our actual assertions stricter while
having to care less about the repository's actual on-disk format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7300-clean.sh | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0ef7b784573..d7d9202f37f 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -517,8 +517,12 @@ test_expect_success 'nested (empty) git should be kept=
' '
 	git init empty_repo &&
 	mkdir to_clean &&
 	>to_clean/should_clean.this &&
+	# Note that we put the expect file in the .git directory so that it
+	# does not get cleaned.
+	find empty_repo | sort >.git/expect &&
 	git clean -f -d &&
-	test_path_is_file empty_repo/.git/HEAD &&
+	find empty_repo | sort >actual &&
+	test_cmp .git/expect actual &&
 	test_path_is_missing to_clean
 '
=20
@@ -559,10 +563,10 @@ test_expect_success 'giving path in nested git work t=
ree will NOT remove it' '
 		mkdir -p bar/baz &&
 		test_commit msg bar/baz/hello.world
 	) &&
+	find repo | sort >expect &&
 	git clean -f -d repo/bar/baz &&
-	test_path_is_file repo/.git/HEAD &&
-	test_path_is_dir repo/bar/ &&
-	test_path_is_file repo/bar/baz/hello.world
+	find repo | sort >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'giving path to nested .git will not remove it' '
@@ -573,10 +577,10 @@ test_expect_success 'giving path to nested .git will =
not remove it' '
 		git init &&
 		test_commit msg hello.world
 	) &&
+	find repo | sort >expect &&
 	git clean -f -d repo/.git &&
-	test_path_is_file repo/.git/HEAD &&
-	test_path_is_dir repo/.git/refs &&
-	test_path_is_dir repo/.git/objects &&
+	find repo | sort >actual &&
+	test_cmp expect actual &&
 	test_path_is_dir untracked/
 '
=20
@@ -588,9 +592,10 @@ test_expect_success 'giving path to nested .git/ will =
NOT remove contents' '
 		git init &&
 		test_commit msg hello.world
 	) &&
+	find repo | sort >expect &&
 	git clean -f -d repo/.git/ &&
-	test_path_is_dir repo/.git &&
-	test_path_is_file repo/.git/HEAD &&
+	find repo | sort >actual &&
+	test_cmp expect actual &&
 	test_path_is_dir untracked/
 '
=20
--=20
2.42.0


--vx6DDZVW12t/lMHO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYgkACgkQVbJhu7ck
PpTEig//R9OSceu0f+FAtkCUYa8oe56wXaxwhwC0wOtx0be6YG2SbC2OMcgEUtpq
MI1R+5Y89nMZLMu3MKywFBuMxcu5jYkw1IRy7YX+vnavezc80aBc/p3SvXrMl4Qy
lyo+6oyfYXSN6pFS/BMAGpsAhr6gLM6SNBVrEry0qJvrvp7K8OIKjaiTnVxGkV4O
WDUA94pnGrLVSzyqm7gqP0xjXqEqNqi6h/HzrjuvSowSKuh4MesWeDxCe9mebWIe
5jpB/XkGCB5IlgJ3GQe5MyBjkd1JvPzh5XDcBo7Fm3LKK6g2wu4NjyODMFgZYisf
+fsSVDoxZs7nMeinMQwT79my1h9pKvQDgqL6fmHB6aRiIrh9+YQXRo2jcHKnghEH
qaHI5SMDJ2MPRiEFLlcmilqpxeIzmlHdaJDq7b4nAd/hYldhB5wKI+/Xvk7D9nRi
Nd0FErZNmQ9BvuU3SIN2jctorL0lxD8+uK9x/31O3b+rt4YgSReKThPMubmD5uzZ
uT6oQ4RmeTnPhqTagkNaTwjLO13TExcIf6IISEqcnWVcJNzATfDuJRTeZoJyDeqw
AZckNFPHoPiS2uO2kSEqez8GJvKeExjbVo6kz5RuW7OlFxvKh5g6S/Y8bpn7iHI4
oa24fPNI6Sudccw4I13wGAveTtK7iD72o2VdLtoqJ3+pleAxrMA=
=3UXN
-----END PGP SIGNATURE-----

--vx6DDZVW12t/lMHO--
