Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FB3161BE;
	Wed, 11 Feb 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797774; cv=none; b=gsXkh+0xe/9gtIDR6M1Jf51N6PC9spPQQLAvU62rGYiXiAvUGPb1xYjn+F8NfT3ior1BC48JpKqM42uKN0BpRrqFOr46zNA0wR58v/TNK25VvTr6vGnSLA1TmnULEZEyIGJ+TvuGLFH7zigAmu553IPlcZw5bqY0sJihjUmafb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797774; c=relaxed/simple;
	bh=inMVqC2Az7YfiQZF/6D1rYdnBoNXLatbqjhRe+GWJ8Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IlHLSU22G9XIB4kjPRzycD85jJHmL2abro0biDjElSMsqPUky+OdTgUwMvQ0eRKjkfq07zj75Hd6A95q9Kx6Gq8k0lEes4bYlAaO6SfS/HcENNw95Pi7uzWLvflRvlb0ccj8alPTEaNuCWrKpvR+6Xpe9581LdreG29ADmBfduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nGQFJYXS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nhQOS7t3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nGQFJYXS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nhQOS7t3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FB8814001B3;
	Wed, 11 Feb 2026 03:16:12 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 03:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770797772;
	 x=1770884172; bh=inMVqC2Az7YfiQZF/6D1rYdnBoNXLatbqjhRe+GWJ8Y=; b=
	nGQFJYXSB68it2L70Y9HxaKeF/Pu/xDXxoZmY+aT/PbYXngsFD9y0m3PwqTI+wI2
	o6Kb374Qf/yecR6rayC3lc8eQBi71l7rsnZ2XWkXl3WZAG2U+ALyUZZ0akidKBpT
	ggnKL8knS9n11tmCEIQhLZ7NOtl5TFkUFaROPdj/GkiKcAkULWAitq5OOowTR2/9
	IqAQcER4HAB2BdWKhpFOZGtDlU9qgRxHisp9vptNO5lCv+P7BS7Sv08fa6HBAqk+
	94SESh1rBnLr3hVX+7VthTAGrHVWC1Ky16j+7DECzyF0ji2Wmj/MorkqF0HXijel
	wn2nW5EYIgQNfzK3uYvrQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770797772; x=
	1770884172; bh=inMVqC2Az7YfiQZF/6D1rYdnBoNXLatbqjhRe+GWJ8Y=; b=n
	hQOS7t3DucW3BIFZyl4cV9yvO/P6rDrSOoBrnC2FX/ZWhPmrje1aDC+CnHrzgGvL
	/3fbMqzGczIpOYujAc8/aKum+Qr+XIsOvwdKi0aeei1lHYj1h4vqSY3Bpn9BIGLi
	d1xAHxC5PQuKiQmcDmUB7i5Oqnf1aTvYOPdwcsax406zmv7m5bVjG43BxQGuLakj
	YBk6ilQicRPNdiAgMxQgE47OvaspgtUSRXFgcqk9/MvEKPEIAVD4HR5uxltcSOpz
	X8q/3kxhFwZ+GQ+i3H450iWhNPGqzCoy+JBUBVB8LB1ovrHqxsrF35aCkChR8T+H
	DmyD++49Fvaw5F94rIh+w==
X-ME-Sender: <xms:yzqMadousUIM0-Zy52rFJOFx5F26EbQoW8A9mT-_Wi96Y2MpW-wTGNg>
    <xme:yzqMaaeiD64ThEBpOHQz2KGIW16nvLLc68dHUx0tuDvAak45Ba_jOMSf4nzf7GXwI
    r5-JZfW36SsPriSWOl0r-ozMKI47aigBE1W8AnLSXBonXaKeBLBqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeel
    uefgleetffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrsghijhgrtgiilhgvfigvlhhi
    sehnrggsihhjrggtiihlvgifvghlihdrgiihiidprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhmrghnsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zDqMae0ovJLkWj-xV92Kf8_7-xWstg1aNQGJFm7f-Jy_8ewKdIt25w>
    <xmx:zDqMaaC0Wsv2YeJ9xa8qL-TZloWnQfn3Ml_OKl06-5fbKiTmiDlvCA>
    <xmx:zDqMaSfwn62qTIrRUhHKZ9upyaJ-h78gnI2_TPQ-land4cKXnSaVpw>
    <xmx:zDqMaf6LQcz6VNjhaf7xtBjHNb6RkjwbQXWalTv4gLvxCYaUX4zKsQ>
    <xmx:zDqMaQn9KSaW3NOyH9NuPTNhy-4d56iqhh4cHrMLWW3X5gus0yzr9FCA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CC7EE1EA006B; Wed, 11 Feb 2026 03:16:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsV1kM-kUU5c
Date: Wed, 11 Feb 2026 09:15:51 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: "Alejandro Colomar" <alx@kernel.org>, git@vger.kernel.org,
 =?UTF-8?Q?=D0=BD=D0=B0=D0=B1?= <nabijaczleweli@nabijaczleweli.xyz>,
 linux-man@vger.kernel.org
Message-Id: <a9602602-5fea-40c0-a505-34133ed4d58c@app.fastmail.com>
In-Reply-To: <20260211073553.GA1867915@coredump.intra.peff.net>
References: 
 <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
 <aYtAknObJpjszCaj@devuan>
 <55bd6ad3-cd19-4839-a808-eceae802d3c8@app.fastmail.com>
 <20260211073553.GA1867915@coredump.intra.peff.net>
Subject: Re: [PATCH v2] futex_waitv.2: new page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 11, 2026, at 08:35, Jeff King wrote:
>>[snip]
>
> Kristoffer, do you want to produce a patch to fix the code? I feel like
> finding it was 99% of the work. ;)

Sure, I want to take a look at it. :)
