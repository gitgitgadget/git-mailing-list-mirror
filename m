Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A556B96
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698416; cv=none; b=ItsPPwi4fe0ZLilSW8/1jntco+nszAQDRLA1fyDibJgtaTvuV5uUUTnWGZ3SC0kzHLWAuluwNvyb3OtIDAVnCEoPJM7NLuVHU8pN8APYOzmPdT7FJresIDCJ+3dBG5r0nG6UKVV38rdDOe6tD81g4z6QhkIN9N0eZZyKWU3tEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698416; c=relaxed/simple;
	bh=kFee43l/Bww6Z9EsrzxHy2D28cFL6m/nDxzx0GpmMmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYzbZ/m9QHYlDutDf8OKXB3MF0Y1CAs8HHixrr56Tbm8ItfDrqM/7ltONJBYweffnLzpOxC05Lwu1PS7peKzBFDMLo42o6/sJQzV49D6amW61VgTkZq/Xf4ukBg0drmHzd70072be12Sz9jfK2QgfyeuEmtUw8hvKqN7pj+9bqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BPsBgldS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BPsBgldS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF50EC433C7;
	Fri, 19 Jan 2024 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705698416;
	bh=kFee43l/Bww6Z9EsrzxHy2D28cFL6m/nDxzx0GpmMmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPsBgldShF+/uk+boeLcZhl+1dU756IbbGwAZhyU0iHtLVXA6Y83REtTkn8KBl9vp
	 EyYdd++TE96RxhJF6/NuFwAyBvtNX6JgTairOdQQvPMr4O0pV7+zvEjwx6yG0SPWZm
	 rn17z5jal4oYwCQjMhlsEIIIcnl5IG/w3xjlICWk=
Date: Fri, 19 Jan 2024 16:06:52 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: spectral via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, spectral <spectral@google.com>
Subject: Re: [PATCH] MyFirstContribution: update mailing list sub steps
Message-ID: <20240119-flat-jellyfish-of-drizzle-b31abe@lemur>
References: <pull.1644.git.1705697955144.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1644.git.1705697955144.gitgitgadget@gmail.com>

On Fri, Jan 19, 2024 at 08:59:15PM +0000, spectral via GitGitGadget wrote:
>  contributing are welcome to post questions here. The Git list requires
>  plain-text-only emails and prefers inline and bottom-posting when replying to
>  mail; you will be CC'd in all replies to you. Optionally, you can subscribe to
> -the list by sending an email to majordomo@vger.kernel.org with "subscribe git"
> -in the body. The https://lore.kernel.org/git[archive] of this mailing list is
> -available to view in a browser.
> +the list by visiting https://subspace.kernel.org/vger.kernel.org.html and using
> +the `sub` link next to the `git` list (this is a mailto link; you can leave
> +subject and body blank, but you still have to send the email). The

I recommend just telling people to send a message to
git+subscribe@vger.kernel.org and linking to
https://subspace.kernel.org/subscribing.html for more details. While
"sub/unsub" links will do the job for some people, webmail users may not
have things properly configured to correctly process the mailto: links.

-K
