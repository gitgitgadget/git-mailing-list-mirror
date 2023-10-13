Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614C15EB1
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC1FCF
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 06:46:08 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7D55D9013BC;
	Fri, 13 Oct 2023 13:46:07 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 42AB5901520;
	Fri, 13 Oct 2023 13:46:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697204765; a=rsa-sha256;
	cv=none;
	b=0bBxhSeBrXFYqOweb0dtXzRm+0GJ4CaWLXnVpZsEOE5NhPY2waBrG0SHWKjzmWc1PRDw+c
	5zln5Kk5FWyQ+zDAWkwKLcuTcVV8z2xuqzwsVfuqHn7B7OV9liB/EXLbUUqctosRlKk4E+
	TgXofLiSW0+PFpcqtAG1kE4c7a2bxFhBRWctE/Md6ikqCTqIiOMHVpCLH9pJL+LqmxdQE8
	2eaIcamkpkcQVElPb8Pbn1H3f6uCzSsjpuoJe3a5BN/RMaqXr6HpCx2Jo45gTwUeeVbhXQ
	oh5vV4Pc4x06rvd+Y9s6Ecut9BY0F8BLzUnxpRXckBiI1k7yemnViPLJRCU0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1697204765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CBTCckAFv/BU30ffPz9rxwduo6TUm+7DzgHWHB/nqM=;
	b=zVpt1dQPxOgnjijatRrQwvWF6940I1yiTqysTLMiuqa1p3atMymTpcoaMbcBPr8M/HKVis
	P4tpx7AAdYR14dt72lcGJiggcNzgKiPX9br5Gt7OwPSPhiXdVB6sVf4HJFplHA45YsqW9r
	exJBK0xpupGcnumomf2hH2lvpz0+UCFBZz+QgS+OCB6piHKVUE+vOtda4ukRwSJ/ziYhoc
	ur58FPv1f+QzMmpXwQbdZZa7xTflL6RKnI4NDMRtSUR/M++GJHTn+rYUTZyvh1yKnAkAR2
	bhcT9JTsqGZOULbcbbYxRXCyAvo4zcoGKEfTJ8245A0sC1/VjSkjSjOZShoCtg==
ARC-Authentication-Results: i=1;
	rspamd-554cd65b86-bfdxl;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cure-Bubble: 2d33693346e58026_1697204765916_136467
X-MC-Loop-Signature: 1697204765915:510076813
X-MC-Ingress-Time: 1697204765915
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.126.222.25 (trex/6.9.1);
	Fri, 13 Oct 2023 13:46:05 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:39260 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1qrIUL-0003IL-0u;
	Fri, 13 Oct 2023 13:46:03 +0000
Message-ID: <48ff9c2ac262cec32ab4681e8417413488278294.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Date: Fri, 13 Oct 2023 15:45:58 +0200
In-Reply-To: <6d673c1bdae41236e95e3a9fca853731@manjaro.org>
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
	 <ec91ff19cca3d881d4746208744663c650ebd250.camel@scientia.org>
	 <6d673c1bdae41236e95e3a9fca853731@manjaro.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-13 at 06:43 +0200, Dragan Simic wrote:
> > *If* some changes were made to how git handles this, it might
> > perhaps
> > be worth to consider not to touch LESS at all, but only add the
> > required settings via command line arguments (i.e. -F -R ...).
>=20
> Actually, that would be wrong.=C2=A0 If someone sets $LESS or $PAGER (or=
=20
> $GIT_PAGER, more specifically), it's up to the utility that invokes
> the=20
> pager internally not to override the user preferences configured
> through=20
> these environment variables.=C2=A0 That's how everyone can customize the=
=20
> pager behavior.

Well, but if its clear that the output would otherwise be garbage (e.g.
because -R is missing).

In any case right now we have the situation that a user cannot just
easily set LESS in his environment, with a minimum set of options, and
git's use of less will continue flawlessly out of the box, as the -R
would be missing.


> > Or perhaps only remove options from it, if they're known to break
> > the
> > behaviour with git (like -+R might).
>=20
> Again, not the way the whole thing with pagination works.=C2=A0 If someon=
e
> sets their environment variables wrong, it's simply the way they want
> it, and it isn't anyone else's business to attempt fixing it=20
> automatically.

Well, I wouldn't agree with that.
LESS foremost a env var to configure less (surprise ^^).

If git (or anyone else) uses less internally, e.g. because they don't
want to implement their own pager, fine... but then they cannot just
blindly assume that LESS is set only for git's (or any other tool's
needs).

So I'd say the proper way is rather that any such tool makes sure, that
any options strictly required as set no matter what. Just as e.g. delta
does.


> Well, fragile or not, that's the way it works.=C2=A0 It has its downsides
> for=20
> sure, but it's all about having each utility handle the environment=20
> carefully and document it in its man page(s), so the users can also=20
> carefully craft the values of their customized environment variables.

Sure, but from a user's view, the use of less (or anything else) within
git is conceptually completely opaque.

In less' manpage LESS isn't documented as "oh and you must make sure -R
is included or otherwise git will break"...



> $LESS can be seen as a global set of the common options for less(1),=20

o.O ... but, as I've described, one cannot really use it as that:

If I globally set e.g. LESS=3D"F" because my desire is to make less
always exit as soon as the file fits on a screen, which I think is a
reasonable thing to do, git would no longer add "R" and output would
break.


> You don't have to define an alias, there's $GIT_PAGER for that
> purpose,=20
> as I already explained above.

Well, yes... and as I've said before, one could also solve it via
git_config... but the problem stays the same... as soon as someone
wants to use LESS as global less options just as you described it
yourself, git will no longer worker properly because of the missing -R.

And actually if one would use GIT_PAGER one would again defeat the
purpose of a allegedly global options LESS, because unless one does
something like GIT_PAGER=3D"${LESS}R" it wouldn't see any changes made to
LESS.


> Moreover, the whole idea of the various utilities touching the $LESS=20
> variable internally is to provide sane defaults to the users that
> don't=20
> configure $LESS, $PAGER, etc. on their own.

Then I don't see what the big problem would be to just do it via a
command argument - if someone really has ever some reasons to remove --
RAW=E2=80=90CONTROL=E2=80=90CHARS from the command options when less is inv=
oked via git
... then he could still go into git_config and set that manually.

But it would seem to me that the overall handling would be much more
what one expects, than when doing the same via LESS.



> I don't know what delta is and how it actually paginates its outputs,
> but it should follow the rules of the environment-based pager=20
> configuration that I described in detail above.

Well, AFAIU, it doesn't and for good reasons :-)


Anyway... I think all necessary things have been said and this thread
has grown far to large with only semi-related stuff... so thanks for
all the replies why git uses "-X".


Cheers,
Chris.
