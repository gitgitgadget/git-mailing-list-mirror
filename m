Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC200633
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709519458; cv=none; b=rfttMBNHZh7aXlQ+B3I0YNGERc03B10N0tVFPgxancni4Be5RWqiV2oDTyFUwAGINjCKbmBglftsOF/GcUzHChZpUnFnD6A3FTSRM6MhXzpUmzMrHaEWbTOBShJWQupiXQQkXFXQKz/LFG4C8VnLh7Zo0SPWZ6uAIA6ZrGZuZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709519458; c=relaxed/simple;
	bh=AHuym85PZgTqQ9MJNwlt6DeUHd4AJCIGKT+ZFtJyQeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPRVKwuVcRugLPCo4oueMw7uJgZygMvpZCOVPWM+WvU/PybQ8jc/oTv9OCiwbF3KX1cPfhAQJ/pQcDrzoAvoziIwORMmPtvD4mPFTvTdiRvzMsWokw7pM0DYwylFjBjXtJtPh1IHIJFT8ioWqEysIukCuvmdw2KFsgtlXwX7Flc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from laptop (unknown [IPV6:2001:da8:d800:aee0:f826:ae72:68b:4c34])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 707CD920108;
	Sun,  3 Mar 2024 22:44:04 +0800 (CST)
Date: Sun, 3 Mar 2024 22:44:03 +0800
From: Wu Zhenyu <wuzhenyu@ustc.edu>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [question] How to customize git revert template
Message-ID: <6x4ybwweqseahgnfdvzm7jhrtyk5q3of7fq6bmx6kei7bqf56s@dgd57y57m5je>
References: <k4zvycdixqmntkyevdtsrswbfiklyj24mp6jhltnwwdswxromc@q3wtrivkbfbl>
 <9389c159-ba55-4329-9d86-bc95b321737f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9389c159-ba55-4329-9d86-bc95b321737f@app.fastmail.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTU5PVhlDT0JDTUtIS0tLQlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlLS0pBHxpDQR9DS0tBGh4eS0EdQ0lNQRoeTElBTUMZQU8YSE9ZV1kWGg8SFR0UWU
	FZT0tIVUpNTEhKTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8e04c5a15c03a1kunm707cd920108
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PlE6Tio5FDMJSFYwNkMuKQ03
	UQwaC05VSlVKTEtCT0xMS09PQklMVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSUtL
	SkEfGkNBH0NLS0EaHh5LQR1DSU1BGh5MSUFNQxlBTxhIT1lXWQgBWUFKQ0NMNwY+

Can git support the feature to customize template? Is it possible?

TIA!

On Thu, Feb 29, 2024 at 04:18:20PM +0100, Kristoffer Haugsbakk wrote:
> Hi
> 
> On Thu, Feb 29, 2024, at 13:52, Wu Zhenyu wrote:
> > In https://git-scm.com/docs/git-revert
> >
> >> While git creates a basic commit message automatically
> >
> > How can I customize git revert template? e.g.,
> >
> > ```sh
> > git config revert.template ~/.config/git/template
> > ```
> >
> > TIA!
> >
> > --
> > Best Regards
> > Wu Zhenyu
> 
> I see no way to customize this message. Your only choices seem to be
> 
> 1. This default
> 2. The “reference” style using `--reference`
> 
> So there doesn’t seem to be a template alternative here.
> 
> -- 
> Kristoffer Haugsbakk
> 
> 

-- 
Best Regards
Wu Zhenyu


