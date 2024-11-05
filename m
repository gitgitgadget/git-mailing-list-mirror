Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418EA2D
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780276; cv=pass; b=TRWHLmUznUQ4hahm3C4YsgREeTeyBDjHvISVGd7iFU0Uj/9RRbUB+g5OpKVV4ofmZiAoq3+8rZ8jYgAXefvpK906lqXgHvmbuChR5f1iNUvJ2HZBGiftyO33HiWF0HgxgD6l33zOLyMgcN/lkHOMDMHBgQkmAUSQhZrXTP8LQMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780276; c=relaxed/simple;
	bh=uVSl3O2yOfr1q8ljzDq6KH/13LAiQ0JEZd4hdEd8RvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1j6/cF/olyF0kh0j6KIMCW8cq97oj1ymeJD3dl5OBaXRqrKxGKSarQA3lK8DKL6N2mS5SX4QmdMh8HSvJG7Gf8Yb8ibi7cvxBH6dqrA4WpFivKR/ECCAVXrfHjkbO1PQ+gJr1DYw3qdAxK80Qbic5InxPXQ0AyuvYvUyMSFe7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6CE488C7881;
	Tue,  5 Nov 2024 01:01:20 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-103-175-120.trex-nlb.outbound.svc.cluster.local [100.103.175.120])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 88B4F8C7CE8;
	Tue,  5 Nov 2024 01:01:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730768479; a=rsa-sha256;
	cv=none;
	b=qEuPB17P+Ps5BWBhv6yF3Wdhyp2RweXsSIU8brAp6ysXvHl975dOiFIb/S8mn0PxEEKw27
	mjA0KLIvz8T4rlVcWk4Bot6n7AItiEuViiqlTmMjRjdeTsFzebd+PbRlXCu2KANacrlqvv
	pn52U795/y+VnFH/ObbUdhQco3OBnypuwRD0cywwcNjd8not7FMvTwFmsfPZuKRRDuwCVX
	QKMHj9SJj+Aeklfl9O65eT5Mxb+8GtTO+A4ii0zkqLIpkv+H1YC30iMrWG263MLXsSaLNP
	fkHDp5LgsmkwtPsKw91rVe0OVbcY9UsFrDaBDBXy009nzM7UrdngqG6sqYUwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730768479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVSl3O2yOfr1q8ljzDq6KH/13LAiQ0JEZd4hdEd8RvM=;
	b=LUb947h7hLlbcxqv8EptAsc54OedDEXjiIPSBH0Lb1VCa3ykHncPgc6NgXrAntItgaOqn9
	GaTiUvLwMt4sSm7FADunlJxN8Bu5qlcsoz0xZWd/tJtmxPxj6JUTkAMhQlFV1R1uF8Y9EN
	R8t8aNMqNUIKi2iTbpyelzxSIa4Fzr4AvuqO3C5lwg6/F2L8MO1lz34yxwpuhPK8IclQgP
	brC/cMxGH51hOn5/ShvylZ/Tl4tpv5IQnrH2EgDxUNjF1+AbG+QjZ4Bw/94LwIUDGuW8KZ
	1AetIkRAAyhZIwhJeEZnkKBIu6kMxoTgrTSGIBI9QOJ4NyB4Mg9/VKAmvJmeow==
ARC-Authentication-Results: i=1;
	rspamd-696f47875-gb4ww;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stretch-Left: 5e331bec654b0bd0_1730768480220_955942612
X-MC-Loop-Signature: 1730768480219:3879941219
X-MC-Ingress-Time: 1730768480219
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.175.120 (trex/7.0.2);
	Tue, 05 Nov 2024 01:01:20 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:62227 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t87wb-00000005wm2-3OTU;
	Tue, 05 Nov 2024 01:01:17 +0000
Message-ID: <b856a94969b7065e84dce60d35ae3ce72b5d0f91.camel@scientia.org>
Subject: Re: git format-patch escaping issues in the patch format
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Date: Tue, 05 Nov 2024 02:01:16 +0100
In-Reply-To: <xmqqttcmv8a6.fsf@gitster.g>
References: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
	 <xmqqttcmv8a6.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.


On Mon, 2024-11-04 at 16:22 -0800, Junio C Hamano wrote:
> ... this falls squarely into "if it hurts, don't do it" category.

I rather thought it would be the category "if it's a bug, that is
completely non-obvious and not really to expect, with not even a
warning in place,... it should better be fixed" ;-)

There is not reason for any commit author to assume that these strings
are not valid, or possibly cause later breakage.

Even if so, it seems not really feasible to know any possible strings,
especially when people might just copy&paste output from others into
their commit message.

To the least there should be an error when format-patch creates a one
that cannot be parsed afterwards.
And a proper solution would employ some form of escaping.



And if one's on the other side, and wants to write a parser, one has no
real chance of assuring that only "valid" input is used by users in a
commit message.

One can easily imagine hat this could accidentally (or intentionally)
be used apply undesired patches.


Cheers,
Chris.

