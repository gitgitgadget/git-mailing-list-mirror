Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C1253F11
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385743; cv=none; b=OmOxH2H+KAq35qLyYeFa6UK0U9dMRjZrjuy9aOrn4nWyojtxOiMfzVqGY8gDqFTAoYTtgNpwNsYp0UdO0vom0yeXvYHhUm/3iAfurmcLTsZcAim23ZfRHoNOzKohQmYbDNHQgNZsU64lufvZMbuvmhBSqX2Dsls620Hpg2STlg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385743; c=relaxed/simple;
	bh=L4YElc1jjEszGAVLFR0ZhTQJn5Zuoinw9QBoYTQSd6Q=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=A4Dv51KC1puGqOXzygd020qh5M89ZI/e8LHPCYpunH75h2YKkKuPCKBOAOLgIM9+j5aT/hDIxU0EYaNp/Yft354oxEFm2jkfKmGVWruchncCQvwf4cPDWK6ggofGSBl5/CT5Y+o5huHxof3MkmacbUoFZlFdU6RZwWwkVVqT8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fk3sLo2h; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fk3sLo2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754385739; x=1754990539;
	i=johannes.schindelin@gmx.de;
	bh=MM0Nvo/RIhpdOttUNHwKj/a/cgmqsbSkAOXrd+iS7ME=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=fk3sLo2hMQYjUsfRlsXunxCv+UT4RCPQ11eXVung23BGjy43jsKTLUcyjy58XBj0
	 T4SP0Er4EJdHz3auvs5qSYRC39llpoDvxmRUgkcRVrIn7r1q6jujaw/OeKPhHwWKX
	 m+uivznc9+pr9E9YnHl1DeylTFyl6BZ3qq4RHmbrjUWs+7l4e0TmQJYK+VFyLsBPT
	 ndKU/b7Q9aUAFEaVtm+sbFt0+GEvTCcZTvXLxrZMqRMIT8bsVDh187nITGCAeo85c
	 Pq7ioV1F5wswrD7tSWZQp/dOr1oKK3HXb1vJ3uQeKiWehMt9LCe6DpnDfDN2OZ4E9
	 XSbHUeLaV8wbunpL+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([151.189.132.51]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1v2Osu3Un8-00YnmZ; Tue, 05
 Aug 2025 11:22:18 +0200
Date: Tue, 5 Aug 2025 11:22:17 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.51.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MDywo-1ut9VW3fhk-007xUT@mail.gmx.net>
X-Provags-ID: V03:K1:nvXY6KOeYhpp4TCZB3VqCStibY/+JvjZqtd1EJS11XxxlX8ihDR
 jSzIECjIsMEIJr7AkkbnmPIqzTWc8DR4htQoKUBmpzsqsYwTLLqhVsvKE90CglBWdpEif6T
 KP8+h5pPRhv1yPjcUDv5uUtfNyw8p1tteGpBdL5YbcnU1v9FSjEUAU1v3NAc2WGLVQ9l+EB
 ziS5MC08dKFfy2E5PQDcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YeP8v1wGeCE=;jw6HPW3l0UAQZNqTv4oWSUwGZGH
 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

Dear Git users,

I hereby announce that Git for Windows 2.51.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.51.0-rc0.windows.1

Changes since Git for Windows v2.50.1 (July 8th 2025)

New Features

  * Comes with Git v2.51.0-rc0.
  * The Portable Git installers (which are self-extracting 7-Zip
    archives) are now based off of 7-Zip 25.00
  * Comes with cURL v8.15.0.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.4.

Git-2.51.0-rc0-64-bit.exe | f10884d85577e87e49589e24ad461f1497ae48c03e725d6dd86f0a28a55872d0
Git-2.51.0-rc0-arm64.exe | 1eaefeb121357b443bec2c9fb94f64fb7433e3961ab784278c9325cf09b21b5f
PortableGit-2.51.0-rc0-64-bit.7z.exe | 8ae49916e2139fd6d388704a4ab7f7382480a0c63d12501b93238e6b2916a98f
PortableGit-2.51.0-rc0-arm64.7z.exe | 4431babf9a3786952807a510c01972a5a03540e1a1ab623e9d99c47361244c0b
MinGit-2.51.0-rc0-64-bit.zip | 36a36ca0d24d6ccdb5328888aceeea7127343c2f6faeaa8474f84d1d7a3575fb
MinGit-2.51.0-rc0-arm64.zip | 8f39a5d5bd4b484b18bde06674c6d134440fe2d77306317eb60464ddb55f5971
MinGit-2.51.0-rc0-32-bit.zip | a0651ed960e54e13ff63de20d61bfa50d4b1df2cfd870810c2528b8b662cbc21
MinGit-2.51.0-rc0-busybox-64-bit.zip | 70e55379ca1e31013ac4f5e69589e13764622c220bc0c12d24320d3325ef6cfb
MinGit-2.51.0-rc0-busybox-32-bit.zip | a6b267c3275cd39eb7649897d1931c87f3278fc43d2a8a965b095e1c89d144fc
Git-2.51.0-rc0-64-bit.tar.bz2 | a77c02f8adcecf46a785c2a70557c04184c84bc12fc2480516c26c33fe035290
Git-2.51.0-rc0-arm64.tar.bz2 | c8b12a3aadaa780cce6b0b007474d8cdc62ddc3d05025063e7ae55e142e4b810

Ciao,
Johannes
