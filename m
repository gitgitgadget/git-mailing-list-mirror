Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C01DFF8
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737338177; cv=none; b=cxU1/RSH+B8QPeFZWlV2z+fNoFOAAtn/7vrKqm7y+5mechSjRE7A1z8g1XQitq11nNH8TDYrZq/qOKwasm/pjv7FPUOi0muaCt/ncyjpQ47KZTfUz6M7n31Kdt1vjlFAAQUrivPiqy3h48NKRfUXmdgOJNMzcRHxWZlFvT63fK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737338177; c=relaxed/simple;
	bh=xOx3TsCm11JsbvObpMZjuXjx63qQLwlecHZwg++iqJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4B9nX0cIg+tOfndj9asChFAmjqDxSUZKMHG/HThzOU59ADqAE01TqWiUFOXfIB0wU3CsyILN3f6tUg5cmZdWhdxPMl0IG/EmkdV/hk7wRElBxSD9TA+dWfPmagehPJJvUEr5cHzkGfaze6q7cRAb3lJ+Wo2iKmO/viqIbUmixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=oYB+ktHn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oYB+ktHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737338171;
	bh=xOx3TsCm11JsbvObpMZjuXjx63qQLwlecHZwg++iqJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=oYB+ktHnz2i5Jj7LX0beBZccZFFOkgne4P1IT6b2Wh/N+g+Fx/+mYVpi4eLAWJ4Ai
	 R+5Kquz8puY5mmUQxyopkkZtyNJqPKhdVCkCa7AbM0H1opfAtEjt0s5U8FlSBaAyeK
	 kLrpHNqY81ogaW+Nxji00qvjhaBYcOQnmhXcpxRuS0CkC3Op51eqpZbzSeyI31hMOt
	 dlhIY9m9GhLsQjGxBGMUa4SmEGoPcg166fDPwVTHgGsoYbGdBwmjAWv7Wyfks9UiHu
	 XYPTVPK7tND897V/DSIXXlaVpp8jLYbHeX51J1J1LjrBObHdsMPGcsXRgQYglWxtar
	 8PRThvZJuqcBZqtFgHOOESrFfVBs30yHSyvMuGu4HWhLCmAeIBthZgkj9jp6Q2c1ni
	 NdNZqyyDyHXVOr9FAJEGxxyT9n3Cs4JqJAbDSR8isa4lZsXfTNMcodR7J3SSCllYR6
	 JE6ahNxyuxGWyFhNt9B9qaNM2uBG/3KlFVrT0YIA0bVt9JNJksr
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 09A322003E;
	Mon, 20 Jan 2025 01:56:11 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 1/5] doc: update gitignore for .adoc extension
Date: Mon, 20 Jan 2025 01:55:59 +0000
Message-ID: <20250120015603.1980991-2-sandals@crustytoothpaste.net>
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

We presently use the ".txt" extension for our AsciiDoc files.  While not
wrong, most editors do not associate this extension with AsciiDoc,
meaning that contributors don't get automatic editor functionality that
could be useful, such as syntax highlighting and prose linting.

Instead, in a future commit, we're going to move to using the more
common ".adoc" extension for these files, which many editors
intrinsically recognize as an AsciiDoc file.  To avoid contributors
accidentally checking in generated files, ignore the new extension for
generated files in the documentation .gitignore files.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/.gitignore           | 4 ++++
 Documentation/technical/.gitignore | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 9f4bb3c4bf..abce806398 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -7,10 +7,14 @@
 git.info
 gitman.info
 howto-index.txt
+howto-index.adoc
 doc.dep
 cmds-*.txt
+cmds-*.adoc
 mergetools-*.txt
+mergetools-*.adoc
 SubmittingPatches.txt
+SubmittingPatches.adoc
 tmp-doc-diff/
 tmp-meson-diff/
 GIT-ASCIIDOCFLAGS
diff --git a/Documentation/technical/.gitignore b/Documentation/technical/.gitignore
index 8aa891daee..3caef14a93 100644
--- a/Documentation/technical/.gitignore
+++ b/Documentation/technical/.gitignore
@@ -1 +1,2 @@
 api-index.txt
+api-index.adoc
