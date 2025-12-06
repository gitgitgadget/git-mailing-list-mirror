Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D527B357
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038437; cv=none; b=d341/MIG1snv+eWidNJv5rErvL7S3BSY4fhu2ZWt2PTM3+jRWueB8LgErqRvZofd5MC3msMLznsRvZw4IbLeynpk4E4igAlmyb2BzEQS4a6j17UYnBiMVdfHK+R0Q6Lj9J5B3kuquvjnbv+NrzPUn+U06q4OdHHZ1uwrGxNydOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038437; c=relaxed/simple;
	bh=YlwLPy/Fhb8SOQGbJHDU/kIvbJgP4+cDC/O2RjSsY8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z6yzxCKyhc5Pm6/bbU8bujxiKtj6aplkQXAvMTZgRtN8C6pcYsBGvqdOt1GfIV6axO0e0uF5ID5HUIRVZB6wO8LxP3eEZurwv1zNaS8vWkkcPaN4CbeoLNmGiNl4wCY2WMV4yCShBm6PDDzncxlDDPuI08x85ejQEi1AMeI8wDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DZ9lXQRm; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DZ9lXQRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765038432; x=1765643232; i=l.s.r@web.de;
	bh=GMqkbSRZluIqFknUosklTBVlOPe+F+Tvz0CC6iMmyMo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DZ9lXQRmm/NMCrcb5PMtkaU941ZAyXeuD9iz/bAkq8NX/GU0KalvsN9KHazC/lEL
	 x41yRXHoTrlVBM3Ql590J69bIADcjWysChAy/sSdGfhXmmM8RdHVhorQHHLzQyGsp
	 hYUigJGNjBgiA8V+M7CpH6iT1WDakBVx8Vi5CYHviPZjeAs2srybCRqCKig61TL7S
	 KExat+4QEXfdZYW2OP4XX8QeibSeyerdGDHrDevHGnovzYFeZEzWarJw+/xNYBHjm
	 pWR+1CkcA50lXIcHHIQ1QsLfwI8k2prUzQ5l6vh2+gD/LYobDtpb5txI9Pm8KdEL5
	 XznH7uSWWe8b+2ukiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.21.144]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MW9vU-1vZ0mY0sm2-00QlLD; Sat, 06
 Dec 2025 17:27:12 +0100
Message-ID: <be503e5e-43e7-41e3-afbe-265cd3da0636@web.de>
Date: Sat, 6 Dec 2025 17:27:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git for structured data
To: Cedric Sodhi <manday@openmail.cc>, git@vger.kernel.org
References: <aTMNdQ_NHTVPtwG8@air>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aTMNdQ_NHTVPtwG8@air>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MVowof8OX5KlJK2e86u5ZL0VUL5b1YtTvjXUYg0CGeK2Vxcn22a
 MkA2YyPp/mWk3KUxy37GXLQBaCxaVIetmXBiOUgBQsnJuJaQWoPSapqMF6l02Ma4+ONb4n8
 Tes89xKvkyleuAW1qmE1i51W3zuz0K0L6iPCb2E23JXclYzvkY+yFtk4iFzFB1jkBcc26jP
 rqalWlmV6NVDbZ2kdicYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XzFclNr+5ps=;ztvPuv3SISOvp8kkMMGF1aFS4t9
 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

On 12/5/25 5:51 PM, Cedric Sodhi wrote:
>=20
> Why can't we have structured, version controlled data?
>=20
> In recent years I've repeatedly struck cases where exactly that was
> needed. For amounts of data which are comparable to what you
> typically version with git; only structured. Without workarounds,
> either structure (table schemas) or versioning (Git) had to be
> sacrificed. Which is disappointing, in my opinion, seen how this
> only hinges on the type of source Git would have to read the data
> from.
>=20
> I'd like to ask your opinion, on what you think is the most
> promising approach to unify structure and version control with Git.
> Currently, I can think of two, kind of complementary options:
>=20
> A) Map structured data into a filesystem, possibly through FUSE,
> then version control that with Git. Pros: Can mix non-structured
> data and structured data. Cons: Expect terrible performance
>=20
> B) Abstract Git's data backend to allow Git to read directly from
> databases Pros: Perhaps reasonable performance Cons: Additional
> changes to Git would be needed to allow mixing data.
>=20
> What would you recommend?
Did you consider Data Version Control (https://dvc.org/) or Dolt
(https://github.com/dolthub/dolt)?  Not a recommendation, since I
haven't used them myself, but they match your description and call
themselves "Git for data".

Ren=C3=A9

