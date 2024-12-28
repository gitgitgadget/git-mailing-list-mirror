Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655D635
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735372848; cv=none; b=q+ck/8AevIVpmBBwTllAg9U/36CmEKaZGNStWDNkDtVIqQk4i95IBNlQz4KvAUv50bMYMOkYSJW7Dqb1v3H8c0LxOPdtdt+a+ovr5K1IhZODhw03tFVfdzz/A54/ZIHm201u/niULM+mewoUV3JRtr9+8pMFiWEbMI5PzFQ31o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735372848; c=relaxed/simple;
	bh=IzgmgLxba2yysv9eWG/Rj7Y0pkKug6L8VmQtw/ijpwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdaJEN4nQgvEKQVXl+s48dNYxeBgK4Uqvkfwm/czmGxgeSkwQBSSqDmwcXl21ylDt7xExbD96Mp8m7CTtDPeP6Atp8U6+/hS/1sZsAKtXCi6NjiL6k65jAW5vaj/cy7ogzM3Y3k/T9h1D2NUK23ByWNpEy4RvfcTefJS9Wc1gfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Umyp1qfv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Umyp1qfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F826C4CECD;
	Sat, 28 Dec 2024 08:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735372848;
	bh=IzgmgLxba2yysv9eWG/Rj7Y0pkKug6L8VmQtw/ijpwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Umyp1qfvohNREuDWGFR3eix4SIWZ3SLSid9QCUkz7Row6UCfIiFVamtHvxocZZBmZ
	 9Ha3ImLZKTUKdmsoOJK22Sd1ZWqDUrQyP7GsIRL0xmLgtLsdZR7L8fGowHG5eGLY9t
	 Ja1N6Oaxp6sl6UZBsTVqltkyEckTqEh8/LLcw+vo=
Date: Sat, 28 Dec 2024 03:00:42 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [help] delivery failed
Message-ID: <20241228-purring-worm-of-competition-ad65d0@lemur>
References: <VqcnQSQNgB_uv7-hDdfxrajqMM1GxbWcWh1iS0jgsAynZrIV06hpHn03LNg3obBw54uBTxtmxPpyCeWO3HIxmrkm4qkS5TOdHmjuUXc5L0I=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VqcnQSQNgB_uv7-hDdfxrajqMM1GxbWcWh1iS0jgsAynZrIV06hpHn03LNg3obBw54uBTxtmxPpyCeWO3HIxmrkm4qkS5TOdHmjuUXc5L0I=@proton.me>

On Sat, Dec 28, 2024 at 03:00:05AM +0000, A bughunter wrote:
> The ML is rejecting all of my posts from another email.

HTML mail is not allowed on this list. Please configure your email client to
send plain text messages.

-K

PS: Note, I'm putting your address on pre-moderation due to repeated off-topic
posts. For help, please reach out to helpdesk@kernel.org, not to the whole
list.
