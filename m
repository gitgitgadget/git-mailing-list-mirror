Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD01126C05
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735424848; cv=none; b=N+li5IhHGc9t98vTYnPJWN65+Exg8CrmH7wKEaJ66GrhV3nFS6yHDjupQLyfRxe8HLZMg5pM7PPm3vV2ZX6pByEjIHoPMMw75B9H1wMd/ct8yFNm9wxCoxeG0/KauUJPbEyV8Su6DFVd6UY5+U6ZwDc55jvTn1YBQqZgNJei1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735424848; c=relaxed/simple;
	bh=EkROcoi1o6j6twKhXURdW23TJ2xjp1XldjWP6wqbEX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmPZd6nkzW4J+3/DO02gEwoYUUvWEsquOIhDfLcXJieH8RSAn7WoDZOH184dXKbHuVCrz5GCAM3Xy8eh35rt86dOZ5Q7CDVeikPV9xvuAy2sah7vA9Pag9J7sYjq12iWMKia/gDiFCqQ55nwH3dfpM4UWTPYuM0Ng4PmzCR+WzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pGQC5O3x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pGQC5O3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70876C4CECD;
	Sat, 28 Dec 2024 22:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735424846;
	bh=EkROcoi1o6j6twKhXURdW23TJ2xjp1XldjWP6wqbEX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGQC5O3xpbbaBP3fKVM3QZ2o0bRNrd9dL0ZSO/BPpY2Ejx7jtZoNqV/zpAh0BBAmF
	 n/GtttDquRu2Y9RatdzwiMidrx7+aBA7G7QL6liQpt1JZWrGeVXKJVnsHYd2lcTzKH
	 7eU72aVyG0exVEhmRbjIKGJJoWF5icP2Fl/49sXM=
Date: Sat, 28 Dec 2024 17:27:22 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [fingerprint] of github.com
Message-ID: <20241228-naughty-satisfied-binturong-32b43b@lemur>
References: <ROrCxOsQ6KcZqO7YsIr2BGbPsmyUYAHXgF-l3Pwg0-7Z12oBWFrwy4yzgax9Zq6whGT4Fh4gKQxMNlHEoEOBljSvucyX9sQyc3rtT3NT0us=@proton.me>
 <20241228-stylish-beetle-of-joy-9be836@lemur>
 <Ai7oUOle2gNhbxgAMTtbayo6Quf4YRgJbFIYYSqUHdgNoJL89fv7P7gYIHNnmlzLn77z0n3KI6HI09_VUmsku4qZ1wmudP0eEb9GN89PmMo=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ai7oUOle2gNhbxgAMTtbayo6Quf4YRgJbFIYYSqUHdgNoJL89fv7P7gYIHNnmlzLn77z0n3KI6HI09_VUmsku4qZ1wmudP0eEb9GN89PmMo=@proton.me>

On Sat, Dec 28, 2024 at 09:12:14PM +0000, A bughunter wrote:
> >  Please do a modicum of effort before posting to the list. This is literally
> >  the first hit on the search engines:
> >  https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
> >  
> 
> Yeah, but you should post the keys in the community incase an attacker would
> intercept, block, or change those posted in the official location.

You have to keep two things in mind:

1. This mailing list has no relationship with GitHub.com. This list is about
   the software, not the hosting service that uses it.

2. The attacker (e.g. me) can also modify the archives of this mailing list to
   put whatever they want there, so you should absolutely not use the archives
   as a source of any kind of truth. :)

-K
