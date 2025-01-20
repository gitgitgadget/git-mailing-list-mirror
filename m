Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D923728373
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737338177; cv=none; b=mtFadajsf1m+Q3krb8qKamqSKeAH4zChuBtVfa+GjcvzfCg+R5JWoJaBeRy8K+sd6fGeISio6hw2d0TA6Aab7ovz/b4vQ/aJWRHUI/kbPE0lkv6iC05dnTW4TRGHGoza/Wj8xDLu2qCRukWSKm1qDGAgpelpX91hpL/OdSV9+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737338177; c=relaxed/simple;
	bh=ZI76br61poen5XYY/tIHDreRvcath8O8qoouY0aQMIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2oaNu0jar/e/P3m7t9ooetyPu0dk9gOyXCmVluRU3BkiVNlnVNTV4ZgKUwaiyc99GvV1wG1vTdUNKeJXFDRXQ8IQnNZZZvR4igUgM9YkE1k5qiOJN5BLCj5alVJyAXbiO1AIrjTwnWyUIVAoxrRT0Lbszs8nm6RUOVlv1NJImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Y8cN+8gm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Y8cN+8gm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737338171;
	bh=ZI76br61poen5XYY/tIHDreRvcath8O8qoouY0aQMIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Y8cN+8gmu4lJm53w3xVuuIyJDpCBtJN2Csdi/rQ43QqYTuiDTBV1DPlHV8WSc+kPF
	 nEX9OcIEZQbynXAC/+v7mXs92rZifJhKlWjPS9sQwQJ9i+pWPK+XVXwACDNI9KobX5
	 iDkyjuISNg7dz3pwSbgjdDO3JqwqN1hs2IwWDYYDcS4RYzf6C0guy06xRma4bptVH7
	 EXhoWSWv7IH2p1E3N5OuXb+Y6xiyLxMWo5n6iZCZdLRULHut2j2NdjO3yr8nde85gn
	 C4j7Y/BZ/letMgzFjV0CGsEJ3qEa89il+qhi47vW6jpoWJrPjkalO2pBQkNR0kAcGX
	 wRKB+wBxctYxuJNWVJ5ZcVnIY4xcbrwsvRV/QPbzgDv+70hUPubVDw4EDmqE4DdTLx
	 eLEd8qH6HZ1ecrjUeskqH3nN52sJAeU0A49HwFAn7Rca5HfRykUwv9w28IBMk+zL1I
	 kmLlvd3PqA5Cc8HtM/PwoG4deolbPSWsyjo+7e3Ipt6Nmbkt7Gw
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4290D24453;
	Mon, 20 Jan 2025 01:56:11 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 5/5] Remove obsolete ".txt" extensions for AsciiDoc files
Date: Mon, 20 Jan 2025 01:56:03 +0000
Message-ID: <20250120015603.1980991-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.48.0.rc1.219.gb6b6757d772
In-Reply-To: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we no longer have any AsciiDoc files that end in ".txt", don't
modify them with .gitattributes or ignore them with .gitignore.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .gitattributes           | 1 -
 Documentation/.gitignore | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index b38cfd499b..43fa883a84 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -7,7 +7,6 @@
 *.py text eol=lf diff=python
 *.bat text eol=crlf
 CODE_OF_CONDUCT.md -whitespace
-/Documentation/**/*.txt text eol=lf
 /Documentation/**/*.adoc text eol=lf
 /command-list.txt text eol=lf
 /GIT-VERSION-GEN text eol=lf
diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index abce806398..dd54cc768a 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -6,14 +6,10 @@
 *.pdf
 git.info
 gitman.info
-howto-index.txt
 howto-index.adoc
 doc.dep
-cmds-*.txt
 cmds-*.adoc
-mergetools-*.txt
 mergetools-*.adoc
-SubmittingPatches.txt
 SubmittingPatches.adoc
 tmp-doc-diff/
 tmp-meson-diff/
