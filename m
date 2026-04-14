Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03A17A2EA
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187897; cv=none; b=osVV8yFvJDQ7I1uIW0Tg19DNKhKD/+w5BgUHQNFBgWGoWhTwvpIOmoGMtPEVmCbCzEjsLSUYBGiSMB+iAFynj2ZKM6OZwLzR517KR8g++JcH+cLByV+eNy9km33ZDP3o9CAMgaeKPLv5XBvMSPygP2frRFBxj1JpFrsC2iS685U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187897; c=relaxed/simple;
	bh=QfkZ4UzgY2QcJoKyoMCEDZXw4jjSs6dYlXyhyKiQaqI=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=pTaTQgNkagh06CgF5m7B23bSapaHMSQe2cA3Ql8Maj3Sowh2rdpxP3gYtGmp7eXFms3bMI4cnqG7q3xQvjT5kDqjjL0hq2KLW3yZPR6lPGurdfL3/llAog/Zi7cz3SyhwvoF/3u/gUCcK8cbTX+n6a4FO1PquWuV9eNcfiVPqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=BAYP4M98; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="BAYP4M98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776187892; x=1776792692;
	i=johannes.schindelin@gmx.de;
	bh=pOe2kSi35Z1m63GZeRL4dfItaOwLcPC2u14JCMkdGV0=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=BAYP4M98kMIyZvzOezK7OqkGdV6ZFJjWP5pTzn8gPdyDZ/3alAIopcsR5sSuhQDx
	 Ur+bBCVm3CG3VzsAYGU/zgO2Cb5LBh7xxRQYLAYJzO2nBIB70k+hTDDPWTZCKhrOz
	 qWTEhaJf+uotiEw5lsVVcX/DSS5cyC95r0eCB7zSaGZPCUVH99jkIZNKFDxUihYGw
	 ZI/+BUQAj2b9pISZnbUtywNrEOwkp2DQqpHcAInblu0ebihA2b9yEMXGeNahnrJSx
	 wuG9NTETmrOh0WrW6HKzFkv+YlmGWxEXcOVz/2Ud4t54UEzPk9OVwgt1h1A52CA8D
	 0ka0JJ/+7EX0kBEtoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatRZ-1vb9w72bT1-00ZV9u; Tue, 14
 Apr 2026 19:31:32 +0200
Date: Tue, 14 Apr 2026 19:31:31 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.53.0(3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1Mz9Un-1vHHb52kbr-00xk70@mail.gmx.net>
X-Provags-ID: V03:K1:fSmkx7JSaBTaQbzE6J4wXczc5nC6Ye6kRQOF+UfNp+Wpo3KB0O0
 MKHd4xOEt+kGoaVwA1SOnWFgZfkbxjhOEFXK4mjb+uticAsWb1tLV9wpV1LjAuGu+9zRqvz
 pKXHJRpThi8hTYcMsKMEQmfvdBKBW1vrRx+4fM/mflodutzyhTsjbdJvu8pQdQwiKJWyPz2
 AwqHFL7Sz8K8EgUsjmfEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AuvkUEPTPuQ=;wIZGtQJN2KO8kKfCch3uxH4hf8k
 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
 52

Dear Git users,

I hereby announce that Git for Windows 2.53.0(3) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.53.0(2) (March 10th 2026):

This is a security fix release, addressing CVE-2026-32631.

  * CVE-2026-32631, Git for Windows: When a user clones a repository
    containing symbolic links pointing to network drives, Git follows
    those symlinks during checkout, causing Windows to transparently
    perform NTLM authentication and disclose the user's NTLMv2 hash to
    an attacker-controlled server. Since NTLM hashing is weak, the
    captured hash can potentially be brute-forced to recover the user's
    credentials. This is addressed by preventing git clone from
    following symbolic links that point to network drives during
    checkout.

Git-2.53.0.3-64-bit.exe | bc88381e192bd5b17a131755d837828d8a570da1ead89cfcde0d45ae38133c0b
Git-2.53.0.3-arm64.exe | 9cc821d1c402f4a5fd397ab0757ed67b7d91d3401ea171131acd745334056a9b
PortableGit-2.53.0.3-64-bit.7z.exe | b365da794b1d2225eb24d5f5e09ef7792cfd5fa26c3a3586210280c80dff3a2a
PortableGit-2.53.0.3-arm64.7z.exe | 0db54010054c01f35501cf69e1e32d3710138ecb934d188bd77093afed24300e
MinGit-2.53.0.3-64-bit.zip | 0d7c85a26e45668b35d0d0aeb763289376cfc039e55e0938a617ed0dfa32e433
MinGit-2.53.0.3-arm64.zip | 4e023ced9acba38d45b63cafadde57a11c754c0b46df8968117cd243f8f58ef4
MinGit-2.53.0.3-32-bit.zip | 2a55bcec4de958570f4e27ae59dfa9f91d98c816113189e2fc6af8afe85ed66a
MinGit-2.53.0.3-busybox-64-bit.zip | cab3a8dfb2bdd7328d79c0f8dbc934d038f755573ab22d4f72bcdd8ff9f86c26
MinGit-2.53.0.3-busybox-32-bit.zip | 98ddcfe902949cfb656e2bc518f1053217d54d88a22317d02c026eda7aeeb984
Git-2.53.0.3-64-bit.tar.bz2 | 1661f02e85a7901ad7920e2a358ee3772ed9066b00d8590bf2d9046ef10aa8b2
Git-2.53.0.3-arm64.tar.bz2 | 4015f05a68bd2bcf3cc6c426e8d44b65d670fbb879225bb7b7c347cfc3a2758a

Ciao,
Johannes
