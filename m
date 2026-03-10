Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701A368970
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177186; cv=none; b=HrAVnJE/NcqrnXwUUU6O7EqPi7QxJg4l39g7d7tMd0k88C2MZn0EYupcxiY4nhSepL9e/rdPJcOJVX3+NtU9hpnMKkQiX1ym6VJwH95ERq0zE+vNK1/b77Nw5OBH6R70j8Amcjbqt/w6NjivSyMV9tO6gR06vXFdjVWJng/kPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177186; c=relaxed/simple;
	bh=VI0emHKC9wKLJaNzMecDyx2cHDEh/7gqnY8fsIUGGsA=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=rRtqTfmkwbRzW8CJimh0v/+xpvfywXda0DEmwBVkQc0pNZcxsefWkLsrTqbfkoTk2ztDoM549xtGyBqdDn+rQtIVyxct/L64DTX3V61PvzKh+wWzXfaAMEgCrQ4tzn7sIPwKnV79erQHqaiaWORpcRR01hzyYO6Ll/BZmoPUsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=J+KLoEWZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="J+KLoEWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773177182; x=1773781982;
	i=johannes.schindelin@gmx.de;
	bh=d/L/zaCV/6IKboTEEzYwba6eFfCtRP6Boihg0Hfp0Mc=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=J+KLoEWZOhFSNkTULZE28S29tElFnV0+eXNO0HJrXhHkodd2mS8eSLxK5t8uhzu9
	 dEXO5eSQCSMRK5o/P3Ntn8lD+x1+hRhI37CntHcnneJk4/44L8WVVNONqqgYs2d2/
	 CEiQG/73Nt2/vhpBnsYFmtqvAMHhVbMCRv2Hs8Ue5y16krKjCET3z3RR9tkgjI7/D
	 Opua+IFcgl2ULNiXMMt9VHTlh5SKhwF5x+M7UxRWBa0v5EfUuQdVN5uU/V20SBjIu
	 1g7pJJIyoUzGp7kbQLyYgozDkUpjusL5K3uSUkt9mD7CNLfZKEnS45IyT2uyqf9MF
	 o1S6hlhiRMApSx+FHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1w35SI3kMN-004GBW; Tue, 10
 Mar 2026 22:13:01 +0100
Date: Tue, 10 Mar 2026 22:13:00 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.53.0(2)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MC34h-1vusG83ucn-00BMuy@mail.gmx.net>
X-Provags-ID: V03:K1:1G6L3bLEvunO8QzQmVabgO7bB7IRKbmQHNYL+444Oy9y3xC5/Ne
 xa9AMlswh1J3OBjOx7HLS7TgYlx6rZkS0z3xYkXVOPUelvEF4ACvyeFNIgAqWcB2OeeDJez
 qkJIyQc1amINLXJ9fQef0GOr1a9WJmtosZpuHerYdy3l+1N+RzdkN9Qe5sx4wPt36hY2KeS
 cu67iMNUzby3w8XoZYppw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LDdGuPwVwSc=;1ecsJ8cYrWQ2hhhYCDV7hw2+bRd
 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

Dear Git users,

I hereby announce that Git for Windows 2.53.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.53.0 (February 2nd 2026):

This is a security fix release, addressing CVE-2025-66413.

  * CVE-2025-66413, Git for Windows: When a user clones a repository
    from an attacker-controlled server, Git may attempt NTLM
    authentication and disclose the user's NTLMv2 hash to the remote
    server. Since NTLM hashing is weak, the captured hash can
    potentially be brute-forced to recover the user's credentials. This
    is addressed by disabling NTLM authentication by default.

Git-2.53.0.2-64-bit.exe | 194362cf24cd0db4b573096108460a34c7f80a20c5f2aa60d06ef817be9f73a1
Git-2.53.0.2-arm64.exe | 07f74afb072a95993d58fbcc3979f7e53ce0cfc10d574f484766c54f73e21d1b
PortableGit-2.53.0.2-64-bit.7z.exe | 5f4f76c7d5036ea3b29fbadedcc510733b3a0ee8da57a36796e2e57a466be964
PortableGit-2.53.0.2-arm64.7z.exe | cd4bb8b1c589051cc5873e900868a31329684ec1a50a55a639bf292c2e2d9580
MinGit-2.53.0.2-64-bit.zip | d4bf83d6a860ccae9af44e508e1e00a39f09db6fa78a9ba5543b94d87ca22a29
MinGit-2.53.0.2-arm64.zip | 842d50edc6bbcf39693e60a8ebb9dabb89b96b932b63aae12d218522b3e497f3
MinGit-2.53.0.2-32-bit.zip | b47bf32db9de7fc9093a9590bc43a15a15b7c2a2070ba84ce0f839021ac2240a
MinGit-2.53.0.2-busybox-64-bit.zip | d105843eb1ce4ee543c9d30b1a028867ec662aac80a5b301058bcaa99966d4f0
MinGit-2.53.0.2-busybox-32-bit.zip | 3bfa7417157c5206433abeb24797ad17f1ca1962ddbaffd867e7860920cbf63e
Git-2.53.0.2-64-bit.tar.bz2 | b17726d9b0041463a9e7b2bb98103cd6a18447d73b65e7b60c43e7d2fb5dea22
Git-2.53.0.2-arm64.tar.bz2 | 91508bfbeb773806a1f7d9a980b04b136938fa9bbc557e1c9023f34bb54749b0

Ciao,
Johannes
