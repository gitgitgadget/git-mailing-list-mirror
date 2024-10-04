Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70A1D5ACD
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049377; cv=none; b=e3rrkxDcYqR88UcKRJ2/hOV8hrQ4r0Yk/UI57WppIxwxWGbrrpE6MidoqFfnsOZJ/XW1r5kd9efE1xxOjMAXvF28cUyCLJS7zVU10s9k0U4pQJlybD/ilArkY71WtTgvYbxJ8KcYPsJr79cytx7GeoeQYYfn/MQRiz8OZ8heS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049377; c=relaxed/simple;
	bh=Oypdn9i7fbL+bp95vHdCVuaOyL87sHThB58VRPtXK/8=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sBUi/LAudHr1q8Sbf+xkwK+uvUL6oTLPUXt4CaDzk57R2MLWjxcCjQ5ALFBRnwFE8tBDGwp0jZq8nFr/MInGSpSP4qed8stLceo0Qsw7+j362zJ4rAqRyfQi9WyY7ENok2x3qP4LdQLaNxtabGOMvsSGEDcbkV57J/w0OMfA2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=EEQGEspH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="EEQGEspH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728049371; x=1728654171;
	i=johannes.schindelin@gmx.de;
	bh=zWLyETTCKC7jeu3njxKRWSvQCgVX9rP52HxuEwytakM=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EEQGEspHa+mgMU8ubbZDbkkICSdeqzoKM8xOHrZxc2ufDgl0nXSHqsGFfNdXcFHt
	 lUhNTvaUgHt93GNzGkOPjuoNh6QGa0js+jrVkTJ+FTviolrNthSvxzNKOIUInefUW
	 JW6X5Ipf25gB4bOgZRC+d4LZFZP+R4KaKPwRmap17CmUPn656YspG6lyO44qgkG6U
	 4zaEUVys/0jwOAkF7zssxL78R17OT3/aroAWtarI6NalcSs5yHctgS3gW27M3uWqy
	 4XdwPvwDPpdhFBq4pPKCTChLU9dOizezQIvVat9hCC4eOh83ePfT+NlnM0cXIBp1j
	 NjPwN4YhNU/eMWgpBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1sSNjJ2G58-00XJtH for
 <git@vger.kernel.org>; Fri, 04 Oct 2024 15:42:51 +0200
Date: Fri, 4 Oct 2024 15:42:51 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.47.0-rc1
In-Reply-To: <20241004133201.3410-1-johannes.schindelin@gmx.de>
Message-ID: <11832e78-0d0b-8b91-4d52-7f4362835f04@gmx.de>
References: <20241004133201.3410-1-johannes.schindelin@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NzqmWWnb1EarA4ut5zlj2DQDJ+2/+JB8xF56bFUnLUh8ZWKDT9Y
 lOKelLFF0lTWBiDBdYzU0pOgzaBQ0rbCayF3O6mHUQKANeDqLogZaYA6WJTyK3CbKJjg3Ou
 mCQn8dc0O2KXpVx81vePNf985qjDMB5ff+mLOQHAf5YUHU/75U8tKjzfjfqexTo6Ug6BX0E
 ynGemp7L0bG99KkXEbvtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d2tf6jw6Mtc=;ALRB2nG8IxSMrkNmVt2V3IduJXN
 JfdsMsjptBecyKVISzbV3av6YkHSZmKpNTSd/si9Ti+7bxmQ4BxP1mUO3fYt8wtz1cdyF2Ctn
 UT58FM/PhNnlPD//Y8JxM/yAl4beLV9cEvz4CNfXCJRdn7x6NLUN50dXeEE/+u2hMS7FOT9l8
 VGcovzDzI/uYJOBSvmyvB4ysLvYNIu3yF/jesDgZwwNu5xkS/f5EMpEj5ko5RrwSdMveBiVEL
 JVnYmX1MTulraVf245epnl9zYgIdVwkt4Gn1Updj9CtbIAy7p6swrvYEjBeUTGDfHH6e9n22E
 Gb1XGaCDbrQcPqXPJJNIeQPaeIbzNr9Ccv69/D80ipkwZ0dIsWoVOuixhpUcD5KpooXpeRz3Z
 MqeeWrtQfUYDbU5jEQotfb5+9wijZvw3KSxSIICK0c9gHz7lbc5vcR8uwPcRO5AddSbaRBpzb
 s6i+n63U78nmPtn/0jJ2Jp30pLDsQ/hhMGnJ3NkK9SbeVtBZ5lZZ/AiMnxxXshbXh8Wpe+98C
 1+pWJbEwo0RWImwXPdiZ1vPKEQZeLzfu95TkwfHo9diL1DccE/96oKhVK/OIe/d/KWa28KgbK
 bvi3JxjEuCpuB3w0J9Y1cXKhxiNHaWJexFFM7AOvqYxBBk3KWUrrwn+J14A8ybMDuFvBtmi5x
 1tI9Qf+gnP51bKS0+w6dz8G51Lsa96IwcP42nNAMTn6rBE+hU0URd2Ky/crK7Y/WkMY4u+GZQ
 dukkN0xmnQEbspGx8I5yuqjfteOJHPtfNvbzRLZfkB15pedgDv2JdXiz98aP3uofAYCGEjUVa
 nK/V9hdl5rclvxa+ZisttBcg==
Content-Transfer-Encoding: quoted-printable

*sigh* apparently I am on the Spamhaus list again.


On Fri, 4 Oct 2024, Johannes Schindelin wrote:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.47.0-rc1 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.47.0-rc1.wind=
ows.1
>
> Changes since Git for Windows v2.46.2 (September 24th 2024)
>
> Git for Windows for Windows v2.47 drops support for Windows 7 and for
> Windows 8, as announced previously.
>
> Please also note that the 32-bit variant of Git for Windows is
> deprecated; Its last official release is planned for 2025.
>
> New Features
>
>   * Comes with Git v2.47.0-rc1.
>   * Comes with the MSYS2 runtime (Git for Windows flavor) based on
>     Cygwin v3.5.4, which drops Windows 7 and Windows 8 support.
>   * The new, experimental git backfill command was added: It helps
>     fetching relevant Git objects smartly in a partial, sparse clone.
>   * The new, experimental git survey command was added. This command is
>     designed to help identify less-than-ideal data shape in monorepos,
>     and it will likely see highly active development. Stay tuned!
>   * Comes with Git Credential Manager v2.6.0.
>
> Git-2.47.0-rc1-64-bit.exe | a0e8c9bf311eb62cbe3b13927a4c6cf531da58ca7350=
83f1e48c2b3227c21aa3
> Git-2.47.0-rc1-32-bit.exe | 920b333e776e72b8ed8c00661087892a2fffc5430fc2=
107722f2a6ecb2cc313c
> PortableGit-2.47.0-rc1-64-bit.7z.exe | 1d8f28905606956494074b3ca47df54f4=
46c3c0d0f63081dc36ae85b4bc1c18a
> PortableGit-2.47.0-rc1-32-bit.7z.exe | 2172d422766f2ff6a63dab1a6f1e0de7e=
6c9430b992f7a73f34f7ec123c6cacd
> MinGit-2.47.0-rc1-64-bit.zip | 35edb7408cea8427d1d5dcd4145ebf53d1596e2ce=
de40b9276816ba11d83367e
> MinGit-2.47.0-rc1-32-bit.zip | d63983be9733cb3c93cd4fb07a04c25cc8edb7a64=
76b1bccfe381483dcca89b2
> MinGit-2.47.0-rc1-busybox-64-bit.zip | 3580edcf579645de7858c7fd83737abef=
ca56a76b6cb0ab6572777635386d749
> MinGit-2.47.0-rc1-busybox-32-bit.zip | be4ec0e1ddb72dce284a57da8d109961b=
391100e8dc3c9c456561a7423d1b8a2
> Git-2.47.0-rc1-64-bit.tar.bz2 | a49685034ec5b2c647e0022d23024c4dfe4448b6=
2ad775c6f8f2b18c5162ea9b
> Git-2.47.0-rc1-32-bit.tar.bz2 | 6d6f0e87edd5111f1e5d62f68d4b98bf92e3cf2e=
e3eb4dc70226cffb2273159e
>
> Ciao,
> Johannes
>
