Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12F3D008
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D59A9
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 16:06:54 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EC940500D4D;
	Thu, 12 Oct 2023 23:06:53 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id CEC2C5015F5;
	Thu, 12 Oct 2023 23:06:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697152013; a=rsa-sha256;
	cv=none;
	b=TMPWtOPua7e4QH5xodGhCsEZOHY6qSOrWMqdQ+oyhVIeMLW42d3gCEPQ3/sTwBqepwMgnX
	VIMPqMKdckkEZWaxV1fsEw8CdtQ6Vez86SWk1leGDOS/lu2huLTGASTdROW6ooERClZdOj
	d8IULeaNohA6i07cAxHT0FMNWoc2LV9EdrOoDVZkoh2NZme1ehAWUqPs7i5T1TDR2Ha8Mr
	vEajp9a5Uu2/czA9mexDVslF+fbcD34+4SA659/llxhkSgsD78e2ovchDuRdqXRW51sZeX
	eYZLUat/T3mn1i71YXvKSrFjz8tTxA/LrLXDOKkbXPw+F3W65SlssHGAOq+D9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1697152013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yBTe7ZcBGIffWOnz59r2t6v/OQYMTfE0F26ihgx1ds=;
	b=HwMC4vCKnpA3NnKXyIW/s/ZsvooEdOVB5oNColOE9gMhNnULkbLCgs2bc1n1294/85UCOM
	iGseS4gKAaVRa8asiNZdwLro6Q4S9rbUb3pQ/at10OQa07++fHC3gqgvvLg02R7uAcvxJf
	M59dREqyTTHATFT3BLPFX6ZDB19Zjjhot3RzL2tzLoik0DW8JiezERgdrQyOLvkITA1NdB
	2uosKF7UqTc8YqLIJgSOu4OlBgBXjWGPKGcQW08VV+c3A5Uwn5dA4U6T91Ii6EOKAlIo1n
	pJgm+0LRLE4KnsrN3VvDptXv9GexhURr3cZE2hsgHvbGB9fHe79O2yOxhAznGw==
ARC-Authentication-Results: i=1;
	rspamd-554cd65b86-7d2zq;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Juvenile-Cure: 159d48e118fa3723_1697152013478_2798045189
X-MC-Loop-Signature: 1697152013478:3711744238
X-MC-Ingress-Time: 1697152013478
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.126.222.7 (trex/6.9.1);
	Thu, 12 Oct 2023 23:06:53 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:36316 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1qr4lV-00079A-0L;
	Thu, 12 Oct 2023 23:06:51 +0000
Message-ID: <ec91ff19cca3d881d4746208744663c650ebd250.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Date: Fri, 13 Oct 2023 01:06:40 +0200
In-Reply-To: <60f1922b12a6ef304ffa36c334348e34@manjaro.org>
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
	 <c6cd3133573d5ade6d02b5da1051853a4b3885e1.camel@scientia.org>
	 <60f1922b12a6ef304ffa36c334348e34@manjaro.org>
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

On Fri, 2023-10-13 at 00:36 +0200, Dragan Simic wrote:
> It seems that "--redraw-on-quit" is a possible candidate for
> replacing=20
> "-X" in the set of default options for less(1)

*If* some changes were made to how git handles this, it might perhaps
be worth to consider not to touch LESS at all, but only add the
required settings via command line arguments (i.e. -F -R ...).

Or perhaps only remove options from it, if they're known to break the
behaviour with git (like -+R might).


I always feel configuration via env vars is a bit fragile:
- especially when one has generic names like POSIXLY_CORRECT there's
  some chance that by exporting it to one program, where one wants the
  effect, another program started off by that also gets it
  unintentionally
- generic terms may be used by multiple programs, causing problems

Also, if one can set only one LESS var in the environment, not one for
less "alone", one for less with git, etc. - that is unless for programs
like bat/delta which have specific own env vars to set the pager.

So if I set e.g. LESS to something, than typically only to stuff from
which I believe it works as expected for any possible users.
E.g. -F might be such a case.

But if I do that, git won't touch LESS and set the required -R, so I
have to do that manually for git, e.g. either via git_config or by
defining an alias git=3D'LESS=3DFRX git'.
But in both cases it would "break" again, should ever another option be
needed and added by git to the default LESS (which is however only set
when it's unset).
And in case of an alias, there would be the additional problem, that
it's typically not picked up in non-interactive shells.


Long story short, it might make sense for git, to (mostly) ignore LESS
and rather invoke less with -F -R.

The problem with that in turn would of course be that it doesn't
automatically propagate down, if e.g. git's pager is set to detla and
delta in turn runs less.
However, that's IMO litte concern, since then it's delta's duty to set
-R (if it think it needs to do so), which it actually does.


Cheers,
Chris.
