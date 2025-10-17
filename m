Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F3229B1F
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708778; cv=none; b=NynYrvZph0M/P8yQ2Y0ubgzdELKU91YR+dSlBIOGVkOvPAK45Jm17NxN7QM+VDDtcUWh/mvsh/roSbzna7827qbw/7zcif4eD1ynJsXN0nL6kUQCg6KHQeKciVzqWAdSpi2y5S2ZTjJ4bSA8mvQempvlRf3zmC1OTEd2pXPUAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708778; c=relaxed/simple;
	bh=pHOa/v+/raErHZ50Msa9u2zI7+zlc1JGLhYkqiNSt3o=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=DrSQ3owt6BvpaOgZT/k8Om3nharjav+/TABmmqdTCAQHvdC6dH44x46XHgOGOzJDn16fWigqQ7dFSyQ+XFAWxlGK+raMDxjuHEq5yx1TZUa4atjaMrwrN7nUWI0AJGP1mejzhntdgBRd5X1kk5WCwK+t9X0YhPZyZYMTftnXiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=taxJAQMQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="taxJAQMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760708770; x=1761313570;
	i=johannes.schindelin@gmx.de;
	bh=fAyoTIhLUgVz31T9fr2XsF82bZ2/elfEvel2T6aTtpQ=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=taxJAQMQLjZoT3sFYtBRWjMHBw2m0ifk0LWTge1pobUZRxEZu1FRm6xHs3sbzgd8
	 SbbqwIcRbKCUO29+6RsrvgBUQlC4cvGX4L9lwb57Rq73BWOmZ9vtWrlZl/0ZI1dgN
	 HwefGnJL9pqnoyXhN1klXKbbF504B+6hDhvn6EINg1mmyF7iMDyf3fjCpTDDmBeGV
	 RvVGX6X5kotIQU6r6i6M0QhEbXNGizuT4QYv9uVivJyyUP1L/3jMF8mbYD6WaQPf+
	 FcuxwaWqrh/Ri9NXm3ryY+8tvY/kpDL18uRDVKpzIqnjwJRwwoERjOXvbhYFn7qqT
	 QaFWWze2UVNgZvrDiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.131]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1uTqa91Ssl-00ouhE; Fri, 17
 Oct 2025 15:46:10 +0200
Date: Fri, 17 Oct 2025 15:46:08 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.51.1 (security release)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MUGe1-1uj37B1cBf-00VKRU@mail.gmx.net>
X-Provags-ID: V03:K1:05BXtDXZSQ9eX1yXBSrsF+zsIpL4LsCf6BkBKjn+xoqLtrfk9TL
 NZTVMQf212Wx6vXlBq94P7b7aHn7HdkTVSsdlwwdhxTtumnHg6BGGXFWV0zTXDUVR5h976R
 j9udFqJyNlp04isKXRCorAMOPPVZ9I6BVhkmCDQjRBswPl5FTho3uj/Gy0Y6OYNZmShNxs3
 G0o5O80xW3fs0+B9EeWGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cjQakVyXEt0=;L56LgyjEPDybKxrDdhVKHOSrn22
 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
 eB8ug==

Dear Git users,

Apologies for a Friday release, but this is important: Git for Windows v2.51.1
addresses CVE-2025-26625, rated High severity (8.6/10). Please avoid cloning or
pulling repositories before upgrading to this release! You can download it
here:

    https://gitforwindows.org/

Changes since Git for Windows v2.51.0(2) (September 29th 2025)

This is a security release! Git LFS (which is enabled by default in Git
for Windows) fixes CVE-2025-26625 (Severity rated High, 8.6 / 10) in
v3.7.1. Please only clone or pull from repositories you trust until you
upgraded.

Due to persistent maintenance challenges and the community's limited
engagement and usage, git svn support in Git for Windows will be
dropped from the next major Git for Windows release.

Note that git flow is no longer shipped with Git for Windows, after a
version had been distributed that had been languishing for years. Even
the original, years-stale Git Flow project has been archived.

New Features

  * Comes with Git v2.51.1.
  * Comes with Git LFS v3.7.1, addressing CVE-2025-26625.
  * Comes with OpenSSL v3.5.4.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.5.
  * Comes with OpenSSH v10.2.P1.
  * Drops git flow.

Bug Fixes

  * A potential memory corruption in the optional wincred credential
    helper was fixed.

Git-2.51.1-64-bit.exe | b6a0e8094a2564e8f5407f18c1b47f057fe3dd10748c11e5f86478d8cbbf6acd
Git-2.51.1-arm64.exe | 58fc351b55a00db7fb9067d1959ba821a2cad0a46a4d35caf6726bdb36950cd4
PortableGit-2.51.1-64-bit.7z.exe | 2a1108dd87bd9d7fc168f76f0f2d7b77a44ca49f42c7a3a081b9fcbbbb75473b
PortableGit-2.51.1-arm64.7z.exe | 0703b02416ff2dd7940a705fc078d04ebc7093889ecc798be4029ee9c5341e70
MinGit-2.51.1-64-bit.zip | ce0360b2bfcb60472064de698c8a5b73e63067320701fcd51d30a6e33d7967fa
MinGit-2.51.1-arm64.zip | 88a6452370fe1caf758eb3d5a327c6888c0b56b74c906fffcaa5c742d21bac35
MinGit-2.51.1-32-bit.zip | a79f881c11a65fd679fae8d8878070531b9c10cfb6fc900d8b4156a5dc3bb791
MinGit-2.51.1-busybox-64-bit.zip | ba3fadd0d47622345201b35a5a8ff2f7de8de7e0e0b7b2341a2a280425c9887b
MinGit-2.51.1-busybox-32-bit.zip | 5267259f9ef56e07b9183b3fe7584b63f8ccbf2646ebce1909482bf67eafade2
Git-2.51.1-64-bit.tar.bz2 | 19194719544f8b64aae43b8858b121958920be4725f3141e5d09b3c6582f093b
Git-2.51.1-arm64.tar.bz2 | 6950a1c7c006e0fc8aa329a888d177f99f92e38d16107cf10442e97617f5a71b

Ciao,
Johannes
