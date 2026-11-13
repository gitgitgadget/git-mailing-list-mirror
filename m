Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794536281;
	b=mGZMP7XtcYud10Od/EzezNvPzfma3BpSTqvYFWYX1DTprWuAPZv+XweywezMZsqsmCwy
	 4cU8iffftdvI//r8fAhehS018WfxyynYDy3pqzjpE1TOKRd6ksYMmtMPRKzS6ZgvIg3EV
	 G5WLzfA6KiC42wRCo7I1DJ41vIoyQH012mMppsoBsZtyQXqoNFBkSamyuEoJjH+ihEqqw
	 fZ46PInosxrIPmEVI15HiHV2GGWSks7R5QYP0NqGjdicBLn+NHwVHG3uuZP76cBJ28W0I
	 cm39fHn3M7ypzEU7olUqiqyLrzCSaOpCZinSAtT+uFeQFFLYt0K2mQvhWSsF9BOXK5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536281;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GZ5uyzH31QfG87X1cIQRDyBOu5vBx+9wHflUOQvg46I=;
	b=M9SBGYywNNAUXKXwaorFPZtgwspDyoBSqiKapX2IhXDoFb88+A2czDOJMqYAcrusLMxq
	 PcbTv9wU7xaxpR+U4vjH0bUR/S/JqhOcasSN9vQ8AEffSTrz13XDIbnNxoUAccBBAgGGb
	 dGkrAIS9Ih/Xfk7zya8rqYsyomJBMvY1WogOYRDvGnQtEU7EppoRhB+yVWOk1P/6prJ33
	 uoFS8wswApnfOCVj8yjkMC33aFfG8fPhr0MN0wAHK4e0ODEb66xAtAKu1reXvXd2ObATX
	 CvkyHnlzwfbJ8VBiyDtNMPkilWaWNUdONLsfU0Q7ieKMIeGQlnIANRrQdAc10pnwpbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJi6uki8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E62606A323
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJi6uki8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794536280;
	b=XoMbuFVXqdzrnfISPp6OkbvRcz5pMXnxtGE/wInmFILhbcoRSqJ74MtV1rF2AvXymIvv
	 zFypBRCQuOIAHvYBmri0x8E5O1p0bSbcgP1vAjK2n1AHDuDCF898lrDkm6JD3mB7tBeI6
	 6P6s/CJEDbmUbDGvmqWbrC3k6pIaduOPCfXqEr54ZO/ldiMtiEMjLK54tvfFI9OkpD7un
	 xRRbVZ15HjDzNNl0Smgl+F9WVdflSnbDfaaAAlT3dhgrZgUnqf/tYhtKMju5FElMyzBnZ
	 Bvuy+s7tzmlpiXlC4++k9u0aaeYnqrXNFWSX//srMjU8Y2ArDvgIV6MXwIWdQcrlt0g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794536280;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GZ5uyzH31QfG87X1cIQRDyBOu5vBx+9wHflUOQvg46I=;
	b=cxvegH4uMQMf4nJdNvLqWH9AMMnLrtfZJS5x8h1xeMia5hrctd5jyXt2uMvzBsLhhQ8A
	 lDPe3Sh8ukfs5cwHCUBu3MMokj/svNNHUOvB/xCIclOQzhNU1UOPqN8PbsnsEEJf1YwMW
	 hscmB2TGxWU9UnR10DSOwErR5ZbQ9ViuQzn9dXYa3HrwB89G7FCeu7Y6e+LFEB5XC88WX
	 IY7h9Wrdj44tURQioSiXC6mZwycgRlZ1fihCyZUbwQnnfyrca2EUB/MbuqUh3LlsKGm1h
	 6Xn7FbrOcM3YdWjk0KZC3z81Jp56VQgUFXRG597QZ4ShWKmH0lCW1XvfBLMNcx5IyGA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4D6C41F000C8;
	Fri, 13 Nov 2026 02:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794536280;
	bh=GZ5uyzH31QfG87X1cIQRDyBOu5vBx+9wHflUOQvg46I=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=gJi6uki8l2A97ZlKmAd55walJPy6026Ahymxpa73Ex1qhI3M3Bvzu8DDEgifaW2Vl
	 3JqXzMbeTr0Gl6C7y2M7FcSdbnMY5Lmvbq/JmvYKi52qpZL+6ObLely4jojwcHuYFR
	 Z7+q0PzwZdA+BKE50M2icam0HViPYZQL8HvdpqhElmopeUyhynULPwnfBQjCBWkcYk
	 qbel4AxyA3Q8FcaeslbiLLOQtTVQkCBeNaRuuyCFXlRJyf4WZhZ7TzsJ3wjcYBpXyt
	 9E/GG1NlVQXq8wJHHFxXTkXWmTA4gJ474eBJj1pFzlalyWPwnyApinDouVuY4QBrZ/
	 YhV22e39YHw6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CEAD147591;
	Fri, 13 Nov 2026 02:17:59 +0000 (UTC)
From: Yusuke Hayashi via B4 Relay <devnull+yusuke8h.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 02:17:58 +0000
Subject: [PATCH] http-backend: drop strbuf pre-sizing from get_info_packs()
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
Message-Id: <20261113-http-backend-drop-strbuf-presizing-v1-1-7d66aae03b22@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFVz9moC/x2NQQqDMBAAvyJ7dsGkNVC/Ih5istGlEMNuWkrFv
 zf0OAzMnKAkTApTd4LQm5WP3MD0HYTd542QY2Owg3XGmBvutRZcfXhSjhjlKKhV1lfCIqT85by
 hS/eHG0cbh+ChhZpJ/PlP5uW6fvQRAf90AAAA
X-Change-ID: 20261113-http-backend-drop-strbuf-presizing-6f496552d0ca
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
 Yusuke Hayashi <yusuke8h@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794536279; l=1829;
 i=yusuke8h@gmail.com; s=20261112; h=from:subject:message-id;
 bh=5KrviimACYCG/AtywYjQYyiJqUKbPCUrIZKRQmnamtg=;
 b=D3J0G++wLzAy04umBnll0qIcK2NDo5/yHuVWk+w9P6DUazpps6P4rjVsX5eaUVq2uZ7a0ZEHA
 eYlER5VJU+8BV9bGOrGbqmA9/CJBhg9/8of9feIhCauFAnrAEYTyRjd
X-Developer-Key: i=yusuke8h@gmail.com; a=ed25519;
 pk=7SzYbbTWl4u1a0gmKeMxAqo7g7F1K7tnWWGWQ+LnNNs=
X-Endpoint-Received: by B4 Relay for yusuke8h@gmail.com/20261112 with
 auth_id=1495
X-Original-From: Yusuke Hayashi <yusuke8h@gmail.com>
Reply-To: yusuke8h@gmail.com
Content-Transfer-Encoding: 7bit

From: Yusuke Hayashi <yusuke8h@gmail.com>

get_info_packs() iterates over all packs in the repository to count
local packs, calls `strbuf_grow(&buf, cnt * 53 + 2)`, and then iterates
over the packs a second time to format each entry with `strbuf_addf()`.

This pre-sizing dates back to 2f4038ab33 (Git-aware CGI to provide dumb
HTTP transport, 2009-10-30) and is no longer worth keeping: `53` assumes
the length of a SHA-1 "P pack-<hex>.pack\n" line (under-counting the
77-byte lines in SHA-256 repositories), `cnt * 53 + 2` uses unchecked
arithmetic, and `strbuf_addf()` / `strbuf_addch()` already grow the
buffer automatically without needing an extra pass over the pack list.
Similar pre-sizing was recently removed in a9ce8526dc (pretty: drop
strbuf pre-sizing from add_rfc2047(), 2026-05-12).

Drop `cnt`, the counting loop, and the `strbuf_grow()` call.

Signed-off-by: Yusuke Hayashi <yusuke8h@gmail.com>
---
Inspired by https://lore.kernel.org/git/20260513185408.GA147423@coredump.intra.peff.net/
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


