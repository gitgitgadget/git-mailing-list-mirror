Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B62FCFC1
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773188; cv=none; b=XHYBT62sqAoQMAiIk+CojBb5goXGVFPSBfFgJs32kZEkj653uA+AS4T7+Ozw6eQtNUyCmizWJVVtj+RLXC5bHhayMDx4KzJKQQJdoVswL6nF2v+ma9hP98HjAoH3KHXPNHEBj4uaV/QT7CUTjZNBWUgaew6ZrVMdPFBdndevYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773188; c=relaxed/simple;
	bh=bmoWiI1bfSEdXqtPWABE7PZ0rj4q9vWS961zSfwhQ8w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qUoI+rgrknYgrZjgoORmxMHqYrR8UWEDbnoBeUYaduerZCel8J5cqA826MOTLcB7K/vTTpW9WFEUYrnLGbGcrCZjaMq7ZxQnZuahxfFy6s0bKlc6/2g4XnDuPxRvWBkRIZtQRwTp5pYQHePZRQNEFJt1ceK6RAweqOAEaGdmGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=gflSxghK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="gflSxghK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752773183; x=1753377983;
	i=johannes.schindelin@gmx.de;
	bh=voofGvjTo2vhfOVknGdjcJ/4EyXtcjT3hdZWLAi2+Ck=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gflSxghKnUzhMTqc8Riqa2yhEzKmivd7hVPA6YSOA0HkW2zpyEuoHLc43W1FX+NK
	 GLC5TLIgoGAudmnJIKmD/ibsej0MmAnVd5VDRjflBueTEqerbE99dN1HKPLQ8lRPm
	 h1bEIapRZIOnYIoEIN6k97G4RwDpidKfgvabz19zIlY7y2YInX0CezvRqafasr+K7
	 uKdujdV894oT55GPklrOINSJ2wVu62A2Ai4wtu5Ppz3fzgRnv4rW8MzJpBDnZHP5w
	 nIBLMh1c5XXDjZwFWIZjnEvKeGCtR94HBMtEJimqMjS9bKIsEWjTDeX1n4MhCMGSV
	 H0P+r0m33El+nBv4pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1uLTUC4814-00QGgS; Thu, 17
 Jul 2025 19:26:23 +0200
Date: Thu, 17 Jul 2025 19:26:21 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Fabio Frumento <frumento.fabio@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Git bash 2.50.0(2) not working on windows 11 PRO 64bit
In-Reply-To: <C4F62B0F-1729-437B-B9C0-0FEA74B307E0@gmail.com>
Message-ID: <572ec2d0-b587-9cf1-7643-1a0f3e59c268@gmx.de>
References: <C4F62B0F-1729-437B-B9C0-0FEA74B307E0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-113415867-1752773183=:9311"
X-Provags-ID: V03:K1:VRtMAM7Wh58rbT80cRPsb7aqBAxS6n6I3WW+4qxGOkOfP4sc/mh
 ya7nossqCgmfAWUQ3zQfpdKDAap/WDxR0yyattN3ULUF/18F4zUFQdbtNZNIAaHrxS0CwEf
 kO4XGcAVOmSC+5Ru79CtndvrFifnIvXFrXz1DjDUSQrq0UIGw0jDlDJBZun/R8uOIiC/MGZ
 6yx83D1ClHVzxhgUvJ6vg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PKf7KjbhLr0=;ksLaf/c6ON8FOZmAqC6HsVCWFC/
 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
 ZvdiVTUDr2p0hYSIyHm2QFkdalIfxkMGyKq

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-113415867-1752773183=:9311
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On Mon, 7 Jul 2025, Fabio Frumento wrote:

> After upgrading from 2.49 to 2.50 git bash won=E2=80=99t start anymore, =
a prompt
> window shortly appears and close immediately, downgrading to 2.49 solve
> the issue
>=20
> So 2.50 don=E2=80=99t work on windows 11 Pro=20

Maybe v2.50.1 does?

If not, please run `& "C:\Program Files\Git\bin\bash.exe" -li` and see
whether that reproduces the error (in which case the terminal window won't
close immediately, giving you ample time to copy/paste the error message).

Ciao,
Johannes

--8323328-113415867-1752773183=:9311--
