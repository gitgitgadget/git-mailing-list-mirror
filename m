Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505321172D
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705774117; cv=none; b=n4qNt8jvgDFtlShWhY9brgAxNOClHZKKs+4JKm79lzz7KYsXgX5eSFaCAjmaOs/hNgoCZCY2JzNz1EJhgwOX/oJ9AAcEl/nka4gZ0Oo6wndLDBJkCs0WhUdKxnteAFJRgXSzgbAlve/TSti+bRgNkG0Q4TVCQASByt24Uazw4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705774117; c=relaxed/simple;
	bh=PgKdMersAF9zRXuxib6Zukm8jljbvjVN2+v8/5Biou8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEK95bYq+socXPV/IZO6obvALwRe1kvIbE03DtTawSAPfOJN2XFE4+fIZXfkRiJfJ/Y8E3SoGRKha2Drutyrm4jE5o7mUGXVGLOrLu9b448LMo7FNKAytG+nNZLliXuHdhIs0BRCz6uwmC8ypuUFOzD06Eh1WbB6gbQL5HMRq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VDneC2gq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VDneC2gq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1D491DDF8E;
	Sat, 20 Jan 2024 13:08:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PgKdMersAF9z
	RXuxib6Zukm8jljbvjVN2+v8/5Biou8=; b=VDneC2gq5D2gLtbOeFEbNh5zShxb
	K419D+MUnOxEP5wB0n0SZOHykJh9Lr1Gs+6rkFmO/TuUr7HUmGDDxTyMc22OdS7o
	8Uvxz97UADXepo8kzGe+U/H7lWYwLS4hpeTfKnRF7dyPT37WP3nj9ZlTSjF7deHd
	53H85t1C55ZJqFU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A81B61DDF8C;
	Sat, 20 Jan 2024 13:08:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 180521DDF8B;
	Sat, 20 Jan 2024 13:08:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  spectral
 <spectral@google.com>,  "Konstantin Ryabitsev"
 <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] MyFirstContribution: update mailing list sub steps
In-Reply-To: <527ae359-32e7-4c49-b733-614f17876f14@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 20 Jan 2024 11:48:38 +0100")
References: <pull.1644.git.1705697955144.gitgitgadget@gmail.com>
	<20240119-flat-jellyfish-of-drizzle-b31abe@lemur>
	<xmqqmst1hsd6.fsf@gitster.g>
	<527ae359-32e7-4c49-b733-614f17876f14@app.fastmail.com>
Date: Sat, 20 Jan 2024 10:08:30 -0800
Message-ID: <xmqq7ck3g9nl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EBB3DA7E-B7BE-11EE-97F2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> Just curious. What=E2=80=99s the difference between `Reported-by` and
> `Noticed-by`? `Reported-by` is documented in `SubmittingPatches` but no=
t
> the other one. Is perhaps `Reported-by` specifically meant for bug
> reports?

It should be reported-by as the recent trend is to dedup similar
ones without much meaningful distinction and stick to those that are
listed in the document.  It was just me being careless and picked
one that used to be relatively common without even thinking:

 $ git rev-list --since 1.year --grep=3DNoticed-by: --count master
 2
 $ git rev-list --since 1.year --grep=3DReported-by: --count master
 54

 $ git rev-list --since 5.year --until 4.year --grep=3DNoticed-by: --coun=
t master
 4
 $ git rev-list --since 5.year --until 4.year --grep=3DReported-by: --cou=
nt master
 102

 $ git rev-list --since 10.year --until 9.year --grep=3DNoticed-by: --cou=
nt master
 12
 $ git rev-list --since 10.year --until 9.year --grep=3DReported-by: --co=
unt master
 54

There probably is a subtle difference perceived between the two by
those who used noticed-by over the years and I think you guessed
their intention right.
