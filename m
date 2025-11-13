Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74CE327208
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036891; cv=none; b=mZRdNPYPzCzGWmFPmpFwz9PfdYcdNAmmquRwht8CMFRYGBoZvsMRfnxRB8idZgLzIZ82VeZFggxY1roFAe5ySXBHgop8B4FPeYPSVlQ4Y8Hm8waYr/ARPasDy+BF92u0cmR2KyQB3VWOv6Eh9Hw2t0vt+6+PnEr0UYVHaDXUsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036891; c=relaxed/simple;
	bh=9KJaW3vEYc2M1aFznC83YpSwZLjjSOVlrZtddOxsMtU=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=uK4DrMQXs4cS4/HirT8JEC0PnQ3mxMIXM7fUYKflOMqVvrClmSRfCMjQwnJfZZo7xHawmeAq1+8Nh/8f0uqzVp1ktmKHgIC2QD2W/4hs9MtqXCejC3jC5QuaSfkuW10tYNLx3o5lycIXoAj6DBZO6U12XzfXnAgtG9WqXFo7s54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=H+PuEuuk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="H+PuEuuk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763036884; x=1763641684;
	i=johannes.schindelin@gmx.de;
	bh=SqBeys30ymOgPQl1N8R1oYPvsuFO295QnU2CwlXVMEA=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=H+PuEuukPt8SWMwBF+cQPFDYdxS/vUq8rcXbHZQECNqQb6raeH0KwKBCnoq/tNL/
	 csTuW29KmBM7+cXC5hf0cxLa4MH4H/tUfswmGAuVyPfurQ9rt+6qALvENtWsJueXm
	 +ZOu3z1i5YznFrgS2CmBLnTVkcYOtP+CfUS9HmVCjOimFeHWpwCttXH8/Qg3zDTF9
	 o1LZrNIzbNirDm6ZXKmdjjnLMW+mx1zaWt8/sDXNQGYMVWb//TawZNzJYY7dEVWAl
	 HfqsOq5DdAt1/ZHGX3nx3z+kfE4wFPMMLkVc1fkqUKskHokSS/JimownxJHXEMkrs
	 WAZGBucLzSOg7/bDmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.65]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhlf-1vRWeh0QNj-00Fq3x; Thu, 13
 Nov 2025 13:28:04 +0100
Date: Thu, 13 Nov 2025 13:28:02 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.52.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MacOQ-1vvJxW0uqI-00ekxU@mail.gmx.net>
X-Provags-ID: V03:K1:TdSPz+cbOct6LROuEJPTZZMEvlR/lnrY46DS6fIZgLu+0srNk4M
 3+w8haEh4eRKuBM3ZxKAdMQgcu2OGw/FmQ0zClKoScm40ZsKdIvc/emXjIAE3hoErixcXrO
 6dy1fwzcQrEj8BTjSqSM5yj5ZaRIkJ/XyXgxT3JjFX5X/hsPKbl9BQwWY9+z3pvm1m4a/fi
 qAXpNaltF5DwAKW1L7Guw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:knGGwaZGN/w=;GqmxWIm94qPtIeU5huQ8Meed8qE
 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
 /vsXN6NNDAqRLDYSc=

Dear Git users,

I hereby announce that Git for Windows 2.52.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.52.0-rc2.windows.1

Changes since Git for Windows v2.51.2 (October 28th 2025)

As announced in several recent release notes, git svn is no longer
supported by the Git for Windows project.

New Features

  * Comes with Git v2.52.0-rc2.
  * Comes with PCRE2 v10.47.
  * Comes with cURL v8.17.0.
  * The Git for Windows installer is now built with version 6.6.0 of
    InnoSetup, giving it a more modern look.

Git-2.52.0-rc2-64-bit.exe | e25c0eb211c093adc3a23b6c668a146a61896f81d84b30cebe3e9cadd2396efe
Git-2.52.0-rc2-arm64.exe | c99c4cf3d91ea29a2eefa49603e051782fda6f378de6f4b385236984026b88b9
PortableGit-2.52.0-rc2-64-bit.7z.exe | 326b0d3fda15522cbe15c06f2b09fa088a9df9270579ebfd18aefb5ac60f8cbb
PortableGit-2.52.0-rc2-arm64.7z.exe | 47003eb65bf34fa1929189d4571e43a307a15b01210957236e4a25420517ffa3
MinGit-2.52.0-rc2-64-bit.zip | e5e0f1d89256c7dd63b4132688ac7dc6034dc8252857c3e0c33d7d673063acf1
MinGit-2.52.0-rc2-arm64.zip | 92097c06ebbd5b3c28449fd13f03220f7bc4ff49240185a7ae4a8caf52864529
MinGit-2.52.0-rc2-32-bit.zip | 1e2c8eb4f5e06b2a3b33fd882563bc12679436a4fc59b5ce7ed2252014950917
MinGit-2.52.0-rc2-busybox-64-bit.zip | 4a626dc900364de41fdfeeff4adaa70361d32e7daa65d929349b3482b54c4fef
MinGit-2.52.0-rc2-busybox-32-bit.zip | b103a371e93e364ddf5d738e0af63a6280afe42f072462be3370c7df3bbb7477
Git-2.52.0-rc2-64-bit.tar.bz2 | 8ccf466bb7a862a1e1789aaa8d5c5532c3431a2d1b61d59d18f695cffaf8c2c7
Git-2.52.0-rc2-arm64.tar.bz2 | 033e4a862d4fd7b9aab62979dc36f0d679d6f24e713c136e61a2c96b02abb354

Ciao,
Johannes
