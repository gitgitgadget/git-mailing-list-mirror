Received: from mrbrklyn.com (www2.mrbrklyn.com [96.57.23.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B516433
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.57.23.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705798064; cv=none; b=Q9QQ/aiofZt8iJjcv9HGFXFQoca03s2foDOaFQ1C0MGK599gwG7c0UYj3YTszfLGyZJaAaf6eJ1rW5VSY77/kNa9YtchM7gDBFahEJcrwDEvfPfm10u1Ggehj2FHG6O7gzsb5P6yOOzrviFYjOLzbBNRvmnfB54PtuJkb13wu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705798064; c=relaxed/simple;
	bh=2SRYpGw6QRtgv/Ha/BiPoI44hwSaXYR+TVPdJQ4kA40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUXMg5+x7kOR1porWhVr5BwOnKoozLvBE57sDf3g7dwoX028ky9pcFD+jBY9OtrRe8Qopl92o61gKIvUFSVecc+JwD3pVUD9QAxnm0dYhFkfNCb/FYJw9KzU9KKx4Bli/gNaRXytHrdLmHXGZanw6yKd8Lugm7keqzbe0ndRje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrbrklyn.com; spf=pass smtp.mailfrom=mrbrklyn.com; arc=none smtp.client-ip=96.57.23.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrbrklyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mrbrklyn.com
Received: from [10.0.0.62] (www.mrbrklyn.com [96.57.23.83])
	by mrbrklyn.com (Postfix) with ESMTP id 4BEE21640A3;
	Sat, 20 Jan 2024 19:41:01 -0500 (EST)
Message-ID: <de816c41-6889-4178-add1-7c2bf636640d@mrbrklyn.com>
Date: Sat, 20 Jan 2024 19:41:01 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Full disclosure
Content-Language: en-US
To: Michael Lohmann <mi.al.lohmann@gmail.com>, christian.couder@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org, newren@gmail.com,
 phillip.wood123@gmail.com
References: <CAP8UFD3g_N+JJ_cdas2ZdsBPxuQFBXW8yY+1nC6AKvQppOYaDw@mail.gmail.com>
 <20240117174125.22915-1-mi.al.lohmann@gmail.com>
From: Ruben Safir <ruben@mrbrklyn.com>
In-Reply-To: <20240117174125.22915-1-mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


https://www.zazzle.com/idit_aharons_tzfat_original_backpack_design-256246398431855710

On 1/17/24 12:41, Michael Lohmann wrote:
> Hi Christian!
> 
> Yes: I agree that the current state of the last submitted patch in that
> discussion is far from optimal.
> After Jeff Kings explanation I had a much better understanding for the
> situation and the reasoning (and his suggestion was definitely better than
> mine).
> 
> I had already prepared a new version which tackled (I think) pretty much all of
> the criticisms. But then the above mentioned message came in and when I read
> this:
> 
>> [...] they are trying to be different for the sake of being different, which
>> is not a good sign.  I'd want our contributors to be original where being
>> original matters more.
> 
> I am reading:
> 
> 1) I am "trying to be different for the sake of being different"
> 2) Contributors like this are not wanted
> 
> So yes, I do understand this as a general statement on me as a contributor
> without any proposal for me at least to explain the situation from my side.
> 
> I teach my colleges not to name variables with how they are initialized, but
> with what information they actually convey and I found the "_NONE" one at least
> misleading in its name.
> 
> So in the initial discussion I was a bit stubborn, because Philip wrote "I
> don't have a strong opinion" and from my perspective the only argument was
> "over there we also do it that way" (which _can_ 100% be a valid reason), but
> Junio C Hamano did not even acknowledge my criticisms of the other the variable
> name. I am totally fine with a decision like this if done consciously, but if I
> don't even get an acknowledgement, let alone an explanation, my demands I place
> on my code quality are that I write the best code I can. And with all the info
> I had (prior to Jeffs message) I did still favour my first suggestion.
> 
> In my eyes it would be helpful to at least tell me what your (in my eyes not
> obvious) preferences are on naming things, because otherwise I will rather
> stick to my standards than blindly follow a single instance of other code where
> I don't even know if that was a concious decision or it just happened by
> accident.
> 
> So no, I don't agree with the assessment of point 1), but I still read the
> message like that. I will accept it and instead use my skills in different
> projects where they are indeed valued.
> 
> Cheers
> Michael

-- 
So many immigrant groups have swept through our town
that Brooklyn, like Atlantis, reaches mythological
proportions in the mind of the world - RI Safir 1998
http://www.mrbrklyn.com
DRM is THEFT - We are the STAKEHOLDERS - RI Safir 2002

http://www.nylxs.com - Leadership Development in Free Software
http://www.brooklyn-living.com

Being so tracked is for FARM ANIMALS and extermination camps,
but incompatible with living as a free human being. -RI Safir 2013

