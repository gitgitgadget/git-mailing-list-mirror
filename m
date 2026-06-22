Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B735E1B5
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118775; cv=none; b=bNHYiHfq2EM97pgIjFbyQilURYlhA4nfm+EezdDJBEkp3x2/sH3/aQagEpDKSb4pms8b2zAIs5/CmOU2ykhWvwi4lV7uTf48t/tCLc5EzL3Hmy+hT7DMTZqpLVqIDVHfaL2gOnZfl/QmbAajwy00tOUmsWHrw9s4dpQ1RZqygZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118775; c=relaxed/simple;
	bh=H+0uciGjvezG417lJZduDAvD7m+LOYU6wcyOeAcgUqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK/DORvWmgDF+kovO7NeiytQg08Qf/Un2+f+Z5HwpfKJE8LTxvO8qOncXOrNNGYGOM2Ok1QOdzZqij/IrDHZbiUOiK5NvOg3hW9rkiCyWihA/Ze9cv8sgD13UIxh5zU6BVH7tWBfM0bk4/LUhISLDh+BxfFf5YO+Od0BBwNxhl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=jEksmHzj; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="jEksmHzj"
Date: Mon, 22 Jun 2026 16:59:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1782118771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+0uciGjvezG417lJZduDAvD7m+LOYU6wcyOeAcgUqE=;
	b=jEksmHzjpY29cpySui/Sn/11BAYa7ZnzfQqJj0LL45M698iCZGqNeuY+qmPW3vcErU9Xg9
	9zE2ybKBAF7s6JOJXPLhpFmNnbE8kFx9Ar7BRTqnD5b6E2tKzHTdhG9oDyoWelstY7Aa62
	BIKb6aw/dhQw/0ZwIvzD3CaBcBxazY7hYoHzmtxvgm1xqVfhRslq6id0C9RajPLy0NGWGk
	dEv7SnDY2FheSJzDRrnwMCNg8iytHGE6zKcjyslp++TfVbGsSCtnM7loPtkpbL3f0Nz47e
	WttESpUNKwxQ+XcRymljvOFGChldnMLDxyC+/N7w3AnQLlM0bQcV3NvrE15pxA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] branch/push: suggest intended form when
 remote/branch slip given
Message-ID: <ajj5Y82644z-ytSA@wyuan.org>
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
 <CAHwyqnUNb-P7F3EREbTtdTmpx=M7bSw3idrKdm-tK3wTKnePZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHwyqnUNb-P7F3EREbTtdTmpx=M7bSw3idrKdm-tK3wTKnePZA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 22, 2026 at 10:41:18AM +0200, Harald Nordgren wrote:
> This is maybe not the most pressing issue, but I remember being quite
> dumbfounded when I was a new Git user; not understanding why some
> commands required one format "origin/main" and other required "origin
> main".

Can't agree more. It's quite confusing for new users like me.
