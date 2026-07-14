Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090141B8D0
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058307; cv=none; b=r3CoQeHwfbdeadJsSPCRAfiE2A8ZHV3BZOTyXJvBJwYMzx6oOWIpOOEgiTHgLwB9K5KTvA7SGgUWozdRn5zShgHaT0YzkE8wosYMHdS+EYcMrdoNZEWhcYktEyJSee9TUux2q86k3jcg73QQBFurWg4INzIWZXqV14rqFCVy7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058307; c=relaxed/simple;
	bh=AYZ9+v9MnLp7o4tnEUxvjSGHqVyIEi5jpGA1Awrrz+w=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=U1bjGs6mtNMkU27BzmJHNdNb+XM0lJNplG25lg6vUEXcXCGDbKxXMi0sKtuJSJrQxxocGRzbbz4hoh6ELVYymJwahlKAucH6wCNy78lnJbmWC3xP0+MIWtHK/a5ag0WIDCE+l9oOkE9+6b2B6KLljZPpyzEdt3I82ckHz9AaR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=N0jTgjiH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="N0jTgjiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784058297; x=1784663097;
	i=johannes.schindelin@gmx.de;
	bh=8jI42sVywkprCZE1do3HO/6bKoIBs4lYI87HXFFKtCU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=N0jTgjiHm+xNV0yBnnALQ6i6UpmcbU/SGpxte1LFWZQV7Y36437MEhG9yTolMdFz
	 iLFpb+DlU5ZdhjEStqZXeBGXH8zCNUCApj57XzGbKrMiTJCT4Ba7/WmNNNZZ82ozE
	 8yI6ahFIGndhJrJ1tMbc5wr0B1kZMfFPuq6R8H8Miij5r+g/Ozf9pyG72b8NPvSHm
	 41EUZ4VrdYR1h2UzQRnv6yQmCI9nU2AUP970bX8I7TL1L5IiWBlmGUqPes5Rt+Q95
	 hiVOkdP6SSr3E7xFlXUDyCoQ1YuqPuoa9DoQL13PUwKZyUYU7syt5l23Wuokb2ML5
	 8MCK7y/MGpqdXydHmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5iZ-1wRNGP42gn-00UsZN; Tue, 14
 Jul 2026 21:44:57 +0200
Date: Tue, 14 Jul 2026 21:44:56 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.55.0(3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1MS3mz-1wcxpy02cl-00Px95@mail.gmx.net>
X-Provags-ID: V03:K1:e4qWn+8Hjuj3eQsYLi2dvZcrK/EhpcbdeWOu3iKZIpBdoi524rZ
 MFyByEINLtioroyWLo5ctXILWB3PNYlLTAiQLel8+RI3xGBfExjclxMdf2Ti3lXhBCo89lV
 OroaRzdMtEwcjcoFubLZb69d3+AFzf3W61QKTw19JivEItCQDFUIaQWRkgHtnrLdUQSMQ5+
 eZRBU4trs0ax0Ma8hIk+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s1bBJfeRRwA=;LKB4qNpS9FoBIbHGGnSmp+3dKJB
 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

Dear Git users,

I hereby announce that Git for Windows 2.55.0(3) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.55.0(2) (July 2nd 2026):

New Features

  * Comes with Git Credential Manager v2.9.0.

Bug Fixes

  * Fixes heap overflows in the credential helper wincred, see
    GHSA-rxqw-wxqg-g7hw for full details.

Git-2.55.0.3-64-bit.exe | af12577d0fdff74243a5988197aa49b957d5044edc17004f6ddf0768996f1dca
Git-2.55.0.3-arm64.exe | e3d7f5a2214f214f0a93cf0d8915dab236a0e91c7de6de70a7dbde9a61c794db
PortableGit-2.55.0.3-64-bit.7z.exe | ab00566336b5472120f9a52d34f2e79c5406535792acb0548001ffd0bd090e5d
PortableGit-2.55.0.3-arm64.7z.exe | 3bf26b94d9399b16a890776e468334f501742861576cbcdea2d9134643c374bd
MinGit-2.55.0.3-64-bit.zip | f48e2d2dc74a24454adc6d8fd0ac25bf9c2386f19cfb06202b9465aaad4f9f05
MinGit-2.55.0.3-arm64.zip | f7748965d5068e81ad93ca1923650db6742d6e22332b1ae7567a841c59f6bde5
MinGit-2.55.0.3-32-bit.zip | 352380d06caa45e569a3b3967b6d1d6c605d564c29f37ef059b59e657a522ef4
MinGit-2.55.0.3-busybox-64-bit.zip | cbb2ade2bf690b62f0d692ec64733cb26c6b4ea294b0b9752a705446f011b41f
MinGit-2.55.0.3-busybox-32-bit.zip | 88a703c92b8af980d6bbbdeb3b4a531c6d615879ec8c16ddac16cd5d3dbabd49
Git-2.55.0.3-64-bit.tar.bz2 | 4ee071816e424f928f493c4b42e5486d05344a371665c82f1802ebcecaa1d19a
Git-2.55.0.3-arm64.tar.bz2 | ff753aa49b9baeafda33470128ee799b19e48b06736d3c555585bc926dc13b2d

Ciao,
Johannes
