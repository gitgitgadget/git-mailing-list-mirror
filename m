Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76635224D6
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000001; cv=none; b=cW24yZ428JFdBub//dgDpyXU3cIrisy+8BrBEMODhnzzm+a4RsEmsGuiV5S/MegARbGBPKweuJTVjJVjB/oWXn+60k4VinMi3MikgHZm5oC8F+hknztnKxFLyKbUaAL3c2XUWlJ0c8L4EOD0F8T0CoF/w8/AD4K++KAdqhyoeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000001; c=relaxed/simple;
	bh=gd2A5GJeBP2nUb0x0ZOJ6Rw2/hicypn7+BD2gW2xgHE=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=OT/haCLr5G184GeaO6vcT2zDUOCt+WaHw6QmNr31rcc5QGCkUqMsPt10YY/DLcuvOhRS8OTrSq7GQ0nh3kMftuo8swhgmZqowxHGI61UQ39b8ohLR6yoIXkbiJSLxkWM++nEFDVcIxRu0hnPjgyCaRRZaxTlPTEkVpS21blL/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=PgiWGzKr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PgiWGzKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782999997; x=1783604797;
	i=johannes.schindelin@gmx.de;
	bh=ggsRzFhyK8OVvVX5vwb3wVe/eq8l10hBdM/eZuh7uUA=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=PgiWGzKrqgiFwkMhhZPQCOv4544pZp0/TnNdINQKhZn7XwBdiKlq2hu5GV6CuTh1
	 H5xoA/zT5zTnrFgNP/l48ibp64I3pprAndQqVuBp6Meje8n4WpVVbli/vzRmhi7lv
	 HLJaf6OVXZNJOlaTzsQgLn4289Dn2LgqI+5JCdSb+NceYoihkh9yJnnTyD7gzb4Af
	 N2plgylLScfSSwXTyqYDlH2jjhCbsCrs78eDYyBYEOvjIjmtNZg1BC9T08bZU1j9g
	 wb71zjUk1mrQubMCRWTEetl4Zzj84g0r62U/JKSSTokHLBjMtLqNFuai9lwW24dv5
	 9FC3Pv7Cl1lTB97I4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1wmxFB13LA-002DQ9; Thu, 02
 Jul 2026 15:46:37 +0200
Date: Thu, 2 Jul 2026 15:46:32 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.55.0(2)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1M5fIW-1wlLDb1F7q-00EtvD@mail.gmx.net>
X-Provags-ID: V03:K1:ww5dUXXxVyCAK+1pIaEODzgHNt23adQKpv0to7YPraTqMYIUv5K
 Mjn42OcSKH5r985PK3XOZZD5mXbnjNstVJeFG//zYrSkGRTBreCi+QCLBb+mAUdaGwq9wa0
 ct3wv81zm5LPT7ZTwuPl7VnBAVf1q7i8mcCWKi5ZTas1o5dPdOnC0DYirbYx1B27UcpVRtT
 UEGOGYi275HROzqwlss5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NbYdy7AuQ08=;1xlqByHfc2SMW1dkPazZtB3GJKX
 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

Dear Git users,

Hot fix release for NTLM authentication issues! Git for Windows 2.55.0(2)
is available!

    https://gitforwindows.org/

(Please note that NTLM support is scheduled to be dropped later this
year.)

Changes since Git for Windows v2.55.0 (June 29th 2026)

Following the MSYS2 project, on which Git for Windows is based, Windows
8.1 support will be dropped after Git for Windows v2.55.

Bug Fixes

  * NTLM opt-in support, which had been prematurely disabled altogether
    (a glimpse into this fall when NTLM will be disabled, no opt-in
    possible) was fixed by temporarily enabling optional NTLM support
    again.

Git-2.55.0.2-64-bit.exe | 74300da8dfe0d844c5449ffb809662f8eeac47916f83730c879c4084890c6c0e
Git-2.55.0.2-arm64.exe | 3df091fc297001ea9592554ee630111ea27b2d33b137859d08c4971abb319a7c
PortableGit-2.55.0.2-64-bit.7z.exe | b20d42da3afa228e9fa6174480de820282667e799440d655e308f700dfa0d0df
PortableGit-2.55.0.2-arm64.7z.exe | 65b913a56a62d7a91fc11a2eecb08422aaa34332d3b2ea39457d2eda02c2f99c
MinGit-2.55.0.2-64-bit.zip | e3ea2944cea4b3fabcd69c7c1669ef69b1b66c05ac7806d81224d0abad2dec31
MinGit-2.55.0.2-arm64.zip | 0b2b81fdce284efd174cbb51b886ccea2fd271679c4b5c21f07d9e03bae51413
MinGit-2.55.0.2-32-bit.zip | 04009f6150c1cec2d6779c51406c8c6a3f0133e57fa91c91eb8a030b93e68ccb
MinGit-2.55.0.2-busybox-64-bit.zip | 760e5a4d2ff5469adfc74f9f46901eee412de48dedaa6ef1785c0cf9a7f065fb
MinGit-2.55.0.2-busybox-32-bit.zip | cc4ce341dae51eafb6c30e0701569338b7cb32c0621328fe43db2047e8a8d821
Git-2.55.0.2-64-bit.tar.bz2 | 5cfd35fadb11ac2f629c16f7be262f3f138cfe3f368331ad1e44f9abb5814882
Git-2.55.0.2-arm64.tar.bz2 | 06c1c6c854628b9ac1081376bccc4a7b6ecd46ee14bb1bca10c57fa680234305

Ciao,
Johannes
