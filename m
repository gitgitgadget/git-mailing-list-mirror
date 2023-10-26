Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542EAD29
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dpAFb1tw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PgyVacrb"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D3193
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:56:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 6186F32007CF;
	Thu, 26 Oct 2023 05:56:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 26 Oct 2023 05:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314191; x=1698400591; bh=gg
	nnzXfRmgrGhL78fj84VpDLFaxq6+ybxpC5rh2Q9Qo=; b=dpAFb1twtz/qwMz5i4
	gMjNenbipLoozZAhvfMffN1Yp1ASd5L6TRSN240+KJqcpJ/r9uHoDuNoY9OiPvqr
	F+QRbFRx1kc+JSJQyjYM+G/F4Hqv5v7GiLD+Ad5ZV25ro1n8i5rqXbUKoFDeYcNC
	pbVxnNyzzGyKZdasdYZyrAalWRa7qeRjm5BiEp3bJ2liWPYI5Ir6S8tEJ8/lXEVW
	4b4wgPRxZhMGIoAbCWcolbweN/jVriY5DX5cZ5+35jUSZdlcl+4b+3z7ZM0VZ6h3
	1FpYax2/DK/fHziAe+GPmdNPCJ8Zoin+2Xv4amSTEhECN0Q7vd7KCzTuTThA1aKW
	aatw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314191; x=1698400591; bh=ggnnzXfRmgrGh
	L78fj84VpDLFaxq6+ybxpC5rh2Q9Qo=; b=PgyVacrbhwnvMkRWSVIjrhWQbxwvl
	v188cMqsHqz7JhPMaAqexxLLo3h1BOMqLYYCXCFqjjWP0e2gERkhCAeP+olCjiNH
	kIbjyJa3ux3f2FS/O6RYmcxNo4SjaXDH/4t3C6redeMRgqF4ildw+Um8fj6XWV1B
	hc43Oru8VXptXTpRoSdpFIS16GrWqru2nHTAdj4Em4E+XucdIkQB5k3UMbZqWoY1
	dpkvZS13ugenBfKrQMxQQzZI2HyB9QNAP8GAEfjZ7AeRZ71he+4yRnpsGOigdGD6
	amI+/wjsNNolnlVhHicGUS63irQVVDmCYlZD9rxKxoE7Fx/opXGNbmNzg==
X-ME-Sender: <xms:zzc6ZZLfCtNSfl-XWpFRexlcKfNdrMQ_PIBOwJ12B9PGYmD6yopr-g>
    <xme:zzc6ZVJ5DJ_y-cJJ6uhoZjvB-pzlyorePS-YOk23Uml5Cy8WZoDAqxv3Kp6hjDHps
    DnDAFEx5Hs0PmhG0Q>
X-ME-Received: <xmr:zzc6ZRusR9ivXxSO9MWPasC1aG16W-1mBIo8sGyc9Ihu_p4KnaZDjSIIinQPBhsJIGg6R3FRaAzCElQYGc57FPGHzEmmmrDq5F_VyKavAGYPVUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:zzc6Zab169IQ9ooTWxjOfj0wr8sVcOWKgfVxbxmgvgI_BV79F6GNcQ>
    <xmx:zzc6ZQaAdnKzcxRSXUnpj73b5OTsdhoqb5seUJGpBMGJmkrjMwNiLQ>
    <xmx:zzc6ZeCC6O0K_LEJuXtLqH6PP3pu2DmXvIf0gzrC2fq1dggkcurJSQ>
    <xmx:zzc6ZflHc1JjEobJ6KAMKD1iqGLrNL22DUMitbHaFxyrlgYhtYwXOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56f3f324 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:22 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 03/12] builtin/show-ref: fix leaking string buffer
Message-ID: <bb0d656a0b40b79c90dc2505239976a93f18f432.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="muSHVXrgroJF1ZMA"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--muSHVXrgroJF1ZMA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix a leaking string buffer in `git show-ref --exclude-existing`. While
the buffer is technically not leaking because its variable is declared
as static, there is no inherent reason why it should be.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index cad5b8b5066..e55c38af478 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -106,7 +106,7 @@ static int add_existing(const char *refname,
  */
 static int cmd_show_ref__exclude_existing(const char *match)
 {
-	static struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
+	struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
 	char buf[1024];
 	int matchlen =3D match ? strlen(match) : 0;
=20
@@ -139,6 +139,8 @@ static int cmd_show_ref__exclude_existing(const char *m=
atch)
 			printf("%s\n", buf);
 		}
 	}
+
+	string_list_clear(&existing_refs, 0);
 	return 0;
 }
=20
--=20
2.42.0


--muSHVXrgroJF1ZMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N8wACgkQVbJhu7ck
PpTfPQ/7BRu2xQAi4Gn2zu0FT1q76cV2M1ZyNXmwZz1607A95DsMFRasov/9GSSm
9OuggWT0JHuIDFmmtbaGEwQCcrXDOEEZJe73CO2twag4sKuJ1q0fHLVOmCif+7oP
/XjfIYM88Fg/ChMwIFfQBZaxTnoLOF4w9O8MCMYM18tQAV2+ibUTFtIzY+FsrOAp
p5KuyshNv/z9JAGlGJX8JXP3b84LID9lcQbeuqRfyCwYdO5UkhG+DnKbw7HgpPP9
nHOb+0AgFbSiBF0pT2WUYfTxvvrhVl/87yrkYT+s3/wKvsAN31cXSaM1aT5+VM0y
Lsq4ofchAOsEvZqWUC30thoYlj4UzOHx2z0mp2x61qzCtlTe60Kj09Z75TK29SBn
KHkuGyQBBh9Z+gn3vTgst2C8wAey8Bk1KV4YgRxTGoEM7m5NjYtdJI4Ji15D3HWn
10O2SgcGMRL7hulGlVpHi5j2l5nJ6BbRXH6xXSWmH80u2UMEMtutMr4QIeLdiEuu
gUFSq870vqwtfsHIbNS4YdusEUhGqFV80sPeXJaBE4lr2ORxD/54Elpv+yifVidI
wCMfEMd9t+dnh8kmy7JeP1VsgpZnx+/HmgCSw0UhP4NsHJn4bTELNCpxkg/iardT
LYssD5LbGO4Kr3nFQCaHMv2+kM+SP6+axtRsB0DL4Vi+WrDDzws=
=AKCr
-----END PGP SIGNATURE-----

--muSHVXrgroJF1ZMA--
