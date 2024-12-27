Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6713C807
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735336272; cv=none; b=MURYFNXbrgS2/SAJJDMoFQoSK24BDf8kZUVpkIWOD47uZZHcuNCTmkr53AKGy22U+6vMiFbozB/8iQ1LutgAFoO5frUb2KRuWaIavvGRN4Q3nYaeqyDX1ipEZblI+MI8ILlPvyW0gjUugnKvOWaQnmW5juv1VK175Snymbt8Y1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735336272; c=relaxed/simple;
	bh=gb6yNbb3qb4K0bB3OSDTYSIinvA9of1jXQyM2Egn1DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhKZIzwdj2YZjIzcXPDZa7zS3H1PE9sobAZSuhqn0LZZTXRuKtQgJEgfOOSpMBYeuiD9MJ94Qml9UGW9Y9m3nvEZVh2dJG53T3dyINf3N73CWUGdcDLvgfK1iew+dcFTeXnDHMnp6g94NKF8Rvb43FO55sUK4lHcoDt9CMT7GdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FeYzXnc9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FeYzXnc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659F2C4CED0;
	Fri, 27 Dec 2024 21:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735336271;
	bh=gb6yNbb3qb4K0bB3OSDTYSIinvA9of1jXQyM2Egn1DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FeYzXnc9h/ZwA8bwujrkDU7mDAkuplkqkeotoqVgfvbPq3hR8ZC1xqOqtS2bQnL0b
	 nX1T9RuGGoljqQEw8jFNUwrFDANm0RJD0JKspZkZJzmrs+rrPlemhHKCH0C8sUeBfs
	 Zg6T8ynKFL8TnE/mp+rdP2vqtxMDiBGnnp+1hgHU=
Date: Fri, 27 Dec 2024 16:51:07 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [help] can nobody get me an email
Message-ID: <20241227-positive-cyber-guan-b3891e@lemur>
References: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me>
 <hzyhvw4pe42yqbuqdbgl5bgnxz2kd5mxxh6jnklnqwvembueqv@b6oaetnegprl>
 <s44De1e7kjF5OIY_YVaSJ0DdAavD-4WeZ3XrrA7XJLJO67ShZWLM9Sb1ywSUq58wmCWOTkRfhBBOvw1qCpiiUyygy53wFTetUECruyO1SEw=@proton.me>
 <TpuMiCTLZ7JDXxJPgVNqcYXWFavK4asar9Gk9uJiiYp1nbqmKlP22mX6xiDOKHKr5yaN7ZH7jXoISqIY67wmbFfz8i8MsYokeomQu_6Ytis=@proton.me>
 <ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF_I6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF_I6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=@proton.me>

On Fri, Dec 27, 2024 at 05:02:49PM +0000, A bughunter wrote:
> How do you move this mailing list to gmail this is too much for my proton inbox here.

You can also read it through nntp:

nntp://nntp.lore.kernel.org/org.kernel.vger.git

https://brennan.io/2021/05/05/kernel-mailing-lists-thunderbird-nntp/

-K
