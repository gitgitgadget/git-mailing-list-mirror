Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69F1A0B0E
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310869; cv=pass; b=f5+McqCu1GUtgHhnH0/Fs7+A6BgialhHibQwnoAJAE0UoK1TjITMKo5mUFBrYtou6Ynwc2+wEFlWaNcbX+2GGBH6nv/Fn0h0mO0fimDCo+e1jIF/oBmbN/7W30WWA2ttY0CWIikLOCC2d72nUTRxz3OmtYLCsbqCXGxCGhq9Zoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310869; c=relaxed/simple;
	bh=tQDITk9cGXpfoAjjiEQlo4qM9duJRHt6LdLdiB+Ekck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HrSmsp+nt02u4XsMqsO4Cz0Hut7fkqVkzifDZEpT7cWn5AEKVP1X+WfO8K0Z8EmqYR1ilUljX6D4KT8Cord6dOZ88m+d4FO3+hHjMFuczyfrGI/5gpQd50Lwk1aN6hir4a0FfGiYSfLLDpB/UGr7qeeM6zNxb2ibsenbz3zpQ90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BC1BC8A46FD;
	Sat, 16 Aug 2025 02:11:24 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-blue-0.trex.outbound.svc.cluster.local [100.96.51.170])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id BDF378A43AE;
	Sat, 16 Aug 2025 02:11:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755310284; a=rsa-sha256;
	cv=none;
	b=C7hx7FkzLvH0DCFYFEI7lTC6Chm88KmglKoE8lllgpr1euWqt6LnQju57+wZNEjZkjfgxF
	766XOfBTK0hdzBt/EXzx0lwxIeLv+bx3kuPihw/RFkB3Dv/V6RTomd3Na+o4wlnvi8MyVc
	mFR7kGfnHGj60xbI7lllhRiCcYU6g4LGcjzeNpnv4yH78AQpmK5j1fOq+zT5D+uTCmaO/F
	gMUiKcs2DkV7AWC6KRUDinFMWJT/58RnDNto2KMn+sHO7jRY6vV2xzNxNMkc3CuY+atCy+
	6GvCYOqeFjjzuDX99uGmslJX5fXRmmsGxyGSBY9H+08nPdFtfM3jZ5r7D8yKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755310284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQDITk9cGXpfoAjjiEQlo4qM9duJRHt6LdLdiB+Ekck=;
	b=xCzpvByp/Kfn9Jb1VtZ5inGLpVB31iclTdihPzq4uAdRw5TIt/hhonc79k+sKodkDb9mWs
	NdqSM+HNNi+5rE+Z7X/2PF52zYapmkkOng0JV8w2GVpCitUmS2RD+AoiqIUs6mngKe7WJG
	WAmJ6ltNJ6ZJi6/B1M6JBbYKCqLgF/toVDSPfG3ZDlEMF5Qvzlh8B/UeQRiVKB69gzRezu
	EkJW3rsTcqaNqoy98ttik5/BkGLqGWyR0eXFY+Svor/Mz6r93s9VvZAxuSvCmSzqb33e86
	i3C6Eoh/2YqATAK3ac59bMDYPZVmnvPMADBihEcRadsh1+/PbaKwFNEN2o7zLg==
ARC-Authentication-Results: i=1;
	rspamd-865b9ccc6c-bxjb2;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Decisive-Relation: 2fc1d9ec2ca4959e_1755310284565_574654885
X-MC-Loop-Signature: 1755310284565:2332928330
X-MC-Ingress-Time: 1755310284565
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.51.170 (trex/7.1.3);
	Sat, 16 Aug 2025 02:11:24 +0000
Received: from [79.127.207.171] (port=56512 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1un6OC-0000000C15U-3YZB;
	Sat, 16 Aug 2025 02:11:22 +0000
Message-ID: <d8b279098a41949eef06f26d3f09c3950486380b.camel@scientia.org>
Subject: Re: why can't one alias `git stash`?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Date: Sat, 16 Aug 2025 04:11:20 +0200
In-Reply-To: <xmqqjz34txjg.fsf@gitster.g>
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
		<xmqq7bz5v0mq.fsf@gitster.g>
		<16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>
		<CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
	 <xmqqjz34txjg.fsf@gitster.g>
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

On Fri, 2025-08-15 at 08:27 -0700, Junio C Hamano wrote:
> =C2=A0=C2=A0=C2=A0 $ git -c alias.loop=3D'!git loop foo' alias foo ;# doe=
s not come
> back
> =C2=A0=C2=A0=C2=A0 ^C
>=20
> To be honest, I do not offhand see a foolproof way to "fix" the
> latter.

I assume every aliasing step causes a new invocation of git - or are
aliases resolved in one process?

If the former, what about:
For every aliasing you append to some special env var the name of the
alias, and if the same is encountered again (or some maximum env var
size has been reached) you bail out with an error?

It's of course still not 100% foolproof, e.g. if users manually clear
the var or somehow else uses it.
And it requires that at least one char (that can be held by an env var)
is not allowed as an alias name, to be used as separator.


> It is true that it would break common expectations for script
> writers (to help other Git users) and those who help other Git users
> at their keyboards if we allowed to alias the basic command away and
> to change its behaviour radically.

As mentioned in the other thread, IMO it sounds rather brittle if
aliases are considered at all in scripting.


> But with so many configuration
> variable to alter behaviour for Porcelain commands, I am not sure
> how much it is helping the latter helpers these days.=C2=A0 For the
> former helpers, those who write their scripts with Porcelain
> commands are beyond salvation X-<.

Well I'd also be happy with a special porcelain option that allows be
to override the default of git stash O:-)


Thanks,
Chris.
