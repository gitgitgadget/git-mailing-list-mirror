Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B6D58AA5
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406065; cv=none; b=PQyatWaTZ/DwcnT7t480G4EIoXO83x13DG/gdfPuB/COs8Hs9ZStPAq/Q2P3cL0YyIQIVce679fxbWk4giPssCYrMszb8wrZsXb5CLk2IJgj6/Sen+r3Qy69e9Jq+qFv8xkaSyKcEJdzoC0/UklLqBi6XYk5WmdwrLZN6cZdZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406065; c=relaxed/simple;
	bh=HIbk7xyeplvPkYbCZna/4gug6HHxbFIP4IY6bhyVOG8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cc6YkSvt6fY72LQE5tjo5OFQ3YNKzPpMrueaoBv9bjUCvnVOmLmlRhgJ0pjf+rQYyscFNu6tqDAg9+iLYXIk1jhAX5aWnpUpTDdfmuB6cbCSCdgF6O0YG8FsqBSm8pYna6g1QHKSilvYviFL5h8lQG6EUCW56kRrrp5eirFb5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=S4aGJMUg; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="S4aGJMUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717406060; x=1718010860;
	i=johannes.schindelin@gmx.de;
	bh=ZkSuQFYEEtGN+fYH4iILkW1S7yYAyXFk1afynOMy2rQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S4aGJMUggRCRq8E0ys9tXiWY7QIeTDTe1iXj3iuVDLgFESmOere796Ln+u6L/kMz
	 tSUm5hNE+4uZbsu29Oros/ZpN47AAfuGoZ+zHjtXW+1qCTxcn9YMxE3jtQwxxNBlP
	 ah8bFeSBIZCH5aEKZ0NWgr69gvNqFwOhvJsPVoJIQQsNLSUvh6jdEWETe17eExwSA
	 dh3tYINtSTkiZXVmy+VwCkmnMVZ6YGn0061v/PhWJM10GhTddxM26YmcZqWymKaMY
	 +ka/SwDX0XVRxreTJjLwz606835uplqs3939Vmd5hIyEM+X3/7lpH21r+tmeAKRWr
	 NHLUpoWHfTmpMWbpvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1024-733.iwjnporn0ryezofxapuyptwyra.bx.internal.cloudapp.net
 ([13.90.174.194]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MLzFr-1rwFll0Ya1-00LCSW; Mon, 03 Jun 2024 11:14:20 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.45.2
Date: Mon,  3 Jun 2024 09:14:18 +0000
Message-ID: <20240603091418.3402-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:/EcrgEPfgPfipUqJQJ7gmCKyMyQreuQjuUXW7Ryy9jN8ckdaPVD
 r+zNYNdMaEZxCYxWi0O/n6O1FbS/yYM+io90B2jXhEOmHya65qPe7q0U6rlZEeydEZYUjnc
 LUOCcmyY128gmj0JiLuClecmzyiILIk51x7fVnjC4dm62ofpEj8mWL1zWHx7xqK4/GftGN2
 xurO1+1uRHha3veV1Ktjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ChcSPDokB4A=;DvvWv5KRGnxhruBid4Y5xn+19N2
 DpxhD4qiCfChQoK25Hi4bI4k+zgibMEpAGkrrbWgfdsb2hQSdEJ4uUOdDA1JioU3UcqI6Forv
 PoTqiy8kqu9aVNFz9O0Kr3fAGOMh5iJlwEChjSBetCw6M46+sS7NtHeCn0qMGD6HrcJI4xtSn
 YLiw7vwrE/UgyMicK0rEg/mj8y4Fvw0dByfG0/SQZkJYlGjibJKkEi9MyZ1SkFjPXEX2/+YiX
 P58BmamUURG+35dkNRCjlySJDLBcdzbBpHzVjUrIyVs1kDH7W4VsWfkCwHMdz9I7InnqvpXQe
 MkZwTIhHPeoxd7Mb+tgbSMUEtPLzE2GITrhffW4bd3Wb7WEsDB72FA76PofSVgwijFvhoSHZ4
 rpaH8fflTufcqcxuP7G3FTmhHKBxMuBLXzCJNFR7iAbaFrxcei4Win6NgMJ04Aes474aK1o7c
 ltVRlkjcsVUgW00K1KBJdPsS6gLfPQf0+kVDLWFtBku7dJWcM0Ss3cag05BALzPM+h/pV15BF
 K+cfIK1qG26paVId05P7FQBBUGfY10lcG6JqE27BSAOP+v5PRp0Yb3SwuyBmJsVtbJ99frQYf
 59PtqK5uzFAJp900QTTpO8xxm5vLdxWgmDHFOR0zrvWjAHlF6d+a9mcwWWxSPFjMce5P09ahX
 OcfvRGJogXTLbqScDoVWhAqdPyLOznMFxoyg7FEaLcW+SM0oIUPfej48sTSCRvVqcMSJMf9RU
 18Pfy230G1y2TrpMGEW/TvCmCaoH0lMnhNLBO+lndWbS3dKfIdBAottMbxsny9hQwSWwa4YKW
 xR5uLi4AFi4menRpvi9ttQJyXZsOYLTnGQGeyiznGwUKA=

Dear Git users,

I hereby announce that Git for Windows 2.45.2 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.45.1 (May 14th 2024)

Git for Windows for Windows v2.45 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.45.2.
  * Comes with Tig v2.5.10.
  * Comes with cURL v8.8.0.

Bug Fixes

  * When Git for Windows v2.44.0 introduced the ability to use native
    Win32 Console ANSI sequence processing, an inadvertent fallout was
    that in this instance, non-ASCII characters were no longer printed
    correctly unless the current code page was set to 65001. This bug
    has been fixed.

Git-2.45.2-64-bit.exe | ce022a6a19e58bbbd4823f51cf798b006b4a683b93b0616a7bb5beeee901da98
Git-2.45.2-32-bit.exe | b8e6db9004c602d9dc375196244484399eb3e33ad71ba3c71455dde4487b4ce6
PortableGit-2.45.2-64-bit.7z.exe | 851a15074dea6b272785b2a2a4697a72970256de2afe7b8e4a9c5e168c27ccdd
PortableGit-2.45.2-32-bit.7z.exe | cfea9e414567d0c59c75ccc5a0e58feeef4dcfc0ea8bfd76efb5e4e22813f5d0
MinGit-2.45.2-64-bit.zip | 7ed2a3ce5bbbf8eea976488de5416894ca3e6a0347cee195a7d768ac146d5290
MinGit-2.45.2-32-bit.zip | 0c0251d02c322d208fb59ba81e7d72db621cd53a3f93b105677dab4dc565199e
MinGit-2.45.2-busybox-64-bit.zip | e841b7aefa8d166fb9dd91afcfb42f163ae6f8d9bd9061da9856084af214a011
MinGit-2.45.2-busybox-32-bit.zip | 9e8ede5629d928f943909f0f3225b27716bdaa95018a3c6cf6276fbc99ee19da
Git-2.45.2-64-bit.tar.bz2 | ef73e007a44a15e8c21fed165faea8707a28703c21c326ac609d706225ba1662
Git-2.45.2-32-bit.tar.bz2 | 451e476b925842546fe47429efcfa91185727da2c2477413556e7827daeab847

Ciao,
Johannes
