Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5827452
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537235; cv=none; b=RY3Aje4cAO0yR6MPoqGw1ukF1MHGK89RkCXtva8Mf0AmDlLgHB4v3zaP6EFw4McEFXv8unHhK91LNfEkp0iAvPLgobHCeL2n71f7mavPc+VDpV+uOIVRlqUFNT36s8Ve1t4y9t76O/xg4RgN1AVXhB4fLzpZyx57ttf+bc/37Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537235; c=relaxed/simple;
	bh=Aue8xUvycYnUxOFzJpE0AvmlvC6IKTWUdiDsXZPb48Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=le+LQBUzb0tc6oxlhGsuNI5KUnXAbwGUNWwMuVaLzmrwNzyfR4fdqkB9ZbzAUe8/eP0ybmT4itDWfqeKiV1HZqSAb91tPBTDpy8yDbwok4KiWiXZCfM4yV/7eXQn1IAxx2/kjm2RAUfTnZ9oijl0pyOdmbB9n+/rcy32OvoXjY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471IXhc03503312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 18:33:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Josh Steadmon'" <steadmon@google.com>, <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>
References: <00a801dae384$de2780d0$9a768270$@nexbridge.com> <ZqtWDtqkXzjz2A8u@tanuki> <01c201dae40c$821ab5e0$865021a0$@nexbridge.com> <024601dae411$faab2cb0$f0018610$@nexbridge.com> <ZquPfiAWgYjIPGRB@tanuki> <025f01dae419$636bb790$2a4326b0$@nexbridge.com> <ZquSkkR_aw2IUdX2@ncase> <027301dae41a$41ea7ce0$c5bf76a0$@nexbridge.com> <ZquT0B-UXy73x6QI@ncase> <028501dae41b$c277ec20$4767c460$@nexbridge.com> <ZqufLYWnj75VeDXB@ncase> <02cf01dae43a$61e95a50$25bc0ef0$@nexbridge.com> <3e31de95-dab7-4552-9a39-1266879a1f86@web.de>
In-Reply-To: <3e31de95-dab7-4552-9a39-1266879a1f86@web.de>
Subject: RE: [RFC PATCH 1/3] t: import the clar unit testing framework (better one)
Date: Thu, 1 Aug 2024 14:33:37 -0400
Organization: Nexbridge Inc.
Message-ID: <02e001dae441$56c502d0$044f0870$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHOPvlDZNo/jbhsLoaIqw/awlXOYALkmT4KAVwZTGUB2+aESgLXgUnWAYAIFx0B/s5joQGBwcBKARAuUtsBb1EvmQJNHeVPAg2P/pcByqXvCrF3OELw

On Thursday, August 1, 2024 2:13 PM, Ren=C3=A9 Scharfe wrote:
>Am 01.08.24 um 19:43 schrieb rsbecker@nexbridge.com:
>>
>> I'm running the full test now and may report more or success.
>
>"make unit-tests" would suffice.

Well, that takes a whole lot less time, thanks. 100% pass after the =
prior fix was applied.

Thank you.
Randall

