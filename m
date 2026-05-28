Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC53CF977
	for <git@vger.kernel.org>; Thu, 28 May 2026 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977802; cv=none; b=Otuok9VNwjmk080NnyJ66pB0VAZeBOlBBoubbLEoIeBJWlwST/zFJI+8TajwWgEo6exjoi87KVCcnY4c/wwe2bdcTKn/Ms1SB7IKk5/S5uUsuo99DDIn7JE4QWFiPkm4i9nYDv/t+t+hjB7Hot3H42rTEx0aDjJoSkw/gxj33q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977802; c=relaxed/simple;
	bh=QiGS7Y9OxPamBIqUTfjmkgtoEodvAn14XXXV8jyDHyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVJN02C7tEnmkeUePYC7W31XspI0qjYgg0vbA73RK8EwwShncxIrK3PiABSzEeYX2lPMZeckXtFzGg6SErLxXNyVwMHmi+adDm04BonaxR+okZvUqdR387Aaf81cXJz+a9YuLYPvN4rbnPWqoc1w3SLLUjK6IvDjBGebK1AXT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=hP6XfJRX; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="hP6XfJRX"
Date: Thu, 28 May 2026 22:16:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1779977797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwRWCDVFhwoO8cFWmaTO1R27bm8lH9nNBRbauTIgj5g=;
	b=hP6XfJRX+BhRd3ZoGK+pIAJ7x0RJl9Ys3UQxfrhDNzX2wKvoNmsfxzcpN7kCCRr/Wi3WAK
	FgfS+KBaTXosCYSPZLbvYaS8zgvwJjNSCcXpi5hvFAyK2G0WOQsAlCpOTAhPfGutO0o+5P
	EaYHfZ89KY7nZllaMAX+Q9lxnMeBBwLcsxa55MyASA03YFxR83ctNLYowmNEy7Bn8iarOs
	knUnrswZbn9IHqUv4xlOKyjodWTeK7MMN+nQAyT+qe3Yp2Y+nA3FgN/LXlxsUU+tH+tWTl
	f/nenjJnGW7lNhQ/US6rLNnHaxd2dwY7u/1RoWIeC1MbGQfK3I6tUumr/OuItw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: =?utf-8?B?6IOh6ZSm?= <hujin2@sunline.cn>
Cc: git <git@vger.kernel.org>
Subject: Re:
Message-ID: <ahhOLaHJByKzVnGV@wyuan.org>
References: <tencent_124443E95FD3502A16815464@qq.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_124443E95FD3502A16815464@qq.com>
X-Migadu-Flow: FLOW_OUT

Hi,

I'm just a diver here, but I would like to give you some suggestions though.

* Your email doesn't have a subject line. So it seems not possible for
  a true dev here to be interested in your email.

* I guess you would need a proper text editor or a proper email client,
  your email doen's wrap perfectly.

As for your feature request, I believe it's even harder, as for the "online
collaborative documents". This doesn't seem like a problem that git was
designed to solve, but more like features of certain forges. Based on
discussions in recent years, this feature you are looking for is not
within the scope or schedule of discussion.

But I guess they would be more possible to discuss it if you could
attach some patches.

Thanks.
