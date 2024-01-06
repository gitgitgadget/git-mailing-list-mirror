Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204446A6
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hYUjX05F"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704524802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9FG8GBiSKrkUBUrq/KEUHHTCfAnKcJ7N0JL7lkQhMA=;
	b=hYUjX05F/r6UfTHI4IRRThtZhYfm8N2TH1QZEVsXnYOdrHgOixoHFb4qc8itldqarw4SZI
	lchSTCFQk8P7pvP6iLGdSTmnSLhgPreLpe92uQA3UezW5auiQoqdPZF0hNtRTOZjtp+4Mm
	PMUiLQNlAoTWIFLY4MopAXcBakaZMJ52lp7WjFFVjd4KdlXeoWun3iNGMApe943cA0PjWE
	MZfTUY/bHctovDMLoPrtwCKBuOfxr1tA9WeF+FndK5SSmPdmVT7apFyp7WCBrFpJULiWYf
	w+c6k/h+ogKnwpm9mAuEf84JTjPj3+6kuDCS6XY+o3Lyth1kv7Iq+YBXMb3Rlg==
Date: Sat, 06 Jan 2024 08:06:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Junio C Hamano <gitster@pobox.com>, Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZZjar4li8R7Uo0c3.jacob@initialcommit.io>
References: <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io> <ZTbVY7Nf+DTYqHky@ugly>
 <ZTb/HeILRHnZjaz6.jacob@initialcommit.io>
 <62164acf4a787042dbb6e5abe212559b@manjaro.org> <xmqqil6w6al3.fsf@gitster.g>
 <8d45763bb4fa4c7d1e1f69dfaf93e647@manjaro.org>
 <778c4540924ad076269ac72097cf3789@manjaro.org>
 <ZZjar4li8R7Uo0c3.jacob@initialcommit.io>
Message-ID: <32c16092c33682a09ef586a4c719f9a4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-06 05:44, Jacob Stopak wrote:
> On Fri, Jan 05, 2024 at 08:14:34PM +0100, Dragan Simic wrote:
>> 
>> Just a brief update...  Some of the associated patches are already 
>> ready to
>> go, and some more are still pending to be implemented.  It took me a 
>> while,
>> which I apologize for, and now I've also unfortunately contracted some
>> really bad flu.  I'll be back to the patches as soon as the flu 
>> decides to
>> go away.
> 
> Hey! No worries - thanks for letting me know. I have been thinking 
> about this
> and am looking forward to getting back to it.
> 
> Hope you recover quickly. Please include me when those patches are 
> ready. Then
> I will try to align my previous patches with them and also I have a 
> bunch of
> restructuring/refactoring to do based on the previous feedback from 
> Junio.

I hope to recover soon.  It's been already about two miserable weeks 
since the flu symptoms started, and it has since moved into my lungs, 
making things much worse than usual.

Sure, I'll also include a brief summary of our earlier discussions into 
the cover letter, with the links to the mailing list archives, to 
provide context for the patches for everyone reviewing them later.  
Looking forward to these new git features!

> Oh and happy new year.

Happy New Year to you too, and to everybody on the mailing list! :)
