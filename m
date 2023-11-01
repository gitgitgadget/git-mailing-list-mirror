Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A9101C0
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="c2YNtoSC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rVL0d8ES"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC581139
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 03:10:00 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 198CA32009BF;
	Wed,  1 Nov 2023 06:09:57 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 01 Nov 2023 06:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1698833396; x=1698919796; bh=YKEorfH6aSAdWaACTFNwwEKHM
	NIW+NhFt9GEeGiQOhc=; b=c2YNtoSCDHi8eCES9KID0X7luFozDFb1wctYQ5xl9
	cRKEffVzkXzhcRBmiXZ//4lDvoZdclcR2oLP5M2wh88yCiC/FO6cynTHlla3bZNp
	oRzpCZLhnvt92FivebbKZiSyS5dcoLSqQRUxN/qTn9COKcgoeN8fdo+/2BYAvTgg
	kcofxSmxqsG9j7ujdtzZoA5jPzzy93Y3Gj7i1QVNlwEu7LBfdiuzR9cdc+o9CapP
	mGUWzrtZ972+FFZ4vVrmyHcWjq0pPugw1P4JA7MUnmfbU5TzCvyPO1Lc16m0vDAE
	frxyuOg7rwEfLOIcMn49M/wLCqW6LuqrxYHWbl+p6BQUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698833396; x=1698919796; bh=YKEorfH6aSAdWaACTFNwwEKHMNIW+NhFt9G
	EeGiQOhc=; b=rVL0d8ES3wPxtEVKuTWLgmMCYZ5mJTiRnNXv7XN4kFydWlWdveI
	BOmDEBIxwThCTJGecJWDigl5PuwGff2DxQLBnqRvEoQpe3TBrxpmZNze4R9bOBqQ
	X0hP71KSwrvMBx2SyeRVSsrOE+9qMChKkrlz84NEzi3R+KDG70w2fQ+utmeTL51W
	3waZR2ccDRC2SfRUAevDYnvdz4aJlsCXp1HiC9lnQYxjgIZ4om3knE3G0fMCE9UG
	ZAkE5FYi29vLjuyqbpGQbID6uEtLSG2E6f9mZ64PjXKZ6hKbgYbGSmoaSG4ezx/I
	i84d1DlVZo2QGFq8U2Y01K298ODyMe4P7ig==
X-ME-Sender: <xms:9CNCZbWPLi8BRgNhw6PKmXoUJjKraBv-oZBioWmjV0mRLjvzzEXTfWA>
    <xme:9CNCZTnqwaQ1JDLNYqlLJja4rvkLfrcX-nrl2HnYiWA-vjPMCRPqHj42US5pZ5FR4
    sSlknrhGKq8QhWs1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:9CNCZXZI7LCiT_Orqd2hhv6mGWROXRFcqx5X51FcLVfIBmsl3hIE0A>
    <xmx:9CNCZWVKYAN2g8AqMqtteyKgaaTrdsk5IY-Bu47aa_Kq_or8U3nhmA>
    <xmx:9CNCZVkvNloH-4bH4nQT1SBrmyImsdgts7Snm8CCgwFJpmSFFTgedw>
    <xmx:9CNCZaxuDCSVG1GabsI9ZfvJ1eTTp2l79JmshNB6_sA7EPHio5PcAg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2B5CB15A0093; Wed,  1 Nov 2023 06:09:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a457e24c-3375-49c6-8cf7-d2dd945827fe@app.fastmail.com>
In-Reply-To: <xmqqa5ryxn8i.fsf@gitster.g>
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
 <ZUALkdSJZ70+KBYq@nand.local> <xmqq1qdb8wzk.fsf@gitster.g>
 <cb166ed4-b8b5-4120-b546-e878445573b6@app.fastmail.com>
 <xmqqa5ryxn8i.fsf@gitster.g>
Date: Wed, 01 Nov 2023 11:09:34 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Ruslan Yakauleu" <ruslan.yakauleu@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023, at 02:42, Junio C Hamano wrote:
> Strictly speaking, the log message on a merge commit serves two
> purposes, one is to summarize commit(s) on the side branch that gets
> merged with the merge, and as you said above, it is not needed when
> merging a topic with just one commit.  But the other is to justify
> why the topic suits the objective of the line of history (which is
> needed even when merging a single commit topic---imagine a commit
> that is not incorrect per-se.  It may or may not be suitable for the
> maintenance track, and a merge commit of such a commit into the
> track can explain if/how the commit being merged is maint-worthy).

Yes. If you have multiple release/maintenance branches which you need to
apply something to then you can=E2=80=99t use this .

>> The point at which you use such a merge feature is when you are alrea=
dy
>> happy with the pull request (or patch series or whatever else). And t=
hen
>> you (according to this strategy) prefer to avoid merge commits for
>> single-commit pull requests.
>
> But that argues against the "--ff-one-only" option, doesn't it?
>
> If you looked at the side branch before you decide to merge it, you
> know if the topic has only one commit (in which case you decide not
> to use "--no-ff"), or if the topic consists of multiple commits (in
> which case you decide to use "--no-ff").  And the only effect to
> have the "--ff-one-only" option is to allow you *not* to look at
> what is on the side branch.

No. The only effect is that you streamline the process of =E2=80=9Cdecid=
e not to
use `--no-ff`=E2=80=9D since the strategy does it for you.

It would act like a small `git my-merge` alias. That is all.

--=20
Kristoffer Haugsbakk
