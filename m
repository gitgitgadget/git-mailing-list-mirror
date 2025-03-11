Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D722F163
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690537; cv=none; b=dUtVu/z88RXRVgRiFM0ymbmtB/NxoaNTXntfgj5NHwsPLYa67hcjO54nCF4Wrp2CumiyWa/PKTX6cKnHwJ7N2AqRC34j6iabCICDAyM8oFffljd49QrvTeWN/884R6Nx2sz0bQ5qpSBlhHqqS8kPNqz7V94gfGJ9Nzoz0MIXyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690537; c=relaxed/simple;
	bh=84prbt2GBNoNUlXcw0bw3EudsDXnrcDDn1WDyT2k0F8=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=KN3u4+kqQhxSEwqChxRUlAlDepFcK/R3f9ecaTtSh0PmVvAAYz6VaiKvGDcb2fhDGCoqvK7Z18DJazCbJdi6yDD19V5hEJBYBCDlEE8hZ+6FdHo40OwsPFY95d+XCrL447c1pM3KxpA8RoXxbuXWpHMl1VXgqAHrlOR3SbH4NJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=OzUt7nrL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="OzUt7nrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741690532; x=1742295332;
	i=johannes.schindelin@gmx.de;
	bh=rYe6s4Ba+PUpzX7HBTxbCWXkKRU56TqbB5zv/h5dEpE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=OzUt7nrLlvCUHvR6LIDDjpajoR/0hjhA8dIpZYqO0gpNXRqQY8jNDsTzwJ3N/kJU
	 LQ8yoOlgAON174WubBDbePxyZTIzMzodsg4m7sHj5LYDCs+4dtIWcATE/Mlej1+gB
	 SuSLYAOX1VCQO+kvrisd+cX41mmqZii7AB36kmpS3+HQUoDLbXJsdeUMuyfbFtsga
	 dHkM7GQMA9i+4NAmmYJfLSoINA5jxtJAyv86shjlWrja6XAJY499G96knqk862slY
	 hsom2+5HZI7EP0KfEkoE3EVdmTG5yOGOqdae/6AXgxQHu3A6ri1PBtH0CvL5jvfd3
	 5IGkBwCKqtprkhgGcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.101]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1tHVfD21qF-00l4yc; Tue, 11
 Mar 2025 11:55:32 +0100
Date: Tue, 11 Mar 2025 11:55:32 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.49.0-rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1Mzyyk-1syahO2FB0-011NRT@mail.gmx.net>
X-Provags-ID: V03:K1:1O4ixlWmkqOgc2r5ikwHUn1aC/rX+L4SoeB+oxfxtfaEKDHPCY+
 C9v42xezWgRVY21Y+ljZyCRDgYGLKIoZmgFX6lx8RjQFyqbXDM+4PTyBDVVhqv4ETvlQy3f
 e+TDpOn7/cEWy90fWqsGU2hO2WyJGAD71cwKa0y7ehDQSKorK/RqKB732UbEXXh1MaNv00X
 4jtrxlxX4LaDpxr9Qvg0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PMlMFxqniZE=;4SEnglmIHomBkpgfWKqJt3jGPLC
 iws/nD6q+ckvKdCxSzHCdEAC8AoT7CwLflPRV6bXjRpAufkQ0Zh217VhQNGm9nS2kW6mLV3Ad
 osWyRtWhId50LjGcb8eczzkuTqmjiwLr1ZbkGSNZQpNiGnK5/UBUiepe6EY9aeHxl+7N4ciAY
 H6pu+uc6zaj9s2tM6EDTyUZx9dijCtWmL0D2RvQRBLeIYd6WdFblEea93FRqkyHM9Pg46qtIq
 e3nQ1yecl3ip7WnZri90j1/bf47AtCPZ5FIRIPeYrD0REBciZBbj5lquenhnqd2dh1IFv1Wtg
 KWTLEtoLHs1IkSXB944j7RH7DtbpSllWpEQQDz/NvLtYRZMHuyoD35FfjYZrr54GInBVJzyZa
 IyewZCox+jHgVv0fVLvtCDMAfof89aSDETK5i6YODL+cW1Oo+ziW2MAokWixyaYQmHHMvGeAz
 1UYseq5Jyw23qo5Qbb0QiImDH2fXdJZuvVUeqraIwCHUqqThJlMcRYiueWlU9U2dR2gDkNQI7
 ZUuRGN6a/V2zW5bf6OKNApixXm4bdXpOrwVWYIVPuuB3LSDfo9xJSU0xjcx80Fvr9gnl7k68K
 gkUb3xH/tCJ0JaxXMQnAC1/ZxX9XWUfZ/c/PPtLEw6dHXw50vk7Qz1qY9k/3V64P5T8bUZVQG
 u/K0OrYyuhjfMSL6GfgBI2lE0Q57VXiyOi+t1uxjJeVZGGIDwnhO+ne1FDdY84M1JuHUIkpHT
 G84v5mmmI3wmq2o60YyYRTdLFef9HKcBp854Xwv3f4DUXIrqPGUOaMWKK9/EEVg04N67UY9nh
 fM4eTknd17C4UwT7EcnslYe7dEn3AyqxZlRBBr3kJRTftMPVFygZPrneZ5gaNAM3W1flXW2gC
 Q+dxX8e9ytHX2TTsffz80EvouEy0dUkBWp3SZj2J/wBVv1sZSzsWVEr5vBv7BHy3n6hbkHQIG
 i/qV+H3y6q7tHxDm+/RO3gahRoD1XGQGc8HQkzwB8MZAE2ws1pOpq2Xp0IJYWSuEr+HuY7iht
 g7nLKWnd32i+5gLjpljJbXEEdsauaZnZexl33BkpYCjeA4/bi8f+nvrucjBy26WYLxAVuTpVJ
 ziwL2Rlhy1P5ZoyhG40StDscvHEUfdTwUG/RmgUBbowrEEU3+8ir4vYet5aN/ETF9NIuEjcNa
 bTk1GJOzy8i3CgPGzmU8LObiJxkf5UE9ySpeVq2VT4KzRXOmYkn44W7OS5RKg4+mLCUrXEeKk
 8724tvE6bDadMVa9Ff+MVQC8t7mMmuQGLOUhSQh1wvLeAI7N4irjA+oH91zL7gsY/rQ4bQGyo
 k0vOd35Ljw14vcf0dLwOQrDuZkvTGsE2Q4zeyWjw8tECHGPREDoLZEtx59PPpJZuQOZNZFsqj
 NZNnSriEP7c0ceB+6Ofmxa7PkLhN8zO0hOmQqOdiTsor7n2R1LcHRhE8CPsLsGKlsA9ylb/Yr
 JFuQhd9vOyvD/GfQQOrNCBQJhEY1R5Is7KfXLeyAfFdOhjcC6

Dear Git users,

I hereby announce that Git for Windows 2.49.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.49.0-rc2.windows.1

Changes since Git for Windows v2.48.1 (February 13th 2025)

Due to persistent maintenance challenges and the community's limited
engagement and usage, git svn support in Git for Windows will be phased
out over the next few months.

Git for Windows v2.48.1 was the last version to ship with the i686
("32-bit") variant of the installer, portable Git and archive. Only
32-bit MinGit will be built for future versions, until April 2029.

New Features

  * Comes with Git v2.49.0-rc2.
  * Comes with OpenSSH v9.9.P2.
  * Comes with PCRE2 v10.45.
  * The previously-experimental --full-name-hash option has been
    accepted into upstream Git as --name-hash-version=2 and is no
    longer experimental.
  * The git backfill command has been accepted into upstream Git; Its
    --batch-size=<n> option has been renamed to --min-batch-size=<n>,
    though.

Bug Fixes

  * A change in upstream Git v2.48.0 broke renaming symlinks, which was
    fixed.
  * On a recent Insider Windows version, users experienced the message:
    "Cygwin WARNING: Couldn't compute FAST_CWD pointer", which has been
    fixed.
  * A bug has been fixed that, when calling git add -p from VS Code's
    internal terminal, after using the edit command, caused the
    internal terminal got stuck and no further command was accepted.
  * The syntax highlighting of the nano editor was recently disabled in
    Git for Windows by mistake, which was fixed.

Git-2.49.0-rc2-64-bit.exe | ce39f83ed9882365be99b66daa0421a33b0a185f943d79b0aaae7b015082f7fc
Git-2.49.0-rc2-arm64.exe | 32d21ad1a6d8c2ba01ec9f6735076124b50d0f5621c3fbf2530e4dda2b90e3cc
PortableGit-2.49.0-rc2-64-bit.7z.exe | 91211414e062dd31a42572885fbd5b044ba9baae649cd9f439d3628bd43c3988
PortableGit-2.49.0-rc2-arm64.7z.exe | 3435b62b6cc3ecfadcf2bdc31cc9d2b3e63dda91105861d4d20c399358abe9dd
MinGit-2.49.0-rc2-64-bit.zip | 07fe73c3f3b33e7bb41c35041e184d1fee4144340d93bbe7c396ad831f42fd37
MinGit-2.49.0-rc2-arm64.zip | 6845d2d3836c9fb6f6cfc6484a033053e86ff926b94afa214a48cc52a60488cc
MinGit-2.49.0-rc2-32-bit.zip | cdc3fd847f6fe3d00d633ebda50f5e5f51a1c68685aac05b2994ab8a97b61bb3
MinGit-2.49.0-rc2-busybox-64-bit.zip | 10b3f1337436c198b0a853ce26e7922cf0b7921cdf475660ea926d2c2ac20954
MinGit-2.49.0-rc2-busybox-32-bit.zip | d44d54fc735cceec962e7b5ba8ad381219caf6033315f3358b685485ef72e736
Git-2.49.0-rc2-64-bit.tar.bz2 | 61712bde225f646bcf2915e41640070a36f8c17b27b2f68cbe7064f4d63bb0a2
Git-2.49.0-rc2-arm64.tar.bz2 | 78e9696a6b35e572047157f9626baf7572669c517eb1b3f622093825d19828db

Ciao,
Johannes
