Received: from mut-mta1-se01b-zose1-fr.yulpa.io (mut-mta1-se01b-zose1-fr.yulpa.io [185.49.22.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CE1C683
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.49.22.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147650; cv=none; b=XuoqzmZvXn9n/TbrF8Zz0PuXA2flBTNn18CJ6Oy0iAJFA41Ifae2XJGkJ6+uJ+bMa3Ismu4I9eu2qBankaT9UsO2ZSZnNsrvqV8ZRa6kjsGClLEpDRDq0jyvigg9D3yBLyybEnhkGJf/o3V8Rwt/+K66EpsXTDP87rCs1GwqRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147650; c=relaxed/simple;
	bh=cHA1Uvk0kCy5yWiuYKro45zBSLjf7xNrMgep1W2NM0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQm33H3wvlPh9G6cqpk6mfrf7nOLaYlzvgR7T9+MiPwGtIglb13gxn6pGBtpTrKA65pU7hPiNJAmfQ4uXfKCtezZcF23UTzP90lPZhhXE9BTFAAOVbYdOFODkS+RI6NKImXc302/JINAp72s/LtCF1Mrm+rt/TxHzhl1Vxngv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthieu-moy.fr; spf=pass smtp.mailfrom=matthieu-moy.fr; arc=none smtp.client-ip=185.49.22.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthieu-moy.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthieu-moy.fr
Received: from [185.217.155.54] (helo=mut-zose1-mta-hub-outmua01b-fr.yulpa.io)
	by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <git@matthieu-moy.fr>)
	id 1rrzUo-0006lN-8J; Wed, 03 Apr 2024 14:13:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id 8D4FE101CAE;
	Wed,  3 Apr 2024 14:13:36 +0200 (CEST)
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
	by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fhkUmCm0IB0v; Wed,  3 Apr 2024 14:13:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id E3B60102639;
	Wed,  3 Apr 2024 14:13:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
	by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id inXvVEj1L9IK; Wed,  3 Apr 2024 14:13:35 +0200 (CEST)
Received: from [140.77.13.73] (dhcp-13-73.lip.ens-lyon.fr [140.77.13.73])
	(Authenticated sender: matthieu.moy@matthieu-moy.fr)
	by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTPSA id 77E5F101CAE;
	Wed,  3 Apr 2024 14:13:35 +0200 (CEST)
Message-ID: <33782130-d4d4-43e7-8688-871a1134121e@matthieu-moy.fr>
Date: Wed, 3 Apr 2024 14:13:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] git-contacts: exclude list
Content-Language: fr
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Tan <jonathantanmy@google.com>,
 Emily Shaffer <nasamuffin@google.com>, Linus Arver <linusa@google.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
 <35192e61-c442-6719-caf0-1019bf3e44c9@live.de>
 <ac044ecd116d4491b5f6cdddc0266486@SAMBXP02.univ-lyon1.fr>
From: Matthieu Moy <git@matthieu-moy.fr>
In-Reply-To: <ac044ecd116d4491b5f6cdddc0266486@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.217.155.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.217.155.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.17)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8QQH/B3OuQIEpPfEWfID2+PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w4tYDeyQr+ATJ++pkNQP0c8iPFETZ5eMMsr0ywWzsFT640
 kJdjVYU8vr3+9c6dpcf7xm4A+NIXWRNiywukHeL09RgGfxFE6nGrRgImkDzpjRwSQefu+FaiC/Ke
 C1XROysF/jXWRjNVUC1rEygcD3KOkpNnwD2KgWEOURyKYDN+u9sLILez2F5J/D63Y8IEJGbBkCbb
 W4Ro97i7oyrgtT5MQItRnAmYJ/wfcu+WErd3+v6ZM0JQVdm1T9bshXNP7sG7ACIBn7w7GQrV2hrW
 txpjU7zdyGBdP8uw7sAXM7BA6DR4pjeCzd+Wjtyz+I/MPTxM3c4PnEZ2A5fvbI3+RdTDa+caqLTo
 Hz+DHCDdG24Xy7VJDEpnrJCbyGQMPNErs933QMsI/RQMo7eRi78JI8NcOHylLosNP/1dYIrW9rho
 JjRSHmZ2NUTnI7eYqiklLnbQRWRz3HrH67WGODN+3AMqT1lSdadDG4nH0yzS4WEgsi0nKfVpZvbe
 qwgjw9+OonbERBuqSI6CydY8wXK5y1ZkMfoGuHVpDGZzQE2NuzzqxW2mwVrPlsYua4FzDkflpnP1
 LF00IQoZP9mfHdpr8xjKIAuXwpfJYHRyzuWE41Tutg4ioFOo4YAeuVhXFQRsg2fjmvts2ooxVjoU
 BkOallUb20SWxn9RMuo31giWOQo6ilarK65TLCuc9DVX6ufWdFYpOMQJvQ/Ck3iiU+4DQAj3Z9Q5
 2xUM+XTOEAQO1Cszn7aQp7HdHs8KeaZkfLaYvUDlfDWhHl7XARJRXUeRtmMWU3N31mrF7EF5ubWQ
 BNxWDlWDZOte9r/966KIlsJ6b5fauxgSaSzzLsT2Gl3xv9urkTTHwSuyD6/B6OfLbvTaVC7+CBjX
 mZZrGftrC3m+rcwckAyT0ZYq/EJYhk+JeMxBqI8wOdh9+8DuIey7mO6TX1zM/7wWYDH5ykGlJp2L
 pUtRXxKF5tPxTxfD0dMN+t5ZQk3n1BLmLfssMdoP0NHGAenUgpMf9pwlnPz9vYfDzu8mOE22hwpb
 rh0P5PyynKVB/ETTbAb6lAg37czIhgXAyTkLqx1IMZY6tduWGdf0n0VjTM5W2JiN66wyFxiZ8xrW
 woqihXNKd4m36ZeGXmSd00+MD7fzqSChs+4uwiFVOMK4zvnXMiwAhNq6UXKOjp6IS5TMxvd8NdRV
 1gKYQ/ojqltjVfgX19fzFFiCXK5SugM=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io

On 4/3/24 12:11, Matthias A=C3=9Fhauer wrote:
>=20
>=20
> On Wed, 3 Apr 2024, Matthias A=C3=9Fhauer wrote:
>=20
> After sending my previous message I've noticed that all of the etu.univ=
-lyon1.fr recipients bounced with the
> message
>=20
>> 550 5.5.0 Requested actions not taken as the mailbox is unavailable
>=20
> After running etu.univ-lyon1.fr&through a machine translation
> service it seems like that subdomain is used for mailboxes of current
> students,

Indeed. These are former students, who contributed to Git under my=20
supervision (as teacher in the same university). I don't have their=20
current email address.

> Would it make sense to have a way to teach `git-contacts` to exclude a
> user defined list of known-bad recipient adresses? This could potential=
lly
> be an extension of mailmap or a separate file.

Sounds like a good idea, yes. At least, the current thread would be a=20
good use-case for such feature.

--=20
Matthieu Moy
