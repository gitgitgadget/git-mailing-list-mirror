Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF118C17
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lvTQZIch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wh9ve5JD"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D35E91
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:05:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 6E59932009AB;
	Tue, 31 Oct 2023 05:05:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 31 Oct 2023 05:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698743105; x=1698829505; bh=KQ
	0aEE34Aj/6/S03u89yypI1E3Y+iieXBmnRz8N2H3M=; b=lvTQZIchDXSRVKjkav
	I/667USh0SBSlSSAGQFB88ao776uZdwLpI6d1EhflBC5jWIy1VMSNrGmIebDPgUF
	4szy9Mw80nTB5QUAbK9mIiq70QJO07IYETEKOeMbzC9UsZ7f+CunujPJS/d55LuD
	qjzXPBD9b1lUXD13JgVyvxA9l4QXyGDYv6araBXOUkzE/Rlfzp6dyfHW1auEfWPu
	A7ZFd51Y+IHDvMF6VPj462so9hsGLafFxDXYjbEAf/hMiMXF4jBFbkq5kcar4UDb
	C0e8wAS+/sRn+/+t5F9wkmV8Sef2le+QGpQzbrlBzSyO89Mq/mNicaHYz55kDTyb
	GD7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698743105; x=1698829505; bh=KQ0aEE34Aj/6/
	S03u89yypI1E3Y+iieXBmnRz8N2H3M=; b=Wh9ve5JDOC/pGwUmqQ6EvZ4XcApHr
	hs8AEz8z/K3Z8JsKb1sgd8thDyzoLh2J4SI4OU1q3xt7FBtpFVX6JiFWogjNbYD9
	RyTMPptulI4LgKEsd0IE58B+MiZBk1Fi5b4BjQZ0qXitNxL1+zOOqitMWmxZ59oA
	Uc2ZQQezmJFHTjRoehVU21XDvyGhr2y8kTUVSQ/53jowhZzONZECaH8znKsFkIgi
	bPZubosigr06fdlVtceCmJJXkGf1PrOscAGQdyBZ8b3PyZY7jbeqV0bDuRZNFD53
	V648aRmAwXt+MqIHyU4Ttv2mlF+f2+NmQcCoADq2XOVIApRuQDdaxiAXg==
X-ME-Sender: <xms:QcNAZYsbSYNzeUk574j97oW6RQ4XaObV9Mc-dhjq-gXPsWZNNElgKg>
    <xme:QcNAZVe4-crjcjtpJr89uPvIvzv3lq5H8mezU5QMr59xrqsYYo7KLG8lpFczp7RBr
    pL8EfwlMzN0DkRoRQ>
X-ME-Received: <xmr:QcNAZTz_hSHD-LKgVJh14RC9MAM8fGvyBzz8V0eBH4YahflvQLZFvumGJRAjWaNHdY2hZy1FQJEfelmiS_G3NwwtatLocqUawlbFHrYB-TLv_lzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:QcNAZbMAkUHZpVXAb29V7a8zztubt6ht1M4lWiAvoVtYZjgjN0VtcA>
    <xmx:QcNAZY_ipUxjO4Vxq82hQt2TaCWBW6Q0-D38BkqmgVR-2-qHvtidYg>
    <xmx:QcNAZTWN6Aoqdy5UIh04ce94AU6sKoi58hPDYtMqG1Y6GhS32VM77w>
    <xmx:QcNAZXaE_xDmtbJWq_3vczWGdnSpCczU3xZY28evRcKUYeDjPxcBew>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 05:05:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 89d1653d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 09:04:57 +0000 (UTC)
Date: Tue, 31 Oct 2023 10:05:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v4 6/8] ci: squelch warnings when testing with unusable Git
 repo
Message-ID: <f7d2a8666fed2e2b98652c78b66871a36b4eddfa.1698742590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KpfLWT9HopUQUixl"
Content-Disposition: inline
In-Reply-To: <cover.1698742590.git.ps@pks.im>


--KpfLWT9HopUQUixl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our CI jobs that run on Docker also use mostly the same architecture to
build and test Git via the "ci/run-build-and-tests.sh" script. These
scripts also provide some functionality to massage the Git repository
we're supposedly operating in.

In our Docker-based infrastructure we may not even have a Git repository
available though, which leads to warnings when those functions execute.
Make the helpers exit gracefully in case either there is no Git in our
PATH, or when not running in a Git repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 9a9b92c05b3..e14b1029fad 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -69,10 +69,32 @@ skip_branch_tip_with_tag () {
 	fi
 }
=20
+# Check whether we can use the path passed via the first argument as Git
+# repository.
+is_usable_git_repository () {
+	# We require Git in our PATH, otherwise we cannot access repositories
+	# at all.
+	if ! command -v git >/dev/null
+	then
+		return 1
+	fi
+
+	# And the target directory needs to be a proper Git repository.
+	if ! git -C "$1" rev-parse 2>/dev/null
+	then
+		return 1
+	fi
+}
+
 # Save some info about the current commit's tree, so we can skip the build
 # job if we encounter the same tree again and can provide a useful info
 # message.
 save_good_tree () {
+	if ! is_usable_git_repository .
+	then
+		return
+	fi
+
 	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JO=
B_ID" >>"$good_trees_file"
 	# limit the file size
 	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
@@ -88,6 +110,11 @@ skip_good_tree () {
 		return
 	fi
=20
+	if ! is_usable_git_repository .
+	then
+		return
+	fi
+
 	if ! good_tree_info=3D"$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$go=
od_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
@@ -119,6 +146,11 @@ skip_good_tree () {
 }
=20
 check_unignored_build_artifacts () {
+	if ! is_usable_git_repository .
+	then
+		return
+	fi
+
 	! git ls-files --other --exclude-standard --error-unmatch \
 		-- ':/*' 2>/dev/null ||
 	{
--=20
2.42.0


--KpfLWT9HopUQUixl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAwz0ACgkQVbJhu7ck
PpR3RQ//VD2TTBiLpdUJ1ZOJvjKnw1zDNF8lnIUzTHno208sjL/Yeh4xvxuc1Fff
gM/pTPaUvD3xAD5LlirSFbJqk7n5eOHdeMcbZatkYPzcGCs6k+zyMSW1e12a9dBN
NHqDH4UQ3TdncTs5vNsnGz4/FqiykfRrj88fkTyMAnyoD7cd3aeuTe9XSpf93KI9
QiTbsF7o+k0ONdcTYMpiUGQlZ//lrzOqCy5uT5TqmcCLI4IP9OFVtq74wNzDK204
/4/sScC65AUFYmU0cRbqCwKK2ehTswnkTrKgLTQ661IaW8KSXcYQqqjOqxzTAtmO
CYbaPnTZOd30VNDMlUdou7/L7dfqX1j8P4nbqnSQgStvqqt0FvZ3mMzovsOR6r+1
k0U9KTwPEDT8Cv2knRbNOFJPRYkNaqvu5TyODseJZt4cB6q+HQL18Z6m3wYwa7rv
peJV0XkIIQ5crH64aoWBg3RegQCm1N+6bvbQqp30WFqBMdDQGgezZIbIDj7i7RpW
0waqk15vt3S38YuJzXi4MOjug8zD5KDLTq5JRvMi8zU/mo/bXD1Ao1LUeaqeYJuz
BwKERMU7USN95Qd0nICp+PKsIsPyhxE5JU8F237mBa/Nae298VAi6CpMAQdr8UKX
t/iephqh66fwpXWd13CDunS5MsuepSgdE+GoO9V/5cOxt2FUbmg=
=FdGc
-----END PGP SIGNATURE-----

--KpfLWT9HopUQUixl--
