Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994049641
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201168; cv=none; b=aDaRxlW5MOSlwxuoBx48RR2vHUh8d7NG3m6n/TM/hjiNvtWIMwMsxyI4RlL1SBIfwY1iQlvb/RC5Cnfc2qhavAPz1PE3bwJ38APz0TY/k0mDbJ3Ssb4L0UcBzONKlf6FR2vseAFgjEJUZmNBqNF4prBvJHIzn+9hbvnolX0DLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201168; c=relaxed/simple;
	bh=pJ2+iMu9SqKkYG7gpSpO0cVqfJ23ZpR7TdxudFYqVho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqqAS48s5yYW9jDTVHyQzKHTVPcpJ5TkDJNKpUblnO4kkfChX6nRFLg0oX3l9g0XKOjaX49a/94cpTfNDX49+17La+W+ng2kwuKdMSnJkSQKJTso6E68Hzo4XQ4+9vlcyeL1lRaSJdxU3nqlmFviHdnu/nsdai9+4yDk6jD1k20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FLqNLPck; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FLqNLPck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230B9C4CEC4;
	Tue, 24 Sep 2024 18:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727201168;
	bh=pJ2+iMu9SqKkYG7gpSpO0cVqfJ23ZpR7TdxudFYqVho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLqNLPck7Ws5WjA/Ar2O8VbOT1z7RzvH0Myl1t4obH7YuL2gojTeaBtUv02uq6qPw
	 UzatGJgt4E7HOhckolmHeHIA9qR2E2d/z/axF4SXj7jM7NVqRAu7SfB/q7h6uo+Tgk
	 X+Zj1iFL4jzwdakgxuVrQbFEwLgDj/7MbPjybviY=
Date: Tue, 24 Sep 2024 14:06:07 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
Message-ID: <20240924-sawfish-of-exotic-fantasy-b6abdb@meerkat>
References: <Zu78E+0Uk5fMSeQv@five231003>
 <xmqqsetr5wl1.fsf@gitster.g>
 <20240923-spirited-lime-lyrebird-fe90d5@lemur>
 <xmqqbk0exdk4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbk0exdk4.fsf@gitster.g>

On Mon, Sep 23, 2024 at 02:31:07PM GMT, Junio C Hamano wrote:
> > I can chime up and offer bugspray bot integration for the list. This is a new
> > tool I've been developing for integrating the mailing list with bugzilla. I've
> > been using it on the tools mailing list over the past year with reasonable
> > success.
> 
> Intriguing.  Everybody loves to hate bugzilla, but would bugzilla
> become less smelly with bugspray enough to make it palatable to all
> of us?

I'm happy to enable it for this list if you'd like to try this out. It doesn't
really create any obligation to use it, but it may end up being something
useful.

To enable it, I only need a list of people who are allowed to trigger bugspray
via the "bugspray track" trigger phrase. I assume it's going to be more than
just you?

-K
