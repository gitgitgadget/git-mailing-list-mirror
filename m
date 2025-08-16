Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB933EC
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755308638; cv=pass; b=ebbKLpBxHOiJBAYySTbf/kriY1cEZDYJcpSxNaPG0SRfr3KGg1BqsiCguhN2HkyAyD1b15YerA3/KCLzocY9BRK7Pxe9JZ2oCyla4heARAk2X1cZhnMcA/4P5F6aG0URhgCMj59tS6NUjxQEhL3hmKwffaP1ajQA81P1afmpsVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755308638; c=relaxed/simple;
	bh=1mcp6WvYgsflIbbdujKmnkUusQ1DSIuNeCn0f/xoLSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Htnof7ax9XmqOOsf53Cy0UaGxEaVJ7viecea9j+gglIz5gpD/RwEmAgOWjJgfqnaXsQVO9xmU/kGX677vMWBpcHam/a6UBS5FxSglnVxtqPbqRnzYKMUdrfCquQVH3OhE/gdQer/KS7Q1+U1LJLdkRjt9VVC1Gq4E1uPQLEpks8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 51EBD44AFF;
	Sat, 16 Aug 2025 01:35:52 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-blue-9.trex.outbound.svc.cluster.local [100.96.30.125])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 828BD43824;
	Sat, 16 Aug 2025 01:35:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755308152; a=rsa-sha256;
	cv=none;
	b=nA8Hp++ho48Y1331kB0xt2hXapJml4PfZMnt9kDKaPPy4EUv7a7qFR6nPg9CLOkROX7nth
	wKlaVyinNZ0tLSHOdr1VntLANORfEg8pB59pnk87Dz7eXPALD9H6H+76OX7Yy68NwGP1LA
	7lxAas7vXsXSd/HEJ42wDg/wn3p5K4er9/6JNO4/H3wmen23V4CcjWM/tX4XXKO7K35xRM
	OosQ/ko1FrlTR7WBQs16zWaecdY0lPfGE7tu1Ry2HQh6mRDUArE3khl/fug2UZRKUveMEE
	TIL3bjxfG7/im0lboQswpGEuZ+eWbUhgTqr5eZh4ZBfthBu7/zpR8X8nf99B0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755308152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mcp6WvYgsflIbbdujKmnkUusQ1DSIuNeCn0f/xoLSc=;
	b=i9EBNNEMtzOuOkLSGhwpTM28e48bWQvbAMdAbL5NqeMjrf6TOPjMld30bbLY33YD8kE0C0
	7MgQtSsp2sVwapozfePxBzHyG9qG6fPQtKDUd4FYh1rgTAU/6YuOFYFXQYOEyCiOmY3AJD
	OAlBCCEKUOEQsVHV4Tk0iM3NbBdleb+/YiaxOKzxSOZeLbLgcaZwBMfEtgA5ohY2HSgCFn
	dDgfUKgOcq3NzWUcImwjPBR7bJullnM7uQfwYnFtwVDGQevCFfWLSkb3QohjjXenS4kUER
	4SzfLbAQtFUdvgBgHz3DYGUUc2rku3YcUtrWg/WrCdOgZRUa5J7EWifuAiVfbQ==
ARC-Authentication-Results: i=1;
	rspamd-865b9ccc6c-hkz5j;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Whispering-Robust: 590050547e807a60_1755308152187_3627738104
X-MC-Loop-Signature: 1755308152187:1338996525
X-MC-Ingress-Time: 1755308152187
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.30.125 (trex/7.1.3);
	Sat, 16 Aug 2025 01:35:52 +0000
Received: from [79.127.207.171] (port=22821 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1un5po-0000000BtCm-0ysD;
	Sat, 16 Aug 2025 01:35:49 +0000
Message-ID: <fdb7d4da229dc41302d1c17871674cb41d3956ce.camel@scientia.org>
Subject: Re: why can't one alias `git stash`?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Date: Sat, 16 Aug 2025 03:35:47 +0200
In-Reply-To: <CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
	 <xmqq7bz5v0mq.fsf@gitster.g>
	 <16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>
	 <CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Thu, 2025-08-14 at 21:04 -0700, Elijah Newren wrote:
> No.=C2=A0 And there won't be one in the future either; see e.g.
> https://lore.kernel.org/git/alpine.DEB.1.00.0903070407480.10279@pacific.m=
pi-cbg.de/

At least the "it makes it hard for users to understand" argument seems
a bit weak.

I mean isn't that's also the case with shell aliases and the whole
point of them is to customise the behaviour for the user (which is btw
also done by many git-config options, which another user that uses my
settings may not be familiar with).



> And it'd mean that other folks who use git commands in their scripts
> now can't rely on any git commands doing what their documentation
> claims.

TBH, I wasn't even aware that git aliases are applied from scripts.

Isn't that anyway a pretty dangerous game?
I mean I could define an alias that works right now, as it doesn't hid
an actual command... my script relies on that alias working.
And the next git version introduces a command of the same name (and my
script breaks).

There's good reason that shell aliasing is per default not active in
non-interactive shells.

> Doesn't it detail what happens already?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If the alias=
 expansion is prefixed with an exclamation
> point, it will be treated as a shell command. For example, defining
> alias.new =3D !gitk --all --not
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ORIG_HEAD, t=
he invocation git new is equivalent to running
> the shell command gitk --all --not ORIG_HEAD. Note that shell
> commands
> will be executed from the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 top-level di=
rectory of a repository, which may not
> necessarily be the current directory.=C2=A0 GIT_PREFIX is set as returned
> by running git rev-parse --show-prefix
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from the ori=
ginal current directory. See git-rev-parse(1).
>=20
> What is missing from this explanation?

Well, what I've said in my initial post.
Is the shell execution environment in any way sanitised (like which
IFS, PATH, whatever are set) or does it even share the env from some
git shell script that may execute the alias shell command (as in dot
sourcing).
Perhaps also *which* shell is used? Is it always /bin/sh or whatever
shell the user has configured as login shell?
Will e.g. profile/rc files be loaded or not.

Admittedly some information might be overkill, but at least I'd wanna
know if using the wrong function/var names in my alias command, could
cause troubles for git.


Cheers,
Chris.
