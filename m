Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E83368D70
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471121; cv=none; b=VZYxjsBFtdolquOS5DyrSTvkUHLwTIj456LIZuHtwzqknkhmyAh/WtwDOVSz+97U+5rkfwMoJpGfX/zdUIECO91g8qyy2dJRyJ1FemQggVjiwVwK8Iy7jpKtHQ4aDU0eGBE3fQvlIm2eOUB3h/0qlamleo1seUfws3kGhxp2OTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471121; c=relaxed/simple;
	bh=JmxG6sUTpPVptrLzst+WEDwQR5ZF/HQ8MNHGz1uf8yY=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=TEwORt3RkeFIE3Jpp1YArufNOuRx1uLj0zPukl1f7bCnTuOEg7itUVPsJbA+gYZ7I0bpkmxhwJi4twgte/FqCW+plLTCGQF4mK62h9LFDiwbk1d7M/G4YIZ3wVCJoM7YV7xw/6sT1iaO3XRIbaQTRHNxgZOPek5OvqYYtx9vqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=iDxVgkrt; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="iDxVgkrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786471116; x=1787075916;
	i=johannes.schindelin@gmx.de;
	bh=Lqmosas5zSvZ/Gah73OiySyKq1twPNm/6FmZyizmsgk=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=iDxVgkrttVnSlRdfS0SSh9VsS2q3WV2nTnYtU7K3pGAo3MX9PEZOuKPohULz9HlP
	 XvtZwZeC//qCKl+7PCkQILMzSqWrn8VOT0lmQgLN+s3uxYd1/j2eM3eDUIjsrVoFM
	 I3PWs7WETw0yKk+fj/PXeapzRsmpFvA9DkNyjM/Ya8F01S7iaBxEec5ZInyZy3NPM
	 QFKcsJpTNMAr+zD4lLLkNi1H6vWSI95vkYEx16P84VnP2MMwzJmO0egbcLm2WmXrg
	 la1aSUGGUVZYGRhQVbT+Ua7CNtVw8OCsYKvAe4oTcz5bP/vBHVptyIXYvuOPNznd0
	 bx3TlqppbjbXu8skyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK0R-1xBF6b1SxF-00yCha; Tue, 11
 Aug 2026 19:58:36 +0200
Date: Tue, 11 Aug 2026 19:58:35 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.55.0(4)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1MPog5-1wWyPX1fBD-00Ju4C@mail.gmx.net>
X-Provags-ID: V03:K1:s67JICASUrhDkmZB2kN4czRgi5LOkZe6B+FUMLuBCPMm2UFYy+S
 8GJBPXzAP0XPE9+xj7dTBK7FM2J2z62V2nqWOd0CKt/Bphm3tbKBtQDkxX4j/VlWGcWY9E2
 FqFIESNs7+9Fq+U59n+/klWlW8f23YFDnyfy6u/IOjF8goG1auPHlj9DzcH40ROsXEq/NGP
 gSQkgYKBmStiCzzMPaXjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xqcAIPqUU2I=;2PESMqwvY78FKF9wDLGSXXAG+1u
 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

Dear Git users,

I hereby announce that Git for Windows 2.55.0(4) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.55.0(3) (July 14th 2026):

Following the MSYS2 project, on which Git for Windows is based, Windows
8.1 support will be dropped after Git for Windows v2.55.

This is a security fix release, addressing CVE-2026-62960.

  * CVE-2026-62960, Git for Windows: Attacker-controlled servers may
    advertise bundle URIs that point to network shares, causing Windows
    to transparently perform NTLM authentication and disclose the
    user's NTLMv2 hash. Since NTLM hashing is weak, the captured hash
    can potentially be brute-forced to recover the user's credentials.
    This is addressed by limiting the bundle URIs that git clone
    respects by the same protocol.<name>.allow rules as usual, which
    excludes file:// URIs by default.

Git-2.55.0.4-64-bit.exe | 0cbc0b34a74b3aff3ace0910328549155a770e228331b19cb1498218a120e7ff
Git-2.55.0.4-arm64.exe | 8d358f4d53a5a475570edca3124dc0d4f1a020321594984f58e6b04f86f50ec4
PortableGit-2.55.0.4-64-bit.7z.exe | 016e84230a3767f0c6b3788e79ba0c58a17377086801719d46700fca4f7b36b5
PortableGit-2.55.0.4-arm64.7z.exe | d69d0c6a3c5445553565ef74f1d9e22a9869f57c246111db347dd96c252b4da5
MinGit-2.55.0.4-64-bit.zip | 4e03f94c2ffbf70be337e005cee02661c732dbfc81031a078bda9299b9a7d644
MinGit-2.55.0.4-arm64.zip | 033eb6b927d804558ae479a6ae6c6ed86da42cabc0d424844a3e108c780a58cc
MinGit-2.55.0.4-32-bit.zip | 01bd8fc4cf00df3e278e09a036a003c698b512b68508a1163404ef138ed4ef93
MinGit-2.55.0.4-busybox-64-bit.zip | 255a8d6f43e330817ae1eb2599e153835383cdfb17759c5251318242b03ad3db
MinGit-2.55.0.4-busybox-32-bit.zip | 308e0a24c77fe72d466d2db1e23aea52ee2e4b6dc92f18db04020a9113171ea0
Git-2.55.0.4-64-bit.tar.bz2 | 5c22d52d59bc5d46a47ef5bd3d071723ee014eed219fb6337444acd0dcb8b910
Git-2.55.0.4-arm64.tar.bz2 | 7cc28b4431c9448c310d0093fbba5646517cd702690a9b965014d7df85319ad9

Ciao,
Johannes
