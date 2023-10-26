Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5E8813
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="cuuLcum5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R3gFFppc"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73021A6
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 05:29:04 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 84AAF5C0275;
	Thu, 26 Oct 2023 08:29:01 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 26 Oct 2023 08:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1698323341; x=1698409741; bh=KDvjjK8I4+LsLipxYRrxHbBRD
	POOWtxfgHRmr0+YNZQ=; b=cuuLcum5uFcZJlEsdRZ/DWY+fnT/+hAz3vsEesIjc
	gCcZMjYkUQhFz9OXQrzU51DwahQrGyerz6mI/SYsDiXa/kDima8nVIm6iWF879n4
	gxWaS/BFn/EIfzwozrNFTlbCCu6UnKSoXueWofQ7kXdGpt0pCWPjPTZMuSV9vHr6
	zIHK1FuDdqBd0q1Fb5yM+1e8b8PxTMnsrMv9zyCak4mgq97ZOH00yoh2L5Hg9D82
	nYF9ayvROGCAgYab2ZDX0kauXSr0kheKNyWmYFNbmMp8dEQQj5Zf6HWxNVpuK9OS
	2dFJz0Yq30uDZoYBj9gBCFQ02+RMHIId/3WJVtjcQPmow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698323341; x=1698409741; bh=KDvjjK8I4+LsLipxYRrxHbBRDPOOWtxfgHR
	mr0+YNZQ=; b=R3gFFppcOXfIkCYx/D68FKY1n1nqnPDv/LjTJZRV9b7Y28KXaos
	r77IzsxbVth21h5WS6kKAkqRAzdoxelE+pzQh9lVy81H+7J2Rk2nLBriGATzyM0K
	qqYa/svHQip3pYD7xFke0ztm7XeoTd2ipjxtIVm5LlzRKwevk6NF66376xBVuK0r
	WRR+PwG9rAgoO5Yf4R/4Lmhyw1P4CSwI7tnVxJw6Xsg6YwoVhK3i5AI6g/WUZWF6
	9KmSgbLdBKAf3xm0AdJob2hEAnJmhF0PyBZXIak6tmflPmvD8fiU84TCKsWhlN4x
	4+pMe42hG75pqqKLUpmcyUf1BtI8sXSG5oQ==
X-ME-Sender: <xms:jVs6ZcA-_njucGzBoNonyJPokjLQE5LL7KbQ66UwiNH3yVf9QfAdL7c>
    <xme:jVs6ZehTl5FlRswACCnhcV6Q5eAPUnwlYmrUeuaU4bYDWla31vbh3lDlGWdTYvGuR
    0V9orc-ErbVoNccqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkeduvedthfelueevheffhedvveeiueeiheehudehveegueetteduuddtfeelueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:jVs6ZfmBEXTfAO9ZqggwdIBupDWGxzMdMuKIyTEI1ZCCL5Wfgqd4ZA>
    <xmx:jVs6ZSx5qSr9tKRRWnF8f3XZ8n6pZP9VPoAtqNeb7DV33pW8FPDI-w>
    <xmx:jVs6ZRTk2YVDPr0aTTKgYKMbEEhT7DSOsAVpLmEHsTtcFgiqHokmuw>
    <xmx:jVs6ZcMb62mSAHQJD6xZRO9ZHyqNcusifT53Pn141HDU8IerFL_gVw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3A29915A0091; Thu, 26 Oct 2023 08:29:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3136992f-15f7-4927-83d0-7b7f985244b5@app.fastmail.com>
In-Reply-To: <Nhfa-Qv--F-9@tutanota.com>
References: <Nhfa-Qv--F-9@tutanota.com>
Date: Thu, 26 Oct 2023 14:28:17 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: triallax@tutanota.com
Cc: Git <git@vger.kernel.org>
Subject: Re: git grep --no-index fails when given an absolute path
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 26, 2023, at 12:46, triallax@tutanota.com wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issu=
e)
> - Run `git grep --no-index -r -- -- /usr/share/fish/completions/`

See this thread: https://lore.kernel.org/git/CAKFQ_Q_P4HvCMHsg4=3D6ycb8r=
44qprhRCGSmLQf7B3_-zy28_oQ@mail.gmail.com/

> What did you expect to happen? (Expected behavior)
>
> The command executes the search successfully.
>
> What happened instead? (Actual behavior)
>
> This happens:
>
> triallax@satoru ~> git grep --no-index -r -- --=20
> /usr/share/fish/completions/
> BUG: environment.c:213: git environment hasn't been setup
> fish: Job 1, 'git grep --no-index -r -- -- /u=E2=80=A6' terminated by =
signal=20
> SIGABRT (Abort)
>
> What's different between what you expected and what actually happened?
>
> One of them is an error, and the other is a successful execution.
>
> Anything else you want to add:
>
> Interestingly enough, this seems to be happening only with absolute pa=
ths from
> my testing, and it happens even when the directory that's passed is a =
Git repo.

What is the working directory that you are in? I=E2=80=99m guessing some=
where in
your home directory?

I=E2=80=99ll try to reproduce your command later with the proposed fix.

Kristoffer
