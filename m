Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="WSoE/JUP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvCi7iwe"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DB129
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 02:37:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 1E1155C0186;
	Fri, 17 Nov 2023 05:37:08 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 17 Nov 2023 05:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1700217428; x=
	1700303828; bh=Op6p7cgf5pfRdse4OMcMIKwqwYxsRo3Bwoqin+1t694=; b=W
	SoE/JUP7BpMBE0L5puIfaafsOdLQ7v5SebWEzp7U7b/CbmI5x09E8MxG20uyOd3+
	sZ43lY59bq1GOFF996MOd/NVBrNBVm/bOvtTh1KRN6OC2mvNH6cr6a1SeCBLhk85
	JhrViDQg+SnnSy7mcYtI7s3Oe2eZ8/fcpKo6WLA2y4Az9sfJRj+nLOG2McvB52Bx
	we8dWI2/1MWWikleewxEbbPhGm2NI95wXyUIdPXJDR+Nznfjktgf6a8bwPNm+DP1
	A7wwBggguocUDJM4ixuLymqrTv0H4TJtO8zZrr5FXVN6bhhx5quAXf9iqB8iCskN
	dgKTpC6vG9MnMoQCB7icQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700217428; x=1700303828; bh=Op6p7cgf5pfRd
	se4OMcMIKwqwYxsRo3Bwoqin+1t694=; b=OvCi7iwepfOFmyi8XneXakymwWepr
	8OnJlY03GzVWQ/0t7QFKmMQBJmz6qZiAoF2jdl+wcpxfQcmPVGKfnKJa6yOWzkZH
	9eiYavuOaJVyCLTc+dXO620BSe5BH5Oej7Q1KJCZYrgRWcAEzW2TG2GJK4nEvVRo
	TK4RdR4uJDjBFSOuenyljyiAsHq2Ya9/VmN8dh/LXF4AAz93TURgY4dd4ao1N4Om
	JjtIAu241P1hhjwt2FuiBQCLZDH2uaoxgeEYu2N9m1iYm8F+wLI41+Liz5x7jk+N
	r+mK7/21okE3SRWwHO60s37JQa3LvuY6QiwJm+ZnmS33Tlm2DxCVrcLNw==
X-ME-Sender: <xms:U0JXZUVKR2Hr1OfcfU8IZBDTz6vlTfHfE7IsGMzx1XnDzO7EY730GHQ>
    <xme:U0JXZYm5pg15Bw6zmuucYmHW9R6XjgRoOqRZYXeJOZhVqNf3ghtSQuqAqUkpyd-Jj
    L6zd__nho6D4vudqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegtddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:U0JXZYZtWmo6OCevd7zqtRHckxByxc9JVeAf7pGPIDCVZ2xqmVdImg>
    <xmx:U0JXZTVyUvdNRYla_JcrrmE_fcJKMc3VZkHbYCUFDRvgsk-ALB4OKQ>
    <xmx:U0JXZekC1tvPbiMwyi1cp7QQ9c_UHkr--oChuKSVADwZXSPHk74PNw>
    <xmx:VEJXZYQ0S6c88FZmTe9kQeUQqWOb-6-hsG1lNP5eFv3ZskAESo6ODA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C2E3915A0091; Fri, 17 Nov 2023 05:37:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <06af02a0-fb98-4a82-bb19-d2017581db3a@app.fastmail.com>
In-Reply-To: <xmqqpm08pyrh.fsf@gitster.g>
References: <xmqqpm08pyrh.fsf@gitster.g>
Date: Fri, 17 Nov 2023 11:36:45 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2023, #07; Fri, 17)
Content-Type: text/plain

On Fri, Nov 17, 2023, at 09:30, Junio C Hamano wrote:
> * kh/t7900-cleanup (2023-10-17) 9 commits
>  - t7900: fix register dependency
>  - t7900: factor out packfile dependency
>  - t7900: fix `print-args` dependency
>  - t7900: fix `pfx` dependency
>  - t7900: factor out common schedule setup
>  - t7900: factor out inheritance test dependency
>  - t7900: create commit so that branch is born
>  - t7900: setup and tear down clones
>  - t7900: remove register dependency
>
>  Test clean-up.
>
>  Perhaps discard?
>  cf. <655ca147-c214-41be-919d-023c1b27b311@app.fastmail.com>
>  source: <cover.1697319294.git.code@khaugsbakk.name>

There has been no interest in it so I say yes to discarding.
