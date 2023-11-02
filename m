Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB21170F
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w5YosSAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AS/WwJQN"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E1E12C
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:47:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id B6FCE3200925;
	Thu,  2 Nov 2023 04:47:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Nov 2023 04:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914821; x=1699001221; bh=it
	B3ub0wlUXB8wqFpHFoM6XFJ3LGA+aPUpJM2jJUCxc=; b=w5YosSALDYUN2FusTR
	NYT2U4Ah+13JNklxxP7Hy4ji8zWtggXqPftmey6XTlBDfg+6D844zA2p9uR8ZLiF
	hmNFBumWwZrCHT11b2ON1jSiB1dGH5eG1gqzmXDRzKs4JuIpClRh4SRAHyIyug6K
	3zDXN6xPicvUVxazgkbBTeLeit4ldmZrvJKiPPbFweRkbUHwZLsY/OaRMUSsuOyf
	JC7j351RzAdeQK+zrdvXRvyKThcZuatSeCOT6My9LDcDc5vuajyrxlwPEl1US+4w
	t8gIA1wOdY6O9rLrxmrNe0pwIAqQ3ppE86r0LqpvQRoXivipy/zAC6WnD28VCoSb
	mWrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914821; x=1699001221; bh=itB3ub0wlUXB8
	wqFpHFoM6XFJ3LGA+aPUpJM2jJUCxc=; b=AS/WwJQNEkBK+dgK/5Oc3j0xcmikP
	63kjSHi9ChxcB8qBvYL9QENQ7l0PsjUY8UD2XxXiw0oqRlMXZUchmLQSeFrrAt7s
	zjgyJ39+oA/qWr9u4mC6RW+17UGt17euYehqybKYr71x6A6HPGWmagK7by4XE7LZ
	uKZYOgXzTlryhYmp9HK7gwfMvJ3+2XxOLuHcsPBkbvS9YtEqh8fPierDA12n+Q6f
	LOaFAlxr0N9W13A5CQYZyTF4lviPrLJ4XVsosxJ/9Hr+l1nMiyhPs4G9/mRHhSz3
	OUuguoiA9gpf1EoSgUiO4U5lH5XsLe+YYHOqJ9GN0xuYuuhbx+JvfyrRg==
X-ME-Sender: <xms:BWJDZbncEa4CcQQhPNyGYtSHJRybo37-oktxf9Jk04K7loi7Ji50CQ>
    <xme:BWJDZe1Ma1qgXO_peqfL2IiS8M4vQ-yN4Nn84f0AxN6ZIOadjLt6hKeY_Z3EicdAx
    ftnhDSWwDdQEboM6A>
X-ME-Received: <xmr:BWJDZRoHqU4uN20-UA7QKjBqWV7dQdxbwkOVij9hlFdm5uSEyY4Fcmq582K0_UKgjvrMUHFZtv-Zk8fMzc0bRsmpg8IKmy-SGkAiwFpNlw0Hzd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:BWJDZTnONLfkeOl4j8WZgJY-j1zUgfPFYraEE3bqpY6vQZcRy2xKww>
    <xmx:BWJDZZ3IkjmeK02FT972hnRqiLxXWOOPzqblhar3IagWSaFNUnvu8w>
    <xmx:BWJDZSsVX_vq-0J2gBTpCCfv6vnf4-PFJePNLGP3KRGZoLkEW1WMzA>
    <xmx:BWJDZSzVRh-JXI91CzSDts7IsZPI33jRwdmOEH64E5AcTvyAVI7ztw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:47:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aab7bbe3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:46:48 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:46:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/9] t1450: convert tests to remove worktrees via
 git-worktree(1)
Message-ID: <a5d55b6882845d1ae0885b3fc879d3167cb0e816.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698914571.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wnGMdMoTMSrPX5Hw"
Content-Disposition: inline
In-Reply-To: <cover.1698914571.git.ps@pks.im>


--wnGMdMoTMSrPX5Hw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of our tests in t1450 create worktrees and then corrupt them.
As it is impossible to delete such worktrees via a normal call to `git
worktree remove`, we instead opt to remove them manually by calling
rm(1) instead.

This is ultimately unnecessary though as we can use the `-f` switch to
remove the worktree. Let's convert the tests to do so such that we don't
have to reach into internal implementation details of worktrees.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1450-fsck.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index a3c97b9c7fc..a6af550867c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -141,7 +141,7 @@ test_expect_success 'HEAD link pointing at a funny plac=
e' '
=20
 test_expect_success 'HEAD link pointing at a funny object (from different =
wt)' '
 	test_when_finished "git update-ref HEAD $orig_head" &&
-	test_when_finished "rm -rf .git/worktrees wt" &&
+	test_when_finished "git worktree remove -f wt" &&
 	git worktree add wt &&
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
@@ -150,7 +150,7 @@ test_expect_success 'HEAD link pointing at a funny obje=
ct (from different wt)' '
 '
=20
 test_expect_success 'other worktree HEAD link pointing at a funny object' '
-	test_when_finished "rm -rf .git/worktrees other" &&
+	test_when_finished "git worktree remove -f other" &&
 	git worktree add other &&
 	echo $ZERO_OID >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
@@ -158,7 +158,7 @@ test_expect_success 'other worktree HEAD link pointing =
at a funny object' '
 '
=20
 test_expect_success 'other worktree HEAD link pointing at missing object' '
-	test_when_finished "rm -rf .git/worktrees other" &&
+	test_when_finished "git worktree remove -f other" &&
 	git worktree add other &&
 	object_id=3D$(echo "Contents missing from repo" | git hash-object --stdin=
) &&
 	test-tool -C other ref-store main update-ref msg HEAD $object_id "" REF_N=
O_DEREF,REF_SKIP_OID_VERIFICATION &&
@@ -167,7 +167,7 @@ test_expect_success 'other worktree HEAD link pointing =
at missing object' '
 '
=20
 test_expect_success 'other worktree HEAD link pointing at a funny place' '
-	test_when_finished "rm -rf .git/worktrees other" &&
+	test_when_finished "git worktree remove -f other" &&
 	git worktree add other &&
 	git -C other symbolic-ref HEAD refs/funny/place &&
 	test_must_fail git fsck 2>out &&
--=20
2.42.0


--wnGMdMoTMSrPX5Hw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYgAACgkQVbJhu7ck
PpRNTQ//Qz7jHmVFt4QnsZhN2hB7BKkT0n9mhIFHqEbeHMEXulKGGF2M9qe7ZDCy
CMHQdXla2k6wMYwjawTkVa3AyYVS7tbD6AN5EShA+7fU9vxAmwTUBPf8jrQuQlMA
r7sSRJ1sBGNhqhDDtb9fj63KsPODpWVBh5XwzC5p80uY6V1laBtSRpFSzUUCWeDo
U9hUKmYSwvZR8KNRi2MJBZBwxpihGWP1CHS3SHbERzUveIajfcK6QfrkD+DQqriD
rS0H/RTy8jxXbmVy2rfy6qPHLfwd7WTzi/e4wsQOzBn0+9s7MJnWO3FIZSDXND26
nPiAnFImaNqlAMC1tzoaFfP484TYXt5JVlVNvMFY3W0zCVxEmDa2VOM6ssKqls2A
wvtNoDjtqhbOqq8bj9MjD4Gh3dXRUKJ7zDEWNCINHaV8yIBcDIBJVMFVnAo0cwUl
sj1OpOJk+Nn7qLr5BbIJEg/kNP7XEmC3j1RqvH6jY8GzUi01B/2XL9e1q9DWshb0
+gtcD7iKBHvmHQ9ppvfjE5SNgpxRXfmKlLHy9y/o8KszXDYi9chaBNcMYxJv1Z5N
e7Y6yxwW9yka9U3ohilhZT2zLADit+0bIl8AWI7agCuqis6iIJGxlTUFIrzvmfsd
r+/8JoEZ+ibdDuMMeYZKQap3ty4hMSUEw+9ppwCBraw57TSPcA4=
=WtH8
-----END PGP SIGNATURE-----

--wnGMdMoTMSrPX5Hw--
