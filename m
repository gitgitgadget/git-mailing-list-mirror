Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21B127B57
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610798; cv=none; b=L/V8empt4W4APre1qPWuhoxvrIHhRgyYjUYMYPOj67tvozOnwf+GESHk+V0hU2Rz6WRyr/FpCEl3xBJM6ODY1FuTtzB/yIfoIgEGZh8JDWlCPws2XzZ3VXwqQwXy0G4g8eG0KgK5CJxU2DB8/k/J5ebTFblaDw8GJyYIfqFe/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610798; c=relaxed/simple;
	bh=d4Vq1eHWSd49xpieHZFlH1hmccY3AuMIekOm+buft5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tRiJsQDklSS7q7LuMWg8ARP7JCkdloF70s0wZDp6tZTM9jv64pc5SsQcTw0qcjR0gpGIhkXHd8OT+LAiqiQj2Fzvb0bfHqworbU7CyjPYZpDd1nhZh++6N3nfe3f2TfDX1cm/Ibt7AY9Ka/VpnKYMq+vmLU15T1KnNyq36LaY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NMvgnjw7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NMvgnjw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720610792; x=1721215592;
	i=johannes.schindelin@gmx.de;
	bh=l5dZjZhCFXH97K6RgtYymevj4Z54YBuJ6AxzvUwziZ0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NMvgnjw7VDT057pYBAwhMkEeCvD9EqMznW2xq4iKwSZidHpllEajoUNJ1zpptdSO
	 G2i6kaoqvAAwVauGZV+1SEBEde5mMv4ZKknFKAp4CEduS4u+/4KMR3blNZTHLk2P9
	 av5kW4xTozLFHRU9VyY+2JfUJegTI4l1epUy821VmNC41rFXA1rUJYPBudoHpD0N/
	 dx7DgzKK+G7NwsXnA1zXIhXpN6ne0FskB5UA/su2xlfaLcJLyfow8uibyHqIUjXJ5
	 M6cDZZiJeDmAFBm05Li6gXhnfSQrVoftYwzOQAl07lFzr/8OWxirHNMSZPMLxsXoi
	 MoxxI02TzkitsgrA2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.84]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1sFQaS31jQ-00tiK0; Wed, 10
 Jul 2024 13:26:32 +0200
Date: Wed, 10 Jul 2024 13:26:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Schoonderwaldt, Michel" <michel.schoonderwaldt@sittard-geleen.nl>
cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
    "git-security@googlegroups.com" <git-security@googlegroups.com>
Subject: Re: Request to Update OpenSSH Version in Git due to Security
 Vulnerabilities (CVE-2006-5051, CVE-2024-6387
In-Reply-To: <AM9PR07MB71854BD4C1CE7E517203FFB6B1DF2@AM9PR07MB7185.eurprd07.prod.outlook.com>
Message-ID: <ffe00b81-5f19-a073-9a9e-ee84b7d3845b@gmx.de>
References: <AM9PR07MB71854BD4C1CE7E517203FFB6B1DF2@AM9PR07MB7185.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s6K2PkHB40laDXvJm6WAmZB8x2WRqLBFnO6jg2DuPUNXIMWNNmB
 ArpQdACKMLRTW4hXdxJtHVMw3L5w8ur/K5fZSSaEe8j0VqQFMGB5gdmAnWqmwyq3NrdjItG
 7kQJIgjZ72bDU7wQnUIguBJD3X9GYLTBL3UvoH9/iaDofS3ELTELfwdaCoYkPgIS/GzSOGv
 1Xz5DyGscYb1Q26/1Tkgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tJoDOdtDeZ4=;ImKAUfAprmwIA9QsYb0pxT9YPsR
 TT5gF2bepnElQLgkplyKb+cECSI5Pq7U52wjbZfhCZSUJ9S51pvZ1GyV3T40ISMtGxQqWH5Es
 YIFk04yRoisk3ckqyhDwFFrkfSW/vWvqW+m5RTUl0dCWYiRZGr6+3zYMpZzmC7NIVQSSFlnby
 OPUSd2NvRYeEZFFO/XImB4fgIsvIUl4rYmwWp7YJXqMGxiPajQp3mtWbcOa7zizi8O5Fbazmi
 xZKYWdyBaelm6f3xCiQEJwcVBmGtDfQe50/UFaedE0pM6XwZT2PfgYWPNzN4mIHDnsVqKYPiL
 3r12yR4BZhqbs6t1RXaS94GUio4KWJtq5hSTo3qPvkvpa8EORPfRkZCXgc0y9YjI8vdci5T0b
 hy8Cf1U/TR6nENXwOGzeba5WBqgErJh/dz/W6qUjWs6mlz2URUp91jv0Ih9kJ7RDfrX4E7u5g
 5zv6P+DB75o06IdNzOswZqx9T39UiEbDMRW4RY6Yc9RmD/uMXT3+OBV0Q2Wu1Dz6gtn+RXfYH
 kyMQKdqy/BypJAMCMUhP/CNK6DvpTaXRJIEcNxCReTyO04zk1nJRIk8bO/5wdYQWJ0Gl2bTyK
 WubD22UcEUNo7OKFDW+0P9c+1Y+bYpyhd9vqV5Vcb+fidbm9Qd74SpNmQMZno1WGFkGHQI+9X
 sO44FfF9BJF56wJfRNV8jRg39JspWupGyujItpOfzMMQkprzKQ8wh1asjhaXThkgg0DUNgu+m
 FZ6tmVVcP4GFLVIejyd1QiajLkc2duXbdpitPR0yZpZMq0jbGJnEbs2GtGqXE0XhTcMc7wcfT
 OpdWkKzcBuDU+tXsU8fOgIZA==
Content-Transfer-Encoding: quoted-printable

Hi Michel,

On Fri, 5 Jul 2024, 'Schoonderwaldt, Michel' via Git Security wrote:

> I am writing to bring to your attention a critical issue regarding the
> version of OpenSSH included in the Git for Windows package. Recently, a
> severe vulnerability (CVE-2024-6387) was disclosed, affecting versions
> of OpenSSH from 8.5p1 up to and including 9.7p1. This vulnerability is a
> regression of the earlier CVE-2006-5051, which was initially resolved in
> OpenSSH version 4.4p1 but reintroduced in 8.5p1.

This description, while correct, is incomplete.
https://nvd.nist.gov/vuln/detail/CVE-2024-6387 has this to say:

	A security regression (CVE-2006-5051) was discovered in OpenSSH's
	server (sshd). There is a race condition which can lead to sshd to
	handle some signals in an unsafe manner. An unauthenticated,
	remote attacker may be able to trigger it by failing to
	authenticate within a set time period.

The crucial part is the `sshd` part. Git for Windows does distribute the
`sshd.exe` binary, but it is in no way used by default, nor is there
support how to set it up to run an SSH server.

Git for Windows is therefore not affected by this vulnerability, and
therefore it is not crucial to get a new version out as quickly as
possible. See also my assessment at
https://github.com/git-for-windows/git/issues/5031#issuecomment-2199722969

I take security very seriously. In some cases that dictates that I do
_not_ rush out security bug-fix releases: Too many updates cause update
fatigue, with the counterintuitive consequence that too many security
bug-fix releases _decrease_ security. Therefore I assess carefully whether
or not any given CVE in any given component that is distributed with Git
for Windows merits an out-of-band release. The regreSSHion CVE in question
does not.

Having said that, the next official version is scheduled for July 29th (or
soon thereafter): https://gh.io/gitCal. This will contain the OpenSSH
version 9.8 that addressed that CVE.

If this is not soon enough for you, feel warmly welcome to install the
most recent snapshot from
https://wingit.blob.core.windows.net/files/index.html; Git for Windows is
kept in an always-releasable state, therefore I consider those snapshots
to be equivalent to official releases with the only exception that they do
not have an official-looking version number (and aren't announced as
prominently, either).

Ciao,
Johannes

> Given the popularity and widespread use of Git, it is crucial to ensure
> that all included components are secure and up to date. Systems using
> the affected versions of OpenSSH are at risk of exploitation, which
> could lead to unauthorized access and other serious security issues.
>
> I would like to kindly request that the OpenSSH version included in the
> Git for Windows package be updated to version 9.8/9.8p1 or higher, which
> addresses these vulnerabilities. This update will help ensure the
> security of all users who rely on Git for their development and
> operational needs.
>
> Thank you for your attention to this matter. Please let me know if there
> is any additional information you require.
>
> Met vriendelijke groet,
>
> Michel Schoonderwaldt
> Senior ICT-specialist technische applicatie- en integratiebeheer  |  Tea=
m Informatiemanagement en ICT  |  Unit ICT
> 046 477 71 96
>
> Werkdagen: maandag tot en met vrijdag, 08:30 - 17:00 uur
>
> Gemeente Sittard-Geleen  |  www.sittard-geleen.nl<http://www.sittard-gel=
een.nl/>
> Adressen en openingstijden<https://www.sittard-geleen.nl/adressen>
>
> [cid:image001.png@01DACEEF.84479400]<http://www.facebook.com/sittardgele=
en>     [cid:image002.png@01DACEEF.84479400] <https://www.instagram.com/ge=
meentesittardgeleen/>      [cid:image003.png@01DACEEF.84479400] <http://tw=
itter.com/sittardgeleen>      [cid:image004.png@01DACEEF.84479400] <https:=
//www.linkedin.com/company/sittard-geleen/>      [cid:image005.png@01DACEE=
F.84479400] <http://www.youtube.com/user/sittardgeleenonline>
>
> [cid:image006.jpg@01DACEEF.84479400]<https://www.sittard-geleen.nl/>
>
>
> --
> You received this message because you are subscribed to the Google Group=
s "Git Security" group.
> To unsubscribe from this group and stop receiving emails from it, send a=
n email to git-security+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msg=
id/git-security/AM9PR07MB71854BD4C1CE7E517203FFB6B1DF2%40AM9PR07MB7185.eur=
prd07.prod.outlook.com.
>
