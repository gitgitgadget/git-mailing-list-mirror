Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE543BBC0
	for <git@vger.kernel.org>; Wed, 15 May 2024 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751630; cv=none; b=OlOZuDatn0PlVv+I9PsrvrI/Ja6fbO8IEcylJb7BoB2RejMNcKEFwyq46JzMtETDcNsR4aUbvXQh/4ZwRe0Bzb1aB96i3csf+u/tFsdLt9l5iayLD/+pWWW3noRiwpT8IUhtedXTcZDCXOWl2JvL7CIHdRXS2TKwl5UiKntqhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751630; c=relaxed/simple;
	bh=NADWCZw5zU/fYoUyp8hM/4NAgMOJ6Q/7KrYmXQFR20w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GkTyvsNm+CkNX33D5HX9aGGV6EARZ0of/WTFoZlI5/x7v9Z4jMSM5HeBNOKBNkRvyntu14An1ouWqqjjfFaHCjmoosuMjTqkUA4ZVE92Yj8SZf8As/6U36qFpLo883e3EqpIMxh1Cw4pdS1uCdw8V/LSoCbQVS4cUxpMC77benE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=omglol.email; spf=pass smtp.mailfrom=omglol.email; dkim=pass (2048-bit key) header.d=omglol.email header.i=@omglol.email header.b=YfG/3/Qr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNik4XVD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=omglol.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omglol.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omglol.email header.i=@omglol.email header.b="YfG/3/Qr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNik4XVD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 65C101140151;
	Wed, 15 May 2024 01:40:24 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 15 May 2024 01:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omglol.email; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1715751624;
	 x=1715838024; bh=NADWCZw5zU/fYoUyp8hM/4NAgMOJ6Q/7KrYmXQFR20w=; b=
	YfG/3/QrQC5RooMj0ReVcJjwZL+d6ClNqF5cAbhDa+IF1eCKNEWJGJFRwftEVeRK
	aFuD8LohgvSK3uxXM+gcywrZx7beKoKnpWFxXtn3jd2IvuBpvYXd0HBWOVD8lwwq
	VtPbwOaGCWZ4QhRkxLD58TAiHCTunlKnjqnYPBXwWE8tQZjFxNUpZhvBDe7bbXae
	bclZ51VY25cUDZJJzeNjVzapmqe+0k5r6rKtVuA6G0DT8cr4i1phOPLRzY53JeSp
	NO8qlBZACcvYm+/JyvApW8YvkNjcN8pVvujFbHPvRiX2oZPC7jF0+Tkafp2CSnFM
	hrm5i+BS//ASrGOOj4q6LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715751624; x=
	1715838024; bh=NADWCZw5zU/fYoUyp8hM/4NAgMOJ6Q/7KrYmXQFR20w=; b=j
	Nik4XVDyB8Sf6sh2w7Ok0dQu/sQFNtMNnLj3YhLw0jeuUi3thEijw80z8a8r9T5v
	dKm0lSLXWiqgYPPxIJZ7PDQA0rkcFn/2sadtBEGJOU3cCzriTxaGvMGwyggQVK03
	91bFRon8/sHjcG03zm/jzq8VHpE3WxfqWZSCc0TY9qrmIVvCjR0bCEz/kRJSZYjM
	gaPwbPZc/JpEvlPT5RUeUmnqAOkvbi/sIF7pFPH5jza2CuUX4FaWcGg4zyjGlcJi
	ANx+PIjEijJynDKojSCqRTUi+htWuZr6CGhRGx/BCvquANkyYUfRkg3ELMR4p+oD
	mqX3d6dkmqwqBUEPxsb2A==
X-ME-Sender: <xms:yEpEZjhNLw3JDbYMUj4peyo9nwHjDQFO2Off__1nYu4KiKZbrc6URg>
    <xme:yEpEZgBNGiSrmPz3sy150nS8KBZPjPUm0bADG7x-Cky_UviSw77sct8J9asS-HRYh
    -TrwcJR1RfqWne6KQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludejmdenucfjughrpefofg
    ggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpegjohhnghhmihhnuceo
    rhgvvhhisehomhhglhholhdrvghmrghilheqnecuggftrfgrthhtvghrnhepiedvffelie
    elhfejkeelvdeuteegueeuffelhfdufffhvdffledtffffffeihedvnecuffhomhgrihhn
    pehprhhonhhouhhnshdrphgrghgvpdhrvghvihdrgiihiienucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghvihesohhmghhlohhlrdgvmhgr
    ihhl
X-ME-Proxy: <xmx:yEpEZjEhwfMpcyO-Vdu5n66C6p8ai0QOo-fT2j2n4cYZURl1I1btFQ>
    <xmx:yEpEZgSUHKkpsPWm3keXv5jGnS7p6iEd5hUuunS1q-6-SeO4agzLeA>
    <xmx:yEpEZgxiGtbaBGSD4YDhlvvMABfbVlR0nar_cSpSuqug_XRa0VoQhw>
    <xmx:yEpEZm4jSSmOwXog8uqOm7uedgbJXplfFMZCuYf6a6rEymjD5J04sA>
    <xmx:yEpEZr8k01gnPv-p1onBciNZ12UcYiwaNDAgRNFKHQCK9aqD4CEvcPxa>
Feedback-ID: ifc394682:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0900715A0092; Wed, 15 May 2024 01:40:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-455-g0aad06e44-fm-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9fd0e8d0-07c3-4461-b8c3-c2e54e27c9ce@app.fastmail.com>
In-Reply-To: <xmqq1q643whe.fsf@gitster.g>
References: <ea41a92d-35df-4b71-be70-a736d620b21f@app.fastmail.com>
 <ZkPNHqAUemfdfaFD@tapette.crustytoothpaste.net> <xmqq1q643whe.fsf@gitster.g>
Date: Wed, 15 May 2024 14:40:04 +0900
From: Yongmin <revi@omglol.email>
To: "Junio C Hamano" <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: git format-patch displays weird chars when filename includes non-ascii
 chars
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-05-15 (Wed) 06:38:21+09:00, Junio C Hamano <gitster@pobox.com> w=
rote:
>
> $ git config --global core.quotepath false

Thanks! It now works as desired.

----
revi | =EB=A0=88=EB=B9=84
- he/him <https://en.pronouns.page/@revi>
- What time is it in my timezone? <https://issuetracker.revi.xyz/u/time>
https://revi.xyz
