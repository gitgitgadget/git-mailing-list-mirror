Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1F311958
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595886; cv=none; b=n0kogR4EefPg6C2qjHgAlIEE1MlMaTO3gtPbWNmEmMC74IEU//QcCuTBBe0j2ve1Zyj0n4rvZFg0xJ/1VuChVHAxE3TMygEjZkX5fxs8sd2nJsrkWwmn19yVJcGnpe6kDjguQKjCRbDLtpi3hbMe4yeG4Y9OwpBknOnHvM/Pa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595886; c=relaxed/simple;
	bh=cXBbx7n71pzsT1Bth31m9yqa0HDlYoEeCnZBBkgxwow=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=Vp8xw0GnEzjx9QVuwZt8XbVDBztANnxSfWDxVu2GQJcnNW6rjxPrzA70ua+lRQVUIz551Ff3a+KOG/fVGy6C8GiMmMmcbaiwlOs6ZwXHf5ZNuQ3hot2DDlRLDuBnw8/S4l36IPDEJAoywiFAL7VtjOaxRJnfAZWINlPHkQ6mAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=LHkY2Gds; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="LHkY2Gds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755595881; x=1756200681;
	i=johannes.schindelin@gmx.de;
	bh=9cFITdR8p86ghsXIBoqnXEWi6bcT4a2RbwUmHB93D/8=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=LHkY2GdsQKDxtX89sbuGKR+7YiGLk5A7qzSqzLhXM1J+w0CuuVTuLNrPTp2c4U+x
	 1/RqfJsnyIBrRRPPmix8CelkoHaGXcVpTFMteJG0kRNt/zUCXWDoPjlL//tatGvS/
	 AsaDgZx6L68MzUmiDrNjGlQ7gWrhJn3SM/dW0H/waO0QD0ODfkE4EhOvrLrEil0TB
	 x8+Rlw0vjCC3lra5BmNLIYRwsnzlhoedDw1MYA0ja74SyAVq2BqjevA1B2Z2pjw/1
	 JxZa90X4NtGKMxBfGn2IHFT9Avb3ypCB3Z1Mn5/efeWcALdXDW2l58JPq/YJ/pUAX
	 FigzKRT+ASpMZXXYoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.116]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5GDv-1uNB2y1obl-010CM5; Tue, 19
 Aug 2025 11:31:21 +0200
Date: Tue, 19 Aug 2025 11:31:20 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MpDNl-1uCpCY1xSJ-00oiAt@mail.gmx.net>
X-Provags-ID: V03:K1:HQlGNEVcO/FOsScODeqn4+LIKp1Ljxd+ZreAHkgM1nFRqo1K9R9
 d2L0MA0MttzuHCdIHd/1Y+p6d/3bpvFk7B/VljuQGUZtXKy1AhnUAbUAicR+jvsCI9lPZaI
 5dI0o8wE8V2bHKeteZ4XKBZfpH9/yJ74BnA7xDnNNc6Lx5fL0sDJHZwRYmW7AmiMpLmUhDn
 3v2vshzibGtYHRfW051GA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rqvScuGyVdM=;QR856itCsPhcBz7UcxE3P5tWuJo
 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

Dear Git users,

I hereby announce that Git for Windows 2.51.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.50.1 (July 8th 2025)

New Features

  * Comes with Git v2.51.0.
  * The Portable Git installers (which are self-extracting 7-Zip
    archives) are now based off of 7-Zip 25.01
  * Comes with cURL v8.15.0.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.4.
  * Comes with MinTTY v3.7.9.

Git-2.51.0-64-bit.exe | 843037416371600a7f289be8fe2b2224afe1c1bb0736bbab7b3ff393e6a7aaf2
Git-2.51.0-arm64.exe | 739673a52a2ea5a3ac23ef1a74985647fd21a758e5e177fed2d995dd897a1600
PortableGit-2.51.0-64-bit.7z.exe | a09b275d51ed3e829128e04cf4168fb54896cf6234bb30fecb8dc96a2bd321fa
PortableGit-2.51.0-arm64.7z.exe | 0aacd4edf0c1715334a18725a947584652e1b34bddab63ac3f4a82c9f7c78e38
MinGit-2.51.0-64-bit.zip | c2c955a21fa99889d83f485f24fa5d9a38fffc2d509d4022385510e11c26b250
MinGit-2.51.0-arm64.zip | b21755ccd10f71a37ec341ca9ac450cebee71bb1e70c0d88d90ddd6e5b16dfa4
MinGit-2.51.0-32-bit.zip | 5a8f1cace31a817fa9fa3d18146e8b40a28fd365d48958976df93ae6f0bae077
MinGit-2.51.0-busybox-64-bit.zip | 6b71de89d321310d1cc233565a10b06cabc65582e1c37bae47548c1fa323c878
MinGit-2.51.0-busybox-32-bit.zip | 050fe76ece1b7762cd556bdbe242a979d5d769c2072db45e1cc888061552779c
Git-2.51.0-64-bit.tar.bz2 | 151bddf70e1115631e62bb05535b5e6726b3813e1f363953ad6b4e6697d96933
Git-2.51.0-arm64.tar.bz2 | 5c3bc6ca50ef6a7686832d2549e6e1b3b1060cf18322a2bbe064d4aec2f33904

Ciao,
Johannes
