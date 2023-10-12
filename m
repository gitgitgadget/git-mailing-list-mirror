Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010673E46D
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385BDC0
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:49:12 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0BE0790137E;
	Thu, 12 Oct 2023 21:49:11 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2C746902545;
	Thu, 12 Oct 2023 21:49:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697147350; a=rsa-sha256;
	cv=none;
	b=8anJ1xVMle85hBgTgrFTlkGzXwyTqfKwF/obAYJGwhEETa//jAvd77Cn8O/0cjUr68J9f2
	WkEHmPQGp39v7KyV/XiAeZYeMbgDLrc/NrQIEW4VCbDN3yBk7pl3rN5vWfhg7/VQCOp2VS
	2WfM39D3iS2oNkBGsORsqDcuv7R6QKbZdl5hjAL0j5rbwUhHa7xU2tngO/hL27MiJzCTK1
	6nZ6O8iBnZvNHPqDmiiB/lTqyraJVm/vMW+7R/zDFjcLHXwvZK68PhXjJIhEK8bwpFnxDQ
	CB5ocdgnmMJNOF1X1l0qy0dYJJ1dmt3jx85z2RUKdZn6W94O57NNsR+F8TOqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1697147350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9DqQnz0ouX1V4GCgFIuwRichjsDp2l13XUD/yfh+kU=;
	b=P6HM2MtgS57jHcbZiNQnGulkCP4nSq6f8CnebTYKXBGY7o0bji9cEPYL8Uf/68Cnqn0nIk
	beyeHoN32cvJ7mpoeOkqUcGeM8BHquaQNk5KtaMnqfbyEcphjzs60kWXJ+M9Yf8SPfUAg5
	mvB4ZDWQpyS8V/KufZhFTlOHmp7KrDrzDqr2jXGpe02l3+v0K5+FzV0zup5MEdNBPcrV7P
	eAxmcdmAd6T+tHKcogS3r5oM1ew1BCkSXsUsBzmdozZbb0huitJgEnPsXmA6nZXx68fd8M
	htVl5PUE4OuiMXXewbqqZtW3MXJrfzwWgQBT4Fj56prkNmie19Kp9PKNWtN8MQ==
ARC-Authentication-Results: i=1;
	rspamd-554cd65b86-7d2zq;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Relation-Well-Made: 391b6670791bf3e7_1697147350808_3575386518
X-MC-Loop-Signature: 1697147350808:1239264491
X-MC-Ingress-Time: 1697147350808
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.117.92.208 (trex/6.9.1);
	Thu, 12 Oct 2023 21:49:10 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:48748 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1qr3YH-0003RP-0m;
	Thu, 12 Oct 2023 21:49:08 +0000
Message-ID: <c6cd3133573d5ade6d02b5da1051853a4b3885e1.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Date: Thu, 12 Oct 2023 23:48:57 +0200
In-Reply-To: <31b6f4a2b88cc3a2cfa908f82f4f2302@manjaro.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
	 <xmqqa5sokdd3.fsf@gitster.g>
	 <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
	 <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
	 <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
	 <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
	 <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
	 <ace230a469fabbbbceb38cc884a40b4c@manjaro.org>
	 <8f3bec2752f4c2d3ebdd29d20910a4a94f75f608.camel@scientia.org>
	 <23cc509bfb433e19c7683c97314e4ac8@manjaro.org>
	 <2f3ef5568ed19ac5bdcd23f84ddfb13dc6901043.camel@scientia.org>
	 <161b9584c6c9a004c01bda98cea4f1f8@manjaro.org>
	 <e1e187ca3d970c18e1a11d51ff93b6cb212bcbaa.camel@scientia.org>
	 <31b6f4a2b88cc3a2cfa908f82f4f2302@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 23:15 +0200, Dragan Simic wrote:
>=20
> Ah, I can finally see what are you talking about...=C2=A0 Thank you very
> much=20
> for all the testing you've performed and for supplying this screen=20
> recording!=C2=A0 I can confirm that my environment is also affected, but
> for=20
> some reason I haven't observed it this way before.

Well... perhaps because it's not really "easy" to spot unless one
carefully reads through the lines (which I guess, one does not that
often in the terminal "history").

Have a look at my ticket at less, especially:
https://github.com/gwsw/less/issues/445#issuecomment-1758887183

Where it was confirmed that the issue I describe might happen (and I
guess is non-fixable?

The whole issue also contains an explanation on why scrolling doesn't
work when -X is used (but --mouse is not) on VTE terminals (and maybe
others, though not xterm).
And it's basically not "fixable" but simply "by design".


> Huh, that's really worrisome and I'm willing to help you with
> debugging=20
> and fixing this issue.=C2=A0 Please, let me perform some debugging and=
=20
> digging around, and I'll come back to you with some further insights,

Well, my assumption (though I'm really not a terminal expert) would be
that it's not fixable... because less would somehow make sure that
everything it prints (in the alt screen buffer) is properly
concatenated in the the regular one.


less upstream made some suggestions:
https://github.com/gwsw/less/issues/445#issuecomment-1759986293

One would be to change the terminfo entry, which I guess is not really
feasible as a general solution.

The other would be less=E2=80=99 --redraw-on-quit option.


Maybe that would be an even better solution for git?
AFAICS, we could have -F, the VTE mouse scrolling out of the box, plus
(via that option) the final screen buffer of less printed when exiting.

Would give some context (what one did in the pager, where one was) on
the regular screen buffer, but (presumably) avoid that mess up... and
perhaps even prevent unneeded pages of output from the pager, if one
scrolled down a lot, which maybe aren't even needed?


(Also note, that less` upstream calls `-X` "a risky flag" ;-) )


> Those people, just as anyone else, can use $PAGER or $GIT_PAGER to=20
> configure the pagination the way they like it.=C2=A0 In the end, that's
> also=20
> what I do in my environment.

Sure... all I said, that (IMO) in the case of `-X` it's not like with
`-R` but rater like with `-S`... i.e. neither mode has more right to be
the default than the other.



Cheers,
Chris.
