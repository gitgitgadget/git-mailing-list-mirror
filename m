Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C949208BC
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkXIt778"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CB0C433BD;
	Thu,  9 Nov 2023 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699546140;
	bh=w9nw5Q634nmAOkXRFgWXXKqx6MpHh4xMwZ8PI4BTli8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vkXIt778MB5f5O7bgUPHVXRX1/2QPnkYdQE7q0z5bQPHcw2t+6cxjtsIrXrNSNKSz
	 hsrbKr3KAOrwPUEfeJPLNca7j6HSr6HHEF4vpDooenhnrJP9ZVBjVRpTOvkXmkkQf5
	 7j9BOpyHrMgA1g1YbeWVZznxzWvmir/bLKTlBXa0=
Date: Thu, 9 Nov 2023 11:08:58 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <vooebygemslmvmi4fzxtcl474wefcvxnigqeestmruzrsj5zsu@5kkq3pveol6c>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
 <ZUz6H3IqRc1YGPZM@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUz6H3IqRc1YGPZM@debian>

On Thu, Nov 09, 2023 at 04:26:23PM +0100, Alejandro Colomar wrote:
> I used it for sending a couple of patches to linux-man@, and it seems to
> work.  I don't have much experience with mutt, so maybe I'm missing some
> corner cases.  Do you expect it to not work for some case?  Otherwise,
> we might have a winner.  :)

Since it's a Linux project, I suggest also checking out b4, which will do the
mail sending for you as part of the contributor-oriented features:

https://b4.docs.kernel.org/en/latest/contributor/overview.html

We also provide a web relay for people who can't configure or use SMTP due to
their company policies.

> > > Would you mind adding this as part of git?  Or should we suggest the
> > > mutt project adding this script?
> > 
> > IMHO it is a little too weird and user-specific to really make sense in
> > either project. It's really glue-ing together two systems. And as it's
> > not something I use myself, I don't plan it moving it further along. But
> > you are welcome to take what I wrote and do what you will with it,
> > including submitting it to mutt.
> 
> I'll start by creating a git repository in my own server, and will write
> something about it to let the public know about it.  I'll also start
> requiring contributors to linux-man@ to sign their patches, and
> recommend them using this if they use mutt(1).

B4 will also sign your patches for you. ;)

-K
