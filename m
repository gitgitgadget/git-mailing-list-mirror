Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500057;
	b=0lSr7aKqLWyol1cBd0PcNexmK3oeNlDylVgDBlXhl6SVIYVwOXZ9On04k0+17UPydbyB
	 GRhl0TjpS2Ma9AHIDuBtdcc+wPnTJVeov+NPwjWbJ5+8k1z6ptNYiqqPfrI4tP8vBlHmE
	 Z8Jqro426c4V9JagH80ajDyBK+PegYYI39YiC+sDFHewuRp82F/T/gYxYqWKLTz6anM1x
	 JqPMlT8xCD5qQHEkTiKuu7gFDZ5EFBWOl2qisc/MGtAVZloMk6/2nfzsvZD761iL/xHE9
	 ojrYuHCdW0LmdCU2hHTIL0vKPyJ3ZQO85k66AQG83HY5gyGbFAk7Dt5No54+2Y+fC1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500057;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=x67X15cQp8e9IlKNHY9w5S/jXbNpuwqQbdYN+Z5SjhQ=;
	b=s0U+y7pjTDmjv9nRQYUSSGzmZkEbMyAfoblCWXOetkMnRWt1/Bg1+rdBgfS/7NTbn61V
	 /kfTEo8ckRuceql3vkW7UH+N5hQsbkFOFp7AgZPHMFQ5Chi5kCpLxbX69Wg+J763skF/2
	 TJGH4TVPsubjX0yiKPhLWv6NtF+skHfHuXXbgr8er2n/NssHr9GJmvW9MH6Bv+nAB3CJ9
	 me7HJCjeE+rO2Ub05mv4jWuo5mZKrNjWfT+jSK5Xk+FxYoApJtnyMA7twDniWEzS09Wck
	 g8+kB0zkz+wAnZrp2KF27tcvVov5z4QAolC0exKOhrBalfmMeXiCZYDtWdRweQc5YBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=q9GaXSz4;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4A606A331
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 06:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA4A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=q9GaXSz4
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AO60nlH2360806
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 24 Nov 2026 07:00:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795500049; bh=x67X15cQp8e9IlKNHY9w5S/jXbNpuwqQbdYN+Z5SjhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=q9GaXSz4Con4gWKK5nimOO6OUJM5PT640kVvxskxRzPsh6Ag3nnr0ODDZc93DN+Wo
	 TV69rWxFxdKesZkk69C8Nn7eZLvbgnhERMl2ac+sjp1gMN730FKfsqTb85sd5dMsAA
	 a8llyY4AEwEu6/yeGb0tC3G6n9NgPHVcS+eOV3pw=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
        "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v4] doc/gitcli: minor fixes
In-Reply-To: <xmqqo6bf3yxh.fsf@gitster.g>
References: <20261115070357.113875-1-dirk@gouders.net>
	<20261123-b4-gitcli-v4-1-de130d0e07e6@gouders.net>
	<xmqqo6bf3yxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 24 Nov 2026 07:00:48 +0100
Message-ID: <ghcxrulqen.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 23 2026, Junio C Hamano wrote:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> - Reword the commit message and clearly list the changes
>> - Fix a typo in the first rule regarding flags as suggested by Andy Koppe
>
> OK.
>
>> - * When an argument can be misunderstood as either a revision or a path,
>> + * When arguments can be misunderstood as either a revision or a path,
>>     they can be disambiguated by placing `--` between them.
>
> Hmph, an earlier iteration I saw had "by placing `--` before or after
> it" and talked about a single argument.
>
> https://lore.kernel.org/git/20261115070357.113875-1-dirk@gouders.net/
>
> And I thought it was much less error prone than this latest version.
>
> "git log main next" where both main and next exist as both a file and a
> branch, and what you meant was to trace the changes made to file 'main'
> up to the tip of the 'next' branch, you cannot just put `--` in between,
> i.e., "git log next -- main", but the new text does not tell the readers
> that they may have to swap.
>
> "git log main" where main both exists as both a file and a branch, you
> would do "git log -- main" to trace the history of file 'main' up to the
> currently checked out commit, or "git log main --" to show the history
> leading to the tip of 'main'.  And the earlier text captured exactly
> that.
>
> So, while all the other parts of this v4 may improve over v3, I think
> this part is a regression.

I'm very sorry.  I used the additional round to try to migrate the
running topic to b4 and obviously failed in this detail.  I didn't mean
to change this back to v1 -- your review comment to v1 was very
understandable.

Dirk
