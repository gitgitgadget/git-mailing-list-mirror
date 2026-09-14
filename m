Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF13A5445
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370105; cv=none; b=cYdILErPQJzwTx/CLa2OvliOcnsO3fs+sCRHz0fxMyTSDNMoYemOQrhuCiIcU3DpUH+ObNVdkC5L6j19sbya7ZmpV45xbWI9JQlb/XadXBwIV9Oh0pMdcJcUvaCUDDPZmGzWfk4bSrOZDm5vPpzyYsTSC2fDLTybrrzOu9vAx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370105; c=relaxed/simple;
	bh=J6pJjHz6Wz73EKAiS4ZFC2TuSVbOzcMJ1yH3Yi8xeEY=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=ZwpF/XuRltjRse9BF/b/tZWLsLmp/bZD+fMpIAbgyO6HktpBHkHSZJL2fsXbZv16ULFaWiVLM3b1F6GvbGja6wKZzkYWZgCt/vjkUtESCUFRu/SlBtJqtfaj0zvO+QwOl4F7CSVoMKX4TftOamupc/xpSyJhQ7XabvQj0G6PuEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=a5sRa+7n; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="a5sRa+7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789370101; x=1789974901;
	i=johannes.schindelin@gmx.de;
	bh=Mc/mKtb97Ehie7S/M47p+7RsWfF/BvuKjCt97lKAwmA=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=a5sRa+7ndCT09tqnzJS3n1xiqM0k8N3NULbC3ZMkDrcx7rUnnODfODESeetwQ8CU
	 FKCxY4U0yVVlBq7M86meiozrmBmj2EtKxjAJ+PEjIRj5rFaFb2hLT/bdqBjdUXhUi
	 /UkBylynRIc/mMXloQHomLFCxmnvuFFgOt5VAb62u5Ozq5RxxcDLbHEvspRb35NJF
	 UbzMJdvjs3nslzC/u720JH93heJR9f+tJnVU11ICe9iVmW93TcYpe+8ZS3ea+2+/F
	 5oNw0ZIkzcrDJb0mA4LgdLhDKr7njcTQ/pQn5WVOpJGXpzW4QJBMFyDCYj1Y95vQK
	 mFxK9zUsRZRdywgW/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1wc9CC43qO-00eupl; Mon, 14
 Sep 2026 09:15:01 +0200
Date: Mon, 14 Sep 2026 09:15:01 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.56.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1Md6Mj-1wVqsA07xT-00cRra@mail.gmx.net>
X-Provags-ID: V03:K1:uiNkq0SnmcKUKSWftpmXJhwMW0ZTm82As/DTlUxSTYW4vv0SBtt
 4vLrvBqSgn65Ndf0QiTILKIbKleVY7r/A1BAGNFfsquxF53SZKEmN7IABVSlim9/XDNfHrT
 0r5U8HhoU+fmAgR+dJcHhM1G7eyalryNPJRhXKCPwKJOS5VbdT7jGg0gebYbKNt1/KNLV1d
 UU+4LnWu3UwYrHxoXJdVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DTTwBvO0+ao=;s0KAcIbmsn+A8C1eU8sl2j4l40i
 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
 As51NaqknJHbYSQ9S8SHNU

Dear Git users,

I hereby announce that Git for Windows 2.56.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.56.0-rc0.windows.1

Changes since Git for Windows v2.55.0(5) (August 20th 2026)

Following the MSYS2 project, on which Git for Windows is based, Windows
8.1 support was dropped; In doing so, internal paths changed (/mingw64/
bin/git.exe does not exist anymore, /ucrt64/bin/git.exe takes its role;
if this breaks your setups, consider switching to /cmd/git.exe instead,
which is guaranteed to stay stable).

An issue with the installer for the previous version
(v2.55.0.windows.5) caused the "Use external OpenSSH" option to be
disabled for some users. This caused the bundled version of OpenSSH to
be installed and overwrote any previously-saved choice of external
OpenSSH. If you rely on an external OpenSSH installation, and you
updated to v2.55.0(5), you should consider re-running the latest
installer with "Only show new options" unchecked so that you can
re-enable the external OpenSSH option. The bundled version of OpenSSH
will be uninstalled automatically. If you do not rely on an external
OpenSSH installation, or you did not install v2.55.0(5) specifically,
you can safely ignore this notice.

New Features

  * Comes with Git v2.56.0-rc0.
  * Comes with Git LFS v3.8.0.
  * Comes with cURL v8.22.0.
  * Comes with OpenSSL v3.5.8.

Bug Fixes

  * The installer is now actually a 64-bit one, which fixes the problem
    that the external OpenSSH option was broken in Git for Windows
    v2.55.0(5) (see notice above).
  * It is now finally possible to commit 4GB objects or larger in Git
    for Windows.
  * Fixes a bug where parallel checkouts could abort with "* stack
    smashing detected *: terminated".
  * A bug introduced in Git for Windows v2.55.0(5), which caused vim to
    often open existing files with the first line missing, was fixed.

Git-2.56.0-rc0-64-bit.exe | ca232e593845909100b7f27368b79e737b879c809743d3b1c11bb6b5e1087ed7
Git-2.56.0-rc0-arm64.exe | 4f1b761f0ed7f199958e1c3d74820f698a70ef45b0dd4635cb28237e7317175f
PortableGit-2.56.0-rc0-64-bit.7z.exe | c1e230bbadf9682206ddee9d2e22ccb6141edd0a2e37cbe053903a4456a55ee5
PortableGit-2.56.0-rc0-arm64.7z.exe | 7dd3bdfe691b5df001cf137d2409be21f10acb655847e6a90b40e2e697b935c2
MinGit-2.56.0-rc0-64-bit.zip | 46075a604af4fcd22e1221dd3b880e119734531f66c55cc25fbeabfcafa109c8
MinGit-2.56.0-rc0-arm64.zip | 5dc3c2ab2776f37e4fd8520eed4fb5ff3c9a7d950910119b3ea111aeca587ebb
MinGit-2.56.0-rc0-32-bit.zip | 65788c0a4fe18d2e78960b37e4c9458819bca0ee078c2535c0c5b0937b1c5400
MinGit-2.56.0-rc0-busybox-64-bit.zip | 2d2c5942afcf961140606d13efe99d751fc00e3190c30712e64bae412f081115
MinGit-2.56.0-rc0-busybox-arm64.zip | 76b634035a81f48a8cd08bd5e674a8135bbb9c7a8133f96d669aa0adae8c8e18
MinGit-2.56.0-rc0-busybox-32-bit.zip | 6b879893d67762a0c89c9370c3fbdb56459a477db570b2cf6befce966ef04497
Git-2.56.0-rc0-64-bit.tar.bz2 | 4d07eb3ed5a6499be9a850c1fa1161dd4678ddc2d72d2856252355f2753dbbc8
Git-2.56.0-rc0-arm64.tar.bz2 | 24987a73bd1a6f10e37607c452a6d14c05e22d113ef02879af8eb435cc36b93e

Ciao,
Johannes
