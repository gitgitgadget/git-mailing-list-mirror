Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAC101F2
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="lM8uSrw2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HIYnsoGW"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121821722
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 02:01:29 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 1FFB2320046E;
	Wed,  8 Nov 2023 05:01:28 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 08 Nov 2023 05:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1699437687; x=1699524087; bh=td3lip12beuhkWoWmx0gdkkZt
	eqEm22oiQM5qZ+MKio=; b=lM8uSrw2KTbQaijndHjRHkeXPsfnR7ER7qrJjfo+h
	UXlYDEpe/EJZ42nkBX6pctNU3UTHZOqk4jZLdnQK/49WbaMU0hYB8S0lJw+jeSgw
	YVmWjbFBQor7WfRqtSwyvUKr6dBb4zSSpJRryF+YrLrjXi15CbvBiOmB6re87n5k
	8IjiP63gDlIGx0YuxckPEcjkOJcAtP9Nt03SHeNOs7N+FJ0eK3DghR+RDBYPbrS+
	MrVn+JCT8JsVsJsUnB5L0j1r2ECKLHq6Au+89NR+wiz+tAFvySgmcYyNA1Rxhn3w
	kZWsDe9NrO2nVkafPerLAedLQimfRpWVVy74NI98ygUKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699437687; x=1699524087; bh=td3lip12beuhkWoWmx0gdkkZteqEm22oiQM
	5qZ+MKio=; b=HIYnsoGWnIE+lYS59xG/Ingab/aUrB4XTKU6oRd1Mp4HEHV6o5v
	FB1DnZSSyD/kx0Can3x0nosBwxo6kytTDFvKkwwAFCjVN5EGTWFP+B0XumzSnxLz
	0HrwERzssq79bdnzP8r9jcXFTXX/l8W8ORg93aNXmhFbb9HbyK6Wa2F9X89JNzZe
	Oiw52gf4ZUOTWY8xR1tL+GJHmo+HcTszLkpTVd6MPe3ufomNOpkcTo1PzcbimQ+X
	3tyaRxxp9h2r1zRal4QN5hykdBdEzz4FKsLurVNkGzoEseBYll/txjiT3yWs5Obq
	fQJgqdAuUPfDYIHaF3Kv5qkWeK42YOvVw6w==
X-ME-Sender: <xms:d1xLZbOOvnnpUTYTDtXfRq7TneFgmpV2mqzdDd6UZNWBChUXwmr4Da8>
    <xme:d1xLZV-wURms2BBW3glm_xeXsrei5GhfAJN1_PJKrWUwDWxtqXEgb72Q3ueRfcUSi
    2dBuD5-8eTsc6BR5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:d1xLZaTKMR0zgZRAZwOrhORmBZ_o6hX67Pu2HU4uZzYrN-0V6Wp5xQ>
    <xmx:d1xLZfsLVna_PRNoZfHVwjz6aaALHsavXp17_pLvTwpH-8FVlZ8pCA>
    <xmx:d1xLZTdgDqMC-DW55CORUYui_MYvNZ8fKFYpcc2YbU-JGTn3hy4GwQ>
    <xmx:d1xLZbF7Jm6KSAKtpaIegZXE5aMSdGF9YjNebejdExNfMguSGmkSVQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4DEF815A0091; Wed,  8 Nov 2023 05:01:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <674aa6c8-ccc7-4120-a864-57cce657f6a9@app.fastmail.com>
In-Reply-To: 
 <CAFaJEquUBYUO=scjHw2qrUyP-4wZJWtdmWAtRrW0mH9x9PbZZw@mail.gmail.com>
References: 
 <88eba4146cd250fcabfb9ffa9b410ce912a82ce7.1699320362.git.gitgitgadget@gmail.com>
 <20231107192326.48296-1-oystwa@gmail.com>
 <e166abeb-3566-4acf-a252-bc493ee37f41@github.com>
 <CAFaJEquUBYUO=scjHw2qrUyP-4wZJWtdmWAtRrW0mH9x9PbZZw@mail.gmail.com>
Date: Wed, 08 Nov 2023 11:00:59 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Victoria Dye" <vdye@github.com>
Subject: Re: [PATCH 2/9] for-each-ref: clarify interaction of --omit-empty & --count
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023, at 08:53, =C3=98ystein Walle wrote:
> On Tue, 7 Nov 2023 at 20:30, Victoria Dye <vdye@github.com> wrote:
>
>> Since the interaction isn't clearly defined at the moment, we could p=
robably
>> still update it to work like you're describing here. I'm happy to dro=
p this
>> patch and implement your recommendation in a follow-up series. Let me=
 know
>> what you think!
>
> Regardless of whether the logic is changed in a follow-up series or not
> I think the current behavior is worth documenting even if it doesn't
> exist for much longer in the tree. So I am favor of having this patch =
as
> part of this series.

The funny thing though is that once it=E2=80=99s documented then you als=
o kind of
commit yourself to it, right? That it=E2=80=99s how it=E2=80=99s suppose=
d to behave.[1] If
you instead change the behavior (to the correct one) and document it in
the same series then there is no in-between time when people can claim to
rely on it via the documentation.

[1] Modulo =E2=80=9Csubject to change=E2=80=9D hedging, but it seems tha=
t even
    experimental commands who are documented as that are now resistant to
    change in practice.
