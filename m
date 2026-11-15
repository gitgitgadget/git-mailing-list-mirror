Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736728;
	b=K0kMPmEnxlmvGeNWY7Ewxf3ksUvBqJu7Mxrl3lXE6MyfW2UreyINzmYpvvrGlOJTpXll
	 XB8DV0uiM1oqVGu5Veqs3FC0d1tsGWexwAaYJKN5D3+B7Yl7HswLugLj7iGm7LD1UIgeK
	 Ad43BvydXsMrURflogzgCtKEXwA+OUj/JWcsCD571k5gngDyLw2Kh/VXL92vqpDOHbZsh
	 Z9UF8IzIDDwcgfkwuVzrfDPv6iJXHo22Sv1O6lkt/pN+k7Nnd8KbIHryGBk6UJtesd5F8
	 EzOreoFkmPo6b55g8dL+GM9D4UXmU88oDOBKnZvY1mEojeytlZEz9MNC7IvvVx6YqFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736728;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:In-Reply-To:
	 References:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=allRsYYmvAPebQMOUhM4J4xtee4nJbG+4F8Xuf1vL2w=;
	b=mYM1ASjk/tNwrYC/6CyyMg1573c101tkLcjDA2F0vU09RVWixgOvFQxqieoIv8Z+41lj
	 ylkMoGT22we6HNFvobhzOCf9KLI1NEcSCQlc70F7pPw43RfhB8LBsArLBJZRW08RiJ61L
	 TWll016euujYoDpoRq7INHAmzLJ7lLUuUJq1l0Gxs+jnxqDtBvZgu6tAjwlFgR9ACdQJG
	 T+6plqQ4iHO2e6HGmIySdsk9O6FLIe3hxhGFkbK/YudTIkSW7iVf/VEslnXOD6OrI/Tgs
	 sOFppZ9ncuNNrbYiu8+slhwmc3b59CMLF/+7QuwV0yTN4v6H6dU1gktvhIQSV5SScMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUUW83QS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86232606A31D
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUUW83QS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794736728;
	b=ZP+vdfpqOrGuqyrc6jYIGh1pBaeyi3MCRq0TUO6ozWUEcNqOycbJ2D9T5XD88RcK1yDj
	 r9LBk5XHrnHFS443Wn/wWNr38225numcKSWteOszsgXI2WTi/CyfjDF8bBG3J3For4SJ/
	 NLp85gnZ/ZgPYpAIkypushNvs07NNKmR3xek76pHo7w/siL3jA+a586XaPUPuZ0rEA4Xl
	 CEFIeyN4ZZHpi07Cd2gfF1ps3nWHRo7fsU6mzNDEhYDNIfYJZXpIVFcM8VrQh7yyzPQF6
	 7akYH/WFtMvw7n+AG2MKOLE66F07un/MAnr9KMKuuez51XNwkjzpROfioXu6L55xnJw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794736728;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=allRsYYmvAPebQMOUhM4J4xtee4nJbG+4F8Xuf1vL2w=;
	b=YOhlaeIUCMRmnmY5D0VQkCjan6XjDo82TUinBH7RGccyT24dHCWsLTy+1VxyyOzFh/m7
	 uLRTL9R9fqsYqmqm+NA9ZiMh9Y788YFPCEvskezb71r3Hoq1+RCbUxc8mAuW+FJsWxHRD
	 LpXt7qF+Sxw1bvsf8rs/yApb+Z9E7WsUp1LYSTPTonYkZVfZd6DaM+Lo9K2eOcoizLG/3
	 TC4GhzFYoASS3osZ6OAMB4Ii/pdvHHFJjNvvJs/SviIzHjEHsxRqQu1hcpepPKzTKgnEa
	 q5/zFtFJ4AdDg8m49mKtXML3kzay9J+rZoc6CvHccCF9B5lJFaFRS+mp4jO2f+buWNg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 834F61F000C4;
	Sun, 15 Nov 2026 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794736728;
	bh=allRsYYmvAPebQMOUhM4J4xtee4nJbG+4F8Xuf1vL2w=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To;
	b=LUUW83QS1jHzECgyThRP+boKdv4cCFZUafFCX/2dUSqVFkdozk/BXYtCKyPyQ1U3s
	 m84HvQ/td3eBWdqlT6w88FvvH/ZhWDJ/enkadcWjBvUD+seiCZ3gtt2IWOXkLzFCfm
	 3mEGp2D9M24A1yGh4QXASQFgFzv2zsmQAmeQIvvVCnPWHNrDbDUJGv+WVp0k1hKuwN
	 ZM1+YiXJnYgWQKybt2ZQ6Q+wr/9NHNW0pSMpaXc7CJRFz+Qs14wnM3TQ+XcQetzgxl
	 FE3Y0G/bScFAJru3JNb4v+DSlq+fcBUW5jgvbIy6U8SkcLT+rQWyY0+dErY4w4Qhy4
	 Lx3OzFDrj8LUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D5C714A03E;
	Sun, 15 Nov 2026 09:58:46 +0000 (UTC)
From: Yusuke Hayashi via B4 Relay <devnull+yusuke8h.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 09:58:47 +0000
Subject: [PATCH v2] http-backend: drop strbuf pre-sizing from
 get_info_packs()
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
Message-Id: <20261115-http-backend-drop-strbuf-presizing-v2-1-b7ffe1be4482@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFaC+WoC/5WNQQ6CMBBFr0Jm7RhapEZX3MOwKO0AE6UlbSUq4
 e5WbuDy/Z+8t0KkwBThWqwQaOHI3mWQhwLMqN1AyDYzyFIqIUSFY0ozdtrcyVm0wc8YU+iePc6
 BIn/YDaj600XVtbSl0ZBF+en5tUdubeaRY/LhvTcX8Vv/0i8CBZ6tUlpTWXVSNsOk+XE0foJ22
 7YvtyAeK9QAAAA=
X-Change-ID: 20261113-http-backend-drop-strbuf-presizing-6f496552d0ca
In-Reply-To: <20261113-http-backend-drop-strbuf-presizing-v1-1-7d66aae03b22@gmail.com>
References: <20261113-http-backend-drop-strbuf-presizing-v1-1-7d66aae03b22@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
 Yusuke Hayashi <yusuke8h@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794736726; l=5207;
 i=yusuke8h@gmail.com; s=20261112; h=from:subject:message-id;
 bh=e2BiSJ1Xm65mUA9mqSKfRdN+Wp4cJ7+YuQE0Bl8GYYY=;
 b=b7eJZ1tD6VbV3NqpA/g2zdMd//Mah18ylx2Qh9QZrzRFTHl2mb5Va1AgWs079DSYdlrLUhsTQ
 uv7S2cVvlsEBpP9vO0TspOUF3tv2lOwzGEoTotS7rDLrNMKa3qrSpPn
X-Developer-Key: i=yusuke8h@gmail.com; a=ed25519;
 pk=7SzYbbTWl4u1a0gmKeMxAqo7g7F1K7tnWWGWQ+LnNNs=
X-Endpoint-Received: by B4 Relay for yusuke8h@gmail.com/20261112 with
 auth_id=1495
X-Original-From: Yusuke Hayashi <yusuke8h@gmail.com>
Reply-To: yusuke8h@gmail.com
Content-Transfer-Encoding: 7bit

From: Yusuke Hayashi <yusuke8h@gmail.com>

`get_info_packs()` iterates over all packs in the repository to count
local packs, calls `strbuf_grow(&buf, cnt * 53 + 2)`, and then iterates
over the packs a second time to format each entry with `strbuf_addf()`.
This pre-sizing dates back to 2f4038ab33 (Git-aware CGI to provide dumb
HTTP transport, 2009-10-30): `53` assumes the length of a SHA-1
"P pack-<hex>.pack\n" line (under-counting the 77-byte lines in SHA-256
repositories), and `cnt * 53 + 2` uses unchecked arithmetic.

Rather than fixing the size calculation with `the_hash_algo->hexsz` and
`st_mult()` / `st_add()`, drop the pre-sizing altogether.
`get_info_packs()` is a one-shot CGI handler for dumb HTTP
`/objects/info/packs` requests that formats a single response and exits.
A typical repository only has a few dozen packs (a few kilobytes of
output), and even with thousands of packs `strbuf`'s geometric growth
only performs a couple dozen reallocations. That cost is negligible next
to CGI startup, scanning `objects/pack` to populate the pack list, and
writing the HTTP response, whereas computing `cnt` up front requires an
extra pass over the pack list.

Drop `cnt`, the counting loop, and the `strbuf_grow()` call, and let
`strbuf_addf()` and `strbuf_addch()` grow the buffer as needed.

Signed-off-by: Yusuke Hayashi <yusuke8h@gmail.com>
---
Inspired by https://lore.kernel.org/git/20260513185408.GA147423@coredump.intra.peff.net/
---
Changes in v2:
- Rewrite the commit message to explain why skipping pre-sizing is fine
  in `get_info_packs()` specifically (one-shot CGI handler where
  `strbuf`'s geometric growth is negligible next to CGI startup, pack
  discovery, and HTTP I/O), rather than citing `a9ce8526dc` as precedent.
- No code changes.
- Link to v1: https://lore.kernel.org/git/20261113-http-backend-drop-strbuf-presizing-v1-1-7d66aae03b22@gmail.com/
---
Range-diff versus v1:

1:  9abfe3635b ! 1:  7561d02b83 http-backend: drop strbuf pre-sizing from get_info_packs()
    @@ Metadata
      ## Commit message ##
         http-backend: drop strbuf pre-sizing from get_info_packs()
     
    -    get_info_packs() iterates over all packs in the repository to count
    +    `get_info_packs()` iterates over all packs in the repository to count
         local packs, calls `strbuf_grow(&buf, cnt * 53 + 2)`, and then iterates
         over the packs a second time to format each entry with `strbuf_addf()`.
    -
         This pre-sizing dates back to 2f4038ab33 (Git-aware CGI to provide dumb
    -    HTTP transport, 2009-10-30) and is no longer worth keeping: `53` assumes
    -    the length of a SHA-1 "P pack-<hex>.pack\n" line (under-counting the
    -    77-byte lines in SHA-256 repositories), `cnt * 53 + 2` uses unchecked
    -    arithmetic, and `strbuf_addf()` / `strbuf_addch()` already grow the
    -    buffer automatically without needing an extra pass over the pack list.
    -    Similar pre-sizing was recently removed in a9ce8526dc (pretty: drop
    -    strbuf pre-sizing from add_rfc2047(), 2026-05-12).
    +    HTTP transport, 2009-10-30): `53` assumes the length of a SHA-1
    +    "P pack-<hex>.pack\n" line (under-counting the 77-byte lines in SHA-256
    +    repositories), and `cnt * 53 + 2` uses unchecked arithmetic.
    +
    +    Rather than fixing the size calculation with `the_hash_algo->hexsz` and
    +    `st_mult()` / `st_add()`, drop the pre-sizing altogether.
    +    `get_info_packs()` is a one-shot CGI handler for dumb HTTP
    +    `/objects/info/packs` requests that formats a single response and exits.
    +    A typical repository only has a few dozen packs (a few kilobytes of
    +    output), and even with thousands of packs `strbuf`'s geometric growth
    +    only performs a couple dozen reallocations. That cost is negligible next
    +    to CGI startup, scanning `objects/pack` to populate the pack list, and
    +    writing the HTTP response, whereas computing `cnt` up front requires an
    +    extra pass over the pack list.
     
    -    Drop `cnt`, the counting loop, and the `strbuf_grow()` call.
    +    Drop `cnt`, the counting loop, and the `strbuf_grow()` call, and let
    +    `strbuf_addf()` and `strbuf_addch()` grow the buffer as needed.
     
         Signed-off-by: Yusuke Hayashi <yusuke8h@gmail.com>
     
---
 http-backend.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index c7566b1d12..da9516a4c1 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -612,15 +612,8 @@ static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
 	size_t objdirlen = strlen(repo_get_object_directory(the_repository));
 	struct strbuf buf = STRBUF_INIT;
 	struct packed_git *p;
-	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	repo_for_each_pack(the_repository, p) {
-		if (p->pack_local)
-			cnt++;
-	}
-
-	strbuf_grow(&buf, cnt * 53 + 2);
 	repo_for_each_pack(the_repository, p) {
 		if (p->pack_local)
 			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);

---
base-commit: 9354c5f04055932909b660a237905b360cba195a
change-id: 20261113-http-backend-drop-strbuf-presizing-6f496552d0ca


