Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3F372685
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253518; cv=none; b=I5EK7ygPUwRCLusahzJAZqCajb3xhXjYNBwFyI36TX/uWzQt+QFmbk2U4iu9UvixPvVGPK+2libgrP7bOWQl6pefqTjvI6C/QkWSFrVpj+68soXg4Zjg+oSVM5QoX1LRhij5izghE0j2mRXde4S/sphu4+CDBVenJ+lXUw186M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253518; c=relaxed/simple;
	bh=rZ8rB3QJvuuSPDOednADRYKnJ2XjKMqXaCK4T3/0EFg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ui80SkQH4xfeNlMO9efHSt8KGgIwNUc9LeZ93EjPwDj+LuEv10vrnH81TsFT3dX0yW+XbtIa1Rj5Ckcds2LUClnKkpOVw8ivMfXIZHIRDCMUcmI3P39By+ODtNO07hN5Ajb3ssth3EjucJKIcmbaM+Zj/biwuigz6IlueVa3sac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=FF0xdHeS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="FF0xdHeS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790253514; x=1790858314;
	i=johannes.schindelin@gmx.de;
	bh=rZ8rB3QJvuuSPDOednADRYKnJ2XjKMqXaCK4T3/0EFg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FF0xdHeSdDAizbCVmKAg9z4sYL7s9dq3+fLKYBYAbEDE/6MuRXpTDTYWMGIp6dzb
	 PKn9rtVcSd5nejE9s/3YVbQ0j2fmpm8okBWmU7DH+U/pb4cbkgDiYpPtM2qDauZBm
	 qHT1HULmFieMps7JbvdBZDfAKFsxQ+/rnYJ92OXvOFIISJ1dGZxTqHZtKtxbiSdeD
	 yv0MNXlcUjqDcG6IALXUlE4a0VVCi1SJtuBAWjIZ3U9IwCikZGLjbsV8jno72Snbl
	 zlzuRYTqHt1EL+Sf/DPFHw3yomnYIYJYRlmx8tcGv/NlzuyGDdE3+HpSPD8nhuD0f
	 31wp9VioQL22NIGNwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1xBMsW01XC-00AyHU; Thu, 24
 Sep 2026 14:38:34 +0200
Date: Thu, 24 Sep 2026 14:38:33 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Toon Claes <toon@iotcl.com>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Security mailing list & process, was Re: My summary of the Git
 Contributors' Summit 2026
In-Reply-To: <874ifg11zc.fsf@emacs.iotcl.com>
Message-ID: <9dd7427b-2130-a936-5a90-24f7c8fd719f@gmx.de>
References: <xmqqwlsei1pv.fsf@gitster.g> <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g> <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de> <874ifg11zc.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:rJBPuCBJ43LNZtCsBedwjkWI7WBecasdKwRwsP9KnP2OZRaO7uk
 85kKjMoroMgPOfuUCKws3umy46TG2m5LaCViV2C05UkmYy6lBzGKRwnX1zTqY1K0A9mH7O8
 u7T7FriNfCHLr+ApKo6mEZdCOyKLNIUeCADRK2c+bVhWbE5BbfZtZs3sauK7nlU09e+eaKy
 t0mn9DBFC3i0HL0HiCfkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:diHHBCGA3vs=;waEIJ6+b3Qvwwo8oJGwwBXE4YUh
 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
Content-Transfer-Encoding: quoted-printable

Hi Toon,

On Wed, 23 Sep 2026, Toon Claes wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > Security mailing list and process
> >
> > [...]
> >
> > Microsoft's release process reportedly needs about seven weeks. There
> > were no objections in the room to proceeding without waiting for that
> > schedule. (Personal note: That release process was misrepresented,
> > which is surprising
>=20
> I wouldn't say this is surprising, I think most people just don't know
> the details.
>=20
> > as I coordinated two or three Git for Windows security bugfix releases
> > _on the git-security list_ since the most recent Git security bugfix
> > release, it's always the same thing: release on a second Tuesday of
> > the month, three weeks before that the patches need to have settled,
> > everybody goes home with a dependable timeline.
>=20
> Well, thanks, that's clear.
>=20
> Personally I think we can try to follow that schedule, if possible. We
> currently have a few patches waiting for months to be released, and
> that's not because of the Git for Windows release schedule, but more
> because the lack of call to action. Those easily can get out with the
> GfW cadence.

I'm glad that you agree that Patch Tuesday isn't all _that_ much of a
friction point, this will allow some of my colleagues to relax visibly.

> [...]
>=20
> So I would like to suggest you and me collaborate closely to get a next
> security release out and then we can go from there.

Excellent! Let's continue this conversation in a more private setting ;-)

Ciao,
Johannes
