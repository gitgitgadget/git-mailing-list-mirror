Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420526AE3
	for <git@vger.kernel.org>; Sat, 18 May 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716061807; cv=none; b=VqPg4xjwhvk+XcYRaeJsNJ80veRVSQ28n3NTRUKxYmc+bUS23Q4woasPTljVzXRMNoL2ftpiqifFNT3Q4Vmi1Ldmh9A2lDyK5vq9+5SKBbQ4nV5CHY0/rfLI8OfT6VyQPoAafVHObNue2sreBt+HYKR9rP4sRlp4J5hpniRsA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716061807; c=relaxed/simple;
	bh=9m2Iiv8K4ul9h87wyFeXp2bUvQVylPktNjub0SCuTc4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HdqyhbQ0c2tUZrcz54t5cuB0qoplMQwyKCLvUTR8mx0NIFfpEPGCjuM4yeGB8huRdXkJta5A0JkYSUE1FG9trw9VF0XPv1PD+fHzoKG5whzwtLVD6eiimFKX4LyI/qUTCrnCVkm7Ng6vU1D1ZcX0pEUkQpDJZP2k4RqNQBcFlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Z+8iIgMg; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Z+8iIgMg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716061802; x=1716666602;
	i=johannes.schindelin@gmx.de;
	bh=OUNVGq9Q5IdA/AuES2G/iJ0aDKghlUC15SoZhZiYd8w=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z+8iIgMgiFsqJ1KvkATMevPOUwhkOzdUywQxuyl+zoo8oYil8rfU48siH51y1umt
	 wfnOxfhg1rBLkCxlENmNftGDnN2KjveSLzF1wDFo4oYPJ7wMmgIEzcu+8wA27UIBe
	 waeChUQeTXZttO4Q9MZzGYJMoAPoIFNapb/gMt3h8IECM2kFiyBrMWiw8wNs6vNTS
	 4YaZR7AogJD8auId9W6yYwRv0GeIUhsz28Ev4booPnwku88QRr2LG1qG0DVchM72r
	 C8a42toKOGU4gP0TCGcgHVSOk8X9LiIxJBN8cAGbAUvlz4uaZobtlX2ePrc+h3jfc
	 k34Vgzet46/A05+owA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1sEToS1VZe-0063Bw; Sat, 18
 May 2024 21:50:02 +0200
Date: Sat, 18 May 2024 21:50:00 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Konstantin Khomoutov <kostix@bswap.ru>
cc: git@vger.kernel.org
Subject: Re: Embedding Git Command Line
In-Reply-To: <20240516181738.g7iw6rfqvjfucoiw@carbon>
Message-ID: <224aff4c-facc-76cd-94c1-8b40f18c0d40@gmx.de>
References: <36B52407-B52F-4394-8DF2-F2DF3D3F0504.ref@yahoo.co.uk> <36B52407-B52F-4394-8DF2-F2DF3D3F0504@yahoo.co.uk> <20240516181738.g7iw6rfqvjfucoiw@carbon>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-117966010-1716061802=:462"
X-Provags-ID: V03:K1:Haq9nnBIqCj26KrmdQGEun0qwQBk9VujqqABUxkZRZG7tg90Qhp
 BBhNk3XOD4hMRBizilJopBGJgciB/BkMaPt54dXT6bOQ7/T3h7AEw4jn4RPDZ7f5c7TLtJl
 CSvN9jDo5RS1k9extj2FBA0JErM41mkOipc/KTzAQtYW6/7rMpS2G8iQe+d9sgp/dGLpkh+
 N09YzSLd59Prz/KFpK6Eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jsakhFizoSc=;fhnjWn6sIpyuzcZdTGWwej92l3t
 X9+bopzd01W9PFIJ3wqegw9fPybDQz8QjsZCDacN7Yc5RB6bYUT2IoVcvb7Fr5RYvzEPDydA5
 mR8KiIBmWBIrxSBsgc0Kbki8Wfbv70o5kcdaE45K2oQJWiPvXwWl6SP7DTNWugrv+2wTZ6f0O
 DerI2vcjD36Kp4IHnzf8zZcdz/8EbyA30hsksihqIc1QBbOEIs5ld+6H0hj/vODYWToBsxaLu
 PVwFl6kyxkG0R7xBUxQN5s5aWasmIOUPYXRO5VbXooMKav3SbmKznKarqhzUdk+2IzeTwxSG1
 x/nOAGVZQv5YVuLzcuKenkxsyKP1XZSS6ftNEzGrfkbJCQecpwjurZmxGry1JGBZJaDMExwxF
 SyO7ukOIKMvuFnsPlMnwLTa3GNQfDxHS3bCtOtkt73HLnv7uD+ssC74+Hat8nMBw9EnHdsITm
 S84ft/BgEQI5uJ1kMTQyTwKbX465yCDifCvuaz7HR1R+EJppz0oJ1f13aIz/S0eXFQfa27VbV
 x56rB8sl2dnviFsBbGCmwlN6F3oJ0jbsoxPrEnevCzxvgQ/lCgK2K5/1zAI1b62f2o+k/Cm0Y
 Ojk473UlEmRy0vstF+MKsLaTUstZQUFnkcfgxbk75hTm42KMpJxf8/AfpPN29lEsVvazN/1TL
 XA6p+jM90dYvjVrgM56SG6Tqi8U2++5H9KL3WWHGHySlnDM+eXMFv5Nf7Y8TyHrvUsw0WnL76
 AgfteIM2iShFGZm9ZzAtHbhGTUXlUMg2/YadbL0l5Qi1tEpYkxrg90ILL1dMR7fEp69hey9di
 u/k6QuAl16M+O/lGS58HrgbTdoUkbUx21VIEAFJ/3IPEQ=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-117966010-1716061802=:462
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 16 May 2024, Konstantin Khomoutov wrote:

> On Thu, May 16, 2024 at 01:04:35PM +0100, Kevin Gale wrote:
>
> > We are looking to embed version control features into our commercially
> > licensed proprietary product.
> >
> > We haven=E2=80=99t made a decision on which technology yet but Git wou=
ld be a
> > popular choice.
> [...]
>
> While only tangentially related, I'd point out that if your product is g=
oing
> to actually _bundle_ Git, then be prepared that it has quite a hefty set
> of dependencies, so unless you're going to rely on the target OS to prov=
ide
> them (which is, as I understand it, a no-go on Windows) you might be req=
uired
> to invest considerable effort into that endaevor.
>
> On the other hand, if it's not a shrink-wrap product but rather somethin=
g
> enterprise-y (kind of software usually installed by a dedicated technici=
an -
> as opposed to being downloaded and click-through installing by a laypers=
on),
> you might just use what Git for Windows ships, I suppose.

Git for Windows offers MinGit (for full details, see
https://github.com/git-for-windows/git/wiki/MinGit), which is a subset of
Git for Windows intended to be bundled by 3rd-party applications. That's
what Visual Studio and GitHub Desktop do.

Ciao,
Johannes

--8323328-117966010-1716061802=:462--
