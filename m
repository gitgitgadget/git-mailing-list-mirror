Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170B84FD0
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814008; cv=none; b=ZeyCywnVTsEN8xUP+W2K6vkE9UI3a8vXTmZ8PaEymx4jJ3sf0QerDTulTuEgPWIROjIZFF3be5GdVZCMTE6Ph6Akk3aEH7zvU7DsTKQpMhmJxzFUc3gqkZPNo/8pKjVYcJqeBfbNYR9N1UuUrQiszaG2oRCHdmzItVKDWOfVI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814008; c=relaxed/simple;
	bh=awdexd4TUz/GZKbQ2D3Bbc23e9P+36Yu8ivJC+eP2Ek=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZgJ0j9AOuZ9h6eNrGNKzNLh9nWykZa/VKHF5sClHqAU/fmbCujCpyb2rXqSLt0ZbJFtKym2H2Y7UNwx5BySGniosQXETNLOSK/RxaypHd8LHJGH6JKqRWk409xbVU9WkZz3Tp1LK8ozOyioai1ML6abF4+t0o1ifIJjRiqzKrI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=yxOpKm/U; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="yxOpKm/U"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706814003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz3oBWchhfsK4ClzxjP2DCFN5xcpr87ELgamWv1N/VU=;
	b=yxOpKm/UFxDfdJpKABe2lmtOzgpcdZH02sg9LouJQWMhyD/Tn7zoCZ+mtk5ouKGldoasAF
	iID0vau6qUrc19Ya2BlV0fcF3zjjy0xGC8NbNetI7w8WRiWie7JPFN2ZoVuRZo3a86ddla
	d2JivDgaappcV6cpIJd5TC6WJakDFjRqmnH+CDSoPbSGN16b5Cbqz1eoPSLvusOfrFYtBj
	e5Df1Z1YrYWg+Vpi/ZWT+TOODsY30RkU1S8E7wWlCYvSp0kz10+j+4ofM9Gid/i6L4errK
	sgD2Rj6IlLUpcTwTLfLyrdnqWlDTbS7gsLQiSnNtWfRLrBdd28jpxOXgQR9Hkg==
Date: Thu, 01 Feb 2024 20:00:02 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Hans Meiser <brille1@hotmail.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
Message-ID: <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-01 19:36, Hans Meiser wrote:
>> Could you, please, clarify what kind of git documentation are you
>> referring to?  Are you having git man pages in mind?
> 
> Yes, these in particular.
> 
> From my point of view, many of these are quite unorganized, hard to
> read and – as I believe – need a fix-up. Markdown could replace the
> currently used language, so editing them would be more easy, proving
> support for preview and lint the documentation.

Please keep in mind that editing the git man pages requires very
intimate knowledge of the related git source code.  Many times even
small changes to the language style can change the meaning and diverge
the man pages from the source code, making the man pages useless.

>> Quite frankly, I think you've missed some important points from the
>> Konstantin's message.  To sum it up a bit, not having continuous 
>> support
>> is simply unacceptable for any kind of a long-term project.
> 
> As I wrote, once installed on-premise, no-one will shut down an
> on-premise git server except for yourself. It can run for eternity.
> You just need someone to administer it properly and publish the
> website.

A git server?  I was under impression that you proposed running an
own instance of GitLab or something similar.

> In the end, it's all just about git. You may create your own git
> webserver (https://git-scm.com/book/en/v2/Git-on-the-Server-GitWeb),
> or just use an existing one, like the GitLab server:
> https://about.gitlab.com/install/
> 
> In these servers, everything is configurable. Moreover, many plug-ins
> exist for plumbing extensions to these providers. It's possible to
> establish your own workflow, rights management and automatic handling.
> You just need someone who is an expert with the tool of your choice.
> 
> Many other great repositories already are using one of those
> providers; Meta, Google, Microsoft for example share their code there
> – just to name a few. I wouldn't consider these users as being known
> for being exceptional risk-takers.
