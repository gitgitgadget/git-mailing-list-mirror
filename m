Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C21CD16
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="YN/D3Qku";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sqnkt2bm"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 0E91C3200AEA;
	Tue, 16 Jan 2024 11:51:57 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 16 Jan 2024 11:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705423917; x=1705510317; bh=0DfHQsOi2xiG4VA9oH0q2E0oQ0sPg3k8
	SDVMhos3s5I=; b=YN/D3QkuhYRRREN5E7XbQUG5l7JjY9jQnVQlZxQtYBxNWSgP
	ek9JpCWbPNNsXcEWP3Wfy9C0k2VjMv6AQXz21sbyEfVKzWFPPTy5P3Ne4Rm749sF
	CWpPLMoX4nJIBi3UuYzS2n8q3gphB4O+11fIC1r8+EPDyfN5LLoQeSfbOjXqm6GI
	crGDs890m5/cnf3vSFWmPDwj0A1ZY51NgDrZQQ2Xmut0UwcKyx9LO5PyjmTdxWiO
	oN0F/L01/wQiUFcgSMCBHkEH6bWERCA4VxZn5U/LIsTqoP4x5TMjRWkfVHepOqR2
	ucpDIuo62fLD2G2vLcsyfSzSTdelfW1+OlApnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705423917; x=
	1705510317; bh=0DfHQsOi2xiG4VA9oH0q2E0oQ0sPg3k8SDVMhos3s5I=; b=S
	qnkt2bmaENHpMPhKKw5+TMGAnuH/KsM7Y9h8NroerrIOKdNithSZVlZ1MtIXYYKS
	g/Wx6ObE5GoKm7eggYSnFurQtWCd3EkdSysGc6jCsb9IWauFvl6kGAab1+SIl+AJ
	OaVxQTQIH1O1xgBJUYTkrSoixTU3p8VRPE8ACYoU/KtTGTer/6KNbZu7nIEMpoZi
	IfgSennL+2lfnn6JEYosZ4BeS4/GmXMB/8Hf7kVYs4VsilOQFUHXq+YDxMwzuVCH
	+UHF23T6V5WDrj3WLvNojE1ddfVXk1e70I05j/LllhR6QkB60kSX2UiFKdLlI4r9
	3NZcOqPX4PIjI4FKPYVZw==
X-ME-Sender: <xms:LbSmZWH8nmXJ7_JNSvhTmrTTuowUVPXAZ4XNFP0mBpE5_l9EKnDRmS8>
    <xme:LbSmZXW30ipyy-1CFZcBFcg8c2ieaV-qMNPPD9LU4er35Pkf86k5Qv87Jfc4cq6AX
    N5EdO9orFGrRRAY6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:LbSmZQKTxxkQGIb0bV7gdRBz3FrrK-f0COuEFxNINqXkL3R7EwSctA>
    <xmx:LbSmZQHQyM5vZVPyxqc_PZ4B-bjklNoEfD7KEh6ENz0lv5k51Er22g>
    <xmx:LbSmZcU6kVFcXoqjm1Qyjvrk0F-1e3b72WfwKZoT8exgVvff5HqDLQ>
    <xmx:LbSmZfCDyAOXuvUuabACOXCWRwUKzYXzlTxD74_b14k-JWnWvE8AMA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2CB9215A0092; Tue, 16 Jan 2024 11:51:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b491d954-b1a4-4000-95fb-fc83bf815edc@app.fastmail.com>
In-Reply-To: <20240116141842.193151-1-nik.borisov@suse.com>
References: <20240116141842.193151-1-nik.borisov@suse.com>
Date: Tue, 16 Jan 2024 17:50:56 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Nikolay Borisov" <nik.borisov@suse.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rebase: Fix documentation about used shell in -x
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

Some nitpicks since it seems like there will be another round (v2):

> rebase: Fix documentation about used shell in -x

Lower-case =E2=80=9Cfix=E2=80=9D is more conventional.[1]

> SHELL_PATH constant at build time. This erroneous statement in the
> documentation sent me on a 10 minute wild goose chase wondering why my
> $SHELL was pointing to /bin/bash and my /bin/sh to dash and git was
> using dash and not bash.

I think anecdotes are not kept in the commit message, usually? Often they
are put after the three-hyphen/three-dash line. But I didn=E2=80=99t man=
age to
find any email that says that.

    The shell used when using the -x option is the one pointed to by the
    SHELL_PATH constant at build time.

    Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
    ---
      This erroneous statement in the documentation sent me on a 10 minu=
te
      wild goose chase wondering why my $SHELL was pointing to /bin/bash=
 and
      my /bin/sh to dash and git was using dash and not bash.

     Documentation/git-rebase.txt | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)

=E2=80=A0 1: SubmittingPatches:

  =E2=80=9C [[summary-section]]
    The title sentence after the "area:" prefix omits the full stop at t=
he
    end, and its first word is not capitalized (the omission
    of capitalization applies only to the word after the "area:"
    prefix of the title)

--=20
Kristoffer Haugsbakk
