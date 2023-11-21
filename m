Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tALavq/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pm7idLPy"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1716F112
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 23:04:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id D22A55C14AE;
	Tue, 21 Nov 2023 02:04:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 21 Nov 2023 02:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1700550250; x=1700636650; bh=cUCyypLxw79v7WDJ3ntNm4SUG
	HheEUAEllFzJUGWfJY=; b=tALavq/cqYMipPSgyimo5QGTZp8bF/HtGxmtdOLfn
	L6iYqWDLGqcqiUxopZ8yB8Xyjse/ylOBzHRO/QwqRgbj2ZpBfD0vdMbQHeVbcYdr
	aOGSroC5zUPnjXMj+m6VSMVWDyVj5NltsTHYeBROcbaKegoHg4IqXEbeU4FaNFlY
	ZAkbSLf2ctv2BNK7R7KQeCMEeprWkTO7jLWBxPBUnpmpZZ5yQ2w5qslBJpjuKS+4
	SWRWRfD96QvIg8Z8acN8keQc1O3OSig2i1RLHIQCM0vnI50hHWOsYxvjoqGg1e5T
	qldcxiaIFtG05VdIJj/Fttncc/czOSNqJ2HX0GgP57Ixg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700550250; x=1700636650; bh=cUCyypLxw79v7WDJ3ntNm4SUGHheEUAEllF
	zJUGWfJY=; b=Pm7idLPyQz9CcjaBxrolDigVdRDbr8tsI44zUH+1Ggc3uWl3dXp
	epTgxexwiJHoh7HH4bQ2GlN8CZxb/S3lfjSTQlDV2FLaBvfWtXhBH38I0PpGEpaW
	oIxobEPJ1B3gh+Pbo4vGNnpK2lT88QKqZtes7mGSwvPmvOYBHMydoXFtmsV3ksap
	6LYCOiE2J1cTaav8V0B1soKFdEYqhppXeL/r178g9YjeAOA+X5RHiAJY8lX0yTgg
	YfFvnHhRoiTZPVVLCBQ8DdN6pIjISUB9K/IILCAIO/WSXTP63LIhVU0Y3ymuMfK/
	D8i0U5qPF5nVtnPtYVkbPtE6ETLFEF9Ro0Q==
X-ME-Sender: <xms:alZcZbuRTQ7QEUfJqQWCxtOneSt9B7HG91bU5fcpw7b4dC9J5hOM0w>
    <xme:alZcZccqT5JBSqbeeysec-VdI8XWP8GyPgkK9VRejDXreiCixyGMcHLKtKwdIORQb
    Ip13V_pUALH1_FXLg>
X-ME-Received: <xmr:alZcZexY-GT2tCHv4s1rZZCFYsmsfuzXsft0YXmLxn2sTcS2nNHr_2xN4QAdwkvWUeZD343mNVS-ybFSCVNeDsy_RGVjUvJdrtedJV9QWpqO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeugfeutdeuieehteelveegudejkeejheeljeejhffhgffhvefgkeeukeejtdeijeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:alZcZaNQFQRn8SCc_ra-nDMrdZMCJW6zOBoT2rGY-hjHgNRT7ZMtZw>
    <xmx:alZcZb-LDdDjUSmCcgkVhJxhfiqRcVY05XBo4qnhTXWqKcpC2RveJA>
    <xmx:alZcZaW2TLioFI6_LOenOjfsJ7YsF5tPZX562ErWGctqMpPjq3FaiQ>
    <xmx:alZcZVmtusMb24DKCYht2Yy04JdIY5ocP4SE7MNAGxI7YPdIf_iUbw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:04:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 417bab06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 07:03:15 +0000 (UTC)
Date: Tue, 21 Nov 2023 08:04:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/8] reftable: small set of fixes
Message-ID: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L43WsHlxan6gFEkV"
Content-Disposition: inline


--L43WsHlxan6gFEkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

while working on the reftable backend I've hit several smaller issues in
the reftable library, which this patch series addresses.

We probably want to refactor t0032-reftable-unittest.sh to plug into the
new unit test architecture eventually, but for now I refrained from
doing so. I care more about getting things to a working state right now,
but I or somebody else from the Gitaly team will probably pick this
topic up later in this release cycle.

One issue I had was that this patch series starts to use more of the Git
infrastructure. Back when the library was introduced that there was some
discussion around whether it should work standalone or not, but if I
remember correctly the outcome was that it's okay to use internals like
e.g. `strbuf`. And while things like `read_in_full()` and related are
trivial wrappers, this patch series start to hook into the tempfiles
interface which I really didn't want to reimplement.

It's a bit unfortunate that we don't yet have good test coverage as
there are no end-to-end tests, and most of the changes I did are not
easily testable in unit tests. So until the reftable backend gets
submitted you'll have to trust my reasoning as layed out in the commit
messages that the changes actually improve things.

Patrick

Patrick Steinhardt (8):
  reftable: wrap EXPECT macros in do/while
  reftable: handle interrupted reads
  reftable: handle interrupted writes
  reftable/stack: verify that `reftable_stack_add()` uses
    auto-compaction
  reftable/stack: perform auto-compaction with transactional interface
  reftable/stack: reuse buffers when reloading stack
  reftable/merged: reuse buffer to compute record keys
  reftable/stack: fix stale lock when dying

 reftable/blocksource.c    |   2 +-
 reftable/merged.c         |  20 ++++----
 reftable/stack.c          |  71 ++++++++++----------------
 reftable/stack_test.c     | 105 +++++++++++++++++++++++++++++++++++++-
 reftable/test_framework.h |  58 +++++++++++----------
 5 files changed, 174 insertions(+), 82 deletions(-)

--=20
2.42.0


--L43WsHlxan6gFEkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVcVmAACgkQVbJhu7ck
PpR+qg/9Em8SkS6MwcpV6jHuGlKlclcolLE60r+uU8gIjfrmfRb1Kn9GH7fzfEqu
fU4DJdALowmT9Y5MokbWmGxtJeocrKlPr3XYirZPFyXlD+B6AX+12nKw3jIJdP8q
C5FTTfqjooopcjvJJH6r39UdH0dFOcaD33PUNSk1Y4FwbzD+WGwktNPtpfNrIrvJ
1X3U3TtT6PaAYt23ttzPS6ZaKnw4t7gvlNEMvgObscQ+CfTBZpFK1DNNySkDD04F
KLAJDJcjizs1MT0MPS8Wv980F9Uo3A+EFSvg4+MvlLCotP63vPqh/aMs29to9d6O
GcLtMmbPm358tn48zq6W5jdNo/47ef0VHvuYiMzJ/ox7NyYPbltjIwLjc8A09Z3u
/W0Gw9Fo4IAIPtyogKVckVnGkCACzy6YYZ4A3lSZq6MWXwTipTDyP4mDeU6F8cRL
RWFAOipjHJ7j6AYvlwKbuLzAI38uoZCLnPPsjqBMvnVknBp1hOaTVmWsMGCTUqQy
9KDbcrP9onE+FwYKIJzSmEA+CP1XcRHS/l4t0sXGC1PbMDJeXYeOGl4iMWw6gRS0
gQYnei0S7z03F5sf+qNNswLivD+3oHmGojSjCLEYH57IR9XLN/gq3aEB/BshTChk
sgFrDz88FseamVLMzv2UxlZclcKvfODsdjTBoU1c+vKDwkBziqg=
=UlwZ
-----END PGP SIGNATURE-----

--L43WsHlxan6gFEkV--
