Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAE2F8BD3
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764917; cv=none; b=nyIKmJH1FrkhvKL5iP/b1zwjCSx76Oi2QiZrTg8w9KwXAOwSpog2xTSiQsiTG5Sa8B979KJSFXA+Eor9UlzBctLzdyHL0NsqXA6z+vtV8Z3hQSp8HFnuXRbUU7pgjQxJvc55xHFpEusZ+s0Vm/3yiJxIs+O1s6YVAyCh2oFxNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764917; c=relaxed/simple;
	bh=L3ALtfa4E5NRvjpTu6sXAkD8Tnq6pqAGmqif2sjLSUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ifj5FvZBxpWc0LDJfZPz2DZKz+0Xt+/q/ujFbGIzvy6lyWxbPmgMeP+mkBX5aw7CmC130G8EGRZ286oEOkjn9cFHH22Fbwnpmfj2yJgJxCY4kUvvytwXrzNqN1mQiui9yWFUAqOf3nVSPfbnNNrFHxlAwfXl1YPLO21S70mDQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=ZxLlMRak; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="ZxLlMRak"
Date: Tue, 17 Mar 2026 17:18:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773764310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvUfdfIjm2DFhNTgMJLB4C88GTc7AZgO4iACn3rAzGQ=;
	b=ZxLlMRak2KnuEzNevWirrD5eq6CNyvbCoLgawJABUU/X2aGxug0DleGbr0qXBX748IWeME
	lgTZw51XbwfAFHhfau0DISbSBreIm8yY6DMGBJNtGVgiPtLSMd2dBeiV5CpkA15iLa2zXK
	uFt5V9mDvmNPmKAgUMfqHL3PAFegMW6e2GSyEkz95HbTAj646Utv4Ar0DIiDUUtLozrwln
	vhlXx0wPxtWH8T7+uNMb36HAISrFDuZriboCGGDVcix22zG1koAB+RetDmtik5sG7I4AKT
	kKbhbKdnJb2TlqwIx0WRE9p20YZt3dM6EVbzPJzlUy/+jO0EeX0BxX/bDqgjZg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH 5/7] format-patch: wrap generate_commit_list_cover()
Message-ID: <abl-U6jJaMQsfxWj@exploit>
References: <cover.1773530191.git.mroik@delayed.space>
 <7be0d6c49d09158739784cc70d17ddcbcd0a1fed.1773530191.git.mroik@delayed.space>
 <f471643e-b434-47d6-9664-e834a92abe6c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f471643e-b434-47d6-9664-e834a92abe6c@app.fastmail.com>
X-Spamd-Bar: --

On Tue, Mar 17, 2026 at 04:32:26PM +0100, Kristoffer Haugsbakk wrote:
> On Sun, Mar 15, 2026, at 00:20, Mirko Faina wrote:
> > While most conventions should not allow for the text lines in commit
> > messages to get too long, when they do it could make emails harder to
> > read.
> >
> > Teach generate_commit_list_cover() to wrap its commit lines if they
> > happend to be too long.
> 
> s/happend/happen/
> 
> But “happen to be” is a bit redundant. You can just say: wrap if they
> are too long.

Will do, thanks
