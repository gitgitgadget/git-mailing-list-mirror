Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF321E47C5
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773276; cv=none; b=rW0srT4HWlmA9gQ+ndtID2ZB38m41tfI1iooXMUlA3UbOHUi4zKYIptkURlWwBtYbHIrK45x76yqazkvKfC4+ARL/Dwhj6635/HGKfqoffuEOBxDigu76zWNK9gvLVXEHf4m5KixbilmHO71BDsSXeovfpOXy8ZWeix8YdZYiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773276; c=relaxed/simple;
	bh=UybVUtvTXMRe5NkGsEsBeQmsKTGFRKIX4hQukCEQ6OY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ILmt5F4cuStDdsHb/BXyzunbeo7DayBbkXXfFqo7OYbrVbk1ZfXQZofau4HsOnc+xbo3j8/6h4Xr8wA3j4/xogzYFhjRxS/M4lbw72oASbtj4gq1OrpVF17Is7/LvOrSMNOpUKZmwL24S3LnVuvd3SZIk9Vhxo4tnsFfJF5FVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=rKr9LH5/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="rKr9LH5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752773272; x=1753378072;
	i=johannes.schindelin@gmx.de;
	bh=vdKXmR7dE91i62RMYMsdWpBuCNIJwAq0w5GhdXtAPgo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rKr9LH5/zb6ovwvMDhmXOvn5VrouguvWAZvCDWnmtVACJhI4tW1M6P7KGCD0V7Ae
	 HgSFkVtLCes/dNu5WIEhUFjTgLn27g0FCEmBl4CudD3DNMezwIxDRirOGZhb1vLCy
	 +wkgbBuusXUvUaiy3O0pz0FgfVemtIfPmQiR4CZYJ5/ncDN36Rq0hwOmM7qUZjjKC
	 j/VoqmbRSLa5uTNOYvgPKuBBmqoJ7ze57fi2haEsPrW6/9bhxpR2TjO3ugFKAZ5Z0
	 Z1dZA3tsizBeeN/Vw7FI5XRMCDhRpzj6/ajB1gWJqaq1hBSAyPN746n/b65q1Dc8Y
	 ieVlgIZtmk2hCGpbwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1v4bt82Cxy-00oL53; Thu, 17
 Jul 2025 19:27:52 +0200
Date: Thu, 17 Jul 2025 19:27:50 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Fabio Frumento <frumento.fabio@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Git bash 2.50.0(2) not working on windows 11 PRO 64bit
In-Reply-To: <572ec2d0-b587-9cf1-7643-1a0f3e59c268@gmx.de>
Message-ID: <af2ab4ad-51d0-7b88-a0aa-6063e3857d4b@gmx.de>
References: <C4F62B0F-1729-437B-B9C0-0FEA74B307E0@gmail.com> <572ec2d0-b587-9cf1-7643-1a0f3e59c268@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-828717416-1752773272=:9311"
X-Provags-ID: V03:K1:z4vS8iqcoBPjmtfKVMvgQmb/AdNXCgiANcpF+3RQZ3xoa8ojtmf
 7xKq1zOuLcu4FV9DDnycjXOcmblUH5jIEKwvcA4QYZleVroiM0jKvMajZve/2/FaRUa6J8K
 5+bSSm0zQOBMBy7lxuCUJ7eNXHA6Xhb1FjLxQyAkp8PNULEtvmwLOLqUXeG+bsX9Qz9YMA+
 VzPyFhxgKwUkdl0cWRHiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NUYaddq5z9U=;d026Ek9BbGWDmHmarb4hgQvP19/
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-828717416-1752773272=:9311
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On Thu, 17 Jul 2025, Johannes Schindelin wrote:

> On Mon, 7 Jul 2025, Fabio Frumento wrote:
>=20
> > After upgrading from 2.49 to 2.50 git bash won=E2=80=99t start anymore=
, a prompt
> > window shortly appears and close immediately, downgrading to 2.49 solv=
e
> > the issue
> >=20
> > So 2.50 don=E2=80=99t work on windows 11 Pro=20
>=20
> Maybe v2.50.1 does?
>=20
> If not, please run `& "C:\Program Files\Git\bin\bash.exe" -li` and see

I meant to add "in a PowerShell session" here, but forgot...

Sorry about that,
Johannes

> whether that reproduces the error (in which case the terminal window won=
't
> close immediately, giving you ample time to copy/paste the error message=
).
>=20
> Ciao,
> Johannes

--8323328-828717416-1752773272=:9311--
