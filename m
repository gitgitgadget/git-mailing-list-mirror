Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B42869A
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="PvZqeibT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BU8t1LmU"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B181E91
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 09:27:25 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 2DA235C01EC;
	Wed, 25 Oct 2023 12:27:25 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 25 Oct 2023 12:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1698251245; x=1698337645; bh=Dmxd+qCbdhzAOXXMIEsn1eFIs
	ceCWm3ZUUfJIqVEpX4=; b=PvZqeibTD5ZNO49uD+UL9aeBilvz/v9l8iAFmKy/S
	YVIRQUeQzO6xBUXmmEcU/s9ddLu/Vg618ezET5rE1TbTsJgqi4xEV66NykcGQq4r
	heuHPRLSMghXo04BhN5uhgabRMoY84YNzlgJq/EG4Q7tzqiGHdoQ8IS83RiGGBTw
	wR3KFBP5Lykxw/R+TbTJjggxbOApnpfVQLjJAhGee1mBJ5RPih3oso+UsPZOvH34
	U9iOlpq8A5aMCWPgI5FhKHA6TBVFkY5ApEGyRDVmE2/MI6+iNYsHlgQrIvUzmtyP
	TIwBfZVbI21SxqxNPxvPhfki6HmmcqVN399RzM1Rjk6OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698251245; x=1698337645; bh=Dmxd+qCbdhzAOXXMIEsn1eFIsceCWm3ZUUf
	JIqVEpX4=; b=BU8t1LmU8FdmqKtsiTWVnMt2ZYjQtpnCleiWrAFzL8DDyfGKNcy
	kmAaS8KLTRJblFPFiD8QsL3wuRZlx7NbiROBYX5qbL644jwtRl2lpeuEcU5wNbd9
	2NuIDf7sOs7BukCD3FHITdAXB115VkiEki7X3a6Bhz6yJw9NP6AUVV7dFWUV/7Nu
	8vhRs3Uu53Ds5vLRDJAr2Fb4XcPT7PJ4qA485GLSSGWaybT+NwE82zkszWZ+cxZq
	tV+lwf8s7LqyZpy642IhDhtHc608RKwdW/TIbK6jwWesQyAKobSMtU4Qni1XCZn9
	FLSsnMZ0wyJAqtyzJncO19q/4qqINnOazRw==
X-ME-Sender: <xms:7EE5ZWh9AoxFQR7_g_WHH5uwOPAkrIEguQqP2S_hW0BaqDUXgcWosJs>
    <xme:7EE5ZXDxkO2NIYWtgiXHKw_FqPgOyKmsBTUSyx19y3y0VWwQ6KMUOi8um4Gk1_mvL
    8IpxnZe2_Zjhi9fFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:7UE5ZeHEQQrUj_c6r1Lq9lKMb_6qMg_tPVyKKpCsErjEKShhh0Raug>
    <xmx:7UE5ZfRlMlcVe_HHb31p6vSy3SPGBIYaS_XaatKdaz0hcL2cTn2J1g>
    <xmx:7UE5ZTxlQjnTmFdgUT0DBNcLTNIm1QPGmawf1mRG_u61JQlENuCFFA>
    <xmx:7UE5ZRY9lIfe7J9JyS5YHOccuO0q82lSmKZrGi_kEgOXw4lbxqXTdg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D933815A0091; Wed, 25 Oct 2023 12:27:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da246287-8530-4680-8fcc-f68f881bc24b@app.fastmail.com>
In-Reply-To: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
Date: Wed, 25 Oct 2023 18:27:03 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Ruslan Yakauleu" <ruslan.yakauleu@gmail.com>
Cc: git@vger.kernel.org, "Josh Soref" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Oct 25, 2023, at 10:58, Ruslan Yakauleu via GitGitGadget wrote:
> A new option --ff-one-only to control the merging strategy.
> For one commit option works like -ff to avoid extra merge commit.
> In other cases the option works like --no-ff to create merge commit for
> complex features.

I do something similar for my pull requests:

- If more than one commit: `--no-ff`
- One commit: rebase/squash

Your change would (according to the commit message) only *not* create a
merge if it so happens to be the case that you can fast-forward the
branch. So it would create a merge commit if (say) your branch was three
commits behind and one ahead (your commit) of the target branch. But isn=
=E2=80=99t
it fine to just rebase/squash in this case? That seems more general.

(Maybe `--squash-one-only`.)

But it seems that your new option would work nicely with =E2=80=9Csemi-l=
inear=E2=80=9D
merges:[1]

- Rebase on the target branch
- `--ff-one-only`
- Now you either get:
  - a =E2=80=9Csemi-linear merge=E2=80=9D; or
  - a single commit (as opposed to a merge which joins together a branch
    which is 0 behind and 1 ahead of the target branch)

--=20
Kristoffer
