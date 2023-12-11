Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Go7MMFve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bEDBbi0t"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08014DF
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:07:38 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 2288F320261E;
	Mon, 11 Dec 2023 04:07:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 04:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285656; x=1702372056; bh=3K
	FSWMNUw2QtyMjQHIzOfM74ETwtxfNqimrqZipOlhU=; b=Go7MMFveDvoHzPI+DE
	zw8oT5l5+HEA5xxeWGjDIy2PHRDI2P6Z03JpNjVNeU5I/ndC+EHioWyjsPESi+a3
	JEQBaqdTKiCD4IYx5huq2gcexw18nmS/WjfQU+tUgAOp75jLSyw+GAWMM4yjP6oJ
	kSLLI0tnSNJdsNkS5y0Ut4PwOo+/2eA407sQUBuCZscBYWSruEp4aDjiPKvy4q0I
	JvdEydi1uqGANL0A4wwdyxPv2kDF6DkwRoOv6mZslH2vqroNOH4jlosZQ/hIB++k
	qO/Db60Px95ZJYeVm1bcSJen+e5fsKYF958gmT0R/wbp+GviJ5FWuB3LuQtLaNk7
	W91g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285656; x=1702372056; bh=3KFSWMNUw2Qty
	MjQHIzOfM74ETwtxfNqimrqZipOlhU=; b=bEDBbi0tNjkw6g2gsahRKquJSbOyt
	HlwFsTsz5TJIqbJsIOE+fIBub0fQZ4xlIYvLWe6/GuJ5kmavY7MDDP68cCwoZK4y
	a3pgYCd95WLVPb8mu+AueS/RDPvyPWoG2yQTaAmGBXo4a9FgbDhXbIDdT0DDA1bd
	3UJEYL9VzTU0jbic5ms0BeOgyFA/U9T9UHSe72dZ4SParTe13SdIWloXQk5eEb4O
	1OAxSl0Xl/lLx1RSSeS9qpqE5FsTNrHA0bBpp8Q0CTuDLYy4UHRHeJd0p8T3RFlP
	LZc4jZ9cQrLNF3aMVZF1cdG7yasgULJ6jpkcuNfXjYlT4voRA29Gf5kOg==
X-ME-Sender: <xms:WNF2ZZB24OKooqMW-mKom-dUUjotYXUlFdfb2m2LJLQhUsJuOEYLfw>
    <xme:WNF2ZXj3zbgomzA5oY3Bp9uNPMIEttjMbqGl7xTL698_0x1Z6JbCSXcioS9ztP6Zq
    waPd_SryZzbpGaPcg>
X-ME-Received: <xmr:WNF2ZUmGCOY3HLPoJSGwR4X6B_GxAyZVNy6IQLVZE3JEj6JpCAaaYd_c6xPTFIcyToapEsRj9G69sVRBKQXtvv4FeG1oCG29Zofz5B5xz7pKzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:WNF2ZTwvdvjdQAU2WptAkRLelDSvNf7ntMyX72FkUyGGdvL46LibYA>
    <xmx:WNF2ZeTIVci05bsHFoImGZCmnlkmRlnNypi0VCX1LRUQ8syq_5SoUw>
    <xmx:WNF2ZWb9GcqJ0IyYIYH45JxByUmKGcn5cAlHeL5rAzw3Z_T8pSt2tw>
    <xmx:WNF2ZcdpIhF0hszaCVPBB3CglvViT2zcA99aEBTnMvrbGLP8ZP2Uyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:07:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b88dbf0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:05:59 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:07:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 02/11] reftable: handle interrupted reads
Message-ID: <3e8e63ece52c507296b012be6632dbed568ff97d.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gm6mPv+x6/8FqvtZ"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--gm6mPv+x6/8FqvtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are calls to pread(3P) and read(3P) where we don't properly handle
interrupts. Convert them to use `pread_in_full()` and `read_in_full()`,
respectively.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 2 +-
 reftable/stack.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 8331b34e82..a1ea304429 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -109,7 +109,7 @@ static int file_read_block(void *v, struct reftable_blo=
ck *dest, uint64_t off,
 	struct file_block_source *b =3D v;
 	assert(off + size <=3D b->size);
 	dest->data =3D reftable_malloc(size);
-	if (pread(b->fd, dest->data, size, off) !=3D size)
+	if (pread_in_full(b->fd, dest->data, size, off) !=3D size)
 		return -1;
 	dest->len =3D size;
 	return size;
diff --git a/reftable/stack.c b/reftable/stack.c
index ddbdf1b9c8..ed108a929b 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -92,7 +92,7 @@ static int fd_read_lines(int fd, char ***namesp)
 	}
=20
 	buf =3D reftable_malloc(size + 1);
-	if (read(fd, buf, size) !=3D size) {
+	if (read_in_full(fd, buf, size) !=3D size) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
--=20
2.43.0


--gm6mPv+x6/8FqvtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20VUACgkQVbJhu7ck
PpRrnQ/7BiRJBXtilkfW6/rQC2fxKVe5JrztEmn9u+76jdt75zjsgCqVBxOmjTp0
Buhs//sDMgPlZrm1PH1q/O6RV+462D0JA7aV4DL1i3WUAD/g162ALdhjECtl5AJt
dyPAQpz7K1eqZjACH5IAlK/BtMfTwvqTCB64QNWb66dKMB5L87Po9cAjpayqjlrV
hIme0hHWNlsqBW8VAOhUh1j41CmyiRMco6AtOubwDjPPY8wcKVohJV7Vp3dDEqlG
QL65o3ZSPVrKOaXdfQX3Inud0vEN1+P68TekIMk8OaRHbaSOpKVR2QR9RKVSIo1c
aBDx4L6qORYi8MIp/5puzoYkltkQde8xrQdTo6Z4d1TZO7/fXkKYpcnF/R8BgABT
Kg7ZKP0iTOQE5z/Xb8kKt10maNk/NULcoqS7ddii1PsThJ2Sz9XdY2ohkkt5xxEA
s4t6ZlWbPIxm6Sk7l91NlCayI7wcKlIYi4rv/SZy79ItafDU4roKJdlHv2LQaCxw
h1H/FyHRodGFd6Z5RKQlV3E2fUI+Kvu+VYA23wNaPFiZxEiTApeps8aE6b/fYxqe
YsBXtmR4kchStT2EAtC+a6p+Y0LnW7lizu8SrFveBYv31xOd9pVlo/3/NfRzz3/q
3JtDbp2cEw6QBD5SRw85dWb/wwNnR66z8t2pQJxOJRsTJ7vPK60=
=PUsU
-----END PGP SIGNATURE-----

--gm6mPv+x6/8FqvtZ--
