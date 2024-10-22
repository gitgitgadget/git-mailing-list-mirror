Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE31130AF6
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632486; cv=none; b=BoePHkxNMXzUywJZz8SQStb9Ngbk81jRyikBq9sg4BYuvqkQLH2v3OJ9rsMwAtic3ye8XZoBxhboiCzLJjk7kCd9aRlLRQ9RskoN9zFgbo7LJFIw2OhbJiUAiDSTLoF9PAlm16LfMYntzzJdH/8i/fQa2sXX+QmQJ+jJjp+AiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632486; c=relaxed/simple;
	bh=+PNAzH28Ui4Pnq/oUKuTiXG9xzAR9LIzOAuR49bHXuw=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LdeR9Jmr5dY1ZRsc2c+W1KW3+BkCZRRQYPenAz4K+5Dly8k4zxnNf8wUb2KY6qxvvM/tG3SoZFBuB9zLHdI6QJAj0LRV8JXFcb6dw48THIeH9rOFJeqbHt/mFuDeIXrQm4Kzvgic4Xg/wx8hRqdd61GraHJm9tVhTQvj0pq2pn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=POFDKZA5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="POFDKZA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729632482; x=1730237282;
	i=johannes.schindelin@gmx.de;
	bh=drfdRT+k1y81l2ayabJqySsWZcPDQR4gKkmsTxXNXFU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=POFDKZA52mu/UaSpwrXl+a9Cqpp/6pIK6v9V3mqO0lqZ5cIJfDXA2PDF4DaWT6jS
	 RmOrCcu7bcYXMv2s1I9RyH2fLYa4IkFw8uJqyBo6SH/ENAzhkyXnGnrJG4GiM2jvl
	 Qms3vvnaKCPvPaUOyAgRbMj+S96nMQB0UzB/9HlLN/yo0NM9dw1lpozQKyqRNnUN7
	 uf71vZuKa3hIBp4EkWjeSCWyQL5+Q1w2mPMapEkmTXFvDkq27vukuGo5mxRIqM+Sx
	 l9dZPLhzNDeQCRsPJzK1Mfd8pKQzLC82FPfJb6iiQifDdsFLD4wYWqNRqSrDNrR7F
	 IcMJBs8kkqNeZQGeeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.102]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1tT28l0SjN-00LWET for
 <git@vger.kernel.org>; Tue, 22 Oct 2024 23:28:02 +0200
Date: Tue, 22 Oct 2024 23:28:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.47.0(2)
In-Reply-To: <20241022105113.3259-1-johannes.schindelin@gmx.de>
Message-ID: <f44861fb-10f4-b701-8385-4664965e4d02@gmx.de>
References: <20241022105113.3259-1-johannes.schindelin@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wGdh5ML7fmefcoHFKCPBa9fE2C7rttmEW/Lqi+tqUhBF0yLH2LO
 jrQ33m+igYr1IBAYv8iho/o8V/nZk4agZj4u6H+mJYEX4V3AfOjb0PIQ1WUV4MhOe/8LhkG
 3mT5FMdrGkUlIKzzw19fnzz1Jq1Cv0l8UmmIJHbbkT889a/EghKPOU60EjZGJHb49xf+/wD
 2LeKSA7DGfqX9Nn0FEd4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rpvPseUrCSA=;gAzqEgzCX7LonTunE2qibIYQ2ys
 f9zFV3k+ShBKLkroWkz4HNUERlHODcg88KxnbTtHX6vvXpe/4OnxSUi7B7gxL9JnGBQqbEyAW
 yK9Ec+Q67W2XE0HW9v1Hh165M7s9WBLKCpLryjHoQT38YU6KrhkY6K5vDFU4tHSW3UNQMVbez
 H+lV/QGWVj4zP6JvmmGZa8AKP/PuNC/pzu3jkWRZSbJZxQj94GAo0mRznLIvW5MpJkWh+a3mL
 NS6r9wQ26lJ6Z2d6SImwSC745g4BqsVe55DFP1y6J+IP60TF878i514Tue8VxdEEr8tCsDips
 pdPyrdCY/w6QeYWQQ5fP3EIW8cPqfSQQkRAQb2jPNAZcH3yBVvsElcfoZ4Ae8oZon8MOdvR4i
 00WN20ZCCt0rfcT4nNXdMpCiBsqsuNWE2ZbG+KlnFySjIzxsSn9dewFnyfTEGpDLToxT7CwA1
 LT80W5pf7t4ihEcn/OCTrrKKWmmpL+JfD7bKb41cDCh3qZJpgNyc8f8oH8BRYrdNatuLhk9Q2
 /liiT7rnPdUjXHAD+WlJ0FLuW2rQYkwHorenNX1ewclWhdeB9LrLiK1RY5jpAOMhomTmp+rbY
 1w9fkqknN60IIFmubfUMXmFwRCsgiXMRmB2lhYGXkHQfefLSVFQ4BEBMBu3IXXmQtiuwamAbR
 8RD9lkPjNo+VPf0kMaY9X7j1IU/ygVSQO6NQZjsEcnQZVv7wYbFoGXn35KgufRZffMwijXHNb
 O6WBXDUtgVckDe32LjuBhw52dyFkFvYVjwAndYnrS18XoW+avoJXRGG3cGKaQ7voRpT1g6/Ef
 8UlWqmS+5Ysjsg7QJUwk0FVg==
Content-Transfer-Encoding: quoted-printable

*sigh* this email got rejected as spam by the Git mailing list.

On Tue, 22 Oct 2024, Johannes Schindelin wrote:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.47.0(2) is available from:
>
>     https://gitforwindows.org/
>
> Changes since Git for Windows v2.47.0 (October 8th 2024)
>
> Bug Fixes
>
>   * A regression in v2.47.0 where git maintenance start crashed
>     immediately was fixed.
>   * A regression where clones, fetches and pushes via SSH would
>     dead-lock was fixed.
>   * As of Git for Windows v2.47.0, Scalar was supposed to enable an
>     optimized push algorithm, but for a typo didn't, which was fixed.
>   * A few documentation and other, minor bug fixes from upstream Git
>     were integrated into Git for Windows early.
>
> Git-2.47.0.2-64-bit.exe | 83c618dcc50b63f0f7afc86a7a125169bd59559ff68068=
3f1d915c45e05ff4cc
> Git-2.47.0.2-32-bit.exe | b798dc1ff11afe912994e0e7d0b538edbbd291e666fdc6=
f34fa4cb19547aefc7
> PortableGit-2.47.0.2-64-bit.7z.exe | c77368a8f6ccbd43bde0df0ab603133ce88=
5407a018787d6f1971e040590f1ab
> PortableGit-2.47.0.2-32-bit.7z.exe | 71d7de445ce2412c0344f5258dec4a51cac=
3b4b536b0d68c8e753729d429d365
> MinGit-2.47.0.2-64-bit.zip | c4a5d3a2adda98b25fe59349733fca56b3843360b96=
2dba5535282a9d8120b31
> MinGit-2.47.0.2-32-bit.zip | 59748b3193b6f27849e35ee76165d53f47a5a205a4c=
d83e926800570aeaf5aa2
> MinGit-2.47.0.2-busybox-64-bit.zip | 672aa54dd79d35baa75df934e2bb6faad5b=
9f45a99339b1dbd5a1fb2f8b44348
> MinGit-2.47.0.2-busybox-32-bit.zip | 94ff74c2c7f68a5093b57c527398fe17623=
0adadb71c25722f0c43a5de611f7b
> Git-2.47.0.2-64-bit.tar.bz2 | b6ca6dcd5c818396faa57e06e10489aed3e1639631=
7475ca8e88e30e4eb2e3c5
> Git-2.47.0.2-32-bit.tar.bz2 | d861cdef6ef1c93f412eb6e5fa766973a6eee5f8a0=
8973ac4a396bb235c3d489
>
> Ciao,
> Johannes
>
