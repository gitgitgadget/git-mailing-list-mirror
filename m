Received: from www133.your-server.de (www133.your-server.de [88.198.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7E2C68F
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tb6.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tb6.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tb6.eu header.i=@tb6.eu header.b="T4ceUhYL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tb6.eu;
	s=default2109; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WJgSSbDup/hbU9DNiEdfQjjzyXY7DQLYIPBWG+YfyKY=; b=T4ceUhYLcm9YRPTmkikcb81q7f
	j60xVZvcdMSZILVn7ajiEdIx1PtjkXFddwiWc87x8TB1RDaBOiPOblqCUBLrpqG9jttnT2VzBAY+J
	KiaZiCz7/Z+JhpJTvFj7JQgDNUHXd4zSO+8HfZ32mMxfjplUYjqA04lfT2NYae6USK2CQEjHq1LZf
	wcE3Vm4LHbzOPZHHUhyq+WnSBdwG/Z7MhGAV2WpK0DxTjNTkT5ChLHa00NB8iNXu5hTGDRFikpimb
	h9x0eQrgZtIcdTxyfLOUry4+3E76fb9+DTQkMkiD38MAXuB0A9z6MZt6Dfn/NjLTLy7/Yw9litOCg
	Ilfm3lSg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www133.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@tb6.eu>)
	id 1rLUAE-000Ey5-J7; Thu, 04 Jan 2024 21:18:02 +0100
Received: from [2a02:810d:1380:a8:8800:9ec1:b722:bc9d]
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@tb6.eu>)
	id 1rLUAE-000O11-Cy; Thu, 04 Jan 2024 21:18:02 +0100
Message-ID: <70f17f0c-2226-41eb-ae08-348c794a3411@tb6.eu>
Date: Thu, 4 Jan 2024 21:18:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fetch: add new config option fetch.all
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
 <20240104143656.615117-1-dev@tb6.eu> <xmqqv8896jqo.fsf@gitster.g>
From: Tamino Bauknecht <dev@tb6.eu>
Autocrypt: addr=dev@tb6.eu; keydata=
 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
In-Reply-To: <xmqqv8896jqo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: dev@tb6.eu
X-Virus-Scanned: Clear (ClamAV 0.103.10/27144/Thu Jan  4 10:39:55 2024)

On 1/4/24 19:23, Junio C Hamano wrote:> This sounds like a usability 
annoyance for forks that use --all some
> of the time and not always, as they now have to remember not just to
> pass something to countermand the configured fetch.all but what that
> something exactly is (i.e., the name of the remote they fetch from
> by default), which makes fetch.all less appealing.  I wonder if we
> can instead take "--no-all" from the command line to make configured
> fetch.all ignored (hence, giving an explicit remote will fetch from
> there, and not giving any remote will fetch from whereever the
> command will fetch from with "git -c fetch.all=false fetch")?

I don't think I fully understand the scenario you describe here.
But I see that the change would disallow users to fetch only the default 
remote without its name in a straight-forward way - either your proposed 
solution to overrule the config value or using something like
`git config "branch.$(git branch --show-current).remote"` in combination 
with `git fetch` would be workarounds.
Do you think it is worth adding a flag for it? I can't really think of a 
real-world use case for it. E.g. the config option "fetch.prune" also 
doesn't have anything to counteract it (as far as I see).

If a flag is necessary, I think something like "--default-only" (or 
similar) might be more descriptive than "--no-all".

> Missing sign-off.

Sorry, thanks for pointing it out.

> And we should say that this configuration variable defaults to false.

Will do so.

> This conditional cascade will probably need to change when we allow
> "--no-all" to countermand the configured fetch.all anyway, so I
> won't worry about it now, but it looks somewhat convoluted that we
> have to re-check "all" many times, which was the point of the
> original that implemented this as a nested conditional.

It's probably because of the tab width of 8 that I feel like three 
indentation levels are already too much. I'll use Taylor's suggestion to 
keep the `argc` check as-is (although two checks will still be necessary).
As an alternative I thought about modifying the current behavior of
"--all" in combination with an explicit remote as well, but discarded 
that idea because it might be less intuitive than the error.
