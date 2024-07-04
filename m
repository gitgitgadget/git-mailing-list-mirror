Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA82F56
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053635; cv=none; b=kAAFw1HbQHUvvk9eeO+hdUcpOgI5u7Z0dB3pvdM4fd4PXzA9KsSGnQ1tQay5FKPDb8BwdzScYtMkm7wsu6yOppxZA/YgLT9wEPX5U7ER5jb8/BKbdXWeCPA/dMSNFf9qVEvHVx0tbPceUIS7gCclFYHygbF8tP8pRPyPdKyAnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053635; c=relaxed/simple;
	bh=Ne/9rSEPkeuWqs8JQP5rHsSQmXgzPVjs4kgiTpLSvaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVFEeV9p+Nv1LkzXpNhrhnyQCN8zpZLfORxdbv3RD1UKfXV7EK1gnBhf9FIWTc9GVT0UEfsl+5/WxMGTQVtRfGPGMte7ivxhNH5W4U6uZyHUeKfqTDKt5lwcZC/c3SJUGbFeIo29BSLEI3rdaAc7C467v4lPtR//BDKIKPBlPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HsGfOMBm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HsGfOMBm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720053631;
	bh=Ne/9rSEPkeuWqs8JQP5rHsSQmXgzPVjs4kgiTpLSvaY=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HsGfOMBmCLhKljeGwjlPIHGcPsoiQMcrfJl4nKDbHJFpa2KUqOPH4ltPSa/iva4I7
	 dpeM2HTNBvaUse6ZfFvZ/OS2J3e3rx6wVY5Fulc+IGRLzaIGosqGPvn+TD523SSOqo
	 3c0mg0oQ+iZRieYfe2NmIfDhv1OnTsIG2EsWZwiq0ttLwwE7CK6g7itVA6oyZtPYme
	 jAXjON9PtsxaDaEnrXC2ZHLPD8ppqWN4lvQDeHwxDvVqg+q4vZMvIW2TwLqOcPGeNu
	 oSapAt7h5EWCR8Lq5q0rI0V8B2AaCcatgNyHF+6PaGFjXJ6G3QYrhrZEQsOdcz0OQj
	 bjg2xvUHgeBBl+uAE9753bSEt4Ueouw8Jd5CphNveXzIuuktXYZLcsH8zdj9VIrgkv
	 q6VeNOC++F6w17dc8/xjo4rLxtb1ZeUJySi+P/UTUBuKpBgKBYt4R6kDKVTRAXb2fW
	 FUS8zmNfgr3xhMHfokWVQypfXU5sRDa/heijLxngAC82iLm9i32
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B0C3E20993;
	Thu,  4 Jul 2024 00:40:31 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] Additional FAQ entries
Date: Thu,  4 Jul 2024 00:38:14 +0000
Message-ID: <20240704003818.750223-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces some additional Git FAQ entries on various
topics.  They are all things I've seen in my professional life or on
Stack Overflow, so I've written documentation.

There were some suggestions in the past that the text "modify, tamper
with, or buffer" might be somewhat redundant, but I've chosen to keep
the text as it is to avoid arguments like, "Well, buffering the entire
request or response isn't really modifying it, so Git should just work
in that situation," when we already know that doesn't work.

Changes from v2 (partial):
* Add documentation on proxies to the configuration documentation as
  well.
* Mention some security problems that are known to occur with TLS MITM
  proxies.  This mirrors the similar Git LFS documentation.
* Provide a documentation example about how to use proxies with SSH.
* Recommend running a `git fsck` after syncing with rsync.

Changes from v1:
* Drop the monorepo patch for now; I want to revise it further.
* Reorder the working tree patch to place more warnings up front.
* Mention core.gitproxy and socat.
* Rephrase text in the EOL entry to read correctly and be easier to
  understand.
* Improve the commit message for the working tree FAQ entry to make it
  clearer that users wish to transfer uncommitted changes.

brian m. carlson (4):
  gitfaq: add documentation on proxies
  gitfaq: give advice on using eol attribute in gitattributes
  gitfaq: add entry about syncing working trees
  doc: mention that proxies must be completely transparent

 Documentation/config/http.txt |   5 ++
 Documentation/gitfaq.txt      | 105 ++++++++++++++++++++++++++++++++--
 2 files changed, 104 insertions(+), 6 deletions(-)

