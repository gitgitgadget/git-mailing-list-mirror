Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7111C94
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gwf+gl4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlmYkizQ"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EC0DF
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 1C1AE32007E8;
	Tue, 31 Oct 2023 04:16:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 04:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740188; x=1698826588; bh=Zm
	WcCe4i1h/sXkWwzithjSU92k+Pokumepy0UGpHYoc=; b=Gwf+gl4FqWBnCEV4Kt
	IBzzX2eZrrzVteBb28fYv40nIS+2TrOEIqKP0QDBL8++5cMP3y4UoqqNcqoSu6uA
	HE7vAms+00MzvUiRbj15PR3z1Fq2OeJA4v1itxCR6Djity21kBU2hyPAUjGux6yV
	Ik89hoqF9sPfjSQhiRBXnJ3wFUgNssQo0frtO5riFD2YEXHG2E0QZ/n9+axqJMrw
	4Akc73VN1KakelxCD3JzbO8Dxpmh49xh43hvd/UFGLRAVmYVDZL0kcD3fT1nab/n
	QknLr13pyaI8T9tl/Zkj5T9gh+a9UOJLDqqKEJPu/XFQbOcIGdN3mZgpdoqZ/hwH
	HemA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740188; x=1698826588; bh=ZmWcCe4i1h/sX
	kWwzithjSU92k+Pokumepy0UGpHYoc=; b=KlmYkizQJFEihscOrII9V5gp41QTZ
	TrWipUZjk55w1hzDv3ku7Wewqe3e0vChSXVMLGGxpA+gzmMV/OgNV/2sZRof80cc
	69/QV42rj4SPlZwwVP0lPvm53Lq1es6EyukTtvER//1ZyVKQF4Th1Kz7O1V98b5N
	hDYJ+FClNNI/w5ZzjzkfVNwx3+gptJk9EnFvbZvgdkuNzzYQ2CZcn1kxz0KdlwhW
	97m5tQm3KtfT+zCG4nRuAQnKObWoCAm92TBo/klNR6bKKxhGst5ZCWEI+HiTkJHO
	03UXjwewpAhkNNoGnFWTmr1dU/CPgL6enkyDcWUgGVYcu+6E96Kfw8iuA==
X-ME-Sender: <xms:3LdAZfw-ObfweNKk-umCgEJBk_a3MY4PpwTsTxYXqv5MOFXrCP9lbw>
    <xme:3LdAZXRVPFKejQaDIsJNyKHaZvD5u4ocCSA-ufogB5Hkn-I4Fx7Ati9aW2NGtVoJt
    Va0r7GydTZMv84RZA>
X-ME-Received: <xmr:3LdAZZXyxo72hDXyFMTzbFRLKYRixFFxlbNqyYPUj6qtgelkgsLRgo7x6Pmhh-f0azpEasae5zb8X7g60n79XVxxOI2AtfWIUqzMdIDg8UtAgwDx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:3LdAZZiT5qRM_-rcqvGSPwwezhBxdON7NrbasazGINuXeKWOrNlSng>
    <xmx:3LdAZRAsK3uAgE0KPvsmxlLIxT2q7Sn_zHxKAFo_Ot8yG1xfHrKc8g>
    <xmx:3LdAZSK_njqLvdOzMRBzv1zHZzX66Iy3jtQcrz9OW2wSkA2YCrY9HA>
    <xmx:3LdAZQMnv8rckbdz6iezWbrqZ89lgcoKbpQBl3F8iaQAR2ncSrXLjg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b08d12b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:19 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 04/12] builtin/show-ref: fix dead code when passing
 patterns
Message-ID: <4605c6f0ac989b03d25ab02403d6b94836595c43.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HzVaOlyyXg56BPl1"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--HzVaOlyyXg56BPl1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passing patterns to `git show-ref` we have some code that will
cause us to die if `verify && !quiet` is true. But because `verify`
indicates a different subcommand of git-show-ref(1) that causes us to
execute `cmd_show_ref__verify()` and not `cmd_show_ref__patterns()`, the
condition cannot ever be true.

Let's remove this dead code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index e55c38af478..f95418d3d16 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -183,11 +183,8 @@ static int cmd_show_ref__patterns(const char **pattern=
s)
 	} else {
 		for_each_ref(show_ref, &show_ref_data);
 	}
-	if (!found_match) {
-		if (verify && !quiet)
-			die("No match");
+	if (!found_match)
 		return 1;
-	}
=20
 	return 0;
 }
--=20
2.42.0


--HzVaOlyyXg56BPl1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt9gACgkQVbJhu7ck
PpQNPA/+K2zwgIJBGWo4bpnT25XQySi4cXygQKOkfgsSPudUHkgv/idhGBslOB9q
leri9cDvxDHOUV8zZh87kKLMQvGZ833dvESfaHl/wRm0dhmIgG1aIUyRgLCDZlfP
Kbh+wSw0CrjQtzFbdI3e4Gk21roa+hRd/c8QeWtBw8Xc9RkpcDcmnEMiAodmXmoO
1XrMFxZ9zxGdePBngBUmin5ltMvS20hFVpwUB7OJH66j40ebzUuL1x9e0OsPOgpT
zLgsa0xbEtppY467FvCLSl9gTDherp34vCh+bOfUROXnjx4TiXTo/YQIVXF1mVZK
R6c3cIqvA/A1U3e4GIsd+nLInvSun0SoTN9l9uVZgyfO8e/sA8ylQ/hmYsLMG4Xd
jFZskOoQMLDCv7ZC3bBwArBpSFJwAa0MgJY183ogaakMhxq1TZRWqse984sDXEAs
QT4BmKV2CokoQ5lt8xB70FDNVHWXd+DMg+/UXvac4CmYmeRikj0BtVBYGGuPmQMs
UeiQO3sRRRXl87P0ZLq4t7SiDKWk7snqy0c80iI6njp9N67idwUYG2zfSG+DfmM9
7t//5Y8Rud5M2CG0Aj0y6+BBHumVOkme/MncL7Tw0S3Zk1hyJzaYxgjhozp1wqGd
0LXSiQPUw0rMNrW2eSlOnfhH606rJiB1vWF90woHQvGTE8vMhvk=
=4Vzv
-----END PGP SIGNATURE-----

--HzVaOlyyXg56BPl1--
