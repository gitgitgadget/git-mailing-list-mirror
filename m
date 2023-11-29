Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HZiI1H8L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFDSIE5j"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE45C9
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:25:16 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 534A85C01B9
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 29 Nov 2023 02:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242716; x=1701329116; bh=Jp
	aCdMq3Yvr+4aJv4U+w+iGQ9tmFxp4esDvJtl2w+Xc=; b=HZiI1H8LUOl4d6t0m9
	bAIZU+BmC5lB+1Bex0vPLELQ5rRNJnBGT/BQr9Lb8smlIM9/rdTP/TxUTGFGMJs2
	H3n6/sb+avjFo+PvwS+yIB72cUmKdYb5lkN4tFekkQ0sTkWXo/SCs83XxNQoWSYO
	YliypCLc9CeIczqLlC5rOb2tupxDQxpKDFuOnw4iWUfNeE1x598a98dr7R/jMpx9
	KdSAopzhcOefzrnZ/wIPH9maBrLI4ENIr6I896eZudyxmlEqCdwlBfx9CTe+X7mb
	5V5d7PHUp/Gtk7slU1OQiYR7In70dq8Hk8IU9MvpWh2xZdQ8lQH9i6tChDNXTtvf
	wMDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242716; x=1701329116; bh=JpaCdMq3Yvr+4
	aJv4U+w+iGQ9tmFxp4esDvJtl2w+Xc=; b=SFDSIE5jRMG9/VF3UaaADUqKRHSYE
	pH3WGNqbxCTGe9s0CH/0kpQyCDRui2uag+XLGuolkRVIOh+6wAWH1o/Ecv+hwvvz
	M+6hhMgXstpgyBjaKS417St26JlFCT0GhbbCIBfbUnwC7mmsB5bn/IrcVTvwWx0C
	aZzbD9tD9FdmHk45E1wO/UCwd07Su6VIQ5Q7rjIvdA9LZa0+W5XUwDcZCRHl95y6
	/9YhR/Vu2++Eed6k1E5K5973D+qE8/Al97CQYKYoFwyigCJa4B+JJQTxu/1Syz+B
	LTL+JA6Gix4wXXfB1YUJims5wZDJoAg0dy8qXXAXtq/R3kz11kPAcg2xA==
X-ME-Sender: <xms:XOdmZcueQpnNvxwLo4BKMtS6mmNVekZhRcX8Nj7ryx80qNN-KEG3YQ>
    <xme:XOdmZZcaItH7CJ3gfjvEyyw_ERlmK3rYv9kVx_wy6QIKLNzavZR2WMtzPK4Dk_n_x
    NaamvgmatLCg2nQrA>
X-ME-Received: <xmr:XOdmZXxU_RvI5RIcNKy4TqgVhZVM1W3EYeHZD1w53nS7NO1K-DFULlHmBAAURbKgz9wSMwwfBsh2QJWUwC2J9xP7XKsFRMOzsNcPc0p-eh6HnyEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeuleekhfehtdehtdfhffegveetffffje
    ettedvieeifeeggfdufeeiteejkeehleenucffohhmrghinhephhhtthhpqdhfvghttghh
    qdhsmhgrrhhtrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XOdmZfPM9zOkfPkqZWUyDCoMUBqtOdQPPRysG6ldES-eaN3sW5ILfw>
    <xmx:XOdmZc9Z7KiB3fnkTxo-eOJ9PlDkdWJFWOnT8t783kQK_l6Z1pdZxg>
    <xmx:XOdmZXXTDBP-ipsZkDfa4-Yesrmx8XUPtoiAvGOpzszBKewipoUB2Q>
    <xmx:XOdmZVJpgDQkl2B-wyMx5U-1uFCxN7RxyBmoho97VrmDnVwIEdiT-g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd4ec091 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:24:05 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:25:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/10] t5551: stop writing packed-refs directly
Message-ID: <2ab24ea5633be6b4855567d126a184d54c624f62.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ZticYLbTAoE2v/Q"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--1ZticYLbTAoE2v/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have multiple tests in t5551 that write thousands of tags. To do so
efficiently we generate the tags by writing the `packed-refs` file
directly, which of course assumes that the reference database is backed
by the files backend.

Refactor the code to instead use a single `git update-ref --stdin`
command to write the tags. While the on-disk end result is not the same
as we now have a bunch of loose refs instead of a single packed-refs
file, the distinction shouldn't really matter for any of the tests that
use this helper.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5551-http-fetch-smart.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 8a41adf1e1..e069737b80 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -359,7 +359,9 @@ create_tags () {
=20
 	# now assign tags to all the dangling commits we created above
 	tag=3D$(perl -e "print \"bla\" x 30") &&
-	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
+	sed -e "s|^:\([^ ]*\) \(.*\)$|create refs/tags/$tag-\1 \2|" <marks >input=
 &&
+	git update-ref --stdin <input &&
+	rm input
 }
=20
 test_expect_success 'create 2,000 tags in the repo' '
--=20
2.43.0


--1ZticYLbTAoE2v/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm51kACgkQVbJhu7ck
PpQ8lA//a2eFFMOvdQ1c4zLItk6xaavL2Q/aKaqFssXoBuOWCOpGHIth62IxrtRo
BZUhP+igKEif/0tAwpfbynp4n/r9912SHdh5Om3cpeKwmLtMQfrkbKhqL4M1Kowj
sfx3TveXhvqApKenVAZv/RAkoChXnYb0bbhPhjXySIh3IlYa+JGmMkf+ly6j+0Fp
wIUcxFeWBvfvvZvZ/1PzUG2q5TO5SbVGJYZZnQMDiJG1hpdEvOIakkg6VoUVVs/N
SFfXkedPjl2BDW+2SDBHKZ0D02F7hzwIh/w7pn9dKtJK9CWADM6ysx8LeLURMB8L
tlGo12M2cQQwhqHFkgiqZb2ElSC04Eg6IEH/1Zg4hkofaQhAUZR1Htjr2SmUzH6z
wENhoN5+A+TjXWmB+qsRtM8Zda8DuRvswG3s4QsuSAwdNmNvdto1rWp64p3RK85v
pI5ZWz0p/YpUAD1LAUStcK1cMq6q6plhBauxAhJ71fB2eFn+EWaz0JZL4993VTza
EQQQa5RP5zVwaiYXvNzz72dPrWC3Vo4oMDZLOyozpVJQkJ7gUA7YMva/HjuMbgMl
q6yo75V3wQjgBeTsTPJjwxWWfe7LzKmo1NGxACGadEY08rVO8ZBpJd0zx1Ea11MD
S0J/lGaPNpO1Xe7DonXAoR8cPZXAFNlZYWewynGz6JoF2J1t0aw=
=oUln
-----END PGP SIGNATURE-----

--1ZticYLbTAoE2v/Q--
