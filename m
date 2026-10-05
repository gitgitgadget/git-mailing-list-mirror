Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044783812F0
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237216; cv=none; b=bwbrTtBVpcBXNAzRRY7Q1hKe8+J0xMqwz1ZIdk6GxsKNEWhKA8jVsIMbxQ9ODOJDe8DYiq8wN401s6f1DCvdWg/75+5J1lw8PCV0SDiXjzfH1vRLOnfr2E84Npcle5mSr8hhbY7Pv8pocZXaiNX3D2Vz7hcJUgE+iyG6IymW/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237216; c=relaxed/simple;
	bh=FnpD7LrwVIjKN8QfUd88/1BkrBn6llep4tgFSAJCDRs=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=VQ2QtJYZWFgQsa5rKd66+KR0PRbFSFN+H4F0T8Z8oxMThlZuWd1qqVjswCkuLQmW9JNTuZtHwBWp4WUEUjpoTL41f70hRXvgkv7abGSnyJw1LaYONPP/QArFoyjg0SYczMWK2cEzkcaahsbkdQ9lLZzj88DAkU0YIQSLm+nlVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=svGTnbh/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="svGTnbh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791237212; x=1791842012;
	i=johannes.schindelin@gmx.de;
	bh=1OOZ5gc49geBPCRgifiioKi+p3aPpgt9aT+QdNoQ0vU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=svGTnbh/I/eeJWq9NxWvAQFbgVvQa6cp7okKWp7naSFSX/rPrmurj1YfMLfYOTYp
	 1NhhgPAW46MORTfFsW+CBGMICuyDFDFm2kapR8JPGe16XY7Fj3yCUk/muwf066s0H
	 msSk4BRbBujcXGKgneWg++zz2gbf4OkbN5XIXEihTJKhw40hrYwh3cHLvni+fGaJt
	 h/vVJL9UBhPDgRRGGLyv1Bm2GwnkYm47OJFz7lr6ixnMaWdcpA0nxZMM5Hwnlo3t+
	 u/lDVAQuWqZC9pORlda8evnuHa3hvv8xE9xIGr+6ZfWJJVZFYrz9ZlzzxzqM4flJ0
	 6oazSxO2Bds0oDq5kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1xCkAB3XyG-000Hvk; Mon, 05
 Oct 2026 23:53:31 +0200
Date: Mon, 5 Oct 2026 23:53:30 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.56.0(2)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1MnaoZ-1wmnHS3mrd-00iBKz@mail.gmx.net>
X-Provags-ID: V03:K1:EV5CMYo288nz1ozhT+mT7cChWHz9RSAUT1ksE0lpqgE6NQdAwNb
 rIlksJp/QBprhEkFyEHZgrv41Ek8xAZrHw0cuQc1H+sF3DepPQcjyFPOYOkANiA11XSHAsZ
 kb38hw3zUSSyKEFwxX8VtlybeyfUcwPe54M4ZUi2ecBjc/ukuAIQGLbKX4n4iIVQ2LsUUd0
 Yw88VXGkwUCutLMcakcEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0jkHcxERnWw=;PrWSCqW/N5krsqEpR80Zjv9eSm6
 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
 abAZ

Dear Git users,

I hereby announce that Git for Windows 2.56.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.56.0 (September 28th 2026)

New Features

  * Comes with OpenSSL v3.5.9.
  * To help with fixing stale references to the Git Credential Manager
    after Git for Windows v2.56.0's MINGW64 -> UCRT64 migration, a
    compatibility shim is now installed.

Bug Fixes

  * Suppressing the user-wide Git config via GIT_CONFIG_GLOBAL=NUL was
    broken in v2.56.0 (surprisingly, as a consequence of the MINGW64 ->
    UCRT64 migration), which was fixed.
  * Fixed a bug in Git for Windows, v2.56.0, where the x64 Git
    executables lost their Authenticode signatures by mistake.
  * An assertion was fixed that caused pushes to fail when the server
    requires a client certificate.

Git-2.56.0.2-64-bit.exe | 52188f917b378f00c70ec136bcf090005f30d44fbc4eba0bce759cc6592d60f6
Git-2.56.0.2-arm64.exe | b9ced78ce371577dc966f50ae571909d6731e36d31065d35c8efa21544c58bf0
PortableGit-2.56.0.2-64-bit.7z.exe | 075e158ef8e1f0ab80b347e245405d3eca735c2dc88fd8e032e137d0ca61f61b
PortableGit-2.56.0.2-arm64.7z.exe | 0f21e681bd33e006e0348dfa1a2be6769efd77e3bfdb247320314facde23a46c
MinGit-2.56.0.2-64-bit.zip | da35e72aa21c005a5a0d298cfbae110bc1609a815730ea0dde84b01a1b3cd3be
MinGit-2.56.0.2-arm64.zip | 38b33dc6024026e3315cf88ab2cfea65205bbd7bb3a8e824bd21c8ad4fe609a7
MinGit-2.56.0.2-32-bit.zip | f63de755797c4cec513f7df0c7a6d2f5addc9d5b4e910fda0f502f72e0643366
MinGit-2.56.0.2-busybox-64-bit.zip | a8a9172a6747926648b78a3411f3b94813dd22da8a8ec5dbe61122bc414edd63
MinGit-2.56.0.2-busybox-arm64.zip | 319621dff5c8be06937e7e68ad671782f7c72e91e45cd1da124ddc2bfa99690b
MinGit-2.56.0.2-busybox-32-bit.zip | 65de4d3477b308f3af418b4497331bb5ac66372d8078930f74e36aefed359aa7
Git-2.56.0.2-64-bit.tar.bz2 | 16ca394bdb94b372267d79e1e10b68763674f73e03e0648202a7971a8a730a84
Git-2.56.0.2-arm64.tar.bz2 | 221865b66f4e6ce8f86837acd777c4580e23de8bf526e99dda274c2544cab7a0

Ciao,
Johannes
