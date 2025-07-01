Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59350239E7F
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371337; cv=none; b=tlwbNaKj8xDwsmtx9Kqzf3nzlscBqDslwjlEmEfndP7jYQ/MrYgWLF6sEQ9CcB02tMcnw/mM8s4BpN5IvQO7o5DVsQl/sGFJS1KbReZKJTrkkcIDh+CQ0EYnPuqc4kZcJYgfGuyDvy7jy6S8pSxzQoOqgXTYhrrUHO4vAZTvMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371337; c=relaxed/simple;
	bh=ouP1d3cGxdhjxv2bGPFfi9gQpknYznQE1mF990itQqI=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=WthLezI8eBNd/odoSOiGuNCqJ3DYLmUTQFYaUfLldwE4eNVukoCGcEUWWQRcofoATTYK31+S46q1Yvqgw/s2wX3mdVcpT9Qfc5ZLkexEbjzRFewLvLhBtUc9ar/FgcARwaAxx1inP80jCL6wiPGrjMW8cd6jL+0dgmcTiOGXG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=k2RsBC1F; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="k2RsBC1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751371330; x=1751976130;
	i=johannes.schindelin@gmx.de;
	bh=+dH28FxfgwKKEgyZ0RNh8hMFu1unsi0pq4cqglQKSlA=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=k2RsBC1F895t7ScmVlOmdfimDM1lj/AtXnFeT0YvN1Giqa8J1rbNFPN1o4R6bQ8v
	 O6DqgR8W4tkyrevAip1mbArnX87GIdfcZ+LEL2I98S9i9rhWyR2b9oVvKXAkPm3rn
	 wtizHJM+miBM4AQlqH5d9/nFb9TdhSMYp16Ofz8JGoKxS5sFWPXMs6XoPl9C4bBt5
	 iY+FUOjMxIDpZzfeOqQjrIwRibglSvVvBzwE94Y0HcUHMyvVuzx56c4vayFhyLOVT
	 swoyPHXRL1RNC21zpIXU+SVElyCI2zN8RS6zDc+XevwluSX8kB3qs5sen02Gd2XDp
	 UwprJxKQrTIptYcT3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFvp-1uOdD50VZl-004D0E; Tue, 01
 Jul 2025 14:02:10 +0200
Date: Tue, 1 Jul 2025 14:02:08 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.50.0(2)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1My32F-1uuqTd0j0h-015Z5k@mail.gmx.net>
X-Provags-ID: V03:K1:b8wp3QEdYJg8vAmt4zQlOEYVXlzgw0ATRYevCFIlkcTknrTuMQv
 aPEddJQwQjVVD39ykJgPHPxAjmmGz/jEGfGAV+G5/gTuBFzaTx9kqOXyA2NK+eNm8U0AKli
 WdACfSTJOuHY6DiHr7gTBXaBUQtOucmHswAjEZ0/HDcu77nlVyD9xZQL5MNGgS6GuceUCmq
 ehCLuKZ0lttAhaubQj+JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OrG4w7RlNzE=;vP0I6G8VzwcdW4OmVJ+0i69lwQR
 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
 P08sgWj2RXp9+GH4Xoog==

Dear Git users,

I hereby announce that Git for Windows 2.50.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.50.0 (June 16th 2025)

New Features

  * Comes with Git LFS v3.7.0.

Bug Fixes

  * Cloning large repositories via SSH frequently hung with Git for
    Windows v2.50.0, which was fixed.
  * In Git for Windows v2.50.0, operations using the POSIX emulation
    layer (cloning via SSH, generating the Bash prompt) cannot be
    interrupted by Ctrl+C, which has been fixed.
  * Git for Windows v2.50.0 is unable to initialize Git repositories on
    Windows Server 2016, which has been fixed.

Git-2.50.0.2-64-bit.exe | a22b0ddaaa6c698be63f8396b5e595c72a4ab2237bb8863c935752c02c1824b3
Git-2.50.0.2-arm64.exe | 4d6306fa8f346615271acef9a6bbd9072485111e7c9717ee993bf72a29ab7cd1
PortableGit-2.50.0.2-64-bit.7z.exe | de8e309e780201d74b09e4b248209fd5544c45acbb5a4d131562739460aeeb46
PortableGit-2.50.0.2-arm64.7z.exe | ae8331ea65e1f7677b6ce140edb0f5501aa108abbd8bab943cd995c4ddf1218e
MinGit-2.50.0.2-64-bit.zip | 6d28c7e9f9c219a16c078c94a80492dd10fa309fbd17a67b2230736fdfb263b9
MinGit-2.50.0.2-arm64.zip | c0552ba67549d2cc0cb847a89cd0c45b884086c06c7e1ec8dc190931e0e48adc
MinGit-2.50.0.2-32-bit.zip | 963ad1352e606f20a719ce1319432aaa23b18acd42cdc0f88f73694c29554a35
MinGit-2.50.0.2-busybox-64-bit.zip | dddb446697623597ee84a7c544310f76cfa9e07bc34f951b8d3390a50d8e3d8b
MinGit-2.50.0.2-busybox-32-bit.zip | f16162dc7c45d438a04f3969b20545699623d89acf92a6a32a6ff9353a9e32a8
Git-2.50.0.2-64-bit.tar.bz2 | 295dfbf88b741aff20b3f50580f8601fe5e3cffa67f48ea21892789274a902eb
Git-2.50.0.2-arm64.tar.bz2 | 7420699c4caf71ef79fd8edae7a0b5cacc708b5ba7c4200ec33963afb0365efa

Ciao,
Johannes
