Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1F2C850
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ysJFVOg/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q6jRty0T"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A8F109
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:05:19 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id C9B323200A8E;
	Tue, 24 Oct 2023 10:05:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Oct 2023 10:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698156318; x=1698242718; bh=Bk
	xXEuIpNIP5gskQfRfHKB3VPm9zWsfFzv36JPmj3ds=; b=ysJFVOg/fv11CZ9ItX
	O1oGrtJEVl6IV7yJSNXjF0qa4ONhi7UzhqwGjFSVxLiDDPhV+mmCMxG7na18ZEGp
	0b78mnlZunQf5QZFqBg0dONhWRZGH/2IL6a4D21E13QwnCNk66RoOX9hhGqFYlXW
	V5M8RlkO6NK1hG5yiqtCZBKyigzsKo3TAtKqztcCz+6aP7i62upTFZ9cwr6IJURE
	NA2JUCuWwp3Ujyf7SWF2WqovTd8BNKyesJ/EAJtbpuFKvG3UW+2qC/WCJ5gl/oEI
	TtpGwt25lsyjXuC5i0/8weuf1cYcXfd25m99o3+oH2NFMcMfc1X9t5Sln9/87VMj
	awIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698156318; x=1698242718; bh=BkxXEuIpNIP5g
	skQfRfHKB3VPm9zWsfFzv36JPmj3ds=; b=q6jRty0TzFc2c30s7/knLFLczL5J7
	ikvNRTsLF3KpAh3fql+W9lAO8Bt1jKl28YxUqlNsniE3/D2i3cpTUEsiApIHhtql
	lZUO8ErbmpY62oYIyUV0khAFVYoybRj60Aj6vNPrtJGWDbniNlesLk/X76MKpWMl
	1ueApG7vg/6Z0Umi3YcgAKgRUPsYU+NDI+L6IJHDozCzUIWT/gB4TdsqXjRa4P+q
	1EH/+hYvJq0tFqXg3da92Vj/3SuLvI3wJUdSEkRVGqs0o0UNm4IlWieZuXBqYBDv
	yrDSeaIZT8Cl8UC9vu2XpHFpu+InG/CcNVloCGmteg9qL6yhfekaslHwg==
X-ME-Sender: <xms:Hc83ZdK2pfh26PLU6hQtNLXsnbCW8jrIokqW3Kmr8CzjFuaxphgEFg>
    <xme:Hc83ZZKfXa7xcDZ7Eq2XLOP_RNGW-FMyfFKItQaxL-Pvs2qNSD-a9mSq2_w-3aYG9
    hQPWCWfQTn0B775Kg>
X-ME-Received: <xmr:Hc83ZVt1Mgm41QnIEJ0dARbmeAcAXGESvSjlyk9oB2YlAWcdk9fL59VmfFIhpXigMhqaonM4rc5nMJyvSp-Nvz8M93AUj64FLOm2-Y98gamzKJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Hs83ZeYls54vtdQpf-KbA2qj4KEKERL4BFc-gd7ff7DGgMcKDtNcDw>
    <xmx:Hs83ZUaLnyapWvhnmW-pq24b9WljkW3LN2Yel7-dcOr6pcbLXCVeaQ>
    <xmx:Hs83ZSDNfWKiJXTrC9u4yHLBMGhJ3yGqUGNH4FpzazidX-FGdbKvCw>
    <xmx:Hs83ZcG25j8-VYLrSeI2tsjW84SiCr4uVmIVlm11vioPng_xyao5SA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 10:05:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82bf9ad5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 14:05:11 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:05:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/9] t4207: delete replace references via git-update-ref(1)
Message-ID: <cb738888ed703fa56dc3c9f46e1afda81e66d8d0.1698156169.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698156169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1JauNLPow8rS5hlu"
Content-Disposition: inline
In-Reply-To: <cover.1698156169.git.ps@pks.im>


--1JauNLPow8rS5hlu
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
 t/t4207-log-decoration-colors.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colo=
rs.sh
index 21986a866df..73ea9e51550 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -70,8 +70,14 @@ ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${=
c_reset} A
 	cmp_filtered_decorations
 '
=20
+remove_replace_refs () {
+	git for-each-ref 'refs/replace*/**' --format=3D'delete %(refname)' >in &&
+	git update-ref --stdin <in &&
+	rm in
+}
+
 test_expect_success 'test coloring with replace-objects' '
-	test_when_finished rm -rf .git/refs/replace* &&
+	test_when_finished remove_replace_refs &&
 	test_commit C &&
 	test_commit D &&
=20
@@ -99,7 +105,7 @@ EOF
 '
=20
 test_expect_success 'test coloring with grafted commit' '
-	test_when_finished rm -rf .git/refs/replace* &&
+	test_when_finished remove_replace_refs &&
=20
 	git replace --graft HEAD HEAD~2 &&
=20
--=20
2.42.0


--1JauNLPow8rS5hlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3zxoACgkQVbJhu7ck
PpTUKw/+PkeYEdA/wr569azXczlf/CAfBLoWUoCC90UfGWTk0V9dbaasdgZSUG36
5OdbwQCsMdNDg9ucNVXr82NCDBOPUwnuffn7AsJcLmgFOur7FuKihJ/JBkRIm6Tu
7qFmJL/WJPJRleSWOez2cBY2MM3sb9MAWoCaNOiD9YRnZtIwsxu7mO9ybfY+/5Lw
JxMi9hoK3DBUFR1kEmLhi5bJibio902R/PwFNtX9w8iD0sAe5h7fT2WugFgXCtT+
F3zbEykYD22Nhp5Mi8s1Cu+h+MB4w3ZoT0AUjhfM1eJ+w/XAMipQ3UUvh9zLlUpI
VfczsWNItnxudLrkALYPgxRwWzlpjh4dl5/z8xO6tMtOQWuut1QvkjQp6ECmxyzw
ok7JZvwlPrLqspDJoeLE1iomvgCbhFsuL2MEU1Y6EUepybKGyBMoRB/tLuACP/VF
tQMpmLqiYB3mLdh88aX6YugvQ5D70MlEu30xnwDSSQ1fLrcuSaMca8SRNQtXKEck
3ZLqlG0eXjx2R839wpgwY+96v4G/idLMH8UHjCA6JfXjpvjXOCiSrkp39hi0KzI9
Uayk20eICHkCF6tkV31kkoLEYIDj7/RVgz6JxF2B9XRdhaiGYsUN3eYCLJJuv6cQ
STyIbXp/3Za70dk1sM/1khTirsxYPLiCY12M/doXeVKsDjgPeFs=
=YQCg
-----END PGP SIGNATURE-----

--1JauNLPow8rS5hlu--
