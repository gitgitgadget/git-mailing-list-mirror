Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96DE28E02
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZlSt7Wkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jn/rG4w0"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74AA196
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:56:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 03E1C32007CF;
	Thu, 26 Oct 2023 05:56:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 26 Oct 2023 05:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314205; x=1698400605; bh=AX
	H4vkAgDBd5Zi4eITQJDs0SX1hr46jyNzVXAzoNK3Y=; b=ZlSt7WkpDmvoELwlca
	pbVlwdUFZ2AGQHhHOSlccIVG37DEBT4nsBJhyw1PWgXYJqasP9MrAgS/+MMF+z/j
	WK0QWe5AMIbob8uIGESpGwQ6Un9qsm+tVj9XmKYnoJqsPhufPXANAw7sOkZds7OJ
	nIju/7AfMIcE5ZHk4qSdeG+jyQjKqq2tuK3e9cHp7BbrYTk/nIy0BC2mSSCPLUF4
	hymbLbViJPKIIuiivngzezsiQ057QhE1j6XKbaLOFKfhZYSWjtEplj/Jx/OufVrr
	v88hgxU9GejOMU/3wYRtFJRvx3wkkEhgPXE83PzLpp993zMGH1qU49fF7XXyGj1Y
	CNFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314205; x=1698400605; bh=AXH4vkAgDBd5Z
	i4eITQJDs0SX1hr46jyNzVXAzoNK3Y=; b=jn/rG4w0ugns27pgxwEWxkzbMOvQ1
	/FcFVtm4q5HkWK0xbY9Rhu5FHbWN7yqX7jF7fa23USAKXN17tcRrL+EOlmMlmggm
	4VeF5DH8LuVsPL5R6mAGhd2H2RFP+nfRKy0ucQ5IQEWfpHfB4HJmoL2v+Eo26+kM
	5n72XdZSlecTmtyPmS2k18ozl2OokvOFq3X3ML0liRa0YayyChDZG6Pm+l/HOEbz
	tUl8+2GJmEOrmMx0tg2XZhYmv1PttNQKMkq51uREPyJheMH+4qr7/iUHzQb3gab+
	JJmEGxdg9Ep9txKpfijYLr5km9Yj4pnhn4xuQSQBR8/N0WWW3idO8y0Hw==
X-ME-Sender: <xms:3Tc6ZaZs_1ohnK5QH_OhgcoluMW1_J7e_BcFbkptvJ8JhbwlhZ6yYA>
    <xme:3Tc6ZdaCXJ_ETqsBxq6mjNvmb9U8NGt91pqTRSq8jPgMR4kzeYupVVnXoMIHWlmhK
    glQBcndcULTVALOmA>
X-ME-Received: <xmr:3Tc6ZU9RmCCNkWeLHeKHEcTkQs3bZHYajw0KYiizDtViy_b6Q97dKLPpxUHxlW6nnyPAj-RFQrlFhRw4fROCQbOorbuky8NR_d9fv83tBxTot5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:3Tc6ZcoEn3VhQcK-kGZvWMfn1HlrOfXKpXRXG2CQ_DIXnM2nN-LmFg>
    <xmx:3Tc6ZVpKfsXMwAoDtFh5bg6xAtMbOoawh31d6R6iwXHeLu1DhuOCsQ>
    <xmx:3Tc6ZaQgcaUG2VeW4qUedUR5Ti0FTb3lH2CT17hQgkSet_jkI-VVCg>
    <xmx:3Tc6Zc2IQkdn7qWVCtYlQENFV-fnMUH9VTF0eaLGM5CT6vssprVnlA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 08adc2b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:35 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 06/12] builtin/show-ref: stop using global variable to
 count matches
Message-ID: <d52a5e8ced2adc5c9315edea9fc497d1ffa30125.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YmEu7Ks9gk1lIfgJ"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--YmEu7Ks9gk1lIfgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passing patterns to git-show-ref(1) we're checking whether any
reference matches -- if none does, we indicate this condition via an
unsuccessful exit code.

We're using a global variable to count these matches, which is required
because the counter is getting incremented in a callback function. But
now that we have the `struct show_ref_data` in place, we can get rid of
the global variable and put the counter in there instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 90481c58492..c30c01785cc 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -18,7 +18,7 @@ static const char * const show_ref_usage[] =3D {
 	NULL
 };
=20
-static int deref_tags, show_head, tags_only, heads_only, found_match, veri=
fy,
+static int deref_tags, show_head, tags_only, heads_only, verify,
 	   quiet, hash_only, abbrev;
=20
 static void show_one(const char *refname, const struct object_id *oid)
@@ -50,6 +50,7 @@ static void show_one(const char *refname, const struct ob=
ject_id *oid)
=20
 struct show_ref_data {
 	const char **patterns;
+	int found_match;
 };
=20
 static int show_ref(const char *refname, const struct object_id *oid,
@@ -78,7 +79,7 @@ static int show_ref(const char *refname, const struct obj=
ect_id *oid,
 	}
=20
 match:
-	found_match++;
+	data->found_match++;
=20
 	show_one(refname, oid);
=20
@@ -187,7 +188,7 @@ static int cmd_show_ref__patterns(const char **patterns)
 	} else {
 		for_each_ref(show_ref, &show_ref_data);
 	}
-	if (!found_match)
+	if (!show_ref_data.found_match)
 		return 1;
=20
 	return 0;
--=20
2.42.0


--YmEu7Ks9gk1lIfgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N9kACgkQVbJhu7ck
PpTI6xAAk5yuiDZ2hNAFi3D2wRJL0V18FpK84qoFob6tBqjr7MoHsA4S8jHpdE8e
9q0dnd4TXMBdGaBpc352udkhyGPkdTuIdr6DTHWsed/WBYb7kp1S1mYHDx3x1MBX
C7dlgHmn7lJ00dC8h0LD25xIWwAin66E10/TwYBs1j7aRifkxpKoCFcadd1Jx/kc
rtxjpzgZ6GTgo1KXja58+yLZ9JeFrVLc3P77TbuthZXHJf7TRC3+1eNcmL+3v6D3
ovRWUWkyG/ljKRTIOrm1QBobRi0VqLvy5bYmx52MvyO19N//FQk1BCM4Gwf6b2+L
NUd4Jq8ViGJ6RavFw9aKkVFNcNQCbM+C2/Y0B3602taSjBahwn1GuV60PXKfK0uY
dD/l4TNz5UwmWkwp52y4jCGoujBf8QSg1BGc5t3wvULdTeo/zgVPufWBV9rPP68J
m1DgxigHckRi97LNXr7hmd2dkn4PJO+UByCwxm+IKs3D1obyv2B/oUyeCFhRTuCl
XyPowy83hIUz/E75sT/lYu4fkFglFuHiKRJKEOiTAzPMSEHB3vRH+q7SB1uVo+z8
tbAWdPGN2CcrXZ4H3kO7ukAxD+JpWnOywW5FqOqsm7FK4Q9hhAepcXn4Cyqw8Cnd
leK2aqVQtFnxKeY0EK2u/J0l3GpArOdx8/iG3x8OYxCHpJYBR6A=
=ozFn
-----END PGP SIGNATURE-----

--YmEu7Ks9gk1lIfgJ--
