Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDDC28383
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="piElhSsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C39C433C7;
	Wed, 15 Nov 2023 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700077509;
	bh=00ZyqmVo2Xa+NBqh5tkohVXQiqZUrVIIQudzG9YDVWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=piElhSsnLoSQI7LoVkLeU/xc6eOz5lxtAO5t8RrmNt5leTaY/4oBaXF+NDILhAiAX
	 ZCWZclfsmR7WqXl5+YFtJWkZqpbOIl17pjOpTvtwJlFOvvd/FgFtLiUleMmnl2qpvP
	 yIkh/sGYoeZ40gkMEiDX9IApEvckYJx48HLr8MLY=
Date: Wed, 15 Nov 2023 14:45:08 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alan Dove <alan.dove@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: "Received" misspelled in remote message
Message-ID: <20231115-funny-marvellous-coati-f0ec9f@nitro>
References: <4e76dda1009a8365a1d66d9594865a4af31ab418.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e76dda1009a8365a1d66d9594865a4af31ab418.camel@gmail.com>

On Wed, Nov 15, 2023 at 01:46:10PM -0500, Alan Dove wrote:
> Hello:
> 
> Using Git 2.40.1 on a private server, I see this message whenever I
> push a commit:
> 
> "remote: Recieved update on checked-out branch, queueing deployment."
> 
> "Received" is misspelled. 
> 
> I realize this is a very minor issue, but it should also be very easy
> to correct. As someone who suffers from Proofreader's Eye, this error
> deals psychic damage to me on a daily basis.

It's most likely coming from some CI/CD hook deployed on the server where
you're pushing, so you should reach out to your IT to have the spelling fixed.

In other words, the message is not coming from any software that is managed by
the git project itself (at least, nothing matches "recieved" in the git
repository tree).

Best regards,
-K
