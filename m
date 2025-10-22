Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986E346785
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137953; cv=none; b=ZW/JUxXIj1sU+5wPvH0c9Ynl2ywzW5q9tDZMTvU09xv/+6S2RfuKrsq75Zeaa5cC0lvCpVozoe5zf+mOnosnHVTBGscuhCaYxWUau8oRaelCCrBJlU1bL4+3AH/PMtmMuzH6yIX2nG62hSqBAyQCcFzaaXlKas+h3kW81iCXRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137953; c=relaxed/simple;
	bh=f5rN5NHNDimU7uC1lKJrVYvnFVX0tmONJNLuKuXbTkg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Bm4KIa4nv07qIws4UZ/3KahpTCDD7zOc75JKffzKisxCeL5QXrP49CbYoL99s63NqEONh754DtcNlk54eFTcXaCcci4/FouY+WU4Us/M6OQ/MJU4lpFdlkrBQgDeMU30vKo5TWDoHs5gUKmfBKP3IFtoQ+rr5++jkZqTUbViD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nSuHxt44; arc=none smtp.client-ip=79.135.106.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nSuHxt44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3lbeloirp5fljbe3mns2fzpfci.protonmail; t=1761137940; x=1761397140;
	bh=f5rN5NHNDimU7uC1lKJrVYvnFVX0tmONJNLuKuXbTkg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nSuHxt44pbLSBmZQKfdgLscWoDvE2sipypbcdLxP2gZHOA0jBq6cvIF0HMo6Z7eo5
	 OkE9O99/iOjtRxGQRqLlZXfM5ABrbWMZptlY5+rS/jZyZopnPXFRjRyt/bN9A5hzmP
	 uJwTMw0+LuHPOXgacBTsLbWCBXjr5EvK+9zZGcCMC8RqaUSFjKeSTw+9mVNBFCBT9k
	 zuE7ZwuUbE4w4B4xLbbPvYiwi8HUB4Zw6AMifDy1OW7+9IRTRJm+XZ5nF9NF+HiJ4Q
	 eVPCZvwzHY5D8r45M3L/Sm7kwtlwN/a+cLdtv/V79TukeRk8QSL/smFb2bNcCCcck9
	 6dDeSYnaVKaCw==
Date: Wed, 22 Oct 2025 12:58:57 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: keita <rudykeita@proton.me>
Subject: [Outreachy] - Introduction from Songiso Cooper Lyambai
Message-ID: <qfk3kkkQIl1s1WTDnWwPOPKxTGHX9wBAj6zycrehEuyR8Zc43JjAe58dOFZFUTvaxCvUJ6MfEC_v9wfYpT95l70ZJUP_iusET00lBy1Ipio=@proton.me>
Feedback-ID: 145215173:user:proton
X-Pm-Message-ID: 4667216a516d551ba36f77274924578072209169
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Git Mentors(Christian Couder, Usman Akinyemi),

My name is Songiso and I am reaching out as an applicant for
the current Outreachy internship round.
I am eager to contribute to the core project. My primary coding experience =
is in C and Python. I am also
familiar with Shell, and I am comfortable setting up the Git source
code and building/testing it locally.

I look forward to interacting with the community.

Best regards,
Songiso
