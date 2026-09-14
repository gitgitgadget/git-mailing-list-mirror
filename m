Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAF377A9D
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789363699; cv=none; b=cZb28/Ev7dUd6d+1iUMfmZSYH5wZQob12PDWpPWfBLuTZZ0g4N8vNRnM+7YEhudPlKopK5S3HIzrmPoqL0el5pwdTC6SKTvehaU8CzP/pgkMe9DvXbZL4YaysyNxCzkdhYR06h/679kqD8Rq7gItZLQsrK10mla6AGaIa8X1dLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789363699; c=relaxed/simple;
	bh=UDitv+ZcBbrrZ2gZ/d2ypW64IBXhiknWPdsaI7n6Vdo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=T80AQHKqBWv/dz6SY5UdljNgyWjxw0JXStmmdGGTWXdwVqaCCn4ugU/A7Zu9oTZTSMQLwWEp1anGmZimO97vh2sKJPSdSOJiT+7GY5rie/Gg91esWRhQiX8iw+hxbSvZRQsTDapQ0e0SQ7BVbFcJib2qFZTBya2TzrkIPEya97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=TAYh/eeF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="TAYh/eeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789363689; x=1789968489;
	i=johannes.schindelin@gmx.de;
	bh=UDitv+ZcBbrrZ2gZ/d2ypW64IBXhiknWPdsaI7n6Vdo=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TAYh/eeFVgZcQttQhcNED17hOTAaJ+EAW4fPTAb2D17CSewjStXotMq8VmUQc06K
	 ES1WXBosSdlnWETuCoEsX7UqXaKcfmdLAPjleQRaYYfaUCRHZOTsBTpGOOrywu3Xj
	 +pfN6al2tY/gCKf2IW2KbJ3I22FrtUoplr5EhBePyztRYMKfaPgA7ZTPFQXPcJwrA
	 ErocFjcmazoXHX4lAlpalN4TYDvBT0a1Oga6/+IzKfrK7jBTQNUNoAvAdPHYL/d9i
	 HV+jgiYVfPHPTPRM1CAkE5L4Bdo8xrvAC4lQua4/AFaQDS6AvAbcijt9MGrXzmgdd
	 Iz9bGyECxFm/W1DcmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpSb-1wd04n3JQP-00auDO; Mon, 14
 Sep 2026 07:28:08 +0200
Date: Mon, 14 Sep 2026 07:28:01 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: Weijie Yuan <wy@wyuan.org>, 15935225213 <15935225213@163.com>
CC: git <git@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mlJlOiBnaXTlronoo4XmiqXplJk=?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aqeBi4qFurY9Pfww@wyuan.org>
References: <abe5f52.3f36.1a09e09e7c8.Coremail.15935225213@163.com> <aqd_pkajmGGNPxnb@wyuan.org> <6f88fc6.92c3.1a09e4d1b91.Coremail.15935225213@163.com> <aqeBi4qFurY9Pfww@wyuan.org>
Message-ID: <5C238277-7E0D-4F8B-8AAD-E881B9FBAC5C@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LpuIB10NIKCoyEE6eXfR64ZdskGL4bPeK1q3utus906Hk/3yTl4
 ANSfqJyFabZLPDzESdRL5UV3f/Q3zLTXSbTzsnojUAhqBBV5JRoGR0qu/DalE5QA8XFyEex
 g4ftB83AdhvwZLa0/ufQuGw9r41g2uE7j9qStdeZKQ8xfEkaducbaL/TCo9e2cZmmpw7IRu
 iea1YkjgbTTmqnmBzZlTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3TMdTANUjCY=;CdgrOyiGOc2KFrYB28xGXLfRWlA
 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
 U=

Please understand that I don't accept bug reports via private email=2E You =
may want to open an Issue on the repository instead=2E


-------- Original Message --------
From: Weijie Yuan <wy@wyuan=2Eorg>
Sent: September 14, 2026 7:09:31 AM GMT+02:00
To: 15935225213 <15935225213@163=2Ecom>
Cc: git <git@vger=2Ekernel=2Eorg>, Johannes Schindelin <Johannes=2ESchinde=
lin@gmx=2Ede>
Subject: Re: =E5=9B=9E=E5=A4=8D=EF=BC=9ARe: git=E5=AE=89=E8=A3=85=E6=8A=A5=
=E9=94=99

On Mon, Sep 14, 2026 at 01:04:08PM +0800, 15935225213 wrote:
> git=E5=AE=89=E8=A3=85=E4=B8=8D=E4=B8=8A=E4=B9=9F=E8=83=BD=E4=BD=BF=E7=94=
=A8=E8=BF=99=E4=B8=AA=E5=91=BD=E4=BB=A4=E5=90=97

Oops, I don't know=2E But I guess you can not=2E Sorry for the useless inf=
o,
as I actually didn't use it before=2E

Hmm, should I Cc Johannes? Then I'm sorry to disturb you=2E :)

Thanks!
