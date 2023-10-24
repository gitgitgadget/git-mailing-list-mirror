Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701652C850
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B388bqC+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSwHeyll"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5353DA4
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:05:24 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 46CF63200A26;
	Tue, 24 Oct 2023 10:05:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Oct 2023 10:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698156322; x=1698242722; bh=S2
	M6DAjWYAx/9AZ8mzV93iEIGMiVCXxlTzdmqPCMthQ=; b=B388bqC+sxKARIMJ0A
	khMEeo2MegmISUQ+dDHiNweIX+FWDCw0NK4jdBxKy6Aso3DKQeGYhVtF+Ag1qK3N
	2guh9HWJ3EW5LLkokMo5gJUV72OL0F3qzZLlWe6Wdb2ElpuBAcf7WcB2oTKEMlw9
	2wr400e183I7vWljv3ombsuwlOSU1Nx0IggkyjmH2IqACgWrHtLBM0SAG34cdFl1
	7SIBvmjCfvu+m9pQ3RikZ0+eA6dJynPjeUnlnGTKBUh9XpkVn2IPTUiU+ueBTi9S
	PnExCJV2xbuksc1K3tysUEC/Ylsg1YZ+fcQuFRFaIw1ziBZUGNn5+pLxr8WfNs4E
	kjmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698156322; x=1698242722; bh=S2M6DAjWYAx/9
	AZ8mzV93iEIGMiVCXxlTzdmqPCMthQ=; b=dSwHeyll3mIvjFZX3nvmX9Cvbk93J
	TjwpxvFBE3nsSRCIIAj/md3NtNBJvwBpReVvhnjaMaArx93S0hdRIYosdIy6NMX1
	taIyLZc+xUaDYe4niNR9CTU75mFFQtVgmbhESd047+oxFW1YJXGgXhLOgfqs3frX
	PtNNqiXDxMZeHTAZiuQJ9J+zsy2Ij/lgvjlvIjewkxtaRlSXQGlEQlXGHFkoGQdt
	sgo2FuKcKGe+tosZmMoFQ4AmDcl/Yc578iBA4QWggSfzpm9fR5bn+XZDF2+MAGlK
	Kle++7Yop5wDxF73/ABzYhLeX4qzkEDUBKWEWbD6No5T160caGmHcnXXw==
X-ME-Sender: <xms:Is83ZbjGmkCcDl0oJlPfr3UCocsMDsU6E3MsgTrd2ZlxT35dJnY-IQ>
    <xme:Is83ZYAIBprxqPU9pWdY-z5rzrU6KFyKMLpfMwOKqKEbYBkR7DtaFAqsWbbzKc-u1
    -3BNXpZy7gkuT2nmg>
X-ME-Received: <xmr:Is83ZbH2lM1sDT_Y9fQUUuduvZFSKPgTM2fHcfYz8Qx62P3u8sQpLKk-fW1q5AcZ69r9Nykq2WbujS4t7H7ON99cH7O0EUWHh9AFKZ4aZkWwb-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Is83ZYR7H4wvfSU7_52B1Q6lhfeKc722cQzBSTWBsUNx_jKxywKCzw>
    <xmx:Is83ZYzzU4QC7YrNVCjKLg25YZsrZ_5uDGfxwwJ2nAYSreMqvJx4wA>
    <xmx:Is83Ze4WhTL-RT9xA-_5Fn_nxmMqi0ER32-xHYeERg5VrN91573hQw>
    <xmx:Is83ZU8sdDR6dPehEBgVR1em3fW9tYk6Sy_WbEjwj6ZcP4i17gsLuw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 10:05:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d1d2e79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 14:05:16 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:05:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/9] t7300: assert exact states of repo
Message-ID: <e730e011de4cf00785af07a52d7b2745de009e48.1698156169.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698156169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="If9YXhDIAsvFqS9c"
Content-Disposition: inline
In-Reply-To: <cover.1698156169.git.ps@pks.im>


--If9YXhDIAsvFqS9c
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


--If9YXhDIAsvFqS9c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3zx4ACgkQVbJhu7ck
PpS2tRAAo9clmGk3N7S/uLeJ3uJu3Rhrq9W8cQrYYvC1qG/swYynM+NduCoUeI29
Sq5MHprit2ol7LAbbE+K83GibWUzEYkNQ964LmUhoDHtL5rEE4DgI9Xyc645iJHT
xdv0ZKOU9jJGYrlEIToiqPeqB4mFxx/rzm37M/3J943+o+Rotipj/FpWCfFWr6Mz
1ylkN6enmw4YE1UxzS5ryCysTTIKrQLL8G/63fwm4ls7Wfc/8275T1gcPTh29CP5
gTUg9qyanetooD0k4ycVdtGdVDQYQ5ltPEzRvxZ8UnRqJdkxgHl+wHyujQiWmMjd
FX5S3uVIXiKpGaExbXxlTaVkL/SCSnvdVFCKrVYGzVGtYOrNPu2tVxknMHtUligr
mDf9fHU9O24Eawl/5iYhEODw65nCp+kkKjIKfVm0nRp4zLih0DiczjfgmFFl7TNY
agq6iWJ75pi75gwaox5IN8vi9Rsfi2hY2iTG6TaFv2FA9NUSl5mYZGIiQ+Kl5aMu
Fjrrxy1bgBGf6iu60poh6gvLdtLYT1+Nw5dTQzum8hY87jw+WPf2PLxSCETZ0XG1
hfYuvZLdnubNlp73sKhPp6sSH/ru0VmcIV65Dw9YkGe9UqJ37Qp+6uL+4PX6zStB
nHMCvUoUvKtsOUO4AAHEfvQRc4e6cyE2jORL7b2Y/Qfwtb0VoVc=
=hdnm
-----END PGP SIGNATURE-----

--If9YXhDIAsvFqS9c--
