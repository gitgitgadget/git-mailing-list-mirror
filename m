Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F2125DE
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="sFxS3jQ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EGoCvlEy"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2753A211D
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:24:05 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id C85C53200991;
	Tue, 24 Oct 2023 09:23:32 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 24 Oct 2023 09:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1698153812; x=
	1698240212; bh=SrIcwH1Gy869cwhGL8TU7yv4xZLa1sM3V98wl4atJHk=; b=s
	FxS3jQ65pxHYm9Ct0FV9ezkeK6oxHwsoa4O9yBJOwbpjdW8FeQ85TpU42EZix1ae
	Tg8FB1fvFDQpL+5ZI1Lx03PoL2N7iVvMuLmv5Y502Ir7VOAV9vtAAEHAGWJwhaPF
	fn+rKxOZUthXcyUUvW13WR4Zzjg2BQddeAhneuKgZi03nSsIWZz0i8yjud/e5px0
	TWQWuwA2nNJXDU5yfVpLTHFlxMflduibDxeOIhAQNAMkelxqPqlxmyURK5xxNdJs
	sESMo2KEVbdI1lAw/VXsLTi3y60rhksR7yoWSUcQwrZqmFhLzCjboE4/63/SerLt
	5U60Vw2kd5kQVb/yV2fVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153812; x=1698240212; bh=SrIcwH1Gy869c
	whGL8TU7yv4xZLa1sM3V98wl4atJHk=; b=EGoCvlEyT3PFsRT777wZhDMiREuxH
	DIOft5hXloKPXqS9tK/vPRNRDsOUfCr1JXio8fAb1bd/o+xIV907Bmvhh2IZmLOL
	0X4OWs6+0zSSL89f9XshpUwJgBG+lcFvO+65xyLR9BSQt3USOqZC7JE3L3enDkrg
	bLvhxP2Q+/P3mQCtPsNeIfJMIvwciMNwqG+ad8IM/XyaPGPLb5kTsbhk/xpCWFwF
	M2MBFR4xxbvDHkUB7NtTzshKUzJZG1fSfeikCuyaqbaJIB6UOXFF4wVwL8PKnZhf
	0/PYsCVH2HLOGeGjbb2Uli/Ykl9mP/PKXdQs1/xcRM5CkmgCP/SL9mWUg==
X-ME-Sender: <xms:VMU3ZUzN8VIVSXkO3VohApeVo-3SM6ijP9xWh5FGgIfjEsMXdQ8cEVc>
    <xme:VMU3ZYTNbAEmHJM8FOpxIBGGqDVS4M0hQH3Fjm9qPl5Xg_TEnP3-tVQXHi5m1FTzY
    7wcbDPDM_ZTK8D1qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffgheel
    ueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:VMU3ZWVxCEHh7groH8tX0wCjyjsR2RAVPtn7gqP1YNbp01w_IMSTfg>
    <xmx:VMU3ZShyeKonmJinG5e67AOvqwu4aNC_0nSnh_4pByaEkVJIqa2JgQ>
    <xmx:VMU3ZWBP_PQ8OhAoWvpkT0M120Lz-o30b-68vExcwikVsx9TWiXxTQ>
    <xmx:VMU3ZX6ajDu9INWNQ9dXsSbSx5BuHi321Og1iiZ_U3FuPzRg5q7euA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F381B15A0092; Tue, 24 Oct 2023 09:23:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <87badbe0-de18-4f8a-9589-314cea46065e@app.fastmail.com>
In-Reply-To: <ZTav2u1JWmLexEHL@nand.local>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name>
 <ZTZDqToqcsDiS5AP@tanuki> <ZTav2u1JWmLexEHL@nand.local>
Date: Tue, 24 Oct 2023 15:23:11 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v1 3/4] config: factor out global config file retrievalync-mailbox>
Content-Type: text/plain

Hi Taylor and Patrick

On Mon, Oct 23, 2023, at 19:40, Taylor Blau wrote:
>> Nit: we don't know about the intent of the caller, so they may not want
>> to write to the file but only read it.
>
> I was going to suggest that we allow the caller to pass in the flags
> that they wish for git_global_config() to pass down to access(2), but
> was surprised to see that we always use R_OK.
>
> But thinking on it for a moment longer, I realized that we don't care
> about write-level permissions for the config, since we want to instead
> open $GIT_DIR/config.lock for writing, and then rename() it into place,
> meaning we only care about whether or not we have write permissions on
> $GIT_DIR itself.
>
> I think in the existing location of this code, the "if we should write"
> portion of the comment is premature, since we don't know for sure
> whether or not we are writing. So I'd be fine with leaving it as-is, but
> changing the comment seems easy enough to do...
>
>> > +		 * location; error out even if XDG_CONFIG_HOME
>> > +		 * is set and points at a sane location.
>> > +		 */
>> > +		die(_("$HOME not set"));
>>
>> Is it sensible to `die()` here in this new function that behaves more
>> like a library function? I imagine it would be more sensible to indicate
>> the error to the user and let them handle it accordingly.
>
> Agreed.
>
> Thanks,
> Taylor

What do you guys think the signature of `git_global_config` should be?
