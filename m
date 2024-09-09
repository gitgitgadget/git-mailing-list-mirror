Received: from ams.karleo.net (ams.karleo.net [178.62.251.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71BC4C6D
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.251.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892394; cv=none; b=gAMF7sSpZ8zOvyY9d+04y5uyO+w2H0WGKgWtq0hm042SLpJdnfaxmjpCPVJwkS/VC40Ec7V45NNmYMh4USbReegTVlDMxDnUBWLP1887OOnJl4JMlkkvQGhuaADs5RyF91u1IKhLmsAuB9GLmWIEPx60rNV6mUcOPvXJcizr6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892394; c=relaxed/simple;
	bh=B3vTHCfpLC+uA0FYwc55QiZ+xXjmguNlY0tvYmHkd+s=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=sozxujqUMPZK9fg+de2ASjj4FID643fII4ZDUGZbOSQ2ekD4kZ8OWvePuZXOPIqIknKjWrjmKrz5oibHJTenWThrT/Ak2CdxKXMh57xW719lyCT2X1uedBUlz8sUjBaecB1SDKGPrJ541fsN5BupUtygWntYZll4wXCSCYmwIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timm.sh; spf=pass smtp.mailfrom=timm.sh; arc=none smtp.client-ip=178.62.251.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timm.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timm.sh
Received: from smtpclient.apple (unknown [IPv6:2a02:8108:121c:d0e0:ada1:7a23:5bc2:824])
	by ams.karleo.net (Postfix) with ESMTPSA id 288D6403D4
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 14:26:36 +0000 (UTC)
From: Okke Timm <okke@timm.sh>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: [bug?] git diff --cached in a non-git directory
Message-Id: <2886189B-4BB5-4230-B7AF-94F97A13D72F@timm.sh>
Date: Mon, 9 Sep 2024 16:26:20 +0200
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I changed into a non-git directory.
Then I called git with 'git diff --cached', which produced this error:

error: unknown option `cached'
usage: git diff --no-index [<options>] <path> <path>
[...]

What did you expect to happen? (Expected behavior)
A helfpul error message.

What happened instead? (Actual behavior)
An unhelpful error message saying that cached is an unknown option.

What's different between what you expected and what actually happened?
Me being confused why git suddenly forgot that `git diff --cached` is an =
allowed option.

Anything else you want to add:
Please fix and thank you for this great tool!

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.4.0
zlib: 1.2.12
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Mon Jul 29 21:14:21 =
PDT 2024; root:xnu-10063.141.2~1/RELEASE_ARM64_T8103 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

