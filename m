Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD123496B
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627994; cv=none; b=uP/wxHHaNIuMfa96bTg7Zr+k6OfSlA5138t/RebnyQ8ABctYiIKcTDhsqQOpehRQKKOqSdmsYpieANsvcBIbJv2rz9OiJYEhYuUoxvBPr0MNSU27R4Or88qtu2P6lJr+qYR/GFb43Bn+zwBmk9rfIChg2k6MoCGlCGfVxYpCEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627994; c=relaxed/simple;
	bh=i1W2579ZavZ1x5QRev7GG9R12xz7Q5L/ThPmpawQVkw=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=Nev6yY5rzj7iCaF7op/9oNUp+eJoKYQF+RSBO/bznjE2Au44Co0QJ96DOUKnHOqO7SoxX2lUuMlcLV5qnh1oVO/KocVGtDT+ixcdEVk1qRtsHkkihI/TLhtQpgcfS+PyuFLdaWyKCWvySVq8VRDKsY8VfqNtrJo2EjPiAD3Si2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Z794dV7v; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Z794dV7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749627989; x=1750232789;
	i=johannes.schindelin@gmx.de;
	bh=hXwcjtN6f2ux4kn8sze+kx3zByBXAT056qGaszuTr6w=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=Z794dV7vH64IjBmZcIYFQ/l9auPHhM5LEUAcZab11ROrNupUPFmZgtTVXn1Jpam/
	 zJLRq+SuJesRegGd3NcVcbt8S1eZFRHk2ESlrY783Y7RKKimfXumcVWI3Kk+Wo0Rn
	 f8hnQMbVg05TVwWQe3jAUqY4MMmnrHAdMeN1NkQ9f2JZmM9zv4SidPgk7LN681Hrk
	 vze/SlwpD+yhgEnMfED90d2KEc4ycfEm6EPiTzJQA6gUIamTznDK0LT6Ec3iBXbBk
	 kIVIzn3f+5aT8pIg7GzHP1uJcW03CQOnqS9nzqu5cYMcEgF++GIdh1xu2rKPXgJCu
	 JAkE1SFt/CjV7thExQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.53]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1uppXZ2fHk-012n7B; Wed, 11
 Jun 2025 09:46:29 +0200
Date: Wed, 11 Jun 2025 09:46:28 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.50.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1N2V0H-1up0rS2pDD-010qmE@mail.gmx.net>
X-Provags-ID: V03:K1:4FxQX4za5iN7+9DYbR0jQe3CTC4TE+qw2QVJUgCUqGStRBE1EMR
 QN3xlsw8Hr0cRwdkP+72BRdo666uDmqZzWFCJYvHleegyUqLywVqctBtE//ft9uFTdApvQY
 INV9mcLeEMhOCXR6D7SdZ1lr+sy0ohLEGZP8ADmegopSh2bQi4R8EELM42YPg22K/8L+1ds
 //ikYqEdg2TsMBCH297vg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rguHWEuJLoc=;PxUQbL/6rDp/mbdRxSb4DmDYNpi
 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

Dear Git users,

I hereby announce that Git for Windows 2.50.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.50.0-rc2.windows.1

Changes since Git for Windows v2.49.0 (March 17th 2025)

New Features

  * Comes with Git v2.50.0-rc2.
  * Comes with MinTTY v3.7.8.
  * Comes with OpenSSH v10.0.P1.
  * Comes with cURL v8.14.1.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.6.3.

Bug Fixes

  * On Windows Server 2022, Git v2.48.1 introduced a regression where
    it failed to write files on ReFS drives, which was fixed.
  * Git for Windows 2.48.1 introduced a regression when fetching long
    branches under core.longPaths = true, which was fixed.
  * Git for Windows' installer used a non-writable file for testing
    custom editors, which was fixed.

Git-2.50.0-rc2-64-bit.exe | 47f89b273a0a63c75a492eb27ba7a34a9d8249ea35ff2f68959f4f4bda3d1626
Git-2.50.0-rc2-arm64.exe | 364c369f7f89c4273b2ee0ad62032a6acb377d88bd35a15d4137f896ee7df1c1
PortableGit-2.50.0-rc2-64-bit.7z.exe | e016139dfc0d72d1bc19ede2ece070f5541476db9f7ba39de2e84d72e918e3e8
PortableGit-2.50.0-rc2-arm64.7z.exe | 0e76b92eb2ad4f4a7a2ec72e3228f31e59f0cf47e800436e7c847b37675e1345
MinGit-2.50.0-rc2-64-bit.zip | ce13ebf5585c238aed503e6c673f6023088da83b5474e6d20cefee4c81e08470
MinGit-2.50.0-rc2-arm64.zip | 508b853637c632b7d4c480956a9bce83372fcdd40333848e0c6945c3d14128bd
MinGit-2.50.0-rc2-32-bit.zip | 430b48c34f7fea1808365c7c6631c72f955bfe9b58d53f4cac4ae951ba2debf0
MinGit-2.50.0-rc2-busybox-64-bit.zip | b2694c6ce537384cc7ad5164e9823e7ef2972aec827bfcd1472df27e47c92136
MinGit-2.50.0-rc2-busybox-32-bit.zip | c457b831b91096d2091abc4efe69352d0e3a158eb898f8e173993f7a0348c35e
Git-2.50.0-rc2-64-bit.tar.bz2 | 45a2d1114e10f2c9cdbb398e09bbc16cd32088263331fb2547dd81467911e6f4
Git-2.50.0-rc2-arm64.tar.bz2 | 13fde8e5312d49bd184cb5a956cdb666de8ec004f701d1320781f638f68a0725

Ciao,
Johannes
