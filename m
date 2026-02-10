Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E71F1315
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684837; cv=pass; b=kyR6fDEaqn2WU3fZPXC9G7VRei/VrPt9IhVK9FEbbaWn1xkWMTAUvvDwoB8exQSifOpZ0bJEy5JPoYZ3+fsc/K4+uyPnAy2oX7L/qTLwe+c+VW6TCrS+JRYDE6XkHtf06BX+JRczzpSuy/EfJDvb0KGfYxo7GtPo1MECm16imJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684837; c=relaxed/simple;
	bh=gLAYW2mn4tQHSrDIcaBVxSsmQB5Hg7Q7YNwsewv5Ri8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZUMCYfTt+cN+2hHqDlgLS0msVShMtPXQ3XwVk9POrhDyRCRRlRDsOkz1jrnC0Wy34p4Y+Pvt3l+Ga6rQM7tFk9FVI+BNTvi4eU9ZiZIIJiXZvMkcVwFUgZ2UMIY0M/SmrW9dnMzOjlLt8VJ1U6bCYQ2+dl31Y3xOIlmaSPBzBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 39F06461AF4
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 00:53:56 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-4.trex.outbound.svc.cluster.local [100.96.85.251])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1C5E3461BB8
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 00:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770684835;
	b=JrujLd8S5TSyfhIG5LtA0LN4ra46wYeG6cqAKdxygWQ8xC5xHswmauGXRbPYYAfah7LyRN
	q4G3i7DDKATqtoLex+oegFRatBdxHr402TtO+Cjm5GHBKllNpFxk7qPxbtXtORI73Mbw8s
	a9ECdYvcltXCmquSSlZI48JbsPi5TV49aCqtuSjjIz+FZ/aQOp/kxA+UIdCbeCzh4wUvck
	nNES0RPZzrobf6zY9PET0MBtDLEaij3Tydyk8o9HbSX//g3KW/YVx4RRgJPAMQt3nWnWR/
	up/wWyeRkwAfATOCXyyLMyP6fS58IzUuQ9ZVffW7MkRLH2/GW42QYg7FFUOrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770684835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLAYW2mn4tQHSrDIcaBVxSsmQB5Hg7Q7YNwsewv5Ri8=;
	b=NG7RCu5ugD2FNZCW5dY61sJYwCBoTVgenVQx+mPra8+MTW5PVcpKkcQDlRvwYzK7ZykS2D
	dJCKu9+eGl2YAV4htr93nYU4VtTV3gNO4C7gvTjaVwywt5sto9AgKrttwUo4SVw9b8xpul
	roDFV4mn/+AMoejNvxCWvXXeULpGoE8wq8zZ8L9kF9LrLCsGwxqHD2qdwoad9V7wih+ecF
	UdTXSWs4milal7rG8aJ0e1cuvEiciWpweO0BBA4XjR2pikRp0rnGIpQ3HXCNzhbUiLZkBX
	sTcnr0kK296BlObzg8anY5IWo/qVIu5eOrZnt+h0C4hXJ27w2A1UfXY8mtX4PA==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-thxvx;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Bitter-Thread: 5357460373ae867e_1770684836134_824038914
X-MC-Loop-Signature: 1770684836134:1254736725
X-MC-Ingress-Time: 1770684836134
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.85.251 (trex/7.1.3);
	Tue, 10 Feb 2026 00:53:56 +0000
Received: from p5b071a6f.dip0.t-ipconnect.de ([91.7.26.111]:62961 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vpc0m-0000000FwiM-0sgH
	for git@vger.kernel.org;
	Tue, 10 Feb 2026 00:53:53 +0000
Message-ID: <83b776c4c3b6092f9714adc157ac6a38af1022f7.camel@scientia.org>
Subject: Re: [PATCH] doc: add caveat about roundtripping format-patch
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: git@vger.kernel.org
Date: Tue, 10 Feb 2026 01:53:51 +0100
In-Reply-To: <format-patch_caveats.281@msgid.xyz>
References: 
	<bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
	 <format-patch_caveats.281@msgid.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

While it's nice to see it getting documented (thanks for that)...
wouldn't it be even better to actually fix the underlying issue? :-)

I mean it's all but guaranteed that everyone reads this,... and IMO the
problem might even be exploited security wise.

Cheers,
Chris.
