Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E032571A0
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593773; cv=none; b=Z+Q5wDzW53BWmCxoYXkWdMBA6NzuXPAWzs8Fool5J+NkQUZgaDglbha4I9De0AJA7hVOhoFHbmkrUM9I9+ho4Pa5QJiWY0wV6Z3+Z0KmzWgNIx+Jo1Uo2da6HWyK7EgJKeIBRa9P2obvqNrNUo9Wvx9BLsKL5QVfi+eGBQzK8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593773; c=relaxed/simple;
	bh=gAUCBBfAk4QNry9d26uJbBjTxHlwKKe0gzlY2pPMoNI=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=o1T6dC+Tw3fXvwZ6AQh51wWFTwRrAT+Y88rALOu3Rhg3ks5uE58rqUHdB+JIEKF64C994d9pVxYC6XKLHh0BlAbLlGwU5cht2TlMaHT3mhLcCGvhz2xWeH8TelPLMP21KBR1aUwJoliiN+jqpSEbNpgL7HjChPYUIKHtGce3pys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=pv6jtGnN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="pv6jtGnN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754593768; x=1755198568;
	i=johannes.schindelin@gmx.de;
	bh=xfj1QFtox6f5XOq43/w5R39cV8oY/QY8y/zKZ90bYZE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=pv6jtGnNNbz4pGH7bIysiJjCFUqXv7BOY5W9Wcnp6ag7U4BtNr5qrRaDkO0YgF+M
	 L9WPrbuuAMdqqnf9UkO3K8eFy+RjLxjia1prks7HdUxH8glbCC6Qn9NAi3OICinRj
	 GCwIwE+KAXEqXRvA6rwnu8lyOyiY0DmH0Va0Y1ZYH4aUP4qwxXJGCssI1Q9KhaYes
	 GtQXJrGfjeMp8Gxn3Qnm4EzVg4DxJTTIfuvcV3BRaaXw0SX4LbIpEiecAPTypsOFk
	 0rFrwYAlOFXGwpRPeL92G0co40uxu0TJTwvM68KAwAULjNmfpJ8jjnH4jzwslTivt
	 xVaH+5pFj8VwVrmKXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1v5yQK2HPk-00QZTO; Thu, 07
 Aug 2025 21:09:28 +0200
Date: Thu, 7 Aug 2025 21:09:26 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.51.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MLzBj-1v1tpB2shF-00MQbz@mail.gmx.net>
X-Provags-ID: V03:K1://UxFgUpZB4u+LRjzl0zf3Vn9N9Vu4tD6M6yuEtgWYyQ/LvOaOx
 RT4COpdS+ZwYvX3/+fLbu8xaS8TCerfxDECy0DzINWGIkK66SKOxUlS5EprBPBGfcKb/Oxn
 RDv2QWy3fRRPt3GdUeejxdVbW/opCt2BUWryJi52kQ5p8PNXuucVwCaLqJ55wmREBLRqC+A
 wEGsqPYsAIBvUDyUw5PTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mGCKCg0krN0=;NjDqgyTf0INaI9BAylSChqstAoV
 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

Dear Git users,

I hereby announce that Git for Windows 2.51.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.51.0-rc1.windows.1

Changes since Git for Windows v2.50.1 (July 8th 2025)

New Features

  * Comes with Git v2.51.0-rc1.
  * The Portable Git installers (which are self-extracting 7-Zip
    archives) are now based off of 7-Zip 25.00
  * Comes with cURL v8.15.0.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.4.

Git-2.51.0-rc1-64-bit.exe | ef8dad28ffad12eb1baefa4d2ed108cf5e3235d6ec00837590b0020bddaf88be
Git-2.51.0-rc1-arm64.exe | a590d46d4408c7a072af3bb9e9dd9f129f0d97006d68c797a00297dc32eba34f
PortableGit-2.51.0-rc1-64-bit.7z.exe | 83db99592683faa184da5eec9874e13e11c218093c8ea260ecd0045014edcbe2
PortableGit-2.51.0-rc1-arm64.7z.exe | ca19a6b04d06732644f8999c5d61d231f1e396c37345624006e9a59169a00a3f
MinGit-2.51.0-rc1-64-bit.zip | 57a42fec5bea403fc7cef60880b28c90ab810a30ce0c015be50870f768b31add
MinGit-2.51.0-rc1-arm64.zip | 8f1f6a4f3348c68c7673e15cb16b7481f90b19af7ff794524c8bd6e80fedab88
MinGit-2.51.0-rc1-32-bit.zip | f66662fec8206f0214391d237a19e140e79b9f46ad90f58e0bf653746568e06b
MinGit-2.51.0-rc1-busybox-64-bit.zip | 5711d4db0e3160e30e6bce4e969b3f6828ce89bc64a3767ca081ae2391ccaa51
MinGit-2.51.0-rc1-busybox-32-bit.zip | 52763ec1fcd5d70f35b6e0df4cea4791f32af4d5427ef803f8d3070342648e15
Git-2.51.0-rc1-64-bit.tar.bz2 | d4159c2b8d937bc615e7e2f37705db1e8a06364b55172bc36a3ae519d6800f27
Git-2.51.0-rc1-arm64.tar.bz2 | bc923a8218000d952ac86ed73b9f08746e3c53bfb186a59a41749da0f1c07620

Ciao,
Johannes
