Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35C79C3
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="EFBmaLE/"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8039D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698094291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WF7uf4Zp+0GA002AQsqeXdVOCYwZnKM0eww9LBMkZ68=;
	b=EFBmaLE/X0O+nq0c9vDR/gRbQAF0WYbFae1kFKTy41RCBydMpIYsy3zqDBMWZtpjIhLWNh
	bZeNFkt6jHzbQbW3zOLG+FY+pEgZgnvi4rD7eePWzI0C97bc5yap1OMuY0r77jZj1BkgeA
	MWV6kBnIV/C1SfP30coNF34pvATQSq3JKFxPJ4R4Yhp1kWptMu1ZHnhf+34xluSyTrI030
	sjwkVkGKbfD0Cpq22owhreC7+MKnVJsBb4t0zbDZBoWAyxGNSveXGSW3pmc4FB5m/zaKGQ
	rRKo30p5da803e/NUUaUlYuA0uGA8yCsIMiOSEOQxrYE/fYY2n4Rkf7e6YLbtA==
Date: Mon, 23 Oct 2023 22:51:31 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTbVY7Nf+DTYqHky@ugly>
References: <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io> <ZTbVY7Nf+DTYqHky@ugly>
Message-ID: <d55eaf41f55bdff0b5ae734e5d7e6724@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-23 22:19, Oswald Buddenhagen wrote:
> On Mon, Oct 23, 2023 at 12:29:12PM -0700, Jacob Stopak wrote:
>> Those arrows showing how things move only really apply to "simulating"
>> (dry runs) for specific commands like add, restore, rm, commit, stash,
>> etc, so making the --table proposal a default status output would 
>> still
>> miss those scenarios.
>> 
> you're too focused on the status quo of your own tool. :-)
> there is really nothing that would speak against the real commands
> reporting what they just *actually did*. this would seem rather
> helpful for noobs and other insecure users.
> if one really wanted, "you can also use this with --dry-run" could be
> part of the hint that would say how to turn off the extra verbosity
> (or just the hint itself, if one likes the verbosity).

The hint should be about how to turn the tables and verbosity on, not 
how to get rid of it.

> one could even go one step further and put at least the destructive
> commands into interactive/confirmation mode by default. but that's
> probably a bridge too far, as it would be potentially habit-forming in
> a bad way.
> 
> regards
