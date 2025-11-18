Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE01FBCA7
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425987; cv=none; b=qkzmu7jkzG1w+HjIYrDAj43cDvIxLY4ceUru1WPYYktlMq+65oS3hyDxiXIDi4y8XtY4+H5WnXBoKAADYJD5IbiY8fNU2zJFvme8Xa2iInqCFkePRUb0bmM/bzeIlvYhBL5n0lDKpq7I15QEhuqYvkSJI/vUXxb6NHXRr09K4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425987; c=relaxed/simple;
	bh=sl3FV6+bk1iYCFOCz9efqJAlQBMyfLO3HEmhrdiQl9c=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=VXMjQfbSrWzoLEnjdvlo5jQEFBVNMulVFKY5gQsXIXkOcr90ZdOcMMJXCgm9K1N8GSoiyK1b19LXpU8f9WJENqd6Lsx34mp2RKyoRGS/gTA5qejHP31eS08+ilErYVpx/lUcAYhARflpeM80x3uUTkIgWZpHuh3gE3PAQ/Bptp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=VMx8Mvyz; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="VMx8Mvyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763425981; x=1764030781;
	i=johannes.schindelin@gmx.de;
	bh=ekEwICAWQ+7AyFeUaYWNAW/IbQdLZhaCqo7zRxHAEjQ=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=VMx8Mvyz8e7Okob6CPC8So/gk+zGPMkyVGdZ2RJMO7nDY4VqpEJFAP91jcYayyIb
	 Gy9KEnLtdT4dY9sWEMWU+DOvonJRvxxHILp6ywJLWEuz6rUezsBB3O+l3tPoDEi2+
	 NU068XqBl8VmRxUoymmjwtqjFQ1sjEOo4NkezZMbxQomaKHS3Htb9lkWOzojjb9en
	 fLGwI9iJ4u+fMERcQCUK+Iz6Y02hk4jFGIWgRhpN3tXjA2ZVwtBwYu0jqN1lgF+oJ
	 9a1iSjhXuJ1fSNZngW9Msn5lKsA+XY1TQ/2xE2i2GymKkrswfKdKHioIjV+bUnjvs
	 3ZWvnWELMPx6+7jRQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.224]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1vT5ri2WB9-0007qF; Tue, 18
 Nov 2025 01:33:01 +0100
Date: Tue, 18 Nov 2025 01:33:01 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1M4b1y-1vLhLn30H0-00AGCE@mail.gmx.net>
X-Provags-ID: V03:K1:jnZmtp88lakfDfOKeBu+3N5KalH2drCrHoAwhzlm/NISrJkvv3P
 0uVyWRUiAdKxTnwULy57WuJNvSUbgaCaIS8dCVj+FhH6EkIpR+SWsntwbGffQpmRiDpX7sa
 sPY1Mjeeyt46i7iIephMmdGMxVUn/y3kirqdEMNJfr/wOwLgbxcvMPJgtzNALEPHt+itm0I
 WdMpQpUghEAm2CX25GGHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/8YpKVQfq5Y=;+t76XrtHYC/XIYpUQBrKDYT3EjX
 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

Dear Git users,

I hereby announce that Git for Windows 2.52.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.51.2 (October 28th 2025)

As announced in several recent release notes, git svn is no longer
supported by the Git for Windows project.

New Features

  * Comes with Git v2.52.0.
  * Comes with PCRE2 v10.47.
  * Comes with cURL v8.17.0.
  * The Git for Windows installer is now built with version 6.6.0 of
    InnoSetup, giving it a more modern look.

Bug Fixes

  * The command git help git-bash was broken by a change in upstream
    Git v2.49.0, which has been fixed.

Git-2.52.0-64-bit.exe | d8de7a3152266c8bb13577eab850ea1df6dccf8c2aa48be5b4a1c58b7190d62c
Git-2.52.0-arm64.exe | ac77636c9240da04aa9306dd6cb99d0e6283a506d6f4ea01df5ab5630408f24e
PortableGit-2.52.0-64-bit.7z.exe | 1dc4046dcfb138f62aa04a46b5529adc8abed5033b2af29bb60b66872a836cf8
PortableGit-2.52.0-arm64.7z.exe | bdc2884b321152225498fadc97cad68c244e047310ea686e4fe18ad7257e5b72
MinGit-2.52.0-64-bit.zip | f42a561840627747ad48e6ece05a14093292d31f3393a401a7f7c780ee7695c2
MinGit-2.52.0-arm64.zip | fea97618f69b41ecb63953e3c650e9087cac3f9d215925346daebef0c4d6f7f8
MinGit-2.52.0-32-bit.zip | b2c1cfcca23fe2861ac62a78a0a921016a5c72292612b05eff649ec6c39ad2b4
MinGit-2.52.0-busybox-64-bit.zip | d4a9ea8b7a93a73c369f80ea71833664725cbff5a5ef7d07c4c4c847cd418be1
MinGit-2.52.0-busybox-32-bit.zip | 7241af16d73f1df26d3fd0907803bc6cc8c34773e4525295f2be7da8f653aed4
Git-2.52.0-64-bit.tar.bz2 | 4c05716ec90806b29d6392e6190e2277a6687688f889f0039d7ae3ca53ed433f
Git-2.52.0-arm64.tar.bz2 | 89f5ff372cc192dc6fb096439030cb479b397c40bb5db6b6f92aa27b98ea92b7

Ciao,
Johannes
