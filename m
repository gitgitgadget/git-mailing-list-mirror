Received: from www133.your-server.de (www133.your-server.de [88.198.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2152C1A9
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tb6.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tb6.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tb6.eu header.i=@tb6.eu header.b="mDJwoG/y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tb6.eu;
	s=default2109; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Cc:
	References:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FfHp9tuuWMT7HlmbeGTXiDBEUQaY+ti7OLz9gzzP0g0=; b=mDJwoG/yNw2tqDO30ypDaIP1EZ
	V2oB49joQVnTTkY4s9oJz5S1zrqx2G1Gj7gQgS8y/hoLZoTSeski+jXNLZlk914l8HTTRqRNaSYFd
	z0lVynNeWW1swsSfPyRnF7uQiDB4AAEAEX1R/PuRYlzD5u1JkXe5okX5aE4Hr+3Ahk5Tzlqm/bkd5
	kiwe5Ytk4xWBuYhbwEH4aHjdBX8fEAJOMExCEwXDmHubeclxX6FiOxgmTzmE6OWEEXHcT7/xIUiZ4
	+Rq7Qg6JRnRU+SYauLIorOxCF3avUyaL/w7u21tCpaeTgSJ93CfaTXIKqfhRSy07LDO5D8mTYRrdu
	PfLZK7ow==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www133.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@tb6.eu>)
	id 1rLSVg-0001yB-6Y; Thu, 04 Jan 2024 19:32:04 +0100
Received: from [2a02:810d:1380:a8:8800:9ec1:b722:bc9d]
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@tb6.eu>)
	id 1rLSVg-0002Oh-0m; Thu, 04 Jan 2024 19:32:04 +0100
Message-ID: <88407aeb-bff7-4899-af7b-e7cb671d991a@tb6.eu>
Date: Thu, 4 Jan 2024 19:32:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tamino Bauknecht <dev@tb6.eu>
Subject: Re: [PATCH] fetch: add new config option fetch.all
To: Taylor Blau <me@ttaylorr.com>
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
 <20240104143656.615117-1-dev@tb6.eu> <ZZbr4yAJe0dnHRcO@nand.local>
Content-Language: en-US
Cc: git@vger.kernel.org
Autocrypt: addr=dev@tb6.eu; keydata=
 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
In-Reply-To: <ZZbr4yAJe0dnHRcO@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: dev@tb6.eu
X-Virus-Scanned: Clear (ClamAV 0.103.10/27144/Thu Jan  4 10:39:55 2024)

Forgot to put the mailing list into the CC - sorry for the duplicate 
mail, Taylor.

On 1/4/24 18:33, Taylor Blau wrote:
> Instead of "can be overridden ...", how about:
> 
>      This behavior can be overridden by explicitly specifying one or more
>      remote(s) to fetch from.

Sure, although I feel a bit conflicted since "git fetch one two" still 
doesn't work and would require "--multiple". But probably still better 
than my wording.

> I don't feel particularly strongly about whether or not you reorganize
> these if-statements, but we should change "argc == 0" to "!argc", which
> matches the conventions of the rest of the project.

Are you sure that I shouldn't use "argc == 0" here instead since it's 
also used in the next "else if" condition? Or is the goal to gradually 
transition to "!argc" in the entire code base?
I agree with keeping the diff minimal, will change that to your suggestion.

> This should be `cat >expect <<-\EOF` (without the space between the
> redirect and heredoc, as well as indicating that the heredoc does not
> need any shell expansions).

Will do so, thanks.
I tried to match the existing test cases as closely as possible, but if 
they are outdated, it might be better to use the more recent structure.

> It looks like these tests match the existing style of the test suite,
> but they are somewhat out of date with respect to our more modern
> standards. I would probably write this like:
> 
>      test_expect_success 'git fetch --all (works with fetch.all = true)' '
>        git clone one test10 &&
>        test_config -C test10 fetch.all true &&
>        for r in one two three
>        do
>          git -C test10 remote add $r ../$r || return 1
>        done &&
>        git -C test10 fetch --all &&
>        git -C test10 branch -r >actual &&
>        test_cmp expect actual
>      '

I think I'd prefer having the "actual" (and maybe also "expected") 
output in the repository so that it won't be overwritten by the next 
test case.

> I suspect that you could go further with a "setup" function that gives
> you a fresh clone (with fetch.all set to a specified value), and then
> test test would continue on from the line "git fetch one". But I think
> it's worth not getting too carried away with refactoring these tests
> ;-).

I think a setup function makes sense to at least remove the clutter from 
adding the remotes. Although I think that setting the value of fetch.all 
in the test case will make it easier to parse the test code - that way 
you don't have to look up different functions to understand the test.

Thanks for the great review, will send an updated patch later.
