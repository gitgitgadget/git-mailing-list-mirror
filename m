Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1832C234A
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282870; cv=none; b=Kq0Rx78TxgiyIql1+OSU1C7+gvNiv1PNXhfgofDF+kI1SyHu5xQ3RZxonqrt/hgKc2ID8LsthGHeCAlbPy83El8xpWarqh86GdzPw59yD076tkNGDlbxtgPLf91ccfdoySm5MdAYWAWk2tsB1bmFLaLqaB2xBXYtzNgfsarTMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282870; c=relaxed/simple;
	bh=eg8WvRVnGiXCDzEy6M2liHfRKCcf7fB8mJ7jTmaa8wM=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=bm3BG7/Ptl2IFfSg33bk+2zZlwmvj5eTHJhLa6GoxJ7UUEkq0B1aDr5rVMMHYw8KtLu4S5y1tn9ANJICoktt3/cUnsZsGLVFz3Noj6gLMyg+OYGeCeIjWQLyBMQaXRkarDGWleNWuz1g7pcRKS5gPv3mqzdZeLdxsSunGjuhjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Gyje2oqR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Gyje2oqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762282864; x=1762887664;
	i=johannes.schindelin@gmx.de;
	bh=OB5g+eagTPKhP4VTI1vPEo+3PCIfPGF7LU3DVU3cpuw=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Gyje2oqRAb6i8J8W9VgILRxzlVaGrQUGN+ZZV3zW49QkdGRCfMAT4iUXUjnualsZ
	 FJzdmKVY3oYHGeliCVV22Jep5y4ut8NrE+YcOgItoagfcGRaj1e7EVMn973v7biZV
	 kB0bJGMohT+DbG732H193Gg2oA2Jv8szumdr/ydEbEykNuz5+MfPuqcii3dnjahax
	 MpEkPY74+rJ50INKV71kA2tgjEvw01/3mKlcdf05KO992VeH8j4ZLz2ic/DQ5M3Zz
	 24cpt/NwYh1WUnwCf/Xk+JrGCN856CFdjoYtARywMKo+LcNiz3gKxyOyST5/IkOEC
	 6SY46IL8YW1aNFVLpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.168]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1veVt948IC-00U0f1; Tue, 04
 Nov 2025 20:01:04 +0100
Date: Tue, 4 Nov 2025 20:01:01 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.52.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MAfYm-1vMz2e0c2K-00CTmB@mail.gmx.net>
X-Provags-ID: V03:K1:HmT517vhJYSnVbviwj1rb7e7W+S560xEXxIr2nANF0WaEpdpHFo
 NMmV6HtGcNg9CWzOl9FZSUy6TAUoN7QYnHqk/YbIVKv5XGHS3+JDvofN0LB0sJYm82Jny2M
 OU1gXtChQHf+/FBaJrupVV9NSogsR5AAlOq36IlD9wHdPMleMVrtC7kpFT7mGh9cZHU/EWJ
 pNVSiQ0wpANJGz3TOf2vA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JoiLjjAz48w=;XN0XBja24gqmUzM//Z9+9RLkHSh
 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
 /CHMozS8AO8qUtoHKgR+JwTH30=
Content-Transfer-Encoding: quoted-printable

Dear Git users,

I hereby announce that Git for Windows 2.52.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.52.0-rc0.window=
s.1

Changes since Git for Windows v2.51.2 (October 28th 2025)

As announced in several recent release notes, git svn is no longer
supported by the Git for Windows project.

New Features

  * Comes with Git v2.52.0-rc0.
  *=20
      + Comes with PCRE2 v10.47.

Git-2.52.0-rc0-64-bit.exe | 7a351e41ef77ee47d400647048f53017b052c7d0ee7ee5=
59d9a1126c5e9ee17e
Git-2.52.0-rc0-arm64.exe | 451b8bec6e6768f38c6b5eaa681d3b479c0c901a68a1560=
36d94ae883beeeff9
PortableGit-2.52.0-rc0-64-bit.7z.exe | ac9b255907daa9da8386e76555d2d7e8b52=
59c8541c2006301f19aa9da2a8d9e
PortableGit-2.52.0-rc0-arm64.7z.exe | 1da1452688e993a69aa635d468b50f867677=
f9174a080b98cf3d8d4a47803cb8
MinGit-2.52.0-rc0-64-bit.zip | 6fe1281a7f536317602e1a2c31db74d13e028dd7cc4=
277e634b37831e51a546c
MinGit-2.52.0-rc0-arm64.zip | 51127ee62b193aa1e00cff46349cca681f9f7a2eef0d=
f0b7edc5082372e0d45d
MinGit-2.52.0-rc0-32-bit.zip | 7e1ee4bc49f8082a2ba873c14a39258f049db0566fb=
73bd1dc7ceda81ef391ba
MinGit-2.52.0-rc0-busybox-64-bit.zip | eb19795e76b0d08b5e88b0413cf5ecd6479=
e8bec074efe20701e22e11f688bd9
MinGit-2.52.0-rc0-busybox-32-bit.zip | de6c3b2b5c8dc791345b4a2a792044f1d8a=
8f6038216970188074fc1ae5f9d8e
Git-2.52.0-rc0-64-bit.tar.bz2 | f38cfbdac8af7bcff6803b63acf39b176691921663=
167fc486e17c71379c439e
Git-2.52.0-rc0-arm64.tar.bz2 | 709682df4414b82d38b572d56c6764be0bfe30b1720=
34d74b45b28d96e0da04c

Ciao,
Johannes
