Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043137;
	b=cPnC4GRV20Dc34BaPN9XBVh/VhRx6f3AKPcwJfGPJkdYrY6HE9hT8bR1jovfFQZLYi07
	 EPpwYpmGkcgIHJBmAryK1pOb7TsPtHZNJBXC8isuw2gksLveev56LgbPM3oX7b0D3ecWI
	 TYgnYAlfOu4fqLYsXEJR43gNIkVX8yIdAT7Pldoc1iWSjIPUnoKYEjcRFd6XnUDmae7EA
	 ln5PFk2Ye5MfNUygSOUdlgRa+esxQFIE+Llo5PO37gU0G/oJ3OJLMrkICyVqTwne7i7Rp
	 cS5+ymuZG271ykQ+s37vB+1AnD6ID4q4i0YJPlcbPymH+F8KLGfuIe/BZARB2FDkT7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043137;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aoBaWedttEa9xu7NJoZDDSWBY+OINn2hYF4pJ5cMCGA=;
	b=iFXF1lwH5damUb+vypDZIF+kjhEPHAjPR1qNNvyIDHrulpknfhZg78uzhHk2wo/lQ4eK
	 OxHCYjgpa0HFCtNFd8a+Sq7afjWdFxSOO4MR8hdmtH+i3UD5HSJWistfCbRi2vxMeiy6K
	 YSMSPFzq1kpvHUyf+SkcDgduimaZTfh+/xeSlok1+NZK8HkaoKtYDHcig+vpnCQmOsKlu
	 TIUE4YqNwKoaTAZmgH79bA/lHr3JZze1YlvD9g0+6miv7O7BWHmX4u9CbL1Z21DxkqCES
	 p28i8ttsqqfrYSchftx5ybEU6ZB0PZv3Rt/mzrkNGm/aPDMPletPC4+79N4mxJUEShQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tkcn3D/U";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1D606A33F
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tkcn3D/U
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795043137;
	b=k2qRiEKRV4uWbD4QOj6U5RQsTCrUjaiUxXg5+OIjp9X6tO0IETWT1VXrl+4gU5FVSENo
	 mnh3GpaN96ALl2kpDMRt25b73fM/ylgbnmtj/7c9iKvpPIPShan6fcyZbNuqpMR+VXpgu
	 yn0plMHbFwa8tPsgD8GkIbzmtWXua1kPPIhDk50fgd9G6fZYq9i5LxWtD+ivYfeoXUay9
	 MCbcn6TToDFVygNvk3pxKuMzxUGgTcBYghA/KvnOnvRNgLVvB6d7WuVOazezGZ+rXZXEf
	 w66WdLTFBP66/sGY/hK4bbBSgN65uoVhwAJ8juumH698uCk3AcKLWjETp29BOZeFxqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795043137;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aoBaWedttEa9xu7NJoZDDSWBY+OINn2hYF4pJ5cMCGA=;
	b=HPC/V437R/dwcco0uIDbqUQZTSvgYBezcRKUGJlpK+SyTewEVM8xNliZWwaGnBD1CDlY
	 8Uscv6w8xPt2GYmZn1Vg41lPmtpsY2o1L/JPYjT2pMKV2lVTZ1CB/hWjox4RJ3SHLVnOb
	 LHnjrDsSeUgoLeNeerSNwwumIsI413hJSIwTPsrv7YG1aL8Gg9peWICiUYNGuxe2eVBO8
	 p9WxjutpmX3w/l9IKTlCew/SuUnvEUaLxMaddhSmz7415tqVAXMHEbXdRS7hxvsKC8Ue7
	 ksp905vR77RJ24ITw59BI8XDNsfMyd/yy1DJQVV2RpYPQH+8cstdYfWdYKaa7rvxqnQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9A6951F000C6;
	Wed, 18 Nov 2026 23:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043137;
	bh=aoBaWedttEa9xu7NJoZDDSWBY+OINn2hYF4pJ5cMCGA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Tkcn3D/UpBCs7InOTLNWOkYs7G1ptzgBKg0f112pcmEzVUcvWRf46pDdzawZON1vw
	 VUtsGcSbCBCZhqTOcIaR0Tb+r1nhUDTsAR7vNr86LeVRyPEaM5HoxsRkCRKnF69n25
	 eAh3LqHT2aP4N5WOe8H2LyMVLc73DNpT8yb6SsWnUktsboa9Cd7kJtEoViNI3QqDIi
	 /16K/hKEenI8/sa0zhRFvhU7iAXxrqKjssafLNHqemG3R6L1mD+2oVXa4uNUlok96S
	 JITMsd9cKlFX4SCCCu8lHVipJD3Xv7zEdncM8pFtY8CJncab+Y0Pz/Y9Ca1aiN6FZA
	 bgBStFzpxEE+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F22E34B009;
	Wed, 18 Nov 2026 23:05:35 +0000 (UTC)
From: Noam Cohen via B4 Relay <devnull+noam.noam.me@kernel.org>
Date: Wed, 18 Nov 2026 23:04:37 +0000
Subject: [PATCH] ls-tree: do not quote %(path) with -z
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-ls-tree-format-z-verbatim-path-v1-1-718987241861@noam.me>
X-B4-Tracking: v=1; b=H4sIAAQv/moC/yXNTQrCQAxA4auUrA2YinXwKuJipiY2Yn9IpkUsv
 bujLr/Neys4m7LDuVrBeFHXcSigXQVtF4c7o96Kod7XDREFfDpmY0YZrY8Z37iwpZi1xynmDuV
 4CofUkEgQKJHJWPT1G1yuf/ucHtzmbxW27QNoc4/aggAAAA==
X-Change-ID: 20261118-ls-tree-format-z-verbatim-path-f5783b61ff8f
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Teng Long <dyroneteng@gmail.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Noam Cohen <noam@noam.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795043135; l=1980;
 i=noam@noam.me; s=20261118; h=from:subject:message-id;
 bh=/gS8cB9hoApkoumXcC9pvUxzrBcAfscqlgx+E/AqFio=;
 b=T+uWUJSMwZRIQ1pVZ2Y7ycU/uL2NxTqfXpExeGeVWi+nxVin6uiqV3h9IRh/VQ1zMxMJrRtYt
 xVyxvddV6xZC+ZkoWmdFmx8/iu9A4w+fQvGFw69v0oKxrEiXzoiKyjJ
X-Developer-Key: i=noam@noam.me; a=ed25519;
 pk=qyNqXh2nrM20rNZXIQMjH3jLUPgL/RaLrmNnO0YOpp4=
X-Endpoint-Received: by B4 Relay for noam@noam.me/20261118 with
 auth_id=1563
X-Original-From: Noam Cohen <noam@noam.me>
Reply-To: noam@noam.me
Content-Transfer-Encoding: 8bit

From: Noam Cohen <noam@noam.me>

With -z, "git ls-tree" is documented to output the filename verbatim,
but since 455923e0a1 (ls-tree: introduce "--format" option,
2022-03-23) the %(path) placeholder of a custom --format is always
C-quoted.

Output it verbatim when -z is given, like "git ls-files --format"
already does.

Signed-off-by: Noam Cohen <noam@noam.me>
---
This makes "ls-tree -z --format" match "ls-files -z --format", which
already outputs %(path) verbatim.
---
 builtin/ls-tree.c         | 5 ++++-
 t/t3104-ls-tree-format.sh | 9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 46edaffc2e..d25bbffcdd 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -130,7 +130,10 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 
 			strbuf_addstr(base, pathname);
 			name = relative_path(base->buf, prefix, &sbuf);
-			quote_c_style(name, &sb, NULL, 0);
+			if (options->null_termination)
+				strbuf_addstr(&sb, name);
+			else
+				quote_c_style(name, &sb, NULL, 0);
 			strbuf_setlen(base, baselen);
 			strbuf_release(&sbuf);
 		} else
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index a1b2069a25..016c0fd0ff 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -12,7 +12,8 @@ test_expect_success 'ls-tree --format usage' '
 '
 
 test_expect_success 'setup' '
-	setup_basic_ls_tree_data
+	setup_basic_ls_tree_data &&
+	test_commit נעם
 '
 
 test_ls_tree_format () {
@@ -76,4 +77,10 @@ test_ls_tree_format \
 	"--full-tree" \
 	"--full-tree"
 
+test_expect_success 'ls-tree --format with -z does not quote paths' '
+	printf "blob נעם.t\0" >expect &&
+	git ls-tree -z --format="%(objecttype) %(path)" HEAD נעם.t >actual &&
+	test_cmp expect actual
+'
+
 test_done

---
base-commit: 03b41523c576f26ad34085378717a0c1b287470f
change-id: 20261118-ls-tree-format-z-verbatim-path-f5783b61ff8f


