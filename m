Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795850213;
	b=eBjo/RNpGB0AwTCcbs4dhvDq9wc/qYqr4/7z/QT2oH0pzOEGe7bqYLcLZO0MuWX89VWy
	 p3SprM0c1NbuggzbqmeoO81gugRUmh14vXulPhLnYeDspnzlRkuPBz93GjWoaugXDgTPX
	 yRndfrACgHA3v6upzhqjaYxhUR7uq06ocjZ3yMMoogqpTL8f72lzbNncp9RZX9U/CuD6J
	 5wu7qIY0nm9MYQpTuLPBRliUmByJVWCCwQ+pTfhHO/WZFRx1gfHptlouby8teWaPudz3v
	 WhWWRMkdnY0wHmqlfqIs15ysGrta4Ie4x5/IVHYJou//lVgIwmgGA45tKSbsKXg1Qkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795850213;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kQaHFtr6CNOmPGo15BJcjmrf8wq7ML6zb3Uclf7bvUY=;
	b=H73Vv9tC/PPakgTPy72MOqH7JTMRQrtHtAZAvRvT7/poOSW332rNZsx9FW+elLFNfJR/
	 phVZouuUonO40H3PuD9hDxaatbROc6HoE5QqXZA5n4uNRORmKcSrtLnv4MyOFnInkAb9a
	 YfVrJgF/LwdZW33xrTZKtk1MyBr3AVTQUlqRTc4zj9eUKdYGDZVVEyH4L1iobf0/hWaJA
	 5RAJcIiRrGBWvIdzPY0HhGg8PsvP10NwAkcspFsQcS3ID8ezCP3vZhWsTBRuyH51McBYP
	 ilb/LFvSWW0U6nfOlO9B/hBYInRfPdagGjcmtpefucJOXI5SAl9fd52FLOuFz2ietkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=AmSBdFbu;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE7606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 07:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBAE7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=AmSBdFbu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1795850211; bh=Vc4vGJCcv+i1GYW0EIdHEFPF5hskAAy2ilhFWeX43qw=;
	h=From:To:Subject:Date:From;
	b=AmSBdFbuSmDaE07g3OH3QghLsYvKqoyzh3uwaqEqgWFD1H1dbdyPx2fXh9ofLgi8E
	 JuUxiWUj3uolV/hIWjLdwfMVK0O8zx+g99OH7Y4Gg307aSfEw0KYBxDimZfBL2Hnd8
	 1m+EF1wiSeJ3ZnEy2wIm57Mm9W0UEg/FjyGx1nHM=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 6251863F91
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 07:16:51 +0000 (UTC)
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Subject: [PATCH] doc: gitignore: rejoin related paragraphs
Date: Sat, 28 Nov 2026 02:14:34 -0500
Message-ID: <20261128071613.3386188-1-m@lfurio.us>
X-Mailer: git-send-email 2.56.1.944.gfc811cc53d
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some text has become separated from relevant context by the addition of
another paragraph.

Reorder the "If there is a separator at the beginning or middle..." item
so that it is next to the "For example..." item that describes it.  The
preceeding item about paths ending in "/" is related, however the
example text speaks more to the moved paragraph than this one.

Signed-off-by: Matt Hunter <m@lfurio.us>
---

Noticed while looking into
 <20261106182945.1316297-1-aniketgupta3001@gmail.com> and
 <xmqqh5hx4jz3.fsf_-_@gitster.g>

 Documentation/gitignore.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
index 7979e50f187e..662632bdefc9 100644
--- a/Documentation/gitignore.adoc
+++ b/Documentation/gitignore.adoc
@@ -91,11 +91,6 @@ PATTERN FORMAT
  - The slash "`/`" is used as the directory separator. Separators may
    occur at the beginning, middle or end of the `.gitignore` search pattern.
 
- - If there is a separator at the beginning or middle (or both) of the
-   pattern, then the pattern is relative to the directory level of the
-   particular `.gitignore` file itself. Otherwise the pattern may also
-   match at any level below the `.gitignore` level.
-
  - Patterns read from exclude sources that are outside the working tree,
    such as $GIT_COMMON_DIR/info/exclude and core.excludesFile, are treated as if
    they are specified at the root of the working tree, i.e. a leading "/"
@@ -105,6 +100,11 @@ PATTERN FORMAT
    will only match directories, otherwise the pattern can match both
    files and directories.
 
+ - If there is a separator at the beginning or middle (or both) of the
+   pattern, then the pattern is relative to the directory level of the
+   particular `.gitignore` file itself. Otherwise the pattern may also
+   match at any level below the `.gitignore` level.
+
  - For example, a pattern `doc/frotz/` matches `doc/frotz` directory,
    but not `a/doc/frotz` directory; however `frotz/` matches `frotz`
    and `a/frotz` that is a directory (all paths are relative from

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.56.1.944.gfc811cc53d

