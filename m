Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3A3715D
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Q/Z5wyCn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+9G3ytI"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C89EDD
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:49:20 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D664E5C024D;
	Thu, 12 Oct 2023 16:49:19 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 12 Oct 2023 16:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1697143759; x=
	1697230159; bh=YjJ5IBXhG1qptjohr2kV9f0u8nkOJhiC475iqpHJL+Q=; b=Q
	/Z5wyCnhz7tQcMtCog/uun1Or4ve5nTESmPTF7urqyi3xm8DwmBqBygm0pRmz+HW
	J2YcM4CL2fDeG5zpqva9+YVK6KhwmlRx5AJopyFIycr/1skpw6JOiHP2pdMgU5jH
	ekKUG1WJQHRXg7YcOT++VsuaidbwUjyp4tV0vaR+dWR34SVzlJjKNyY535ELsj06
	jUvgjIeT1B1B8Koh+vvxiQIW4xF9fdAjYdIUl0mk4UvqdKcO1kd+wpTOrImekQ20
	Rk9J4R0fnnhDtaquZpbpGvnsb2zm2jTj4rgLx2zpuHiHNcORt0+9eiGG9lKILEf6
	xycaHb2ydNxhIDbHzAEaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1697143759; x=1697230159; bh=YjJ5IBXhG1qpt
	johr2kV9f0u8nkOJhiC475iqpHJL+Q=; b=i+9G3ytIsnm5VuWbfMrl5AX0wx2Vw
	Rzq42tXLADRe+0uJC/vRWPt0U2kAFRpqEhpHVA7Xobs6KOSsKTnDeaR3H9qnuNV7
	eYZ6PWqdU2hIXocBiiySfJP0hmUv2XTGdCr1pm0xi5MhPmnuvGzyTgDJVC8FOHbT
	iqj1pN5IaXip5SQPWlcFoBUVLIBPAyoSNR1gyaXOObjPuPnMfTIqyKCPMcZDSp5M
	Jg62inwFsxd33+MD46xlctaasLLDTNO9yrmgDMwdR289bVpNTbuK4DtmjYB45Hvy
	ndKHk7oA92GxVDZGLTo90s6fTGQoSwaYJOepQiMEykrKHu0KcY5aQqM8g==
X-ME-Sender: <xms:z1soZYiihi1l7KkvYz2mBNLyZrmUgy9wSb6jKG6TIvJOmjUJlELAydo>
    <xme:z1soZRCAr2UlvkLxlRb_jrc0IWr3CVbm5zXBEImbp3OrWOF-EiPi5jUEny_OZD7xb
    Ft4Zm5cblv_cpq3sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueekvdejffeuudegueelteeufeevhefh
    gffhjedtheeludfffeehiedvteelfffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:z1soZQE_6N4_8XP4QKnc7_K3BUBWwObfNzQYrPmizGZmh-yMwU--yg>
    <xmx:z1soZZQlTclBzMZe0TGtT4hOdeqnbtA9O79SY38yFeRwZQI2jfyKvA>
    <xmx:z1soZVy8Tz4IxHyDKvATMSkxveq-glc2oLx2_KwMzXQekNlTggpU5A>
    <xmx:z1soZTbbg93xNLHbhxYK3D2n13OFqttHOj4TdMlElSi9KGGddVu7pw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 855E715A0091; Thu, 12 Oct 2023 16:49:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <789b885d-19e6-49f9-a1b4-230a9bfa4d75@app.fastmail.com>
In-Reply-To: <xmqqlec7mvl1.fsf@gitster.g>
References: <20231012112743.2756259-1-ben.dooks@codethink.co.uk>
 <277a80c5-40c9-4f1e-a68f-96673380012b@app.fastmail.com>
 <xmqqlec7mvl1.fsf@gitster.g>
Date: Thu, 12 Oct 2023 22:48:59 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Ben Dooks" <ben.dooks@codethink.co.uk>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: add --compose-cover option
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023, at 22:31, Junio C Hamano wrote:
> Hmph, I am not sure why a format-patch user would bother with the
> "--compose-cover" option for the cover letter, to be honest.  I am a
> format-patch user and never drive it from send-email, just like the
> workflow you use, and the norm to me is to review everything, not
> just the cover letter but also the patches, in my editor session.
> You apparently do not need "--edit-patches" option to review and
> adjust as needed before sending, even though that is what you do
> already.  Why do you need a "--compose-cover" option?

The thought was to get an interactive editor session for the subject and
the message and let `format-patch` fill in the range-diff etc., but on
second thought I have to do so many edits (fix mistakes and use the cover
letter in later versions) that an interactive session would probably not
be useful for me, after all. If so I would probably need to use some tool
that makes cover-letter a first-class entity that you can edit multiple
times similar to a commit message, like `git-series` (I'm guessing that's
how it works?).

The upcoming `--description-file`[1] is probably what I'm gonna end up
using.

[1] https://lore.kernel.org/git/20230821170720.577820-1-oswald.buddenhagen@gmx.de/

-- 
Kristoffer Haugsbakk
