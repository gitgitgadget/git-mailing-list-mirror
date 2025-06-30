Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E779D2
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309733; cv=none; b=qq2DW/U6el/sb+Brws/dhv5HT7hFZm35kcoTJx8at+P/SaVH5tbaIhSClNI/CaGhJfzQRZ8QrCHzzeHR5HYVRPJAWSEpK798/t4yWUHqCy3JAp9Wval/QCVf31LJ11stUjts8/zt8eS4dwC7OLvg9a7hQ7+54auNqjJH2/2POeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309733; c=relaxed/simple;
	bh=caJdKiNUe/LqU9FS8Br6dxqFJSDaR8iIDMXIsEHbtYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rhg3bffLicAgpyphMmpDXdsMIXUHlYkRiy/qhJOPBeLCc0au58mMABV9vPU7TTOQ1avaKs1Mp6ZC8ztMZ9USTkGo8G2nJUDGb5PZqtHjBXFhk/7RLfBmBlLXRxvTRSEEkfXCNdTJtqm5MQiNnjXw/2+SZVX6xTMIQ4dSE14MQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=dzAUN6if; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="dzAUN6if"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 4B586DF8BEB
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 20:55:21 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:1ba8:ed93:91fe:b5f0])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 5B8A9B00563;
	Mon, 30 Jun 2025 20:55:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1751309713;
	bh=caJdKiNUe/LqU9FS8Br6dxqFJSDaR8iIDMXIsEHbtYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzAUN6ifRn/2z1p8msspgqvTcCo8Q4nZvdTHfryNlxMSYRkG+Ir3CtNwRmmySvdva
	 wUtWGMQ/mysrLLYSSZgX15BYMotfvF+ImujBctuiq7yEnDFQFWrBApP83Xl0aDX2+k
	 L1+TFUTb50S9QakCzb3irPz28WM/rVRZBnysl5Q73E1SqhiSZcX4qvMzRSkt7TxmLH
	 BWe6xZBjDwPOwAke5VEEyW8bjs+v3p39/Sol75w0nxpiYRC4gAGlI5C+hr/jcg5E5U
	 yymzjZodCCN92AXocOtLO0WicsL77oRY2zchH/gNFxlRGdvt75TDDLxZ4rYSZPl/Rf
	 yGEiDRneSPDqQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org, ps@pks.im,
 shejialuo@gmail.com
Subject: Re: [PATCH] doc:git-for-each-ref: fix styling and typos
Date: Mon, 30 Jun 2025 20:55:08 +0200
Message-ID: <5900272.DvuYhMxLoT@cayenne>
In-Reply-To: <xmqqjz4t44ei.fsf@gitster.g>
References:
 <20250627074934.1761897-2-meetsoni3017@gmail.com>
 <20250629110652.123890-1-jn.avila@free.fr> <xmqqjz4t44ei.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 30 June 2025 17:48:05 CEST Junio C Hamano wrote:
> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
> > This commit fixes the synopsis syntax writing and changes the wording o=
f a
> > few descriptions to be more consistent with the rest of the documentati=
on.
> >=20
> > Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> > ---
> >=20
> >  Documentation/git-for-each-ref.adoc | 30 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 16 deletions(-)
>=20
> It is not making anything worse and all the changes I see here
> (except for a stray SP slipped in) are for the better, but it is
>=20
> curious that this stops halfway.  Things I noticed:


I was just focusing on general style and synopsis syntax as an example for =
the=20
original patch in this thread, not really trying to convert this page. I ag=
ree=20
that I should do the full monty while at it.

Will roll a V2 then.

Thanks

Jean-No=C3=ABl



