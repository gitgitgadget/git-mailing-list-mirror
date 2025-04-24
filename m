Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2127B51C
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499488; cv=none; b=DR9RH3e1HLT0hVu8fjQfLQtE2UO5ZbOerIuyv+AjNP9y3d68g9Pl0+ayFjaNMeUEl7xLT3b+oR3GdVVHkoUbuVG0siYTxR3rXVab3Ys7VU3WESe2BNAe3kYBuayR1+sxc9DfrZ8tcO+HRnLkpVoP5Ni1X7Z71z96yKY+78rTr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499488; c=relaxed/simple;
	bh=Xbqv2KhJpMegeilPkZGAYGc+ll9v49EI76SUms4e0cY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R1Buyt+5n1HrbCKlalIcD+HxrnOmX86LMJC6UeivZvL4SCx6CPQheaQ1KkkUUcWLP8BfJDx28kt/HZVs2CctpoRSQnsG79YL5eWIwnXpWnIGKQ9A37j4ZGTcez+EZpkq/tL4Hc/Hh2dzCI9gTcWlndhSpsl+ZRXDDKcG9hsF1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=PZm4XuLQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PZm4XuLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745499479; x=1746104279;
	i=johannes.schindelin@gmx.de;
	bh=Yf0Ruhu0JjwuwTIC5HHiU4dvbNCiqWTmF3VfAktJzSQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PZm4XuLQhOOOteyCpvOpFxtBNBVanNmutHv5QobCYp9jvaBk0DoCWZSrPcz83IcP
	 GojsSDxcLPEpZ7CtI6cGFUGs5qtiyTCJ0SupomJyVsKBdPIQ/Jy0FxlP6lSi94pMm
	 qw2uq1wdFqxAyHGX9tmsQnK4dxyHhdZDL0XPJ4CJBJWDQHFZBm0sEGZABpsMuvkBA
	 rQ24PuGPk2cdszbykChcQkm40fhcM66AcwpILvhkXoStWpDUDH2sdlrc0cIV/11vY
	 +s13t7NurWycpMUsA/dbrhxulK4Bzfl6sjLQZwczic8fQ0Za6j85zZWbuFPfeAWdv
	 9OW6+ThzZsk+CF/pxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.93]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1uUXCb0Gnu-00UTFC; Thu, 24
 Apr 2025 14:57:59 +0200
Date: Thu, 24 Apr 2025 14:57:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?=E5=BC=B5=E7=A7=80=E7=A9=8E_KITTY?= <kittychang@cathayholdings.com.tw>
cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
    =?UTF-8?Q?=E9=96=A2=E8=A9=A9=E7=A9=8E_VANESSA?= <VanessaKuang@cathayholdings.com.tw>
Subject: Re: Get support
In-Reply-To: <202504160735.53G7ZjeU083840@365mse01.symphox.net>
Message-ID: <dc58a9ce-3d02-bb52-bfe1-7427333d6128@gmx.de>
References: <1744786449-14024-mlmmj-0f30ebef@vger.kernel.org> <202504160735.53G7ZjeU083840@365mse01.symphox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1376473283-1745499479=:96"
X-Provags-ID: V03:K1:6HdupC5s75l5GuxouakaMx33UHsP3oSfGT+W4JZvplVsC43uhcq
 vQ9Iow/aRm7LTAnd8bQnd44FQX00W4/7HnBN9CfsijLkQW41hI6E1BAse/0VLg46gj+EcOr
 2opjLbH8DsWy/mLZVOqmxiI5omhtvPoOp8eeOTGQIyT6LClQaBLWQ2tCna7I0F3iY1b0MPx
 VioUt9UfKCi2shbKqolsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QEqixOYS4vI=;4rt7yUMKHbfLAbRu+/Iyo6M6QAA
 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
 Q==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1376473283-1745499479=:96
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kitty,

On Wed, 16 Apr 2025, =E5=BC=B5=E7=A7=80=E7=A9=8E KITTY wrote:

> Hi git support,
>=20
> We have problem =E2=80=98cloning repos from AzureDevOps via SourceTree o=
r via command line.=E2=80=99
> We guess this is a Microsoft issue before, but later we find that this i=
ssue comes with specific git version. (Microsoft case: 2412240040000772)
>=20
> Different git version got different result.
>=20
> Git for Windows v2.30.2-rc0.windows.1 ~ 2.43 ---> Clone success
>=20
> Git for Windows v2.44.0-rc0.windows.1 or above ---> Clone failed
>=20
>=20
> To prevent git version 2.30.2~2.43 from reaching EOL, we need to know ho=
w to successfully clone repos after upgrading git version to 2.44 or above=
.
> Any suggestion is appreciate.
>=20
> The Error Message:
>=20
> ----clone by Sourcetree----
> git -c filter.lfs.smudge=3D -c filter.lfs.required=3Dfalse -c diff.mnemo=
nicprefix=3Dfalse -c core.quotepath=3Dfalse --no-optional-locks clone --br=
anch develop https://cfhdevops@dev.azure.com/cfhdevops/IT-CBooking/_git/ca=
thaymeetingroom "\\CFHVDIFSVIP\CFH_VDI_UserData$\00904813.CFHDOM\My Docume=
nts\cathaymeetingroom"
> Cloning into '\\CFHVDIFSVIP\CFH_VDI_UserData$\00904813.CFHDOM\My Documen=
ts\cathaymeetingroom'...
> error: RPC failed; curl 56 OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0 =
Completed with errors, see above.
>=20
> ----clone by command line ----
> $ git clone https://cfhdevops@dev.azure.com/cfhdevops/IT-Contract/_git/I=
T-Contract
> Cloning into 'IT-Contract'...
> remote: Azure Repos
> remote: Found 10 objects to send. (25 ms)
> error: RPC failed; curl 56 OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0 =
Unpacking objects: 100% (10/10), 2.18 GiB | 6.12 MiB/s, done.

Could you try with `git -c http.sslbackend=3Dschannel clone ...`?

Ciao,
Johannes

--8323328-1376473283-1745499479=:96--
