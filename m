Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD63157A41
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727392786; cv=none; b=ozY+JH0QHGCpM3OiwtCnFGSk3G+LfA5Sr0KaVR2dAIP9DyQkLc/UWUyf+s8xoPp68qPvbjbMeBw4D4TOGNxcESNd5Ft47oAHiuYJYFnlmf8Sa/Uqa2/LDp8kCwJt+3UzZ4ktR6wncvVc0KkXFFaM5nFvdY5l4o7wgou/xInyhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727392786; c=relaxed/simple;
	bh=hT+E8MiAlJsvQCLMtRdl17Pkk+EidervMFpY4nvZ9ig=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EEyz3dncQIc8B/uSH6wxCS5yw8py9Cdcd1IVnilqfHpQTP1Eyc2kQO0Ta1JKYKCCwy81RuWobm4e7mXVKjcBEobXEAs+RNLI9CejQi4y3YBEO96lp8CDOcbHUH7suBYlZ8Q6iTNvj8YtirE0ixFGgN8RrGY3lqQGE94R+ugs4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=GRyLZwZf; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="GRyLZwZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727392780; x=1727997580;
	i=johannes.schindelin@gmx.de;
	bh=5JuUfsoO97ZoVj5VsATNQB8UsNgws0gXhmzwhyoiYOE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GRyLZwZfYXeawjs8zMyctVf1h7PM+PBkq4fbJamiRIsmifblt+fQoK4t0T0v/g5u
	 g9a+fdoxLxCkoBPrXD8T2DhwbU9Z9LcxXUclgu2Qyk2UtQ1x7CHe/sUuV6kvVTPqm
	 hbeGVmg5aJZdaW+0+gXnFbSMeQB3XcndLW5P6Epvxv30F7W5Dt/4G2r43j+VvL6Y4
	 wgxbMTap01sBqRaXngxk1EsC1KYOTpShDc2SPLYJYkt9NEI7qieFD83mAJ1Y77znX
	 oUw2bLhHh8LKCneNCvoUQS24F8EJgsBU1cL3DUynQr2PknmmqAcUU7fADFLrh/VsT
	 IR2WAzr2yICEfsrBLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1118-824.jboa14ee0bjuvjv5ua334yvpdd.cx.internal.cloudapp.net
 ([40.67.133.159]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MMGRK-1sbkAE1eRa-00MHHB; Fri, 27 Sep 2024 01:19:40 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.47.0-rc0
Date: Thu, 26 Sep 2024 23:19:38 +0000
Message-ID: <20240926231938.3362-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.46.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jnBgP1HW0SYcWxc+aAXAN2DGXyujVRMDQGGzgb2P7JKu4iIautA
 gBkn5X31wtIFIzBACyBVDEV6nN4reDSD5bW3PY83AtZiW4G/l3Hw0vqbI1go73g/JAFXmaO
 0IiBuAe1fINKF04FNTUyd7m9Cwv1yOh0tUrvPZ5uvMYjMxo+0LqQ1YrWCoFf3aFvHnbR0M/
 wbLPrDaTdeDicEjid3+Vg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kFBEl034pKc=;0mvFMGlJwW27GoNCS/srvSxmJSZ
 U2uoYrZGFy3bRGt4mZZzKAPYQOFYE4GM6q5cHUZ/mcOtu0Ad5hUhJGF4so8xyDZ58tXECjbUg
 VovUdFUfU96oMktYqG36BP99esVgcscqAkYaw/ihP9WO38W+ngn9XvPNzSS8F2hNh5Hi741eG
 +544vY8ESNwxU2vyRKwPt520uyrAKIYYKEfr878vAEBMYiXU073hn9oV01UDNOBF8DiKsRV3L
 M15YrsBLaBoUOiwayaaCJpMIoDkIr//6hUget335CsGIAcVAZuH/CRA0ptv6rjhP1Y8cLAbzE
 XchpVywVMo+1vqoORriN+SR3z9uL+7PFBiYSRlloiL9imUnWmj6+U6qcKrssqICdyGkPCG+eo
 ArPJDAZU3ZlAtpROZl9iCcvRWblBLstZh1Y2dZZpBAYCR7ZWpJ5HChcqYqbl+72ldgX8aH9Yn
 jyWnno3h2clJRxTeTy8JNDCF6QKoealIKwu0HKrJ0NzigElPwAs/+jBXdbo4yJX0sXJZOGb/w
 flznCZi/oh011bfD6nrUtp3HKZWghhptnRutSHRxsTe8xMZC5ZUuLcEJ97xTEJMkZxWCdddD6
 PirFaB6GpUAP28uAys/cTHB+tCegpreAdGCNGJGVDybIHEWI5hy4PeaXkqf42MOgJqBzOd45+
 SvPfRq/ayMi1QiMPFl18UZy7LxrIJF+jCNSKGTZNXnFqKuMtZ8UwzxqnfucqAPOgZIpa6r56S
 7XG5Njy6sQZa6Rxv79La6q8fZwUviZNy4O8n4NxkJE8m1equ63432xBqfPYDSQHNnn60Yse+8
 wd4XZpNQBSjuOy73qOrZmPag==

Dear Git users,

I hereby announce that Git for Windows 2.47.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.47.0-rc0.windows.1

Changes since Git for Windows v2.46.2 (September 24th 2024)

Git for Windows for Windows v2.47 drops support for Windows 7 and for
Windows 8, as announced previously.

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.47.0-rc0.
  * Comes with the MSYS2 runtime (Git for Windows flavor) based on
    Cygwin v3.5.4, which drops Windows 7 and Windows 8 support.
  * The new, experimental git backfill command was added: It helps
    fetching relevant Git objects smartly in a partial, sparse clone.
  * The new, experimental git survey command was added. This command is
    designed to help identify less-than-ideal data shape in monorepos,
    and it will likely see highly active development. Stay tuned!

Git-2.47.0-rc0-64-bit.exe | dc04b25551e16450b69510609e13cb547a8034044de3946b1b8af20989d61160
Git-2.47.0-rc0-32-bit.exe | 0812c66262aa06e89989c4470ead52e1bc3e2dd7bd0f56bf0aff280a508831cb
PortableGit-2.47.0-rc0-64-bit.7z.exe | 4d3f7132f527ce771915c3ad5013cc44b6579d0044a7e1163135f99c101e7b4a
PortableGit-2.47.0-rc0-32-bit.7z.exe | 24f4ae7f1ba5c290427036bce10dc252f256f7feb18246cd87d0472db78298c5
MinGit-2.47.0-rc0-64-bit.zip | 5575923763af15840d36f954c25cfb898529393ccb8cf887df5ddbd74b49784d
MinGit-2.47.0-rc0-32-bit.zip | c49519473d62d89f0e5f5aeff380ee229ea34de961d1ce7de67c2d2ce325f4b4
MinGit-2.47.0-rc0-busybox-64-bit.zip | 5615718f83e1e2934d580a9b077512a59fe2c8d67a4e89b35fcfed627145a7c2
MinGit-2.47.0-rc0-busybox-32-bit.zip | e5f0ebf186eeb88fc8993076f05ad611e8b5af6ad39bcaf21611535439b0b4e2
Git-2.47.0-rc0-64-bit.tar.bz2 | 1fb8a8d375fc4908f60542854196fe0fd9fa2451d4be0a49ba005290fb7e7e2b
Git-2.47.0-rc0-32-bit.tar.bz2 | bce4b324df0ba20a15a14540dea84a50ba5d81f82dff21745b958c1d12f90e2c

Ciao,
Johannes
