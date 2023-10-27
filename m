Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C3168CF
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AZXjzYl/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCKqOtqA"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E20D9
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 02:25:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 676685C01F3;
	Fri, 27 Oct 2023 05:25:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 27 Oct 2023 05:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698398735; x=1698485135; bh=lZ
	Rk2Exn8casJKCI8lH7lZ9RBARB2exsyG4oHvafAe0=; b=AZXjzYl/4c2xxRMBxG
	NV/x0dqJqK1ykY3EE0v8QI3lizCSsk9p+Zjz5wEBe581zBfpaRoOuZS39IfIBGZZ
	aBKn0tMZLJAkh9Vmywc9bhiE96FMavT/LnSvClv/fO6DTiqp6D2JvKr5gHEMuxvf
	0NzeLySOF5DsIi8GGPtIlkupQT+ilSLDkBsHFOzVLS+20dps5z7fE3ozAAZwW84W
	lmyYwyPuN5Y/AUm0X3B0J+UuIKMf0z085D0ugd/mDmKdySqtBicqi+5obq4UCK0i
	m7oM4wBpeoiKO9LrctC145QYOBspMYHXpOOST8B86HSOKcGxVrq+M4HeQIm15bz9
	Ah8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698398735; x=1698485135; bh=lZRk2Exn8casJ
	KCI8lH7lZ9RBARB2exsyG4oHvafAe0=; b=XCKqOtqAplZSP0XPx9Jvn/XblP/2X
	xKaE/X1foKug8DsC6ZqdaGrB/E26S78xY8bGx1Ox4xj2jVwi9UWNWheXwJWrZGeS
	IgPqq8tYYKQFk42Mh7r3oNtK2ZcbNxa5RK3nNSiKA31ZJZg5XdV+1/M68tT3593L
	qG9ajbo7T39d9+5Jnrt5dXYU92ZRvESQ/xc0uQVHm7wF9EbN8EST2amgDahRch1V
	ZhmExJlPVr+unOd97G1QRuTESN/RBd7D/vsngYzbFiOvIPy/H5NcVt4fJ5QQXfhw
	puRmWflo8zgixtLc9mAQhwANlRI1ZKYJmm/wTMsN1645Ix3BJIojuZgSA==
X-ME-Sender: <xms:D4I7ZYA5Bd7P6eUZMIWT0unheFOwkhDnHVTsH1SB3TTGiZwS-OYtCg>
    <xme:D4I7ZaiX2IOtCQrjZ6GGpx6YvG26fpbQukW4mf5ML7CK-nfKfmKpksg1H5zOkKSVY
    ur4bL6ag0l17qHtkg>
X-ME-Received: <xmr:D4I7ZbnauTHNGaam0vnDvu3-RLCFU_AOL8d62cP1r1qKWGB1tki_nQDmX3bsRTOlqAFzAxLC5CRM_PCGqhVkyaPR2f10aXeTwqQVwXJlQi5JVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:D4I7ZezCE3z1KQ8J1oiqGqLGhgVhzqQ-Pi1bl1jov7Ff97reOwPjew>
    <xmx:D4I7ZdTKXSu_fGoTRlhz2jTxT5qakYDQM-YeF0lg0ksyl52oUZITpQ>
    <xmx:D4I7ZZZwgA9JlgtPSqrhq7tyRDV64hENzuJkW-TlJO4h_8w0uDh1oA>
    <xmx:D4I7Ze412IMY0VAUvCeefZeLEq3GZMP2dIfow_IEo1wdW1vFT-MnMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 05:25:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 142af336 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 09:25:23 +0000 (UTC)
Date: Fri, 27 Oct 2023 11:25:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 3/5] ci: group installation of Docker dependencies
Message-ID: <57bbc50e3dc33b5f9f0a0b0e70b84cc49c14c55c.1698398590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FNR13/B9U9Nk9PzI"
Content-Disposition: inline
In-Reply-To: <cover.1698398590.git.ps@pks.im>


--FNR13/B9U9Nk9PzI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The output of CI jobs tends to be quite long-winded and hard to digest.
To help with this, many CI systems provide the ability to group output
into collapsible sections, and we're also doing this in some of our
scripts.

One notable omission is the script to install Docker dependencies.
Address it to bring more structure to the output for Docker-based jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-docker-dependencies.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index 78b7e326da6..d0bc19d3bb3 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -3,6 +3,10 @@
 # Install dependencies required to build and test Git inside container
 #
=20
+. ${0%/*}/lib.sh
+
+begin_group "Install dependencies"
+
 case "$jobname" in
 linux32)
 	linux32 --32bit i386 sh -c '
@@ -20,3 +24,5 @@ pedantic)
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-de=
vel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
 esac
+
+end_group "Install dependencies"
--=20
2.42.0


--FNR13/B9U9Nk9PzI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7ggsACgkQVbJhu7ck
PpQaeA//cxCDBsvUG8vlwDpORNTtw6H6YqGo3MkzdJCJ3WzjO+GgQHCaabtm20uY
1bZtvvFwHr1VxUqGBsai9BrImrvmjvE96IbM+O9jI5/0jWe2nxwVXcvaDvE10820
uLDsdORJ4cLw2RmLvXrQlt+yzparRWL6TMtHCzYnFewRhnfakO/edK2aWyPHlrE+
sBn9TXHRq9giKhM2yyM/0umxedBTmRVHbQ5k66bRkm+OgIcP51puLhCSXOIGbCF8
J5CE3175TDXz4CIo6k8xjuH1T0GI8ikwPfYi8YgKNZxMizVN5VYKmyZ6SVDJkfrh
WABTpydVbB+P179JFSltMlSRej/3CbzLz7NzaWbmuOf3Nboln7j00yBg/LHfAT81
V3ZgHoJ7M7+l4xiKqowheLRezA0jP97NTHncf7rHIxevBOABhGi0H/J3Rget2Df9
YHWrTyZXR4oONELCu2SS+vmcYlhMYaiSn5zUB+KV+YvjNT/+oB8sZJK5yxfEBOSD
UxetcOWNxZ8GR57EhF9KBI/YbadGPGDqpWWWSlJF1dc6SsJ5t9yXcVeE22yNjOQF
AGKNa4raOK3+/hJho7ze0ut8y1N4+Iqr4dLnEk9i7CUKV0VIbNAYqZzRn0owckqB
BiYhZnuZaCpWxCZTs7/QMtT0hqWvyF+e/SYEmQIDHeJESwk5r/s=
=kM8A
-----END PGP SIGNATURE-----

--FNR13/B9U9Nk9PzI--
