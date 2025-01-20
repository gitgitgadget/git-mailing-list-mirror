Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189121CD2C
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737338186; cv=none; b=CDnmGxirpMC2a5UnMjpAct1SvwqdDVItK92ZEprEX/uo1YBgmlihbNPzhT33ELZKJj9UosKHPwZTxwZGgzwAu6jOQm3GIpYO/Rgei9ZiqWeiUAXEFyLdQcoVX+PfPyFtheZLmkXealkld7kSwXiiEAEetMqJsEGrOOfFvbQLDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737338186; c=relaxed/simple;
	bh=Hvf7dEtGgU4cjfQvKkBjQEHAYoSUMS13UuTPXYaLeXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT8ZcDlnnosIrqnyigdC9MYlF4X46QS5+wR+DnEwPNutD42Sq+3A08qzMMcUh/SLT/kZ+NnsoBU2+1UYZxrJ9nYO50FbYrLXTtbSfmmJ6fcEIrmXNDb0NpOzQD/EAFqv7K2M0SahcbHbtf2gmLbhPoC6d6xyRIDCUbVwd6kC0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wnCiFu4T; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wnCiFu4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737338171;
	bh=Hvf7dEtGgU4cjfQvKkBjQEHAYoSUMS13UuTPXYaLeXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=wnCiFu4T/+dtbNLE+MUmQAZ1v/BkJ53HZX4h1R7423JBLLZhk/zJ7ZxqyPui/T8+a
	 oU4dRxaCPxC7+PRIdYtgChvIY4s8b2M5zge361qvjlrkluE+bu7KkAxDBSQTWQSE6o
	 XshhWY/VCgvSWV3tRd37kzCkRWBD6HfKxg6UZTw9NFjIHAYx7S7dTAbebpfpFxNx0g
	 n0maoNbRRJnHHVNIDzwJFo+oGN17AIJX9PWmLeD4ey/zrAkg5FrzTSq1/zhbZuDrrC
	 A4BSA4I4cP7eyUxIGra0qtLZRGpOjVKqAbDVMlRZZf9aAtUv57g4EpwXLSqGwDryZH
	 2H35aYoKE1AqDiCji1+dm7VHPYvaMO2VK9ha3OVdTCw/AUI29ppmenvqzH8HPqZQrh
	 F5/Cf6Ceaypn4fYgTu+v/axdw1MzRtkkJyEuRe1F3MbEvPVSp0g3UBPMplPuAk+ACx
	 JIMeLq5O28MMe+yKORHet9B6yzI/tZeA1yKLEUEJAZMnP9ZWcfH
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 297F524452;
	Mon, 20 Jan 2025 01:56:11 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
Date: Mon, 20 Jan 2025 01:56:02 +0000
Message-ID: <20250120015603.1980991-5-sandals@crustytoothpaste.net>
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

It is much more common to use the ".adoc" extension for AsciiDoc files,
since this helps editors automatically detect files and also allows
various forges to provide rich (HTML-like) rendering.  Let's do that
here, renaming all of the files and updating the includes where
relevant.  Adjust the various build scripts and makefiles to use the new
extension as well.

Note that this should not result in any user-visible changes to the
documentation.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ...eakingChanges.txt => BreakingChanges.adoc} |   0
 ...DecisionMaking.txt => DecisionMaking.adoc} |   0
 Documentation/Makefile                        | 194 ++++----
 ...tribution.txt => MyFirstContribution.adoc} |   0
 ...tObjectWalk.txt => MyFirstObjectWalk.adoc} |   0
 .../RelNotes/{1.5.0.1.txt => 1.5.0.1.adoc}    |   0
 .../RelNotes/{1.5.0.2.txt => 1.5.0.2.adoc}    |   0
 .../RelNotes/{1.5.0.3.txt => 1.5.0.3.adoc}    |   0
 .../RelNotes/{1.5.0.4.txt => 1.5.0.4.adoc}    |   0
 .../RelNotes/{1.5.0.5.txt => 1.5.0.5.adoc}    |   0
 .../RelNotes/{1.5.0.6.txt => 1.5.0.6.adoc}    |   0
 .../RelNotes/{1.5.0.7.txt => 1.5.0.7.adoc}    |   0
 .../RelNotes/{1.5.0.txt => 1.5.0.adoc}        |   0
 .../RelNotes/{1.5.1.1.txt => 1.5.1.1.adoc}    |   0
 .../RelNotes/{1.5.1.2.txt => 1.5.1.2.adoc}    |   0
 .../RelNotes/{1.5.1.3.txt => 1.5.1.3.adoc}    |   0
 .../RelNotes/{1.5.1.4.txt => 1.5.1.4.adoc}    |   0
 .../RelNotes/{1.5.1.5.txt => 1.5.1.5.adoc}    |   0
 .../RelNotes/{1.5.1.6.txt => 1.5.1.6.adoc}    |   0
 .../RelNotes/{1.5.1.txt => 1.5.1.adoc}        |   0
 .../RelNotes/{1.5.2.1.txt => 1.5.2.1.adoc}    |   0
 .../RelNotes/{1.5.2.2.txt => 1.5.2.2.adoc}    |   0
 .../RelNotes/{1.5.2.3.txt => 1.5.2.3.adoc}    |   0
 .../RelNotes/{1.5.2.4.txt => 1.5.2.4.adoc}    |   0
 .../RelNotes/{1.5.2.5.txt => 1.5.2.5.adoc}    |   0
 .../RelNotes/{1.5.2.txt => 1.5.2.adoc}        |   0
 .../RelNotes/{1.5.3.1.txt => 1.5.3.1.adoc}    |   0
 .../RelNotes/{1.5.3.2.txt => 1.5.3.2.adoc}    |   0
 .../RelNotes/{1.5.3.3.txt => 1.5.3.3.adoc}    |   0
 .../RelNotes/{1.5.3.4.txt => 1.5.3.4.adoc}    |   0
 .../RelNotes/{1.5.3.5.txt => 1.5.3.5.adoc}    |   0
 .../RelNotes/{1.5.3.6.txt => 1.5.3.6.adoc}    |   0
 .../RelNotes/{1.5.3.7.txt => 1.5.3.7.adoc}    |   0
 .../RelNotes/{1.5.3.8.txt => 1.5.3.8.adoc}    |   0
 .../RelNotes/{1.5.3.txt => 1.5.3.adoc}        |   0
 .../RelNotes/{1.5.4.1.txt => 1.5.4.1.adoc}    |   0
 .../RelNotes/{1.5.4.2.txt => 1.5.4.2.adoc}    |   0
 .../RelNotes/{1.5.4.3.txt => 1.5.4.3.adoc}    |   0
 .../RelNotes/{1.5.4.4.txt => 1.5.4.4.adoc}    |   0
 .../RelNotes/{1.5.4.5.txt => 1.5.4.5.adoc}    |   0
 .../RelNotes/{1.5.4.6.txt => 1.5.4.6.adoc}    |   0
 .../RelNotes/{1.5.4.7.txt => 1.5.4.7.adoc}    |   0
 .../RelNotes/{1.5.4.txt => 1.5.4.adoc}        |   0
 .../RelNotes/{1.5.5.1.txt => 1.5.5.1.adoc}    |   0
 .../RelNotes/{1.5.5.2.txt => 1.5.5.2.adoc}    |   0
 .../RelNotes/{1.5.5.3.txt => 1.5.5.3.adoc}    |   0
 .../RelNotes/{1.5.5.4.txt => 1.5.5.4.adoc}    |   0
 .../RelNotes/{1.5.5.5.txt => 1.5.5.5.adoc}    |   0
 .../RelNotes/{1.5.5.6.txt => 1.5.5.6.adoc}    |   0
 .../RelNotes/{1.5.5.txt => 1.5.5.adoc}        |   0
 .../RelNotes/{1.5.6.1.txt => 1.5.6.1.adoc}    |   0
 .../RelNotes/{1.5.6.2.txt => 1.5.6.2.adoc}    |   0
 .../RelNotes/{1.5.6.3.txt => 1.5.6.3.adoc}    |   0
 .../RelNotes/{1.5.6.4.txt => 1.5.6.4.adoc}    |   0
 .../RelNotes/{1.5.6.5.txt => 1.5.6.5.adoc}    |   0
 .../RelNotes/{1.5.6.6.txt => 1.5.6.6.adoc}    |   0
 .../RelNotes/{1.5.6.txt => 1.5.6.adoc}        |   0
 .../RelNotes/{1.6.0.1.txt => 1.6.0.1.adoc}    |   0
 .../RelNotes/{1.6.0.2.txt => 1.6.0.2.adoc}    |   0
 .../RelNotes/{1.6.0.3.txt => 1.6.0.3.adoc}    |   0
 .../RelNotes/{1.6.0.4.txt => 1.6.0.4.adoc}    |   0
 .../RelNotes/{1.6.0.5.txt => 1.6.0.5.adoc}    |   0
 .../RelNotes/{1.6.0.6.txt => 1.6.0.6.adoc}    |   0
 .../RelNotes/{1.6.0.txt => 1.6.0.adoc}        |   0
 .../RelNotes/{1.6.1.1.txt => 1.6.1.1.adoc}    |   0
 .../RelNotes/{1.6.1.2.txt => 1.6.1.2.adoc}    |   0
 .../RelNotes/{1.6.1.3.txt => 1.6.1.3.adoc}    |   0
 .../RelNotes/{1.6.1.4.txt => 1.6.1.4.adoc}    |   0
 .../RelNotes/{1.6.1.txt => 1.6.1.adoc}        |   0
 .../RelNotes/{1.6.2.1.txt => 1.6.2.1.adoc}    |   0
 .../RelNotes/{1.6.2.2.txt => 1.6.2.2.adoc}    |   0
 .../RelNotes/{1.6.2.3.txt => 1.6.2.3.adoc}    |   0
 .../RelNotes/{1.6.2.4.txt => 1.6.2.4.adoc}    |   0
 .../RelNotes/{1.6.2.5.txt => 1.6.2.5.adoc}    |   0
 .../RelNotes/{1.6.2.txt => 1.6.2.adoc}        |   0
 .../RelNotes/{1.6.3.1.txt => 1.6.3.1.adoc}    |   0
 .../RelNotes/{1.6.3.2.txt => 1.6.3.2.adoc}    |   0
 .../RelNotes/{1.6.3.3.txt => 1.6.3.3.adoc}    |   0
 .../RelNotes/{1.6.3.4.txt => 1.6.3.4.adoc}    |   0
 .../RelNotes/{1.6.3.txt => 1.6.3.adoc}        |   0
 .../RelNotes/{1.6.4.1.txt => 1.6.4.1.adoc}    |   0
 .../RelNotes/{1.6.4.2.txt => 1.6.4.2.adoc}    |   0
 .../RelNotes/{1.6.4.3.txt => 1.6.4.3.adoc}    |   0
 .../RelNotes/{1.6.4.4.txt => 1.6.4.4.adoc}    |   0
 .../RelNotes/{1.6.4.5.txt => 1.6.4.5.adoc}    |   0
 .../RelNotes/{1.6.4.txt => 1.6.4.adoc}        |   0
 .../RelNotes/{1.6.5.1.txt => 1.6.5.1.adoc}    |   0
 .../RelNotes/{1.6.5.2.txt => 1.6.5.2.adoc}    |   0
 .../RelNotes/{1.6.5.3.txt => 1.6.5.3.adoc}    |   0
 .../RelNotes/{1.6.5.4.txt => 1.6.5.4.adoc}    |   0
 .../RelNotes/{1.6.5.5.txt => 1.6.5.5.adoc}    |   0
 .../RelNotes/{1.6.5.6.txt => 1.6.5.6.adoc}    |   0
 .../RelNotes/{1.6.5.7.txt => 1.6.5.7.adoc}    |   0
 .../RelNotes/{1.6.5.8.txt => 1.6.5.8.adoc}    |   0
 .../RelNotes/{1.6.5.9.txt => 1.6.5.9.adoc}    |   0
 .../RelNotes/{1.6.5.txt => 1.6.5.adoc}        |   0
 .../RelNotes/{1.6.6.1.txt => 1.6.6.1.adoc}    |   0
 .../RelNotes/{1.6.6.2.txt => 1.6.6.2.adoc}    |   0
 .../RelNotes/{1.6.6.3.txt => 1.6.6.3.adoc}    |   0
 .../RelNotes/{1.6.6.txt => 1.6.6.adoc}        |   0
 .../RelNotes/{1.7.0.1.txt => 1.7.0.1.adoc}    |   0
 .../RelNotes/{1.7.0.2.txt => 1.7.0.2.adoc}    |   0
 .../RelNotes/{1.7.0.3.txt => 1.7.0.3.adoc}    |   0
 .../RelNotes/{1.7.0.4.txt => 1.7.0.4.adoc}    |   0
 .../RelNotes/{1.7.0.5.txt => 1.7.0.5.adoc}    |   0
 .../RelNotes/{1.7.0.6.txt => 1.7.0.6.adoc}    |   0
 .../RelNotes/{1.7.0.7.txt => 1.7.0.7.adoc}    |   0
 .../RelNotes/{1.7.0.8.txt => 1.7.0.8.adoc}    |   0
 .../RelNotes/{1.7.0.9.txt => 1.7.0.9.adoc}    |   0
 .../RelNotes/{1.7.0.txt => 1.7.0.adoc}        |   0
 .../RelNotes/{1.7.1.1.txt => 1.7.1.1.adoc}    |   0
 .../RelNotes/{1.7.1.2.txt => 1.7.1.2.adoc}    |   0
 .../RelNotes/{1.7.1.3.txt => 1.7.1.3.adoc}    |   0
 .../RelNotes/{1.7.1.4.txt => 1.7.1.4.adoc}    |   0
 .../RelNotes/{1.7.1.txt => 1.7.1.adoc}        |   0
 .../RelNotes/{1.7.10.1.txt => 1.7.10.1.adoc}  |   0
 .../RelNotes/{1.7.10.2.txt => 1.7.10.2.adoc}  |   0
 .../RelNotes/{1.7.10.3.txt => 1.7.10.3.adoc}  |   0
 .../RelNotes/{1.7.10.4.txt => 1.7.10.4.adoc}  |   0
 .../RelNotes/{1.7.10.5.txt => 1.7.10.5.adoc}  |   0
 .../RelNotes/{1.7.10.txt => 1.7.10.adoc}      |   0
 .../RelNotes/{1.7.11.1.txt => 1.7.11.1.adoc}  |   0
 .../RelNotes/{1.7.11.2.txt => 1.7.11.2.adoc}  |   0
 .../RelNotes/{1.7.11.3.txt => 1.7.11.3.adoc}  |   0
 .../RelNotes/{1.7.11.4.txt => 1.7.11.4.adoc}  |   0
 .../RelNotes/{1.7.11.5.txt => 1.7.11.5.adoc}  |   0
 .../RelNotes/{1.7.11.6.txt => 1.7.11.6.adoc}  |   0
 .../RelNotes/{1.7.11.7.txt => 1.7.11.7.adoc}  |   0
 .../RelNotes/{1.7.11.txt => 1.7.11.adoc}      |   0
 .../RelNotes/{1.7.12.1.txt => 1.7.12.1.adoc}  |   0
 .../RelNotes/{1.7.12.2.txt => 1.7.12.2.adoc}  |   0
 .../RelNotes/{1.7.12.3.txt => 1.7.12.3.adoc}  |   0
 .../RelNotes/{1.7.12.4.txt => 1.7.12.4.adoc}  |   0
 .../RelNotes/{1.7.12.txt => 1.7.12.adoc}      |   0
 .../RelNotes/{1.7.2.1.txt => 1.7.2.1.adoc}    |   0
 .../RelNotes/{1.7.2.2.txt => 1.7.2.2.adoc}    |   0
 .../RelNotes/{1.7.2.3.txt => 1.7.2.3.adoc}    |   0
 .../RelNotes/{1.7.2.4.txt => 1.7.2.4.adoc}    |   0
 .../RelNotes/{1.7.2.5.txt => 1.7.2.5.adoc}    |   0
 .../RelNotes/{1.7.2.txt => 1.7.2.adoc}        |   0
 .../RelNotes/{1.7.3.1.txt => 1.7.3.1.adoc}    |   0
 .../RelNotes/{1.7.3.2.txt => 1.7.3.2.adoc}    |   0
 .../RelNotes/{1.7.3.3.txt => 1.7.3.3.adoc}    |   0
 .../RelNotes/{1.7.3.4.txt => 1.7.3.4.adoc}    |   0
 .../RelNotes/{1.7.3.5.txt => 1.7.3.5.adoc}    |   0
 .../RelNotes/{1.7.3.txt => 1.7.3.adoc}        |   0
 .../RelNotes/{1.7.4.1.txt => 1.7.4.1.adoc}    |   0
 .../RelNotes/{1.7.4.2.txt => 1.7.4.2.adoc}    |   0
 .../RelNotes/{1.7.4.3.txt => 1.7.4.3.adoc}    |   0
 .../RelNotes/{1.7.4.4.txt => 1.7.4.4.adoc}    |   0
 .../RelNotes/{1.7.4.5.txt => 1.7.4.5.adoc}    |   0
 .../RelNotes/{1.7.4.txt => 1.7.4.adoc}        |   0
 .../RelNotes/{1.7.5.1.txt => 1.7.5.1.adoc}    |   0
 .../RelNotes/{1.7.5.2.txt => 1.7.5.2.adoc}    |   0
 .../RelNotes/{1.7.5.3.txt => 1.7.5.3.adoc}    |   0
 .../RelNotes/{1.7.5.4.txt => 1.7.5.4.adoc}    |   0
 .../RelNotes/{1.7.5.txt => 1.7.5.adoc}        |   0
 .../RelNotes/{1.7.6.1.txt => 1.7.6.1.adoc}    |   0
 .../RelNotes/{1.7.6.2.txt => 1.7.6.2.adoc}    |   0
 .../RelNotes/{1.7.6.3.txt => 1.7.6.3.adoc}    |   0
 .../RelNotes/{1.7.6.4.txt => 1.7.6.4.adoc}    |   0
 .../RelNotes/{1.7.6.5.txt => 1.7.6.5.adoc}    |   0
 .../RelNotes/{1.7.6.6.txt => 1.7.6.6.adoc}    |   0
 .../RelNotes/{1.7.6.txt => 1.7.6.adoc}        |   0
 .../RelNotes/{1.7.7.1.txt => 1.7.7.1.adoc}    |   0
 .../RelNotes/{1.7.7.2.txt => 1.7.7.2.adoc}    |   0
 .../RelNotes/{1.7.7.3.txt => 1.7.7.3.adoc}    |   0
 .../RelNotes/{1.7.7.4.txt => 1.7.7.4.adoc}    |   0
 .../RelNotes/{1.7.7.5.txt => 1.7.7.5.adoc}    |   0
 .../RelNotes/{1.7.7.6.txt => 1.7.7.6.adoc}    |   0
 .../RelNotes/{1.7.7.7.txt => 1.7.7.7.adoc}    |   0
 .../RelNotes/{1.7.7.txt => 1.7.7.adoc}        |   0
 .../RelNotes/{1.7.8.1.txt => 1.7.8.1.adoc}    |   0
 .../RelNotes/{1.7.8.2.txt => 1.7.8.2.adoc}    |   0
 .../RelNotes/{1.7.8.3.txt => 1.7.8.3.adoc}    |   0
 .../RelNotes/{1.7.8.4.txt => 1.7.8.4.adoc}    |   0
 .../RelNotes/{1.7.8.5.txt => 1.7.8.5.adoc}    |   0
 .../RelNotes/{1.7.8.6.txt => 1.7.8.6.adoc}    |   0
 .../RelNotes/{1.7.8.txt => 1.7.8.adoc}        |   0
 .../RelNotes/{1.7.9.1.txt => 1.7.9.1.adoc}    |   0
 .../RelNotes/{1.7.9.2.txt => 1.7.9.2.adoc}    |   0
 .../RelNotes/{1.7.9.3.txt => 1.7.9.3.adoc}    |   0
 .../RelNotes/{1.7.9.4.txt => 1.7.9.4.adoc}    |   0
 .../RelNotes/{1.7.9.5.txt => 1.7.9.5.adoc}    |   0
 .../RelNotes/{1.7.9.6.txt => 1.7.9.6.adoc}    |   0
 .../RelNotes/{1.7.9.7.txt => 1.7.9.7.adoc}    |   0
 .../RelNotes/{1.7.9.txt => 1.7.9.adoc}        |   0
 .../RelNotes/{1.8.0.1.txt => 1.8.0.1.adoc}    |   0
 .../RelNotes/{1.8.0.2.txt => 1.8.0.2.adoc}    |   0
 .../RelNotes/{1.8.0.3.txt => 1.8.0.3.adoc}    |   0
 .../RelNotes/{1.8.0.txt => 1.8.0.adoc}        |   0
 .../RelNotes/{1.8.1.1.txt => 1.8.1.1.adoc}    |   0
 .../RelNotes/{1.8.1.2.txt => 1.8.1.2.adoc}    |   0
 .../RelNotes/{1.8.1.3.txt => 1.8.1.3.adoc}    |   0
 .../RelNotes/{1.8.1.4.txt => 1.8.1.4.adoc}    |   0
 .../RelNotes/{1.8.1.5.txt => 1.8.1.5.adoc}    |   0
 .../RelNotes/{1.8.1.6.txt => 1.8.1.6.adoc}    |   0
 .../RelNotes/{1.8.1.txt => 1.8.1.adoc}        |   0
 .../RelNotes/{1.8.2.1.txt => 1.8.2.1.adoc}    |   0
 .../RelNotes/{1.8.2.2.txt => 1.8.2.2.adoc}    |   0
 .../RelNotes/{1.8.2.3.txt => 1.8.2.3.adoc}    |   0
 .../RelNotes/{1.8.2.txt => 1.8.2.adoc}        |   0
 .../RelNotes/{1.8.3.1.txt => 1.8.3.1.adoc}    |   0
 .../RelNotes/{1.8.3.2.txt => 1.8.3.2.adoc}    |   0
 .../RelNotes/{1.8.3.3.txt => 1.8.3.3.adoc}    |   0
 .../RelNotes/{1.8.3.4.txt => 1.8.3.4.adoc}    |   0
 .../RelNotes/{1.8.3.txt => 1.8.3.adoc}        |   0
 .../RelNotes/{1.8.4.1.txt => 1.8.4.1.adoc}    |   0
 .../RelNotes/{1.8.4.2.txt => 1.8.4.2.adoc}    |   0
 .../RelNotes/{1.8.4.3.txt => 1.8.4.3.adoc}    |   0
 .../RelNotes/{1.8.4.4.txt => 1.8.4.4.adoc}    |   0
 .../RelNotes/{1.8.4.5.txt => 1.8.4.5.adoc}    |   0
 .../RelNotes/{1.8.4.txt => 1.8.4.adoc}        |   0
 .../RelNotes/{1.8.5.1.txt => 1.8.5.1.adoc}    |   0
 .../RelNotes/{1.8.5.2.txt => 1.8.5.2.adoc}    |   0
 .../RelNotes/{1.8.5.3.txt => 1.8.5.3.adoc}    |   0
 .../RelNotes/{1.8.5.4.txt => 1.8.5.4.adoc}    |   0
 .../RelNotes/{1.8.5.5.txt => 1.8.5.5.adoc}    |   0
 .../RelNotes/{1.8.5.6.txt => 1.8.5.6.adoc}    |   0
 .../RelNotes/{1.8.5.txt => 1.8.5.adoc}        |   0
 .../RelNotes/{1.9.0.txt => 1.9.0.adoc}        |   0
 .../RelNotes/{1.9.1.txt => 1.9.1.adoc}        |   0
 .../RelNotes/{1.9.2.txt => 1.9.2.adoc}        |   0
 .../RelNotes/{1.9.3.txt => 1.9.3.adoc}        |   0
 .../RelNotes/{1.9.4.txt => 1.9.4.adoc}        |   0
 .../RelNotes/{1.9.5.txt => 1.9.5.adoc}        |   0
 .../RelNotes/{2.0.0.txt => 2.0.0.adoc}        |   0
 .../RelNotes/{2.0.1.txt => 2.0.1.adoc}        |   0
 .../RelNotes/{2.0.2.txt => 2.0.2.adoc}        |   0
 .../RelNotes/{2.0.3.txt => 2.0.3.adoc}        |   0
 .../RelNotes/{2.0.4.txt => 2.0.4.adoc}        |   0
 .../RelNotes/{2.0.5.txt => 2.0.5.adoc}        |   0
 .../RelNotes/{2.1.0.txt => 2.1.0.adoc}        |   0
 .../RelNotes/{2.1.1.txt => 2.1.1.adoc}        |   0
 .../RelNotes/{2.1.2.txt => 2.1.2.adoc}        |   0
 .../RelNotes/{2.1.3.txt => 2.1.3.adoc}        |   0
 .../RelNotes/{2.1.4.txt => 2.1.4.adoc}        |   0
 .../RelNotes/{2.10.0.txt => 2.10.0.adoc}      |   0
 .../RelNotes/{2.10.1.txt => 2.10.1.adoc}      |   0
 .../RelNotes/{2.10.2.txt => 2.10.2.adoc}      |   0
 .../RelNotes/{2.10.3.txt => 2.10.3.adoc}      |   0
 .../RelNotes/{2.10.4.txt => 2.10.4.adoc}      |   0
 .../RelNotes/{2.10.5.txt => 2.10.5.adoc}      |   0
 .../RelNotes/{2.11.0.txt => 2.11.0.adoc}      |   0
 .../RelNotes/{2.11.1.txt => 2.11.1.adoc}      |   0
 .../RelNotes/{2.11.2.txt => 2.11.2.adoc}      |   0
 .../RelNotes/{2.11.3.txt => 2.11.3.adoc}      |   0
 .../RelNotes/{2.11.4.txt => 2.11.4.adoc}      |   0
 .../RelNotes/{2.12.0.txt => 2.12.0.adoc}      |   0
 .../RelNotes/{2.12.1.txt => 2.12.1.adoc}      |   0
 .../RelNotes/{2.12.2.txt => 2.12.2.adoc}      |   0
 .../RelNotes/{2.12.3.txt => 2.12.3.adoc}      |   0
 .../RelNotes/{2.12.4.txt => 2.12.4.adoc}      |   0
 .../RelNotes/{2.12.5.txt => 2.12.5.adoc}      |   0
 .../RelNotes/{2.13.0.txt => 2.13.0.adoc}      |   0
 .../RelNotes/{2.13.1.txt => 2.13.1.adoc}      |   0
 .../RelNotes/{2.13.2.txt => 2.13.2.adoc}      |   0
 .../RelNotes/{2.13.3.txt => 2.13.3.adoc}      |   0
 .../RelNotes/{2.13.4.txt => 2.13.4.adoc}      |   0
 .../RelNotes/{2.13.5.txt => 2.13.5.adoc}      |   0
 .../RelNotes/{2.13.6.txt => 2.13.6.adoc}      |   0
 .../RelNotes/{2.13.7.txt => 2.13.7.adoc}      |   0
 .../RelNotes/{2.14.0.txt => 2.14.0.adoc}      |   0
 .../RelNotes/{2.14.1.txt => 2.14.1.adoc}      |   0
 .../RelNotes/{2.14.2.txt => 2.14.2.adoc}      |   0
 .../RelNotes/{2.14.3.txt => 2.14.3.adoc}      |   0
 .../RelNotes/{2.14.4.txt => 2.14.4.adoc}      |   0
 .../RelNotes/{2.14.5.txt => 2.14.5.adoc}      |   0
 .../RelNotes/{2.14.6.txt => 2.14.6.adoc}      |   0
 .../RelNotes/{2.15.0.txt => 2.15.0.adoc}      |   0
 .../RelNotes/{2.15.1.txt => 2.15.1.adoc}      |   0
 .../RelNotes/{2.15.2.txt => 2.15.2.adoc}      |   0
 .../RelNotes/{2.15.3.txt => 2.15.3.adoc}      |   0
 .../RelNotes/{2.15.4.txt => 2.15.4.adoc}      |   0
 .../RelNotes/{2.16.0.txt => 2.16.0.adoc}      |   0
 .../RelNotes/{2.16.1.txt => 2.16.1.adoc}      |   0
 .../RelNotes/{2.16.2.txt => 2.16.2.adoc}      |   0
 .../RelNotes/{2.16.3.txt => 2.16.3.adoc}      |   0
 .../RelNotes/{2.16.4.txt => 2.16.4.adoc}      |   0
 .../RelNotes/{2.16.5.txt => 2.16.5.adoc}      |   0
 .../RelNotes/{2.16.6.txt => 2.16.6.adoc}      |   0
 .../RelNotes/{2.17.0.txt => 2.17.0.adoc}      |   0
 .../RelNotes/{2.17.1.txt => 2.17.1.adoc}      |   0
 .../RelNotes/{2.17.2.txt => 2.17.2.adoc}      |   0
 .../RelNotes/{2.17.3.txt => 2.17.3.adoc}      |   0
 .../RelNotes/{2.17.4.txt => 2.17.4.adoc}      |   0
 .../RelNotes/{2.17.5.txt => 2.17.5.adoc}      |   0
 .../RelNotes/{2.17.6.txt => 2.17.6.adoc}      |   0
 .../RelNotes/{2.18.0.txt => 2.18.0.adoc}      |   0
 .../RelNotes/{2.18.1.txt => 2.18.1.adoc}      |   0
 .../RelNotes/{2.18.2.txt => 2.18.2.adoc}      |   0
 .../RelNotes/{2.18.3.txt => 2.18.3.adoc}      |   0
 .../RelNotes/{2.18.4.txt => 2.18.4.adoc}      |   0
 .../RelNotes/{2.18.5.txt => 2.18.5.adoc}      |   0
 .../RelNotes/{2.19.0.txt => 2.19.0.adoc}      |   0
 .../RelNotes/{2.19.1.txt => 2.19.1.adoc}      |   0
 .../RelNotes/{2.19.2.txt => 2.19.2.adoc}      |   0
 .../RelNotes/{2.19.3.txt => 2.19.3.adoc}      |   0
 .../RelNotes/{2.19.4.txt => 2.19.4.adoc}      |   0
 .../RelNotes/{2.19.5.txt => 2.19.5.adoc}      |   0
 .../RelNotes/{2.19.6.txt => 2.19.6.adoc}      |   0
 .../RelNotes/{2.2.0.txt => 2.2.0.adoc}        |   0
 .../RelNotes/{2.2.1.txt => 2.2.1.adoc}        |   0
 .../RelNotes/{2.2.2.txt => 2.2.2.adoc}        |   0
 .../RelNotes/{2.2.3.txt => 2.2.3.adoc}        |   0
 .../RelNotes/{2.20.0.txt => 2.20.0.adoc}      |   0
 .../RelNotes/{2.20.1.txt => 2.20.1.adoc}      |   0
 .../RelNotes/{2.20.2.txt => 2.20.2.adoc}      |   0
 .../RelNotes/{2.20.3.txt => 2.20.3.adoc}      |   0
 .../RelNotes/{2.20.4.txt => 2.20.4.adoc}      |   0
 .../RelNotes/{2.20.5.txt => 2.20.5.adoc}      |   0
 .../RelNotes/{2.21.0.txt => 2.21.0.adoc}      |   0
 .../RelNotes/{2.21.1.txt => 2.21.1.adoc}      |   0
 .../RelNotes/{2.21.2.txt => 2.21.2.adoc}      |   0
 .../RelNotes/{2.21.3.txt => 2.21.3.adoc}      |   0
 .../RelNotes/{2.21.4.txt => 2.21.4.adoc}      |   0
 .../RelNotes/{2.22.0.txt => 2.22.0.adoc}      |   0
 .../RelNotes/{2.22.1.txt => 2.22.1.adoc}      |   0
 .../RelNotes/{2.22.2.txt => 2.22.2.adoc}      |   0
 .../RelNotes/{2.22.3.txt => 2.22.3.adoc}      |   0
 .../RelNotes/{2.22.4.txt => 2.22.4.adoc}      |   0
 .../RelNotes/{2.22.5.txt => 2.22.5.adoc}      |   0
 .../RelNotes/{2.23.0.txt => 2.23.0.adoc}      |   0
 .../RelNotes/{2.23.1.txt => 2.23.1.adoc}      |   0
 .../RelNotes/{2.23.2.txt => 2.23.2.adoc}      |   0
 .../RelNotes/{2.23.3.txt => 2.23.3.adoc}      |   0
 .../RelNotes/{2.23.4.txt => 2.23.4.adoc}      |   0
 .../RelNotes/{2.24.0.txt => 2.24.0.adoc}      |   0
 .../RelNotes/{2.24.1.txt => 2.24.1.adoc}      |   0
 .../RelNotes/{2.24.2.txt => 2.24.2.adoc}      |   0
 .../RelNotes/{2.24.3.txt => 2.24.3.adoc}      |   0
 .../RelNotes/{2.24.4.txt => 2.24.4.adoc}      |   0
 .../RelNotes/{2.25.0.txt => 2.25.0.adoc}      |   0
 .../RelNotes/{2.25.1.txt => 2.25.1.adoc}      |   0
 .../RelNotes/{2.25.2.txt => 2.25.2.adoc}      |   0
 .../RelNotes/{2.25.3.txt => 2.25.3.adoc}      |   0
 .../RelNotes/{2.25.4.txt => 2.25.4.adoc}      |   0
 .../RelNotes/{2.25.5.txt => 2.25.5.adoc}      |   0
 .../RelNotes/{2.26.0.txt => 2.26.0.adoc}      |   0
 .../RelNotes/{2.26.1.txt => 2.26.1.adoc}      |   0
 .../RelNotes/{2.26.2.txt => 2.26.2.adoc}      |   0
 .../RelNotes/{2.26.3.txt => 2.26.3.adoc}      |   0
 .../RelNotes/{2.27.0.txt => 2.27.0.adoc}      |   0
 .../RelNotes/{2.27.1.txt => 2.27.1.adoc}      |   0
 .../RelNotes/{2.28.0.txt => 2.28.0.adoc}      |   0
 .../RelNotes/{2.28.1.txt => 2.28.1.adoc}      |   0
 .../RelNotes/{2.29.0.txt => 2.29.0.adoc}      |   0
 .../RelNotes/{2.29.1.txt => 2.29.1.adoc}      |   0
 .../RelNotes/{2.29.2.txt => 2.29.2.adoc}      |   0
 .../RelNotes/{2.29.3.txt => 2.29.3.adoc}      |   0
 .../RelNotes/{2.3.0.txt => 2.3.0.adoc}        |   0
 .../RelNotes/{2.3.1.txt => 2.3.1.adoc}        |   0
 .../RelNotes/{2.3.10.txt => 2.3.10.adoc}      |   0
 .../RelNotes/{2.3.2.txt => 2.3.2.adoc}        |   0
 .../RelNotes/{2.3.3.txt => 2.3.3.adoc}        |   0
 .../RelNotes/{2.3.4.txt => 2.3.4.adoc}        |   0
 .../RelNotes/{2.3.5.txt => 2.3.5.adoc}        |   0
 .../RelNotes/{2.3.6.txt => 2.3.6.adoc}        |   0
 .../RelNotes/{2.3.7.txt => 2.3.7.adoc}        |   0
 .../RelNotes/{2.3.8.txt => 2.3.8.adoc}        |   0
 .../RelNotes/{2.3.9.txt => 2.3.9.adoc}        |   0
 .../RelNotes/{2.30.0.txt => 2.30.0.adoc}      |   0
 .../RelNotes/{2.30.1.txt => 2.30.1.adoc}      |   0
 .../RelNotes/{2.30.2.txt => 2.30.2.adoc}      |   0
 .../RelNotes/{2.30.3.txt => 2.30.3.adoc}      |   0
 .../RelNotes/{2.30.4.txt => 2.30.4.adoc}      |   0
 .../RelNotes/{2.30.5.txt => 2.30.5.adoc}      |   0
 .../RelNotes/{2.30.6.txt => 2.30.6.adoc}      |   0
 .../RelNotes/{2.30.7.txt => 2.30.7.adoc}      |   0
 .../RelNotes/{2.30.8.txt => 2.30.8.adoc}      |   0
 .../RelNotes/{2.30.9.txt => 2.30.9.adoc}      |   0
 .../RelNotes/{2.31.0.txt => 2.31.0.adoc}      |   0
 .../RelNotes/{2.31.1.txt => 2.31.1.adoc}      |   0
 .../RelNotes/{2.31.2.txt => 2.31.2.adoc}      |   0
 .../RelNotes/{2.31.3.txt => 2.31.3.adoc}      |   0
 .../RelNotes/{2.31.4.txt => 2.31.4.adoc}      |   0
 .../RelNotes/{2.31.5.txt => 2.31.5.adoc}      |   0
 .../RelNotes/{2.31.6.txt => 2.31.6.adoc}      |   0
 .../RelNotes/{2.31.7.txt => 2.31.7.adoc}      |   0
 .../RelNotes/{2.31.8.txt => 2.31.8.adoc}      |   0
 .../RelNotes/{2.32.0.txt => 2.32.0.adoc}      |   0
 .../RelNotes/{2.32.1.txt => 2.32.1.adoc}      |   0
 .../RelNotes/{2.32.2.txt => 2.32.2.adoc}      |   0
 .../RelNotes/{2.32.3.txt => 2.32.3.adoc}      |   0
 .../RelNotes/{2.32.4.txt => 2.32.4.adoc}      |   0
 .../RelNotes/{2.32.5.txt => 2.32.5.adoc}      |   0
 .../RelNotes/{2.32.6.txt => 2.32.6.adoc}      |   0
 .../RelNotes/{2.32.7.txt => 2.32.7.adoc}      |   0
 .../RelNotes/{2.33.0.txt => 2.33.0.adoc}      |   0
 .../RelNotes/{2.33.1.txt => 2.33.1.adoc}      |   0
 .../RelNotes/{2.33.2.txt => 2.33.2.adoc}      |   0
 .../RelNotes/{2.33.3.txt => 2.33.3.adoc}      |   0
 .../RelNotes/{2.33.4.txt => 2.33.4.adoc}      |   0
 .../RelNotes/{2.33.5.txt => 2.33.5.adoc}      |   0
 .../RelNotes/{2.33.6.txt => 2.33.6.adoc}      |   0
 .../RelNotes/{2.33.7.txt => 2.33.7.adoc}      |   0
 .../RelNotes/{2.33.8.txt => 2.33.8.adoc}      |   0
 .../RelNotes/{2.34.0.txt => 2.34.0.adoc}      |   0
 .../RelNotes/{2.34.1.txt => 2.34.1.adoc}      |   0
 .../RelNotes/{2.34.2.txt => 2.34.2.adoc}      |   0
 .../RelNotes/{2.34.3.txt => 2.34.3.adoc}      |   0
 .../RelNotes/{2.34.4.txt => 2.34.4.adoc}      |   0
 .../RelNotes/{2.34.5.txt => 2.34.5.adoc}      |   0
 .../RelNotes/{2.34.6.txt => 2.34.6.adoc}      |   0
 .../RelNotes/{2.34.7.txt => 2.34.7.adoc}      |   0
 .../RelNotes/{2.34.8.txt => 2.34.8.adoc}      |   0
 .../RelNotes/{2.35.0.txt => 2.35.0.adoc}      |   0
 .../RelNotes/{2.35.1.txt => 2.35.1.adoc}      |   0
 .../RelNotes/{2.35.2.txt => 2.35.2.adoc}      |   0
 .../RelNotes/{2.35.3.txt => 2.35.3.adoc}      |   0
 .../RelNotes/{2.35.4.txt => 2.35.4.adoc}      |   0
 .../RelNotes/{2.35.5.txt => 2.35.5.adoc}      |   0
 .../RelNotes/{2.35.6.txt => 2.35.6.adoc}      |   0
 .../RelNotes/{2.35.7.txt => 2.35.7.adoc}      |   0
 .../RelNotes/{2.35.8.txt => 2.35.8.adoc}      |   0
 .../RelNotes/{2.36.0.txt => 2.36.0.adoc}      |   0
 .../RelNotes/{2.36.1.txt => 2.36.1.adoc}      |   0
 .../RelNotes/{2.36.2.txt => 2.36.2.adoc}      |   0
 .../RelNotes/{2.36.3.txt => 2.36.3.adoc}      |   0
 .../RelNotes/{2.36.4.txt => 2.36.4.adoc}      |   0
 .../RelNotes/{2.36.5.txt => 2.36.5.adoc}      |   0
 .../RelNotes/{2.36.6.txt => 2.36.6.adoc}      |   0
 .../RelNotes/{2.37.0.txt => 2.37.0.adoc}      |   0
 .../RelNotes/{2.37.1.txt => 2.37.1.adoc}      |   0
 .../RelNotes/{2.37.2.txt => 2.37.2.adoc}      |   0
 .../RelNotes/{2.37.3.txt => 2.37.3.adoc}      |   0
 .../RelNotes/{2.37.4.txt => 2.37.4.adoc}      |   0
 .../RelNotes/{2.37.5.txt => 2.37.5.adoc}      |   0
 .../RelNotes/{2.37.6.txt => 2.37.6.adoc}      |   0
 .../RelNotes/{2.37.7.txt => 2.37.7.adoc}      |   0
 .../RelNotes/{2.38.0.txt => 2.38.0.adoc}      |   0
 .../RelNotes/{2.38.1.txt => 2.38.1.adoc}      |   0
 .../RelNotes/{2.38.2.txt => 2.38.2.adoc}      |   0
 .../RelNotes/{2.38.3.txt => 2.38.3.adoc}      |   0
 .../RelNotes/{2.38.4.txt => 2.38.4.adoc}      |   0
 .../RelNotes/{2.38.5.txt => 2.38.5.adoc}      |   0
 .../RelNotes/{2.39.0.txt => 2.39.0.adoc}      |   0
 .../RelNotes/{2.39.1.txt => 2.39.1.adoc}      |   0
 .../RelNotes/{2.39.2.txt => 2.39.2.adoc}      |   0
 .../RelNotes/{2.39.3.txt => 2.39.3.adoc}      |   0
 .../RelNotes/{2.39.4.txt => 2.39.4.adoc}      |   0
 .../RelNotes/{2.39.5.txt => 2.39.5.adoc}      |   0
 .../RelNotes/{2.4.0.txt => 2.4.0.adoc}        |   0
 .../RelNotes/{2.4.1.txt => 2.4.1.adoc}        |   0
 .../RelNotes/{2.4.10.txt => 2.4.10.adoc}      |   0
 .../RelNotes/{2.4.11.txt => 2.4.11.adoc}      |   0
 .../RelNotes/{2.4.12.txt => 2.4.12.adoc}      |   0
 .../RelNotes/{2.4.2.txt => 2.4.2.adoc}        |   0
 .../RelNotes/{2.4.3.txt => 2.4.3.adoc}        |   0
 .../RelNotes/{2.4.4.txt => 2.4.4.adoc}        |   0
 .../RelNotes/{2.4.5.txt => 2.4.5.adoc}        |   0
 .../RelNotes/{2.4.6.txt => 2.4.6.adoc}        |   0
 .../RelNotes/{2.4.7.txt => 2.4.7.adoc}        |   0
 .../RelNotes/{2.4.8.txt => 2.4.8.adoc}        |   0
 .../RelNotes/{2.4.9.txt => 2.4.9.adoc}        |   0
 .../RelNotes/{2.40.0.txt => 2.40.0.adoc}      |   0
 .../RelNotes/{2.40.1.txt => 2.40.1.adoc}      |   0
 .../RelNotes/{2.40.2.txt => 2.40.2.adoc}      |   0
 .../RelNotes/{2.40.3.txt => 2.40.3.adoc}      |   0
 .../RelNotes/{2.40.4.txt => 2.40.4.adoc}      |   0
 .../RelNotes/{2.41.0.txt => 2.41.0.adoc}      |   0
 .../RelNotes/{2.41.1.txt => 2.41.1.adoc}      |   0
 .../RelNotes/{2.41.2.txt => 2.41.2.adoc}      |   0
 .../RelNotes/{2.41.3.txt => 2.41.3.adoc}      |   0
 .../RelNotes/{2.42.0.txt => 2.42.0.adoc}      |   0
 .../RelNotes/{2.42.1.txt => 2.42.1.adoc}      |   0
 .../RelNotes/{2.42.2.txt => 2.42.2.adoc}      |   0
 .../RelNotes/{2.42.3.txt => 2.42.3.adoc}      |   0
 .../RelNotes/{2.42.4.txt => 2.42.4.adoc}      |   0
 .../RelNotes/{2.43.0.txt => 2.43.0.adoc}      |   0
 .../RelNotes/{2.43.1.txt => 2.43.1.adoc}      |   0
 .../RelNotes/{2.43.2.txt => 2.43.2.adoc}      |   0
 .../RelNotes/{2.43.3.txt => 2.43.3.adoc}      |   0
 .../RelNotes/{2.43.4.txt => 2.43.4.adoc}      |   0
 .../RelNotes/{2.43.5.txt => 2.43.5.adoc}      |   0
 .../RelNotes/{2.43.6.txt => 2.43.6.adoc}      |   0
 .../RelNotes/{2.44.0.txt => 2.44.0.adoc}      |   0
 .../RelNotes/{2.44.1.txt => 2.44.1.adoc}      |   0
 .../RelNotes/{2.44.2.txt => 2.44.2.adoc}      |   0
 .../RelNotes/{2.44.3.txt => 2.44.3.adoc}      |   0
 .../RelNotes/{2.45.0.txt => 2.45.0.adoc}      |   0
 .../RelNotes/{2.45.1.txt => 2.45.1.adoc}      |   0
 .../RelNotes/{2.45.2.txt => 2.45.2.adoc}      |   0
 .../RelNotes/{2.45.3.txt => 2.45.3.adoc}      |   0
 .../RelNotes/{2.46.0.txt => 2.46.0.adoc}      |   0
 .../RelNotes/{2.46.1.txt => 2.46.1.adoc}      |   0
 .../RelNotes/{2.46.2.txt => 2.46.2.adoc}      |   0
 .../RelNotes/{2.46.3.txt => 2.46.3.adoc}      |   0
 .../RelNotes/{2.47.0.txt => 2.47.0.adoc}      |   0
 .../RelNotes/{2.47.1.txt => 2.47.1.adoc}      |   0
 .../RelNotes/{2.47.2.txt => 2.47.2.adoc}      |   0
 .../RelNotes/{2.48.0.txt => 2.48.0.adoc}      |   0
 .../RelNotes/{2.48.1.txt => 2.48.1.adoc}      |   0
 .../RelNotes/{2.49.0.txt => 2.49.0.adoc}      |   0
 .../RelNotes/{2.5.0.txt => 2.5.0.adoc}        |   0
 .../RelNotes/{2.5.1.txt => 2.5.1.adoc}        |   0
 .../RelNotes/{2.5.2.txt => 2.5.2.adoc}        |   0
 .../RelNotes/{2.5.3.txt => 2.5.3.adoc}        |   0
 .../RelNotes/{2.5.4.txt => 2.5.4.adoc}        |   0
 .../RelNotes/{2.5.5.txt => 2.5.5.adoc}        |   0
 .../RelNotes/{2.5.6.txt => 2.5.6.adoc}        |   0
 .../RelNotes/{2.6.0.txt => 2.6.0.adoc}        |   0
 .../RelNotes/{2.6.1.txt => 2.6.1.adoc}        |   0
 .../RelNotes/{2.6.2.txt => 2.6.2.adoc}        |   0
 .../RelNotes/{2.6.3.txt => 2.6.3.adoc}        |   0
 .../RelNotes/{2.6.4.txt => 2.6.4.adoc}        |   0
 .../RelNotes/{2.6.5.txt => 2.6.5.adoc}        |   0
 .../RelNotes/{2.6.6.txt => 2.6.6.adoc}        |   0
 .../RelNotes/{2.6.7.txt => 2.6.7.adoc}        |   0
 .../RelNotes/{2.7.0.txt => 2.7.0.adoc}        |   0
 .../RelNotes/{2.7.1.txt => 2.7.1.adoc}        |   0
 .../RelNotes/{2.7.2.txt => 2.7.2.adoc}        |   0
 .../RelNotes/{2.7.3.txt => 2.7.3.adoc}        |   0
 .../RelNotes/{2.7.4.txt => 2.7.4.adoc}        |   0
 .../RelNotes/{2.7.5.txt => 2.7.5.adoc}        |   0
 .../RelNotes/{2.7.6.txt => 2.7.6.adoc}        |   0
 .../RelNotes/{2.8.0.txt => 2.8.0.adoc}        |   0
 .../RelNotes/{2.8.1.txt => 2.8.1.adoc}        |   0
 .../RelNotes/{2.8.2.txt => 2.8.2.adoc}        |   0
 .../RelNotes/{2.8.3.txt => 2.8.3.adoc}        |   0
 .../RelNotes/{2.8.4.txt => 2.8.4.adoc}        |   0
 .../RelNotes/{2.8.5.txt => 2.8.5.adoc}        |   0
 .../RelNotes/{2.8.6.txt => 2.8.6.adoc}        |   0
 .../RelNotes/{2.9.0.txt => 2.9.0.adoc}        |   0
 .../RelNotes/{2.9.1.txt => 2.9.1.adoc}        |   0
 .../RelNotes/{2.9.2.txt => 2.9.2.adoc}        |   0
 .../RelNotes/{2.9.3.txt => 2.9.3.adoc}        |   0
 .../RelNotes/{2.9.4.txt => 2.9.4.adoc}        |   0
 .../RelNotes/{2.9.5.txt => 2.9.5.adoc}        |   0
 ...uidelines.txt => ReviewingGuidelines.adoc} |   0
 .../{ToolsForGit.txt => ToolsForGit.adoc}     |   0
 .../{blame-options.txt => blame-options.adoc} |   2 +-
 Documentation/cmd-list.perl                   |   8 +-
 Documentation/{config.txt => config.adoc}     | 184 ++++----
 Documentation/config/{add.txt => add.adoc}    |   0
 .../config/{advice.txt => advice.adoc}        |   0
 .../config/{alias.txt => alias.adoc}          |   0
 Documentation/config/{am.txt => am.adoc}      |   0
 .../config/{apply.txt => apply.adoc}          |   0
 Documentation/config/{attr.txt => attr.adoc}  |   0
 ...udo-merge.txt => bitmap-pseudo-merge.adoc} |   0
 .../config/{blame.txt => blame.adoc}          |   0
 .../config/{branch.txt => branch.adoc}        |   0
 .../config/{browser.txt => browser.adoc}      |   0
 .../config/{bundle.txt => bundle.adoc}        |   0
 .../config/{checkout.txt => checkout.adoc}    |   0
 .../config/{clean.txt => clean.adoc}          |   0
 .../config/{clone.txt => clone.adoc}          |   0
 .../config/{color.txt => color.adoc}          |   0
 .../config/{column.txt => column.adoc}        |   0
 .../config/{commit.txt => commit.adoc}        |   0
 .../{commitgraph.txt => commitgraph.adoc}     |   0
 .../{completion.txt => completion.adoc}       |   0
 Documentation/config/{core.txt => core.adoc}  |   0
 .../{credential.txt => credential.adoc}       |   0
 Documentation/config/{diff.txt => diff.adoc}  |   2 +-
 .../config/{difftool.txt => difftool.adoc}    |   0
 .../{extensions.txt => extensions.adoc}       |   2 +-
 .../{fastimport.txt => fastimport.adoc}       |   0
 .../config/{feature.txt => feature.adoc}      |   0
 .../config/{fetch.txt => fetch.adoc}          |   0
 .../config/{filter.txt => filter.adoc}        |   0
 .../{fmt-merge-msg.txt => fmt-merge-msg.adoc} |   0
 .../config/{format.txt => format.adoc}        |   0
 Documentation/config/{fsck.txt => fsck.adoc}  |   0
 ...tor--daemon.txt => fsmonitor--daemon.adoc} |   0
 Documentation/config/{gc.txt => gc.adoc}      |   0
 .../config/{gitcvs.txt => gitcvs.adoc}        |   0
 .../config/{gitweb.txt => gitweb.adoc}        |   0
 Documentation/config/{gpg.txt => gpg.adoc}    |   0
 Documentation/config/{grep.txt => grep.adoc}  |   0
 Documentation/config/{gui.txt => gui.adoc}    |   0
 .../config/{guitool.txt => guitool.adoc}      |   0
 Documentation/config/{help.txt => help.adoc}  |   0
 Documentation/config/{http.txt => http.adoc}  |   0
 Documentation/config/{i18n.txt => i18n.adoc}  |   0
 Documentation/config/{imap.txt => imap.adoc}  |   0
 .../config/{includeif.txt => includeif.adoc}  |   0
 .../config/{index.txt => index.adoc}          |   0
 Documentation/config/{init.txt => init.adoc}  |   0
 .../config/{instaweb.txt => instaweb.adoc}    |   0
 .../{interactive.txt => interactive.adoc}     |   0
 Documentation/config/{log.txt => log.adoc}    |   0
 .../config/{lsrefs.txt => lsrefs.adoc}        |   0
 .../config/{mailinfo.txt => mailinfo.adoc}    |   0
 .../config/{mailmap.txt => mailmap.adoc}      |   0
 .../{maintenance.txt => maintenance.adoc}     |   0
 Documentation/config/{man.txt => man.adoc}    |   0
 .../config/{merge.txt => merge.adoc}          |   4 +-
 .../config/{mergetool.txt => mergetool.adoc}  |   0
 .../config/{notes.txt => notes.adoc}          |   0
 Documentation/config/{pack.txt => pack.adoc}  |   0
 .../config/{pager.txt => pager.adoc}          |   0
 .../config/{pretty.txt => pretty.adoc}        |   0
 .../config/{promisor.txt => promisor.adoc}    |   0
 .../config/{protocol.txt => protocol.adoc}    |   0
 Documentation/config/{pull.txt => pull.adoc}  |   0
 Documentation/config/{push.txt => push.adoc}  |   0
 .../config/{rebase.txt => rebase.adoc}        |   0
 .../config/{receive.txt => receive.adoc}      |   0
 .../config/{reftable.txt => reftable.adoc}    |   0
 .../config/{remote.txt => remote.adoc}        |   0
 .../config/{remotes.txt => remotes.adoc}      |   0
 .../config/{repack.txt => repack.adoc}        |   0
 .../config/{rerere.txt => rerere.adoc}        |   0
 .../config/{revert.txt => revert.adoc}        |   0
 Documentation/config/{safe.txt => safe.adoc}  |   0
 .../config/{sendemail.txt => sendemail.adoc}  |   0
 .../config/{sequencer.txt => sequencer.adoc}  |   0
 .../{showbranch.txt => showbranch.adoc}       |   0
 .../config/{sparse.txt => sparse.adoc}        |   0
 .../{splitindex.txt => splitindex.adoc}       |   0
 Documentation/config/{ssh.txt => ssh.adoc}    |   0
 .../config/{stash.txt => stash.adoc}          |   0
 .../config/{status.txt => status.adoc}        |   0
 .../config/{submodule.txt => submodule.adoc}  |   0
 Documentation/config/{tag.txt => tag.adoc}    |   0
 Documentation/config/{tar.txt => tar.adoc}    |   0
 .../config/{trace2.txt => trace2.adoc}        |   2 +-
 .../config/{transfer.txt => transfer.adoc}    |   0
 .../{uploadarchive.txt => uploadarchive.adoc} |   0
 .../{uploadpack.txt => uploadpack.adoc}       |   0
 Documentation/config/{url.txt => url.adoc}    |   0
 Documentation/config/{user.txt => user.adoc}  |   0
 .../{versionsort.txt => versionsort.adoc}     |   0
 Documentation/config/{web.txt => web.adoc}    |   0
 .../config/{worktree.txt => worktree.adoc}    |   0
 .../{date-formats.txt => date-formats.adoc}   |   0
 .../{diff-format.txt => diff-format.adoc}     |   2 +-
 ...ate-patch.txt => diff-generate-patch.adoc} |   0
 .../{diff-options.txt => diff-options.adoc}   |   0
 .../{everyday.txto => everyday.adoco}         |   0
 .../{fetch-options.txt => fetch-options.adoc} |   0
 .../{fsck-msgids.txt => fsck-msgids.adoc}     |   0
 Documentation/{git-add.txt => git-add.adoc}   |   4 +-
 Documentation/{git-am.txt => git-am.adoc}     |   6 +-
 .../{git-annotate.txt => git-annotate.adoc}   |   2 +-
 .../{git-apply.txt => git-apply.adoc}         |   4 +-
 ...git-archimport.txt => git-archimport.adoc} |   0
 .../{git-archive.txt => git-archive.adoc}     |   0
 ...sect-lk2009.txt => git-bisect-lk2009.adoc} |   0
 .../{git-bisect.txt => git-bisect.adoc}       |   0
 .../{git-blame.txt => git-blame.adoc}         |   6 +-
 .../{git-branch.txt => git-branch.adoc}       |   6 +-
 .../{git-bugreport.txt => git-bugreport.adoc} |   0
 .../{git-bundle.txt => git-bundle.adoc}       |   0
 .../{git-cat-file.txt => git-cat-file.adoc}   |   0
 ...git-check-attr.txt => git-check-attr.adoc} |   0
 ...check-ignore.txt => git-check-ignore.adoc} |   0
 ...eck-mailmap.txt => git-check-mailmap.adoc} |   0
 ...f-format.txt => git-check-ref-format.adoc} |   0
 ...kout-index.txt => git-checkout-index.adoc} |   0
 .../{git-checkout.txt => git-checkout.adoc}   |   4 +-
 ...t-cherry-pick.txt => git-cherry-pick.adoc} |   4 +-
 .../{git-cherry.txt => git-cherry.adoc}       |   0
 .../{git-citool.txt => git-citool.adoc}       |   0
 .../{git-clean.txt => git-clean.adoc}         |   4 +-
 .../{git-clone.txt => git-clone.adoc}         |  10 +-
 .../{git-column.txt => git-column.adoc}       |   4 +-
 ...commit-graph.txt => git-commit-graph.adoc} |   4 +-
 ...t-commit-tree.txt => git-commit-tree.adoc} |   4 +-
 .../{git-commit.txt => git-commit.adoc}       |  10 +-
 .../{git-config.txt => git-config.adoc}       |   2 +-
 ...unt-objects.txt => git-count-objects.adoc} |   0
 ....txt => git-credential-cache--daemon.adoc} |   0
 ...al-cache.txt => git-credential-cache.adoc} |   0
 ...al-store.txt => git-credential-store.adoc} |   0
 ...git-credential.txt => git-credential.adoc} |   0
 ...ortcommit.txt => git-cvsexportcommit.adoc} |   0
 .../{git-cvsimport.txt => git-cvsimport.adoc} |   0
 .../{git-cvsserver.txt => git-cvsserver.adoc} |   0
 .../{git-daemon.txt => git-daemon.adoc}       |   0
 .../{git-describe.txt => git-describe.adoc}   |   0
 .../{git-diagnose.txt => git-diagnose.adoc}   |   0
 ...git-diff-files.txt => git-diff-files.adoc} |   4 +-
 ...git-diff-index.txt => git-diff-index.adoc} |   4 +-
 .../{git-diff-tree.txt => git-diff-tree.adoc} |   8 +-
 Documentation/{git-diff.txt => git-diff.adoc} |   8 +-
 .../{git-difftool.txt => git-difftool.adoc}   |   4 +-
 ...t-fast-export.txt => git-fast-export.adoc} |   0
 ...t-fast-import.txt => git-fast-import.adoc} |   4 +-
 ...git-fetch-pack.txt => git-fetch-pack.adoc} |   0
 .../{git-fetch.txt => git-fetch.adoc}         |  12 +-
 ...lter-branch.txt => git-filter-branch.adoc} |   0
 ...t-merge-msg.txt => git-fmt-merge-msg.adoc} |   2 +-
 ...for-each-ref.txt => git-for-each-ref.adoc} |   2 +-
 ...r-each-repo.txt => git-for-each-repo.adoc} |   0
 ...format-patch.txt => git-format-patch.adoc} |   2 +-
 ...fsck-objects.txt => git-fsck-objects.adoc} |   0
 Documentation/{git-fsck.txt => git-fsck.adoc} |   6 +-
 ...-daemon.txt => git-fsmonitor--daemon.adoc} |   4 +-
 Documentation/{git-gc.txt => git-gc.adoc}     |   4 +-
 ...mmit-id.txt => git-get-tar-commit-id.adoc} |   0
 Documentation/{git-grep.txt => git-grep.adoc} |   4 +-
 Documentation/{git-gui.txt => git-gui.adoc}   |   0
 ...t-hash-object.txt => git-hash-object.adoc} |   0
 Documentation/{git-help.txt => git-help.adoc} |   0
 Documentation/{git-hook.txt => git-hook.adoc} |   0
 ...http-backend.txt => git-http-backend.adoc} |   0
 ...git-http-fetch.txt => git-http-fetch.adoc} |   0
 .../{git-http-push.txt => git-http-push.adoc} |   0
 .../{git-imap-send.txt => git-imap-send.adoc} |   4 +-
 ...git-index-pack.txt => git-index-pack.adoc} |   2 +-
 .../{git-init-db.txt => git-init-db.adoc}     |   0
 Documentation/{git-init.txt => git-init.adoc} |   8 +-
 .../{git-instaweb.txt => git-instaweb.adoc}   |   0
 ...ailers.txt => git-interpret-trailers.adoc} |   0
 Documentation/{git-log.txt => git-log.adoc}   |  20 +-
 .../{git-ls-files.txt => git-ls-files.adoc}   |   0
 .../{git-ls-remote.txt => git-ls-remote.adoc} |   0
 .../{git-ls-tree.txt => git-ls-tree.adoc}     |   0
 .../{git-mailinfo.txt => git-mailinfo.adoc}   |   4 +-
 .../{git-mailsplit.txt => git-mailsplit.adoc} |   0
 ...t-maintenance.txt => git-maintenance.adoc} |   4 +-
 ...git-merge-base.txt => git-merge-base.adoc} |   0
 ...git-merge-file.txt => git-merge-file.adoc} |   0
 ...t-merge-index.txt => git-merge-index.adoc} |   0
 ...e-one-file.txt => git-merge-one-file.adoc} |   0
 ...git-merge-tree.txt => git-merge-tree.adoc} |   0
 .../{git-merge.txt => git-merge.adoc}         |  10 +-
 ...etool--lib.txt => git-mergetool--lib.adoc} |   0
 .../{git-mergetool.txt => git-mergetool.adoc} |   6 +-
 .../{git-mktag.txt => git-mktag.adoc}         |   0
 .../{git-mktree.txt => git-mktree.adoc}       |   0
 ...ck-index.txt => git-multi-pack-index.adoc} |   0
 Documentation/{git-mv.txt => git-mv.adoc}     |   0
 .../{git-name-rev.txt => git-name-rev.adoc}   |   0
 .../{git-notes.txt => git-notes.adoc}         |   4 +-
 Documentation/{git-p4.txt => git-p4.adoc}     |   0
 ...pack-objects.txt => git-pack-objects.adoc} |   0
 ...-redundant.txt => git-pack-redundant.adoc} |   0
 .../{git-pack-refs.txt => git-pack-refs.adoc} |   0
 .../{git-patch-id.txt => git-patch-id.adoc}   |   0
 ...prune-packed.txt => git-prune-packed.adoc} |   0
 .../{git-prune.txt => git-prune.adoc}         |   0
 Documentation/{git-pull.txt => git-pull.adoc} |  12 +-
 Documentation/{git-push.txt => git-push.adoc} |   8 +-
 ...t-quiltimport.txt => git-quiltimport.adoc} |   0
 ...git-range-diff.txt => git-range-diff.adoc} |   0
 .../{git-read-tree.txt => git-read-tree.adoc} |   0
 .../{git-rebase.txt => git-rebase.adoc}       |  10 +-
 ...receive-pack.txt => git-receive-pack.adoc} |   0
 .../{git-reflog.txt => git-reflog.adoc}       |   0
 Documentation/{git-refs.txt => git-refs.adoc} |   2 +-
 ...git-remote-ext.txt => git-remote-ext.adoc} |   0
 .../{git-remote-fd.txt => git-remote-fd.adoc} |   0
 ...-helpers.txto => git-remote-helpers.adoco} |   0
 .../{git-remote.txt => git-remote.adoc}       |   0
 .../{git-repack.txt => git-repack.adoc}       |   0
 .../{git-replace.txt => git-replace.adoc}     |   0
 .../{git-replay.txt => git-replay.adoc}       |   2 +-
 ...request-pull.txt => git-request-pull.adoc} |   0
 .../{git-rerere.txt => git-rerere.adoc}       |   0
 .../{git-reset.txt => git-reset.adoc}         |   0
 .../{git-restore.txt => git-restore.adoc}     |   0
 .../{git-rev-list.txt => git-rev-list.adoc}   |   6 +-
 .../{git-rev-parse.txt => git-rev-parse.adoc} |   2 +-
 .../{git-revert.txt => git-revert.adoc}       |   8 +-
 Documentation/{git-rm.txt => git-rm.adoc}     |   0
 ...git-send-email.txt => git-send-email.adoc} |   4 +-
 .../{git-send-pack.txt => git-send-pack.adoc} |   0
 ...nvsubst.txt => git-sh-i18n--envsubst.adoc} |   0
 .../{git-sh-i18n.txt => git-sh-i18n.adoc}     |   0
 .../{git-sh-setup.txt => git-sh-setup.adoc}   |   0
 .../{git-shell.txt => git-shell.adoc}         |   0
 .../{git-shortlog.txt => git-shortlog.adoc}   |   2 +-
 ...t-show-branch.txt => git-show-branch.adoc} |   4 +-
 ...git-show-index.txt => git-show-index.adoc} |   2 +-
 .../{git-show-ref.txt => git-show-ref.adoc}   |   0
 Documentation/{git-show.txt => git-show.adoc} |  10 +-
 ...-checkout.txt => git-sparse-checkout.adoc} |   0
 .../{git-stage.txt => git-stage.adoc}         |   0
 .../{git-stash.txt => git-stash.adoc}         |   4 +-
 .../{git-status.txt => git-status.adoc}       |   0
 ...git-stripspace.txt => git-stripspace.adoc} |   0
 .../{git-submodule.txt => git-submodule.adoc} |   0
 Documentation/{git-svn.txt => git-svn.adoc}   |   0
 .../{git-switch.txt => git-switch.adoc}       |   4 +-
 ...symbolic-ref.txt => git-symbolic-ref.adoc} |   0
 Documentation/{git-tag.txt => git-tag.adoc}   |   4 +-
 .../{git-tools.txt => git-tools.adoc}         |   0
 ...t-unpack-file.txt => git-unpack-file.adoc} |   0
 ...ck-objects.txt => git-unpack-objects.adoc} |   0
 ...update-index.txt => git-update-index.adoc} |   0
 ...git-update-ref.txt => git-update-ref.adoc} |   0
 ...r-info.txt => git-update-server-info.adoc} |   0
 ...ad-archive.txt => git-upload-archive.adoc} |   0
 ...t-upload-pack.txt => git-upload-pack.adoc} |   0
 Documentation/{git-var.txt => git-var.adoc}   |   0
 ...rify-commit.txt => git-verify-commit.adoc} |   0
 ...t-verify-pack.txt => git-verify-pack.adoc} |   0
 ...git-verify-tag.txt => git-verify-tag.adoc} |   0
 .../{git-version.txt => git-version.adoc}     |   0
 ...t-web--browse.txt => git-web--browse.adoc} |   0
 ...t-whatchanged.txt => git-whatchanged.adoc} |   0
 .../{git-worktree.txt => git-worktree.adoc}   |   0
 ...git-write-tree.txt => git-write-tree.adoc} |   0
 Documentation/{git.txt => git.adoc}           |  24 +-
 .../{gitattributes.txt => gitattributes.adoc} |   0
 Documentation/{gitcli.txt => gitcli.adoc}     |   0
 ...ore-tutorial.txt => gitcore-tutorial.adoc} |   0
 ...gitcredentials.txt => gitcredentials.adoc} |   0
 ...vs-migration.txt => gitcvs-migration.adoc} |   0
 .../{gitdiffcore.txt => gitdiffcore.adoc}     |   0
 .../{giteveryday.txt => giteveryday.adoc}     |   0
 Documentation/{gitfaq.txt => gitfaq.adoc}     |   0
 ...ormat-bundle.txt => gitformat-bundle.adoc} |   0
 ...tformat-chunk.txt => gitformat-chunk.adoc} |   0
 ...-graph.txt => gitformat-commit-graph.adoc} |   0
 ...tformat-index.txt => gitformat-index.adoc} |   0
 ...gitformat-pack.txt => gitformat-pack.adoc} |   0
 ...signature.txt => gitformat-signature.adoc} |   0
 .../{gitglossary.txt => gitglossary.adoc}     |   2 +-
 Documentation/{githooks.txt => githooks.adoc} |   0
 .../{gitignore.txt => gitignore.adoc}         |   0
 Documentation/{gitk.txt => gitk.adoc}         |   2 +-
 .../{gitmailmap.txt => gitmailmap.adoc}       |   0
 .../{gitmodules.txt => gitmodules.adoc}       |   0
 .../{gitnamespaces.txt => gitnamespaces.adoc} |   2 +-
 .../{gitpacking.txt => gitpacking.adoc}       |   2 +-
 ...ties.txt => gitprotocol-capabilities.adoc} |   0
 ...col-common.txt => gitprotocol-common.adoc} |   0
 ...rotocol-http.txt => gitprotocol-http.adoc} |   0
 ...rotocol-pack.txt => gitprotocol-pack.adoc} |   0
 ...gitprotocol-v2.txt => gitprotocol-v2.adoc} |   0
 ...ote-helpers.txt => gitremote-helpers.adoc} |   0
 ...y-layout.txt => gitrepository-layout.adoc} |   2 +-
 .../{gitrevisions.txt => gitrevisions.adoc}   |   2 +-
 .../{gitsubmodules.txt => gitsubmodules.adoc} |   0
 .../{gittutorial-2.txt => gittutorial-2.adoc} |   0
 .../{gittutorial.txt => gittutorial.adoc}     |   0
 Documentation/{gitweb.txt => gitweb.adoc}     |   0
 .../{gitweb.conf.txt => gitweb.conf.adoc}     |   0
 .../{gitworkflows.txt => gitworkflows.adoc}   |   0
 ...sary-content.txt => glossary-content.adoc} |   0
 ...txt => coordinate-embargoed-releases.adoc} |   0
 ...xt => keep-canonical-history-correct.adoc} |   0
 .../{maintain-git.txt => maintain-git.adoc}   |   0
 .../{new-command.txt => new-command.adoc}     |   0
 ...h.txt => rebase-from-internal-branch.adoc} |   0
 ...hook.txt => rebuild-from-update-hook.adoc} |   0
 ...txt => recover-corrupted-blob-object.adoc} |   0
 ...t => recover-corrupted-object-harder.adoc} |   0
 ...y-merge.txt => revert-a-faulty-merge.adoc} |   0
 ...h-rebase.txt => revert-branch-rebase.adoc} |   0
 ...hes.txt => separating-topic-branches.adoc} |   0
 ...tp.txt => setup-git-server-over-http.adoc} |   0
 ...k-example.txt => update-hook-example.adoc} |   0
 ...use-git-daemon.txt => use-git-daemon.adoc} |   0
 ...e-subtree.txt => using-merge-subtree.adoc} |   0
 ... => using-signed-tag-in-pull-request.adoc} |   0
 Documentation/{i18n.txt => i18n.adoc}         |   0
 ...on-all.txt => cmd-config-section-all.adoc} |   0
 ...-rest.txt => cmd-config-section-rest.adoc} |   0
 Documentation/install-webdoc.sh               |  16 +-
 ...ange-format.txt => line-range-format.adoc} |   0
 ...ge-options.txt => line-range-options.adoc} |   2 +-
 Documentation/lint-gitlink.perl               |   4 +-
 Documentation/lint-manpages.sh                |   6 +-
 .../{merge-options.txt => merge-options.adoc} |   2 +-
 ...e-strategies.txt => merge-strategies.adoc} |   0
 .../mergetools/{vimdiff.txt => vimdiff.adoc}  |   0
 Documentation/meson.build                     | 442 +++++++++---------
 ...imer.txt => object-format-disclaimer.adoc} |   0
 ...pretty-formats.txt => pretty-formats.adoc} |   0
 ...pretty-options.txt => pretty-options.adoc} |   0
 ...-fetch-param.txt => pull-fetch-param.adoc} |   0
 ...ters.txt => ref-reachability-filters.adoc} |   0
 ...age-format.txt => ref-storage-format.adoc} |   0
 ...rerere-options.txt => rerere-options.adoc} |   0
 ...cription.txt => rev-list-description.adoc} |   0
 ...list-options.txt => rev-list-options.adoc} |   2 +-
 .../{revisions.txt => revisions.adoc}         |   0
 Documentation/{scalar.txt => scalar.adoc}     |   0
 .../{sequencer.txt => sequencer.adoc}         |   0
 ...signoff-option.txt => signoff-option.adoc} |   0
 ...r-handling.txt => api-error-handling.adoc} |   0
 ...api-index-skel.txt => api-index-skel.adoc} |   0
 Documentation/technical/api-index.sh          |   8 +-
 .../{api-merge.txt => api-merge.adoc}         |   0
 ...rse-options.txt => api-parse-options.adoc} |   0
 ...api-simple-ipc.txt => api-simple-ipc.adoc} |   0
 .../{api-trace2.txt => api-trace2.adoc}       |   2 +-
 .../{bitmap-format.txt => bitmap-format.adoc} |   0
 .../{build-systems.txt => build-systems.adoc} |   0
 .../{bundle-uri.txt => bundle-uri.adoc}       |   0
 .../{commit-graph.txt => commit-graph.adoc}   |   0
 ...on.txt => directory-rename-detection.adoc} |   0
 ...tion.txt => hash-function-transition.adoc} |   0
 ...txt => long-running-process-protocol.adoc} |   0
 ...i-pack-index.txt => multi-pack-index.adoc} |   0
 ...ck-heuristics.txt => pack-heuristics.adoc} |   0
 .../{packfile-uri.txt => packfile-uri.adoc}   |   0
 ...el-checkout.txt => parallel-checkout.adoc} |   0
 .../{partial-clone.txt => partial-clone.adoc} |   0
 ...form-support.txt => platform-support.adoc} |   0
 .../technical/{racy-git.txt => racy-git.adoc} |   0
 .../technical/{reftable.txt => reftable.adoc} |   0
 ...g-renames.txt => remembering-renames.adoc} |   0
 ...ry-version.txt => repository-version.adoc} |   0
 .../technical/{rerere.txt => rerere.adoc}     |   0
 .../technical/{scalar.txt => scalar.adoc}     |   0
 ...k-pipeline.txt => send-pack-pipeline.adoc} |   0
 .../technical/{shallow.txt => shallow.adoc}   |   0
 ...arse-checkout.txt => sparse-checkout.adoc} |   0
 .../{sparse-index.txt => sparse-index.adoc}   |   0
 .../{trivial-merge.txt => trivial-merge.adoc} |   0
 .../{unit-tests.txt => unit-tests.adoc}       |   0
 ...t-values.txt => trace2-target-values.adoc} |   0
 ...ata-leaks.txt => transfer-data-leaks.adoc} |   0
 .../{urls-remotes.txt => urls-remotes.adoc}   |   2 +-
 Documentation/{urls.txt => urls.adoc}         |   0
 .../{user-manual.txt => user-manual.adoc}     |   2 +-
 Makefile                                      |   6 +-
 RelNotes                                      |   2 +-
 generate-cmdlist.sh                           |   2 +-
 generate-configlist.sh                        |   2 +-
 generate-hooklist.sh                          |   2 +-
 meson.build                                   |   2 +-
 919 files changed, 614 insertions(+), 614 deletions(-)
 rename Documentation/{BreakingChanges.txt => BreakingChanges.adoc} (100%)
 rename Documentation/{DecisionMaking.txt => DecisionMaking.adoc} (100%)
 rename Documentation/{MyFirstContribution.txt => MyFirstContribution.adoc} (100%)
 rename Documentation/{MyFirstObjectWalk.txt => MyFirstObjectWalk.adoc} (100%)
 rename Documentation/RelNotes/{1.5.0.1.txt => 1.5.0.1.adoc} (100%)
 rename Documentation/RelNotes/{1.5.0.2.txt => 1.5.0.2.adoc} (100%)
 rename Documentation/RelNotes/{1.5.0.3.txt => 1.5.0.3.adoc} (100%)
 rename Documentation/RelNotes/{1.5.0.4.txt => 1.5.0.4.adoc} (100%)
 rename Documentation/RelNotes/{1.5.0.5.txt => 1.5.0.5.adoc} (100%)
 rename Documentation/RelNotes/{1.5.0.6.txt => 1.5.0.6.adoc} (100%)
 rename Documentation/RelNotes/{1.5.0.7.txt => 1.5.0.7.adoc} (100%)
 rename Documentation/RelNotes/{1.5.0.txt => 1.5.0.adoc} (100%)
 rename Documentation/RelNotes/{1.5.1.1.txt => 1.5.1.1.adoc} (100%)
 rename Documentation/RelNotes/{1.5.1.2.txt => 1.5.1.2.adoc} (100%)
 rename Documentation/RelNotes/{1.5.1.3.txt => 1.5.1.3.adoc} (100%)
 rename Documentation/RelNotes/{1.5.1.4.txt => 1.5.1.4.adoc} (100%)
 rename Documentation/RelNotes/{1.5.1.5.txt => 1.5.1.5.adoc} (100%)
 rename Documentation/RelNotes/{1.5.1.6.txt => 1.5.1.6.adoc} (100%)
 rename Documentation/RelNotes/{1.5.1.txt => 1.5.1.adoc} (100%)
 rename Documentation/RelNotes/{1.5.2.1.txt => 1.5.2.1.adoc} (100%)
 rename Documentation/RelNotes/{1.5.2.2.txt => 1.5.2.2.adoc} (100%)
 rename Documentation/RelNotes/{1.5.2.3.txt => 1.5.2.3.adoc} (100%)
 rename Documentation/RelNotes/{1.5.2.4.txt => 1.5.2.4.adoc} (100%)
 rename Documentation/RelNotes/{1.5.2.5.txt => 1.5.2.5.adoc} (100%)
 rename Documentation/RelNotes/{1.5.2.txt => 1.5.2.adoc} (100%)
 rename Documentation/RelNotes/{1.5.3.1.txt => 1.5.3.1.adoc} (100%)
 rename Documentation/RelNotes/{1.5.3.2.txt => 1.5.3.2.adoc} (100%)
 rename Documentation/RelNotes/{1.5.3.3.txt => 1.5.3.3.adoc} (100%)
 rename Documentation/RelNotes/{1.5.3.4.txt => 1.5.3.4.adoc} (100%)
 rename Documentation/RelNotes/{1.5.3.5.txt => 1.5.3.5.adoc} (100%)
 rename Documentation/RelNotes/{1.5.3.6.txt => 1.5.3.6.adoc} (100%)
 rename Documentation/RelNotes/{1.5.3.7.txt => 1.5.3.7.adoc} (100%)
 rename Documentation/RelNotes/{1.5.3.8.txt => 1.5.3.8.adoc} (100%)
 rename Documentation/RelNotes/{1.5.3.txt => 1.5.3.adoc} (100%)
 rename Documentation/RelNotes/{1.5.4.1.txt => 1.5.4.1.adoc} (100%)
 rename Documentation/RelNotes/{1.5.4.2.txt => 1.5.4.2.adoc} (100%)
 rename Documentation/RelNotes/{1.5.4.3.txt => 1.5.4.3.adoc} (100%)
 rename Documentation/RelNotes/{1.5.4.4.txt => 1.5.4.4.adoc} (100%)
 rename Documentation/RelNotes/{1.5.4.5.txt => 1.5.4.5.adoc} (100%)
 rename Documentation/RelNotes/{1.5.4.6.txt => 1.5.4.6.adoc} (100%)
 rename Documentation/RelNotes/{1.5.4.7.txt => 1.5.4.7.adoc} (100%)
 rename Documentation/RelNotes/{1.5.4.txt => 1.5.4.adoc} (100%)
 rename Documentation/RelNotes/{1.5.5.1.txt => 1.5.5.1.adoc} (100%)
 rename Documentation/RelNotes/{1.5.5.2.txt => 1.5.5.2.adoc} (100%)
 rename Documentation/RelNotes/{1.5.5.3.txt => 1.5.5.3.adoc} (100%)
 rename Documentation/RelNotes/{1.5.5.4.txt => 1.5.5.4.adoc} (100%)
 rename Documentation/RelNotes/{1.5.5.5.txt => 1.5.5.5.adoc} (100%)
 rename Documentation/RelNotes/{1.5.5.6.txt => 1.5.5.6.adoc} (100%)
 rename Documentation/RelNotes/{1.5.5.txt => 1.5.5.adoc} (100%)
 rename Documentation/RelNotes/{1.5.6.1.txt => 1.5.6.1.adoc} (100%)
 rename Documentation/RelNotes/{1.5.6.2.txt => 1.5.6.2.adoc} (100%)
 rename Documentation/RelNotes/{1.5.6.3.txt => 1.5.6.3.adoc} (100%)
 rename Documentation/RelNotes/{1.5.6.4.txt => 1.5.6.4.adoc} (100%)
 rename Documentation/RelNotes/{1.5.6.5.txt => 1.5.6.5.adoc} (100%)
 rename Documentation/RelNotes/{1.5.6.6.txt => 1.5.6.6.adoc} (100%)
 rename Documentation/RelNotes/{1.5.6.txt => 1.5.6.adoc} (100%)
 rename Documentation/RelNotes/{1.6.0.1.txt => 1.6.0.1.adoc} (100%)
 rename Documentation/RelNotes/{1.6.0.2.txt => 1.6.0.2.adoc} (100%)
 rename Documentation/RelNotes/{1.6.0.3.txt => 1.6.0.3.adoc} (100%)
 rename Documentation/RelNotes/{1.6.0.4.txt => 1.6.0.4.adoc} (100%)
 rename Documentation/RelNotes/{1.6.0.5.txt => 1.6.0.5.adoc} (100%)
 rename Documentation/RelNotes/{1.6.0.6.txt => 1.6.0.6.adoc} (100%)
 rename Documentation/RelNotes/{1.6.0.txt => 1.6.0.adoc} (100%)
 rename Documentation/RelNotes/{1.6.1.1.txt => 1.6.1.1.adoc} (100%)
 rename Documentation/RelNotes/{1.6.1.2.txt => 1.6.1.2.adoc} (100%)
 rename Documentation/RelNotes/{1.6.1.3.txt => 1.6.1.3.adoc} (100%)
 rename Documentation/RelNotes/{1.6.1.4.txt => 1.6.1.4.adoc} (100%)
 rename Documentation/RelNotes/{1.6.1.txt => 1.6.1.adoc} (100%)
 rename Documentation/RelNotes/{1.6.2.1.txt => 1.6.2.1.adoc} (100%)
 rename Documentation/RelNotes/{1.6.2.2.txt => 1.6.2.2.adoc} (100%)
 rename Documentation/RelNotes/{1.6.2.3.txt => 1.6.2.3.adoc} (100%)
 rename Documentation/RelNotes/{1.6.2.4.txt => 1.6.2.4.adoc} (100%)
 rename Documentation/RelNotes/{1.6.2.5.txt => 1.6.2.5.adoc} (100%)
 rename Documentation/RelNotes/{1.6.2.txt => 1.6.2.adoc} (100%)
 rename Documentation/RelNotes/{1.6.3.1.txt => 1.6.3.1.adoc} (100%)
 rename Documentation/RelNotes/{1.6.3.2.txt => 1.6.3.2.adoc} (100%)
 rename Documentation/RelNotes/{1.6.3.3.txt => 1.6.3.3.adoc} (100%)
 rename Documentation/RelNotes/{1.6.3.4.txt => 1.6.3.4.adoc} (100%)
 rename Documentation/RelNotes/{1.6.3.txt => 1.6.3.adoc} (100%)
 rename Documentation/RelNotes/{1.6.4.1.txt => 1.6.4.1.adoc} (100%)
 rename Documentation/RelNotes/{1.6.4.2.txt => 1.6.4.2.adoc} (100%)
 rename Documentation/RelNotes/{1.6.4.3.txt => 1.6.4.3.adoc} (100%)
 rename Documentation/RelNotes/{1.6.4.4.txt => 1.6.4.4.adoc} (100%)
 rename Documentation/RelNotes/{1.6.4.5.txt => 1.6.4.5.adoc} (100%)
 rename Documentation/RelNotes/{1.6.4.txt => 1.6.4.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.1.txt => 1.6.5.1.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.2.txt => 1.6.5.2.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.3.txt => 1.6.5.3.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.4.txt => 1.6.5.4.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.5.txt => 1.6.5.5.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.6.txt => 1.6.5.6.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.7.txt => 1.6.5.7.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.8.txt => 1.6.5.8.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.9.txt => 1.6.5.9.adoc} (100%)
 rename Documentation/RelNotes/{1.6.5.txt => 1.6.5.adoc} (100%)
 rename Documentation/RelNotes/{1.6.6.1.txt => 1.6.6.1.adoc} (100%)
 rename Documentation/RelNotes/{1.6.6.2.txt => 1.6.6.2.adoc} (100%)
 rename Documentation/RelNotes/{1.6.6.3.txt => 1.6.6.3.adoc} (100%)
 rename Documentation/RelNotes/{1.6.6.txt => 1.6.6.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.1.txt => 1.7.0.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.2.txt => 1.7.0.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.3.txt => 1.7.0.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.4.txt => 1.7.0.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.5.txt => 1.7.0.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.6.txt => 1.7.0.6.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.7.txt => 1.7.0.7.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.8.txt => 1.7.0.8.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.9.txt => 1.7.0.9.adoc} (100%)
 rename Documentation/RelNotes/{1.7.0.txt => 1.7.0.adoc} (100%)
 rename Documentation/RelNotes/{1.7.1.1.txt => 1.7.1.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.1.2.txt => 1.7.1.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.1.3.txt => 1.7.1.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.1.4.txt => 1.7.1.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.1.txt => 1.7.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.10.1.txt => 1.7.10.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.10.2.txt => 1.7.10.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.10.3.txt => 1.7.10.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.10.4.txt => 1.7.10.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.10.5.txt => 1.7.10.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.10.txt => 1.7.10.adoc} (100%)
 rename Documentation/RelNotes/{1.7.11.1.txt => 1.7.11.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.11.2.txt => 1.7.11.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.11.3.txt => 1.7.11.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.11.4.txt => 1.7.11.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.11.5.txt => 1.7.11.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.11.6.txt => 1.7.11.6.adoc} (100%)
 rename Documentation/RelNotes/{1.7.11.7.txt => 1.7.11.7.adoc} (100%)
 rename Documentation/RelNotes/{1.7.11.txt => 1.7.11.adoc} (100%)
 rename Documentation/RelNotes/{1.7.12.1.txt => 1.7.12.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.12.2.txt => 1.7.12.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.12.3.txt => 1.7.12.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.12.4.txt => 1.7.12.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.12.txt => 1.7.12.adoc} (100%)
 rename Documentation/RelNotes/{1.7.2.1.txt => 1.7.2.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.2.2.txt => 1.7.2.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.2.3.txt => 1.7.2.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.2.4.txt => 1.7.2.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.2.5.txt => 1.7.2.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.2.txt => 1.7.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.3.1.txt => 1.7.3.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.3.2.txt => 1.7.3.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.3.3.txt => 1.7.3.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.3.4.txt => 1.7.3.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.3.5.txt => 1.7.3.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.3.txt => 1.7.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.4.1.txt => 1.7.4.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.4.2.txt => 1.7.4.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.4.3.txt => 1.7.4.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.4.4.txt => 1.7.4.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.4.5.txt => 1.7.4.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.4.txt => 1.7.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.5.1.txt => 1.7.5.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.5.2.txt => 1.7.5.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.5.3.txt => 1.7.5.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.5.4.txt => 1.7.5.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.5.txt => 1.7.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.6.1.txt => 1.7.6.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.6.2.txt => 1.7.6.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.6.3.txt => 1.7.6.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.6.4.txt => 1.7.6.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.6.5.txt => 1.7.6.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.6.6.txt => 1.7.6.6.adoc} (100%)
 rename Documentation/RelNotes/{1.7.6.txt => 1.7.6.adoc} (100%)
 rename Documentation/RelNotes/{1.7.7.1.txt => 1.7.7.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.7.2.txt => 1.7.7.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.7.3.txt => 1.7.7.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.7.4.txt => 1.7.7.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.7.5.txt => 1.7.7.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.7.6.txt => 1.7.7.6.adoc} (100%)
 rename Documentation/RelNotes/{1.7.7.7.txt => 1.7.7.7.adoc} (100%)
 rename Documentation/RelNotes/{1.7.7.txt => 1.7.7.adoc} (100%)
 rename Documentation/RelNotes/{1.7.8.1.txt => 1.7.8.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.8.2.txt => 1.7.8.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.8.3.txt => 1.7.8.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.8.4.txt => 1.7.8.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.8.5.txt => 1.7.8.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.8.6.txt => 1.7.8.6.adoc} (100%)
 rename Documentation/RelNotes/{1.7.8.txt => 1.7.8.adoc} (100%)
 rename Documentation/RelNotes/{1.7.9.1.txt => 1.7.9.1.adoc} (100%)
 rename Documentation/RelNotes/{1.7.9.2.txt => 1.7.9.2.adoc} (100%)
 rename Documentation/RelNotes/{1.7.9.3.txt => 1.7.9.3.adoc} (100%)
 rename Documentation/RelNotes/{1.7.9.4.txt => 1.7.9.4.adoc} (100%)
 rename Documentation/RelNotes/{1.7.9.5.txt => 1.7.9.5.adoc} (100%)
 rename Documentation/RelNotes/{1.7.9.6.txt => 1.7.9.6.adoc} (100%)
 rename Documentation/RelNotes/{1.7.9.7.txt => 1.7.9.7.adoc} (100%)
 rename Documentation/RelNotes/{1.7.9.txt => 1.7.9.adoc} (100%)
 rename Documentation/RelNotes/{1.8.0.1.txt => 1.8.0.1.adoc} (100%)
 rename Documentation/RelNotes/{1.8.0.2.txt => 1.8.0.2.adoc} (100%)
 rename Documentation/RelNotes/{1.8.0.3.txt => 1.8.0.3.adoc} (100%)
 rename Documentation/RelNotes/{1.8.0.txt => 1.8.0.adoc} (100%)
 rename Documentation/RelNotes/{1.8.1.1.txt => 1.8.1.1.adoc} (100%)
 rename Documentation/RelNotes/{1.8.1.2.txt => 1.8.1.2.adoc} (100%)
 rename Documentation/RelNotes/{1.8.1.3.txt => 1.8.1.3.adoc} (100%)
 rename Documentation/RelNotes/{1.8.1.4.txt => 1.8.1.4.adoc} (100%)
 rename Documentation/RelNotes/{1.8.1.5.txt => 1.8.1.5.adoc} (100%)
 rename Documentation/RelNotes/{1.8.1.6.txt => 1.8.1.6.adoc} (100%)
 rename Documentation/RelNotes/{1.8.1.txt => 1.8.1.adoc} (100%)
 rename Documentation/RelNotes/{1.8.2.1.txt => 1.8.2.1.adoc} (100%)
 rename Documentation/RelNotes/{1.8.2.2.txt => 1.8.2.2.adoc} (100%)
 rename Documentation/RelNotes/{1.8.2.3.txt => 1.8.2.3.adoc} (100%)
 rename Documentation/RelNotes/{1.8.2.txt => 1.8.2.adoc} (100%)
 rename Documentation/RelNotes/{1.8.3.1.txt => 1.8.3.1.adoc} (100%)
 rename Documentation/RelNotes/{1.8.3.2.txt => 1.8.3.2.adoc} (100%)
 rename Documentation/RelNotes/{1.8.3.3.txt => 1.8.3.3.adoc} (100%)
 rename Documentation/RelNotes/{1.8.3.4.txt => 1.8.3.4.adoc} (100%)
 rename Documentation/RelNotes/{1.8.3.txt => 1.8.3.adoc} (100%)
 rename Documentation/RelNotes/{1.8.4.1.txt => 1.8.4.1.adoc} (100%)
 rename Documentation/RelNotes/{1.8.4.2.txt => 1.8.4.2.adoc} (100%)
 rename Documentation/RelNotes/{1.8.4.3.txt => 1.8.4.3.adoc} (100%)
 rename Documentation/RelNotes/{1.8.4.4.txt => 1.8.4.4.adoc} (100%)
 rename Documentation/RelNotes/{1.8.4.5.txt => 1.8.4.5.adoc} (100%)
 rename Documentation/RelNotes/{1.8.4.txt => 1.8.4.adoc} (100%)
 rename Documentation/RelNotes/{1.8.5.1.txt => 1.8.5.1.adoc} (100%)
 rename Documentation/RelNotes/{1.8.5.2.txt => 1.8.5.2.adoc} (100%)
 rename Documentation/RelNotes/{1.8.5.3.txt => 1.8.5.3.adoc} (100%)
 rename Documentation/RelNotes/{1.8.5.4.txt => 1.8.5.4.adoc} (100%)
 rename Documentation/RelNotes/{1.8.5.5.txt => 1.8.5.5.adoc} (100%)
 rename Documentation/RelNotes/{1.8.5.6.txt => 1.8.5.6.adoc} (100%)
 rename Documentation/RelNotes/{1.8.5.txt => 1.8.5.adoc} (100%)
 rename Documentation/RelNotes/{1.9.0.txt => 1.9.0.adoc} (100%)
 rename Documentation/RelNotes/{1.9.1.txt => 1.9.1.adoc} (100%)
 rename Documentation/RelNotes/{1.9.2.txt => 1.9.2.adoc} (100%)
 rename Documentation/RelNotes/{1.9.3.txt => 1.9.3.adoc} (100%)
 rename Documentation/RelNotes/{1.9.4.txt => 1.9.4.adoc} (100%)
 rename Documentation/RelNotes/{1.9.5.txt => 1.9.5.adoc} (100%)
 rename Documentation/RelNotes/{2.0.0.txt => 2.0.0.adoc} (100%)
 rename Documentation/RelNotes/{2.0.1.txt => 2.0.1.adoc} (100%)
 rename Documentation/RelNotes/{2.0.2.txt => 2.0.2.adoc} (100%)
 rename Documentation/RelNotes/{2.0.3.txt => 2.0.3.adoc} (100%)
 rename Documentation/RelNotes/{2.0.4.txt => 2.0.4.adoc} (100%)
 rename Documentation/RelNotes/{2.0.5.txt => 2.0.5.adoc} (100%)
 rename Documentation/RelNotes/{2.1.0.txt => 2.1.0.adoc} (100%)
 rename Documentation/RelNotes/{2.1.1.txt => 2.1.1.adoc} (100%)
 rename Documentation/RelNotes/{2.1.2.txt => 2.1.2.adoc} (100%)
 rename Documentation/RelNotes/{2.1.3.txt => 2.1.3.adoc} (100%)
 rename Documentation/RelNotes/{2.1.4.txt => 2.1.4.adoc} (100%)
 rename Documentation/RelNotes/{2.10.0.txt => 2.10.0.adoc} (100%)
 rename Documentation/RelNotes/{2.10.1.txt => 2.10.1.adoc} (100%)
 rename Documentation/RelNotes/{2.10.2.txt => 2.10.2.adoc} (100%)
 rename Documentation/RelNotes/{2.10.3.txt => 2.10.3.adoc} (100%)
 rename Documentation/RelNotes/{2.10.4.txt => 2.10.4.adoc} (100%)
 rename Documentation/RelNotes/{2.10.5.txt => 2.10.5.adoc} (100%)
 rename Documentation/RelNotes/{2.11.0.txt => 2.11.0.adoc} (100%)
 rename Documentation/RelNotes/{2.11.1.txt => 2.11.1.adoc} (100%)
 rename Documentation/RelNotes/{2.11.2.txt => 2.11.2.adoc} (100%)
 rename Documentation/RelNotes/{2.11.3.txt => 2.11.3.adoc} (100%)
 rename Documentation/RelNotes/{2.11.4.txt => 2.11.4.adoc} (100%)
 rename Documentation/RelNotes/{2.12.0.txt => 2.12.0.adoc} (100%)
 rename Documentation/RelNotes/{2.12.1.txt => 2.12.1.adoc} (100%)
 rename Documentation/RelNotes/{2.12.2.txt => 2.12.2.adoc} (100%)
 rename Documentation/RelNotes/{2.12.3.txt => 2.12.3.adoc} (100%)
 rename Documentation/RelNotes/{2.12.4.txt => 2.12.4.adoc} (100%)
 rename Documentation/RelNotes/{2.12.5.txt => 2.12.5.adoc} (100%)
 rename Documentation/RelNotes/{2.13.0.txt => 2.13.0.adoc} (100%)
 rename Documentation/RelNotes/{2.13.1.txt => 2.13.1.adoc} (100%)
 rename Documentation/RelNotes/{2.13.2.txt => 2.13.2.adoc} (100%)
 rename Documentation/RelNotes/{2.13.3.txt => 2.13.3.adoc} (100%)
 rename Documentation/RelNotes/{2.13.4.txt => 2.13.4.adoc} (100%)
 rename Documentation/RelNotes/{2.13.5.txt => 2.13.5.adoc} (100%)
 rename Documentation/RelNotes/{2.13.6.txt => 2.13.6.adoc} (100%)
 rename Documentation/RelNotes/{2.13.7.txt => 2.13.7.adoc} (100%)
 rename Documentation/RelNotes/{2.14.0.txt => 2.14.0.adoc} (100%)
 rename Documentation/RelNotes/{2.14.1.txt => 2.14.1.adoc} (100%)
 rename Documentation/RelNotes/{2.14.2.txt => 2.14.2.adoc} (100%)
 rename Documentation/RelNotes/{2.14.3.txt => 2.14.3.adoc} (100%)
 rename Documentation/RelNotes/{2.14.4.txt => 2.14.4.adoc} (100%)
 rename Documentation/RelNotes/{2.14.5.txt => 2.14.5.adoc} (100%)
 rename Documentation/RelNotes/{2.14.6.txt => 2.14.6.adoc} (100%)
 rename Documentation/RelNotes/{2.15.0.txt => 2.15.0.adoc} (100%)
 rename Documentation/RelNotes/{2.15.1.txt => 2.15.1.adoc} (100%)
 rename Documentation/RelNotes/{2.15.2.txt => 2.15.2.adoc} (100%)
 rename Documentation/RelNotes/{2.15.3.txt => 2.15.3.adoc} (100%)
 rename Documentation/RelNotes/{2.15.4.txt => 2.15.4.adoc} (100%)
 rename Documentation/RelNotes/{2.16.0.txt => 2.16.0.adoc} (100%)
 rename Documentation/RelNotes/{2.16.1.txt => 2.16.1.adoc} (100%)
 rename Documentation/RelNotes/{2.16.2.txt => 2.16.2.adoc} (100%)
 rename Documentation/RelNotes/{2.16.3.txt => 2.16.3.adoc} (100%)
 rename Documentation/RelNotes/{2.16.4.txt => 2.16.4.adoc} (100%)
 rename Documentation/RelNotes/{2.16.5.txt => 2.16.5.adoc} (100%)
 rename Documentation/RelNotes/{2.16.6.txt => 2.16.6.adoc} (100%)
 rename Documentation/RelNotes/{2.17.0.txt => 2.17.0.adoc} (100%)
 rename Documentation/RelNotes/{2.17.1.txt => 2.17.1.adoc} (100%)
 rename Documentation/RelNotes/{2.17.2.txt => 2.17.2.adoc} (100%)
 rename Documentation/RelNotes/{2.17.3.txt => 2.17.3.adoc} (100%)
 rename Documentation/RelNotes/{2.17.4.txt => 2.17.4.adoc} (100%)
 rename Documentation/RelNotes/{2.17.5.txt => 2.17.5.adoc} (100%)
 rename Documentation/RelNotes/{2.17.6.txt => 2.17.6.adoc} (100%)
 rename Documentation/RelNotes/{2.18.0.txt => 2.18.0.adoc} (100%)
 rename Documentation/RelNotes/{2.18.1.txt => 2.18.1.adoc} (100%)
 rename Documentation/RelNotes/{2.18.2.txt => 2.18.2.adoc} (100%)
 rename Documentation/RelNotes/{2.18.3.txt => 2.18.3.adoc} (100%)
 rename Documentation/RelNotes/{2.18.4.txt => 2.18.4.adoc} (100%)
 rename Documentation/RelNotes/{2.18.5.txt => 2.18.5.adoc} (100%)
 rename Documentation/RelNotes/{2.19.0.txt => 2.19.0.adoc} (100%)
 rename Documentation/RelNotes/{2.19.1.txt => 2.19.1.adoc} (100%)
 rename Documentation/RelNotes/{2.19.2.txt => 2.19.2.adoc} (100%)
 rename Documentation/RelNotes/{2.19.3.txt => 2.19.3.adoc} (100%)
 rename Documentation/RelNotes/{2.19.4.txt => 2.19.4.adoc} (100%)
 rename Documentation/RelNotes/{2.19.5.txt => 2.19.5.adoc} (100%)
 rename Documentation/RelNotes/{2.19.6.txt => 2.19.6.adoc} (100%)
 rename Documentation/RelNotes/{2.2.0.txt => 2.2.0.adoc} (100%)
 rename Documentation/RelNotes/{2.2.1.txt => 2.2.1.adoc} (100%)
 rename Documentation/RelNotes/{2.2.2.txt => 2.2.2.adoc} (100%)
 rename Documentation/RelNotes/{2.2.3.txt => 2.2.3.adoc} (100%)
 rename Documentation/RelNotes/{2.20.0.txt => 2.20.0.adoc} (100%)
 rename Documentation/RelNotes/{2.20.1.txt => 2.20.1.adoc} (100%)
 rename Documentation/RelNotes/{2.20.2.txt => 2.20.2.adoc} (100%)
 rename Documentation/RelNotes/{2.20.3.txt => 2.20.3.adoc} (100%)
 rename Documentation/RelNotes/{2.20.4.txt => 2.20.4.adoc} (100%)
 rename Documentation/RelNotes/{2.20.5.txt => 2.20.5.adoc} (100%)
 rename Documentation/RelNotes/{2.21.0.txt => 2.21.0.adoc} (100%)
 rename Documentation/RelNotes/{2.21.1.txt => 2.21.1.adoc} (100%)
 rename Documentation/RelNotes/{2.21.2.txt => 2.21.2.adoc} (100%)
 rename Documentation/RelNotes/{2.21.3.txt => 2.21.3.adoc} (100%)
 rename Documentation/RelNotes/{2.21.4.txt => 2.21.4.adoc} (100%)
 rename Documentation/RelNotes/{2.22.0.txt => 2.22.0.adoc} (100%)
 rename Documentation/RelNotes/{2.22.1.txt => 2.22.1.adoc} (100%)
 rename Documentation/RelNotes/{2.22.2.txt => 2.22.2.adoc} (100%)
 rename Documentation/RelNotes/{2.22.3.txt => 2.22.3.adoc} (100%)
 rename Documentation/RelNotes/{2.22.4.txt => 2.22.4.adoc} (100%)
 rename Documentation/RelNotes/{2.22.5.txt => 2.22.5.adoc} (100%)
 rename Documentation/RelNotes/{2.23.0.txt => 2.23.0.adoc} (100%)
 rename Documentation/RelNotes/{2.23.1.txt => 2.23.1.adoc} (100%)
 rename Documentation/RelNotes/{2.23.2.txt => 2.23.2.adoc} (100%)
 rename Documentation/RelNotes/{2.23.3.txt => 2.23.3.adoc} (100%)
 rename Documentation/RelNotes/{2.23.4.txt => 2.23.4.adoc} (100%)
 rename Documentation/RelNotes/{2.24.0.txt => 2.24.0.adoc} (100%)
 rename Documentation/RelNotes/{2.24.1.txt => 2.24.1.adoc} (100%)
 rename Documentation/RelNotes/{2.24.2.txt => 2.24.2.adoc} (100%)
 rename Documentation/RelNotes/{2.24.3.txt => 2.24.3.adoc} (100%)
 rename Documentation/RelNotes/{2.24.4.txt => 2.24.4.adoc} (100%)
 rename Documentation/RelNotes/{2.25.0.txt => 2.25.0.adoc} (100%)
 rename Documentation/RelNotes/{2.25.1.txt => 2.25.1.adoc} (100%)
 rename Documentation/RelNotes/{2.25.2.txt => 2.25.2.adoc} (100%)
 rename Documentation/RelNotes/{2.25.3.txt => 2.25.3.adoc} (100%)
 rename Documentation/RelNotes/{2.25.4.txt => 2.25.4.adoc} (100%)
 rename Documentation/RelNotes/{2.25.5.txt => 2.25.5.adoc} (100%)
 rename Documentation/RelNotes/{2.26.0.txt => 2.26.0.adoc} (100%)
 rename Documentation/RelNotes/{2.26.1.txt => 2.26.1.adoc} (100%)
 rename Documentation/RelNotes/{2.26.2.txt => 2.26.2.adoc} (100%)
 rename Documentation/RelNotes/{2.26.3.txt => 2.26.3.adoc} (100%)
 rename Documentation/RelNotes/{2.27.0.txt => 2.27.0.adoc} (100%)
 rename Documentation/RelNotes/{2.27.1.txt => 2.27.1.adoc} (100%)
 rename Documentation/RelNotes/{2.28.0.txt => 2.28.0.adoc} (100%)
 rename Documentation/RelNotes/{2.28.1.txt => 2.28.1.adoc} (100%)
 rename Documentation/RelNotes/{2.29.0.txt => 2.29.0.adoc} (100%)
 rename Documentation/RelNotes/{2.29.1.txt => 2.29.1.adoc} (100%)
 rename Documentation/RelNotes/{2.29.2.txt => 2.29.2.adoc} (100%)
 rename Documentation/RelNotes/{2.29.3.txt => 2.29.3.adoc} (100%)
 rename Documentation/RelNotes/{2.3.0.txt => 2.3.0.adoc} (100%)
 rename Documentation/RelNotes/{2.3.1.txt => 2.3.1.adoc} (100%)
 rename Documentation/RelNotes/{2.3.10.txt => 2.3.10.adoc} (100%)
 rename Documentation/RelNotes/{2.3.2.txt => 2.3.2.adoc} (100%)
 rename Documentation/RelNotes/{2.3.3.txt => 2.3.3.adoc} (100%)
 rename Documentation/RelNotes/{2.3.4.txt => 2.3.4.adoc} (100%)
 rename Documentation/RelNotes/{2.3.5.txt => 2.3.5.adoc} (100%)
 rename Documentation/RelNotes/{2.3.6.txt => 2.3.6.adoc} (100%)
 rename Documentation/RelNotes/{2.3.7.txt => 2.3.7.adoc} (100%)
 rename Documentation/RelNotes/{2.3.8.txt => 2.3.8.adoc} (100%)
 rename Documentation/RelNotes/{2.3.9.txt => 2.3.9.adoc} (100%)
 rename Documentation/RelNotes/{2.30.0.txt => 2.30.0.adoc} (100%)
 rename Documentation/RelNotes/{2.30.1.txt => 2.30.1.adoc} (100%)
 rename Documentation/RelNotes/{2.30.2.txt => 2.30.2.adoc} (100%)
 rename Documentation/RelNotes/{2.30.3.txt => 2.30.3.adoc} (100%)
 rename Documentation/RelNotes/{2.30.4.txt => 2.30.4.adoc} (100%)
 rename Documentation/RelNotes/{2.30.5.txt => 2.30.5.adoc} (100%)
 rename Documentation/RelNotes/{2.30.6.txt => 2.30.6.adoc} (100%)
 rename Documentation/RelNotes/{2.30.7.txt => 2.30.7.adoc} (100%)
 rename Documentation/RelNotes/{2.30.8.txt => 2.30.8.adoc} (100%)
 rename Documentation/RelNotes/{2.30.9.txt => 2.30.9.adoc} (100%)
 rename Documentation/RelNotes/{2.31.0.txt => 2.31.0.adoc} (100%)
 rename Documentation/RelNotes/{2.31.1.txt => 2.31.1.adoc} (100%)
 rename Documentation/RelNotes/{2.31.2.txt => 2.31.2.adoc} (100%)
 rename Documentation/RelNotes/{2.31.3.txt => 2.31.3.adoc} (100%)
 rename Documentation/RelNotes/{2.31.4.txt => 2.31.4.adoc} (100%)
 rename Documentation/RelNotes/{2.31.5.txt => 2.31.5.adoc} (100%)
 rename Documentation/RelNotes/{2.31.6.txt => 2.31.6.adoc} (100%)
 rename Documentation/RelNotes/{2.31.7.txt => 2.31.7.adoc} (100%)
 rename Documentation/RelNotes/{2.31.8.txt => 2.31.8.adoc} (100%)
 rename Documentation/RelNotes/{2.32.0.txt => 2.32.0.adoc} (100%)
 rename Documentation/RelNotes/{2.32.1.txt => 2.32.1.adoc} (100%)
 rename Documentation/RelNotes/{2.32.2.txt => 2.32.2.adoc} (100%)
 rename Documentation/RelNotes/{2.32.3.txt => 2.32.3.adoc} (100%)
 rename Documentation/RelNotes/{2.32.4.txt => 2.32.4.adoc} (100%)
 rename Documentation/RelNotes/{2.32.5.txt => 2.32.5.adoc} (100%)
 rename Documentation/RelNotes/{2.32.6.txt => 2.32.6.adoc} (100%)
 rename Documentation/RelNotes/{2.32.7.txt => 2.32.7.adoc} (100%)
 rename Documentation/RelNotes/{2.33.0.txt => 2.33.0.adoc} (100%)
 rename Documentation/RelNotes/{2.33.1.txt => 2.33.1.adoc} (100%)
 rename Documentation/RelNotes/{2.33.2.txt => 2.33.2.adoc} (100%)
 rename Documentation/RelNotes/{2.33.3.txt => 2.33.3.adoc} (100%)
 rename Documentation/RelNotes/{2.33.4.txt => 2.33.4.adoc} (100%)
 rename Documentation/RelNotes/{2.33.5.txt => 2.33.5.adoc} (100%)
 rename Documentation/RelNotes/{2.33.6.txt => 2.33.6.adoc} (100%)
 rename Documentation/RelNotes/{2.33.7.txt => 2.33.7.adoc} (100%)
 rename Documentation/RelNotes/{2.33.8.txt => 2.33.8.adoc} (100%)
 rename Documentation/RelNotes/{2.34.0.txt => 2.34.0.adoc} (100%)
 rename Documentation/RelNotes/{2.34.1.txt => 2.34.1.adoc} (100%)
 rename Documentation/RelNotes/{2.34.2.txt => 2.34.2.adoc} (100%)
 rename Documentation/RelNotes/{2.34.3.txt => 2.34.3.adoc} (100%)
 rename Documentation/RelNotes/{2.34.4.txt => 2.34.4.adoc} (100%)
 rename Documentation/RelNotes/{2.34.5.txt => 2.34.5.adoc} (100%)
 rename Documentation/RelNotes/{2.34.6.txt => 2.34.6.adoc} (100%)
 rename Documentation/RelNotes/{2.34.7.txt => 2.34.7.adoc} (100%)
 rename Documentation/RelNotes/{2.34.8.txt => 2.34.8.adoc} (100%)
 rename Documentation/RelNotes/{2.35.0.txt => 2.35.0.adoc} (100%)
 rename Documentation/RelNotes/{2.35.1.txt => 2.35.1.adoc} (100%)
 rename Documentation/RelNotes/{2.35.2.txt => 2.35.2.adoc} (100%)
 rename Documentation/RelNotes/{2.35.3.txt => 2.35.3.adoc} (100%)
 rename Documentation/RelNotes/{2.35.4.txt => 2.35.4.adoc} (100%)
 rename Documentation/RelNotes/{2.35.5.txt => 2.35.5.adoc} (100%)
 rename Documentation/RelNotes/{2.35.6.txt => 2.35.6.adoc} (100%)
 rename Documentation/RelNotes/{2.35.7.txt => 2.35.7.adoc} (100%)
 rename Documentation/RelNotes/{2.35.8.txt => 2.35.8.adoc} (100%)
 rename Documentation/RelNotes/{2.36.0.txt => 2.36.0.adoc} (100%)
 rename Documentation/RelNotes/{2.36.1.txt => 2.36.1.adoc} (100%)
 rename Documentation/RelNotes/{2.36.2.txt => 2.36.2.adoc} (100%)
 rename Documentation/RelNotes/{2.36.3.txt => 2.36.3.adoc} (100%)
 rename Documentation/RelNotes/{2.36.4.txt => 2.36.4.adoc} (100%)
 rename Documentation/RelNotes/{2.36.5.txt => 2.36.5.adoc} (100%)
 rename Documentation/RelNotes/{2.36.6.txt => 2.36.6.adoc} (100%)
 rename Documentation/RelNotes/{2.37.0.txt => 2.37.0.adoc} (100%)
 rename Documentation/RelNotes/{2.37.1.txt => 2.37.1.adoc} (100%)
 rename Documentation/RelNotes/{2.37.2.txt => 2.37.2.adoc} (100%)
 rename Documentation/RelNotes/{2.37.3.txt => 2.37.3.adoc} (100%)
 rename Documentation/RelNotes/{2.37.4.txt => 2.37.4.adoc} (100%)
 rename Documentation/RelNotes/{2.37.5.txt => 2.37.5.adoc} (100%)
 rename Documentation/RelNotes/{2.37.6.txt => 2.37.6.adoc} (100%)
 rename Documentation/RelNotes/{2.37.7.txt => 2.37.7.adoc} (100%)
 rename Documentation/RelNotes/{2.38.0.txt => 2.38.0.adoc} (100%)
 rename Documentation/RelNotes/{2.38.1.txt => 2.38.1.adoc} (100%)
 rename Documentation/RelNotes/{2.38.2.txt => 2.38.2.adoc} (100%)
 rename Documentation/RelNotes/{2.38.3.txt => 2.38.3.adoc} (100%)
 rename Documentation/RelNotes/{2.38.4.txt => 2.38.4.adoc} (100%)
 rename Documentation/RelNotes/{2.38.5.txt => 2.38.5.adoc} (100%)
 rename Documentation/RelNotes/{2.39.0.txt => 2.39.0.adoc} (100%)
 rename Documentation/RelNotes/{2.39.1.txt => 2.39.1.adoc} (100%)
 rename Documentation/RelNotes/{2.39.2.txt => 2.39.2.adoc} (100%)
 rename Documentation/RelNotes/{2.39.3.txt => 2.39.3.adoc} (100%)
 rename Documentation/RelNotes/{2.39.4.txt => 2.39.4.adoc} (100%)
 rename Documentation/RelNotes/{2.39.5.txt => 2.39.5.adoc} (100%)
 rename Documentation/RelNotes/{2.4.0.txt => 2.4.0.adoc} (100%)
 rename Documentation/RelNotes/{2.4.1.txt => 2.4.1.adoc} (100%)
 rename Documentation/RelNotes/{2.4.10.txt => 2.4.10.adoc} (100%)
 rename Documentation/RelNotes/{2.4.11.txt => 2.4.11.adoc} (100%)
 rename Documentation/RelNotes/{2.4.12.txt => 2.4.12.adoc} (100%)
 rename Documentation/RelNotes/{2.4.2.txt => 2.4.2.adoc} (100%)
 rename Documentation/RelNotes/{2.4.3.txt => 2.4.3.adoc} (100%)
 rename Documentation/RelNotes/{2.4.4.txt => 2.4.4.adoc} (100%)
 rename Documentation/RelNotes/{2.4.5.txt => 2.4.5.adoc} (100%)
 rename Documentation/RelNotes/{2.4.6.txt => 2.4.6.adoc} (100%)
 rename Documentation/RelNotes/{2.4.7.txt => 2.4.7.adoc} (100%)
 rename Documentation/RelNotes/{2.4.8.txt => 2.4.8.adoc} (100%)
 rename Documentation/RelNotes/{2.4.9.txt => 2.4.9.adoc} (100%)
 rename Documentation/RelNotes/{2.40.0.txt => 2.40.0.adoc} (100%)
 rename Documentation/RelNotes/{2.40.1.txt => 2.40.1.adoc} (100%)
 rename Documentation/RelNotes/{2.40.2.txt => 2.40.2.adoc} (100%)
 rename Documentation/RelNotes/{2.40.3.txt => 2.40.3.adoc} (100%)
 rename Documentation/RelNotes/{2.40.4.txt => 2.40.4.adoc} (100%)
 rename Documentation/RelNotes/{2.41.0.txt => 2.41.0.adoc} (100%)
 rename Documentation/RelNotes/{2.41.1.txt => 2.41.1.adoc} (100%)
 rename Documentation/RelNotes/{2.41.2.txt => 2.41.2.adoc} (100%)
 rename Documentation/RelNotes/{2.41.3.txt => 2.41.3.adoc} (100%)
 rename Documentation/RelNotes/{2.42.0.txt => 2.42.0.adoc} (100%)
 rename Documentation/RelNotes/{2.42.1.txt => 2.42.1.adoc} (100%)
 rename Documentation/RelNotes/{2.42.2.txt => 2.42.2.adoc} (100%)
 rename Documentation/RelNotes/{2.42.3.txt => 2.42.3.adoc} (100%)
 rename Documentation/RelNotes/{2.42.4.txt => 2.42.4.adoc} (100%)
 rename Documentation/RelNotes/{2.43.0.txt => 2.43.0.adoc} (100%)
 rename Documentation/RelNotes/{2.43.1.txt => 2.43.1.adoc} (100%)
 rename Documentation/RelNotes/{2.43.2.txt => 2.43.2.adoc} (100%)
 rename Documentation/RelNotes/{2.43.3.txt => 2.43.3.adoc} (100%)
 rename Documentation/RelNotes/{2.43.4.txt => 2.43.4.adoc} (100%)
 rename Documentation/RelNotes/{2.43.5.txt => 2.43.5.adoc} (100%)
 rename Documentation/RelNotes/{2.43.6.txt => 2.43.6.adoc} (100%)
 rename Documentation/RelNotes/{2.44.0.txt => 2.44.0.adoc} (100%)
 rename Documentation/RelNotes/{2.44.1.txt => 2.44.1.adoc} (100%)
 rename Documentation/RelNotes/{2.44.2.txt => 2.44.2.adoc} (100%)
 rename Documentation/RelNotes/{2.44.3.txt => 2.44.3.adoc} (100%)
 rename Documentation/RelNotes/{2.45.0.txt => 2.45.0.adoc} (100%)
 rename Documentation/RelNotes/{2.45.1.txt => 2.45.1.adoc} (100%)
 rename Documentation/RelNotes/{2.45.2.txt => 2.45.2.adoc} (100%)
 rename Documentation/RelNotes/{2.45.3.txt => 2.45.3.adoc} (100%)
 rename Documentation/RelNotes/{2.46.0.txt => 2.46.0.adoc} (100%)
 rename Documentation/RelNotes/{2.46.1.txt => 2.46.1.adoc} (100%)
 rename Documentation/RelNotes/{2.46.2.txt => 2.46.2.adoc} (100%)
 rename Documentation/RelNotes/{2.46.3.txt => 2.46.3.adoc} (100%)
 rename Documentation/RelNotes/{2.47.0.txt => 2.47.0.adoc} (100%)
 rename Documentation/RelNotes/{2.47.1.txt => 2.47.1.adoc} (100%)
 rename Documentation/RelNotes/{2.47.2.txt => 2.47.2.adoc} (100%)
 rename Documentation/RelNotes/{2.48.0.txt => 2.48.0.adoc} (100%)
 rename Documentation/RelNotes/{2.48.1.txt => 2.48.1.adoc} (100%)
 rename Documentation/RelNotes/{2.49.0.txt => 2.49.0.adoc} (100%)
 rename Documentation/RelNotes/{2.5.0.txt => 2.5.0.adoc} (100%)
 rename Documentation/RelNotes/{2.5.1.txt => 2.5.1.adoc} (100%)
 rename Documentation/RelNotes/{2.5.2.txt => 2.5.2.adoc} (100%)
 rename Documentation/RelNotes/{2.5.3.txt => 2.5.3.adoc} (100%)
 rename Documentation/RelNotes/{2.5.4.txt => 2.5.4.adoc} (100%)
 rename Documentation/RelNotes/{2.5.5.txt => 2.5.5.adoc} (100%)
 rename Documentation/RelNotes/{2.5.6.txt => 2.5.6.adoc} (100%)
 rename Documentation/RelNotes/{2.6.0.txt => 2.6.0.adoc} (100%)
 rename Documentation/RelNotes/{2.6.1.txt => 2.6.1.adoc} (100%)
 rename Documentation/RelNotes/{2.6.2.txt => 2.6.2.adoc} (100%)
 rename Documentation/RelNotes/{2.6.3.txt => 2.6.3.adoc} (100%)
 rename Documentation/RelNotes/{2.6.4.txt => 2.6.4.adoc} (100%)
 rename Documentation/RelNotes/{2.6.5.txt => 2.6.5.adoc} (100%)
 rename Documentation/RelNotes/{2.6.6.txt => 2.6.6.adoc} (100%)
 rename Documentation/RelNotes/{2.6.7.txt => 2.6.7.adoc} (100%)
 rename Documentation/RelNotes/{2.7.0.txt => 2.7.0.adoc} (100%)
 rename Documentation/RelNotes/{2.7.1.txt => 2.7.1.adoc} (100%)
 rename Documentation/RelNotes/{2.7.2.txt => 2.7.2.adoc} (100%)
 rename Documentation/RelNotes/{2.7.3.txt => 2.7.3.adoc} (100%)
 rename Documentation/RelNotes/{2.7.4.txt => 2.7.4.adoc} (100%)
 rename Documentation/RelNotes/{2.7.5.txt => 2.7.5.adoc} (100%)
 rename Documentation/RelNotes/{2.7.6.txt => 2.7.6.adoc} (100%)
 rename Documentation/RelNotes/{2.8.0.txt => 2.8.0.adoc} (100%)
 rename Documentation/RelNotes/{2.8.1.txt => 2.8.1.adoc} (100%)
 rename Documentation/RelNotes/{2.8.2.txt => 2.8.2.adoc} (100%)
 rename Documentation/RelNotes/{2.8.3.txt => 2.8.3.adoc} (100%)
 rename Documentation/RelNotes/{2.8.4.txt => 2.8.4.adoc} (100%)
 rename Documentation/RelNotes/{2.8.5.txt => 2.8.5.adoc} (100%)
 rename Documentation/RelNotes/{2.8.6.txt => 2.8.6.adoc} (100%)
 rename Documentation/RelNotes/{2.9.0.txt => 2.9.0.adoc} (100%)
 rename Documentation/RelNotes/{2.9.1.txt => 2.9.1.adoc} (100%)
 rename Documentation/RelNotes/{2.9.2.txt => 2.9.2.adoc} (100%)
 rename Documentation/RelNotes/{2.9.3.txt => 2.9.3.adoc} (100%)
 rename Documentation/RelNotes/{2.9.4.txt => 2.9.4.adoc} (100%)
 rename Documentation/RelNotes/{2.9.5.txt => 2.9.5.adoc} (100%)
 rename Documentation/{ReviewingGuidelines.txt => ReviewingGuidelines.adoc} (100%)
 rename Documentation/{ToolsForGit.txt => ToolsForGit.adoc} (100%)
 rename Documentation/{blame-options.txt => blame-options.adoc} (99%)
 rename Documentation/{config.txt => config.adoc} (84%)
 rename Documentation/config/{add.txt => add.adoc} (100%)
 rename Documentation/config/{advice.txt => advice.adoc} (100%)
 rename Documentation/config/{alias.txt => alias.adoc} (100%)
 rename Documentation/config/{am.txt => am.adoc} (100%)
 rename Documentation/config/{apply.txt => apply.adoc} (100%)
 rename Documentation/config/{attr.txt => attr.adoc} (100%)
 rename Documentation/config/{bitmap-pseudo-merge.txt => bitmap-pseudo-merge.adoc} (100%)
 rename Documentation/config/{blame.txt => blame.adoc} (100%)
 rename Documentation/config/{branch.txt => branch.adoc} (100%)
 rename Documentation/config/{browser.txt => browser.adoc} (100%)
 rename Documentation/config/{bundle.txt => bundle.adoc} (100%)
 rename Documentation/config/{checkout.txt => checkout.adoc} (100%)
 rename Documentation/config/{clean.txt => clean.adoc} (100%)
 rename Documentation/config/{clone.txt => clone.adoc} (100%)
 rename Documentation/config/{color.txt => color.adoc} (100%)
 rename Documentation/config/{column.txt => column.adoc} (100%)
 rename Documentation/config/{commit.txt => commit.adoc} (100%)
 rename Documentation/config/{commitgraph.txt => commitgraph.adoc} (100%)
 rename Documentation/config/{completion.txt => completion.adoc} (100%)
 rename Documentation/config/{core.txt => core.adoc} (100%)
 rename Documentation/config/{credential.txt => credential.adoc} (100%)
 rename Documentation/config/{diff.txt => diff.adoc} (99%)
 rename Documentation/config/{difftool.txt => difftool.adoc} (100%)
 rename Documentation/config/{extensions.txt => extensions.adoc} (99%)
 rename Documentation/config/{fastimport.txt => fastimport.adoc} (100%)
 rename Documentation/config/{feature.txt => feature.adoc} (100%)
 rename Documentation/config/{fetch.txt => fetch.adoc} (100%)
 rename Documentation/config/{filter.txt => filter.adoc} (100%)
 rename Documentation/config/{fmt-merge-msg.txt => fmt-merge-msg.adoc} (100%)
 rename Documentation/config/{format.txt => format.adoc} (100%)
 rename Documentation/config/{fsck.txt => fsck.adoc} (100%)
 rename Documentation/config/{fsmonitor--daemon.txt => fsmonitor--daemon.adoc} (100%)
 rename Documentation/config/{gc.txt => gc.adoc} (100%)
 rename Documentation/config/{gitcvs.txt => gitcvs.adoc} (100%)
 rename Documentation/config/{gitweb.txt => gitweb.adoc} (100%)
 rename Documentation/config/{gpg.txt => gpg.adoc} (100%)
 rename Documentation/config/{grep.txt => grep.adoc} (100%)
 rename Documentation/config/{gui.txt => gui.adoc} (100%)
 rename Documentation/config/{guitool.txt => guitool.adoc} (100%)
 rename Documentation/config/{help.txt => help.adoc} (100%)
 rename Documentation/config/{http.txt => http.adoc} (100%)
 rename Documentation/config/{i18n.txt => i18n.adoc} (100%)
 rename Documentation/config/{imap.txt => imap.adoc} (100%)
 rename Documentation/config/{includeif.txt => includeif.adoc} (100%)
 rename Documentation/config/{index.txt => index.adoc} (100%)
 rename Documentation/config/{init.txt => init.adoc} (100%)
 rename Documentation/config/{instaweb.txt => instaweb.adoc} (100%)
 rename Documentation/config/{interactive.txt => interactive.adoc} (100%)
 rename Documentation/config/{log.txt => log.adoc} (100%)
 rename Documentation/config/{lsrefs.txt => lsrefs.adoc} (100%)
 rename Documentation/config/{mailinfo.txt => mailinfo.adoc} (100%)
 rename Documentation/config/{mailmap.txt => mailmap.adoc} (100%)
 rename Documentation/config/{maintenance.txt => maintenance.adoc} (100%)
 rename Documentation/config/{man.txt => man.adoc} (100%)
 rename Documentation/config/{merge.txt => merge.adoc} (98%)
 rename Documentation/config/{mergetool.txt => mergetool.adoc} (100%)
 rename Documentation/config/{notes.txt => notes.adoc} (100%)
 rename Documentation/config/{pack.txt => pack.adoc} (100%)
 rename Documentation/config/{pager.txt => pager.adoc} (100%)
 rename Documentation/config/{pretty.txt => pretty.adoc} (100%)
 rename Documentation/config/{promisor.txt => promisor.adoc} (100%)
 rename Documentation/config/{protocol.txt => protocol.adoc} (100%)
 rename Documentation/config/{pull.txt => pull.adoc} (100%)
 rename Documentation/config/{push.txt => push.adoc} (100%)
 rename Documentation/config/{rebase.txt => rebase.adoc} (100%)
 rename Documentation/config/{receive.txt => receive.adoc} (100%)
 rename Documentation/config/{reftable.txt => reftable.adoc} (100%)
 rename Documentation/config/{remote.txt => remote.adoc} (100%)
 rename Documentation/config/{remotes.txt => remotes.adoc} (100%)
 rename Documentation/config/{repack.txt => repack.adoc} (100%)
 rename Documentation/config/{rerere.txt => rerere.adoc} (100%)
 rename Documentation/config/{revert.txt => revert.adoc} (100%)
 rename Documentation/config/{safe.txt => safe.adoc} (100%)
 rename Documentation/config/{sendemail.txt => sendemail.adoc} (100%)
 rename Documentation/config/{sequencer.txt => sequencer.adoc} (100%)
 rename Documentation/config/{showbranch.txt => showbranch.adoc} (100%)
 rename Documentation/config/{sparse.txt => sparse.adoc} (100%)
 rename Documentation/config/{splitindex.txt => splitindex.adoc} (100%)
 rename Documentation/config/{ssh.txt => ssh.adoc} (100%)
 rename Documentation/config/{stash.txt => stash.adoc} (100%)
 rename Documentation/config/{status.txt => status.adoc} (100%)
 rename Documentation/config/{submodule.txt => submodule.adoc} (100%)
 rename Documentation/config/{tag.txt => tag.adoc} (100%)
 rename Documentation/config/{tar.txt => tar.adoc} (100%)
 rename Documentation/config/{trace2.txt => trace2.adoc} (98%)
 rename Documentation/config/{transfer.txt => transfer.adoc} (100%)
 rename Documentation/config/{uploadarchive.txt => uploadarchive.adoc} (100%)
 rename Documentation/config/{uploadpack.txt => uploadpack.adoc} (100%)
 rename Documentation/config/{url.txt => url.adoc} (100%)
 rename Documentation/config/{user.txt => user.adoc} (100%)
 rename Documentation/config/{versionsort.txt => versionsort.adoc} (100%)
 rename Documentation/config/{web.txt => web.adoc} (100%)
 rename Documentation/config/{worktree.txt => worktree.adoc} (100%)
 rename Documentation/{date-formats.txt => date-formats.adoc} (100%)
 rename Documentation/{diff-format.txt => diff-format.adoc} (99%)
 rename Documentation/{diff-generate-patch.txt => diff-generate-patch.adoc} (100%)
 rename Documentation/{diff-options.txt => diff-options.adoc} (100%)
 rename Documentation/{everyday.txto => everyday.adoco} (100%)
 rename Documentation/{fetch-options.txt => fetch-options.adoc} (100%)
 rename Documentation/{fsck-msgids.txt => fsck-msgids.adoc} (100%)
 rename Documentation/{git-add.txt => git-add.adoc} (99%)
 rename Documentation/{git-am.txt => git-am.adoc} (98%)
 rename Documentation/{git-annotate.txt => git-annotate.adoc} (96%)
 rename Documentation/{git-apply.txt => git-apply.adoc} (99%)
 rename Documentation/{git-archimport.txt => git-archimport.adoc} (100%)
 rename Documentation/{git-archive.txt => git-archive.adoc} (100%)
 rename Documentation/{git-bisect-lk2009.txt => git-bisect-lk2009.adoc} (100%)
 rename Documentation/{git-bisect.txt => git-bisect.adoc} (100%)
 rename Documentation/{git-blame.txt => git-blame.adoc} (98%)
 rename Documentation/{git-branch.txt => git-branch.adoc} (99%)
 rename Documentation/{git-bugreport.txt => git-bugreport.adoc} (100%)
 rename Documentation/{git-bundle.txt => git-bundle.adoc} (100%)
 rename Documentation/{git-cat-file.txt => git-cat-file.adoc} (100%)
 rename Documentation/{git-check-attr.txt => git-check-attr.adoc} (100%)
 rename Documentation/{git-check-ignore.txt => git-check-ignore.adoc} (100%)
 rename Documentation/{git-check-mailmap.txt => git-check-mailmap.adoc} (100%)
 rename Documentation/{git-check-ref-format.txt => git-check-ref-format.adoc} (100%)
 rename Documentation/{git-checkout-index.txt => git-checkout-index.adoc} (100%)
 rename Documentation/{git-checkout.txt => git-checkout.adoc} (99%)
 rename Documentation/{git-cherry-pick.txt => git-cherry-pick.adoc} (99%)
 rename Documentation/{git-cherry.txt => git-cherry.adoc} (100%)
 rename Documentation/{git-citool.txt => git-citool.adoc} (100%)
 rename Documentation/{git-clean.txt => git-clean.adoc} (98%)
 rename Documentation/{git-clone.txt => git-clone.adoc} (98%)
 rename Documentation/{git-column.txt => git-column.adoc} (96%)
 rename Documentation/{git-commit-graph.txt => git-commit-graph.adoc} (98%)
 rename Documentation/{git-commit-tree.txt => git-commit-tree.adoc} (98%)
 rename Documentation/{git-commit.txt => git-commit.adoc} (99%)
 rename Documentation/{git-config.txt => git-config.adoc} (99%)
 rename Documentation/{git-count-objects.txt => git-count-objects.adoc} (100%)
 rename Documentation/{git-credential-cache--daemon.txt => git-credential-cache--daemon.adoc} (100%)
 rename Documentation/{git-credential-cache.txt => git-credential-cache.adoc} (100%)
 rename Documentation/{git-credential-store.txt => git-credential-store.adoc} (100%)
 rename Documentation/{git-credential.txt => git-credential.adoc} (100%)
 rename Documentation/{git-cvsexportcommit.txt => git-cvsexportcommit.adoc} (100%)
 rename Documentation/{git-cvsimport.txt => git-cvsimport.adoc} (100%)
 rename Documentation/{git-cvsserver.txt => git-cvsserver.adoc} (100%)
 rename Documentation/{git-daemon.txt => git-daemon.adoc} (100%)
 rename Documentation/{git-describe.txt => git-describe.adoc} (100%)
 rename Documentation/{git-diagnose.txt => git-diagnose.adoc} (100%)
 rename Documentation/{git-diff-files.txt => git-diff-files.adoc} (95%)
 rename Documentation/{git-diff-index.txt => git-diff-index.adoc} (98%)
 rename Documentation/{git-diff-tree.txt => git-diff-tree.adoc} (97%)
 rename Documentation/{git-diff.txt => git-diff.adoc} (98%)
 rename Documentation/{git-difftool.txt => git-difftool.adoc} (98%)
 rename Documentation/{git-fast-export.txt => git-fast-export.adoc} (100%)
 rename Documentation/{git-fast-import.txt => git-fast-import.adoc} (99%)
 rename Documentation/{git-fetch-pack.txt => git-fetch-pack.adoc} (100%)
 rename Documentation/{git-fetch.txt => git-fetch.adoc} (98%)
 rename Documentation/{git-filter-branch.txt => git-filter-branch.adoc} (100%)
 rename Documentation/{git-fmt-merge-msg.txt => git-fmt-merge-msg.adoc} (98%)
 rename Documentation/{git-for-each-ref.txt => git-for-each-ref.adoc} (99%)
 rename Documentation/{git-for-each-repo.txt => git-for-each-repo.adoc} (100%)
 rename Documentation/{git-format-patch.txt => git-format-patch.adoc} (99%)
 rename Documentation/{git-fsck-objects.txt => git-fsck-objects.adoc} (100%)
 rename Documentation/{git-fsck.txt => git-fsck.adoc} (98%)
 rename Documentation/{git-fsmonitor--daemon.txt => git-fsmonitor--daemon.adoc} (97%)
 rename Documentation/{git-gc.txt => git-gc.adoc} (98%)
 rename Documentation/{git-get-tar-commit-id.txt => git-get-tar-commit-id.adoc} (100%)
 rename Documentation/{git-grep.txt => git-grep.adoc} (99%)
 rename Documentation/{git-gui.txt => git-gui.adoc} (100%)
 rename Documentation/{git-hash-object.txt => git-hash-object.adoc} (100%)
 rename Documentation/{git-help.txt => git-help.adoc} (100%)
 rename Documentation/{git-hook.txt => git-hook.adoc} (100%)
 rename Documentation/{git-http-backend.txt => git-http-backend.adoc} (100%)
 rename Documentation/{git-http-fetch.txt => git-http-fetch.adoc} (100%)
 rename Documentation/{git-http-push.txt => git-http-push.adoc} (100%)
 rename Documentation/{git-imap-send.txt => git-imap-send.adoc} (97%)
 rename Documentation/{git-index-pack.txt => git-index-pack.adoc} (99%)
 rename Documentation/{git-init-db.txt => git-init-db.adoc} (100%)
 rename Documentation/{git-init.txt => git-init.adoc} (97%)
 rename Documentation/{git-instaweb.txt => git-instaweb.adoc} (100%)
 rename Documentation/{git-interpret-trailers.txt => git-interpret-trailers.adoc} (100%)
 rename Documentation/{git-log.txt => git-log.adoc} (95%)
 rename Documentation/{git-ls-files.txt => git-ls-files.adoc} (100%)
 rename Documentation/{git-ls-remote.txt => git-ls-remote.adoc} (100%)
 rename Documentation/{git-ls-tree.txt => git-ls-tree.adoc} (100%)
 rename Documentation/{git-mailinfo.txt => git-mailinfo.adoc} (97%)
 rename Documentation/{git-mailsplit.txt => git-mailsplit.adoc} (100%)
 rename Documentation/{git-maintenance.txt => git-maintenance.adoc} (99%)
 rename Documentation/{git-merge-base.txt => git-merge-base.adoc} (100%)
 rename Documentation/{git-merge-file.txt => git-merge-file.adoc} (100%)
 rename Documentation/{git-merge-index.txt => git-merge-index.adoc} (100%)
 rename Documentation/{git-merge-one-file.txt => git-merge-one-file.adoc} (100%)
 rename Documentation/{git-merge-tree.txt => git-merge-tree.adoc} (100%)
 rename Documentation/{git-merge.txt => git-merge.adoc} (98%)
 rename Documentation/{git-mergetool--lib.txt => git-mergetool--lib.adoc} (100%)
 rename Documentation/{git-mergetool.txt => git-mergetool.adoc} (97%)
 rename Documentation/{git-mktag.txt => git-mktag.adoc} (100%)
 rename Documentation/{git-mktree.txt => git-mktree.adoc} (100%)
 rename Documentation/{git-multi-pack-index.txt => git-multi-pack-index.adoc} (100%)
 rename Documentation/{git-mv.txt => git-mv.adoc} (100%)
 rename Documentation/{git-name-rev.txt => git-name-rev.adoc} (100%)
 rename Documentation/{git-notes.txt => git-notes.adoc} (99%)
 rename Documentation/{git-p4.txt => git-p4.adoc} (100%)
 rename Documentation/{git-pack-objects.txt => git-pack-objects.adoc} (100%)
 rename Documentation/{git-pack-redundant.txt => git-pack-redundant.adoc} (100%)
 rename Documentation/{git-pack-refs.txt => git-pack-refs.adoc} (100%)
 rename Documentation/{git-patch-id.txt => git-patch-id.adoc} (100%)
 rename Documentation/{git-prune-packed.txt => git-prune-packed.adoc} (100%)
 rename Documentation/{git-prune.txt => git-prune.adoc} (100%)
 rename Documentation/{git-pull.txt => git-pull.adoc} (97%)
 rename Documentation/{git-push.txt => git-push.adoc} (99%)
 rename Documentation/{git-quiltimport.txt => git-quiltimport.adoc} (100%)
 rename Documentation/{git-range-diff.txt => git-range-diff.adoc} (100%)
 rename Documentation/{git-read-tree.txt => git-read-tree.adoc} (100%)
 rename Documentation/{git-rebase.txt => git-rebase.adoc} (99%)
 rename Documentation/{git-receive-pack.txt => git-receive-pack.adoc} (100%)
 rename Documentation/{git-reflog.txt => git-reflog.adoc} (100%)
 rename Documentation/{git-refs.txt => git-refs.adoc} (98%)
 rename Documentation/{git-remote-ext.txt => git-remote-ext.adoc} (100%)
 rename Documentation/{git-remote-fd.txt => git-remote-fd.adoc} (100%)
 rename Documentation/{git-remote-helpers.txto => git-remote-helpers.adoco} (100%)
 rename Documentation/{git-remote.txt => git-remote.adoc} (100%)
 rename Documentation/{git-repack.txt => git-repack.adoc} (100%)
 rename Documentation/{git-replace.txt => git-replace.adoc} (100%)
 rename Documentation/{git-replay.txt => git-replay.adoc} (99%)
 rename Documentation/{git-request-pull.txt => git-request-pull.adoc} (100%)
 rename Documentation/{git-rerere.txt => git-rerere.adoc} (100%)
 rename Documentation/{git-reset.txt => git-reset.adoc} (100%)
 rename Documentation/{git-restore.txt => git-restore.adoc} (100%)
 rename Documentation/{git-rev-list.txt => git-rev-list.adoc} (96%)
 rename Documentation/{git-rev-parse.txt => git-rev-parse.adoc} (99%)
 rename Documentation/{git-revert.txt => git-revert.adoc} (97%)
 rename Documentation/{git-rm.txt => git-rm.adoc} (100%)
 rename Documentation/{git-send-email.txt => git-send-email.adoc} (99%)
 rename Documentation/{git-send-pack.txt => git-send-pack.adoc} (100%)
 rename Documentation/{git-sh-i18n--envsubst.txt => git-sh-i18n--envsubst.adoc} (100%)
 rename Documentation/{git-sh-i18n.txt => git-sh-i18n.adoc} (100%)
 rename Documentation/{git-sh-setup.txt => git-sh-setup.adoc} (100%)
 rename Documentation/{git-shell.txt => git-shell.adoc} (100%)
 rename Documentation/{git-shortlog.txt => git-shortlog.adoc} (99%)
 rename Documentation/{git-show-branch.txt => git-show-branch.adoc} (98%)
 rename Documentation/{git-show-index.txt => git-show-index.adoc} (97%)
 rename Documentation/{git-show-ref.txt => git-show-ref.adoc} (100%)
 rename Documentation/{git-show.txt => git-show.adoc} (92%)
 rename Documentation/{git-sparse-checkout.txt => git-sparse-checkout.adoc} (100%)
 rename Documentation/{git-stage.txt => git-stage.adoc} (100%)
 rename Documentation/{git-stash.txt => git-stash.adoc} (99%)
 rename Documentation/{git-status.txt => git-status.adoc} (100%)
 rename Documentation/{git-stripspace.txt => git-stripspace.adoc} (100%)
 rename Documentation/{git-submodule.txt => git-submodule.adoc} (100%)
 rename Documentation/{git-svn.txt => git-svn.adoc} (100%)
 rename Documentation/{git-switch.txt => git-switch.adoc} (99%)
 rename Documentation/{git-symbolic-ref.txt => git-symbolic-ref.adoc} (100%)
 rename Documentation/{git-tag.txt => git-tag.adoc} (99%)
 rename Documentation/{git-tools.txt => git-tools.adoc} (100%)
 rename Documentation/{git-unpack-file.txt => git-unpack-file.adoc} (100%)
 rename Documentation/{git-unpack-objects.txt => git-unpack-objects.adoc} (100%)
 rename Documentation/{git-update-index.txt => git-update-index.adoc} (100%)
 rename Documentation/{git-update-ref.txt => git-update-ref.adoc} (100%)
 rename Documentation/{git-update-server-info.txt => git-update-server-info.adoc} (100%)
 rename Documentation/{git-upload-archive.txt => git-upload-archive.adoc} (100%)
 rename Documentation/{git-upload-pack.txt => git-upload-pack.adoc} (100%)
 rename Documentation/{git-var.txt => git-var.adoc} (100%)
 rename Documentation/{git-verify-commit.txt => git-verify-commit.adoc} (100%)
 rename Documentation/{git-verify-pack.txt => git-verify-pack.adoc} (100%)
 rename Documentation/{git-verify-tag.txt => git-verify-tag.adoc} (100%)
 rename Documentation/{git-version.txt => git-version.adoc} (100%)
 rename Documentation/{git-web--browse.txt => git-web--browse.adoc} (100%)
 rename Documentation/{git-whatchanged.txt => git-whatchanged.adoc} (100%)
 rename Documentation/{git-worktree.txt => git-worktree.adoc} (100%)
 rename Documentation/{git-write-tree.txt => git-write-tree.adoc} (100%)
 rename Documentation/{git.txt => git.adoc} (98%)
 rename Documentation/{gitattributes.txt => gitattributes.adoc} (100%)
 rename Documentation/{gitcli.txt => gitcli.adoc} (100%)
 rename Documentation/{gitcore-tutorial.txt => gitcore-tutorial.adoc} (100%)
 rename Documentation/{gitcredentials.txt => gitcredentials.adoc} (100%)
 rename Documentation/{gitcvs-migration.txt => gitcvs-migration.adoc} (100%)
 rename Documentation/{gitdiffcore.txt => gitdiffcore.adoc} (100%)
 rename Documentation/{giteveryday.txt => giteveryday.adoc} (100%)
 rename Documentation/{gitfaq.txt => gitfaq.adoc} (100%)
 rename Documentation/{gitformat-bundle.txt => gitformat-bundle.adoc} (100%)
 rename Documentation/{gitformat-chunk.txt => gitformat-chunk.adoc} (100%)
 rename Documentation/{gitformat-commit-graph.txt => gitformat-commit-graph.adoc} (100%)
 rename Documentation/{gitformat-index.txt => gitformat-index.adoc} (100%)
 rename Documentation/{gitformat-pack.txt => gitformat-pack.adoc} (100%)
 rename Documentation/{gitformat-signature.txt => gitformat-signature.adoc} (100%)
 rename Documentation/{gitglossary.txt => gitglossary.adoc} (90%)
 rename Documentation/{githooks.txt => githooks.adoc} (100%)
 rename Documentation/{gitignore.txt => gitignore.adoc} (100%)
 rename Documentation/{gitk.txt => gitk.adoc} (99%)
 rename Documentation/{gitmailmap.txt => gitmailmap.adoc} (100%)
 rename Documentation/{gitmodules.txt => gitmodules.adoc} (100%)
 rename Documentation/{gitnamespaces.txt => gitnamespaces.adoc} (98%)
 rename Documentation/{gitpacking.txt => gitpacking.adoc} (99%)
 rename Documentation/{gitprotocol-capabilities.txt => gitprotocol-capabilities.adoc} (100%)
 rename Documentation/{gitprotocol-common.txt => gitprotocol-common.adoc} (100%)
 rename Documentation/{gitprotocol-http.txt => gitprotocol-http.adoc} (100%)
 rename Documentation/{gitprotocol-pack.txt => gitprotocol-pack.adoc} (100%)
 rename Documentation/{gitprotocol-v2.txt => gitprotocol-v2.adoc} (100%)
 rename Documentation/{gitremote-helpers.txt => gitremote-helpers.adoc} (100%)
 rename Documentation/{gitrepository-layout.txt => gitrepository-layout.adoc} (99%)
 rename Documentation/{gitrevisions.txt => gitrevisions.adoc} (96%)
 rename Documentation/{gitsubmodules.txt => gitsubmodules.adoc} (100%)
 rename Documentation/{gittutorial-2.txt => gittutorial-2.adoc} (100%)
 rename Documentation/{gittutorial.txt => gittutorial.adoc} (100%)
 rename Documentation/{gitweb.txt => gitweb.adoc} (100%)
 rename Documentation/{gitweb.conf.txt => gitweb.conf.adoc} (100%)
 rename Documentation/{gitworkflows.txt => gitworkflows.adoc} (100%)
 rename Documentation/{glossary-content.txt => glossary-content.adoc} (100%)
 rename Documentation/howto/{coordinate-embargoed-releases.txt => coordinate-embargoed-releases.adoc} (100%)
 rename Documentation/howto/{keep-canonical-history-correct.txt => keep-canonical-history-correct.adoc} (100%)
 rename Documentation/howto/{maintain-git.txt => maintain-git.adoc} (100%)
 rename Documentation/howto/{new-command.txt => new-command.adoc} (100%)
 rename Documentation/howto/{rebase-from-internal-branch.txt => rebase-from-internal-branch.adoc} (100%)
 rename Documentation/howto/{rebuild-from-update-hook.txt => rebuild-from-update-hook.adoc} (100%)
 rename Documentation/howto/{recover-corrupted-blob-object.txt => recover-corrupted-blob-object.adoc} (100%)
 rename Documentation/howto/{recover-corrupted-object-harder.txt => recover-corrupted-object-harder.adoc} (100%)
 rename Documentation/howto/{revert-a-faulty-merge.txt => revert-a-faulty-merge.adoc} (100%)
 rename Documentation/howto/{revert-branch-rebase.txt => revert-branch-rebase.adoc} (100%)
 rename Documentation/howto/{separating-topic-branches.txt => separating-topic-branches.adoc} (100%)
 rename Documentation/howto/{setup-git-server-over-http.txt => setup-git-server-over-http.adoc} (100%)
 rename Documentation/howto/{update-hook-example.txt => update-hook-example.adoc} (100%)
 rename Documentation/howto/{use-git-daemon.txt => use-git-daemon.adoc} (100%)
 rename Documentation/howto/{using-merge-subtree.txt => using-merge-subtree.adoc} (100%)
 rename Documentation/howto/{using-signed-tag-in-pull-request.txt => using-signed-tag-in-pull-request.adoc} (100%)
 rename Documentation/{i18n.txt => i18n.adoc} (100%)
 rename Documentation/includes/{cmd-config-section-all.txt => cmd-config-section-all.adoc} (100%)
 rename Documentation/includes/{cmd-config-section-rest.txt => cmd-config-section-rest.adoc} (100%)
 rename Documentation/{line-range-format.txt => line-range-format.adoc} (100%)
 rename Documentation/{line-range-options.txt => line-range-options.adoc} (95%)
 rename Documentation/{merge-options.txt => merge-options.adoc} (99%)
 rename Documentation/{merge-strategies.txt => merge-strategies.adoc} (100%)
 rename Documentation/mergetools/{vimdiff.txt => vimdiff.adoc} (100%)
 rename Documentation/{object-format-disclaimer.txt => object-format-disclaimer.adoc} (100%)
 rename Documentation/{pretty-formats.txt => pretty-formats.adoc} (100%)
 rename Documentation/{pretty-options.txt => pretty-options.adoc} (100%)
 rename Documentation/{pull-fetch-param.txt => pull-fetch-param.adoc} (100%)
 rename Documentation/{ref-reachability-filters.txt => ref-reachability-filters.adoc} (100%)
 rename Documentation/{ref-storage-format.txt => ref-storage-format.adoc} (100%)
 rename Documentation/{rerere-options.txt => rerere-options.adoc} (100%)
 rename Documentation/{rev-list-description.txt => rev-list-description.adoc} (100%)
 rename Documentation/{rev-list-options.txt => rev-list-options.adoc} (99%)
 rename Documentation/{revisions.txt => revisions.adoc} (100%)
 rename Documentation/{scalar.txt => scalar.adoc} (100%)
 rename Documentation/{sequencer.txt => sequencer.adoc} (100%)
 rename Documentation/{signoff-option.txt => signoff-option.adoc} (100%)
 rename Documentation/technical/{api-error-handling.txt => api-error-handling.adoc} (100%)
 rename Documentation/technical/{api-index-skel.txt => api-index-skel.adoc} (100%)
 rename Documentation/technical/{api-merge.txt => api-merge.adoc} (100%)
 rename Documentation/technical/{api-parse-options.txt => api-parse-options.adoc} (100%)
 rename Documentation/technical/{api-simple-ipc.txt => api-simple-ipc.adoc} (100%)
 rename Documentation/technical/{api-trace2.txt => api-trace2.adoc} (99%)
 rename Documentation/technical/{bitmap-format.txt => bitmap-format.adoc} (100%)
 rename Documentation/technical/{build-systems.txt => build-systems.adoc} (100%)
 rename Documentation/technical/{bundle-uri.txt => bundle-uri.adoc} (100%)
 rename Documentation/technical/{commit-graph.txt => commit-graph.adoc} (100%)
 rename Documentation/technical/{directory-rename-detection.txt => directory-rename-detection.adoc} (100%)
 rename Documentation/technical/{hash-function-transition.txt => hash-function-transition.adoc} (100%)
 rename Documentation/technical/{long-running-process-protocol.txt => long-running-process-protocol.adoc} (100%)
 rename Documentation/technical/{multi-pack-index.txt => multi-pack-index.adoc} (100%)
 rename Documentation/technical/{pack-heuristics.txt => pack-heuristics.adoc} (100%)
 rename Documentation/technical/{packfile-uri.txt => packfile-uri.adoc} (100%)
 rename Documentation/technical/{parallel-checkout.txt => parallel-checkout.adoc} (100%)
 rename Documentation/technical/{partial-clone.txt => partial-clone.adoc} (100%)
 rename Documentation/technical/{platform-support.txt => platform-support.adoc} (100%)
 rename Documentation/technical/{racy-git.txt => racy-git.adoc} (100%)
 rename Documentation/technical/{reftable.txt => reftable.adoc} (100%)
 rename Documentation/technical/{remembering-renames.txt => remembering-renames.adoc} (100%)
 rename Documentation/technical/{repository-version.txt => repository-version.adoc} (100%)
 rename Documentation/technical/{rerere.txt => rerere.adoc} (100%)
 rename Documentation/technical/{scalar.txt => scalar.adoc} (100%)
 rename Documentation/technical/{send-pack-pipeline.txt => send-pack-pipeline.adoc} (100%)
 rename Documentation/technical/{shallow.txt => shallow.adoc} (100%)
 rename Documentation/technical/{sparse-checkout.txt => sparse-checkout.adoc} (100%)
 rename Documentation/technical/{sparse-index.txt => sparse-index.adoc} (100%)
 rename Documentation/technical/{trivial-merge.txt => trivial-merge.adoc} (100%)
 rename Documentation/technical/{unit-tests.txt => unit-tests.adoc} (100%)
 rename Documentation/{trace2-target-values.txt => trace2-target-values.adoc} (100%)
 rename Documentation/{transfer-data-leaks.txt => transfer-data-leaks.adoc} (100%)
 rename Documentation/{urls-remotes.txt => urls-remotes.adoc} (99%)
 rename Documentation/{urls.txt => urls.adoc} (100%)
 rename Documentation/{user-manual.txt => user-manual.adoc} (99%)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.adoc
similarity index 100%
rename from Documentation/BreakingChanges.txt
rename to Documentation/BreakingChanges.adoc
diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.adoc
similarity index 100%
rename from Documentation/DecisionMaking.txt
rename to Documentation/DecisionMaking.adoc
diff --git a/Documentation/Makefile b/Documentation/Makefile
index aedfe99d1d..a734c6d624 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -17,56 +17,56 @@ OBSOLETE_HTML =
 -include GIT-EXCLUDED-PROGRAMS
 
 MAN1_TXT += $(filter-out \
-		$(patsubst %,%.txt,$(EXCLUDED_PROGRAMS)) \
-		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
-		$(wildcard git-*.txt))
-MAN1_TXT += git.txt
-MAN1_TXT += gitk.txt
-MAN1_TXT += gitweb.txt
-MAN1_TXT += scalar.txt
+		$(patsubst %,%.adoc,$(EXCLUDED_PROGRAMS)) \
+		$(addsuffix .adoc, $(ARTICLES) $(SP_ARTICLES)), \
+		$(wildcard git-*.adoc))
+MAN1_TXT += git.adoc
+MAN1_TXT += gitk.adoc
+MAN1_TXT += gitweb.adoc
+MAN1_TXT += scalar.adoc
 
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
-MAN5_TXT += gitattributes.txt
-MAN5_TXT += gitformat-bundle.txt
-MAN5_TXT += gitformat-chunk.txt
-MAN5_TXT += gitformat-commit-graph.txt
-MAN5_TXT += gitformat-index.txt
-MAN5_TXT += gitformat-pack.txt
-MAN5_TXT += gitformat-signature.txt
-MAN5_TXT += githooks.txt
-MAN5_TXT += gitignore.txt
-MAN5_TXT += gitmailmap.txt
-MAN5_TXT += gitmodules.txt
-MAN5_TXT += gitprotocol-capabilities.txt
-MAN5_TXT += gitprotocol-common.txt
-MAN5_TXT += gitprotocol-http.txt
-MAN5_TXT += gitprotocol-pack.txt
-MAN5_TXT += gitprotocol-v2.txt
-MAN5_TXT += gitrepository-layout.txt
-MAN5_TXT += gitweb.conf.txt
+MAN5_TXT += gitattributes.adoc
+MAN5_TXT += gitformat-bundle.adoc
+MAN5_TXT += gitformat-chunk.adoc
+MAN5_TXT += gitformat-commit-graph.adoc
+MAN5_TXT += gitformat-index.adoc
+MAN5_TXT += gitformat-pack.adoc
+MAN5_TXT += gitformat-signature.adoc
+MAN5_TXT += githooks.adoc
+MAN5_TXT += gitignore.adoc
+MAN5_TXT += gitmailmap.adoc
+MAN5_TXT += gitmodules.adoc
+MAN5_TXT += gitprotocol-capabilities.adoc
+MAN5_TXT += gitprotocol-common.adoc
+MAN5_TXT += gitprotocol-http.adoc
+MAN5_TXT += gitprotocol-pack.adoc
+MAN5_TXT += gitprotocol-v2.adoc
+MAN5_TXT += gitrepository-layout.adoc
+MAN5_TXT += gitweb.conf.adoc
 
-MAN7_TXT += gitcli.txt
-MAN7_TXT += gitcore-tutorial.txt
-MAN7_TXT += gitcredentials.txt
-MAN7_TXT += gitcvs-migration.txt
-MAN7_TXT += gitdiffcore.txt
-MAN7_TXT += giteveryday.txt
-MAN7_TXT += gitfaq.txt
-MAN7_TXT += gitglossary.txt
-MAN7_TXT += gitpacking.txt
-MAN7_TXT += gitnamespaces.txt
-MAN7_TXT += gitremote-helpers.txt
-MAN7_TXT += gitrevisions.txt
-MAN7_TXT += gitsubmodules.txt
-MAN7_TXT += gittutorial-2.txt
-MAN7_TXT += gittutorial.txt
-MAN7_TXT += gitworkflows.txt
+MAN7_TXT += gitcli.adoc
+MAN7_TXT += gitcore-tutorial.adoc
+MAN7_TXT += gitcredentials.adoc
+MAN7_TXT += gitcvs-migration.adoc
+MAN7_TXT += gitdiffcore.adoc
+MAN7_TXT += giteveryday.adoc
+MAN7_TXT += gitfaq.adoc
+MAN7_TXT += gitglossary.adoc
+MAN7_TXT += gitpacking.adoc
+MAN7_TXT += gitnamespaces.adoc
+MAN7_TXT += gitremote-helpers.adoc
+MAN7_TXT += gitrevisions.adoc
+MAN7_TXT += gitsubmodules.adoc
+MAN7_TXT += gittutorial-2.adoc
+MAN7_TXT += gittutorial.adoc
+MAN7_TXT += gitworkflows.adoc
 
-HOWTO_TXT += $(wildcard howto/*.txt)
+HOWTO_TXT += $(wildcard howto/*.adoc)
 
-DOC_DEP_TXT += $(wildcard *.txt)
-DOC_DEP_TXT += $(wildcard config/*.txt)
-DOC_DEP_TXT += $(wildcard includes/*.txt)
+DOC_DEP_TXT += $(wildcard *.adoc)
+DOC_DEP_TXT += $(wildcard config/*.adoc)
+DOC_DEP_TXT += $(wildcard includes/*.adoc)
 
 ifdef MAN_FILTER
 MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
@@ -75,8 +75,8 @@ MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_FILTER = $(MAN_TXT)
 endif
 
-MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
-MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
+MAN_XML = $(patsubst %.adoc,%.xml,$(MAN_TXT))
+MAN_HTML = $(patsubst %.adoc,%.html,$(MAN_TXT))
 GIT_MAN_REF = master
 
 OBSOLETE_HTML += everyday.html
@@ -103,7 +103,7 @@ SP_ARTICLES += howto/rebase-from-internal-branch
 SP_ARTICLES += howto/keep-canonical-history-correct
 SP_ARTICLES += howto/maintain-git
 SP_ARTICLES += howto/coordinate-embargoed-releases
-API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
+API_DOCS = $(patsubst %.adoc,%,$(filter-out technical/api-index-skel.adoc technical/api-index.adoc, $(wildcard technical/api-*.adoc)))
 SP_ARTICLES += $(API_DOCS)
 
 TECH_DOCS += DecisionMaking
@@ -136,9 +136,9 @@ ARTICLES_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
 HTML_FILTER ?= $(ARTICLES_HTML) $(OBSOLETE_HTML)
 DOC_HTML = $(MAN_HTML) $(filter $(HTML_FILTER),$(ARTICLES_HTML) $(OBSOLETE_HTML))
 
-DOC_MAN1 = $(patsubst %.txt,%.1,$(filter $(MAN_FILTER),$(MAN1_TXT)))
-DOC_MAN5 = $(patsubst %.txt,%.5,$(filter $(MAN_FILTER),$(MAN5_TXT)))
-DOC_MAN7 = $(patsubst %.txt,%.7,$(filter $(MAN_FILTER),$(MAN7_TXT)))
+DOC_MAN1 = $(patsubst %.adoc,%.1,$(filter $(MAN_FILTER),$(MAN1_TXT)))
+DOC_MAN5 = $(patsubst %.adoc,%.5,$(filter $(MAN_FILTER),$(MAN5_TXT)))
+DOC_MAN7 = $(patsubst %.adoc,%.7,$(filter $(MAN_FILTER),$(MAN7_TXT)))
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
@@ -278,7 +278,7 @@ install-pdf: pdf
 install-html: html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
-mergetools_txt = mergetools-diff.txt mergetools-merge.txt
+mergetools_txt = mergetools-diff.adoc mergetools-merge.adoc
 
 #
 # Determine "include::" file references in asciidoc files.
@@ -294,18 +294,18 @@ ifneq ($(MAKECMDGOALS),clean)
 -include doc.dep
 endif
 
-cmds_txt = cmds-ancillaryinterrogators.txt \
-	cmds-ancillarymanipulators.txt \
-	cmds-mainporcelain.txt \
-	cmds-plumbinginterrogators.txt \
-	cmds-plumbingmanipulators.txt \
-	cmds-synchingrepositories.txt \
-	cmds-synchelpers.txt \
-	cmds-guide.txt \
-	cmds-developerinterfaces.txt \
-	cmds-userinterfaces.txt \
-	cmds-purehelpers.txt \
-	cmds-foreignscminterface.txt
+cmds_txt = cmds-ancillaryinterrogators.adoc \
+	cmds-ancillarymanipulators.adoc \
+	cmds-mainporcelain.adoc \
+	cmds-plumbinginterrogators.adoc \
+	cmds-plumbingmanipulators.adoc \
+	cmds-synchingrepositories.adoc \
+	cmds-synchelpers.adoc \
+	cmds-guide.adoc \
+	cmds-developerinterfaces.adoc \
+	cmds-userinterfaces.adoc \
+	cmds-purehelpers.adoc \
+	cmds-foreignscminterface.adoc
 
 $(cmds_txt): cmd-list.made
 
@@ -313,10 +313,10 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 	$(QUIET_GEN)$(PERL_PATH) ./cmd-list.perl .. . $(cmds_txt) && \
 	date >$@
 
-mergetools-%.txt: generate-mergetool-list.sh ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
-mergetools-diff.txt:
+mergetools-%.adoc: generate-mergetool-list.sh ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
+mergetools-diff.adoc:
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-mergetool-list.sh .. diff $@
-mergetools-merge.txt:
+mergetools-merge.adoc:
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-mergetool-list.sh .. merge $@
 
 TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
@@ -333,9 +333,9 @@ clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) *.pdf
-	$(RM) howto-index.txt howto/*.html doc.dep
-	$(RM) technical/*.html technical/api-index.txt
-	$(RM) SubmittingPatches.txt
+	$(RM) howto-index.adoc howto/*.html doc.dep
+	$(RM) technical/*.html technical/api-index.adoc
+	$(RM) SubmittingPatches.adoc
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) GIT-ASCIIDOCFLAGS
 	$(RM) asciidoc.conf asciidoctor-extensions.rb
@@ -344,10 +344,10 @@ clean:
 docinfo.html: docinfo-html.in
 	$(QUIET_GEN)$(RM) $@ && cat $< >$@
 
-$(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
+$(MAN_HTML): %.html : %.adoc $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@ $<
 
-$(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
+$(OBSOLETE_HTML): %.html : %.adoco $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -o $@ $<
 
 manpage-prereqs := $(wildcard manpage*.xsl)
@@ -360,22 +360,22 @@ manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 %.7 : %.xml $(manpage-prereqs)
 	$(manpage-cmd)
 
-%.xml : %.txt $(ASCIIDOC_DEPS)
+%.xml : %.adoc $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
 
-user-manual.xml: user-manual.txt $(ASCIIDOC_DEPS)
+user-manual.xml: user-manual.adoc $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
 
-technical/api-index.txt: technical/api-index-skel.txt \
-	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
-	$(QUIET_GEN)'$(SHELL_PATH_SQ)' technical/api-index.sh ./technical ./technical/api-index.txt
+technical/api-index.adoc: technical/api-index-skel.adoc \
+	technical/api-index.sh $(patsubst %,%.adoc,$(API_DOCS))
+	$(QUIET_GEN)'$(SHELL_PATH_SQ)' technical/api-index.sh ./technical ./technical/api-index.adoc
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
+$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.adoc \
 	$(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.adoc
 
-SubmittingPatches.txt: SubmittingPatches
+SubmittingPatches.adoc: SubmittingPatches
 	$(QUIET_GEN) cp $< $@
 
 XSLT = docbook.xsl
@@ -409,19 +409,19 @@ gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
 gitman.info: gitman.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $<
 
-$(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
+$(patsubst %.adoc,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@
 
-howto-index.txt: howto/howto-index.sh $(HOWTO_TXT)
+howto-index.adoc: howto/howto-index.sh $(HOWTO_TXT)
 	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto/howto-index.sh $(sort $(HOWTO_TXT)) >$@
 
-$(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt $(ASCIIDOC_DEPS)
-	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
+$(patsubst %,%.html,$(ARTICLES)) : %.html : %.adoc $(ASCIIDOC_DEPS)
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.adoc
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt $(ASCIIDOC_DEPS)
+$(patsubst %.adoc,%.html,$(HOWTO_TXT)): %.html : %.adoc $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC) \
 	sed -e '1,/^$$/d' $< | \
 	$(TXT_TO_HTML) - >$@
@@ -452,9 +452,9 @@ print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
 
 ## Lint: gitlink
-LINT_DOCS_GITLINK = $(patsubst %.txt,.build/lint-docs/gitlink/%.ok,$(HOWTO_TXT) $(DOC_DEP_TXT))
+LINT_DOCS_GITLINK = $(patsubst %.adoc,.build/lint-docs/gitlink/%.ok,$(HOWTO_TXT) $(DOC_DEP_TXT))
 $(LINT_DOCS_GITLINK): lint-gitlink.perl
-$(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
+$(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.adoc
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINT_GITLINK)$(PERL_PATH) lint-gitlink.perl \
 		$< \
@@ -466,17 +466,17 @@ $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
 lint-docs-gitlink: $(LINT_DOCS_GITLINK)
 
 ## Lint: man-end-blurb
-LINT_DOCS_MAN_END_BLURB = $(patsubst %.txt,.build/lint-docs/man-end-blurb/%.ok,$(MAN_TXT))
+LINT_DOCS_MAN_END_BLURB = $(patsubst %.adoc,.build/lint-docs/man-end-blurb/%.ok,$(MAN_TXT))
 $(LINT_DOCS_MAN_END_BLURB): lint-man-end-blurb.perl
-$(LINT_DOCS_MAN_END_BLURB): .build/lint-docs/man-end-blurb/%.ok: %.txt
+$(LINT_DOCS_MAN_END_BLURB): .build/lint-docs/man-end-blurb/%.ok: %.adoc
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINT_MANEND)$(PERL_PATH) lint-man-end-blurb.perl $< >$@
 .PHONY: lint-docs-man-end-blurb
 
 ## Lint: man-section-order
-LINT_DOCS_MAN_SECTION_ORDER = $(patsubst %.txt,.build/lint-docs/man-section-order/%.ok,$(MAN_TXT))
+LINT_DOCS_MAN_SECTION_ORDER = $(patsubst %.adoc,.build/lint-docs/man-section-order/%.ok,$(MAN_TXT))
 $(LINT_DOCS_MAN_SECTION_ORDER): lint-man-section-order.perl
-$(LINT_DOCS_MAN_SECTION_ORDER): .build/lint-docs/man-section-order/%.ok: %.txt
+$(LINT_DOCS_MAN_SECTION_ORDER): .build/lint-docs/man-section-order/%.ok: %.adoc
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINT_MANSEC)$(PERL_PATH) lint-man-section-order.perl $< >$@
 .PHONY: lint-docs-man-section-order
@@ -485,10 +485,10 @@ lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)
 .PHONY: lint-docs-fsck-msgids
 LINT_DOCS_FSCK_MSGIDS = .build/lint-docs/fsck-msgids.ok
 $(LINT_DOCS_FSCK_MSGIDS): lint-fsck-msgids.perl
-$(LINT_DOCS_FSCK_MSGIDS): ../fsck.h fsck-msgids.txt
+$(LINT_DOCS_FSCK_MSGIDS): ../fsck.h fsck-msgids.adoc
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)$(PERL_PATH) lint-fsck-msgids.perl \
-		../fsck.h fsck-msgids.txt $@
+		../fsck.h fsck-msgids.adoc $@
 
 lint-docs-fsck-msgids: $(LINT_DOCS_FSCK_MSGIDS)
 
@@ -501,11 +501,11 @@ lint-docs-meson:
 	@mkdir -p tmp-meson-diff && \
 	awk "/^manpages = {$$/ {flag=1 ; next } /^}$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047 : [157],\$$/, \"\"); print }" meson.build | \
 		grep -v -e '#' -e '^$$' | \
-		sort >tmp-meson-diff/meson.txt && \
-	ls git*.txt scalar.txt | grep -v -e git-bisect-lk2009.txt -e git-tools.txt >tmp-meson-diff/actual.txt && \
-	if ! cmp tmp-meson-diff/meson.txt tmp-meson-diff/actual.txt; then \
+		sort >tmp-meson-diff/meson.adoc && \
+	ls git*.adoc scalar.adoc | grep -v -e git-bisect-lk2009.adoc -e git-tools.adoc >tmp-meson-diff/actual.adoc && \
+	if ! cmp tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; then \
 		echo "Meson man pages differ from actual man pages:"; \
-		diff -u tmp-meson-diff/meson.txt tmp-meson-diff/actual.txt; \
+		diff -u tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; \
 		exit 1; \
 	fi
 
diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.adoc
similarity index 100%
rename from Documentation/MyFirstContribution.txt
rename to Documentation/MyFirstContribution.adoc
diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.adoc
similarity index 100%
rename from Documentation/MyFirstObjectWalk.txt
rename to Documentation/MyFirstObjectWalk.adoc
diff --git a/Documentation/RelNotes/1.5.0.1.txt b/Documentation/RelNotes/1.5.0.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.0.1.txt
rename to Documentation/RelNotes/1.5.0.1.adoc
diff --git a/Documentation/RelNotes/1.5.0.2.txt b/Documentation/RelNotes/1.5.0.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.0.2.txt
rename to Documentation/RelNotes/1.5.0.2.adoc
diff --git a/Documentation/RelNotes/1.5.0.3.txt b/Documentation/RelNotes/1.5.0.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.0.3.txt
rename to Documentation/RelNotes/1.5.0.3.adoc
diff --git a/Documentation/RelNotes/1.5.0.4.txt b/Documentation/RelNotes/1.5.0.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.0.4.txt
rename to Documentation/RelNotes/1.5.0.4.adoc
diff --git a/Documentation/RelNotes/1.5.0.5.txt b/Documentation/RelNotes/1.5.0.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.0.5.txt
rename to Documentation/RelNotes/1.5.0.5.adoc
diff --git a/Documentation/RelNotes/1.5.0.6.txt b/Documentation/RelNotes/1.5.0.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.0.6.txt
rename to Documentation/RelNotes/1.5.0.6.adoc
diff --git a/Documentation/RelNotes/1.5.0.7.txt b/Documentation/RelNotes/1.5.0.7.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.0.7.txt
rename to Documentation/RelNotes/1.5.0.7.adoc
diff --git a/Documentation/RelNotes/1.5.0.txt b/Documentation/RelNotes/1.5.0.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.0.txt
rename to Documentation/RelNotes/1.5.0.adoc
diff --git a/Documentation/RelNotes/1.5.1.1.txt b/Documentation/RelNotes/1.5.1.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.1.1.txt
rename to Documentation/RelNotes/1.5.1.1.adoc
diff --git a/Documentation/RelNotes/1.5.1.2.txt b/Documentation/RelNotes/1.5.1.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.1.2.txt
rename to Documentation/RelNotes/1.5.1.2.adoc
diff --git a/Documentation/RelNotes/1.5.1.3.txt b/Documentation/RelNotes/1.5.1.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.1.3.txt
rename to Documentation/RelNotes/1.5.1.3.adoc
diff --git a/Documentation/RelNotes/1.5.1.4.txt b/Documentation/RelNotes/1.5.1.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.1.4.txt
rename to Documentation/RelNotes/1.5.1.4.adoc
diff --git a/Documentation/RelNotes/1.5.1.5.txt b/Documentation/RelNotes/1.5.1.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.1.5.txt
rename to Documentation/RelNotes/1.5.1.5.adoc
diff --git a/Documentation/RelNotes/1.5.1.6.txt b/Documentation/RelNotes/1.5.1.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.1.6.txt
rename to Documentation/RelNotes/1.5.1.6.adoc
diff --git a/Documentation/RelNotes/1.5.1.txt b/Documentation/RelNotes/1.5.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.1.txt
rename to Documentation/RelNotes/1.5.1.adoc
diff --git a/Documentation/RelNotes/1.5.2.1.txt b/Documentation/RelNotes/1.5.2.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.2.1.txt
rename to Documentation/RelNotes/1.5.2.1.adoc
diff --git a/Documentation/RelNotes/1.5.2.2.txt b/Documentation/RelNotes/1.5.2.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.2.2.txt
rename to Documentation/RelNotes/1.5.2.2.adoc
diff --git a/Documentation/RelNotes/1.5.2.3.txt b/Documentation/RelNotes/1.5.2.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.2.3.txt
rename to Documentation/RelNotes/1.5.2.3.adoc
diff --git a/Documentation/RelNotes/1.5.2.4.txt b/Documentation/RelNotes/1.5.2.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.2.4.txt
rename to Documentation/RelNotes/1.5.2.4.adoc
diff --git a/Documentation/RelNotes/1.5.2.5.txt b/Documentation/RelNotes/1.5.2.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.2.5.txt
rename to Documentation/RelNotes/1.5.2.5.adoc
diff --git a/Documentation/RelNotes/1.5.2.txt b/Documentation/RelNotes/1.5.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.2.txt
rename to Documentation/RelNotes/1.5.2.adoc
diff --git a/Documentation/RelNotes/1.5.3.1.txt b/Documentation/RelNotes/1.5.3.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.3.1.txt
rename to Documentation/RelNotes/1.5.3.1.adoc
diff --git a/Documentation/RelNotes/1.5.3.2.txt b/Documentation/RelNotes/1.5.3.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.3.2.txt
rename to Documentation/RelNotes/1.5.3.2.adoc
diff --git a/Documentation/RelNotes/1.5.3.3.txt b/Documentation/RelNotes/1.5.3.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.3.3.txt
rename to Documentation/RelNotes/1.5.3.3.adoc
diff --git a/Documentation/RelNotes/1.5.3.4.txt b/Documentation/RelNotes/1.5.3.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.3.4.txt
rename to Documentation/RelNotes/1.5.3.4.adoc
diff --git a/Documentation/RelNotes/1.5.3.5.txt b/Documentation/RelNotes/1.5.3.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.3.5.txt
rename to Documentation/RelNotes/1.5.3.5.adoc
diff --git a/Documentation/RelNotes/1.5.3.6.txt b/Documentation/RelNotes/1.5.3.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.3.6.txt
rename to Documentation/RelNotes/1.5.3.6.adoc
diff --git a/Documentation/RelNotes/1.5.3.7.txt b/Documentation/RelNotes/1.5.3.7.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.3.7.txt
rename to Documentation/RelNotes/1.5.3.7.adoc
diff --git a/Documentation/RelNotes/1.5.3.8.txt b/Documentation/RelNotes/1.5.3.8.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.3.8.txt
rename to Documentation/RelNotes/1.5.3.8.adoc
diff --git a/Documentation/RelNotes/1.5.3.txt b/Documentation/RelNotes/1.5.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.3.txt
rename to Documentation/RelNotes/1.5.3.adoc
diff --git a/Documentation/RelNotes/1.5.4.1.txt b/Documentation/RelNotes/1.5.4.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.4.1.txt
rename to Documentation/RelNotes/1.5.4.1.adoc
diff --git a/Documentation/RelNotes/1.5.4.2.txt b/Documentation/RelNotes/1.5.4.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.4.2.txt
rename to Documentation/RelNotes/1.5.4.2.adoc
diff --git a/Documentation/RelNotes/1.5.4.3.txt b/Documentation/RelNotes/1.5.4.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.4.3.txt
rename to Documentation/RelNotes/1.5.4.3.adoc
diff --git a/Documentation/RelNotes/1.5.4.4.txt b/Documentation/RelNotes/1.5.4.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.4.4.txt
rename to Documentation/RelNotes/1.5.4.4.adoc
diff --git a/Documentation/RelNotes/1.5.4.5.txt b/Documentation/RelNotes/1.5.4.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.4.5.txt
rename to Documentation/RelNotes/1.5.4.5.adoc
diff --git a/Documentation/RelNotes/1.5.4.6.txt b/Documentation/RelNotes/1.5.4.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.4.6.txt
rename to Documentation/RelNotes/1.5.4.6.adoc
diff --git a/Documentation/RelNotes/1.5.4.7.txt b/Documentation/RelNotes/1.5.4.7.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.4.7.txt
rename to Documentation/RelNotes/1.5.4.7.adoc
diff --git a/Documentation/RelNotes/1.5.4.txt b/Documentation/RelNotes/1.5.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.4.txt
rename to Documentation/RelNotes/1.5.4.adoc
diff --git a/Documentation/RelNotes/1.5.5.1.txt b/Documentation/RelNotes/1.5.5.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.5.1.txt
rename to Documentation/RelNotes/1.5.5.1.adoc
diff --git a/Documentation/RelNotes/1.5.5.2.txt b/Documentation/RelNotes/1.5.5.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.5.2.txt
rename to Documentation/RelNotes/1.5.5.2.adoc
diff --git a/Documentation/RelNotes/1.5.5.3.txt b/Documentation/RelNotes/1.5.5.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.5.3.txt
rename to Documentation/RelNotes/1.5.5.3.adoc
diff --git a/Documentation/RelNotes/1.5.5.4.txt b/Documentation/RelNotes/1.5.5.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.5.4.txt
rename to Documentation/RelNotes/1.5.5.4.adoc
diff --git a/Documentation/RelNotes/1.5.5.5.txt b/Documentation/RelNotes/1.5.5.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.5.5.txt
rename to Documentation/RelNotes/1.5.5.5.adoc
diff --git a/Documentation/RelNotes/1.5.5.6.txt b/Documentation/RelNotes/1.5.5.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.5.6.txt
rename to Documentation/RelNotes/1.5.5.6.adoc
diff --git a/Documentation/RelNotes/1.5.5.txt b/Documentation/RelNotes/1.5.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.5.txt
rename to Documentation/RelNotes/1.5.5.adoc
diff --git a/Documentation/RelNotes/1.5.6.1.txt b/Documentation/RelNotes/1.5.6.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.6.1.txt
rename to Documentation/RelNotes/1.5.6.1.adoc
diff --git a/Documentation/RelNotes/1.5.6.2.txt b/Documentation/RelNotes/1.5.6.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.6.2.txt
rename to Documentation/RelNotes/1.5.6.2.adoc
diff --git a/Documentation/RelNotes/1.5.6.3.txt b/Documentation/RelNotes/1.5.6.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.6.3.txt
rename to Documentation/RelNotes/1.5.6.3.adoc
diff --git a/Documentation/RelNotes/1.5.6.4.txt b/Documentation/RelNotes/1.5.6.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.6.4.txt
rename to Documentation/RelNotes/1.5.6.4.adoc
diff --git a/Documentation/RelNotes/1.5.6.5.txt b/Documentation/RelNotes/1.5.6.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.6.5.txt
rename to Documentation/RelNotes/1.5.6.5.adoc
diff --git a/Documentation/RelNotes/1.5.6.6.txt b/Documentation/RelNotes/1.5.6.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.6.6.txt
rename to Documentation/RelNotes/1.5.6.6.adoc
diff --git a/Documentation/RelNotes/1.5.6.txt b/Documentation/RelNotes/1.5.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.5.6.txt
rename to Documentation/RelNotes/1.5.6.adoc
diff --git a/Documentation/RelNotes/1.6.0.1.txt b/Documentation/RelNotes/1.6.0.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.0.1.txt
rename to Documentation/RelNotes/1.6.0.1.adoc
diff --git a/Documentation/RelNotes/1.6.0.2.txt b/Documentation/RelNotes/1.6.0.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.0.2.txt
rename to Documentation/RelNotes/1.6.0.2.adoc
diff --git a/Documentation/RelNotes/1.6.0.3.txt b/Documentation/RelNotes/1.6.0.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.0.3.txt
rename to Documentation/RelNotes/1.6.0.3.adoc
diff --git a/Documentation/RelNotes/1.6.0.4.txt b/Documentation/RelNotes/1.6.0.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.0.4.txt
rename to Documentation/RelNotes/1.6.0.4.adoc
diff --git a/Documentation/RelNotes/1.6.0.5.txt b/Documentation/RelNotes/1.6.0.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.0.5.txt
rename to Documentation/RelNotes/1.6.0.5.adoc
diff --git a/Documentation/RelNotes/1.6.0.6.txt b/Documentation/RelNotes/1.6.0.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.0.6.txt
rename to Documentation/RelNotes/1.6.0.6.adoc
diff --git a/Documentation/RelNotes/1.6.0.txt b/Documentation/RelNotes/1.6.0.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.0.txt
rename to Documentation/RelNotes/1.6.0.adoc
diff --git a/Documentation/RelNotes/1.6.1.1.txt b/Documentation/RelNotes/1.6.1.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.1.1.txt
rename to Documentation/RelNotes/1.6.1.1.adoc
diff --git a/Documentation/RelNotes/1.6.1.2.txt b/Documentation/RelNotes/1.6.1.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.1.2.txt
rename to Documentation/RelNotes/1.6.1.2.adoc
diff --git a/Documentation/RelNotes/1.6.1.3.txt b/Documentation/RelNotes/1.6.1.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.1.3.txt
rename to Documentation/RelNotes/1.6.1.3.adoc
diff --git a/Documentation/RelNotes/1.6.1.4.txt b/Documentation/RelNotes/1.6.1.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.1.4.txt
rename to Documentation/RelNotes/1.6.1.4.adoc
diff --git a/Documentation/RelNotes/1.6.1.txt b/Documentation/RelNotes/1.6.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.1.txt
rename to Documentation/RelNotes/1.6.1.adoc
diff --git a/Documentation/RelNotes/1.6.2.1.txt b/Documentation/RelNotes/1.6.2.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.2.1.txt
rename to Documentation/RelNotes/1.6.2.1.adoc
diff --git a/Documentation/RelNotes/1.6.2.2.txt b/Documentation/RelNotes/1.6.2.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.2.2.txt
rename to Documentation/RelNotes/1.6.2.2.adoc
diff --git a/Documentation/RelNotes/1.6.2.3.txt b/Documentation/RelNotes/1.6.2.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.2.3.txt
rename to Documentation/RelNotes/1.6.2.3.adoc
diff --git a/Documentation/RelNotes/1.6.2.4.txt b/Documentation/RelNotes/1.6.2.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.2.4.txt
rename to Documentation/RelNotes/1.6.2.4.adoc
diff --git a/Documentation/RelNotes/1.6.2.5.txt b/Documentation/RelNotes/1.6.2.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.2.5.txt
rename to Documentation/RelNotes/1.6.2.5.adoc
diff --git a/Documentation/RelNotes/1.6.2.txt b/Documentation/RelNotes/1.6.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.2.txt
rename to Documentation/RelNotes/1.6.2.adoc
diff --git a/Documentation/RelNotes/1.6.3.1.txt b/Documentation/RelNotes/1.6.3.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.3.1.txt
rename to Documentation/RelNotes/1.6.3.1.adoc
diff --git a/Documentation/RelNotes/1.6.3.2.txt b/Documentation/RelNotes/1.6.3.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.3.2.txt
rename to Documentation/RelNotes/1.6.3.2.adoc
diff --git a/Documentation/RelNotes/1.6.3.3.txt b/Documentation/RelNotes/1.6.3.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.3.3.txt
rename to Documentation/RelNotes/1.6.3.3.adoc
diff --git a/Documentation/RelNotes/1.6.3.4.txt b/Documentation/RelNotes/1.6.3.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.3.4.txt
rename to Documentation/RelNotes/1.6.3.4.adoc
diff --git a/Documentation/RelNotes/1.6.3.txt b/Documentation/RelNotes/1.6.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.3.txt
rename to Documentation/RelNotes/1.6.3.adoc
diff --git a/Documentation/RelNotes/1.6.4.1.txt b/Documentation/RelNotes/1.6.4.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.4.1.txt
rename to Documentation/RelNotes/1.6.4.1.adoc
diff --git a/Documentation/RelNotes/1.6.4.2.txt b/Documentation/RelNotes/1.6.4.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.4.2.txt
rename to Documentation/RelNotes/1.6.4.2.adoc
diff --git a/Documentation/RelNotes/1.6.4.3.txt b/Documentation/RelNotes/1.6.4.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.4.3.txt
rename to Documentation/RelNotes/1.6.4.3.adoc
diff --git a/Documentation/RelNotes/1.6.4.4.txt b/Documentation/RelNotes/1.6.4.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.4.4.txt
rename to Documentation/RelNotes/1.6.4.4.adoc
diff --git a/Documentation/RelNotes/1.6.4.5.txt b/Documentation/RelNotes/1.6.4.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.4.5.txt
rename to Documentation/RelNotes/1.6.4.5.adoc
diff --git a/Documentation/RelNotes/1.6.4.txt b/Documentation/RelNotes/1.6.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.4.txt
rename to Documentation/RelNotes/1.6.4.adoc
diff --git a/Documentation/RelNotes/1.6.5.1.txt b/Documentation/RelNotes/1.6.5.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.1.txt
rename to Documentation/RelNotes/1.6.5.1.adoc
diff --git a/Documentation/RelNotes/1.6.5.2.txt b/Documentation/RelNotes/1.6.5.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.2.txt
rename to Documentation/RelNotes/1.6.5.2.adoc
diff --git a/Documentation/RelNotes/1.6.5.3.txt b/Documentation/RelNotes/1.6.5.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.3.txt
rename to Documentation/RelNotes/1.6.5.3.adoc
diff --git a/Documentation/RelNotes/1.6.5.4.txt b/Documentation/RelNotes/1.6.5.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.4.txt
rename to Documentation/RelNotes/1.6.5.4.adoc
diff --git a/Documentation/RelNotes/1.6.5.5.txt b/Documentation/RelNotes/1.6.5.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.5.txt
rename to Documentation/RelNotes/1.6.5.5.adoc
diff --git a/Documentation/RelNotes/1.6.5.6.txt b/Documentation/RelNotes/1.6.5.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.6.txt
rename to Documentation/RelNotes/1.6.5.6.adoc
diff --git a/Documentation/RelNotes/1.6.5.7.txt b/Documentation/RelNotes/1.6.5.7.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.7.txt
rename to Documentation/RelNotes/1.6.5.7.adoc
diff --git a/Documentation/RelNotes/1.6.5.8.txt b/Documentation/RelNotes/1.6.5.8.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.8.txt
rename to Documentation/RelNotes/1.6.5.8.adoc
diff --git a/Documentation/RelNotes/1.6.5.9.txt b/Documentation/RelNotes/1.6.5.9.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.9.txt
rename to Documentation/RelNotes/1.6.5.9.adoc
diff --git a/Documentation/RelNotes/1.6.5.txt b/Documentation/RelNotes/1.6.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.5.txt
rename to Documentation/RelNotes/1.6.5.adoc
diff --git a/Documentation/RelNotes/1.6.6.1.txt b/Documentation/RelNotes/1.6.6.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.6.1.txt
rename to Documentation/RelNotes/1.6.6.1.adoc
diff --git a/Documentation/RelNotes/1.6.6.2.txt b/Documentation/RelNotes/1.6.6.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.6.2.txt
rename to Documentation/RelNotes/1.6.6.2.adoc
diff --git a/Documentation/RelNotes/1.6.6.3.txt b/Documentation/RelNotes/1.6.6.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.6.3.txt
rename to Documentation/RelNotes/1.6.6.3.adoc
diff --git a/Documentation/RelNotes/1.6.6.txt b/Documentation/RelNotes/1.6.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.6.6.txt
rename to Documentation/RelNotes/1.6.6.adoc
diff --git a/Documentation/RelNotes/1.7.0.1.txt b/Documentation/RelNotes/1.7.0.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.1.txt
rename to Documentation/RelNotes/1.7.0.1.adoc
diff --git a/Documentation/RelNotes/1.7.0.2.txt b/Documentation/RelNotes/1.7.0.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.2.txt
rename to Documentation/RelNotes/1.7.0.2.adoc
diff --git a/Documentation/RelNotes/1.7.0.3.txt b/Documentation/RelNotes/1.7.0.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.3.txt
rename to Documentation/RelNotes/1.7.0.3.adoc
diff --git a/Documentation/RelNotes/1.7.0.4.txt b/Documentation/RelNotes/1.7.0.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.4.txt
rename to Documentation/RelNotes/1.7.0.4.adoc
diff --git a/Documentation/RelNotes/1.7.0.5.txt b/Documentation/RelNotes/1.7.0.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.5.txt
rename to Documentation/RelNotes/1.7.0.5.adoc
diff --git a/Documentation/RelNotes/1.7.0.6.txt b/Documentation/RelNotes/1.7.0.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.6.txt
rename to Documentation/RelNotes/1.7.0.6.adoc
diff --git a/Documentation/RelNotes/1.7.0.7.txt b/Documentation/RelNotes/1.7.0.7.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.7.txt
rename to Documentation/RelNotes/1.7.0.7.adoc
diff --git a/Documentation/RelNotes/1.7.0.8.txt b/Documentation/RelNotes/1.7.0.8.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.8.txt
rename to Documentation/RelNotes/1.7.0.8.adoc
diff --git a/Documentation/RelNotes/1.7.0.9.txt b/Documentation/RelNotes/1.7.0.9.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.9.txt
rename to Documentation/RelNotes/1.7.0.9.adoc
diff --git a/Documentation/RelNotes/1.7.0.txt b/Documentation/RelNotes/1.7.0.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.0.txt
rename to Documentation/RelNotes/1.7.0.adoc
diff --git a/Documentation/RelNotes/1.7.1.1.txt b/Documentation/RelNotes/1.7.1.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.1.1.txt
rename to Documentation/RelNotes/1.7.1.1.adoc
diff --git a/Documentation/RelNotes/1.7.1.2.txt b/Documentation/RelNotes/1.7.1.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.1.2.txt
rename to Documentation/RelNotes/1.7.1.2.adoc
diff --git a/Documentation/RelNotes/1.7.1.3.txt b/Documentation/RelNotes/1.7.1.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.1.3.txt
rename to Documentation/RelNotes/1.7.1.3.adoc
diff --git a/Documentation/RelNotes/1.7.1.4.txt b/Documentation/RelNotes/1.7.1.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.1.4.txt
rename to Documentation/RelNotes/1.7.1.4.adoc
diff --git a/Documentation/RelNotes/1.7.1.txt b/Documentation/RelNotes/1.7.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.1.txt
rename to Documentation/RelNotes/1.7.1.adoc
diff --git a/Documentation/RelNotes/1.7.10.1.txt b/Documentation/RelNotes/1.7.10.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.10.1.txt
rename to Documentation/RelNotes/1.7.10.1.adoc
diff --git a/Documentation/RelNotes/1.7.10.2.txt b/Documentation/RelNotes/1.7.10.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.10.2.txt
rename to Documentation/RelNotes/1.7.10.2.adoc
diff --git a/Documentation/RelNotes/1.7.10.3.txt b/Documentation/RelNotes/1.7.10.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.10.3.txt
rename to Documentation/RelNotes/1.7.10.3.adoc
diff --git a/Documentation/RelNotes/1.7.10.4.txt b/Documentation/RelNotes/1.7.10.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.10.4.txt
rename to Documentation/RelNotes/1.7.10.4.adoc
diff --git a/Documentation/RelNotes/1.7.10.5.txt b/Documentation/RelNotes/1.7.10.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.10.5.txt
rename to Documentation/RelNotes/1.7.10.5.adoc
diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.10.txt
rename to Documentation/RelNotes/1.7.10.adoc
diff --git a/Documentation/RelNotes/1.7.11.1.txt b/Documentation/RelNotes/1.7.11.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.11.1.txt
rename to Documentation/RelNotes/1.7.11.1.adoc
diff --git a/Documentation/RelNotes/1.7.11.2.txt b/Documentation/RelNotes/1.7.11.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.11.2.txt
rename to Documentation/RelNotes/1.7.11.2.adoc
diff --git a/Documentation/RelNotes/1.7.11.3.txt b/Documentation/RelNotes/1.7.11.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.11.3.txt
rename to Documentation/RelNotes/1.7.11.3.adoc
diff --git a/Documentation/RelNotes/1.7.11.4.txt b/Documentation/RelNotes/1.7.11.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.11.4.txt
rename to Documentation/RelNotes/1.7.11.4.adoc
diff --git a/Documentation/RelNotes/1.7.11.5.txt b/Documentation/RelNotes/1.7.11.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.11.5.txt
rename to Documentation/RelNotes/1.7.11.5.adoc
diff --git a/Documentation/RelNotes/1.7.11.6.txt b/Documentation/RelNotes/1.7.11.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.11.6.txt
rename to Documentation/RelNotes/1.7.11.6.adoc
diff --git a/Documentation/RelNotes/1.7.11.7.txt b/Documentation/RelNotes/1.7.11.7.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.11.7.txt
rename to Documentation/RelNotes/1.7.11.7.adoc
diff --git a/Documentation/RelNotes/1.7.11.txt b/Documentation/RelNotes/1.7.11.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.11.txt
rename to Documentation/RelNotes/1.7.11.adoc
diff --git a/Documentation/RelNotes/1.7.12.1.txt b/Documentation/RelNotes/1.7.12.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.12.1.txt
rename to Documentation/RelNotes/1.7.12.1.adoc
diff --git a/Documentation/RelNotes/1.7.12.2.txt b/Documentation/RelNotes/1.7.12.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.12.2.txt
rename to Documentation/RelNotes/1.7.12.2.adoc
diff --git a/Documentation/RelNotes/1.7.12.3.txt b/Documentation/RelNotes/1.7.12.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.12.3.txt
rename to Documentation/RelNotes/1.7.12.3.adoc
diff --git a/Documentation/RelNotes/1.7.12.4.txt b/Documentation/RelNotes/1.7.12.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.12.4.txt
rename to Documentation/RelNotes/1.7.12.4.adoc
diff --git a/Documentation/RelNotes/1.7.12.txt b/Documentation/RelNotes/1.7.12.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.12.txt
rename to Documentation/RelNotes/1.7.12.adoc
diff --git a/Documentation/RelNotes/1.7.2.1.txt b/Documentation/RelNotes/1.7.2.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.2.1.txt
rename to Documentation/RelNotes/1.7.2.1.adoc
diff --git a/Documentation/RelNotes/1.7.2.2.txt b/Documentation/RelNotes/1.7.2.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.2.2.txt
rename to Documentation/RelNotes/1.7.2.2.adoc
diff --git a/Documentation/RelNotes/1.7.2.3.txt b/Documentation/RelNotes/1.7.2.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.2.3.txt
rename to Documentation/RelNotes/1.7.2.3.adoc
diff --git a/Documentation/RelNotes/1.7.2.4.txt b/Documentation/RelNotes/1.7.2.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.2.4.txt
rename to Documentation/RelNotes/1.7.2.4.adoc
diff --git a/Documentation/RelNotes/1.7.2.5.txt b/Documentation/RelNotes/1.7.2.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.2.5.txt
rename to Documentation/RelNotes/1.7.2.5.adoc
diff --git a/Documentation/RelNotes/1.7.2.txt b/Documentation/RelNotes/1.7.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.2.txt
rename to Documentation/RelNotes/1.7.2.adoc
diff --git a/Documentation/RelNotes/1.7.3.1.txt b/Documentation/RelNotes/1.7.3.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.3.1.txt
rename to Documentation/RelNotes/1.7.3.1.adoc
diff --git a/Documentation/RelNotes/1.7.3.2.txt b/Documentation/RelNotes/1.7.3.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.3.2.txt
rename to Documentation/RelNotes/1.7.3.2.adoc
diff --git a/Documentation/RelNotes/1.7.3.3.txt b/Documentation/RelNotes/1.7.3.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.3.3.txt
rename to Documentation/RelNotes/1.7.3.3.adoc
diff --git a/Documentation/RelNotes/1.7.3.4.txt b/Documentation/RelNotes/1.7.3.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.3.4.txt
rename to Documentation/RelNotes/1.7.3.4.adoc
diff --git a/Documentation/RelNotes/1.7.3.5.txt b/Documentation/RelNotes/1.7.3.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.3.5.txt
rename to Documentation/RelNotes/1.7.3.5.adoc
diff --git a/Documentation/RelNotes/1.7.3.txt b/Documentation/RelNotes/1.7.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.3.txt
rename to Documentation/RelNotes/1.7.3.adoc
diff --git a/Documentation/RelNotes/1.7.4.1.txt b/Documentation/RelNotes/1.7.4.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.4.1.txt
rename to Documentation/RelNotes/1.7.4.1.adoc
diff --git a/Documentation/RelNotes/1.7.4.2.txt b/Documentation/RelNotes/1.7.4.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.4.2.txt
rename to Documentation/RelNotes/1.7.4.2.adoc
diff --git a/Documentation/RelNotes/1.7.4.3.txt b/Documentation/RelNotes/1.7.4.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.4.3.txt
rename to Documentation/RelNotes/1.7.4.3.adoc
diff --git a/Documentation/RelNotes/1.7.4.4.txt b/Documentation/RelNotes/1.7.4.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.4.4.txt
rename to Documentation/RelNotes/1.7.4.4.adoc
diff --git a/Documentation/RelNotes/1.7.4.5.txt b/Documentation/RelNotes/1.7.4.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.4.5.txt
rename to Documentation/RelNotes/1.7.4.5.adoc
diff --git a/Documentation/RelNotes/1.7.4.txt b/Documentation/RelNotes/1.7.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.4.txt
rename to Documentation/RelNotes/1.7.4.adoc
diff --git a/Documentation/RelNotes/1.7.5.1.txt b/Documentation/RelNotes/1.7.5.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.5.1.txt
rename to Documentation/RelNotes/1.7.5.1.adoc
diff --git a/Documentation/RelNotes/1.7.5.2.txt b/Documentation/RelNotes/1.7.5.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.5.2.txt
rename to Documentation/RelNotes/1.7.5.2.adoc
diff --git a/Documentation/RelNotes/1.7.5.3.txt b/Documentation/RelNotes/1.7.5.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.5.3.txt
rename to Documentation/RelNotes/1.7.5.3.adoc
diff --git a/Documentation/RelNotes/1.7.5.4.txt b/Documentation/RelNotes/1.7.5.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.5.4.txt
rename to Documentation/RelNotes/1.7.5.4.adoc
diff --git a/Documentation/RelNotes/1.7.5.txt b/Documentation/RelNotes/1.7.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.5.txt
rename to Documentation/RelNotes/1.7.5.adoc
diff --git a/Documentation/RelNotes/1.7.6.1.txt b/Documentation/RelNotes/1.7.6.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.6.1.txt
rename to Documentation/RelNotes/1.7.6.1.adoc
diff --git a/Documentation/RelNotes/1.7.6.2.txt b/Documentation/RelNotes/1.7.6.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.6.2.txt
rename to Documentation/RelNotes/1.7.6.2.adoc
diff --git a/Documentation/RelNotes/1.7.6.3.txt b/Documentation/RelNotes/1.7.6.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.6.3.txt
rename to Documentation/RelNotes/1.7.6.3.adoc
diff --git a/Documentation/RelNotes/1.7.6.4.txt b/Documentation/RelNotes/1.7.6.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.6.4.txt
rename to Documentation/RelNotes/1.7.6.4.adoc
diff --git a/Documentation/RelNotes/1.7.6.5.txt b/Documentation/RelNotes/1.7.6.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.6.5.txt
rename to Documentation/RelNotes/1.7.6.5.adoc
diff --git a/Documentation/RelNotes/1.7.6.6.txt b/Documentation/RelNotes/1.7.6.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.6.6.txt
rename to Documentation/RelNotes/1.7.6.6.adoc
diff --git a/Documentation/RelNotes/1.7.6.txt b/Documentation/RelNotes/1.7.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.6.txt
rename to Documentation/RelNotes/1.7.6.adoc
diff --git a/Documentation/RelNotes/1.7.7.1.txt b/Documentation/RelNotes/1.7.7.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.7.1.txt
rename to Documentation/RelNotes/1.7.7.1.adoc
diff --git a/Documentation/RelNotes/1.7.7.2.txt b/Documentation/RelNotes/1.7.7.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.7.2.txt
rename to Documentation/RelNotes/1.7.7.2.adoc
diff --git a/Documentation/RelNotes/1.7.7.3.txt b/Documentation/RelNotes/1.7.7.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.7.3.txt
rename to Documentation/RelNotes/1.7.7.3.adoc
diff --git a/Documentation/RelNotes/1.7.7.4.txt b/Documentation/RelNotes/1.7.7.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.7.4.txt
rename to Documentation/RelNotes/1.7.7.4.adoc
diff --git a/Documentation/RelNotes/1.7.7.5.txt b/Documentation/RelNotes/1.7.7.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.7.5.txt
rename to Documentation/RelNotes/1.7.7.5.adoc
diff --git a/Documentation/RelNotes/1.7.7.6.txt b/Documentation/RelNotes/1.7.7.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.7.6.txt
rename to Documentation/RelNotes/1.7.7.6.adoc
diff --git a/Documentation/RelNotes/1.7.7.7.txt b/Documentation/RelNotes/1.7.7.7.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.7.7.txt
rename to Documentation/RelNotes/1.7.7.7.adoc
diff --git a/Documentation/RelNotes/1.7.7.txt b/Documentation/RelNotes/1.7.7.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.7.txt
rename to Documentation/RelNotes/1.7.7.adoc
diff --git a/Documentation/RelNotes/1.7.8.1.txt b/Documentation/RelNotes/1.7.8.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.8.1.txt
rename to Documentation/RelNotes/1.7.8.1.adoc
diff --git a/Documentation/RelNotes/1.7.8.2.txt b/Documentation/RelNotes/1.7.8.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.8.2.txt
rename to Documentation/RelNotes/1.7.8.2.adoc
diff --git a/Documentation/RelNotes/1.7.8.3.txt b/Documentation/RelNotes/1.7.8.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.8.3.txt
rename to Documentation/RelNotes/1.7.8.3.adoc
diff --git a/Documentation/RelNotes/1.7.8.4.txt b/Documentation/RelNotes/1.7.8.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.8.4.txt
rename to Documentation/RelNotes/1.7.8.4.adoc
diff --git a/Documentation/RelNotes/1.7.8.5.txt b/Documentation/RelNotes/1.7.8.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.8.5.txt
rename to Documentation/RelNotes/1.7.8.5.adoc
diff --git a/Documentation/RelNotes/1.7.8.6.txt b/Documentation/RelNotes/1.7.8.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.8.6.txt
rename to Documentation/RelNotes/1.7.8.6.adoc
diff --git a/Documentation/RelNotes/1.7.8.txt b/Documentation/RelNotes/1.7.8.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.8.txt
rename to Documentation/RelNotes/1.7.8.adoc
diff --git a/Documentation/RelNotes/1.7.9.1.txt b/Documentation/RelNotes/1.7.9.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.9.1.txt
rename to Documentation/RelNotes/1.7.9.1.adoc
diff --git a/Documentation/RelNotes/1.7.9.2.txt b/Documentation/RelNotes/1.7.9.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.9.2.txt
rename to Documentation/RelNotes/1.7.9.2.adoc
diff --git a/Documentation/RelNotes/1.7.9.3.txt b/Documentation/RelNotes/1.7.9.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.9.3.txt
rename to Documentation/RelNotes/1.7.9.3.adoc
diff --git a/Documentation/RelNotes/1.7.9.4.txt b/Documentation/RelNotes/1.7.9.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.9.4.txt
rename to Documentation/RelNotes/1.7.9.4.adoc
diff --git a/Documentation/RelNotes/1.7.9.5.txt b/Documentation/RelNotes/1.7.9.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.9.5.txt
rename to Documentation/RelNotes/1.7.9.5.adoc
diff --git a/Documentation/RelNotes/1.7.9.6.txt b/Documentation/RelNotes/1.7.9.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.9.6.txt
rename to Documentation/RelNotes/1.7.9.6.adoc
diff --git a/Documentation/RelNotes/1.7.9.7.txt b/Documentation/RelNotes/1.7.9.7.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.9.7.txt
rename to Documentation/RelNotes/1.7.9.7.adoc
diff --git a/Documentation/RelNotes/1.7.9.txt b/Documentation/RelNotes/1.7.9.adoc
similarity index 100%
rename from Documentation/RelNotes/1.7.9.txt
rename to Documentation/RelNotes/1.7.9.adoc
diff --git a/Documentation/RelNotes/1.8.0.1.txt b/Documentation/RelNotes/1.8.0.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.0.1.txt
rename to Documentation/RelNotes/1.8.0.1.adoc
diff --git a/Documentation/RelNotes/1.8.0.2.txt b/Documentation/RelNotes/1.8.0.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.0.2.txt
rename to Documentation/RelNotes/1.8.0.2.adoc
diff --git a/Documentation/RelNotes/1.8.0.3.txt b/Documentation/RelNotes/1.8.0.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.0.3.txt
rename to Documentation/RelNotes/1.8.0.3.adoc
diff --git a/Documentation/RelNotes/1.8.0.txt b/Documentation/RelNotes/1.8.0.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.0.txt
rename to Documentation/RelNotes/1.8.0.adoc
diff --git a/Documentation/RelNotes/1.8.1.1.txt b/Documentation/RelNotes/1.8.1.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.1.1.txt
rename to Documentation/RelNotes/1.8.1.1.adoc
diff --git a/Documentation/RelNotes/1.8.1.2.txt b/Documentation/RelNotes/1.8.1.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.1.2.txt
rename to Documentation/RelNotes/1.8.1.2.adoc
diff --git a/Documentation/RelNotes/1.8.1.3.txt b/Documentation/RelNotes/1.8.1.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.1.3.txt
rename to Documentation/RelNotes/1.8.1.3.adoc
diff --git a/Documentation/RelNotes/1.8.1.4.txt b/Documentation/RelNotes/1.8.1.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.1.4.txt
rename to Documentation/RelNotes/1.8.1.4.adoc
diff --git a/Documentation/RelNotes/1.8.1.5.txt b/Documentation/RelNotes/1.8.1.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.1.5.txt
rename to Documentation/RelNotes/1.8.1.5.adoc
diff --git a/Documentation/RelNotes/1.8.1.6.txt b/Documentation/RelNotes/1.8.1.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.1.6.txt
rename to Documentation/RelNotes/1.8.1.6.adoc
diff --git a/Documentation/RelNotes/1.8.1.txt b/Documentation/RelNotes/1.8.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.1.txt
rename to Documentation/RelNotes/1.8.1.adoc
diff --git a/Documentation/RelNotes/1.8.2.1.txt b/Documentation/RelNotes/1.8.2.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.2.1.txt
rename to Documentation/RelNotes/1.8.2.1.adoc
diff --git a/Documentation/RelNotes/1.8.2.2.txt b/Documentation/RelNotes/1.8.2.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.2.2.txt
rename to Documentation/RelNotes/1.8.2.2.adoc
diff --git a/Documentation/RelNotes/1.8.2.3.txt b/Documentation/RelNotes/1.8.2.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.2.3.txt
rename to Documentation/RelNotes/1.8.2.3.adoc
diff --git a/Documentation/RelNotes/1.8.2.txt b/Documentation/RelNotes/1.8.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.2.txt
rename to Documentation/RelNotes/1.8.2.adoc
diff --git a/Documentation/RelNotes/1.8.3.1.txt b/Documentation/RelNotes/1.8.3.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.3.1.txt
rename to Documentation/RelNotes/1.8.3.1.adoc
diff --git a/Documentation/RelNotes/1.8.3.2.txt b/Documentation/RelNotes/1.8.3.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.3.2.txt
rename to Documentation/RelNotes/1.8.3.2.adoc
diff --git a/Documentation/RelNotes/1.8.3.3.txt b/Documentation/RelNotes/1.8.3.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.3.3.txt
rename to Documentation/RelNotes/1.8.3.3.adoc
diff --git a/Documentation/RelNotes/1.8.3.4.txt b/Documentation/RelNotes/1.8.3.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.3.4.txt
rename to Documentation/RelNotes/1.8.3.4.adoc
diff --git a/Documentation/RelNotes/1.8.3.txt b/Documentation/RelNotes/1.8.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.3.txt
rename to Documentation/RelNotes/1.8.3.adoc
diff --git a/Documentation/RelNotes/1.8.4.1.txt b/Documentation/RelNotes/1.8.4.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.4.1.txt
rename to Documentation/RelNotes/1.8.4.1.adoc
diff --git a/Documentation/RelNotes/1.8.4.2.txt b/Documentation/RelNotes/1.8.4.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.4.2.txt
rename to Documentation/RelNotes/1.8.4.2.adoc
diff --git a/Documentation/RelNotes/1.8.4.3.txt b/Documentation/RelNotes/1.8.4.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.4.3.txt
rename to Documentation/RelNotes/1.8.4.3.adoc
diff --git a/Documentation/RelNotes/1.8.4.4.txt b/Documentation/RelNotes/1.8.4.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.4.4.txt
rename to Documentation/RelNotes/1.8.4.4.adoc
diff --git a/Documentation/RelNotes/1.8.4.5.txt b/Documentation/RelNotes/1.8.4.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.4.5.txt
rename to Documentation/RelNotes/1.8.4.5.adoc
diff --git a/Documentation/RelNotes/1.8.4.txt b/Documentation/RelNotes/1.8.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.4.txt
rename to Documentation/RelNotes/1.8.4.adoc
diff --git a/Documentation/RelNotes/1.8.5.1.txt b/Documentation/RelNotes/1.8.5.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.5.1.txt
rename to Documentation/RelNotes/1.8.5.1.adoc
diff --git a/Documentation/RelNotes/1.8.5.2.txt b/Documentation/RelNotes/1.8.5.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.5.2.txt
rename to Documentation/RelNotes/1.8.5.2.adoc
diff --git a/Documentation/RelNotes/1.8.5.3.txt b/Documentation/RelNotes/1.8.5.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.5.3.txt
rename to Documentation/RelNotes/1.8.5.3.adoc
diff --git a/Documentation/RelNotes/1.8.5.4.txt b/Documentation/RelNotes/1.8.5.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.5.4.txt
rename to Documentation/RelNotes/1.8.5.4.adoc
diff --git a/Documentation/RelNotes/1.8.5.5.txt b/Documentation/RelNotes/1.8.5.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.5.5.txt
rename to Documentation/RelNotes/1.8.5.5.adoc
diff --git a/Documentation/RelNotes/1.8.5.6.txt b/Documentation/RelNotes/1.8.5.6.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.5.6.txt
rename to Documentation/RelNotes/1.8.5.6.adoc
diff --git a/Documentation/RelNotes/1.8.5.txt b/Documentation/RelNotes/1.8.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.8.5.txt
rename to Documentation/RelNotes/1.8.5.adoc
diff --git a/Documentation/RelNotes/1.9.0.txt b/Documentation/RelNotes/1.9.0.adoc
similarity index 100%
rename from Documentation/RelNotes/1.9.0.txt
rename to Documentation/RelNotes/1.9.0.adoc
diff --git a/Documentation/RelNotes/1.9.1.txt b/Documentation/RelNotes/1.9.1.adoc
similarity index 100%
rename from Documentation/RelNotes/1.9.1.txt
rename to Documentation/RelNotes/1.9.1.adoc
diff --git a/Documentation/RelNotes/1.9.2.txt b/Documentation/RelNotes/1.9.2.adoc
similarity index 100%
rename from Documentation/RelNotes/1.9.2.txt
rename to Documentation/RelNotes/1.9.2.adoc
diff --git a/Documentation/RelNotes/1.9.3.txt b/Documentation/RelNotes/1.9.3.adoc
similarity index 100%
rename from Documentation/RelNotes/1.9.3.txt
rename to Documentation/RelNotes/1.9.3.adoc
diff --git a/Documentation/RelNotes/1.9.4.txt b/Documentation/RelNotes/1.9.4.adoc
similarity index 100%
rename from Documentation/RelNotes/1.9.4.txt
rename to Documentation/RelNotes/1.9.4.adoc
diff --git a/Documentation/RelNotes/1.9.5.txt b/Documentation/RelNotes/1.9.5.adoc
similarity index 100%
rename from Documentation/RelNotes/1.9.5.txt
rename to Documentation/RelNotes/1.9.5.adoc
diff --git a/Documentation/RelNotes/2.0.0.txt b/Documentation/RelNotes/2.0.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.0.0.txt
rename to Documentation/RelNotes/2.0.0.adoc
diff --git a/Documentation/RelNotes/2.0.1.txt b/Documentation/RelNotes/2.0.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.0.1.txt
rename to Documentation/RelNotes/2.0.1.adoc
diff --git a/Documentation/RelNotes/2.0.2.txt b/Documentation/RelNotes/2.0.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.0.2.txt
rename to Documentation/RelNotes/2.0.2.adoc
diff --git a/Documentation/RelNotes/2.0.3.txt b/Documentation/RelNotes/2.0.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.0.3.txt
rename to Documentation/RelNotes/2.0.3.adoc
diff --git a/Documentation/RelNotes/2.0.4.txt b/Documentation/RelNotes/2.0.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.0.4.txt
rename to Documentation/RelNotes/2.0.4.adoc
diff --git a/Documentation/RelNotes/2.0.5.txt b/Documentation/RelNotes/2.0.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.0.5.txt
rename to Documentation/RelNotes/2.0.5.adoc
diff --git a/Documentation/RelNotes/2.1.0.txt b/Documentation/RelNotes/2.1.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.1.0.txt
rename to Documentation/RelNotes/2.1.0.adoc
diff --git a/Documentation/RelNotes/2.1.1.txt b/Documentation/RelNotes/2.1.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.1.1.txt
rename to Documentation/RelNotes/2.1.1.adoc
diff --git a/Documentation/RelNotes/2.1.2.txt b/Documentation/RelNotes/2.1.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.1.2.txt
rename to Documentation/RelNotes/2.1.2.adoc
diff --git a/Documentation/RelNotes/2.1.3.txt b/Documentation/RelNotes/2.1.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.1.3.txt
rename to Documentation/RelNotes/2.1.3.adoc
diff --git a/Documentation/RelNotes/2.1.4.txt b/Documentation/RelNotes/2.1.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.1.4.txt
rename to Documentation/RelNotes/2.1.4.adoc
diff --git a/Documentation/RelNotes/2.10.0.txt b/Documentation/RelNotes/2.10.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.10.0.txt
rename to Documentation/RelNotes/2.10.0.adoc
diff --git a/Documentation/RelNotes/2.10.1.txt b/Documentation/RelNotes/2.10.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.10.1.txt
rename to Documentation/RelNotes/2.10.1.adoc
diff --git a/Documentation/RelNotes/2.10.2.txt b/Documentation/RelNotes/2.10.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.10.2.txt
rename to Documentation/RelNotes/2.10.2.adoc
diff --git a/Documentation/RelNotes/2.10.3.txt b/Documentation/RelNotes/2.10.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.10.3.txt
rename to Documentation/RelNotes/2.10.3.adoc
diff --git a/Documentation/RelNotes/2.10.4.txt b/Documentation/RelNotes/2.10.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.10.4.txt
rename to Documentation/RelNotes/2.10.4.adoc
diff --git a/Documentation/RelNotes/2.10.5.txt b/Documentation/RelNotes/2.10.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.10.5.txt
rename to Documentation/RelNotes/2.10.5.adoc
diff --git a/Documentation/RelNotes/2.11.0.txt b/Documentation/RelNotes/2.11.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.11.0.txt
rename to Documentation/RelNotes/2.11.0.adoc
diff --git a/Documentation/RelNotes/2.11.1.txt b/Documentation/RelNotes/2.11.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.11.1.txt
rename to Documentation/RelNotes/2.11.1.adoc
diff --git a/Documentation/RelNotes/2.11.2.txt b/Documentation/RelNotes/2.11.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.11.2.txt
rename to Documentation/RelNotes/2.11.2.adoc
diff --git a/Documentation/RelNotes/2.11.3.txt b/Documentation/RelNotes/2.11.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.11.3.txt
rename to Documentation/RelNotes/2.11.3.adoc
diff --git a/Documentation/RelNotes/2.11.4.txt b/Documentation/RelNotes/2.11.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.11.4.txt
rename to Documentation/RelNotes/2.11.4.adoc
diff --git a/Documentation/RelNotes/2.12.0.txt b/Documentation/RelNotes/2.12.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.12.0.txt
rename to Documentation/RelNotes/2.12.0.adoc
diff --git a/Documentation/RelNotes/2.12.1.txt b/Documentation/RelNotes/2.12.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.12.1.txt
rename to Documentation/RelNotes/2.12.1.adoc
diff --git a/Documentation/RelNotes/2.12.2.txt b/Documentation/RelNotes/2.12.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.12.2.txt
rename to Documentation/RelNotes/2.12.2.adoc
diff --git a/Documentation/RelNotes/2.12.3.txt b/Documentation/RelNotes/2.12.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.12.3.txt
rename to Documentation/RelNotes/2.12.3.adoc
diff --git a/Documentation/RelNotes/2.12.4.txt b/Documentation/RelNotes/2.12.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.12.4.txt
rename to Documentation/RelNotes/2.12.4.adoc
diff --git a/Documentation/RelNotes/2.12.5.txt b/Documentation/RelNotes/2.12.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.12.5.txt
rename to Documentation/RelNotes/2.12.5.adoc
diff --git a/Documentation/RelNotes/2.13.0.txt b/Documentation/RelNotes/2.13.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.13.0.txt
rename to Documentation/RelNotes/2.13.0.adoc
diff --git a/Documentation/RelNotes/2.13.1.txt b/Documentation/RelNotes/2.13.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.13.1.txt
rename to Documentation/RelNotes/2.13.1.adoc
diff --git a/Documentation/RelNotes/2.13.2.txt b/Documentation/RelNotes/2.13.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.13.2.txt
rename to Documentation/RelNotes/2.13.2.adoc
diff --git a/Documentation/RelNotes/2.13.3.txt b/Documentation/RelNotes/2.13.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.13.3.txt
rename to Documentation/RelNotes/2.13.3.adoc
diff --git a/Documentation/RelNotes/2.13.4.txt b/Documentation/RelNotes/2.13.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.13.4.txt
rename to Documentation/RelNotes/2.13.4.adoc
diff --git a/Documentation/RelNotes/2.13.5.txt b/Documentation/RelNotes/2.13.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.13.5.txt
rename to Documentation/RelNotes/2.13.5.adoc
diff --git a/Documentation/RelNotes/2.13.6.txt b/Documentation/RelNotes/2.13.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.13.6.txt
rename to Documentation/RelNotes/2.13.6.adoc
diff --git a/Documentation/RelNotes/2.13.7.txt b/Documentation/RelNotes/2.13.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.13.7.txt
rename to Documentation/RelNotes/2.13.7.adoc
diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.14.0.txt
rename to Documentation/RelNotes/2.14.0.adoc
diff --git a/Documentation/RelNotes/2.14.1.txt b/Documentation/RelNotes/2.14.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.14.1.txt
rename to Documentation/RelNotes/2.14.1.adoc
diff --git a/Documentation/RelNotes/2.14.2.txt b/Documentation/RelNotes/2.14.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.14.2.txt
rename to Documentation/RelNotes/2.14.2.adoc
diff --git a/Documentation/RelNotes/2.14.3.txt b/Documentation/RelNotes/2.14.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.14.3.txt
rename to Documentation/RelNotes/2.14.3.adoc
diff --git a/Documentation/RelNotes/2.14.4.txt b/Documentation/RelNotes/2.14.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.14.4.txt
rename to Documentation/RelNotes/2.14.4.adoc
diff --git a/Documentation/RelNotes/2.14.5.txt b/Documentation/RelNotes/2.14.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.14.5.txt
rename to Documentation/RelNotes/2.14.5.adoc
diff --git a/Documentation/RelNotes/2.14.6.txt b/Documentation/RelNotes/2.14.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.14.6.txt
rename to Documentation/RelNotes/2.14.6.adoc
diff --git a/Documentation/RelNotes/2.15.0.txt b/Documentation/RelNotes/2.15.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.15.0.txt
rename to Documentation/RelNotes/2.15.0.adoc
diff --git a/Documentation/RelNotes/2.15.1.txt b/Documentation/RelNotes/2.15.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.15.1.txt
rename to Documentation/RelNotes/2.15.1.adoc
diff --git a/Documentation/RelNotes/2.15.2.txt b/Documentation/RelNotes/2.15.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.15.2.txt
rename to Documentation/RelNotes/2.15.2.adoc
diff --git a/Documentation/RelNotes/2.15.3.txt b/Documentation/RelNotes/2.15.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.15.3.txt
rename to Documentation/RelNotes/2.15.3.adoc
diff --git a/Documentation/RelNotes/2.15.4.txt b/Documentation/RelNotes/2.15.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.15.4.txt
rename to Documentation/RelNotes/2.15.4.adoc
diff --git a/Documentation/RelNotes/2.16.0.txt b/Documentation/RelNotes/2.16.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.16.0.txt
rename to Documentation/RelNotes/2.16.0.adoc
diff --git a/Documentation/RelNotes/2.16.1.txt b/Documentation/RelNotes/2.16.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.16.1.txt
rename to Documentation/RelNotes/2.16.1.adoc
diff --git a/Documentation/RelNotes/2.16.2.txt b/Documentation/RelNotes/2.16.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.16.2.txt
rename to Documentation/RelNotes/2.16.2.adoc
diff --git a/Documentation/RelNotes/2.16.3.txt b/Documentation/RelNotes/2.16.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.16.3.txt
rename to Documentation/RelNotes/2.16.3.adoc
diff --git a/Documentation/RelNotes/2.16.4.txt b/Documentation/RelNotes/2.16.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.16.4.txt
rename to Documentation/RelNotes/2.16.4.adoc
diff --git a/Documentation/RelNotes/2.16.5.txt b/Documentation/RelNotes/2.16.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.16.5.txt
rename to Documentation/RelNotes/2.16.5.adoc
diff --git a/Documentation/RelNotes/2.16.6.txt b/Documentation/RelNotes/2.16.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.16.6.txt
rename to Documentation/RelNotes/2.16.6.adoc
diff --git a/Documentation/RelNotes/2.17.0.txt b/Documentation/RelNotes/2.17.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.17.0.txt
rename to Documentation/RelNotes/2.17.0.adoc
diff --git a/Documentation/RelNotes/2.17.1.txt b/Documentation/RelNotes/2.17.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.17.1.txt
rename to Documentation/RelNotes/2.17.1.adoc
diff --git a/Documentation/RelNotes/2.17.2.txt b/Documentation/RelNotes/2.17.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.17.2.txt
rename to Documentation/RelNotes/2.17.2.adoc
diff --git a/Documentation/RelNotes/2.17.3.txt b/Documentation/RelNotes/2.17.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.17.3.txt
rename to Documentation/RelNotes/2.17.3.adoc
diff --git a/Documentation/RelNotes/2.17.4.txt b/Documentation/RelNotes/2.17.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.17.4.txt
rename to Documentation/RelNotes/2.17.4.adoc
diff --git a/Documentation/RelNotes/2.17.5.txt b/Documentation/RelNotes/2.17.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.17.5.txt
rename to Documentation/RelNotes/2.17.5.adoc
diff --git a/Documentation/RelNotes/2.17.6.txt b/Documentation/RelNotes/2.17.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.17.6.txt
rename to Documentation/RelNotes/2.17.6.adoc
diff --git a/Documentation/RelNotes/2.18.0.txt b/Documentation/RelNotes/2.18.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.18.0.txt
rename to Documentation/RelNotes/2.18.0.adoc
diff --git a/Documentation/RelNotes/2.18.1.txt b/Documentation/RelNotes/2.18.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.18.1.txt
rename to Documentation/RelNotes/2.18.1.adoc
diff --git a/Documentation/RelNotes/2.18.2.txt b/Documentation/RelNotes/2.18.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.18.2.txt
rename to Documentation/RelNotes/2.18.2.adoc
diff --git a/Documentation/RelNotes/2.18.3.txt b/Documentation/RelNotes/2.18.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.18.3.txt
rename to Documentation/RelNotes/2.18.3.adoc
diff --git a/Documentation/RelNotes/2.18.4.txt b/Documentation/RelNotes/2.18.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.18.4.txt
rename to Documentation/RelNotes/2.18.4.adoc
diff --git a/Documentation/RelNotes/2.18.5.txt b/Documentation/RelNotes/2.18.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.18.5.txt
rename to Documentation/RelNotes/2.18.5.adoc
diff --git a/Documentation/RelNotes/2.19.0.txt b/Documentation/RelNotes/2.19.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.19.0.txt
rename to Documentation/RelNotes/2.19.0.adoc
diff --git a/Documentation/RelNotes/2.19.1.txt b/Documentation/RelNotes/2.19.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.19.1.txt
rename to Documentation/RelNotes/2.19.1.adoc
diff --git a/Documentation/RelNotes/2.19.2.txt b/Documentation/RelNotes/2.19.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.19.2.txt
rename to Documentation/RelNotes/2.19.2.adoc
diff --git a/Documentation/RelNotes/2.19.3.txt b/Documentation/RelNotes/2.19.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.19.3.txt
rename to Documentation/RelNotes/2.19.3.adoc
diff --git a/Documentation/RelNotes/2.19.4.txt b/Documentation/RelNotes/2.19.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.19.4.txt
rename to Documentation/RelNotes/2.19.4.adoc
diff --git a/Documentation/RelNotes/2.19.5.txt b/Documentation/RelNotes/2.19.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.19.5.txt
rename to Documentation/RelNotes/2.19.5.adoc
diff --git a/Documentation/RelNotes/2.19.6.txt b/Documentation/RelNotes/2.19.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.19.6.txt
rename to Documentation/RelNotes/2.19.6.adoc
diff --git a/Documentation/RelNotes/2.2.0.txt b/Documentation/RelNotes/2.2.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.2.0.txt
rename to Documentation/RelNotes/2.2.0.adoc
diff --git a/Documentation/RelNotes/2.2.1.txt b/Documentation/RelNotes/2.2.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.2.1.txt
rename to Documentation/RelNotes/2.2.1.adoc
diff --git a/Documentation/RelNotes/2.2.2.txt b/Documentation/RelNotes/2.2.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.2.2.txt
rename to Documentation/RelNotes/2.2.2.adoc
diff --git a/Documentation/RelNotes/2.2.3.txt b/Documentation/RelNotes/2.2.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.2.3.txt
rename to Documentation/RelNotes/2.2.3.adoc
diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.20.0.txt
rename to Documentation/RelNotes/2.20.0.adoc
diff --git a/Documentation/RelNotes/2.20.1.txt b/Documentation/RelNotes/2.20.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.20.1.txt
rename to Documentation/RelNotes/2.20.1.adoc
diff --git a/Documentation/RelNotes/2.20.2.txt b/Documentation/RelNotes/2.20.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.20.2.txt
rename to Documentation/RelNotes/2.20.2.adoc
diff --git a/Documentation/RelNotes/2.20.3.txt b/Documentation/RelNotes/2.20.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.20.3.txt
rename to Documentation/RelNotes/2.20.3.adoc
diff --git a/Documentation/RelNotes/2.20.4.txt b/Documentation/RelNotes/2.20.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.20.4.txt
rename to Documentation/RelNotes/2.20.4.adoc
diff --git a/Documentation/RelNotes/2.20.5.txt b/Documentation/RelNotes/2.20.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.20.5.txt
rename to Documentation/RelNotes/2.20.5.adoc
diff --git a/Documentation/RelNotes/2.21.0.txt b/Documentation/RelNotes/2.21.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.21.0.txt
rename to Documentation/RelNotes/2.21.0.adoc
diff --git a/Documentation/RelNotes/2.21.1.txt b/Documentation/RelNotes/2.21.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.21.1.txt
rename to Documentation/RelNotes/2.21.1.adoc
diff --git a/Documentation/RelNotes/2.21.2.txt b/Documentation/RelNotes/2.21.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.21.2.txt
rename to Documentation/RelNotes/2.21.2.adoc
diff --git a/Documentation/RelNotes/2.21.3.txt b/Documentation/RelNotes/2.21.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.21.3.txt
rename to Documentation/RelNotes/2.21.3.adoc
diff --git a/Documentation/RelNotes/2.21.4.txt b/Documentation/RelNotes/2.21.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.21.4.txt
rename to Documentation/RelNotes/2.21.4.adoc
diff --git a/Documentation/RelNotes/2.22.0.txt b/Documentation/RelNotes/2.22.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.22.0.txt
rename to Documentation/RelNotes/2.22.0.adoc
diff --git a/Documentation/RelNotes/2.22.1.txt b/Documentation/RelNotes/2.22.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.22.1.txt
rename to Documentation/RelNotes/2.22.1.adoc
diff --git a/Documentation/RelNotes/2.22.2.txt b/Documentation/RelNotes/2.22.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.22.2.txt
rename to Documentation/RelNotes/2.22.2.adoc
diff --git a/Documentation/RelNotes/2.22.3.txt b/Documentation/RelNotes/2.22.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.22.3.txt
rename to Documentation/RelNotes/2.22.3.adoc
diff --git a/Documentation/RelNotes/2.22.4.txt b/Documentation/RelNotes/2.22.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.22.4.txt
rename to Documentation/RelNotes/2.22.4.adoc
diff --git a/Documentation/RelNotes/2.22.5.txt b/Documentation/RelNotes/2.22.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.22.5.txt
rename to Documentation/RelNotes/2.22.5.adoc
diff --git a/Documentation/RelNotes/2.23.0.txt b/Documentation/RelNotes/2.23.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.23.0.txt
rename to Documentation/RelNotes/2.23.0.adoc
diff --git a/Documentation/RelNotes/2.23.1.txt b/Documentation/RelNotes/2.23.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.23.1.txt
rename to Documentation/RelNotes/2.23.1.adoc
diff --git a/Documentation/RelNotes/2.23.2.txt b/Documentation/RelNotes/2.23.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.23.2.txt
rename to Documentation/RelNotes/2.23.2.adoc
diff --git a/Documentation/RelNotes/2.23.3.txt b/Documentation/RelNotes/2.23.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.23.3.txt
rename to Documentation/RelNotes/2.23.3.adoc
diff --git a/Documentation/RelNotes/2.23.4.txt b/Documentation/RelNotes/2.23.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.23.4.txt
rename to Documentation/RelNotes/2.23.4.adoc
diff --git a/Documentation/RelNotes/2.24.0.txt b/Documentation/RelNotes/2.24.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.24.0.txt
rename to Documentation/RelNotes/2.24.0.adoc
diff --git a/Documentation/RelNotes/2.24.1.txt b/Documentation/RelNotes/2.24.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.24.1.txt
rename to Documentation/RelNotes/2.24.1.adoc
diff --git a/Documentation/RelNotes/2.24.2.txt b/Documentation/RelNotes/2.24.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.24.2.txt
rename to Documentation/RelNotes/2.24.2.adoc
diff --git a/Documentation/RelNotes/2.24.3.txt b/Documentation/RelNotes/2.24.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.24.3.txt
rename to Documentation/RelNotes/2.24.3.adoc
diff --git a/Documentation/RelNotes/2.24.4.txt b/Documentation/RelNotes/2.24.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.24.4.txt
rename to Documentation/RelNotes/2.24.4.adoc
diff --git a/Documentation/RelNotes/2.25.0.txt b/Documentation/RelNotes/2.25.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.25.0.txt
rename to Documentation/RelNotes/2.25.0.adoc
diff --git a/Documentation/RelNotes/2.25.1.txt b/Documentation/RelNotes/2.25.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.25.1.txt
rename to Documentation/RelNotes/2.25.1.adoc
diff --git a/Documentation/RelNotes/2.25.2.txt b/Documentation/RelNotes/2.25.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.25.2.txt
rename to Documentation/RelNotes/2.25.2.adoc
diff --git a/Documentation/RelNotes/2.25.3.txt b/Documentation/RelNotes/2.25.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.25.3.txt
rename to Documentation/RelNotes/2.25.3.adoc
diff --git a/Documentation/RelNotes/2.25.4.txt b/Documentation/RelNotes/2.25.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.25.4.txt
rename to Documentation/RelNotes/2.25.4.adoc
diff --git a/Documentation/RelNotes/2.25.5.txt b/Documentation/RelNotes/2.25.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.25.5.txt
rename to Documentation/RelNotes/2.25.5.adoc
diff --git a/Documentation/RelNotes/2.26.0.txt b/Documentation/RelNotes/2.26.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.26.0.txt
rename to Documentation/RelNotes/2.26.0.adoc
diff --git a/Documentation/RelNotes/2.26.1.txt b/Documentation/RelNotes/2.26.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.26.1.txt
rename to Documentation/RelNotes/2.26.1.adoc
diff --git a/Documentation/RelNotes/2.26.2.txt b/Documentation/RelNotes/2.26.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.26.2.txt
rename to Documentation/RelNotes/2.26.2.adoc
diff --git a/Documentation/RelNotes/2.26.3.txt b/Documentation/RelNotes/2.26.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.26.3.txt
rename to Documentation/RelNotes/2.26.3.adoc
diff --git a/Documentation/RelNotes/2.27.0.txt b/Documentation/RelNotes/2.27.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.27.0.txt
rename to Documentation/RelNotes/2.27.0.adoc
diff --git a/Documentation/RelNotes/2.27.1.txt b/Documentation/RelNotes/2.27.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.27.1.txt
rename to Documentation/RelNotes/2.27.1.adoc
diff --git a/Documentation/RelNotes/2.28.0.txt b/Documentation/RelNotes/2.28.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.28.0.txt
rename to Documentation/RelNotes/2.28.0.adoc
diff --git a/Documentation/RelNotes/2.28.1.txt b/Documentation/RelNotes/2.28.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.28.1.txt
rename to Documentation/RelNotes/2.28.1.adoc
diff --git a/Documentation/RelNotes/2.29.0.txt b/Documentation/RelNotes/2.29.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.29.0.txt
rename to Documentation/RelNotes/2.29.0.adoc
diff --git a/Documentation/RelNotes/2.29.1.txt b/Documentation/RelNotes/2.29.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.29.1.txt
rename to Documentation/RelNotes/2.29.1.adoc
diff --git a/Documentation/RelNotes/2.29.2.txt b/Documentation/RelNotes/2.29.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.29.2.txt
rename to Documentation/RelNotes/2.29.2.adoc
diff --git a/Documentation/RelNotes/2.29.3.txt b/Documentation/RelNotes/2.29.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.29.3.txt
rename to Documentation/RelNotes/2.29.3.adoc
diff --git a/Documentation/RelNotes/2.3.0.txt b/Documentation/RelNotes/2.3.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.0.txt
rename to Documentation/RelNotes/2.3.0.adoc
diff --git a/Documentation/RelNotes/2.3.1.txt b/Documentation/RelNotes/2.3.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.1.txt
rename to Documentation/RelNotes/2.3.1.adoc
diff --git a/Documentation/RelNotes/2.3.10.txt b/Documentation/RelNotes/2.3.10.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.10.txt
rename to Documentation/RelNotes/2.3.10.adoc
diff --git a/Documentation/RelNotes/2.3.2.txt b/Documentation/RelNotes/2.3.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.2.txt
rename to Documentation/RelNotes/2.3.2.adoc
diff --git a/Documentation/RelNotes/2.3.3.txt b/Documentation/RelNotes/2.3.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.3.txt
rename to Documentation/RelNotes/2.3.3.adoc
diff --git a/Documentation/RelNotes/2.3.4.txt b/Documentation/RelNotes/2.3.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.4.txt
rename to Documentation/RelNotes/2.3.4.adoc
diff --git a/Documentation/RelNotes/2.3.5.txt b/Documentation/RelNotes/2.3.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.5.txt
rename to Documentation/RelNotes/2.3.5.adoc
diff --git a/Documentation/RelNotes/2.3.6.txt b/Documentation/RelNotes/2.3.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.6.txt
rename to Documentation/RelNotes/2.3.6.adoc
diff --git a/Documentation/RelNotes/2.3.7.txt b/Documentation/RelNotes/2.3.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.7.txt
rename to Documentation/RelNotes/2.3.7.adoc
diff --git a/Documentation/RelNotes/2.3.8.txt b/Documentation/RelNotes/2.3.8.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.8.txt
rename to Documentation/RelNotes/2.3.8.adoc
diff --git a/Documentation/RelNotes/2.3.9.txt b/Documentation/RelNotes/2.3.9.adoc
similarity index 100%
rename from Documentation/RelNotes/2.3.9.txt
rename to Documentation/RelNotes/2.3.9.adoc
diff --git a/Documentation/RelNotes/2.30.0.txt b/Documentation/RelNotes/2.30.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.0.txt
rename to Documentation/RelNotes/2.30.0.adoc
diff --git a/Documentation/RelNotes/2.30.1.txt b/Documentation/RelNotes/2.30.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.1.txt
rename to Documentation/RelNotes/2.30.1.adoc
diff --git a/Documentation/RelNotes/2.30.2.txt b/Documentation/RelNotes/2.30.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.2.txt
rename to Documentation/RelNotes/2.30.2.adoc
diff --git a/Documentation/RelNotes/2.30.3.txt b/Documentation/RelNotes/2.30.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.3.txt
rename to Documentation/RelNotes/2.30.3.adoc
diff --git a/Documentation/RelNotes/2.30.4.txt b/Documentation/RelNotes/2.30.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.4.txt
rename to Documentation/RelNotes/2.30.4.adoc
diff --git a/Documentation/RelNotes/2.30.5.txt b/Documentation/RelNotes/2.30.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.5.txt
rename to Documentation/RelNotes/2.30.5.adoc
diff --git a/Documentation/RelNotes/2.30.6.txt b/Documentation/RelNotes/2.30.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.6.txt
rename to Documentation/RelNotes/2.30.6.adoc
diff --git a/Documentation/RelNotes/2.30.7.txt b/Documentation/RelNotes/2.30.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.7.txt
rename to Documentation/RelNotes/2.30.7.adoc
diff --git a/Documentation/RelNotes/2.30.8.txt b/Documentation/RelNotes/2.30.8.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.8.txt
rename to Documentation/RelNotes/2.30.8.adoc
diff --git a/Documentation/RelNotes/2.30.9.txt b/Documentation/RelNotes/2.30.9.adoc
similarity index 100%
rename from Documentation/RelNotes/2.30.9.txt
rename to Documentation/RelNotes/2.30.9.adoc
diff --git a/Documentation/RelNotes/2.31.0.txt b/Documentation/RelNotes/2.31.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.31.0.txt
rename to Documentation/RelNotes/2.31.0.adoc
diff --git a/Documentation/RelNotes/2.31.1.txt b/Documentation/RelNotes/2.31.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.31.1.txt
rename to Documentation/RelNotes/2.31.1.adoc
diff --git a/Documentation/RelNotes/2.31.2.txt b/Documentation/RelNotes/2.31.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.31.2.txt
rename to Documentation/RelNotes/2.31.2.adoc
diff --git a/Documentation/RelNotes/2.31.3.txt b/Documentation/RelNotes/2.31.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.31.3.txt
rename to Documentation/RelNotes/2.31.3.adoc
diff --git a/Documentation/RelNotes/2.31.4.txt b/Documentation/RelNotes/2.31.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.31.4.txt
rename to Documentation/RelNotes/2.31.4.adoc
diff --git a/Documentation/RelNotes/2.31.5.txt b/Documentation/RelNotes/2.31.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.31.5.txt
rename to Documentation/RelNotes/2.31.5.adoc
diff --git a/Documentation/RelNotes/2.31.6.txt b/Documentation/RelNotes/2.31.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.31.6.txt
rename to Documentation/RelNotes/2.31.6.adoc
diff --git a/Documentation/RelNotes/2.31.7.txt b/Documentation/RelNotes/2.31.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.31.7.txt
rename to Documentation/RelNotes/2.31.7.adoc
diff --git a/Documentation/RelNotes/2.31.8.txt b/Documentation/RelNotes/2.31.8.adoc
similarity index 100%
rename from Documentation/RelNotes/2.31.8.txt
rename to Documentation/RelNotes/2.31.8.adoc
diff --git a/Documentation/RelNotes/2.32.0.txt b/Documentation/RelNotes/2.32.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.32.0.txt
rename to Documentation/RelNotes/2.32.0.adoc
diff --git a/Documentation/RelNotes/2.32.1.txt b/Documentation/RelNotes/2.32.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.32.1.txt
rename to Documentation/RelNotes/2.32.1.adoc
diff --git a/Documentation/RelNotes/2.32.2.txt b/Documentation/RelNotes/2.32.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.32.2.txt
rename to Documentation/RelNotes/2.32.2.adoc
diff --git a/Documentation/RelNotes/2.32.3.txt b/Documentation/RelNotes/2.32.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.32.3.txt
rename to Documentation/RelNotes/2.32.3.adoc
diff --git a/Documentation/RelNotes/2.32.4.txt b/Documentation/RelNotes/2.32.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.32.4.txt
rename to Documentation/RelNotes/2.32.4.adoc
diff --git a/Documentation/RelNotes/2.32.5.txt b/Documentation/RelNotes/2.32.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.32.5.txt
rename to Documentation/RelNotes/2.32.5.adoc
diff --git a/Documentation/RelNotes/2.32.6.txt b/Documentation/RelNotes/2.32.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.32.6.txt
rename to Documentation/RelNotes/2.32.6.adoc
diff --git a/Documentation/RelNotes/2.32.7.txt b/Documentation/RelNotes/2.32.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.32.7.txt
rename to Documentation/RelNotes/2.32.7.adoc
diff --git a/Documentation/RelNotes/2.33.0.txt b/Documentation/RelNotes/2.33.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.33.0.txt
rename to Documentation/RelNotes/2.33.0.adoc
diff --git a/Documentation/RelNotes/2.33.1.txt b/Documentation/RelNotes/2.33.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.33.1.txt
rename to Documentation/RelNotes/2.33.1.adoc
diff --git a/Documentation/RelNotes/2.33.2.txt b/Documentation/RelNotes/2.33.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.33.2.txt
rename to Documentation/RelNotes/2.33.2.adoc
diff --git a/Documentation/RelNotes/2.33.3.txt b/Documentation/RelNotes/2.33.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.33.3.txt
rename to Documentation/RelNotes/2.33.3.adoc
diff --git a/Documentation/RelNotes/2.33.4.txt b/Documentation/RelNotes/2.33.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.33.4.txt
rename to Documentation/RelNotes/2.33.4.adoc
diff --git a/Documentation/RelNotes/2.33.5.txt b/Documentation/RelNotes/2.33.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.33.5.txt
rename to Documentation/RelNotes/2.33.5.adoc
diff --git a/Documentation/RelNotes/2.33.6.txt b/Documentation/RelNotes/2.33.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.33.6.txt
rename to Documentation/RelNotes/2.33.6.adoc
diff --git a/Documentation/RelNotes/2.33.7.txt b/Documentation/RelNotes/2.33.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.33.7.txt
rename to Documentation/RelNotes/2.33.7.adoc
diff --git a/Documentation/RelNotes/2.33.8.txt b/Documentation/RelNotes/2.33.8.adoc
similarity index 100%
rename from Documentation/RelNotes/2.33.8.txt
rename to Documentation/RelNotes/2.33.8.adoc
diff --git a/Documentation/RelNotes/2.34.0.txt b/Documentation/RelNotes/2.34.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.34.0.txt
rename to Documentation/RelNotes/2.34.0.adoc
diff --git a/Documentation/RelNotes/2.34.1.txt b/Documentation/RelNotes/2.34.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.34.1.txt
rename to Documentation/RelNotes/2.34.1.adoc
diff --git a/Documentation/RelNotes/2.34.2.txt b/Documentation/RelNotes/2.34.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.34.2.txt
rename to Documentation/RelNotes/2.34.2.adoc
diff --git a/Documentation/RelNotes/2.34.3.txt b/Documentation/RelNotes/2.34.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.34.3.txt
rename to Documentation/RelNotes/2.34.3.adoc
diff --git a/Documentation/RelNotes/2.34.4.txt b/Documentation/RelNotes/2.34.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.34.4.txt
rename to Documentation/RelNotes/2.34.4.adoc
diff --git a/Documentation/RelNotes/2.34.5.txt b/Documentation/RelNotes/2.34.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.34.5.txt
rename to Documentation/RelNotes/2.34.5.adoc
diff --git a/Documentation/RelNotes/2.34.6.txt b/Documentation/RelNotes/2.34.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.34.6.txt
rename to Documentation/RelNotes/2.34.6.adoc
diff --git a/Documentation/RelNotes/2.34.7.txt b/Documentation/RelNotes/2.34.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.34.7.txt
rename to Documentation/RelNotes/2.34.7.adoc
diff --git a/Documentation/RelNotes/2.34.8.txt b/Documentation/RelNotes/2.34.8.adoc
similarity index 100%
rename from Documentation/RelNotes/2.34.8.txt
rename to Documentation/RelNotes/2.34.8.adoc
diff --git a/Documentation/RelNotes/2.35.0.txt b/Documentation/RelNotes/2.35.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.35.0.txt
rename to Documentation/RelNotes/2.35.0.adoc
diff --git a/Documentation/RelNotes/2.35.1.txt b/Documentation/RelNotes/2.35.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.35.1.txt
rename to Documentation/RelNotes/2.35.1.adoc
diff --git a/Documentation/RelNotes/2.35.2.txt b/Documentation/RelNotes/2.35.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.35.2.txt
rename to Documentation/RelNotes/2.35.2.adoc
diff --git a/Documentation/RelNotes/2.35.3.txt b/Documentation/RelNotes/2.35.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.35.3.txt
rename to Documentation/RelNotes/2.35.3.adoc
diff --git a/Documentation/RelNotes/2.35.4.txt b/Documentation/RelNotes/2.35.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.35.4.txt
rename to Documentation/RelNotes/2.35.4.adoc
diff --git a/Documentation/RelNotes/2.35.5.txt b/Documentation/RelNotes/2.35.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.35.5.txt
rename to Documentation/RelNotes/2.35.5.adoc
diff --git a/Documentation/RelNotes/2.35.6.txt b/Documentation/RelNotes/2.35.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.35.6.txt
rename to Documentation/RelNotes/2.35.6.adoc
diff --git a/Documentation/RelNotes/2.35.7.txt b/Documentation/RelNotes/2.35.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.35.7.txt
rename to Documentation/RelNotes/2.35.7.adoc
diff --git a/Documentation/RelNotes/2.35.8.txt b/Documentation/RelNotes/2.35.8.adoc
similarity index 100%
rename from Documentation/RelNotes/2.35.8.txt
rename to Documentation/RelNotes/2.35.8.adoc
diff --git a/Documentation/RelNotes/2.36.0.txt b/Documentation/RelNotes/2.36.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.36.0.txt
rename to Documentation/RelNotes/2.36.0.adoc
diff --git a/Documentation/RelNotes/2.36.1.txt b/Documentation/RelNotes/2.36.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.36.1.txt
rename to Documentation/RelNotes/2.36.1.adoc
diff --git a/Documentation/RelNotes/2.36.2.txt b/Documentation/RelNotes/2.36.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.36.2.txt
rename to Documentation/RelNotes/2.36.2.adoc
diff --git a/Documentation/RelNotes/2.36.3.txt b/Documentation/RelNotes/2.36.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.36.3.txt
rename to Documentation/RelNotes/2.36.3.adoc
diff --git a/Documentation/RelNotes/2.36.4.txt b/Documentation/RelNotes/2.36.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.36.4.txt
rename to Documentation/RelNotes/2.36.4.adoc
diff --git a/Documentation/RelNotes/2.36.5.txt b/Documentation/RelNotes/2.36.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.36.5.txt
rename to Documentation/RelNotes/2.36.5.adoc
diff --git a/Documentation/RelNotes/2.36.6.txt b/Documentation/RelNotes/2.36.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.36.6.txt
rename to Documentation/RelNotes/2.36.6.adoc
diff --git a/Documentation/RelNotes/2.37.0.txt b/Documentation/RelNotes/2.37.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.37.0.txt
rename to Documentation/RelNotes/2.37.0.adoc
diff --git a/Documentation/RelNotes/2.37.1.txt b/Documentation/RelNotes/2.37.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.37.1.txt
rename to Documentation/RelNotes/2.37.1.adoc
diff --git a/Documentation/RelNotes/2.37.2.txt b/Documentation/RelNotes/2.37.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.37.2.txt
rename to Documentation/RelNotes/2.37.2.adoc
diff --git a/Documentation/RelNotes/2.37.3.txt b/Documentation/RelNotes/2.37.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.37.3.txt
rename to Documentation/RelNotes/2.37.3.adoc
diff --git a/Documentation/RelNotes/2.37.4.txt b/Documentation/RelNotes/2.37.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.37.4.txt
rename to Documentation/RelNotes/2.37.4.adoc
diff --git a/Documentation/RelNotes/2.37.5.txt b/Documentation/RelNotes/2.37.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.37.5.txt
rename to Documentation/RelNotes/2.37.5.adoc
diff --git a/Documentation/RelNotes/2.37.6.txt b/Documentation/RelNotes/2.37.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.37.6.txt
rename to Documentation/RelNotes/2.37.6.adoc
diff --git a/Documentation/RelNotes/2.37.7.txt b/Documentation/RelNotes/2.37.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.37.7.txt
rename to Documentation/RelNotes/2.37.7.adoc
diff --git a/Documentation/RelNotes/2.38.0.txt b/Documentation/RelNotes/2.38.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.38.0.txt
rename to Documentation/RelNotes/2.38.0.adoc
diff --git a/Documentation/RelNotes/2.38.1.txt b/Documentation/RelNotes/2.38.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.38.1.txt
rename to Documentation/RelNotes/2.38.1.adoc
diff --git a/Documentation/RelNotes/2.38.2.txt b/Documentation/RelNotes/2.38.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.38.2.txt
rename to Documentation/RelNotes/2.38.2.adoc
diff --git a/Documentation/RelNotes/2.38.3.txt b/Documentation/RelNotes/2.38.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.38.3.txt
rename to Documentation/RelNotes/2.38.3.adoc
diff --git a/Documentation/RelNotes/2.38.4.txt b/Documentation/RelNotes/2.38.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.38.4.txt
rename to Documentation/RelNotes/2.38.4.adoc
diff --git a/Documentation/RelNotes/2.38.5.txt b/Documentation/RelNotes/2.38.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.38.5.txt
rename to Documentation/RelNotes/2.38.5.adoc
diff --git a/Documentation/RelNotes/2.39.0.txt b/Documentation/RelNotes/2.39.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.39.0.txt
rename to Documentation/RelNotes/2.39.0.adoc
diff --git a/Documentation/RelNotes/2.39.1.txt b/Documentation/RelNotes/2.39.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.39.1.txt
rename to Documentation/RelNotes/2.39.1.adoc
diff --git a/Documentation/RelNotes/2.39.2.txt b/Documentation/RelNotes/2.39.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.39.2.txt
rename to Documentation/RelNotes/2.39.2.adoc
diff --git a/Documentation/RelNotes/2.39.3.txt b/Documentation/RelNotes/2.39.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.39.3.txt
rename to Documentation/RelNotes/2.39.3.adoc
diff --git a/Documentation/RelNotes/2.39.4.txt b/Documentation/RelNotes/2.39.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.39.4.txt
rename to Documentation/RelNotes/2.39.4.adoc
diff --git a/Documentation/RelNotes/2.39.5.txt b/Documentation/RelNotes/2.39.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.39.5.txt
rename to Documentation/RelNotes/2.39.5.adoc
diff --git a/Documentation/RelNotes/2.4.0.txt b/Documentation/RelNotes/2.4.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.0.txt
rename to Documentation/RelNotes/2.4.0.adoc
diff --git a/Documentation/RelNotes/2.4.1.txt b/Documentation/RelNotes/2.4.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.1.txt
rename to Documentation/RelNotes/2.4.1.adoc
diff --git a/Documentation/RelNotes/2.4.10.txt b/Documentation/RelNotes/2.4.10.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.10.txt
rename to Documentation/RelNotes/2.4.10.adoc
diff --git a/Documentation/RelNotes/2.4.11.txt b/Documentation/RelNotes/2.4.11.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.11.txt
rename to Documentation/RelNotes/2.4.11.adoc
diff --git a/Documentation/RelNotes/2.4.12.txt b/Documentation/RelNotes/2.4.12.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.12.txt
rename to Documentation/RelNotes/2.4.12.adoc
diff --git a/Documentation/RelNotes/2.4.2.txt b/Documentation/RelNotes/2.4.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.2.txt
rename to Documentation/RelNotes/2.4.2.adoc
diff --git a/Documentation/RelNotes/2.4.3.txt b/Documentation/RelNotes/2.4.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.3.txt
rename to Documentation/RelNotes/2.4.3.adoc
diff --git a/Documentation/RelNotes/2.4.4.txt b/Documentation/RelNotes/2.4.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.4.txt
rename to Documentation/RelNotes/2.4.4.adoc
diff --git a/Documentation/RelNotes/2.4.5.txt b/Documentation/RelNotes/2.4.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.5.txt
rename to Documentation/RelNotes/2.4.5.adoc
diff --git a/Documentation/RelNotes/2.4.6.txt b/Documentation/RelNotes/2.4.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.6.txt
rename to Documentation/RelNotes/2.4.6.adoc
diff --git a/Documentation/RelNotes/2.4.7.txt b/Documentation/RelNotes/2.4.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.7.txt
rename to Documentation/RelNotes/2.4.7.adoc
diff --git a/Documentation/RelNotes/2.4.8.txt b/Documentation/RelNotes/2.4.8.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.8.txt
rename to Documentation/RelNotes/2.4.8.adoc
diff --git a/Documentation/RelNotes/2.4.9.txt b/Documentation/RelNotes/2.4.9.adoc
similarity index 100%
rename from Documentation/RelNotes/2.4.9.txt
rename to Documentation/RelNotes/2.4.9.adoc
diff --git a/Documentation/RelNotes/2.40.0.txt b/Documentation/RelNotes/2.40.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.40.0.txt
rename to Documentation/RelNotes/2.40.0.adoc
diff --git a/Documentation/RelNotes/2.40.1.txt b/Documentation/RelNotes/2.40.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.40.1.txt
rename to Documentation/RelNotes/2.40.1.adoc
diff --git a/Documentation/RelNotes/2.40.2.txt b/Documentation/RelNotes/2.40.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.40.2.txt
rename to Documentation/RelNotes/2.40.2.adoc
diff --git a/Documentation/RelNotes/2.40.3.txt b/Documentation/RelNotes/2.40.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.40.3.txt
rename to Documentation/RelNotes/2.40.3.adoc
diff --git a/Documentation/RelNotes/2.40.4.txt b/Documentation/RelNotes/2.40.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.40.4.txt
rename to Documentation/RelNotes/2.40.4.adoc
diff --git a/Documentation/RelNotes/2.41.0.txt b/Documentation/RelNotes/2.41.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.41.0.txt
rename to Documentation/RelNotes/2.41.0.adoc
diff --git a/Documentation/RelNotes/2.41.1.txt b/Documentation/RelNotes/2.41.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.41.1.txt
rename to Documentation/RelNotes/2.41.1.adoc
diff --git a/Documentation/RelNotes/2.41.2.txt b/Documentation/RelNotes/2.41.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.41.2.txt
rename to Documentation/RelNotes/2.41.2.adoc
diff --git a/Documentation/RelNotes/2.41.3.txt b/Documentation/RelNotes/2.41.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.41.3.txt
rename to Documentation/RelNotes/2.41.3.adoc
diff --git a/Documentation/RelNotes/2.42.0.txt b/Documentation/RelNotes/2.42.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.42.0.txt
rename to Documentation/RelNotes/2.42.0.adoc
diff --git a/Documentation/RelNotes/2.42.1.txt b/Documentation/RelNotes/2.42.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.42.1.txt
rename to Documentation/RelNotes/2.42.1.adoc
diff --git a/Documentation/RelNotes/2.42.2.txt b/Documentation/RelNotes/2.42.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.42.2.txt
rename to Documentation/RelNotes/2.42.2.adoc
diff --git a/Documentation/RelNotes/2.42.3.txt b/Documentation/RelNotes/2.42.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.42.3.txt
rename to Documentation/RelNotes/2.42.3.adoc
diff --git a/Documentation/RelNotes/2.42.4.txt b/Documentation/RelNotes/2.42.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.42.4.txt
rename to Documentation/RelNotes/2.42.4.adoc
diff --git a/Documentation/RelNotes/2.43.0.txt b/Documentation/RelNotes/2.43.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.43.0.txt
rename to Documentation/RelNotes/2.43.0.adoc
diff --git a/Documentation/RelNotes/2.43.1.txt b/Documentation/RelNotes/2.43.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.43.1.txt
rename to Documentation/RelNotes/2.43.1.adoc
diff --git a/Documentation/RelNotes/2.43.2.txt b/Documentation/RelNotes/2.43.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.43.2.txt
rename to Documentation/RelNotes/2.43.2.adoc
diff --git a/Documentation/RelNotes/2.43.3.txt b/Documentation/RelNotes/2.43.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.43.3.txt
rename to Documentation/RelNotes/2.43.3.adoc
diff --git a/Documentation/RelNotes/2.43.4.txt b/Documentation/RelNotes/2.43.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.43.4.txt
rename to Documentation/RelNotes/2.43.4.adoc
diff --git a/Documentation/RelNotes/2.43.5.txt b/Documentation/RelNotes/2.43.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.43.5.txt
rename to Documentation/RelNotes/2.43.5.adoc
diff --git a/Documentation/RelNotes/2.43.6.txt b/Documentation/RelNotes/2.43.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.43.6.txt
rename to Documentation/RelNotes/2.43.6.adoc
diff --git a/Documentation/RelNotes/2.44.0.txt b/Documentation/RelNotes/2.44.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.44.0.txt
rename to Documentation/RelNotes/2.44.0.adoc
diff --git a/Documentation/RelNotes/2.44.1.txt b/Documentation/RelNotes/2.44.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.44.1.txt
rename to Documentation/RelNotes/2.44.1.adoc
diff --git a/Documentation/RelNotes/2.44.2.txt b/Documentation/RelNotes/2.44.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.44.2.txt
rename to Documentation/RelNotes/2.44.2.adoc
diff --git a/Documentation/RelNotes/2.44.3.txt b/Documentation/RelNotes/2.44.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.44.3.txt
rename to Documentation/RelNotes/2.44.3.adoc
diff --git a/Documentation/RelNotes/2.45.0.txt b/Documentation/RelNotes/2.45.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.45.0.txt
rename to Documentation/RelNotes/2.45.0.adoc
diff --git a/Documentation/RelNotes/2.45.1.txt b/Documentation/RelNotes/2.45.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.45.1.txt
rename to Documentation/RelNotes/2.45.1.adoc
diff --git a/Documentation/RelNotes/2.45.2.txt b/Documentation/RelNotes/2.45.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.45.2.txt
rename to Documentation/RelNotes/2.45.2.adoc
diff --git a/Documentation/RelNotes/2.45.3.txt b/Documentation/RelNotes/2.45.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.45.3.txt
rename to Documentation/RelNotes/2.45.3.adoc
diff --git a/Documentation/RelNotes/2.46.0.txt b/Documentation/RelNotes/2.46.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.46.0.txt
rename to Documentation/RelNotes/2.46.0.adoc
diff --git a/Documentation/RelNotes/2.46.1.txt b/Documentation/RelNotes/2.46.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.46.1.txt
rename to Documentation/RelNotes/2.46.1.adoc
diff --git a/Documentation/RelNotes/2.46.2.txt b/Documentation/RelNotes/2.46.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.46.2.txt
rename to Documentation/RelNotes/2.46.2.adoc
diff --git a/Documentation/RelNotes/2.46.3.txt b/Documentation/RelNotes/2.46.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.46.3.txt
rename to Documentation/RelNotes/2.46.3.adoc
diff --git a/Documentation/RelNotes/2.47.0.txt b/Documentation/RelNotes/2.47.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.47.0.txt
rename to Documentation/RelNotes/2.47.0.adoc
diff --git a/Documentation/RelNotes/2.47.1.txt b/Documentation/RelNotes/2.47.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.47.1.txt
rename to Documentation/RelNotes/2.47.1.adoc
diff --git a/Documentation/RelNotes/2.47.2.txt b/Documentation/RelNotes/2.47.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.47.2.txt
rename to Documentation/RelNotes/2.47.2.adoc
diff --git a/Documentation/RelNotes/2.48.0.txt b/Documentation/RelNotes/2.48.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.48.0.txt
rename to Documentation/RelNotes/2.48.0.adoc
diff --git a/Documentation/RelNotes/2.48.1.txt b/Documentation/RelNotes/2.48.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.48.1.txt
rename to Documentation/RelNotes/2.48.1.adoc
diff --git a/Documentation/RelNotes/2.49.0.txt b/Documentation/RelNotes/2.49.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.49.0.txt
rename to Documentation/RelNotes/2.49.0.adoc
diff --git a/Documentation/RelNotes/2.5.0.txt b/Documentation/RelNotes/2.5.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.5.0.txt
rename to Documentation/RelNotes/2.5.0.adoc
diff --git a/Documentation/RelNotes/2.5.1.txt b/Documentation/RelNotes/2.5.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.5.1.txt
rename to Documentation/RelNotes/2.5.1.adoc
diff --git a/Documentation/RelNotes/2.5.2.txt b/Documentation/RelNotes/2.5.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.5.2.txt
rename to Documentation/RelNotes/2.5.2.adoc
diff --git a/Documentation/RelNotes/2.5.3.txt b/Documentation/RelNotes/2.5.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.5.3.txt
rename to Documentation/RelNotes/2.5.3.adoc
diff --git a/Documentation/RelNotes/2.5.4.txt b/Documentation/RelNotes/2.5.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.5.4.txt
rename to Documentation/RelNotes/2.5.4.adoc
diff --git a/Documentation/RelNotes/2.5.5.txt b/Documentation/RelNotes/2.5.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.5.5.txt
rename to Documentation/RelNotes/2.5.5.adoc
diff --git a/Documentation/RelNotes/2.5.6.txt b/Documentation/RelNotes/2.5.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.5.6.txt
rename to Documentation/RelNotes/2.5.6.adoc
diff --git a/Documentation/RelNotes/2.6.0.txt b/Documentation/RelNotes/2.6.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.6.0.txt
rename to Documentation/RelNotes/2.6.0.adoc
diff --git a/Documentation/RelNotes/2.6.1.txt b/Documentation/RelNotes/2.6.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.6.1.txt
rename to Documentation/RelNotes/2.6.1.adoc
diff --git a/Documentation/RelNotes/2.6.2.txt b/Documentation/RelNotes/2.6.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.6.2.txt
rename to Documentation/RelNotes/2.6.2.adoc
diff --git a/Documentation/RelNotes/2.6.3.txt b/Documentation/RelNotes/2.6.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.6.3.txt
rename to Documentation/RelNotes/2.6.3.adoc
diff --git a/Documentation/RelNotes/2.6.4.txt b/Documentation/RelNotes/2.6.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.6.4.txt
rename to Documentation/RelNotes/2.6.4.adoc
diff --git a/Documentation/RelNotes/2.6.5.txt b/Documentation/RelNotes/2.6.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.6.5.txt
rename to Documentation/RelNotes/2.6.5.adoc
diff --git a/Documentation/RelNotes/2.6.6.txt b/Documentation/RelNotes/2.6.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.6.6.txt
rename to Documentation/RelNotes/2.6.6.adoc
diff --git a/Documentation/RelNotes/2.6.7.txt b/Documentation/RelNotes/2.6.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.6.7.txt
rename to Documentation/RelNotes/2.6.7.adoc
diff --git a/Documentation/RelNotes/2.7.0.txt b/Documentation/RelNotes/2.7.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.7.0.txt
rename to Documentation/RelNotes/2.7.0.adoc
diff --git a/Documentation/RelNotes/2.7.1.txt b/Documentation/RelNotes/2.7.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.7.1.txt
rename to Documentation/RelNotes/2.7.1.adoc
diff --git a/Documentation/RelNotes/2.7.2.txt b/Documentation/RelNotes/2.7.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.7.2.txt
rename to Documentation/RelNotes/2.7.2.adoc
diff --git a/Documentation/RelNotes/2.7.3.txt b/Documentation/RelNotes/2.7.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.7.3.txt
rename to Documentation/RelNotes/2.7.3.adoc
diff --git a/Documentation/RelNotes/2.7.4.txt b/Documentation/RelNotes/2.7.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.7.4.txt
rename to Documentation/RelNotes/2.7.4.adoc
diff --git a/Documentation/RelNotes/2.7.5.txt b/Documentation/RelNotes/2.7.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.7.5.txt
rename to Documentation/RelNotes/2.7.5.adoc
diff --git a/Documentation/RelNotes/2.7.6.txt b/Documentation/RelNotes/2.7.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.7.6.txt
rename to Documentation/RelNotes/2.7.6.adoc
diff --git a/Documentation/RelNotes/2.8.0.txt b/Documentation/RelNotes/2.8.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.8.0.txt
rename to Documentation/RelNotes/2.8.0.adoc
diff --git a/Documentation/RelNotes/2.8.1.txt b/Documentation/RelNotes/2.8.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.8.1.txt
rename to Documentation/RelNotes/2.8.1.adoc
diff --git a/Documentation/RelNotes/2.8.2.txt b/Documentation/RelNotes/2.8.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.8.2.txt
rename to Documentation/RelNotes/2.8.2.adoc
diff --git a/Documentation/RelNotes/2.8.3.txt b/Documentation/RelNotes/2.8.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.8.3.txt
rename to Documentation/RelNotes/2.8.3.adoc
diff --git a/Documentation/RelNotes/2.8.4.txt b/Documentation/RelNotes/2.8.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.8.4.txt
rename to Documentation/RelNotes/2.8.4.adoc
diff --git a/Documentation/RelNotes/2.8.5.txt b/Documentation/RelNotes/2.8.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.8.5.txt
rename to Documentation/RelNotes/2.8.5.adoc
diff --git a/Documentation/RelNotes/2.8.6.txt b/Documentation/RelNotes/2.8.6.adoc
similarity index 100%
rename from Documentation/RelNotes/2.8.6.txt
rename to Documentation/RelNotes/2.8.6.adoc
diff --git a/Documentation/RelNotes/2.9.0.txt b/Documentation/RelNotes/2.9.0.adoc
similarity index 100%
rename from Documentation/RelNotes/2.9.0.txt
rename to Documentation/RelNotes/2.9.0.adoc
diff --git a/Documentation/RelNotes/2.9.1.txt b/Documentation/RelNotes/2.9.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.9.1.txt
rename to Documentation/RelNotes/2.9.1.adoc
diff --git a/Documentation/RelNotes/2.9.2.txt b/Documentation/RelNotes/2.9.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.9.2.txt
rename to Documentation/RelNotes/2.9.2.adoc
diff --git a/Documentation/RelNotes/2.9.3.txt b/Documentation/RelNotes/2.9.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.9.3.txt
rename to Documentation/RelNotes/2.9.3.adoc
diff --git a/Documentation/RelNotes/2.9.4.txt b/Documentation/RelNotes/2.9.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.9.4.txt
rename to Documentation/RelNotes/2.9.4.adoc
diff --git a/Documentation/RelNotes/2.9.5.txt b/Documentation/RelNotes/2.9.5.adoc
similarity index 100%
rename from Documentation/RelNotes/2.9.5.txt
rename to Documentation/RelNotes/2.9.5.adoc
diff --git a/Documentation/ReviewingGuidelines.txt b/Documentation/ReviewingGuidelines.adoc
similarity index 100%
rename from Documentation/ReviewingGuidelines.txt
rename to Documentation/ReviewingGuidelines.adoc
diff --git a/Documentation/ToolsForGit.txt b/Documentation/ToolsForGit.adoc
similarity index 100%
rename from Documentation/ToolsForGit.txt
rename to Documentation/ToolsForGit.adoc
diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.adoc
similarity index 99%
rename from Documentation/blame-options.txt
rename to Documentation/blame-options.adoc
index 552dcc60f2..aa77406d4e 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.adoc
@@ -18,7 +18,7 @@
 '<start>' and '<end>' are optional. `-L <start>` or `-L <start>,` spans from
 '<start>' to end of file. `-L ,<end>` spans from start of file to '<end>'.
 +
-include::line-range-format.txt[]
+include::line-range-format.adoc[]
 
 -l::
 	Show long rev (Default: off).
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index e260a98977..0a0c1b3f61 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -5,11 +5,11 @@
 sub format_one {
 	my ($source_dir, $out, $nameattr) = @_;
 	my ($name, $attr) = @$nameattr;
-	my ($path) = "$source_dir/Documentation/$name.txt";
+	my ($path) = "$source_dir/Documentation/$name.adoc";
 	my ($state, $description);
 	my $mansection;
 	$state = 0;
-	open I, '<', "$path" or die "No such file $path.txt";
+	open I, '<', "$path" or die "No such file $path.adoc";
 	while (<I>) {
 		if (/^(?:git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
 			$mansection = $1;
@@ -30,7 +30,7 @@ sub format_one {
 	}
 	close I;
 	if (!defined $description) {
-		die "No description found in $path.txt";
+		die "No description found in $path.adoc";
 	}
 	if (my ($verify_name, $text) = ($description =~ /^($name) - (.*)/)) {
 		print $out "linkgit:$name\[$mansection\]::\n\t";
@@ -63,7 +63,7 @@ sub format_one {
 close IN;
 
 for my $out (@categories) {
-	my ($cat) = $out =~ /^cmds-(.*)\.txt$/;
+	my ($cat) = $out =~ /^cmds-(.*)\.adoc$/;
 	my ($path) = "$build_dir/$out";
 	open O, '>', "$path+" or die "Cannot open output file $out+";
 	for (@{$cmds{$cat}}) {
diff --git a/Documentation/config.txt b/Documentation/config.adoc
similarity index 84%
rename from Documentation/config.txt
rename to Documentation/config.adoc
index 8c0b3ed807..812b43c43d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.adoc
@@ -372,186 +372,186 @@ inventing new variables for use in your own tool, make sure their
 names do not conflict with those that are used by Git itself and
 other popular tools, and describe them in your documentation.
 
-include::config/add.txt[]
+include::config/add.adoc[]
 
-include::config/advice.txt[]
+include::config/advice.adoc[]
 
-include::config/alias.txt[]
+include::config/alias.adoc[]
 
-include::config/am.txt[]
+include::config/am.adoc[]
 
-include::config/apply.txt[]
+include::config/apply.adoc[]
 
-include::config/attr.txt[]
+include::config/attr.adoc[]
 
-include::config/bitmap-pseudo-merge.txt[]
+include::config/bitmap-pseudo-merge.adoc[]
 
-include::config/blame.txt[]
+include::config/blame.adoc[]
 
-include::config/branch.txt[]
+include::config/branch.adoc[]
 
-include::config/browser.txt[]
+include::config/browser.adoc[]
 
-include::config/bundle.txt[]
+include::config/bundle.adoc[]
 
-include::config/checkout.txt[]
+include::config/checkout.adoc[]
 
-include::config/clean.txt[]
+include::config/clean.adoc[]
 
-include::config/clone.txt[]
+include::config/clone.adoc[]
 
-include::config/color.txt[]
+include::config/color.adoc[]
 
-include::config/column.txt[]
+include::config/column.adoc[]
 
-include::config/commit.txt[]
+include::config/commit.adoc[]
 
-include::config/commitgraph.txt[]
+include::config/commitgraph.adoc[]
 
-include::config/completion.txt[]
+include::config/completion.adoc[]
 
-include::config/core.txt[]
+include::config/core.adoc[]
 
-include::config/credential.txt[]
+include::config/credential.adoc[]
 
-include::config/diff.txt[]
+include::config/diff.adoc[]
 
-include::config/difftool.txt[]
+include::config/difftool.adoc[]
 
-include::config/extensions.txt[]
+include::config/extensions.adoc[]
 
-include::config/fastimport.txt[]
+include::config/fastimport.adoc[]
 
-include::config/feature.txt[]
+include::config/feature.adoc[]
 
-include::config/fetch.txt[]
+include::config/fetch.adoc[]
 
-include::config/filter.txt[]
+include::config/filter.adoc[]
 
-include::config/format.txt[]
+include::config/format.adoc[]
 
-include::config/fsck.txt[]
+include::config/fsck.adoc[]
 
-include::config/fsmonitor--daemon.txt[]
+include::config/fsmonitor--daemon.adoc[]
 
-include::config/gc.txt[]
+include::config/gc.adoc[]
 
-include::config/gitcvs.txt[]
+include::config/gitcvs.adoc[]
 
-include::config/gitweb.txt[]
+include::config/gitweb.adoc[]
 
-include::config/gpg.txt[]
+include::config/gpg.adoc[]
 
-include::config/grep.txt[]
+include::config/grep.adoc[]
 
-include::config/gui.txt[]
+include::config/gui.adoc[]
 
-include::config/guitool.txt[]
+include::config/guitool.adoc[]
 
-include::config/help.txt[]
+include::config/help.adoc[]
 
-include::config/http.txt[]
+include::config/http.adoc[]
 
-include::config/i18n.txt[]
+include::config/i18n.adoc[]
 
-include::config/imap.txt[]
+include::config/imap.adoc[]
 
-include::config/includeif.txt[]
+include::config/includeif.adoc[]
 
-include::config/index.txt[]
+include::config/index.adoc[]
 
-include::config/init.txt[]
+include::config/init.adoc[]
 
-include::config/instaweb.txt[]
+include::config/instaweb.adoc[]
 
-include::config/interactive.txt[]
+include::config/interactive.adoc[]
 
-include::config/log.txt[]
+include::config/log.adoc[]
 
-include::config/lsrefs.txt[]
+include::config/lsrefs.adoc[]
 
-include::config/mailinfo.txt[]
+include::config/mailinfo.adoc[]
 
-include::config/mailmap.txt[]
+include::config/mailmap.adoc[]
 
-include::config/maintenance.txt[]
+include::config/maintenance.adoc[]
 
-include::config/man.txt[]
+include::config/man.adoc[]
 
-include::config/merge.txt[]
+include::config/merge.adoc[]
 
-include::config/mergetool.txt[]
+include::config/mergetool.adoc[]
 
-include::config/notes.txt[]
+include::config/notes.adoc[]
 
-include::config/pack.txt[]
+include::config/pack.adoc[]
 
-include::config/pager.txt[]
+include::config/pager.adoc[]
 
-include::config/pretty.txt[]
+include::config/pretty.adoc[]
 
-include::config/promisor.txt[]
+include::config/promisor.adoc[]
 
-include::config/protocol.txt[]
+include::config/protocol.adoc[]
 
-include::config/pull.txt[]
+include::config/pull.adoc[]
 
-include::config/push.txt[]
+include::config/push.adoc[]
 
-include::config/rebase.txt[]
+include::config/rebase.adoc[]
 
-include::config/receive.txt[]
+include::config/receive.adoc[]
 
-include::config/reftable.txt[]
+include::config/reftable.adoc[]
 
-include::config/remote.txt[]
+include::config/remote.adoc[]
 
-include::config/remotes.txt[]
+include::config/remotes.adoc[]
 
-include::config/repack.txt[]
+include::config/repack.adoc[]
 
-include::config/rerere.txt[]
+include::config/rerere.adoc[]
 
-include::config/revert.txt[]
+include::config/revert.adoc[]
 
-include::config/safe.txt[]
+include::config/safe.adoc[]
 
-include::config/sendemail.txt[]
+include::config/sendemail.adoc[]
 
-include::config/sequencer.txt[]
+include::config/sequencer.adoc[]
 
-include::config/showbranch.txt[]
+include::config/showbranch.adoc[]
 
-include::config/sparse.txt[]
+include::config/sparse.adoc[]
 
-include::config/splitindex.txt[]
+include::config/splitindex.adoc[]
 
-include::config/ssh.txt[]
+include::config/ssh.adoc[]
 
-include::config/stash.txt[]
+include::config/stash.adoc[]
 
-include::config/status.txt[]
+include::config/status.adoc[]
 
-include::config/submodule.txt[]
+include::config/submodule.adoc[]
 
-include::config/tag.txt[]
+include::config/tag.adoc[]
 
-include::config/tar.txt[]
+include::config/tar.adoc[]
 
-include::config/trace2.txt[]
+include::config/trace2.adoc[]
 
-include::config/transfer.txt[]
+include::config/transfer.adoc[]
 
-include::config/uploadarchive.txt[]
+include::config/uploadarchive.adoc[]
 
-include::config/uploadpack.txt[]
+include::config/uploadpack.adoc[]
 
-include::config/url.txt[]
+include::config/url.adoc[]
 
-include::config/user.txt[]
+include::config/user.adoc[]
 
-include::config/versionsort.txt[]
+include::config/versionsort.adoc[]
 
-include::config/web.txt[]
+include::config/web.adoc[]
 
-include::config/worktree.txt[]
+include::config/worktree.adoc[]
diff --git a/Documentation/config/add.txt b/Documentation/config/add.adoc
similarity index 100%
rename from Documentation/config/add.txt
rename to Documentation/config/add.adoc
diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.adoc
similarity index 100%
rename from Documentation/config/advice.txt
rename to Documentation/config/advice.adoc
diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.adoc
similarity index 100%
rename from Documentation/config/alias.txt
rename to Documentation/config/alias.adoc
diff --git a/Documentation/config/am.txt b/Documentation/config/am.adoc
similarity index 100%
rename from Documentation/config/am.txt
rename to Documentation/config/am.adoc
diff --git a/Documentation/config/apply.txt b/Documentation/config/apply.adoc
similarity index 100%
rename from Documentation/config/apply.txt
rename to Documentation/config/apply.adoc
diff --git a/Documentation/config/attr.txt b/Documentation/config/attr.adoc
similarity index 100%
rename from Documentation/config/attr.txt
rename to Documentation/config/attr.adoc
diff --git a/Documentation/config/bitmap-pseudo-merge.txt b/Documentation/config/bitmap-pseudo-merge.adoc
similarity index 100%
rename from Documentation/config/bitmap-pseudo-merge.txt
rename to Documentation/config/bitmap-pseudo-merge.adoc
diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.adoc
similarity index 100%
rename from Documentation/config/blame.txt
rename to Documentation/config/blame.adoc
diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.adoc
similarity index 100%
rename from Documentation/config/branch.txt
rename to Documentation/config/branch.adoc
diff --git a/Documentation/config/browser.txt b/Documentation/config/browser.adoc
similarity index 100%
rename from Documentation/config/browser.txt
rename to Documentation/config/browser.adoc
diff --git a/Documentation/config/bundle.txt b/Documentation/config/bundle.adoc
similarity index 100%
rename from Documentation/config/bundle.txt
rename to Documentation/config/bundle.adoc
diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.adoc
similarity index 100%
rename from Documentation/config/checkout.txt
rename to Documentation/config/checkout.adoc
diff --git a/Documentation/config/clean.txt b/Documentation/config/clean.adoc
similarity index 100%
rename from Documentation/config/clean.txt
rename to Documentation/config/clean.adoc
diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.adoc
similarity index 100%
rename from Documentation/config/clone.txt
rename to Documentation/config/clone.adoc
diff --git a/Documentation/config/color.txt b/Documentation/config/color.adoc
similarity index 100%
rename from Documentation/config/color.txt
rename to Documentation/config/color.adoc
diff --git a/Documentation/config/column.txt b/Documentation/config/column.adoc
similarity index 100%
rename from Documentation/config/column.txt
rename to Documentation/config/column.adoc
diff --git a/Documentation/config/commit.txt b/Documentation/config/commit.adoc
similarity index 100%
rename from Documentation/config/commit.txt
rename to Documentation/config/commit.adoc
diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.adoc
similarity index 100%
rename from Documentation/config/commitgraph.txt
rename to Documentation/config/commitgraph.adoc
diff --git a/Documentation/config/completion.txt b/Documentation/config/completion.adoc
similarity index 100%
rename from Documentation/config/completion.txt
rename to Documentation/config/completion.adoc
diff --git a/Documentation/config/core.txt b/Documentation/config/core.adoc
similarity index 100%
rename from Documentation/config/core.txt
rename to Documentation/config/core.adoc
diff --git a/Documentation/config/credential.txt b/Documentation/config/credential.adoc
similarity index 100%
rename from Documentation/config/credential.txt
rename to Documentation/config/credential.adoc
diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.adoc
similarity index 99%
rename from Documentation/config/diff.txt
rename to Documentation/config/diff.adoc
index fdae13a212..b35be31861 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.adoc
@@ -218,7 +218,7 @@ endif::git-diff[]
 	Set this option to `true` to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
-include::{build_dir}/mergetools-diff.txt[]
+include::{build_dir}/mergetools-diff.adoc[]
 
 `diff.indentHeuristic`::
 	Set this option to `false` to disable the default heuristics
diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.adoc
similarity index 100%
rename from Documentation/config/difftool.txt
rename to Documentation/config/difftool.adoc
diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.adoc
similarity index 99%
rename from Documentation/config/extensions.txt
rename to Documentation/config/extensions.adoc
index 5cb4721a0e..9e2f321a6d 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.adoc
@@ -56,7 +56,7 @@ For historical reasons, this extension is respected regardless of the
 refStorage::
 	Specify the ref storage format to use. The acceptable values are:
 +
-include::../ref-storage-format.txt[]
+include::../ref-storage-format.adoc[]
 
 +
 Note that this setting should only be set by linkgit:git-init[1] or
diff --git a/Documentation/config/fastimport.txt b/Documentation/config/fastimport.adoc
similarity index 100%
rename from Documentation/config/fastimport.txt
rename to Documentation/config/fastimport.adoc
diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.adoc
similarity index 100%
rename from Documentation/config/feature.txt
rename to Documentation/config/feature.adoc
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.adoc
similarity index 100%
rename from Documentation/config/fetch.txt
rename to Documentation/config/fetch.adoc
diff --git a/Documentation/config/filter.txt b/Documentation/config/filter.adoc
similarity index 100%
rename from Documentation/config/filter.txt
rename to Documentation/config/filter.adoc
diff --git a/Documentation/config/fmt-merge-msg.txt b/Documentation/config/fmt-merge-msg.adoc
similarity index 100%
rename from Documentation/config/fmt-merge-msg.txt
rename to Documentation/config/fmt-merge-msg.adoc
diff --git a/Documentation/config/format.txt b/Documentation/config/format.adoc
similarity index 100%
rename from Documentation/config/format.txt
rename to Documentation/config/format.adoc
diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.adoc
similarity index 100%
rename from Documentation/config/fsck.txt
rename to Documentation/config/fsck.adoc
diff --git a/Documentation/config/fsmonitor--daemon.txt b/Documentation/config/fsmonitor--daemon.adoc
similarity index 100%
rename from Documentation/config/fsmonitor--daemon.txt
rename to Documentation/config/fsmonitor--daemon.adoc
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.adoc
similarity index 100%
rename from Documentation/config/gc.txt
rename to Documentation/config/gc.adoc
diff --git a/Documentation/config/gitcvs.txt b/Documentation/config/gitcvs.adoc
similarity index 100%
rename from Documentation/config/gitcvs.txt
rename to Documentation/config/gitcvs.adoc
diff --git a/Documentation/config/gitweb.txt b/Documentation/config/gitweb.adoc
similarity index 100%
rename from Documentation/config/gitweb.txt
rename to Documentation/config/gitweb.adoc
diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.adoc
similarity index 100%
rename from Documentation/config/gpg.txt
rename to Documentation/config/gpg.adoc
diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.adoc
similarity index 100%
rename from Documentation/config/grep.txt
rename to Documentation/config/grep.adoc
diff --git a/Documentation/config/gui.txt b/Documentation/config/gui.adoc
similarity index 100%
rename from Documentation/config/gui.txt
rename to Documentation/config/gui.adoc
diff --git a/Documentation/config/guitool.txt b/Documentation/config/guitool.adoc
similarity index 100%
rename from Documentation/config/guitool.txt
rename to Documentation/config/guitool.adoc
diff --git a/Documentation/config/help.txt b/Documentation/config/help.adoc
similarity index 100%
rename from Documentation/config/help.txt
rename to Documentation/config/help.adoc
diff --git a/Documentation/config/http.txt b/Documentation/config/http.adoc
similarity index 100%
rename from Documentation/config/http.txt
rename to Documentation/config/http.adoc
diff --git a/Documentation/config/i18n.txt b/Documentation/config/i18n.adoc
similarity index 100%
rename from Documentation/config/i18n.txt
rename to Documentation/config/i18n.adoc
diff --git a/Documentation/config/imap.txt b/Documentation/config/imap.adoc
similarity index 100%
rename from Documentation/config/imap.txt
rename to Documentation/config/imap.adoc
diff --git a/Documentation/config/includeif.txt b/Documentation/config/includeif.adoc
similarity index 100%
rename from Documentation/config/includeif.txt
rename to Documentation/config/includeif.adoc
diff --git a/Documentation/config/index.txt b/Documentation/config/index.adoc
similarity index 100%
rename from Documentation/config/index.txt
rename to Documentation/config/index.adoc
diff --git a/Documentation/config/init.txt b/Documentation/config/init.adoc
similarity index 100%
rename from Documentation/config/init.txt
rename to Documentation/config/init.adoc
diff --git a/Documentation/config/instaweb.txt b/Documentation/config/instaweb.adoc
similarity index 100%
rename from Documentation/config/instaweb.txt
rename to Documentation/config/instaweb.adoc
diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.adoc
similarity index 100%
rename from Documentation/config/interactive.txt
rename to Documentation/config/interactive.adoc
diff --git a/Documentation/config/log.txt b/Documentation/config/log.adoc
similarity index 100%
rename from Documentation/config/log.txt
rename to Documentation/config/log.adoc
diff --git a/Documentation/config/lsrefs.txt b/Documentation/config/lsrefs.adoc
similarity index 100%
rename from Documentation/config/lsrefs.txt
rename to Documentation/config/lsrefs.adoc
diff --git a/Documentation/config/mailinfo.txt b/Documentation/config/mailinfo.adoc
similarity index 100%
rename from Documentation/config/mailinfo.txt
rename to Documentation/config/mailinfo.adoc
diff --git a/Documentation/config/mailmap.txt b/Documentation/config/mailmap.adoc
similarity index 100%
rename from Documentation/config/mailmap.txt
rename to Documentation/config/mailmap.adoc
diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.adoc
similarity index 100%
rename from Documentation/config/maintenance.txt
rename to Documentation/config/maintenance.adoc
diff --git a/Documentation/config/man.txt b/Documentation/config/man.adoc
similarity index 100%
rename from Documentation/config/man.txt
rename to Documentation/config/man.adoc
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.adoc
similarity index 98%
rename from Documentation/config/merge.txt
rename to Documentation/config/merge.adoc
index 82554d65a0..857de5b40b 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.adoc
@@ -37,7 +37,7 @@ merge.verifySignatures::
 	If true, this is equivalent to the --verify-signatures command
 	line option. See linkgit:git-merge[1] for details.
 
-include::fmt-merge-msg.txt[]
+include::fmt-merge-msg.adoc[]
 
 merge.renameLimit::
 	The number of files to consider in the exhaustive portion of
@@ -101,7 +101,7 @@ merge.guitool::
 	Any other value is treated as a custom merge tool and requires that a
 	corresponding mergetool.<guitool>.cmd variable is defined.
 
-include::{build_dir}/mergetools-merge.txt[]
+include::{build_dir}/mergetools-merge.adoc[]
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.adoc
similarity index 100%
rename from Documentation/config/mergetool.txt
rename to Documentation/config/mergetool.adoc
diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.adoc
similarity index 100%
rename from Documentation/config/notes.txt
rename to Documentation/config/notes.adoc
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.adoc
similarity index 100%
rename from Documentation/config/pack.txt
rename to Documentation/config/pack.adoc
diff --git a/Documentation/config/pager.txt b/Documentation/config/pager.adoc
similarity index 100%
rename from Documentation/config/pager.txt
rename to Documentation/config/pager.adoc
diff --git a/Documentation/config/pretty.txt b/Documentation/config/pretty.adoc
similarity index 100%
rename from Documentation/config/pretty.txt
rename to Documentation/config/pretty.adoc
diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.adoc
similarity index 100%
rename from Documentation/config/promisor.txt
rename to Documentation/config/promisor.adoc
diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.adoc
similarity index 100%
rename from Documentation/config/protocol.txt
rename to Documentation/config/protocol.adoc
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.adoc
similarity index 100%
rename from Documentation/config/pull.txt
rename to Documentation/config/pull.adoc
diff --git a/Documentation/config/push.txt b/Documentation/config/push.adoc
similarity index 100%
rename from Documentation/config/push.txt
rename to Documentation/config/push.adoc
diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.adoc
similarity index 100%
rename from Documentation/config/rebase.txt
rename to Documentation/config/rebase.adoc
diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.adoc
similarity index 100%
rename from Documentation/config/receive.txt
rename to Documentation/config/receive.adoc
diff --git a/Documentation/config/reftable.txt b/Documentation/config/reftable.adoc
similarity index 100%
rename from Documentation/config/reftable.txt
rename to Documentation/config/reftable.adoc
diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.adoc
similarity index 100%
rename from Documentation/config/remote.txt
rename to Documentation/config/remote.adoc
diff --git a/Documentation/config/remotes.txt b/Documentation/config/remotes.adoc
similarity index 100%
rename from Documentation/config/remotes.txt
rename to Documentation/config/remotes.adoc
diff --git a/Documentation/config/repack.txt b/Documentation/config/repack.adoc
similarity index 100%
rename from Documentation/config/repack.txt
rename to Documentation/config/repack.adoc
diff --git a/Documentation/config/rerere.txt b/Documentation/config/rerere.adoc
similarity index 100%
rename from Documentation/config/rerere.txt
rename to Documentation/config/rerere.adoc
diff --git a/Documentation/config/revert.txt b/Documentation/config/revert.adoc
similarity index 100%
rename from Documentation/config/revert.txt
rename to Documentation/config/revert.adoc
diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.adoc
similarity index 100%
rename from Documentation/config/safe.txt
rename to Documentation/config/safe.adoc
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.adoc
similarity index 100%
rename from Documentation/config/sendemail.txt
rename to Documentation/config/sendemail.adoc
diff --git a/Documentation/config/sequencer.txt b/Documentation/config/sequencer.adoc
similarity index 100%
rename from Documentation/config/sequencer.txt
rename to Documentation/config/sequencer.adoc
diff --git a/Documentation/config/showbranch.txt b/Documentation/config/showbranch.adoc
similarity index 100%
rename from Documentation/config/showbranch.txt
rename to Documentation/config/showbranch.adoc
diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.adoc
similarity index 100%
rename from Documentation/config/sparse.txt
rename to Documentation/config/sparse.adoc
diff --git a/Documentation/config/splitindex.txt b/Documentation/config/splitindex.adoc
similarity index 100%
rename from Documentation/config/splitindex.txt
rename to Documentation/config/splitindex.adoc
diff --git a/Documentation/config/ssh.txt b/Documentation/config/ssh.adoc
similarity index 100%
rename from Documentation/config/ssh.txt
rename to Documentation/config/ssh.adoc
diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.adoc
similarity index 100%
rename from Documentation/config/stash.txt
rename to Documentation/config/stash.adoc
diff --git a/Documentation/config/status.txt b/Documentation/config/status.adoc
similarity index 100%
rename from Documentation/config/status.txt
rename to Documentation/config/status.adoc
diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.adoc
similarity index 100%
rename from Documentation/config/submodule.txt
rename to Documentation/config/submodule.adoc
diff --git a/Documentation/config/tag.txt b/Documentation/config/tag.adoc
similarity index 100%
rename from Documentation/config/tag.txt
rename to Documentation/config/tag.adoc
diff --git a/Documentation/config/tar.txt b/Documentation/config/tar.adoc
similarity index 100%
rename from Documentation/config/tar.txt
rename to Documentation/config/tar.adoc
diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.adoc
similarity index 98%
rename from Documentation/config/trace2.txt
rename to Documentation/config/trace2.adoc
index 3b6bca2b7a..05639ce33f 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.adoc
@@ -17,7 +17,7 @@ trace2.eventTarget::
 	It may be overridden by the `GIT_TRACE2_EVENT` environment variable.
 	The following table shows possible values.
 +
-include::../trace2-target-values.txt[]
+include::../trace2-target-values.adoc[]
 
 trace2.normalBrief::
 	Boolean.  When true `time`, `filename`, and `line` fields are
diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.adoc
similarity index 100%
rename from Documentation/config/transfer.txt
rename to Documentation/config/transfer.adoc
diff --git a/Documentation/config/uploadarchive.txt b/Documentation/config/uploadarchive.adoc
similarity index 100%
rename from Documentation/config/uploadarchive.txt
rename to Documentation/config/uploadarchive.adoc
diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.adoc
similarity index 100%
rename from Documentation/config/uploadpack.txt
rename to Documentation/config/uploadpack.adoc
diff --git a/Documentation/config/url.txt b/Documentation/config/url.adoc
similarity index 100%
rename from Documentation/config/url.txt
rename to Documentation/config/url.adoc
diff --git a/Documentation/config/user.txt b/Documentation/config/user.adoc
similarity index 100%
rename from Documentation/config/user.txt
rename to Documentation/config/user.adoc
diff --git a/Documentation/config/versionsort.txt b/Documentation/config/versionsort.adoc
similarity index 100%
rename from Documentation/config/versionsort.txt
rename to Documentation/config/versionsort.adoc
diff --git a/Documentation/config/web.txt b/Documentation/config/web.adoc
similarity index 100%
rename from Documentation/config/web.txt
rename to Documentation/config/web.adoc
diff --git a/Documentation/config/worktree.txt b/Documentation/config/worktree.adoc
similarity index 100%
rename from Documentation/config/worktree.txt
rename to Documentation/config/worktree.adoc
diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.adoc
similarity index 100%
rename from Documentation/date-formats.txt
rename to Documentation/date-formats.adoc
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.adoc
similarity index 99%
rename from Documentation/diff-format.txt
rename to Documentation/diff-format.adoc
index c72fb37986..80e36e153d 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.adoc
@@ -121,7 +121,7 @@ Note that 'combined diff' lists only files which were modified from
 all parents.
 
 
-include::diff-generate-patch.txt[]
+include::diff-generate-patch.adoc[]
 
 
 other diff formats
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.adoc
similarity index 100%
rename from Documentation/diff-generate-patch.txt
rename to Documentation/diff-generate-patch.adoc
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.adoc
similarity index 100%
rename from Documentation/diff-options.txt
rename to Documentation/diff-options.adoc
diff --git a/Documentation/everyday.txto b/Documentation/everyday.adoco
similarity index 100%
rename from Documentation/everyday.txto
rename to Documentation/everyday.adoco
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.adoc
similarity index 100%
rename from Documentation/fetch-options.txt
rename to Documentation/fetch-options.adoc
diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.adoc
similarity index 100%
rename from Documentation/fsck-msgids.txt
rename to Documentation/fsck-msgids.adoc
diff --git a/Documentation/git-add.txt b/Documentation/git-add.adoc
similarity index 99%
rename from Documentation/git-add.txt
rename to Documentation/git-add.adoc
index 5f2c3592b8..eba0b419ce 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.adoc
@@ -437,10 +437,10 @@ they will make the patch impossible to apply:
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
 :git-add: 1
-include::config/add.txt[]
+include::config/add.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-am.txt b/Documentation/git-am.adoc
similarity index 98%
rename from Documentation/git-am.txt
rename to Documentation/git-am.adoc
index 69d5cc9f21..221070de48 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.adoc
@@ -120,7 +120,7 @@ default.   You can use `--no-utf8` to override this.
 	am.threeWay configuration variable. For more information,
 	see am.threeWay in linkgit:git-config[1].
 
-include::rerere-options.txt[]
+include::rerere-options.adoc[]
 
 --ignore-space-change::
 --ignore-whitespace::
@@ -284,9 +284,9 @@ information.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/am.txt[]
+include::config/am.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.adoc
similarity index 96%
rename from Documentation/git-annotate.txt
rename to Documentation/git-annotate.adoc
index 5ae8aabe0f..965bc676af 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.adoc
@@ -22,7 +22,7 @@ familiar command name for people coming from other SCM systems.
 
 OPTIONS
 -------
-include::blame-options.txt[]
+include::blame-options.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.adoc
similarity index 99%
rename from Documentation/git-apply.txt
rename to Documentation/git-apply.adoc
index dd4a61ef28..952518b8af 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.adoc
@@ -270,9 +270,9 @@ has no effect when `--index` or `--cached` is in use.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/apply.txt[]
+include::config/apply.adoc[]
 
 SUBMODULES
 ----------
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.adoc
similarity index 100%
rename from Documentation/git-archimport.txt
rename to Documentation/git-archimport.adoc
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.adoc
similarity index 100%
rename from Documentation/git-archive.txt
rename to Documentation/git-archive.adoc
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.adoc
similarity index 100%
rename from Documentation/git-bisect-lk2009.txt
rename to Documentation/git-bisect-lk2009.adoc
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.adoc
similarity index 100%
rename from Documentation/git-bisect.txt
rename to Documentation/git-bisect.adoc
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.adoc
similarity index 98%
rename from Documentation/git-blame.txt
rename to Documentation/git-blame.adoc
index b1d7fb539d..f75ed44790 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.adoc
@@ -48,7 +48,7 @@ ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 
 OPTIONS
 -------
-include::blame-options.txt[]
+include::blame-options.adoc[]
 
 -c::
 	Use the same output mode as linkgit:git-annotate[1] (Default: off).
@@ -244,9 +244,9 @@ See linkgit:gitmailmap[5].
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/blame.txt[]
+include::config/blame.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.adoc
similarity index 99%
rename from Documentation/git-branch.txt
rename to Documentation/git-branch.adoc
index 0b08442932..7a073a36d6 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.adoc
@@ -345,9 +345,9 @@ CONFIGURATION
 `--list` is used or implied. The default is to use a pager.
 See linkgit:git-config[1].
 
-include::includes/cmd-config-section-rest.txt[]
+include::includes/cmd-config-section-rest.adoc[]
 
-include::config/branch.txt[]
+include::config/branch.adoc[]
 
 EXAMPLES
 --------
@@ -415,7 +415,7 @@ serve four related but different purposes:
 - `--no-merged` is used to find branches which are candidates for merging
   into HEAD, since those branches are not fully contained by HEAD.
 
-include::ref-reachability-filters.txt[]
+include::ref-reachability-filters.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.adoc
similarity index 100%
rename from Documentation/git-bugreport.txt
rename to Documentation/git-bugreport.adoc
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.adoc
similarity index 100%
rename from Documentation/git-bundle.txt
rename to Documentation/git-bundle.adoc
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.adoc
similarity index 100%
rename from Documentation/git-cat-file.txt
rename to Documentation/git-cat-file.adoc
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.adoc
similarity index 100%
rename from Documentation/git-check-attr.txt
rename to Documentation/git-check-attr.adoc
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.adoc
similarity index 100%
rename from Documentation/git-check-ignore.txt
rename to Documentation/git-check-ignore.adoc
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.adoc
similarity index 100%
rename from Documentation/git-check-mailmap.txt
rename to Documentation/git-check-mailmap.adoc
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.adoc
similarity index 100%
rename from Documentation/git-check-ref-format.txt
rename to Documentation/git-check-ref-format.adoc
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.adoc
similarity index 100%
rename from Documentation/git-checkout-index.txt
rename to Documentation/git-checkout-index.adoc
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.adoc
similarity index 99%
rename from Documentation/git-checkout.txt
rename to Documentation/git-checkout.adoc
index bf26655764..a66c53a5cd 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.adoc
@@ -612,9 +612,9 @@ $ git add frotz
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/checkout.txt[]
+include::config/checkout.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.adoc
similarity index 99%
rename from Documentation/git-cherry-pick.txt
rename to Documentation/git-cherry-pick.adoc
index 81ace900fc..42b41923d5 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.adoc
@@ -172,11 +172,11 @@ fail unless one of `--empty=keep` or `--allow-empty` are specified.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
-include::rerere-options.txt[]
+include::rerere-options.adoc[]
 
 SEQUENCER SUBCOMMANDS
 ---------------------
-include::sequencer.txt[]
+include::sequencer.adoc[]
 
 EXAMPLES
 --------
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.adoc
similarity index 100%
rename from Documentation/git-cherry.txt
rename to Documentation/git-cherry.adoc
diff --git a/Documentation/git-citool.txt b/Documentation/git-citool.adoc
similarity index 100%
rename from Documentation/git-citool.txt
rename to Documentation/git-citool.adoc
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.adoc
similarity index 98%
rename from Documentation/git-clean.txt
rename to Documentation/git-clean.adoc
index fd17165416..bed52c203b 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.adoc
@@ -140,9 +140,9 @@ help::
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/clean.txt[]
+include::config/clean.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.adoc
similarity index 98%
rename from Documentation/git-clone.txt
rename to Documentation/git-clone.adoc
index de8d8f5893..db1c06560a 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.adoc
@@ -321,7 +321,7 @@ or `--mirror` is given)
 
 Specify the given ref storage format for the repository. The valid values are:
 +
-include::ref-storage-format.txt[]
+include::ref-storage-format.adoc[]
 
 `-j` _<n>_::
 `--jobs` _<n>_::
@@ -348,7 +348,7 @@ _<directory>_::
 	`--shallow-since`, and `--shallow-exclude`.
 
 :git-clone: 1
-include::urls.txt[]
+include::urls.adoc[]
 
 EXAMPLES
 --------
@@ -396,11 +396,11 @@ $ git clone --no-local /home/otheruser/proj.git /pub/scm/proj.git
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/init.txt[]
+include::config/init.adoc[]
 
-include::config/clone.txt[]
+include::config/clone.adoc[]
 
 
 GIT
diff --git a/Documentation/git-column.txt b/Documentation/git-column.adoc
similarity index 96%
rename from Documentation/git-column.txt
rename to Documentation/git-column.adoc
index 18431647a2..85fb87c94a 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.adoc
@@ -77,9 +77,9 @@ v2.4.8  v2.4.9
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/column.txt[]
+include::config/column.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.adoc
similarity index 98%
rename from Documentation/git-commit-graph.txt
rename to Documentation/git-commit-graph.adoc
index 903b16830e..50b5016804 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.adoc
@@ -148,9 +148,9 @@ $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/commitgraph.txt[]
+include::config/commitgraph.adoc[]
 
 
 FILE FORMAT
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.adoc
similarity index 98%
rename from Documentation/git-commit-tree.txt
rename to Documentation/git-commit-tree.adoc
index 2e2c581098..6472921e14 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.adoc
@@ -80,12 +80,12 @@ A commit comment is read from stdin. If a changelog
 entry is not provided via "<" redirection, 'git commit-tree' will just wait
 for one to be entered and terminated with ^D.
 
-include::date-formats.txt[]
+include::date-formats.adoc[]
 
 Discussion
 ----------
 
-include::i18n.txt[]
+include::i18n.adoc[]
 
 FILES
 -----
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.adoc
similarity index 99%
rename from Documentation/git-commit.txt
rename to Documentation/git-commit.adoc
index c822113c11..33ac5c4185 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.adoc
@@ -198,7 +198,7 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	message, the commit is aborted.  This has no effect when a message
 	is given by other means, e.g. with the `-m` or `-F` options.
 
-include::signoff-option.txt[]
+include::signoff-option.adoc[]
 
 --trailer <token>[(=|:)<value>]::
 	Specify a (<token>, <value>) pair that should be applied as a
@@ -537,7 +537,7 @@ The typical usage is to set just the `user.name` and `user.email` variables;
 the other options are provided for more complex use cases.
 
 :git-commit: 1
-include::date-formats.txt[]
+include::date-formats.adoc[]
 
 DISCUSSION
 ----------
@@ -550,7 +550,7 @@ as the commit title, and that title is used throughout Git.
 For example, linkgit:git-format-patch[1] turns a commit into email, and it uses
 the title on the Subject line and the rest of the commit in the body.
 
-include::i18n.txt[]
+include::i18n.adoc[]
 
 ENVIRONMENT AND CONFIGURATION VARIABLES
 ---------------------------------------
@@ -559,9 +559,9 @@ The editor used to edit the commit log message will be chosen from the
 `VISUAL` environment variable, or the `EDITOR` environment variable (in that
 order).  See linkgit:git-var[1] for details.
 
-include::includes/cmd-config-section-rest.txt[]
+include::includes/cmd-config-section-rest.adoc[]
 
-include::config/commit.txt[]
+include::config/commit.adoc[]
 
 HOOKS
 -----
diff --git a/Documentation/git-config.txt b/Documentation/git-config.adoc
similarity index 99%
rename from Documentation/git-config.txt
rename to Documentation/git-config.adoc
index 3e420177c1..888f8ba54b 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.adoc
@@ -610,7 +610,7 @@ http.cookieFile /tmp/cookie.txt
 http.sslverify false
 ------------
 
-include::config.txt[]
+include::config.adoc[]
 
 BUGS
 ----
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.adoc
similarity index 100%
rename from Documentation/git-count-objects.txt
rename to Documentation/git-count-objects.adoc
diff --git a/Documentation/git-credential-cache--daemon.txt b/Documentation/git-credential-cache--daemon.adoc
similarity index 100%
rename from Documentation/git-credential-cache--daemon.txt
rename to Documentation/git-credential-cache--daemon.adoc
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.adoc
similarity index 100%
rename from Documentation/git-credential-cache.txt
rename to Documentation/git-credential-cache.adoc
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.adoc
similarity index 100%
rename from Documentation/git-credential-store.txt
rename to Documentation/git-credential-store.adoc
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.adoc
similarity index 100%
rename from Documentation/git-credential.txt
rename to Documentation/git-credential.adoc
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.adoc
similarity index 100%
rename from Documentation/git-cvsexportcommit.txt
rename to Documentation/git-cvsexportcommit.adoc
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.adoc
similarity index 100%
rename from Documentation/git-cvsimport.txt
rename to Documentation/git-cvsimport.adoc
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.adoc
similarity index 100%
rename from Documentation/git-cvsserver.txt
rename to Documentation/git-cvsserver.adoc
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.adoc
similarity index 100%
rename from Documentation/git-daemon.txt
rename to Documentation/git-daemon.adoc
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.adoc
similarity index 100%
rename from Documentation/git-describe.txt
rename to Documentation/git-describe.adoc
diff --git a/Documentation/git-diagnose.txt b/Documentation/git-diagnose.adoc
similarity index 100%
rename from Documentation/git-diagnose.txt
rename to Documentation/git-diagnose.adoc
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.adoc
similarity index 95%
rename from Documentation/git-diff-files.txt
rename to Documentation/git-diff-files.adoc
index bf78e31431..2b2358ca1c 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.adoc
@@ -20,7 +20,7 @@ same as for 'git diff-index' and 'git diff-tree'.
 
 OPTIONS
 -------
-include::diff-options.txt[]
+include::diff-options.adoc[]
 
 -1 --base::
 -2 --ours::
@@ -45,7 +45,7 @@ omit diff output for unmerged entries and just show "Unmerged".
 	Remain silent even for nonexistent files
 
 
-include::diff-format.txt[]
+include::diff-format.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.adoc
similarity index 98%
rename from Documentation/git-diff-index.txt
rename to Documentation/git-diff-index.adoc
index 4de1d4c8f1..911446a296 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.adoc
@@ -21,7 +21,7 @@ files are compared.
 
 OPTIONS
 -------
-include::diff-options.txt[]
+include::diff-options.adoc[]
 
 <tree-ish>::
 	The id of a tree object to diff against.
@@ -40,7 +40,7 @@ include::diff-options.txt[]
 	'git diff-index' say that all non-checked-out files are up
 	to date.
 
-include::diff-format.txt[]
+include::diff-format.adoc[]
 
 OPERATING MODES
 ---------------
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.adoc
similarity index 97%
rename from Documentation/git-diff-tree.txt
rename to Documentation/git-diff-tree.adoc
index 09286a85eb..f1e3134bde 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.adoc
@@ -24,7 +24,7 @@ Note that 'git diff-tree' can use the tree encapsulated in a commit object.
 
 OPTIONS
 -------
-include::diff-options.txt[]
+include::diff-options.adoc[]
 
 <tree-ish>::
 	The id of a tree object.
@@ -84,7 +84,7 @@ commits (but not trees).
 	This flag causes 'git diff-tree --stdin' to also show
 	the commit message before the differences.
 
-include::pretty-options.txt[]
+include::pretty-options.adoc[]
 
 --no-commit-id::
 	'git diff-tree' outputs a line with the commit ID when
@@ -122,9 +122,9 @@ include::pretty-options.txt[]
 	if the diff itself is empty.
 
 
-include::pretty-formats.txt[]
+include::pretty-formats.adoc[]
 
-include::diff-format.txt[]
+include::diff-format.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.adoc
similarity index 98%
rename from Documentation/git-diff.txt
rename to Documentation/git-diff.adoc
index e19f31e8b9..dec173a345 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.adoc
@@ -123,7 +123,7 @@ do not mean a range as defined in the
 OPTIONS
 -------
 :git-diff: 1
-include::diff-options.txt[]
+include::diff-options.adoc[]
 
 `-1`::
 `--base`::
@@ -154,7 +154,7 @@ section "3-Way Merge" for detailed information.
 	names and get diff for all files under them).
 
 
-include::diff-format.txt[]
+include::diff-format.adoc[]
 
 EXAMPLES
 --------
@@ -232,10 +232,10 @@ $ git diff -R                          <2>
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
 :git-diff: 1
-include::config/diff.txt[]
+include::config/diff.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.adoc
similarity index 98%
rename from Documentation/git-difftool.txt
rename to Documentation/git-difftool.adoc
index a616f8b2e6..d596205eaf 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.adoc
@@ -119,9 +119,9 @@ CONFIGURATION
 'git difftool' falls back to 'git mergetool' config variables when the
 difftool equivalents have not been defined.
 
-include::includes/cmd-config-section-rest.txt[]
+include::includes/cmd-config-section-rest.adoc[]
 
-include::config/difftool.txt[]
+include::config/difftool.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.adoc
similarity index 100%
rename from Documentation/git-fast-export.txt
rename to Documentation/git-fast-export.adoc
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.adoc
similarity index 99%
rename from Documentation/git-fast-import.txt
rename to Documentation/git-fast-import.adoc
index 3d435157a6..58a2eaa51a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.adoc
@@ -1578,9 +1578,9 @@ compression.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/fastimport.txt[]
+include::config/fastimport.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.adoc
similarity index 100%
rename from Documentation/git-fetch-pack.txt
rename to Documentation/git-fetch-pack.adoc
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.adoc
similarity index 98%
rename from Documentation/git-fetch.txt
rename to Documentation/git-fetch.adoc
index 50900a50da..16f5d9d69a 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.adoc
@@ -44,15 +44,15 @@ may be used by scripts or other git commands, such as linkgit:git-pull[1].
 
 OPTIONS
 -------
-include::fetch-options.txt[]
+include::fetch-options.adoc[]
 
-include::pull-fetch-param.txt[]
+include::pull-fetch-param.adoc[]
 
 --stdin::
 	Read refspecs, one per line, from stdin in addition to those provided
 	as arguments. The "tag <name>" format is not supported.
 
-include::urls-remotes.txt[]
+include::urls-remotes.adoc[]
 
 
 CONFIGURED REMOTE-TRACKING BRANCHES[[CRTB]]
@@ -292,14 +292,14 @@ The first command fetches the `maint` branch from the repository at
 objects will eventually be removed by git's built-in housekeeping (see
 linkgit:git-gc[1]).
 
-include::transfer-data-leaks.txt[]
+include::transfer-data-leaks.adoc[]
 
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/fetch.txt[]
+include::config/fetch.adoc[]
 
 BUGS
 ----
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.adoc
similarity index 100%
rename from Documentation/git-filter-branch.txt
rename to Documentation/git-filter-branch.adoc
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.adoc
similarity index 98%
rename from Documentation/git-fmt-merge-msg.txt
rename to Documentation/git-fmt-merge-msg.adoc
index 6f28812f38..0f3328956d 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.adoc
@@ -55,7 +55,7 @@ OPTIONS
 
 CONFIGURATION
 -------------
-include::config/fmt-merge-msg.txt[]
+include::config/fmt-merge-msg.adoc[]
 
 merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.adoc
similarity index 99%
rename from Documentation/git-for-each-ref.txt
rename to Documentation/git-for-each-ref.adoc
index d3764401a2..ffb97e62c2 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.adoc
@@ -538,7 +538,7 @@ will be reported.
 NOTES
 -----
 
-include::ref-reachability-filters.txt[]
+include::ref-reachability-filters.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.adoc
similarity index 100%
rename from Documentation/git-for-each-repo.txt
rename to Documentation/git-for-each-repo.adoc
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.adoc
similarity index 99%
rename from Documentation/git-format-patch.txt
rename to Documentation/git-format-patch.adoc
index 5dc7bb4cfc..a8b53db9a6 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.adoc
@@ -105,7 +105,7 @@ reference.
 OPTIONS
 -------
 :git-format-patch: 1
-include::diff-options.txt[]
+include::diff-options.adoc[]
 
 -<n>::
 	Prepare patches from the topmost <n> commits.
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.adoc
similarity index 100%
rename from Documentation/git-fsck-objects.txt
rename to Documentation/git-fsck-objects.adoc
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.adoc
similarity index 98%
rename from Documentation/git-fsck.txt
rename to Documentation/git-fsck.adoc
index 5b82e4605c..8f32800a83 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.adoc
@@ -107,9 +107,9 @@ care about this output and want to speed it up further.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/fsck.txt[]
+include::config/fsck.adoc[]
 
 DISCUSSION
 ----------
@@ -161,7 +161,7 @@ each error means, with their default severity.  The severity of the
 error, other than those that are marked as "(FATAL)", can be tweaked
 by setting the corresponding `fsck.<msg-id>` configuration variable.
 
-include::fsck-msgids.txt[]
+include::fsck-msgids.adoc[]
 
 
 Environment Variables
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.adoc
similarity index 97%
rename from Documentation/git-fsmonitor--daemon.txt
rename to Documentation/git-fsmonitor--daemon.adoc
index 8585d19f4d..8fe5241b08 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.adoc
@@ -97,9 +97,9 @@ error that will cause the daemon and the currently running command to exit.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/fsmonitor--daemon.txt[]
+include::config/fsmonitor--daemon.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.adoc
similarity index 98%
rename from Documentation/git-gc.txt
rename to Documentation/git-gc.adoc
index 370e22faae..b61bacd25c 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.adoc
@@ -122,9 +122,9 @@ users and their repositories.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/gc.txt[]
+include::config/gc.adoc[]
 
 NOTES
 -----
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.adoc
similarity index 100%
rename from Documentation/git-get-tar-commit-id.txt
rename to Documentation/git-get-tar-commit-id.adoc
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.adoc
similarity index 99%
rename from Documentation/git-grep.txt
rename to Documentation/git-grep.adoc
index 1e6d7b65c8..a548585d4c 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.adoc
@@ -351,9 +351,9 @@ experienced in this case, it might be desirable to use `--threads=1`.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/grep.txt[]
+include::config/grep.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.adoc
similarity index 100%
rename from Documentation/git-gui.txt
rename to Documentation/git-gui.adoc
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.adoc
similarity index 100%
rename from Documentation/git-hash-object.txt
rename to Documentation/git-hash-object.adoc
diff --git a/Documentation/git-help.txt b/Documentation/git-help.adoc
similarity index 100%
rename from Documentation/git-help.txt
rename to Documentation/git-help.adoc
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.adoc
similarity index 100%
rename from Documentation/git-hook.txt
rename to Documentation/git-hook.adoc
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.adoc
similarity index 100%
rename from Documentation/git-http-backend.txt
rename to Documentation/git-http-backend.adoc
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.adoc
similarity index 100%
rename from Documentation/git-http-fetch.txt
rename to Documentation/git-http-fetch.adoc
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.adoc
similarity index 100%
rename from Documentation/git-http-push.txt
rename to Documentation/git-http-push.adoc
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.adoc
similarity index 97%
rename from Documentation/git-imap-send.txt
rename to Documentation/git-imap-send.adoc
index c8a89d7243..26ccf4e433 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.adoc
@@ -54,9 +54,9 @@ CONFIGURATION
 To use the tool, `imap.folder` and either `imap.tunnel` or `imap.host` must be set
 to appropriate values.
 
-include::includes/cmd-config-section-rest.txt[]
+include::includes/cmd-config-section-rest.adoc[]
 
-include::config/imap.txt[]
+include::config/imap.adoc[]
 
 EXAMPLES
 --------
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.adoc
similarity index 99%
rename from Documentation/git-index-pack.txt
rename to Documentation/git-index-pack.adoc
index 58dd5b5f0e..270056cf63 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.adoc
@@ -130,7 +130,7 @@ information on the possible values of `<msg-id>` and `<severity>`.
 +
 This option cannot be used with --stdin.
 +
-include::object-format-disclaimer.txt[]
+include::object-format-disclaimer.adoc[]
 
 --promisor[=<message>]::
 	Before committing the pack-index, create a .promisor file for this
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.adoc
similarity index 100%
rename from Documentation/git-init-db.txt
rename to Documentation/git-init-db.adoc
diff --git a/Documentation/git-init.txt b/Documentation/git-init.adoc
similarity index 97%
rename from Documentation/git-init.txt
rename to Documentation/git-init.adoc
index 315f7f7530..a0dffba665 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.adoc
@@ -55,12 +55,12 @@ current working directory.
 Specify the given object _<format>_ (hash algorithm) for the repository.  The valid
 values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 +
-include::object-format-disclaimer.txt[]
+include::object-format-disclaimer.adoc[]
 
 `--ref-format=<format>`::
 Specify the given ref storage _<format>_ for the repository. The valid values are:
 +
-include::ref-storage-format.txt[]
+include::ref-storage-format.adoc[]
 
 `--template=<template-directory>`::
 Specify the directory from which templates will be used.  (See the "TEMPLATE
@@ -178,11 +178,11 @@ $ git commit    <3>
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
 :git-init:
 
-include::config/init.txt[]
+include::config/init.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.adoc
similarity index 100%
rename from Documentation/git-instaweb.txt
rename to Documentation/git-instaweb.adoc
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.adoc
similarity index 100%
rename from Documentation/git-interpret-trailers.txt
rename to Documentation/git-interpret-trailers.adoc
diff --git a/Documentation/git-log.txt b/Documentation/git-log.adoc
similarity index 95%
rename from Documentation/git-log.txt
rename to Documentation/git-log.adoc
index 579682172f..ae8a7e2d63 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.adoc
@@ -16,7 +16,7 @@ DESCRIPTION
 Shows the commit logs.
 
 :git-log: 1
-include::rev-list-description.txt[]
+include::rev-list-description.adoc[]
 
 The command takes options applicable to the linkgit:git-rev-list[1]
 command to control what is shown and how, and options applicable to
@@ -89,7 +89,7 @@ produced by `--stat`, etc.
 	Intended to speed up tools that read log messages from `git log`
 	output by allowing them to allocate space in advance.
 
-include::line-range-options.txt[]
+include::line-range-options.adoc[]
 
 <revision-range>::
 	Show only commits in the specified revision range.  When no
@@ -109,9 +109,9 @@ include::line-range-options.txt[]
 Paths may need to be prefixed with `--` to separate them from
 options or the revision range, when confusion arises.
 
-include::rev-list-options.txt[]
+include::rev-list-options.adoc[]
 
-include::pretty-formats.txt[]
+include::pretty-formats.adoc[]
 
 DIFF FORMATTING
 ---------------
@@ -128,9 +128,9 @@ the default format for merge commits.
 
 :git-log: 1
 :diff-merges-default: `off`
-include::diff-options.txt[]
+include::diff-options.adoc[]
 
-include::diff-generate-patch.txt[]
+include::diff-generate-patch.adoc[]
 
 EXAMPLES
 --------
@@ -192,7 +192,7 @@ EXAMPLES
 DISCUSSION
 ----------
 
-include::i18n.txt[]
+include::i18n.adoc[]
 
 CONFIGURATION
 -------------
@@ -209,11 +209,11 @@ i18n.logOutputEncoding::
 	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
 
-include::includes/cmd-config-section-rest.txt[]
+include::includes/cmd-config-section-rest.adoc[]
 
-include::config/log.txt[]
+include::config/log.adoc[]
 
-include::config/notes.txt[]
+include::config/notes.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.adoc
similarity index 100%
rename from Documentation/git-ls-files.txt
rename to Documentation/git-ls-files.adoc
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.adoc
similarity index 100%
rename from Documentation/git-ls-remote.txt
rename to Documentation/git-ls-remote.adoc
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.adoc
similarity index 100%
rename from Documentation/git-ls-tree.txt
rename to Documentation/git-ls-tree.adoc
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.adoc
similarity index 97%
rename from Documentation/git-mailinfo.txt
rename to Documentation/git-mailinfo.adoc
index 28060283c7..3b24c9abd9 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.adoc
@@ -118,9 +118,9 @@ If no such configuration option has been set, `warn` will be used.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/mailinfo.txt[]
+include::config/mailinfo.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.adoc
similarity index 100%
rename from Documentation/git-mailsplit.txt
rename to Documentation/git-mailsplit.adoc
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.adoc
similarity index 99%
rename from Documentation/git-maintenance.txt
rename to Documentation/git-maintenance.adoc
index 6e6651309d..0450d74aff 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.adoc
@@ -409,9 +409,9 @@ custom tasks.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/maintenance.txt[]
+include::config/maintenance.adoc[]
 
 
 GIT
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.adoc
similarity index 100%
rename from Documentation/git-merge-base.txt
rename to Documentation/git-merge-base.adoc
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.adoc
similarity index 100%
rename from Documentation/git-merge-file.txt
rename to Documentation/git-merge-file.adoc
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.adoc
similarity index 100%
rename from Documentation/git-merge-index.txt
rename to Documentation/git-merge-index.adoc
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.adoc
similarity index 100%
rename from Documentation/git-merge-one-file.txt
rename to Documentation/git-merge-one-file.adoc
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.adoc
similarity index 100%
rename from Documentation/git-merge-tree.txt
rename to Documentation/git-merge-tree.adoc
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.adoc
similarity index 98%
rename from Documentation/git-merge.txt
rename to Documentation/git-merge.adoc
index 1ab69f61f5..64281d6d44 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.adoc
@@ -65,7 +65,7 @@ OPTIONS
 -------
 :git-merge: 1
 
-include::merge-options.txt[]
+include::merge-options.adoc[]
 
 -m <msg>::
 	Set the commit message to be used for the merge commit (in
@@ -91,7 +91,7 @@ invocations. The automated message can include the branch description.
 If `--log` is specified, a shortlog of the commits being merged
 will be appended to the specified message.
 
-include::rerere-options.txt[]
+include::rerere-options.adoc[]
 
 --overwrite-ignore::
 --no-overwrite-ignore::
@@ -385,7 +385,7 @@ changes into a merge commit.  Small fixups like bumping
 release/version name would be acceptable.
 
 
-include::merge-strategies.txt[]
+include::merge-strategies.adoc[]
 
 CONFIGURATION
 -------------
@@ -395,9 +395,9 @@ branch.<name>.mergeOptions::
 	supported options are the same as those of `git merge`, but option
 	values containing whitespace characters are currently not supported.
 
-include::includes/cmd-config-section-rest.txt[]
+include::includes/cmd-config-section-rest.adoc[]
 
-include::config/merge.txt[]
+include::config/merge.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.adoc
similarity index 100%
rename from Documentation/git-mergetool--lib.txt
rename to Documentation/git-mergetool--lib.adoc
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.adoc
similarity index 97%
rename from Documentation/git-mergetool.txt
rename to Documentation/git-mergetool.adoc
index b9e20c5dcd..046c3258f0 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.adoc
@@ -104,9 +104,9 @@ CONFIGURATION
 -------------
 :git-mergetool: 1
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/mergetool.txt[]
+include::config/mergetool.adoc[]
 
 TEMPORARY FILES
 ---------------
@@ -123,7 +123,7 @@ BACKEND SPECIFIC HINTS
 
 vimdiff
 ~~~~~~~
-include::mergetools/vimdiff.txt[]
+include::mergetools/vimdiff.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.adoc
similarity index 100%
rename from Documentation/git-mktag.txt
rename to Documentation/git-mktag.adoc
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.adoc
similarity index 100%
rename from Documentation/git-mktree.txt
rename to Documentation/git-mktree.adoc
diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.adoc
similarity index 100%
rename from Documentation/git-multi-pack-index.txt
rename to Documentation/git-multi-pack-index.adoc
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.adoc
similarity index 100%
rename from Documentation/git-mv.txt
rename to Documentation/git-mv.adoc
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.adoc
similarity index 100%
rename from Documentation/git-name-rev.txt
rename to Documentation/git-name-rev.adoc
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.adoc
similarity index 99%
rename from Documentation/git-notes.txt
rename to Documentation/git-notes.adoc
index 84022f99d7..02b743392f 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.adoc
@@ -345,9 +345,9 @@ core.notesRef::
 	This setting can be overridden through the environment and
 	command line.
 
-include::includes/cmd-config-section-rest.txt[]
+include::includes/cmd-config-section-rest.adoc[]
 
-include::config/notes.txt[]
+include::config/notes.adoc[]
 
 
 ENVIRONMENT
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.adoc
similarity index 100%
rename from Documentation/git-p4.txt
rename to Documentation/git-p4.adoc
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.adoc
similarity index 100%
rename from Documentation/git-pack-objects.txt
rename to Documentation/git-pack-objects.adoc
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.adoc
similarity index 100%
rename from Documentation/git-pack-redundant.txt
rename to Documentation/git-pack-redundant.adoc
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.adoc
similarity index 100%
rename from Documentation/git-pack-refs.txt
rename to Documentation/git-pack-refs.adoc
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.adoc
similarity index 100%
rename from Documentation/git-patch-id.txt
rename to Documentation/git-patch-id.adoc
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.adoc
similarity index 100%
rename from Documentation/git-prune-packed.txt
rename to Documentation/git-prune-packed.adoc
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.adoc
similarity index 100%
rename from Documentation/git-prune.txt
rename to Documentation/git-prune.adoc
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.adoc
similarity index 97%
rename from Documentation/git-pull.txt
rename to Documentation/git-pull.adoc
index b2ae496e48..3f4ecc4730 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.adoc
@@ -102,7 +102,7 @@ Options related to merging
 
 :git-pull: 1
 
-include::merge-options.txt[]
+include::merge-options.adoc[]
 
 -r::
 --rebase[=(false|true|merges|interactive)]::
@@ -136,13 +136,13 @@ unless you have read linkgit:git-rebase[1] carefully.
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-include::fetch-options.txt[]
+include::fetch-options.adoc[]
 
-include::pull-fetch-param.txt[]
+include::pull-fetch-param.adoc[]
 
-include::urls-remotes.txt[]
+include::urls-remotes.adoc[]
 
-include::merge-strategies.txt[]
+include::merge-strategies.adoc[]
 
 DEFAULT BEHAVIOUR
 -----------------
@@ -234,7 +234,7 @@ If you tried a pull which resulted in complex conflicts and
 would want to start over, you can recover with 'git reset'.
 
 
-include::transfer-data-leaks.txt[]
+include::transfer-data-leaks.adoc[]
 
 BUGS
 ----
diff --git a/Documentation/git-push.txt b/Documentation/git-push.adoc
similarity index 99%
rename from Documentation/git-push.txt
rename to Documentation/git-push.adoc
index 9b7cfbc5c1..d1978650d6 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.adoc
@@ -432,7 +432,7 @@ further recursion will occur. In this case, "only" is treated as "on-demand".
 --ipv6::
 	Use IPv6 addresses only, ignoring IPv4 addresses.
 
-include::urls-remotes.txt[]
+include::urls-remotes.adoc[]
 
 OUTPUT
 ------
@@ -695,14 +695,14 @@ Commits A and B would no longer belong to a branch with a symbolic name,
 and so would be unreachable.  As such, these commits would be removed by
 a `git gc` command on the origin repository.
 
-include::transfer-data-leaks.txt[]
+include::transfer-data-leaks.adoc[]
 
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/push.txt[]
+include::config/push.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.adoc
similarity index 100%
rename from Documentation/git-quiltimport.txt
rename to Documentation/git-quiltimport.adoc
diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.adoc
similarity index 100%
rename from Documentation/git-range-diff.txt
rename to Documentation/git-range-diff.adoc
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.adoc
similarity index 100%
rename from Documentation/git-read-tree.txt
rename to Documentation/git-read-tree.adoc
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.adoc
similarity index 99%
rename from Documentation/git-rebase.txt
rename to Documentation/git-rebase.adoc
index b18cdbc023..133fe8c5e6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.adoc
@@ -401,7 +401,7 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
-include::rerere-options.txt[]
+include::rerere-options.adoc[]
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
@@ -825,7 +825,7 @@ completeness:
 * State directories: The two backends keep their state in different
   directories under `.git/`
 
-include::merge-strategies.txt[]
+include::merge-strategies.adoc[]
 
 NOTES
 -----
@@ -1294,10 +1294,10 @@ merge cmake
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/rebase.txt[]
-include::config/sequencer.txt[]
+include::config/rebase.adoc[]
+include::config/sequencer.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.adoc
similarity index 100%
rename from Documentation/git-receive-pack.txt
rename to Documentation/git-receive-pack.adoc
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.adoc
similarity index 100%
rename from Documentation/git-reflog.txt
rename to Documentation/git-reflog.adoc
diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.adoc
similarity index 98%
rename from Documentation/git-refs.txt
rename to Documentation/git-refs.adoc
index 9829984b0a..95f25776aa 100644
--- a/Documentation/git-refs.txt
+++ b/Documentation/git-refs.adoc
@@ -34,7 +34,7 @@ The following options are specific to 'git refs migrate':
 --ref-format=<format>::
 	The ref format to migrate the ref store to. Can be one of:
 +
-include::ref-storage-format.txt[]
+include::ref-storage-format.adoc[]
 
 --dry-run::
 	Perform the migration, but do not modify the repository. The migrated
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.adoc
similarity index 100%
rename from Documentation/git-remote-ext.txt
rename to Documentation/git-remote-ext.adoc
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.adoc
similarity index 100%
rename from Documentation/git-remote-fd.txt
rename to Documentation/git-remote-fd.adoc
diff --git a/Documentation/git-remote-helpers.txto b/Documentation/git-remote-helpers.adoco
similarity index 100%
rename from Documentation/git-remote-helpers.txto
rename to Documentation/git-remote-helpers.adoco
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.adoc
similarity index 100%
rename from Documentation/git-remote.txt
rename to Documentation/git-remote.adoc
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.adoc
similarity index 100%
rename from Documentation/git-repack.txt
rename to Documentation/git-repack.adoc
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.adoc
similarity index 100%
rename from Documentation/git-replace.txt
rename to Documentation/git-replace.adoc
diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.adoc
similarity index 99%
rename from Documentation/git-replay.txt
rename to Documentation/git-replay.adoc
index 8f3300c683..0b12bf8aa4 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.adoc
@@ -49,7 +49,7 @@ the new commits (in other words, this mimics a cherry-pick operation).
 	to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
 	"Commit Limiting" options below.
 
-include::rev-list-options.txt[]
+include::rev-list-options.adoc[]
 
 OUTPUT
 ------
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.adoc
similarity index 100%
rename from Documentation/git-request-pull.txt
rename to Documentation/git-request-pull.adoc
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.adoc
similarity index 100%
rename from Documentation/git-rerere.txt
rename to Documentation/git-rerere.adoc
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.adoc
similarity index 100%
rename from Documentation/git-reset.txt
rename to Documentation/git-reset.adoc
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.adoc
similarity index 100%
rename from Documentation/git-restore.txt
rename to Documentation/git-restore.adoc
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.adoc
similarity index 96%
rename from Documentation/git-rev-list.txt
rename to Documentation/git-rev-list.adoc
index 2e05c4b510..f582491dd4 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.adoc
@@ -15,7 +15,7 @@ DESCRIPTION
 -----------
 
 :git-rev-list: 1
-include::rev-list-description.txt[]
+include::rev-list-description.adoc[]
 
 'rev-list' is an essential Git command, since it
 provides the ability to build and traverse commit ancestry graphs. For
@@ -27,9 +27,9 @@ OPTIONS
 -------
 
 :git-rev-list: 1
-include::rev-list-options.txt[]
+include::rev-list-options.adoc[]
 
-include::pretty-formats.txt[]
+include::pretty-formats.adoc[]
 
 EXAMPLES
 --------
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.adoc
similarity index 99%
rename from Documentation/git-rev-parse.txt
rename to Documentation/git-rev-parse.adoc
index dc12d38534..cc32b4b4f0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.adoc
@@ -351,7 +351,7 @@ Other Options
 	Flags and parameters to be parsed.
 
 
-include::revisions.txt[]
+include::revisions.adoc[]
 
 PARSEOPT
 --------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.adoc
similarity index 97%
rename from Documentation/git-revert.txt
rename to Documentation/git-revert.adoc
index 568925db53..ffba365e63 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.adoc
@@ -112,7 +112,7 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
-include::rerere-options.txt[]
+include::rerere-options.adoc[]
 
 --reference::
 	Instead of starting the body of the log message with "This
@@ -125,7 +125,7 @@ include::rerere-options.txt[]
 
 SEQUENCER SUBCOMMANDS
 ---------------------
-include::sequencer.txt[]
+include::sequencer.adoc[]
 
 EXAMPLES
 --------
@@ -155,9 +155,9 @@ Please consider rewording these to be shorter and more unique.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/revert.txt[]
+include::config/revert.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.adoc
similarity index 100%
rename from Documentation/git-rm.txt
rename to Documentation/git-rm.adoc
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.adoc
similarity index 99%
rename from Documentation/git-send-email.txt
rename to Documentation/git-send-email.adoc
index bc3ef45acb..7f223db42d 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.adoc
@@ -492,9 +492,9 @@ Information
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/sendemail.txt[]
+include::config/sendemail.adoc[]
 
 EXAMPLES
 --------
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.adoc
similarity index 100%
rename from Documentation/git-send-pack.txt
rename to Documentation/git-send-pack.adoc
diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation/git-sh-i18n--envsubst.adoc
similarity index 100%
rename from Documentation/git-sh-i18n--envsubst.txt
rename to Documentation/git-sh-i18n--envsubst.adoc
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.adoc
similarity index 100%
rename from Documentation/git-sh-i18n.txt
rename to Documentation/git-sh-i18n.adoc
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.adoc
similarity index 100%
rename from Documentation/git-sh-setup.txt
rename to Documentation/git-sh-setup.adoc
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.adoc
similarity index 100%
rename from Documentation/git-shell.txt
rename to Documentation/git-shell.adoc
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.adoc
similarity index 99%
rename from Documentation/git-shortlog.txt
rename to Documentation/git-shortlog.adoc
index 7d0277d033..d8ab38dcc1 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.adoc
@@ -114,7 +114,7 @@ Paths may need to be prefixed with `--` to separate them from
 options or the revision range, when confusion arises.
 
 :git-shortlog: 1
-include::rev-list-options.txt[]
+include::rev-list-options.adoc[]
 
 MAPPING AUTHORS
 ---------------
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.adoc
similarity index 98%
rename from Documentation/git-show-branch.txt
rename to Documentation/git-show-branch.adoc
index bc31d8b6d3..7e86d54a24 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.adoc
@@ -202,9 +202,9 @@ topologically related to each other.
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/showbranch.txt[]
+include::config/showbranch.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.adoc
similarity index 97%
rename from Documentation/git-show-index.txt
rename to Documentation/git-show-index.adoc
index e49318a5a0..f0e40e6164 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.adoc
@@ -45,7 +45,7 @@ OPTIONS
 	algorithm for the current repository (set by `extensions.objectFormat`), or
 	'sha1' if no value is set or outside a repository..
 +
-include::object-format-disclaimer.txt[]
+include::object-format-disclaimer.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.adoc
similarity index 100%
rename from Documentation/git-show-ref.txt
rename to Documentation/git-show-ref.adoc
diff --git a/Documentation/git-show.txt b/Documentation/git-show.adoc
similarity index 92%
rename from Documentation/git-show.txt
rename to Documentation/git-show.adoc
index 5eb67439af..51044c814f 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.adoc
@@ -39,10 +39,10 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
-include::pretty-options.txt[]
+include::pretty-options.adoc[]
 
 
-include::pretty-formats.txt[]
+include::pretty-formats.adoc[]
 
 
 DIFF FORMATTING
@@ -52,9 +52,9 @@ diff output.
 
 :git-log: 1
 :diff-merges-default: `dense-combined`
-include::diff-options.txt[]
+include::diff-options.adoc[]
 
-include::diff-generate-patch.txt[]
+include::diff-generate-patch.adoc[]
 
 
 EXAMPLES
@@ -83,7 +83,7 @@ EXAMPLES
 DISCUSSION
 ----------
 
-include::i18n.txt[]
+include::i18n.adoc[]
 
 GIT
 ---
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.adoc
similarity index 100%
rename from Documentation/git-sparse-checkout.txt
rename to Documentation/git-sparse-checkout.adoc
diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.adoc
similarity index 100%
rename from Documentation/git-stage.txt
rename to Documentation/git-stage.adoc
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.adoc
similarity index 99%
rename from Documentation/git-stash.txt
rename to Documentation/git-stash.adoc
index 06fb7f1d18..1a5177f498 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.adoc
@@ -388,9 +388,9 @@ xargs git log --merges --no-walk --grep=WIP
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/stash.txt[]
+include::config/stash.adoc[]
 
 
 SEE ALSO
diff --git a/Documentation/git-status.txt b/Documentation/git-status.adoc
similarity index 100%
rename from Documentation/git-status.txt
rename to Documentation/git-status.adoc
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.adoc
similarity index 100%
rename from Documentation/git-stripspace.txt
rename to Documentation/git-stripspace.adoc
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.adoc
similarity index 100%
rename from Documentation/git-submodule.txt
rename to Documentation/git-submodule.adoc
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.adoc
similarity index 100%
rename from Documentation/git-svn.txt
rename to Documentation/git-svn.adoc
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.adoc
similarity index 99%
rename from Documentation/git-switch.txt
rename to Documentation/git-switch.adoc
index f38e4c8afa..f55315c51e 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.adoc
@@ -273,9 +273,9 @@ $ git switch -c good-surprises
 CONFIGURATION
 -------------
 
-include::includes/cmd-config-section-all.txt[]
+include::includes/cmd-config-section-all.adoc[]
 
-include::config/checkout.txt[]
+include::config/checkout.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.adoc
similarity index 100%
rename from Documentation/git-symbolic-ref.txt
rename to Documentation/git-symbolic-ref.adoc
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.adoc
similarity index 99%
rename from Documentation/git-tag.txt
rename to Documentation/git-tag.adoc
index 4494729f5e..a4b1c0ec05 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.adoc
@@ -391,7 +391,7 @@ For example:
 $ GIT_COMMITTER_DATE="2006-10-02 10:31" git tag -s v1.0.1
 ------------
 
-include::date-formats.txt[]
+include::date-formats.adoc[]
 
 FILES
 -----
@@ -406,7 +406,7 @@ FILES
 NOTES
 -----
 
-include::ref-reachability-filters.txt[]
+include::ref-reachability-filters.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.adoc
similarity index 100%
rename from Documentation/git-tools.txt
rename to Documentation/git-tools.adoc
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.adoc
similarity index 100%
rename from Documentation/git-unpack-file.txt
rename to Documentation/git-unpack-file.adoc
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.adoc
similarity index 100%
rename from Documentation/git-unpack-objects.txt
rename to Documentation/git-unpack-objects.adoc
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.adoc
similarity index 100%
rename from Documentation/git-update-index.txt
rename to Documentation/git-update-index.adoc
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.adoc
similarity index 100%
rename from Documentation/git-update-ref.txt
rename to Documentation/git-update-ref.adoc
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.adoc
similarity index 100%
rename from Documentation/git-update-server-info.txt
rename to Documentation/git-update-server-info.adoc
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.adoc
similarity index 100%
rename from Documentation/git-upload-archive.txt
rename to Documentation/git-upload-archive.adoc
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.adoc
similarity index 100%
rename from Documentation/git-upload-pack.txt
rename to Documentation/git-upload-pack.adoc
diff --git a/Documentation/git-var.txt b/Documentation/git-var.adoc
similarity index 100%
rename from Documentation/git-var.txt
rename to Documentation/git-var.adoc
diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.adoc
similarity index 100%
rename from Documentation/git-verify-commit.txt
rename to Documentation/git-verify-commit.adoc
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.adoc
similarity index 100%
rename from Documentation/git-verify-pack.txt
rename to Documentation/git-verify-pack.adoc
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.adoc
similarity index 100%
rename from Documentation/git-verify-tag.txt
rename to Documentation/git-verify-tag.adoc
diff --git a/Documentation/git-version.txt b/Documentation/git-version.adoc
similarity index 100%
rename from Documentation/git-version.txt
rename to Documentation/git-version.adoc
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.adoc
similarity index 100%
rename from Documentation/git-web--browse.txt
rename to Documentation/git-web--browse.adoc
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.adoc
similarity index 100%
rename from Documentation/git-whatchanged.txt
rename to Documentation/git-whatchanged.adoc
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.adoc
similarity index 100%
rename from Documentation/git-worktree.txt
rename to Documentation/git-worktree.adoc
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.adoc
similarity index 100%
rename from Documentation/git-write-tree.txt
rename to Documentation/git-write-tree.adoc
diff --git a/Documentation/git.txt b/Documentation/git.adoc
similarity index 98%
rename from Documentation/git.txt
rename to Documentation/git.adoc
index e89a91dd0d..a9c1183318 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.adoc
@@ -245,17 +245,17 @@ ancillary user utilities.
 Main porcelain commands
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-include::{build_dir}/cmds-mainporcelain.txt[]
+include::{build_dir}/cmds-mainporcelain.adoc[]
 
 Ancillary Commands
 ~~~~~~~~~~~~~~~~~~
 Manipulators:
 
-include::{build_dir}/cmds-ancillarymanipulators.txt[]
+include::{build_dir}/cmds-ancillarymanipulators.adoc[]
 
 Interrogators:
 
-include::{build_dir}/cmds-ancillaryinterrogators.txt[]
+include::{build_dir}/cmds-ancillaryinterrogators.adoc[]
 
 
 Interacting with Others
@@ -264,7 +264,7 @@ Interacting with Others
 These commands are to interact with foreign SCM and with other
 people via patch over e-mail.
 
-include::{build_dir}/cmds-foreignscminterface.txt[]
+include::{build_dir}/cmds-foreignscminterface.adoc[]
 
 Reset, restore and revert
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -313,13 +313,13 @@ repositories.
 Manipulation commands
 ~~~~~~~~~~~~~~~~~~~~~
 
-include::{build_dir}/cmds-plumbingmanipulators.txt[]
+include::{build_dir}/cmds-plumbingmanipulators.adoc[]
 
 
 Interrogation commands
 ~~~~~~~~~~~~~~~~~~~~~~
 
-include::{build_dir}/cmds-plumbinginterrogators.txt[]
+include::{build_dir}/cmds-plumbinginterrogators.adoc[]
 
 In general, the interrogate commands do not touch the files in
 the working tree.
@@ -328,12 +328,12 @@ the working tree.
 Syncing repositories
 ~~~~~~~~~~~~~~~~~~~~
 
-include::{build_dir}/cmds-synchingrepositories.txt[]
+include::{build_dir}/cmds-synchingrepositories.adoc[]
 
 The following are helper commands used by the above; end users
 typically do not use them directly.
 
-include::{build_dir}/cmds-synchelpers.txt[]
+include::{build_dir}/cmds-synchelpers.adoc[]
 
 
 Internal helper commands
@@ -342,14 +342,14 @@ Internal helper commands
 These are internal helper commands used by other commands; end
 users typically do not use them directly.
 
-include::{build_dir}/cmds-purehelpers.txt[]
+include::{build_dir}/cmds-purehelpers.adoc[]
 
 Guides
 ------
 
 The following documentation pages are guides about Git concepts.
 
-include::{build_dir}/cmds-guide.txt[]
+include::{build_dir}/cmds-guide.adoc[]
 
 Repository, command and file interfaces
 ---------------------------------------
@@ -358,7 +358,7 @@ This documentation discusses repository and command interfaces which
 users are expected to interact with directly. See `--user-formats` in
 linkgit:git-help[1] for more details on the criteria.
 
-include::{build_dir}/cmds-userinterfaces.txt[]
+include::{build_dir}/cmds-userinterfaces.adoc[]
 
 File formats, protocols and other developer interfaces
 ------------------------------------------------------
@@ -367,7 +367,7 @@ This documentation discusses file formats, over-the-wire protocols and
 other git developer interfaces. See `--developer-interfaces` in
 linkgit:git-help[1].
 
-include::{build_dir}/cmds-developerinterfaces.txt[]
+include::{build_dir}/cmds-developerinterfaces.adoc[]
 
 Configuration Mechanism
 -----------------------
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.adoc
similarity index 100%
rename from Documentation/gitattributes.txt
rename to Documentation/gitattributes.adoc
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.adoc
similarity index 100%
rename from Documentation/gitcli.txt
rename to Documentation/gitcli.adoc
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.adoc
similarity index 100%
rename from Documentation/gitcore-tutorial.txt
rename to Documentation/gitcore-tutorial.adoc
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.adoc
similarity index 100%
rename from Documentation/gitcredentials.txt
rename to Documentation/gitcredentials.adoc
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.adoc
similarity index 100%
rename from Documentation/gitcvs-migration.txt
rename to Documentation/gitcvs-migration.adoc
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.adoc
similarity index 100%
rename from Documentation/gitdiffcore.txt
rename to Documentation/gitdiffcore.adoc
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.adoc
similarity index 100%
rename from Documentation/giteveryday.txt
rename to Documentation/giteveryday.adoc
diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.adoc
similarity index 100%
rename from Documentation/gitfaq.txt
rename to Documentation/gitfaq.adoc
diff --git a/Documentation/gitformat-bundle.txt b/Documentation/gitformat-bundle.adoc
similarity index 100%
rename from Documentation/gitformat-bundle.txt
rename to Documentation/gitformat-bundle.adoc
diff --git a/Documentation/gitformat-chunk.txt b/Documentation/gitformat-chunk.adoc
similarity index 100%
rename from Documentation/gitformat-chunk.txt
rename to Documentation/gitformat-chunk.adoc
diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.adoc
similarity index 100%
rename from Documentation/gitformat-commit-graph.txt
rename to Documentation/gitformat-commit-graph.adoc
diff --git a/Documentation/gitformat-index.txt b/Documentation/gitformat-index.adoc
similarity index 100%
rename from Documentation/gitformat-index.txt
rename to Documentation/gitformat-index.adoc
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.adoc
similarity index 100%
rename from Documentation/gitformat-pack.txt
rename to Documentation/gitformat-pack.adoc
diff --git a/Documentation/gitformat-signature.txt b/Documentation/gitformat-signature.adoc
similarity index 100%
rename from Documentation/gitformat-signature.txt
rename to Documentation/gitformat-signature.adoc
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.adoc
similarity index 90%
rename from Documentation/gitglossary.txt
rename to Documentation/gitglossary.adoc
index 571f640f5c..0e85be4847 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.adoc
@@ -12,7 +12,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-include::glossary-content.txt[]
+include::glossary-content.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.adoc
similarity index 100%
rename from Documentation/githooks.txt
rename to Documentation/githooks.adoc
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.adoc
similarity index 100%
rename from Documentation/gitignore.txt
rename to Documentation/gitignore.adoc
diff --git a/Documentation/gitk.txt b/Documentation/gitk.adoc
similarity index 99%
rename from Documentation/gitk.txt
rename to Documentation/gitk.adoc
index 35b3996029..58ce40ddb1 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.adoc
@@ -98,7 +98,7 @@ linkgit:git-rev-list[1] for a complete list.
 	(See "History simplification" in linkgit:git-log[1] for a more
 	detailed explanation.)
 
-include::line-range-options.txt[]
+include::line-range-options.adoc[]
 
 <revision range>::
 
diff --git a/Documentation/gitmailmap.txt b/Documentation/gitmailmap.adoc
similarity index 100%
rename from Documentation/gitmailmap.txt
rename to Documentation/gitmailmap.adoc
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.adoc
similarity index 100%
rename from Documentation/gitmodules.txt
rename to Documentation/gitmodules.adoc
diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespaces.adoc
similarity index 98%
rename from Documentation/gitnamespaces.txt
rename to Documentation/gitnamespaces.adoc
index 1c8d2ecc35..06f4d37efa 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.adoc
@@ -61,7 +61,7 @@ For a simple local test, you can use linkgit:git-remote-ext[1]:
 git clone ext::'git --namespace=foo %s /tmp/prefixed.git'
 ----------
 
-include::transfer-data-leaks.txt[]
+include::transfer-data-leaks.adoc[]
 
 GIT
 ---
diff --git a/Documentation/gitpacking.txt b/Documentation/gitpacking.adoc
similarity index 99%
rename from Documentation/gitpacking.txt
rename to Documentation/gitpacking.adoc
index 321154d4e6..a56596e2d1 100644
--- a/Documentation/gitpacking.txt
+++ b/Documentation/gitpacking.adoc
@@ -136,7 +136,7 @@ chunks of "stableSize" in order of age.
 
 The exact configuration for pseudo-merges is as follows:
 
-include::config/bitmap-pseudo-merge.txt[]
+include::config/bitmap-pseudo-merge.adoc[]
 
 === Examples
 
diff --git a/Documentation/gitprotocol-capabilities.txt b/Documentation/gitprotocol-capabilities.adoc
similarity index 100%
rename from Documentation/gitprotocol-capabilities.txt
rename to Documentation/gitprotocol-capabilities.adoc
diff --git a/Documentation/gitprotocol-common.txt b/Documentation/gitprotocol-common.adoc
similarity index 100%
rename from Documentation/gitprotocol-common.txt
rename to Documentation/gitprotocol-common.adoc
diff --git a/Documentation/gitprotocol-http.txt b/Documentation/gitprotocol-http.adoc
similarity index 100%
rename from Documentation/gitprotocol-http.txt
rename to Documentation/gitprotocol-http.adoc
diff --git a/Documentation/gitprotocol-pack.txt b/Documentation/gitprotocol-pack.adoc
similarity index 100%
rename from Documentation/gitprotocol-pack.txt
rename to Documentation/gitprotocol-pack.adoc
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.adoc
similarity index 100%
rename from Documentation/gitprotocol-v2.txt
rename to Documentation/gitprotocol-v2.adoc
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.adoc
similarity index 100%
rename from Documentation/gitremote-helpers.txt
rename to Documentation/gitremote-helpers.adoc
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.adoc
similarity index 99%
rename from Documentation/gitrepository-layout.txt
rename to Documentation/gitrepository-layout.adoc
index fa8b51daf0..c77f474311 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.adoc
@@ -292,7 +292,7 @@ worktrees/<id>/locked::
 worktrees/<id>/config.worktree::
 	Working directory specific configuration file.
 
-include::technical/repository-version.txt[]
+include::technical/repository-version.adoc[]
 
 SEE ALSO
 --------
diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.adoc
similarity index 96%
rename from Documentation/gitrevisions.txt
rename to Documentation/gitrevisions.adoc
index d407b7dee1..7146117de5 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/gitrevisions.adoc
@@ -24,7 +24,7 @@ linkgit:git-push[1]) can also take revision parameters which denote
 other objects than commits, e.g. blobs ("files") or trees
 ("directories of files").
 
-include::revisions.txt[]
+include::revisions.adoc[]
 
 
 SEE ALSO
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.adoc
similarity index 100%
rename from Documentation/gitsubmodules.txt
rename to Documentation/gitsubmodules.adoc
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.adoc
similarity index 100%
rename from Documentation/gittutorial-2.txt
rename to Documentation/gittutorial-2.adoc
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.adoc
similarity index 100%
rename from Documentation/gittutorial.txt
rename to Documentation/gittutorial.adoc
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.adoc
similarity index 100%
rename from Documentation/gitweb.txt
rename to Documentation/gitweb.adoc
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.adoc
similarity index 100%
rename from Documentation/gitweb.conf.txt
rename to Documentation/gitweb.conf.adoc
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.adoc
similarity index 100%
rename from Documentation/gitworkflows.txt
rename to Documentation/gitworkflows.adoc
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.adoc
similarity index 100%
rename from Documentation/glossary-content.txt
rename to Documentation/glossary-content.adoc
diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Documentation/howto/coordinate-embargoed-releases.adoc
similarity index 100%
rename from Documentation/howto/coordinate-embargoed-releases.txt
rename to Documentation/howto/coordinate-embargoed-releases.adoc
diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.adoc
similarity index 100%
rename from Documentation/howto/keep-canonical-history-correct.txt
rename to Documentation/howto/keep-canonical-history-correct.adoc
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.adoc
similarity index 100%
rename from Documentation/howto/maintain-git.txt
rename to Documentation/howto/maintain-git.adoc
diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/new-command.adoc
similarity index 100%
rename from Documentation/howto/new-command.txt
rename to Documentation/howto/new-command.adoc
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.adoc
similarity index 100%
rename from Documentation/howto/rebase-from-internal-branch.txt
rename to Documentation/howto/rebase-from-internal-branch.adoc
diff --git a/Documentation/howto/rebuild-from-update-hook.txt b/Documentation/howto/rebuild-from-update-hook.adoc
similarity index 100%
rename from Documentation/howto/rebuild-from-update-hook.txt
rename to Documentation/howto/rebuild-from-update-hook.adoc
diff --git a/Documentation/howto/recover-corrupted-blob-object.txt b/Documentation/howto/recover-corrupted-blob-object.adoc
similarity index 100%
rename from Documentation/howto/recover-corrupted-blob-object.txt
rename to Documentation/howto/recover-corrupted-blob-object.adoc
diff --git a/Documentation/howto/recover-corrupted-object-harder.txt b/Documentation/howto/recover-corrupted-object-harder.adoc
similarity index 100%
rename from Documentation/howto/recover-corrupted-object-harder.txt
rename to Documentation/howto/recover-corrupted-object-harder.adoc
diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.adoc
similarity index 100%
rename from Documentation/howto/revert-a-faulty-merge.txt
rename to Documentation/howto/revert-a-faulty-merge.adoc
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.adoc
similarity index 100%
rename from Documentation/howto/revert-branch-rebase.txt
rename to Documentation/howto/revert-branch-rebase.adoc
diff --git a/Documentation/howto/separating-topic-branches.txt b/Documentation/howto/separating-topic-branches.adoc
similarity index 100%
rename from Documentation/howto/separating-topic-branches.txt
rename to Documentation/howto/separating-topic-branches.adoc
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.adoc
similarity index 100%
rename from Documentation/howto/setup-git-server-over-http.txt
rename to Documentation/howto/setup-git-server-over-http.adoc
diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.adoc
similarity index 100%
rename from Documentation/howto/update-hook-example.txt
rename to Documentation/howto/update-hook-example.adoc
diff --git a/Documentation/howto/use-git-daemon.txt b/Documentation/howto/use-git-daemon.adoc
similarity index 100%
rename from Documentation/howto/use-git-daemon.txt
rename to Documentation/howto/use-git-daemon.adoc
diff --git a/Documentation/howto/using-merge-subtree.txt b/Documentation/howto/using-merge-subtree.adoc
similarity index 100%
rename from Documentation/howto/using-merge-subtree.txt
rename to Documentation/howto/using-merge-subtree.adoc
diff --git a/Documentation/howto/using-signed-tag-in-pull-request.txt b/Documentation/howto/using-signed-tag-in-pull-request.adoc
similarity index 100%
rename from Documentation/howto/using-signed-tag-in-pull-request.txt
rename to Documentation/howto/using-signed-tag-in-pull-request.adoc
diff --git a/Documentation/i18n.txt b/Documentation/i18n.adoc
similarity index 100%
rename from Documentation/i18n.txt
rename to Documentation/i18n.adoc
diff --git a/Documentation/includes/cmd-config-section-all.txt b/Documentation/includes/cmd-config-section-all.adoc
similarity index 100%
rename from Documentation/includes/cmd-config-section-all.txt
rename to Documentation/includes/cmd-config-section-all.adoc
diff --git a/Documentation/includes/cmd-config-section-rest.txt b/Documentation/includes/cmd-config-section-rest.adoc
similarity index 100%
rename from Documentation/includes/cmd-config-section-rest.txt
rename to Documentation/includes/cmd-config-section-rest.adoc
diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
index ed8b4ff3e5..b237b311c3 100755
--- a/Documentation/install-webdoc.sh
+++ b/Documentation/install-webdoc.sh
@@ -3,10 +3,10 @@
 T="$1"
 
 for h in \
-	*.txt *.html \
-	howto/*.txt howto/*.html \
-	technical/*.txt technical/*.html \
-	RelNotes/*.txt *.css
+	*.adoc *.html \
+	howto/*.adoc howto/*.html \
+	technical/*.adoc technical/*.html \
+	RelNotes/*.adoc *.css
 do
 	if test ! -f "$h"
 	then
@@ -24,13 +24,13 @@ do
 done
 strip_leading=$(echo "$T/" | sed -e 's|.|.|g')
 for th in \
-	"$T"/*.html "$T"/*.txt \
-	"$T"/howto/*.txt "$T"/howto/*.html \
-	"$T"/technical/*.txt "$T"/technical/*.html
+	"$T"/*.html "$T"/*.adoc \
+	"$T"/howto/*.adoc "$T"/howto/*.html \
+	"$T"/technical/*.adoc "$T"/technical/*.html
 do
 	h=$(expr "$th" : "$strip_leading"'\(.*\)')
 	case "$h" in
-	RelNotes-*.txt | index.html) continue ;;
+	RelNotes-*.adoc | index.html) continue ;;
 	esac
 	test -f "$h" && continue
 	echo >&2 "# rm -f $th"
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.adoc
similarity index 100%
rename from Documentation/line-range-format.txt
rename to Documentation/line-range-format.adoc
diff --git a/Documentation/line-range-options.txt b/Documentation/line-range-options.adoc
similarity index 95%
rename from Documentation/line-range-options.txt
rename to Documentation/line-range-options.adoc
index 8e295a62b8..f275df3b69 100644
--- a/Documentation/line-range-options.txt
+++ b/Documentation/line-range-options.adoc
@@ -12,4 +12,4 @@
 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
 	`--name-only`, `--name-status`, `--check`) are not currently implemented.
 +
-include::line-range-format.txt[]
+include::line-range-format.adoc[]
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index 1c61dd9512..aea564dad7 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -5,7 +5,7 @@
 
 # Parse arguments, a simple state machine for input like:
 #
-# <file-to-check.txt> <valid-files-to-link-to> --section=1 git.txt git-add.txt [...] --to-lint git-add.txt a-file.txt [...]
+# <file-to-check.adoc> <valid-files-to-link-to> --section=1 git.adoc git-add.adoc [...] --to-lint git-add.adoc a-file.adoc [...]
 my %TXT;
 my %SECTION;
 my $section;
@@ -17,7 +17,7 @@
 		next;
 	}
 
-	my ($name) = $arg =~ /^(.*?)\.txt$/s;
+	my ($name) = $arg =~ /^(.*?)\.adoc$/s;
 	unless (defined $section) {
 		$TXT{$name} = $arg;
 		next;
diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
index 92cfc0a15a..a0ea572382 100755
--- a/Documentation/lint-manpages.sh
+++ b/Documentation/lint-manpages.sh
@@ -31,7 +31,7 @@ check_missing_docs () (
 		git-?*--?* ) continue ;;
 		esac
 
-		if ! test -f "$v.txt"
+		if ! test -f "$v.adoc"
 		then
 			echo "no doc: $v"
 			ret=1
@@ -63,9 +63,9 @@ check_extraneous_docs () {
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' ../command-list.txt
 		make print-man1 |
-		grep '\.txt$' |
+		grep '\.adoc$' |
 		sed -e 's|^|documented |' \
-		    -e 's/\.txt//'
+		    -e 's/\.adoc//'
 	) | (
 		all_commands="$(printf "%s " "$ALL_COMMANDS" "$BUILT_INS" "$EXCLUDED_PROGRAMS" | tr '\n' ' ')"
 		ret=0
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.adoc
similarity index 99%
rename from Documentation/merge-options.txt
rename to Documentation/merge-options.adoc
index 3eaefc4e94..0022185201 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.adoc
@@ -102,7 +102,7 @@ endif::git-pull[]
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
 
-include::signoff-option.txt[]
+include::signoff-option.adoc[]
 
 --stat::
 -n::
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.adoc
similarity index 100%
rename from Documentation/merge-strategies.txt
rename to Documentation/merge-strategies.adoc
diff --git a/Documentation/mergetools/vimdiff.txt b/Documentation/mergetools/vimdiff.adoc
similarity index 100%
rename from Documentation/mergetools/vimdiff.txt
rename to Documentation/mergetools/vimdiff.adoc
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2a26fa8a5f..ead8e48213 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -1,207 +1,207 @@
 manpages = {
   # Category 1.
-  'git-add.txt' : 1,
-  'git-am.txt' : 1,
-  'git-annotate.txt' : 1,
-  'git-apply.txt' : 1,
-  'git-archimport.txt' : 1,
-  'git-archive.txt' : 1,
-  'git-bisect.txt' : 1,
-  'git-blame.txt' : 1,
-  'git-branch.txt' : 1,
-  'git-bugreport.txt' : 1,
-  'git-bundle.txt' : 1,
-  'git-cat-file.txt' : 1,
-  'git-check-attr.txt' : 1,
-  'git-check-ignore.txt' : 1,
-  'git-check-mailmap.txt' : 1,
-  'git-checkout-index.txt' : 1,
-  'git-checkout.txt' : 1,
-  'git-check-ref-format.txt' : 1,
-  'git-cherry-pick.txt' : 1,
-  'git-cherry.txt' : 1,
-  'git-citool.txt' : 1,
-  'git-clean.txt' : 1,
-  'git-clone.txt' : 1,
-  'git-column.txt' : 1,
-  'git-commit-graph.txt' : 1,
-  'git-commit-tree.txt' : 1,
-  'git-commit.txt' : 1,
-  'git-config.txt' : 1,
-  'git-count-objects.txt' : 1,
-  'git-credential-cache--daemon.txt' : 1,
-  'git-credential-cache.txt' : 1,
-  'git-credential-store.txt' : 1,
-  'git-credential.txt' : 1,
-  'git-cvsexportcommit.txt' : 1,
-  'git-cvsimport.txt' : 1,
-  'git-cvsserver.txt' : 1,
-  'git-daemon.txt' : 1,
-  'git-describe.txt' : 1,
-  'git-diagnose.txt' : 1,
-  'git-diff-files.txt' : 1,
-  'git-diff-index.txt' : 1,
-  'git-difftool.txt' : 1,
-  'git-diff-tree.txt' : 1,
-  'git-diff.txt' : 1,
-  'git-fast-export.txt' : 1,
-  'git-fast-import.txt' : 1,
-  'git-fetch-pack.txt' : 1,
-  'git-fetch.txt' : 1,
-  'git-filter-branch.txt' : 1,
-  'git-fmt-merge-msg.txt' : 1,
-  'git-for-each-ref.txt' : 1,
-  'git-for-each-repo.txt' : 1,
-  'git-format-patch.txt' : 1,
-  'git-fsck-objects.txt' : 1,
-  'git-fsck.txt' : 1,
-  'git-fsmonitor--daemon.txt' : 1,
-  'git-gc.txt' : 1,
-  'git-get-tar-commit-id.txt' : 1,
-  'git-grep.txt' : 1,
-  'git-gui.txt' : 1,
-  'git-hash-object.txt' : 1,
-  'git-help.txt' : 1,
-  'git-hook.txt' : 1,
-  'git-http-backend.txt' : 1,
-  'git-http-fetch.txt' : 1,
-  'git-http-push.txt' : 1,
-  'git-imap-send.txt' : 1,
-  'git-index-pack.txt' : 1,
-  'git-init-db.txt' : 1,
-  'git-init.txt' : 1,
-  'git-instaweb.txt' : 1,
-  'git-interpret-trailers.txt' : 1,
-  'git-log.txt' : 1,
-  'git-ls-files.txt' : 1,
-  'git-ls-remote.txt' : 1,
-  'git-ls-tree.txt' : 1,
-  'git-mailinfo.txt' : 1,
-  'git-mailsplit.txt' : 1,
-  'git-maintenance.txt' : 1,
-  'git-merge-base.txt' : 1,
-  'git-merge-file.txt' : 1,
-  'git-merge-index.txt' : 1,
-  'git-merge-one-file.txt' : 1,
-  'git-mergetool--lib.txt' : 1,
-  'git-mergetool.txt' : 1,
-  'git-merge-tree.txt' : 1,
-  'git-merge.txt' : 1,
-  'git-mktag.txt' : 1,
-  'git-mktree.txt' : 1,
-  'git-multi-pack-index.txt' : 1,
-  'git-mv.txt' : 1,
-  'git-name-rev.txt' : 1,
-  'git-notes.txt' : 1,
-  'git-p4.txt' : 1,
-  'git-pack-objects.txt' : 1,
-  'git-pack-redundant.txt' : 1,
-  'git-pack-refs.txt' : 1,
-  'git-patch-id.txt' : 1,
-  'git-prune-packed.txt' : 1,
-  'git-prune.txt' : 1,
-  'git-pull.txt' : 1,
-  'git-push.txt' : 1,
-  'git-quiltimport.txt' : 1,
-  'git-range-diff.txt' : 1,
-  'git-read-tree.txt' : 1,
-  'git-rebase.txt' : 1,
-  'git-receive-pack.txt' : 1,
-  'git-reflog.txt' : 1,
-  'git-refs.txt' : 1,
-  'git-remote-ext.txt' : 1,
-  'git-remote-fd.txt' : 1,
-  'git-remote.txt' : 1,
-  'git-repack.txt' : 1,
-  'git-replace.txt' : 1,
-  'git-replay.txt' : 1,
-  'git-request-pull.txt' : 1,
-  'git-rerere.txt' : 1,
-  'git-reset.txt' : 1,
-  'git-restore.txt' : 1,
-  'git-revert.txt' : 1,
-  'git-rev-list.txt' : 1,
-  'git-rev-parse.txt' : 1,
-  'git-rm.txt' : 1,
-  'git-send-email.txt' : 1,
-  'git-send-pack.txt' : 1,
-  'git-shell.txt' : 1,
-  'git-sh-i18n--envsubst.txt' : 1,
-  'git-sh-i18n.txt' : 1,
-  'git-shortlog.txt' : 1,
-  'git-show-branch.txt' : 1,
-  'git-show-index.txt' : 1,
-  'git-show-ref.txt' : 1,
-  'git-show.txt' : 1,
-  'git-sh-setup.txt' : 1,
-  'git-sparse-checkout.txt' : 1,
-  'git-stage.txt' : 1,
-  'git-stash.txt' : 1,
-  'git-status.txt' : 1,
-  'git-stripspace.txt' : 1,
-  'git-submodule.txt' : 1,
-  'git-svn.txt' : 1,
-  'git-switch.txt' : 1,
-  'git-symbolic-ref.txt' : 1,
-  'git-tag.txt' : 1,
-  'git-unpack-file.txt' : 1,
-  'git-unpack-objects.txt' : 1,
-  'git-update-index.txt' : 1,
-  'git-update-ref.txt' : 1,
-  'git-update-server-info.txt' : 1,
-  'git-upload-archive.txt' : 1,
-  'git-upload-pack.txt' : 1,
-  'git-var.txt' : 1,
-  'git-verify-commit.txt' : 1,
-  'git-verify-pack.txt' : 1,
-  'git-verify-tag.txt' : 1,
-  'git-version.txt' : 1,
-  'git-web--browse.txt' : 1,
-  'git-whatchanged.txt' : 1,
-  'git-worktree.txt' : 1,
-  'git-write-tree.txt' : 1,
-  'git.txt' : 1,
-  'gitk.txt' : 1,
-  'gitweb.txt' : 1,
-  'scalar.txt' : 1,
+  'git-add.adoc' : 1,
+  'git-am.adoc' : 1,
+  'git-annotate.adoc' : 1,
+  'git-apply.adoc' : 1,
+  'git-archimport.adoc' : 1,
+  'git-archive.adoc' : 1,
+  'git-bisect.adoc' : 1,
+  'git-blame.adoc' : 1,
+  'git-branch.adoc' : 1,
+  'git-bugreport.adoc' : 1,
+  'git-bundle.adoc' : 1,
+  'git-cat-file.adoc' : 1,
+  'git-check-attr.adoc' : 1,
+  'git-check-ignore.adoc' : 1,
+  'git-check-mailmap.adoc' : 1,
+  'git-checkout-index.adoc' : 1,
+  'git-checkout.adoc' : 1,
+  'git-check-ref-format.adoc' : 1,
+  'git-cherry-pick.adoc' : 1,
+  'git-cherry.adoc' : 1,
+  'git-citool.adoc' : 1,
+  'git-clean.adoc' : 1,
+  'git-clone.adoc' : 1,
+  'git-column.adoc' : 1,
+  'git-commit-graph.adoc' : 1,
+  'git-commit-tree.adoc' : 1,
+  'git-commit.adoc' : 1,
+  'git-config.adoc' : 1,
+  'git-count-objects.adoc' : 1,
+  'git-credential-cache--daemon.adoc' : 1,
+  'git-credential-cache.adoc' : 1,
+  'git-credential-store.adoc' : 1,
+  'git-credential.adoc' : 1,
+  'git-cvsexportcommit.adoc' : 1,
+  'git-cvsimport.adoc' : 1,
+  'git-cvsserver.adoc' : 1,
+  'git-daemon.adoc' : 1,
+  'git-describe.adoc' : 1,
+  'git-diagnose.adoc' : 1,
+  'git-diff-files.adoc' : 1,
+  'git-diff-index.adoc' : 1,
+  'git-difftool.adoc' : 1,
+  'git-diff-tree.adoc' : 1,
+  'git-diff.adoc' : 1,
+  'git-fast-export.adoc' : 1,
+  'git-fast-import.adoc' : 1,
+  'git-fetch-pack.adoc' : 1,
+  'git-fetch.adoc' : 1,
+  'git-filter-branch.adoc' : 1,
+  'git-fmt-merge-msg.adoc' : 1,
+  'git-for-each-ref.adoc' : 1,
+  'git-for-each-repo.adoc' : 1,
+  'git-format-patch.adoc' : 1,
+  'git-fsck-objects.adoc' : 1,
+  'git-fsck.adoc' : 1,
+  'git-fsmonitor--daemon.adoc' : 1,
+  'git-gc.adoc' : 1,
+  'git-get-tar-commit-id.adoc' : 1,
+  'git-grep.adoc' : 1,
+  'git-gui.adoc' : 1,
+  'git-hash-object.adoc' : 1,
+  'git-help.adoc' : 1,
+  'git-hook.adoc' : 1,
+  'git-http-backend.adoc' : 1,
+  'git-http-fetch.adoc' : 1,
+  'git-http-push.adoc' : 1,
+  'git-imap-send.adoc' : 1,
+  'git-index-pack.adoc' : 1,
+  'git-init-db.adoc' : 1,
+  'git-init.adoc' : 1,
+  'git-instaweb.adoc' : 1,
+  'git-interpret-trailers.adoc' : 1,
+  'git-log.adoc' : 1,
+  'git-ls-files.adoc' : 1,
+  'git-ls-remote.adoc' : 1,
+  'git-ls-tree.adoc' : 1,
+  'git-mailinfo.adoc' : 1,
+  'git-mailsplit.adoc' : 1,
+  'git-maintenance.adoc' : 1,
+  'git-merge-base.adoc' : 1,
+  'git-merge-file.adoc' : 1,
+  'git-merge-index.adoc' : 1,
+  'git-merge-one-file.adoc' : 1,
+  'git-mergetool--lib.adoc' : 1,
+  'git-mergetool.adoc' : 1,
+  'git-merge-tree.adoc' : 1,
+  'git-merge.adoc' : 1,
+  'git-mktag.adoc' : 1,
+  'git-mktree.adoc' : 1,
+  'git-multi-pack-index.adoc' : 1,
+  'git-mv.adoc' : 1,
+  'git-name-rev.adoc' : 1,
+  'git-notes.adoc' : 1,
+  'git-p4.adoc' : 1,
+  'git-pack-objects.adoc' : 1,
+  'git-pack-redundant.adoc' : 1,
+  'git-pack-refs.adoc' : 1,
+  'git-patch-id.adoc' : 1,
+  'git-prune-packed.adoc' : 1,
+  'git-prune.adoc' : 1,
+  'git-pull.adoc' : 1,
+  'git-push.adoc' : 1,
+  'git-quiltimport.adoc' : 1,
+  'git-range-diff.adoc' : 1,
+  'git-read-tree.adoc' : 1,
+  'git-rebase.adoc' : 1,
+  'git-receive-pack.adoc' : 1,
+  'git-reflog.adoc' : 1,
+  'git-refs.adoc' : 1,
+  'git-remote-ext.adoc' : 1,
+  'git-remote-fd.adoc' : 1,
+  'git-remote.adoc' : 1,
+  'git-repack.adoc' : 1,
+  'git-replace.adoc' : 1,
+  'git-replay.adoc' : 1,
+  'git-request-pull.adoc' : 1,
+  'git-rerere.adoc' : 1,
+  'git-reset.adoc' : 1,
+  'git-restore.adoc' : 1,
+  'git-revert.adoc' : 1,
+  'git-rev-list.adoc' : 1,
+  'git-rev-parse.adoc' : 1,
+  'git-rm.adoc' : 1,
+  'git-send-email.adoc' : 1,
+  'git-send-pack.adoc' : 1,
+  'git-shell.adoc' : 1,
+  'git-sh-i18n--envsubst.adoc' : 1,
+  'git-sh-i18n.adoc' : 1,
+  'git-shortlog.adoc' : 1,
+  'git-show-branch.adoc' : 1,
+  'git-show-index.adoc' : 1,
+  'git-show-ref.adoc' : 1,
+  'git-show.adoc' : 1,
+  'git-sh-setup.adoc' : 1,
+  'git-sparse-checkout.adoc' : 1,
+  'git-stage.adoc' : 1,
+  'git-stash.adoc' : 1,
+  'git-status.adoc' : 1,
+  'git-stripspace.adoc' : 1,
+  'git-submodule.adoc' : 1,
+  'git-svn.adoc' : 1,
+  'git-switch.adoc' : 1,
+  'git-symbolic-ref.adoc' : 1,
+  'git-tag.adoc' : 1,
+  'git-unpack-file.adoc' : 1,
+  'git-unpack-objects.adoc' : 1,
+  'git-update-index.adoc' : 1,
+  'git-update-ref.adoc' : 1,
+  'git-update-server-info.adoc' : 1,
+  'git-upload-archive.adoc' : 1,
+  'git-upload-pack.adoc' : 1,
+  'git-var.adoc' : 1,
+  'git-verify-commit.adoc' : 1,
+  'git-verify-pack.adoc' : 1,
+  'git-verify-tag.adoc' : 1,
+  'git-version.adoc' : 1,
+  'git-web--browse.adoc' : 1,
+  'git-whatchanged.adoc' : 1,
+  'git-worktree.adoc' : 1,
+  'git-write-tree.adoc' : 1,
+  'git.adoc' : 1,
+  'gitk.adoc' : 1,
+  'gitweb.adoc' : 1,
+  'scalar.adoc' : 1,
 
   # Category 5.
-  'gitattributes.txt' : 5,
-  'gitformat-bundle.txt' : 5,
-  'gitformat-chunk.txt' : 5,
-  'gitformat-commit-graph.txt' : 5,
-  'gitformat-index.txt' : 5,
-  'gitformat-pack.txt' : 5,
-  'gitformat-signature.txt' : 5,
-  'githooks.txt' : 5,
-  'gitignore.txt' : 5,
-  'gitmailmap.txt' : 5,
-  'gitmodules.txt' : 5,
-  'gitprotocol-capabilities.txt' : 5,
-  'gitprotocol-common.txt' : 5,
-  'gitprotocol-http.txt' : 5,
-  'gitprotocol-pack.txt' : 5,
-  'gitprotocol-v2.txt' : 5,
-  'gitrepository-layout.txt' : 5,
-  'gitweb.conf.txt' : 5,
+  'gitattributes.adoc' : 5,
+  'gitformat-bundle.adoc' : 5,
+  'gitformat-chunk.adoc' : 5,
+  'gitformat-commit-graph.adoc' : 5,
+  'gitformat-index.adoc' : 5,
+  'gitformat-pack.adoc' : 5,
+  'gitformat-signature.adoc' : 5,
+  'githooks.adoc' : 5,
+  'gitignore.adoc' : 5,
+  'gitmailmap.adoc' : 5,
+  'gitmodules.adoc' : 5,
+  'gitprotocol-capabilities.adoc' : 5,
+  'gitprotocol-common.adoc' : 5,
+  'gitprotocol-http.adoc' : 5,
+  'gitprotocol-pack.adoc' : 5,
+  'gitprotocol-v2.adoc' : 5,
+  'gitrepository-layout.adoc' : 5,
+  'gitweb.conf.adoc' : 5,
 
   # Category 7.
-  'gitcli.txt' : 7,
-  'gitcore-tutorial.txt' : 7,
-  'gitcredentials.txt' : 7,
-  'gitcvs-migration.txt' : 7,
-  'gitdiffcore.txt' : 7,
-  'giteveryday.txt' : 7,
-  'gitfaq.txt' : 7,
-  'gitglossary.txt' : 7,
-  'gitpacking.txt' : 7,
-  'gitnamespaces.txt' : 7,
-  'gitremote-helpers.txt' : 7,
-  'gitrevisions.txt' : 7,
-  'gitsubmodules.txt' : 7,
-  'gittutorial-2.txt' : 7,
-  'gittutorial.txt' : 7,
-  'gitworkflows.txt' : 7,
+  'gitcli.adoc' : 7,
+  'gitcore-tutorial.adoc' : 7,
+  'gitcredentials.adoc' : 7,
+  'gitcvs-migration.adoc' : 7,
+  'gitdiffcore.adoc' : 7,
+  'giteveryday.adoc' : 7,
+  'gitfaq.adoc' : 7,
+  'gitglossary.adoc' : 7,
+  'gitpacking.adoc' : 7,
+  'gitnamespaces.adoc' : 7,
+  'gitremote-helpers.adoc' : 7,
+  'gitrevisions.adoc' : 7,
+  'gitsubmodules.adoc' : 7,
+  'gittutorial-2.adoc' : 7,
+  'gittutorial.adoc' : 7,
+  'gitworkflows.adoc' : 7,
 }
 
 docs_backend = get_option('docs_backend')
@@ -287,18 +287,18 @@ git = find_program('git', required: false)
 xmlto = find_program('xmlto')
 
 cmd_lists = [
-  'cmds-ancillaryinterrogators.txt',
-  'cmds-ancillarymanipulators.txt',
-  'cmds-mainporcelain.txt',
-  'cmds-plumbinginterrogators.txt',
-  'cmds-plumbingmanipulators.txt',
-  'cmds-synchingrepositories.txt',
-  'cmds-synchelpers.txt',
-  'cmds-guide.txt',
-  'cmds-developerinterfaces.txt',
-  'cmds-userinterfaces.txt',
-  'cmds-purehelpers.txt',
-  'cmds-foreignscminterface.txt',
+  'cmds-ancillaryinterrogators.adoc',
+  'cmds-ancillarymanipulators.adoc',
+  'cmds-mainporcelain.adoc',
+  'cmds-plumbinginterrogators.adoc',
+  'cmds-plumbingmanipulators.adoc',
+  'cmds-synchingrepositories.adoc',
+  'cmds-synchelpers.adoc',
+  'cmds-guide.adoc',
+  'cmds-developerinterfaces.adoc',
+  'cmds-userinterfaces.adoc',
+  'cmds-purehelpers.adoc',
+  'cmds-foreignscminterface.adoc',
 ]
 
 documentation_deps += custom_target(
@@ -325,7 +325,7 @@ foreach mode : [ 'diff', 'merge' ]
       'MERGE_TOOLS_DIR=' + meson.project_source_root() / 'mergetools',
     ],
     input: 'generate-mergetool-list.sh',
-    output: 'mergetools-' + mode + '.txt',
+    output: 'mergetools-' + mode + '.adoc',
   )
 endforeach
 
@@ -414,7 +414,7 @@ if get_option('docs').contains('html')
       '--out-file=@OUTPUT@',
       '@INPUT@',
     ],
-    input: 'user-manual.txt',
+    input: 'user-manual.adoc',
     output: 'user-manual.xml',
     depends: documentation_deps,
   )
@@ -436,14 +436,14 @@ if get_option('docs').contains('html')
   )
 
   articles = [
-    'DecisionMaking.txt',
-    'MyFirstContribution.txt',
-    'MyFirstObjectWalk.txt',
-    'ReviewingGuidelines.txt',
+    'DecisionMaking.adoc',
+    'MyFirstContribution.adoc',
+    'MyFirstObjectWalk.adoc',
+    'ReviewingGuidelines.adoc',
     'SubmittingPatches',
-    'ToolsForGit.txt',
-    'git-bisect-lk2009.txt',
-    'git-tools.txt',
+    'ToolsForGit.adoc',
+    'git-bisect-lk2009.adoc',
+    'git-tools.adoc',
   ]
 
   foreach article : articles
@@ -475,8 +475,8 @@ endif
 # Sanity check that we are not missing any tests present in 't/'. This check
 # only runs once at configure time and is thus best-effort, only. Furthermore,
 # it only verifies man pages for the sake of simplicity.
-configured_manpages = manpages.keys() + [ 'git-bisect-lk2009.txt', 'git-tools.txt' ]
-actual_manpages = run_command(shell, '-c', 'ls git*.txt scalar.txt',
+configured_manpages = manpages.keys() + [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
+actual_manpages = run_command(shell, '-c', 'ls git*.adoc scalar.adoc',
   check: true,
   env: script_environment,
 ).stdout().strip().split('\n')
diff --git a/Documentation/object-format-disclaimer.txt b/Documentation/object-format-disclaimer.adoc
similarity index 100%
rename from Documentation/object-format-disclaimer.txt
rename to Documentation/object-format-disclaimer.adoc
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.adoc
similarity index 100%
rename from Documentation/pretty-formats.txt
rename to Documentation/pretty-formats.adoc
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.adoc
similarity index 100%
rename from Documentation/pretty-options.txt
rename to Documentation/pretty-options.adoc
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.adoc
similarity index 100%
rename from Documentation/pull-fetch-param.txt
rename to Documentation/pull-fetch-param.adoc
diff --git a/Documentation/ref-reachability-filters.txt b/Documentation/ref-reachability-filters.adoc
similarity index 100%
rename from Documentation/ref-reachability-filters.txt
rename to Documentation/ref-reachability-filters.adoc
diff --git a/Documentation/ref-storage-format.txt b/Documentation/ref-storage-format.adoc
similarity index 100%
rename from Documentation/ref-storage-format.txt
rename to Documentation/ref-storage-format.adoc
diff --git a/Documentation/rerere-options.txt b/Documentation/rerere-options.adoc
similarity index 100%
rename from Documentation/rerere-options.txt
rename to Documentation/rerere-options.adoc
diff --git a/Documentation/rev-list-description.txt b/Documentation/rev-list-description.adoc
similarity index 100%
rename from Documentation/rev-list-description.txt
rename to Documentation/rev-list-description.adoc
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.adoc
similarity index 99%
rename from Documentation/rev-list-options.txt
rename to Documentation/rev-list-options.adoc
index 459e5a02f5..196b2781cc 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.adoc
@@ -1059,7 +1059,7 @@ more specialized family of commit log tools: linkgit:git-log[1],
 linkgit:git-show[1], and linkgit:git-whatchanged[1]
 endif::git-rev-list[]
 
-include::pretty-options.txt[]
+include::pretty-options.adoc[]
 
 --relative-date::
 	Synonym for `--date=relative`.
diff --git a/Documentation/revisions.txt b/Documentation/revisions.adoc
similarity index 100%
rename from Documentation/revisions.txt
rename to Documentation/revisions.adoc
diff --git a/Documentation/scalar.txt b/Documentation/scalar.adoc
similarity index 100%
rename from Documentation/scalar.txt
rename to Documentation/scalar.adoc
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.adoc
similarity index 100%
rename from Documentation/sequencer.txt
rename to Documentation/sequencer.adoc
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.adoc
similarity index 100%
rename from Documentation/signoff-option.txt
rename to Documentation/signoff-option.adoc
diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.adoc
similarity index 100%
rename from Documentation/technical/api-error-handling.txt
rename to Documentation/technical/api-error-handling.adoc
diff --git a/Documentation/technical/api-index-skel.txt b/Documentation/technical/api-index-skel.adoc
similarity index 100%
rename from Documentation/technical/api-index-skel.txt
rename to Documentation/technical/api-index-skel.adoc
diff --git a/Documentation/technical/api-index.sh b/Documentation/technical/api-index.sh
index 2964885574..dd206b1ca4 100755
--- a/Documentation/technical/api-index.sh
+++ b/Documentation/technical/api-index.sh
@@ -13,18 +13,18 @@ OUTPUT="$2"
 	cd "$SOURCE_DIR"
 
 	c=////////////////////////////////////////////////////////////////
-	skel=api-index-skel.txt
+	skel=api-index-skel.adoc
 	sed -e '/^\/\/ table of contents begin/q' "$skel"
 	echo "$c"
 
-	ls api-*.txt |
+	ls api-*.adoc |
 	while read filename
 	do
 		case "$filename" in
-		api-index-skel.txt | api-index.txt) continue ;;
+		api-index-skel.adoc | api-index.adoc) continue ;;
 		esac
 		title=$(sed -e 1q "$filename")
-		html=${filename%.txt}.html
+		html=${filename%.adoc}.html
 		echo "* link:$html[$title]"
 	done
 	echo "$c"
diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.adoc
similarity index 100%
rename from Documentation/technical/api-merge.txt
rename to Documentation/technical/api-merge.adoc
diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.adoc
similarity index 100%
rename from Documentation/technical/api-parse-options.txt
rename to Documentation/technical/api-parse-options.adoc
diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.adoc
similarity index 100%
rename from Documentation/technical/api-simple-ipc.txt
rename to Documentation/technical/api-simple-ipc.adoc
diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.adoc
similarity index 99%
rename from Documentation/technical/api-trace2.txt
rename to Documentation/technical/api-trace2.adoc
index 5817b18310..cf493dae03 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.adoc
@@ -140,7 +140,7 @@ $ cat ~/log.event
 To enable a target, set the corresponding environment variable or
 system or global config value to one of the following:
 
-include::../trace2-target-values.txt[]
+include::../trace2-target-values.adoc[]
 
 When trace files are written to a target directory, they will be named according
 to the last component of the SID (optionally followed by a counter to avoid
diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.adoc
similarity index 100%
rename from Documentation/technical/bitmap-format.txt
rename to Documentation/technical/bitmap-format.adoc
diff --git a/Documentation/technical/build-systems.txt b/Documentation/technical/build-systems.adoc
similarity index 100%
rename from Documentation/technical/build-systems.txt
rename to Documentation/technical/build-systems.adoc
diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.adoc
similarity index 100%
rename from Documentation/technical/bundle-uri.txt
rename to Documentation/technical/bundle-uri.adoc
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.adoc
similarity index 100%
rename from Documentation/technical/commit-graph.txt
rename to Documentation/technical/commit-graph.adoc
diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.adoc
similarity index 100%
rename from Documentation/technical/directory-rename-detection.txt
rename to Documentation/technical/directory-rename-detection.adoc
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.adoc
similarity index 100%
rename from Documentation/technical/hash-function-transition.txt
rename to Documentation/technical/hash-function-transition.adoc
diff --git a/Documentation/technical/long-running-process-protocol.txt b/Documentation/technical/long-running-process-protocol.adoc
similarity index 100%
rename from Documentation/technical/long-running-process-protocol.txt
rename to Documentation/technical/long-running-process-protocol.adoc
diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.adoc
similarity index 100%
rename from Documentation/technical/multi-pack-index.txt
rename to Documentation/technical/multi-pack-index.adoc
diff --git a/Documentation/technical/pack-heuristics.txt b/Documentation/technical/pack-heuristics.adoc
similarity index 100%
rename from Documentation/technical/pack-heuristics.txt
rename to Documentation/technical/pack-heuristics.adoc
diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.adoc
similarity index 100%
rename from Documentation/technical/packfile-uri.txt
rename to Documentation/technical/packfile-uri.adoc
diff --git a/Documentation/technical/parallel-checkout.txt b/Documentation/technical/parallel-checkout.adoc
similarity index 100%
rename from Documentation/technical/parallel-checkout.txt
rename to Documentation/technical/parallel-checkout.adoc
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.adoc
similarity index 100%
rename from Documentation/technical/partial-clone.txt
rename to Documentation/technical/partial-clone.adoc
diff --git a/Documentation/technical/platform-support.txt b/Documentation/technical/platform-support.adoc
similarity index 100%
rename from Documentation/technical/platform-support.txt
rename to Documentation/technical/platform-support.adoc
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.adoc
similarity index 100%
rename from Documentation/technical/racy-git.txt
rename to Documentation/technical/racy-git.adoc
diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.adoc
similarity index 100%
rename from Documentation/technical/reftable.txt
rename to Documentation/technical/reftable.adoc
diff --git a/Documentation/technical/remembering-renames.txt b/Documentation/technical/remembering-renames.adoc
similarity index 100%
rename from Documentation/technical/remembering-renames.txt
rename to Documentation/technical/remembering-renames.adoc
diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.adoc
similarity index 100%
rename from Documentation/technical/repository-version.txt
rename to Documentation/technical/repository-version.adoc
diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.adoc
similarity index 100%
rename from Documentation/technical/rerere.txt
rename to Documentation/technical/rerere.adoc
diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.adoc
similarity index 100%
rename from Documentation/technical/scalar.txt
rename to Documentation/technical/scalar.adoc
diff --git a/Documentation/technical/send-pack-pipeline.txt b/Documentation/technical/send-pack-pipeline.adoc
similarity index 100%
rename from Documentation/technical/send-pack-pipeline.txt
rename to Documentation/technical/send-pack-pipeline.adoc
diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.adoc
similarity index 100%
rename from Documentation/technical/shallow.txt
rename to Documentation/technical/shallow.adoc
diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/technical/sparse-checkout.adoc
similarity index 100%
rename from Documentation/technical/sparse-checkout.txt
rename to Documentation/technical/sparse-checkout.adoc
diff --git a/Documentation/technical/sparse-index.txt b/Documentation/technical/sparse-index.adoc
similarity index 100%
rename from Documentation/technical/sparse-index.txt
rename to Documentation/technical/sparse-index.adoc
diff --git a/Documentation/technical/trivial-merge.txt b/Documentation/technical/trivial-merge.adoc
similarity index 100%
rename from Documentation/technical/trivial-merge.txt
rename to Documentation/technical/trivial-merge.adoc
diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technical/unit-tests.adoc
similarity index 100%
rename from Documentation/technical/unit-tests.txt
rename to Documentation/technical/unit-tests.adoc
diff --git a/Documentation/trace2-target-values.txt b/Documentation/trace2-target-values.adoc
similarity index 100%
rename from Documentation/trace2-target-values.txt
rename to Documentation/trace2-target-values.adoc
diff --git a/Documentation/transfer-data-leaks.txt b/Documentation/transfer-data-leaks.adoc
similarity index 100%
rename from Documentation/transfer-data-leaks.txt
rename to Documentation/transfer-data-leaks.adoc
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.adoc
similarity index 99%
rename from Documentation/urls-remotes.txt
rename to Documentation/urls-remotes.adoc
index bf17012241..9b10151198 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.adoc
@@ -1,4 +1,4 @@
-include::urls.txt[]
+include::urls.adoc[]
 
 REMOTES[[REMOTES]]
 ------------------
diff --git a/Documentation/urls.txt b/Documentation/urls.adoc
similarity index 100%
rename from Documentation/urls.txt
rename to Documentation/urls.adoc
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.adoc
similarity index 99%
rename from Documentation/user-manual.txt
rename to Documentation/user-manual.adoc
index 90a4189358..d2b478ad23 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.adoc
@@ -4354,7 +4354,7 @@ itself!
 [[git-explained]]
 === Git explained
 
-include::glossary-content.txt[]
+include::glossary-content.adoc[]
 
 [[git-quick-start]]
 [appendix]
diff --git a/Makefile b/Makefile
index 97e8385b66..0c1acbfe71 100644
--- a/Makefile
+++ b/Makefile
@@ -2528,17 +2528,17 @@ $(BUILT_INS): git$X
 
 config-list.h: generate-configlist.sh
 
-config-list.h: Documentation/*config.txt Documentation/config/*.txt
+config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
-command-list.h: $(wildcard Documentation/git*.txt)
+command-list.h: $(wildcard Documentation/git*.adoc)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
 		. $@
 
-hook-list.h: generate-hooklist.sh Documentation/githooks.txt
+hook-list.h: generate-hooklist.sh Documentation/githooks.adoc
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh . $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):\
diff --git a/RelNotes b/RelNotes
index 978481996e..ac72bdf04d 120000
--- a/RelNotes
+++ b/RelNotes
@@ -1 +1 @@
-Documentation/RelNotes/2.49.0.txt
\ No newline at end of file
+Documentation/RelNotes/2.49.0.adoc
\ No newline at end of file
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index b923a5aab8..0ed39c4c5d 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -76,7 +76,7 @@ print_command_list () {
 				break
 				;;
 			esac
-		done <"$1/Documentation/$cmd.txt"
+		done <"$1/Documentation/$cmd.adoc"
 
 		printf '\t{ "%s", N_("%s"), 0' "$cmd" "$synopsis"
 		printf " | CAT_%s" $rest
diff --git a/generate-configlist.sh b/generate-configlist.sh
index 579422619c..dffdaada8b 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -13,7 +13,7 @@ print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] = {
 EOF
-	grep -h '^[a-zA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/*config.txt "$SOURCE_DIR"/Documentation/config/*.txt |
+	grep -h '^[a-zA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |
 	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
 	sort |
 	sed 's/^.*$/	"&",/'
diff --git a/generate-hooklist.sh b/generate-hooklist.sh
index e22068c2fa..e0cdf26944 100755
--- a/generate-hooklist.sh
+++ b/generate-hooklist.sh
@@ -22,7 +22,7 @@ EOF
 sed -n \
 	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
 	-e 'x' \
-	<"$SOURCE_DIR"/Documentation/githooks.txt |
+	<"$SOURCE_DIR"/Documentation/githooks.adoc |
 	LC_ALL=C sort
 
 cat <<EOF
diff --git a/meson.build b/meson.build
index 7361eb2eaa..743b942d21 100644
--- a/meson.build
+++ b/meson.build
@@ -626,7 +626,7 @@ libgit_sources += custom_target(
 )
 
 libgit_sources += custom_target(
-  input: 'Documentation/githooks.txt',
+  input: 'Documentation/githooks.adoc',
   output: 'hook-list.h',
   command: [
     shell,
