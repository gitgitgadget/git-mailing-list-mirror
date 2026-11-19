Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795059793;
	b=hlLRlVUVUqg+1RAx78XPZeRuyxPNIcG/ra/Uv36sz7ZAmT1Y0fjrHiHG5ujJ+2VfKSzX
	 4Pjopny157L1YFrhsgompsD4Hk8PWj50NZq9OWTOCsVGBtbQydcBSAiLU5Xvu6ysCRCtA
	 +1GEudT9Q1yiVbSxj5DHXjKwwECI7YMKAR9sBD9nQ8swzvf5wr2yT2IyctDjq4HsxXIvN
	 bL06xd0mwFBi97oJuJUaC/ug86QRiHuPyN4nYjD55d9gTxLzKi5PhRY2nHkj5HKLQhjpC
	 gHQ4vzYUV6aaCp7/YiOMf6BQeJ/N7PKdRq0lpVBFmT/LRzENVFON527UUaycYgCnqOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059793;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:In-Reply-To:
	 References:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=x2UbesA3pNoU2k8kREXP8A9hhrEal2TgtnATlGa/hZY=;
	b=O1l766baz8qr2UVindiI9Gg1w0VK86/roFrrbyKIoWMLD3rftkTazE6CrGL9r+noqt8K
	 FDxi8kyrOZub/NKWzJaIXel331hzBYBrpswEJB+O6tzhpMGWmEod7PN9Uk0/YXYqmESd5
	 d3Ht0u7bULgvQtfF/FeiAsOmD1itEwN7VPrsFm6AQJzQa0QLdZMRNI4eYIznRBucQ4Ivz
	 OMxWLBcjGWpvjC3IWkuUWQMBjD/2LoJZ+UMVjaOYwjjnWTT2zOQ36Gy8+uKutssDIQuWS
	 wmKfKSXu1/XRY10uT36WreqMqYH86LUBS2lEm9dHnuaSdqgp5F9d889iDgDzYY4yiDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9MOPOmE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC15606A325
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9MOPOmE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795059793;
	b=QOXRBV4UGhrfgGUk4ODowFdz1DOqsuaSOdyYs+cnXxOleNsWy7GMX5kTacnqWyfTyusH
	 OzQixqgY2r6U1bQbZ5bajYO1vOKDUcAXpX5q25fJG4jFNnLP7anWugAR+hf6i4DxGXMHi
	 EzjpTrEdu6llxHuZgtFhvooVptx8w1TG0iQMsLxQB8EJ+abT2dWeZw+HIOGr70KuErc37
	 ZW7HmUmQUvHctSZjfcra7LZNde2Thlgp8vAMFq08PltmvnuwCpVu40nhO2J2fpetKNofP
	 8JQOxyaDXKuxORCHIk9TEmQdqUdsFLba8gTO/s5HRkhyI3tnuzPWxa35b7AwE3FzwaA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795059793;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=x2UbesA3pNoU2k8kREXP8A9hhrEal2TgtnATlGa/hZY=;
	b=Rq/v+aJI8ZOY/xex2bfw2oCdux6PAOPazUpMHHgrrwyLJ6Rna/k6e0DTwo4Qnnm6n8gk
	 fN1KFtKNSTS4zHTMrxs9Nt/a4ts7ZGdrNUA3buIu3/aengvROqUvO9XPKxGsndZsLHR53
	 W9HRwhQCZL6Y2EwGd9RDUE079KiGNwQuuPmP+bT100DoW6CGYh6h68ziyLj7u97g/jAH2
	 ISpEFANHALbeu/HPq1ousX4bxFD4r1TGAl4AZK62h2lKqkQ86ZEJozYju80sdQkofGTTR
	 kMMq1M4zaia0jk6nFcciaG+B4UVI5jVcjrXGXFplffWG4zxIcAqtvIVzpDyhFSeLh+w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8B6D81F000C4;
	Thu, 19 Nov 2026 03:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795059793;
	bh=x2UbesA3pNoU2k8kREXP8A9hhrEal2TgtnATlGa/hZY=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To;
	b=W9MOPOmEPe8M5BhCIW3f9YBHuTs2OZOQkbBbRXK5SaDAM6gSRTOlm0vwKncFQP5p8
	 XQhs5OEfvbE4WdBgtgJH1d4l9O8bsnnaVCIA6DAXpAr99MU6WdbXvmnqQxj2Sr1aEe
	 RCsTCprMoT3JjmUqekA1CkbC3kIi8wolIlsP1c+xoLCEeLKeKquQXwfs5HoBCbVAbP
	 s1OphQVWdRK6v+tBHKAngUDF1awmT8/hjpNYqzp48o6lyPpgvNIl/7/2jgHqFe7/8+
	 NLVKcHGJUZJXjzwJsBBqyaZJJ77wNXUtTzFju3BWkufwiY+8KXq7AqgHMXVM2fbOCO
	 96EafOTJonHLA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DCE9D4B0A7;
	Thu, 19 Nov 2026 03:43:11 +0000 (UTC)
From: Noam Cohen via B4 Relay <devnull+noam.noam.me@kernel.org>
Date: Thu, 19 Nov 2026 03:43:01 +0000
Subject: [PATCH v2] ls-tree: do not quote %(path) with -z
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
Message-Id: <20261119-ls-tree-format-z-verbatim-path-v2-1-c014e4e4c96f@noam.me>
X-B4-Tracking: v=1; b=H4sIAERw/moC/42OQQ6CMBBFr2Jm7RinKlRX3sOwKDiVGkvJtDYq4
 e4CXsDlS17++wNEFscRTqsBhLOLLnQTqPUKmtZ0N0Z3nRjUVhVEpPERMQkz2iDeJPxgZqlNch5
 7k1q0h1Lv6oKs1RamkV7YutcSuFQ/js/6zk2aV2ejdTEFeS8PMs3e37FMSFiSPupS7UkXdO6C8
 RvPUI3j+AXhR0br3AAAAA==
X-Change-ID: 20261118-ls-tree-format-z-verbatim-path-f5783b61ff8f
In-Reply-To: <20261118-ls-tree-format-z-verbatim-path-v1-1-718987241861@noam.me>
References: <20261118-ls-tree-format-z-verbatim-path-v1-1-718987241861@noam.me>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Teng Long <dyroneteng@gmail.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Noam Cohen <noam@noam.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795059791; l=2205;
 i=noam@noam.me; s=20261118; h=from:subject:message-id;
 bh=vgoVj7DmaNqL+zpYiTvi4MOrtN+qceluz1+GNCR8MPM=;
 b=LEI5IdnifZQZ2djQax4CVk2oD9+Hn/nrk5SKW2mpYdaH9Sk/r8l409Z919/CxEaPB+3J8WJj1
 PWktBhqQ0HHCHrlZdd1H966agWs6wOb6X8yxy3BuekPJQWHxMMC6RwN
X-Developer-Key: i=noam@noam.me; a=ed25519;
 pk=qyNqXh2nrM20rNZXIQMjH3jLUPgL/RaLrmNnO0YOpp4=
X-Endpoint-Received: by B4 Relay for noam@noam.me/20261118 with
 auth_id=1563
X-Original-From: Noam Cohen <noam@noam.me>
Reply-To: noam@noam.me
Content-Transfer-Encoding: 7bit

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
Changes in v2:
- Use a path with a double quote, built with "git mktree", so the test
  stays within US-ASCII and does not depend on the filesystem.
- Force core.quotePath=true in the test.
- Link to v1: https://patch.msgid.link/20261118-ls-tree-format-z-verbatim-path-v1-1-718987241861@noam.me
---
 builtin/ls-tree.c         | 5 ++++-
 t/t3104-ls-tree-format.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

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
index a1b2069a25..0df216909b 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -76,4 +76,13 @@ test_ls_tree_format \
 	"--full-tree" \
 	"--full-tree"
 
+test_expect_success 'ls-tree --format with -z does not quote paths' '
+	blob=$(git rev-parse HEAD:top-file.t) &&
+	tree=$(printf "100644 blob $blob\tdouble\"quote\n" | git mktree) &&
+	printf "blob double\"quote\0" >expect &&
+	git -c core.quotePath=true ls-tree -z \
+		--format="%(objecttype) %(path)" $tree >actual &&
+	test_cmp expect actual
+'
+
 test_done

---
base-commit: 03b41523c576f26ad34085378717a0c1b287470f
change-id: 20261118-ls-tree-format-z-verbatim-path-f5783b61ff8f


