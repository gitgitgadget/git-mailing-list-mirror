Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150527EC74
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499960; cv=none; b=XSH2tAXvBsTZ3aKzA71KlHnT/rRDt5wHRUK2+EoAQHdpgJvqnwIjHwBrr5BkwBGHgFW+jzOiitji0V6hiwJRRyiSNJLp5WoEqbhZx1C4LS34PMxqlGJ3RK1sN0ZfREhopr1r0mGqY6I20EikH5reRpVRDjNYxypopQADhqIXLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499960; c=relaxed/simple;
	bh=Pu9AJRtMp3AN3sioMCeEAbOfAtyxdHFJjRrwkTEDih4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X7m9Nzdp/A+4eoEm63fhX9zLB1y12eVKUAdN+qjNqEqKAJTEBJAYF8H/aE+J34UCvaO52AA7hToDS7pmhMpHqBBqKuTTinF5i17tFvMAP48/Zn/BmAVuaDZt9VdZG3Y9h5T/slgGHMZ9hRCkl4RnvKK9g4B56yOTDVBF499OfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=f3DRmPLG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="f3DRmPLG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745499955; x=1746104755;
	i=johannes.schindelin@gmx.de;
	bh=4+6G+4FhuyXpU1kI3UeNnUUIzPI/Safwd4WF7AHUEJk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f3DRmPLGvs/W6NUYShQJsHk8PfGUC74ZOj78HKbw9In1vA5pDQapg7Hq0rhw9gCT
	 rDMrRLsak+tbSCVB/uQFbK8IpMKKjjDtkhVEsipImtLYqP/HE00opED/GKCx2RbOg
	 YNYOtSx7udrmYRm+2iQka8QFsvAJzpS2hrDL7/tMPJRzbw2rL+0HXI5gUCR9qLjOd
	 pxE7X1OjstB/qi+rFC7t78yeqpbPN5NBJhM5blCVP5FS98uFgPaXQHtAFMVPRmpe0
	 Yyqxo3jhzPOo3Wzf8bneBf2BsZi5wN0C5ysX3NgP0A8UhPe/elCQ+BkpDmx7OfNtB
	 EVGMssJUB6KXglGFtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.61]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1u6I7I38CU-007S6i; Thu, 24
 Apr 2025 15:05:54 +0200
Date: Thu, 24 Apr 2025 15:05:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio Luan Pereira <junioluanutfrma@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Error on using git update-git-for-windows
In-Reply-To: <CA+7SsOdTiAocj7ZTV=OVw0tyKJxZ-H+m5S8soPfFy6zW=1ddzg@mail.gmail.com>
Message-ID: <ceb84ea7-6359-63c4-e02b-418d9d313b06@gmx.de>
References: <CA+7SsOdTiAocj7ZTV=OVw0tyKJxZ-H+m5S8soPfFy6zW=1ddzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1697311051-1745499954=:6177"
X-Provags-ID: V03:K1:ESOHIha0M/i69gn9QPqZWVXlMmf20H0MOv1pQBvwrzH+ztMrubx
 rxlJvxLV84vc2ZNYCP9aQLNjiHZIy9DMm6peyIdrxtvO4hx674CLxRyODmoIUGmw0274xIx
 K9nqIu26pJJNTxprxDCobr0XgQyAmi9BKAtqZaHoNYuLbNd70vU27lUjicEDNgKoKr60Gli
 30QqdgyAViN8c1utVvGig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K3Vc48Kgj3s=;Mnk+tegY1Gv9X5eWG68svUdEbJ6
 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
 XnJz46oEEsbaQ=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1697311051-1745499954=:6177
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 9 Apr 2025, Junio Luan Pereira wrote:

> I am using git-for-windows on a windows 11 laptop with the Brazilian
> Portuguese language.
>=20
> Recently, an error occur every time I execute the git
> update-git-for-windows in the following way:
>=20
> $ git update-git-for-windows
> curl: (35) schannel: next InitializeSecurityContext failed:
> CRYPT_E_NO_REVOCATION_CHECK (0x80092012) - A fun=EF=BF=BD=EF=BF=BDo de r=
evoga=EF=BF=BD=EF=BF=BDo n=EF=BF=BDo
> p=EF=BF=BDde verificar a revoga=EF=BF=BD=EF=BF=BDo do certificado.

This command is implemented as a Unix shell script:

https://github.com/git-for-windows/build-extra/blob/HEAD/git-extra/git-upd=
ate-git-for-windows

Could you edit (in elevated mode!) the file at
`C:\Program Files\Git\mingw64\bin\git-update-git-for-windows` and add the
`--ssl-revoke-best-effort` option (for a full explanation, see
https://curl.se/docs/manpage.html#--ssl-revoke-best-effort) to the two
`curl` invocations in that script, and then try it again?

Thank you,
Johannes

>=20
> Reinstalling completely the program apparently does not work.
>=20
> Is this some kind of bug on git-for-windows? Was it reported? Should
> it be reported?
>=20
> PS: I have no knowledge of programming, developing or debugging git.
> Ask me in case more information is needed.
>=20
> Sincerely
>=20
>=20

--8323328-1697311051-1745499954=:6177--
