Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F225FA20
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612638; cv=none; b=Jq8UftoDjGG/kEgcHqY4ciBIftpkgxE3OkYQGJYtB51QO68MvOhjrgmmosRe50JzJ59NGer6iV1Xou3kgOTMamCeZ/6oKPLnkCl9mBNZ0B6NhO0fr89b8x0XTXmPnD4SQOlK08RCBvs1Zge8+gw+mGURZay6ovDbePSukjIZygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612638; c=relaxed/simple;
	bh=uLqFuwS5+jLqcXwiy2W6dK6/xXcJDxU55ZYBasgZe9s=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=gAso0OrYipcDVLWFA8aPja23TFRgc+MnxadVUsA/CM4ZU3fyJW3hkEuExXPaySxpqQaE2vHbpuoeJ/qGwYSdm4nRvaRMccXVt4J1ItdKgUb7taXpJw4CSSOGhKqu5HDvGrk9/PX+yf8ezDsGv9D2CrH3BZAK3zmhZmHg7A6hINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=kp7T9lpg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="kp7T9lpg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740612633; x=1741217433;
	i=johannes.schindelin@gmx.de;
	bh=rY/D+OquLC2C2O0NMqlbxdC1+bd61bgjX98uiQabZfE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=kp7T9lpguZ8Zf6Rt2Zpo3l6wCva6Li0NiPpLibnjWwcPjdp4P5dZ7fVnHGbhWBzQ
	 0cs5lMrC3oyCSUH8SvjFerBvOH4VzLzSyi8p+Uzjqt2hC7bIXouTH+g1e5d6xADQn
	 01XC/+PoPOjjhXCJrBIxX4CrXqGNYHYMQvqNJwEINKmVxseMgBkPGtiaQEXHrrDlH
	 qrBzUreLLQVQ8LWto9PtFWyRJEiqG7xkkpaSpFXnwCqLtuFixAStLhP6BrScb6tD3
	 TEBpAaerFWq8rqN+sWsp0Q1qwPaB47G/NMB0u6HBZEaiG+wLI1Y8ck9iQWTplPbPK
	 Yf015K8V42Q+VpNFmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.254]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1t5b7O2EYx-00mAdP; Thu, 27
 Feb 2025 00:30:33 +0100
Date: Thu, 27 Feb 2025 00:30:33 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.49.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1N33ET-1tJMWa2VAL-00yrx3@mail.gmx.net>
X-Provags-ID: V03:K1:cBEufmNjepMZJIcBY2cQzYNv4zkAlsKbbr9xRb0bSIBXa1gTKmi
 LeloBYoauR2SgHOGOU0qTqVtyLw9DARoT042nM34idUViyAppk7mw5YcXpBf/LNUonnrUZA
 dC3NUIacc0aMAveBtXXLs2wL/xHQT6bEJlCdmPyRufhkB3yMoP1Ltf5qninuiOY+A8N2Bjq
 6IfqBBSF/oVNmLjlFQ4fA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jC1WrqysLr8=;Yn5sDPYgxRQPKyDTdzJt+PNYrRP
 ulFaO13PXzurCUqci24Z1OegGH4j441n65xHDgpvdGvKzN0hwwFGYl/GByKfkc584Phu7+54m
 yuZZnV703J3WKnyRb1nReqxHE8lu8mIvFIsyKC/JMSezTxmKFQEpUbALwHrssF2ec3qZgemkx
 w34Y7chylPJ2aDqaQbe1iD4k8CrJyckN2vlko1WxLawwUkiF0hWA752cScos9oZKMraemTsO9
 CJY1DO3kXC3u0IuD9UsbYatxNCtUD/0YRLATqaQJK0QNsUA41BFFZ4ISFrdMTJGIhpfB+Bixj
 GkD1WEVETKZzLkGD9JQPwE7sMZSpWyxsbp47VMMFJd2djKMKk52N10SIXXE1Epiyt7YtkmevP
 zCxmIwYJ/jpXlOtE8++M7Q25qUIJ53jELXGeSFCDrXafp2+Gr+2IDWTwgwG01D3kL+BofiMbm
 XZWFDH+rGSRmMZ1M9R393njfXhEia2Gsm339Nrru+9r2Sj8V18ePzRKla/0Od00Ci0M+4Q6qW
 UgN+fdEu684AIkWGEobC6QhIUC9Yhrs+kzE50nxRvFwCyQpoqPXqJPZosmeDttN8CsXnRwbbX
 cC+Wi26M+9C1ucDwV/inaASkYvClS11+EWI7xNk0WFZgc0c+g2H06MN8F9ju3rVxjPiSgT7hF
 gG902aGi/3ExDAN1rH6vYtFSYrgC25zmc/nVNwkQ6kthfIzB2GaGHKJvifo3YVm4qMAjfWBZ5
 sD9jKxAeRTTbtJZfBODG/m18AwGjqX3bV4PXjtfJIpa3ockv4fFEiz0xEIKmzcUO6E4Ytmq/b
 2oAMGA1dzlvTecgWO/+hKNxcm9shNKQ9K/kkspj6NDvyAlp2tjIJobHSiLFW0nkb5xHIrcT9p
 Qv81WJVagu/Gto6necP1KzkW0w7x9wLZDhZX1P7FDM0b8gkzbKE+XYk4KMHNJ57BkVFsx/o8K
 x9o+OyVBcDK4XTFdIm7QvfDD4gxkfPRGiDB5C+P3EeOJLpeG2iObnZpiXzM8YpDvUFyPxzrJI
 vYSQJK8q+32T+8NWOgBAXsvZcYUOZAQoGt6EcqMh7anq5OzYIzObel4Nf7ksDY7dOACCwu+Lq
 4b4us2l68dPS4Ne/gr6tZ4CBzdymqTzXV3A8Ynf6YBz++6pXvcav+DvRdAc+7kM+O79hnmFFu
 VgOkXphVjC3avLKYgeuw7S1mNNIC+fi0E5ymSi1cT/mBmOZ2TKYzFZ7zVe9uQnUFq5keUyhSa
 lqefOB0FMi50i6zWyls8QvMMlzLCYXJ2K9Re8m7apk0eN/LQ/E5Cb8o1af9qfNlxEp9/fupX+
 EFHW1QOlQh4OR/u2zM4rVBhtgPAOibyFiodxco5qxrqJKSYHFVuQMzl68XCSqv0I9U1qYWNLh
 kW0R0o5Qjm+nVP8m2ekjzCdR/JIKnUEKeGmkrOCvFsnydzKphJIzQNEcHzU5137FC/sho3aR1
 91sjru8kAdC2fN8vKiPQn5617fH0qvgJMtwHvfFV3jhwxEBnJ

Dear Git users,

I hereby announce that Git for Windows 2.49.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.49.0-rc0.windows.1

Changes since Git for Windows v2.48.1 (February 13th 2025)

Due to persistent maintenance challenges and the community's limited
engagement and usage, git svn support in Git for Windows will be phased
out over the next few months.

Git for Windows v2.48.1 was the last version to ship with the i686
("32-bit") variant of the installer, portable Git and archive. Only
32-bit MinGit will be built for future versions, until April 2029.

New Features

  * Comes with Git v2.49.0-rc0.
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

Git-2.49.0-rc0-64-bit.exe | 34c6210d4366e4a9134a614539efb4b567dbacb14f8593171f5343a08c455c5b
Git-2.49.0-rc0-arm64.exe | 68b9e2b955bc662976f24b83cb8bd92e704487c3a95c2f4b729b83480225a3c8
PortableGit-2.49.0-rc0-64-bit.7z.exe | 3fb9bc5317a8df797e87e07f3f6ff107c31681ad258269f8bd3bb08a75e1c63d
PortableGit-2.49.0-rc0-arm64.7z.exe | 4b286b58954aa57ce11cf0228c674fd74b79ddbd75fd416cb6c172591d845444
MinGit-2.49.0-rc0-64-bit.zip | 5748562cda2c68530e1ecb56d45811ce944671c0828c597c2589347757bc3018
MinGit-2.49.0-rc0-arm64.zip | a4b437d77bfc832a952271dab564724c7ba834ce4c8971f055451909c62a45d7
MinGit-2.49.0-rc0-32-bit.zip | 2ded30540bc852c21dc46ef9ef3214d89f6f7cba66372b9e57f14f543a5f97b8
MinGit-2.49.0-rc0-busybox-64-bit.zip | 3e2c82c648a29cca1a82abff2f93354aaad1162aa7988fd49c497246cc9abe66
MinGit-2.49.0-rc0-busybox-32-bit.zip | 6890dfbe5254217f238efe2fc2e4b67144330a7f230e2f7e90af1dc08483e49c
Git-2.49.0-rc0-64-bit.tar.bz2 | 78852ed65b05b3867db9979548430209540fdea1e88a5786a35e76f5a53bc837
Git-2.49.0-rc0-arm64.tar.bz2 | 6be844bfdbe833888d640cb73b2dc9b8de231dd3c66949b98f9487f2a38aabc8

Ciao,
Johannes
