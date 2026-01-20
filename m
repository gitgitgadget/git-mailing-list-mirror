Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAFD47A0C8
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937077; cv=none; b=IgIJRDBK1oLKu8RVoxXXjUAYdWiPP2RL0fleM+cqgLs0GiVmnpUQrS5w9T6aGzCeV5w7QZX1s0HymFVlSnH4MQdvwzqwwhlX2Cqf5O8r7yOLppxOGq5O0FHA9rtARprNogzscKjSxUfrcZQ0iW4mOSZXN+gBNiD8lvQCRs1TDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937077; c=relaxed/simple;
	bh=sZgDOMRIsUJ4Dc/pNgrHIhFGCCxiCQaBE0rTgrE4IvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhZmSMY9Diw0qPK3RioctfH4PHpMTTxb84Nvn1nQ3ytx3UXR0MlzoHYXfLa4NofDP7Nw++jwlAfsfG1Mnlic+TugDhqBMtLMKDb9EgKN4vVjLsEGNtTRt2FG1xjpucf/g7nzStocvOlc5MuP4GMsQDPal3ZBXy3dKC7MoS1eO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AUXvsWAL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AUXvsWAL"
Received: (qmail 116768 invoked by uid 109); 20 Jan 2026 19:24:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sZgDOMRIsUJ4Dc/pNgrHIhFGCCxiCQaBE0rTgrE4IvQ=; b=AUXvsWALwx62sCKrlSUIgqRp+VnvXLkE5CIO3/5szpLW/yb6k9nf64eLG0wivR7e3Mz+MJnvVkZbOv9zMiE749iCnWZarPs11yw8HP8MC9/o06Nko1SfudhB4X0wGPK2cwK3UHsv4cUqbqO2t8+1tnuyQjZbidu4igbEKjF0FroUEbVJAd9dvK37R+tiWgQPWNrmbWoUwMziB1t4sVpQ9gUPvlYXB2ljo27Fc/ADPkK+k07vnvpPzX0lDJsYZ1D75Ys2/NJqs1f1rYTdJ/DRy5W4gAmgp//jD1Iwe4f3Sa5A2vjAGtEBtaqMlHgp6omAPZz2Q6hDpxAxw+L2v25DZw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jan 2026 19:24:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 183948 invoked by uid 111); 20 Jan 2026 19:24:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jan 2026 14:24:26 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 20 Jan 2026 14:24:24 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] mailmap: add an entry for Phillip Wood
Message-ID: <20260120192424.GA3295894@coredump.intra.peff.net>
References: <f10c3f680d58ca0abbf795ae8b0f2ad14ab85419.1768906910.git.phillip.wood@dunelm.org.uk>
 <5a4e7da4-d295-4beb-9f37-b2ce4e10df35@app.fastmail.com>
 <xmqqtswgywb4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtswgywb4.fsf@gitster.g>

On Tue, Jan 20, 2026 at 10:26:55AM -0800, Junio C Hamano wrote:

> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> 
> > On Tue, Jan 20, 2026, at 12:01, Phillip Wood wrote:
> >> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>
> >> While all my commits appear under the same address, other addresses
> >> appear in some commit trailers. Map those addresses to the canonical
> >> one.
> >>
> >> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> >> ---
> >> I'm not sure if we actually remap the address in trailers but
> >> we've certainly talked about doing it in the past.
> >
> > Yeah it does.
> 
> Hmph, are you sure?  My quick experiment tells me that the trailers
> are not munged.
> 
>     $ git show --pretty=fuller -s | grep '@'
>     Author:     Patrick Steinhardt <ps@pks.im>
>     Commit:     Junio C Hamano <gitster@pobox.com>
>         Signed-off-by: Patrick Steinhardt <ps@pks.im>
>         Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     $ cat >>.mailmap <<\EOF
>     Junio C Hamano <no-such-user@google.com> <gitster@pobox.com>
>     EOF
>     $ git show --pretty=fuller -s | grep '@'
>     Author:     Patrick Steinhardt <ps@pks.im>
>     Commit:     Junio C Hamano <no-such-user@google.com>
>         Signed-off-by: Patrick Steinhardt <ps@pks.im>
>         Signed-off-by: Junio C Hamano <gitster@pobox.com>

We do apply them in some places, like shortlog:

  $ cat >>.mailmap <<\EOF
  Junio C Hamano <no-such-user@google.com> <gitster@pobox.com>
  EOF
  $ git shortlog -1 -ne --group=trailer:signed-off-by 3f051fc9
  Junio C Hamano <no-such-user@google.com> (1):
        doc: patch-id: --verbatim locks in --stable
  
  Kristoffer Haugsbakk <code@khaugsbakk.name> (1):
        doc: patch-id: --verbatim locks in --stable

As you noted, we don't necessarily know that a given trailer represents
an ident. But we try to parse them as one (not just for mailmap, but for
stuff like "-e"), and if that doesn't work leave it as an opaque string.
That all comes from 56d5dde752 (shortlog: parse trailer idents,
2020-09-27).

I _thought_ we added support for %(trailers) to handle mailmap, too,
but...

> Or perhaps your "Yeah" is about "we've talkined about doing it"?

...yeah, I think this is the case. There's a proof of concept at:

  https://lore.kernel.org/git/YW8A5FznqLYs7MqH@coredump.intra.peff.net/

but nobody ever took it further (I do still run with it as part of my
daily build, which probably enhanced my confusion ;) ).

-Peff
