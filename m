Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDA1A9FBE
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147306; cv=none; b=eq2snTVJI/pAg8b3V71HJxF6asP93Ww4lEjoyMTV9SRrCAlc5ga/zmXjT2dknxng1xzjLHyKRcRbI46NU0X9Yw9UQfvFWloXYOj05378QOGHQjj/elvqFeajOEzGDbkSCYWdUzg5uFQXW9WDTvBnThMJBDDv0aGQ5qKkc3fQ2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147306; c=relaxed/simple;
	bh=zoqHT9kz5oBoHw9gt9/lYQlUtizDgx/h52NRRU/01oM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dKAteHr+ATAFBdZEcEJJlocj6CEl0+dWE1L3MfR70VdWLgUADuZs1w+AJiWinS1Q5L3lyY34pDYCnPuCscJqZijAz1mQ7hjqFUpWsP7OeSW8+inaA/yWaZYY/zKcGX2YsYbgbkyU68ByASag2k9LjLTBdgSRKRBUsJpy0IjfEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=nr402AK+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="nr402AK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758147297; x=1758752097;
	i=johannes.schindelin@gmx.de;
	bh=YMiOhkZhxiQFs0HRYgf0kfgX/PoF1qAK6OHJrjU5kqY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nr402AK+W/MmgXuXvLEjKKNYYgNgAeKk9WH+SXGPIYRBGwfIMA6YYLLQAgkn5BFa
	 BIhkFChI/G7Bf/AA4X6kmnEY6resHqsQJV9iVGW5zyPf0VGR00yQLCIVcDh/QbjHY
	 OBtayh0LSgqH/tjm3DFVw9OCHhIN/zOlqgqtIXHytX6dQwENAKpOIk8+KuesBkHji
	 /JTRbNb4fFzv/129vH1CcmGAf8F2bOQRGE9mizfps7xL06C3P6TrTZ0giGVeZpHvO
	 P5dErreHhkZeiPuNd/xo5NusZicBZNRvUDl+O4o2oKLBne8KkoIT8NQ5DHkiK3Lm5
	 kD/bqCFW2fZ/1WtqnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1vBsae2KOX-00E5AZ; Thu, 18
 Sep 2025 00:14:57 +0200
Date: Thu, 18 Sep 2025 00:14:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Greg Hurrell <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH] mailmap: consolidate multiple addresses into one
In-Reply-To: <xmqqldmubtnu.fsf@gitster.g>
Message-ID: <4d47677c-787e-59ca-84f8-5ebf59947b0c@gmx.de>
References: <pull.1966.git.1756816258606.gitgitgadget@gmail.com> <xmqqldmubtnu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-752272834-1758147297=:25409"
X-Provags-ID: V03:K1:G415Fq7Vmag7wGv6nJEJ+vuKu3GWSqINbiZurqSvrAheJ/sONug
 nyW+eQbcWPE/rw1PVvSbE7C4ZVp2gTMaeNjTvKb8/VoNHIoEolYNAFN3EBzZ+NpM6Q1N54a
 K6WhqGJPISx6DW84H0AQK91Y2AUlSfi8pjGK3yEk4OSHck6LOK4NeEvJvJZE4iMNu5N2Flk
 E5a6ftyLlF+MBkrQOpmng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s90y3pzUPVY=;s2W8gzKZS/dBBktHXOaI0Bd40Aj
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-752272834-1758147297=:25409
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 3 Sep 2025, Junio C Hamano wrote:

> "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: Greg Hurrell <greg.hurrell@datadoghq.com>
> >
> > Merges contributions made from three different addresses:
> >
> > - win@wincent.com (old address, initial contributions in 2007=E2=80=93=
2009)
> > - greg@hurrell.net (personal address matching full name, so this one i=
s
> >   the "forever" address; contributions made starting in 2018)
> > - greg.hurrell@datadoghq.com (current work address, used for recent
> >   contributions)
>=20
> Consolidating to a single "forever" address is good.
>=20
> It is a bit hard for us to convince ourselves that Wincent Colaiuta
> and Greg Hurrel are the same person, though.  The only way I can
> think of offhand is to leave this message in the mailing list
> briefly and see if a different Wincent comes and complains ;-)

I can vouch for Greg, having worked with him during our mutual time at
GitHub that I greatly enjoyed, and can say with conviction that his GitHub
handle @wincent corresponds to the name Wincent Colaiuta.

I can also guarantee that you will enjoy hearing the story behind it,
although it might require you to buy Greg/Wincent a beer or two (which I
guarantee you won't regret, either).

Ciao,
Johannes

--8323328-752272834-1758147297=:25409--
