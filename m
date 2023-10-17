Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3E16403
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="T7UfoMeW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hsbew0qz"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50462A2
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 03:51:25 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E85C65C020D;
	Tue, 17 Oct 2023 06:51:21 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 17 Oct 2023 06:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1697539881; x=1697626281; bh=XUMNhF/HfjRbGkvS1kHMAbHFo
	w8nESA2ZT8vApaIRD8=; b=T7UfoMeWOvOm/WHTpOU7Y+TI61jeR2bwMP+YkrzEE
	y9P6McuLTJ5RyUb2Y/zTItCNdu+fl56VUp+SPqbAN5Ut5hsbhDg9Pvu/HrnjxcwE
	ICSVC4bq0IPUNicN20gAtwmE1G5hNDNuPWSu9MscHro2WkRpN+xcIUObx+Ygm1M2
	A2RuMF/d5VmqxhxqrLBjsVSvGA1Nqf0p4dF1bC8vYcm9jhhhrBQwYWP17AjZRMLL
	0LWMzwxXwCPVazMVnvV6HI97Wao5PGlGBe2m9X+sFUYxzqV9Xd+JV7xrwxJl6jgA
	7pn3UVHtdERr4tghBeFBBXIm23WSF0RjoXBbAbOC62coQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697539881; x=1697626281; bh=XUMNhF/HfjRbGkvS1kHMAbHFow8nESA2ZT8
	vApaIRD8=; b=Hsbew0qzszjvdFi117b6gFoWhBL9zLiB0XEMISfPaZJIvDKNioz
	9Gnm57goOpLMfjRw6zKQ1fXt4XkUG9kllPIl2Jh7OIjeRJx9x6la2Ky29l4v+0Kn
	4VBfwUqOrVCi53t/Xvo/eZKTucGidBExY7yXlDygoOuyAzRwYSJGEdwARNu29nVX
	jGfR+YF5wIZKyyvcCMYllHS4+zU6zpXD/Lm+LtBx41vF66oUiKEpJMLgtPfbEybJ
	EY+WFzaIbxxVu074vhunrMEx1OqSw7+JXzgGWqlAF7UhQRarKk4yblhQ6lCjl5Yd
	3PUAx/rV4yyoltRbV5jnomSNhT28sPZD7ZQ==
X-ME-Sender: <xms:KWcuZWNGapAlpjmd9WZMnHCbJvns5t0tnj-6wZcREXqEiqbUlfpe5A4>
    <xme:KWcuZU8Gt_3ZvDUMPz_xnWA1RbwhthS0WKLrOFSE4zIRF3wk4X6muUclDFNybMeqz
    XkaXbaOAadxjsRhZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfeelgfejvdfgtdefgffhfeekvdevvdeg
    ueffieetgedtheekvefhfeefkefguedunecuffhomhgrihhnpehsthgrtghkohhvvghrfh
    hlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:KWcuZdQBzcC0A79xYSji8DrCD0PZTa0xKnlSmQnnKvbgqfn5VpHu0g>
    <xmx:KWcuZWurQRMVqlMVXpt1q3GiKnMzD38L_kb1hPLp5HmKEcAG3oqfaw>
    <xmx:KWcuZefi3z-wC82aqo0R77QyFNVaSnoN391rDt6ogivRFCMPftjCWA>
    <xmx:KWcuZQoUsstCYyjxDdjkX5HBk1nXJh0o5XF8nMme5NziFSxBoEhhOA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A6D1B15A0092; Tue, 17 Oct 2023 06:51:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2c45e813-738a-480f-8c77-8c646df9c0e3@app.fastmail.com>
In-Reply-To: <7368e4ad-b05b-4b8f-a13b-0a68b442e72b@tweaklab.org>
References: <7368e4ad-b05b-4b8f-a13b-0a68b442e72b@tweaklab.org>
Date: Tue, 17 Oct 2023 12:51:00 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Moritz Widmann" <widmann@tweaklab.org>
Cc: git@vger.kernel.org
Subject: Re: Git Pathspec bug
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023, at 11:45, Moritz Widmann wrote:
> I executed the following command in zsh (added `command` just to be su=
re=20
> that there's no aliases or functions)
>
> command git submodule add=20
> 'git@github.com:moritz-t-w/Godot-Onscreen-Keyboard.git' '.'
> fatal: empty string is not a valid pathspec. please use . instead if y=
ou=20
> meant to match all paths
>
> Git Version:=C2=A02.42.0
>
> OS: Arch Linux

Is this the same issue?: https://stackoverflow.com/a/53441183/1725151
