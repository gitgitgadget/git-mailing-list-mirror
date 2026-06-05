Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EE416CEA
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683991; cv=none; b=mSRpyfBa0LPwOFHnfti62JAbfLh7NZazUy94EBHSxx1pY7b6dhskk7EpLWVKHCwz13+swMoBvRArKvvA/Ua2SHXT+JKxlQGezZhIgnaQo3ZZuuwEquoiTk7ULClwq/SKKSDUrYuNFJoghiSqQn23KlRMWStGrso8M4H3WpapqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683991; c=relaxed/simple;
	bh=Z+lhQ/ht8CwyJZt3IuCoacKbCv/h0MK09OozSXLImmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldp9uTTq+S6tvObyDVhxzao5R+IGexavDqlCuaFJmEp2EiANHz6bl9Y3Q2JbX0sJajwKVkt1NA2mdNFA1VHqsg3O3XJOe7XtxNKbNPBw0Q3REvvoHjzZvx+uVlDwFBuOdUc7G8h8dMVlyZSVGRCmCJ5J57m7mSOM/VQaSif2nxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=M0Y8eUgP; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="M0Y8eUgP"
Date: Sat, 6 Jun 2026 02:26:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780683986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jotq10JqYqOlSn7ZZV198HaQOk/Ndu6uXBHe6E8NKKE=;
	b=M0Y8eUgPY3Ejk0FLA/P2nnOomZJnVlNaW8z/LYTJSc0nix/xjgemWU3iqEXnpn8IxWRFyg
	qCh20ihyb6saqI4SBlFr0o+HbNUUF91kctCCUjGd/yCiMKYeAv6B9/sSWsGepjURF0IAkG
	FPn2KAWKpJ/IIIwv5SMGU+16X+JoILl7JRg76/nMZCjbEH4tHFjUoArPWxyMm5OqJJp/EA
	yZpYiIqUyQ+gzy1ONvlJoWMN3nXaGpcHp/h1srNES8638Lx3+80hVZCzae0CH4goU1RZxh
	fjLk95em1Jgg2wK+MoZHp9XWBPLV2aQF5pUNZSZrhoJl5YGc5dMjeAFTbS9xKQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Tuomas Ahola <taahol@utu.fi>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] docs: fix typos
Message-ID: <aiMT-U9YhMNzXEkB@wyuan.org>
References: <20260604131457.19215-1-taahol@utu.fi>
 <92fe3db2-83bd-4aa9-a1f4-bec01dfaf8ca@app.fastmail.com>
 <20260604165557.MWQuu%taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604165557.MWQuu%taahol@utu.fi>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 04, 2026 at 07:55:57PM +0300, Tuomas Ahola wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> wrote:
> 
> > On Thu, Jun 4, 2026, at 15:14, Tuomas Ahola wrote:
> > > [PATCH] docs: fix typos
> > 
> > The area `docs` isn´t correct since you are also changing comments in
> > source files.
> > 
> > `*` could be used (as in a wildcard). Other people have used other
> > things for "treewide" changes.
> > 
> 
> Hmm, I took that from the other typofix patches we have currently in `seen`.

Hi all,

Yup, my patch 8570d9ba31 (Merge branch 'wy/docs-typofixes' into seen, 2026-06-04)
used "docs" as the scope of the commit message.

I thought for a while what would be the preferred scope for a typofixes
commit that touches a quite wide range of the tree. And I didn't know we
could use "*".

On the one hand, I would rather let the typofix thing be simple and easy
in one commit, since the actual changes were sort of logically unified.
On the other hand, splitting them apart makes it easier to name the
scope of each commit, while it would make much "meaningless" noise. So I
was torn at that time.

"Luckily", Junio didn't say something about that, and my topic is
waiting for more comments. So it just happens when I am struggling with
re-roll it or not, I saw this thread. Therefore, could you please also
raise it again in my topic in order to  give it a final decision? (Or
start a new thread as my patch is actually in Andrew's thread, really
sorry Andrew)

Message-ID of my previous patch:
<7b502e20e9495cd4720496bd6738a1fbeb453410.1780041658.git.wy@wyuan.org>

Thanks!
