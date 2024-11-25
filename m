Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59D14E2E8
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549028; cv=none; b=TEA2uMe+8RrtjvBOLE3xTSAK1UWTkWZ7RU9Wxjk3xv6wWYa+ZhihRhGwjkxdN5kGiAtolOicIVdNcbNCbiFfKRUfIUH0pDZe7qBFOVfGU+t0Ku684OXiF4gXQysqqIsED8OByO3yTtFkXtaoF+kUwNbWP4XjzRX9l+uuI3kkgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549028; c=relaxed/simple;
	bh=TEHe5PjLC/uUXJdHE046axW207V3CSOmKzT8DlWt7o4=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h19HUmmX2KhNA7pGDpKuxLyB5vHv+OjqiKXcUTx1GKCWC38FmmvVplbmBicd7tcV6g1WIAl7nX8QN8sa+uEmPiQ4mOUr+ZKu43WZVIXuA9fUxsNnjq6S1ZTRlOk0PlVpb39Fd/xni12S1CIcqXPMKs089SzWElqbUTm8uzSU5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ihGS5wwV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ihGS5wwV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732549023; x=1733153823;
	i=johannes.schindelin@gmx.de;
	bh=cRAAInSnOnh9mFcnFRn7T95sW0k0nNyzNg9IqmIXHIU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ihGS5wwVOoyDdJo6sA0udKxJLsL04Bq6pM8TvZbGbt2/X5K5dAI9MsmgCh/BntUL
	 MyimL4EflkiiZvGDxl2+KD7slR3lg+uXuU8KlH0LZRn0XbIqm9MrmG3B3IF1mZixj
	 8GZrKH3DyeZcjsu2/N5lINWCpIvuHFVDu+rAx9v/F2BqTy59fJm9H/Zy60VEpFOgq
	 h2/O8U6ffrlt59hTCrZAZGtufKH6+4iUXqpvfrL86AQ+NsIWqujvT1L22EmYY+Xif
	 hs4qx+QZuR4iIyuTas2+7dgNlU6/ChnEghB5bUucyCxapvVcTvIdBYB/pCqInyski
	 sQmnT0iRgOCQLWsiMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.125]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1tgEgQ0yjB-010v9K; Mon, 25
 Nov 2024 16:37:03 +0100
Date: Mon, 25 Nov 2024 16:37:02 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git-for-windows@googlegroups.com, git@vger.kernel.org, 
    git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.47.1
In-Reply-To: <20241125150158.3347-1-johannes.schindelin@gmx.de>
Message-ID: <e713d3c1-c1cf-abe5-ca24-d63a5e78d6a9@gmx.de>
References: <20241125150158.3347-1-johannes.schindelin@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L6TvLa9G/gOygNlv4ggDejZipRETAiaUNEPH5IGhHC5MI2Bcz0Z
 uYTV8HH6IPo10kYOfIK00srLe0T4SJl5b2+xvMvzzhqLxniq9ZlC1q9CGtZVb/WqasLhQOV
 eLNxRdxacbkWA8dQHnOIMrXquew1yPO099zHKAy9WAE8YuWfx5h3KOjzbLyjaChk1J3q+L0
 jJzGOe3Db2hYj1eSWSRpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j6DtXtWMcu4=;hiWA490e+PYdCKUeaAdc5sE4m3N
 MfQwcOl2rUZpAgBrCh1wo+8fnkYLRpOCo+9gnrSXf0R3xbbb6ll67Xa4vqkCzd3kBiVEO3f1/
 vRfOqG7E8xECjyD4WfGC2wztlPELQTP6AAK2s4ByWIBDiy4ub4xrc/zzVkv59w1ZoBNFLlLRQ
 cQGeOSZoyMzep6DGCKiPkUoLSKp6NeYjMLpmFrTzDlyUKHXePmLK4EdROy2gOToESSrOOP9Mg
 xJdil+Hdk70oXQDqFsuu5GQpn3o7BroDxmxULiijNQNAfPjHFfOjE2DXZMpOPDkuUMccgYAqU
 Mwx0KwZmOL9ExkVBZiIo8nYqzoEyiSY3RQBqNfw05ThCagpoGRoDj72vqq4n30NyBy0PBz2n9
 59Fu7h8L9m/wAN/cNsZdqZkUJoC1FY6V7wHTrYBkT2y0O7jZb15Y+Bc9rjA0ZaEjnPD/sd1KD
 WlUqz+v+Es7AyREScNNkRku0N3HbY3pwHcjwUu/TYX2Rv9UGstW379KX/OfbJ60qgKWhd+QAV
 PpljZT64IvTpWAd+WftNMo9vllIMNji+JQkHZ2hcR1St306rXJgrHmglPWCgFm/4tuC0u9kg7
 A2qbPrZ6OJ3ecZe+U+lP1nyRX5ROUxl9K+aaPpAkkTnLMNaGIOVE/jyk55KQN3h+UFvXfFIRK
 7RFlcmD5F7RExPyhwZQ5Z39bKgBNTnNSZFyhm1s+Hw1/a7ckXo1ydVwldb0gZdYsv6Ea24KPn
 J33MSFaCqxTia2QXOIW1zNaj44XdtYvg2RyFPLi4/5b0O56Y54Z7lbP+034Kx/UuXWlZxmHHp
 GT9Ip7SGVF4d9cPhIT3sqIZOJ0at9vX9S0g1LzhUnRXn78OVLJsX0FWF/Me3kejx2ajUK1ybm
 J3dj9dZj9yPqWjfWdnQTWenPD85OOX81ZwJWAN9mFZmG9Li5up3mzW8cY
Content-Transfer-Encoding: quoted-printable

Another Git for Windows announcement that was rejected as spam by the Git
mailing list.

On Mon, 25 Nov 2024, Johannes Schindelin wrote:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.47.1 is available from:
>
>     https://gitforwindows.org/
>
> Changes since Git for Windows v2.47.0(2) (October 22nd 2024)
>
> This release comes with the first early native support of Windows/ARM64
> , ready for testing. Please report any issues!
>
> New Features
>
>   * Comes with Git v2.47.1.
>   * Comes with cURL v8.11.0.
>   * Comes with Git LFS v3.6.0.
>
> Bug Fixes
>
>   * Due to a bug introduced in the v2.47 cycle, the installer showed an
>     empty "experimental options" page, which was fixed.
>   * A potential crash in Git Bash on Insider versions of Windows/ARM64
>     was fixed.
>   * On Windows/ARM64, running the 64-bit version of Git for Windows
>     could infrequently cause deadlocked threads (see e.g. this report
>     or this one), which was addressed.
>
> Git-2.47.1-64-bit.exe | 25527923debc06515b3016f2d6bca0820656e8281a23be2f=
43bfb658bd5dda70
> Git-2.47.1-32-bit.exe | 121744b5d804f839d7f6e66e594ccafbe345418f0d02a696=
f6cec866f6eb1e62
> PortableGit-2.47.1-64-bit.7z.exe | 4f3f21f4effcb659566883ee1ed3ae403e5b3=
d7a0699cee455f6cd765e1ac39c
> PortableGit-2.47.1-32-bit.7z.exe | 7d022cdf6a79b0206db4274231f51bee27100=
1d8c88fe2e25d5ff81cc0535b80
> MinGit-2.47.1-64-bit.zip | 50b04b55425b5c465d076cdb184f63a0cd0f86f6ec8bb=
4d5860114a713d2c29a
> MinGit-2.47.1-32-bit.zip | 3c0fa6e3096c2304f8c6af9cb6bb35623b2e615771cf7=
be45f9632af83bd9864
> MinGit-2.47.1-busybox-64-bit.zip | 7b26cc61866c5c0ec050797f57837bf064eac=
d3aaa87ae316e96c6936235cf29
> MinGit-2.47.1-busybox-32-bit.zip | c5ee149a781c4672537926f967614e9e33233=
b8fd08811ce967b5f535ce77620
> Git-2.47.1-64-bit.tar.bz2 | 45d2bdc96712b0ab785c307461429cf5bd7442271088=
05edaaec7517432db54c
> Git-2.47.1-32-bit.tar.bz2 | 99a91af7a6a7a8791ebede7c0fd5339084853ec1a3c4=
f9dffdb91145ce934c1e
> Git-2.47.1-arm64.tar.bz2 | bc7fbbdfbc54d4a245fc0c18f88c2a20f82ec60345879=
f2fdc2e7f48d100bd61
> Git-2.47.1-arm64.exe | 63950d69998ca184b0ade0389a0e0b50e62f4a1ea8da97524=
49193c9dcda569f
> MinGit-2.47.1-arm64.zip | fc5747e187a70147404a94da104dc9f6005a3d45a78a56=
dbfa132075ad4a45e4
> PortableGit-2.47.1-arm64.7z.exe | d366f44ef2b65e11f7b5a1430ae43aceb5f7c6=
40150f325fa4b767f6da472845
>
> Ciao,
> Johannes
>
