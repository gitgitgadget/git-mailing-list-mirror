Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91A22EE1
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vz1VJBs3"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A56710E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698092988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WWQhpspWZd6QB+9YQTCLZ2e6xNpOUAi4N63I88LWvA=;
	b=vz1VJBs3ul2vVO+Go9Q2bsVcE94vJpR2qc7WgtOsz4ijJcjSFB5OJrhLk/aglhwYAouomI
	A9H0c31PFfWtWqYL8GaDo1lU/bgUxKrr97jv7TH57+beHWBf0lOV4oehE3v3EXI2KofrWQ
	w5cjmugBfCwxJxpTBCqkbl/UIUxcnizwE42tpSTitEMH1e50FciNtljnQ9NgRM3za7p6e+
	l+vDkXu4FqSly0OP7QBTQoDS3kAImFKsyAnZRBgQLydESr9p0ETavDF3a4ui+ZAUot+mNv
	kFBzcTfewCjbbpnFcQY/pNuy5VW74SZ0p4GwPKXoPyQ1oe5p47o/4K1EfEiBEA==
Date: Mon, 23 Oct 2023 22:29:48 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io>
References: <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io>
Message-ID: <206fcee1a8004aca813debc358b183d4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-23 21:29, Jacob Stopak wrote:
> However, now that I'm thinking about it maybe it could somehow be 
> included
> in the Hints feature? I honestly don't know exactly when the hints are
> currently invoked or how much detail they go into, but what just popped
> into my head is kindof a "universal dry run" option, which would show 
> the
> user the --table format hint when they invoke an applicable command, 
> and
> prompt them if they actually want to run it.

That's a good idea, having the tables and dry runs mentioned in a 
well-placed hint that could, of course, be disabled through git 
configuration.
