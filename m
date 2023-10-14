Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E215B8
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="o9Ear3wG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uPo0rkph"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343EC9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 07:56:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 87C203200923;
	Sat, 14 Oct 2023 10:56:36 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 14 Oct 2023 10:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1697295396; x=1697381796; bh=2Tz7Nzpfdr6zNEyqdyn0dFmoe
	f3o58HNo9xWcAt3OGY=; b=o9Ear3wGbsQtIaXFMI7M+TSwBT/vo98CDAAQOocni
	UcZqD+lC7ELUv1DSdi56gFNtda8XucFbpYKdJDLODGHmUW8RfNiDa62+tfoFJXCn
	ELcAxYkwzt/1ZW4ByWHXpCjLkzTWJRINQbtseTsWoElMbr4GAGekItaSVfb0xihl
	Efh+qmFt9azfi15MaHI+897PAq5eSMAnKycuZ4rco9abZKj9RTgRnqG7MkTLRZhv
	zix9HJ1a0PFxevMamKGk+O0Wcwrvly8oTAKX+fSQIWPYwOu4pATgb7DtJoS0txSz
	a/sFXM9BvcS3vK56KWVX8XJ4IXSHVmrf3pe7I8v/M3szg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697295396; x=1697381796; bh=2Tz7Nzpfdr6zNEyqdyn0dFmoef3o58HNo9x
	WcAt3OGY=; b=uPo0rkph28SubQ5PLbUBeNA/FvF/zauJ8DC5rZ1U84MrhviSjMd
	kj6mp50TppxZLr7LCfCxvxbV2M/qtsFsGhPF4hUe7LroEltL3kDVUyKaEpSf22WR
	Jcs8ltXesS8yUCSZMRoYMa9gWSAG8MGO8llj4UyGhu5wjkf2tNSbzp9j7+enlQfu
	Ak3agQHBQlSPT5MUyAGjCLjtmVXSHrk4ptYuon+U/5cQEdJ7eWM1k52SaYtye8rF
	SssVB2GZa0sP80aSF5xdsB1i/lvfGUIP7tdxWgLH3/RjVUaf1nDGJEUEnWMnhDJ2
	LMyjjUxRYZTWgMiyyrNh6yAlHHpwxciTkPQ==
X-ME-Sender: <xms:I6wqZefLZ5q974-9DCeC0CbMiRwBtD8ZHgpJoR47m5H8UK5hXZCtaYY>
    <xme:I6wqZYN3TZId0pLkYvOTTwtfucpq3OMzt2zfMjl2sALfiwEHYI_eRHK5pnnjQ0msH
    ksLzZONmFPCj3YE6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:I6wqZfjsf6JGhL279vvkjU0EODd_pYNFo5p4CeuGqjqbiA30Fzbqdg>
    <xmx:I6wqZb8h4uizx3fY2EXSsiF8OSbNk8sivBZ3bjLUMZryRbdrkOiGHg>
    <xmx:I6wqZau88Uw61diHP98OzGIm9-8w5uu0NwLq4lyydvWw-_RW0HAe9w>
    <xmx:JKwqZfUFDhUnD_8LwzPsjL6_o84xjaUKCowNoSte7z67ApUEuTX1kQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C8AA615A0091; Sat, 14 Oct 2023 10:56:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cfc411f9-26b4-4af2-8c50-29fbe3dcbe43@app.fastmail.com>
In-Reply-To: <20231014135302.13095-1-martin.agren@gmail.com>
References: 
 <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
 <20231014135302.13095-1-martin.agren@gmail.com>
Date: Sat, 14 Oct 2023 16:56:02 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org, "Victoria Dye" <vdye@github.com>,
 "ks1322 ks1322" <ks1322@gmail.com>
Subject: Re: [PATCH] diagnose: require repository
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023, at 15:53, Martin =C3=85gren wrote:
> Switch from the gentle setup to requiring a git directory. Without a g=
it
> repo, there isn't really much to diagnose.

This patch works for me. Thanks.

--=20
Kristoffer Haugsbakk
