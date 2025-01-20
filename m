Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189EFBE4A
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737338174; cv=none; b=arfoEcoN3/Nrd2LTzfJe1IxD2OXpt9a5vbLama4mPsDfVDE3Q47CrvUb+tRXXdQhKSCdDeEwvIbO2aS+RX1mJvGMRoY5oy0wdgYcfvl0CcyLZOl/7yiuTCmmAotlb29uuPZOVj1ifnyONvgW8BmWCHcCtxQH0e6nH54WqhyCIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737338174; c=relaxed/simple;
	bh=LBmC9vOfRcLATCRuklomyGixfDoJF8XfmQvCLUSz2Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eROAcD0o3Dhw5INe2QrQQRgE9E9xBhQINEdM3/UTaGsluMkTJI8iIyOXdLCsh9FFz8COG8Wri+QAZ++SkbpWK6dqZij5iOoNydHIa0FiIFl8cBaVxvAGz6/dTv8Z364Mibt3JqUFkAQjBx7n2r93Klm3xObe5PM7M8tGB9xI4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=txkvSZrX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="txkvSZrX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737338171;
	bh=LBmC9vOfRcLATCRuklomyGixfDoJF8XfmQvCLUSz2Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=txkvSZrXcRV49UxtFaKjertX/GqKu3ufnxcbrA4RxHYPX15QSbp+y2XFLFlEvpCan
	 9eXMe3eSpdPbqAkEv7i5+SD4u6iiRx71i2mJPXB+jUE3OS0ikud5TmwBQ0m1wIDbYt
	 NWdDpQ816DOIJiDEKXvSLTox/mM/RLFcoWePURLlGyEaYiAl8MzQxPHiPe4HCHkDT/
	 Bu+tt+ameqQkx3/reGMSFUeItqNiyO7CZGlJHscT6zqWEmxAvUMDKEk6VoLbRXk7fu
	 G2mKriBe8P882xULSV1qV2tdF+JEq7gxI2Ljzz0m3Dhvaj9WBd847dTN72X60S6Bgj
	 CkKb+8hgmSm5ULwpkbBxBHvUwYSu4cq50gXSL7nb4QtkJRW9aaXq9CP5AjdBLvUyfc
	 PZg0szmYWTuoejD0vvx6pPHjli4OAOUfQf4covIDA4gdiBg7Gpo6Mm4c1wox4uA3Oc
	 hjnPuBfcX8uQ3nn+Nm++8YWx/oj82ZsJrRgWwVvyln4ysbz3H1e
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 12BE02444F;
	Mon, 20 Jan 2025 01:56:11 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 2/5] editorconfig: add .adoc extension
Date: Mon, 20 Jan 2025 01:56:00 +0000
Message-ID: <20250120015603.1980991-3-sandals@crustytoothpaste.net>
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

The .adoc extension is commonly used for AsciiDoc files.  In a future
commit, we'll update some files to switch from the .txt extension to the
.adoc extension, so update the EditorConfig file to use the same
configuration for both extensions, since we want the files to be
formatted completely identically whether they're using the older or
newer extension.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .editorconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.editorconfig b/.editorconfig
index 15d6cbeab1..a3c578a43c 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -4,7 +4,7 @@ insert_final_newline = true
 
 # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
 # them in sync.
-[{*.{c,h,sh,perl,pl,pm,txt},config.mak.*,Makefile}]
+[{*.{c,h,sh,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
 indent_style = tab
 tab_width = 8
 
