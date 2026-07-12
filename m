Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1FA370AED
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884798; cv=none; b=bmRnugzkKa9oNWyzeyRUQ9JFIYdeSUMzqvoB++B8UWomWqrJfvrD3PwUmiOPdGOfsdml5t9/ZrC7aJstyxc18TdKsXMmMonLfyFWYTpEPsvLAGwAu5axJCo3UFZU5GDT2GVGVDr44DqEYqp67GVVVx5Bu7rV0OpFuvDpXNmaR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884798; c=relaxed/simple;
	bh=4po1Ck8MUxUAhrAxFixdrz+tDGLjXgyPKwfiNFPYLdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqCyLeR1irP1JX5xkPcuYK0Yc+/ijm9m7xoSnYkjVorDKbl018EfYSEVolyFq5cm1pgsU9uySQxhKnRfxBjIfypP5eVuXe1ztZV070O7rLcn8KwFq90NxU1mrT6Y9SXowiMiOV0xA5TX77UbMw+p2SQsirsmO/OlJAh2WCZVzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=PV5Ird5j; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="PV5Ird5j"
Date: Sun, 12 Jul 2026 21:33:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1783884793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QCpo1APIOjKoEySQywu9TRvwNYyI27zOsHdkTbhOaHM=;
	b=PV5Ird5jXlNwSQas+ZLvWfZv60wPScWkINTTDwjtJ4kkUcwPoqosVXmHILihqcjBJzQsK+
	b1gAD3ZnQh2mGvGHth89faPe7RFvPQ8pbbcS7W+AWLQA9pRglxPZB2x6ha0PsM3pdfieH1
	DmJQ+ni2Bm3cMqneO8tFpAfKrIZK39ZQlbsnneombX5BMmZEzVYHe6Ekr3SlIAV4ZIZwjQ
	QGZYP3BvmFIxbFBvbFOxXIlzarcrkgQzKfG9s/IlxM+A5hRdO3lpbPyL74JeaEWi6Ft7jm
	LncgQ2zpGTfWkqc4Mfx6A3/HBumD2HLVPWGS3HCHmH3SD9czIHVLane0b4rPvg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org, 
	ayu.chandekar@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v9 0/4] graph: indent visual roots in graph
Message-ID: <alPqaebsr2OPQk5H@exploit>
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <alJOgYmAfGg37hsB@exploit>
 <DJVUU76PUXR4.2BYRTA8SEEBVC@gmail.com>
 <alJpjTXfZmYQccwk@exploit>
 <CA+J6zkQcHu-LVKE-1ypfT=59gEzo4qBzi-pmhSJNC_udCDCJZg@mail.gmail.com>
 <alOOXKGIB8BqACxR@exploit>
 <DJWR4GEV14P4.3G9N0ZL1R8VDL@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJWR4GEV14P4.3G9N0ZL1R8VDL@gmail.com>
X-Spamd-Bar: -

On Sun, Jul 12, 2026 at 06:59:58PM +0200, Pablo Sabater wrote:
> 2. Ambiguity:
> 
> If it happens that the visual number on visual roots meet the condition
> (number_of_visual_roots % 3 == 0) and the next commit is NOT a visual
> root this would happen:
> 
>   A
>     B
>       C
>   D
>   E
>   E
> 
> Which would be ambiguous. The solution is to check with the lookahead
> buffer that we have since patch 3 if the next is a visual root, if it's
> not we indent D anyway:
> 
>   A
>     B
>       C
>     D
>   E
>   E
> 
> Which I find the pyramid effect uncomfortable.
> What about capping at 4 columns?
> 
> 1.
> 
>   A
>     B
>       C
>         D
>   E
>     F
>       G
>         H
> 
> 2.
> 
>   A
>     B
>       C
>         D
>     E
>   F
>   F
> 
> I prefer the 4 column wrap because it looks more abrupt and IMO shows
> better that the commits are unrelated.
> 
> What do you think?

I agree, warpping beyond three levels instead of two would resolve this
ambiguity.

> Also, about the no-opt option "--no-graph-indent" is still wanted
> regardless of the final design that we choose?

Yes, I personally wouldn't want indentation on non-oneline formats.

Thank you.
