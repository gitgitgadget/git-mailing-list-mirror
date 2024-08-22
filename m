Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481955885
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349736; cv=none; b=Q4hWYAzvcOOj/0gjqhWcAkynt0/iaQx9EW1Am6F3caShiEKMWcDaU4H1PrzweGSFIH/k0XZcokUS3UhxOwVuVMSvEp4zzbkyBK/HexFkfqch4Gh5/iwEA0t9B5U5k5DwYBhpbt88XPBL6XWRP9/0FxCwnBcwABV23mLeRWM27q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349736; c=relaxed/simple;
	bh=MPCK0HOJbsRci/qgIiVK3dfHxWnOO3nOs+934xt6e+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pkGUNG1OZ4tHJJvwZCNhw79KqWLlTHdnLjfrdYpkkizofqLEAD41uFc7F52UgSB3uCi98M4PfBO4U9m/WvQ5Qq/xpJWTz04lFEMs6bjTEv50dsrsn9MuCAi/+drFMyrnCetKD1nsVO7LokMimP3qRjInvx80C6Xm1uUC43eSXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zg4Q+/tI; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zg4Q+/tI"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F19341A7C1;
	Thu, 22 Aug 2024 14:02:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MPCK0HOJbsRci/qgIiVK3dfHxWnOO3nOs+934x
	t6e+E=; b=Zg4Q+/tIGtMgqqk7uqylxY617QoWtBrluX8YvmXbls9PFGgYzp99VJ
	xd6yALfIYGqEeF1i1HQHkWqjKteMgrZQFRQMSaBkD1mHSyqkdgBOGnNGwI4qhaZ0
	WxeRggsRY6fnfF6eGtIPD+600pRKi25Gvhq9pXT2xrbEfm9YQbMTE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EA36C1A7C0;
	Thu, 22 Aug 2024 14:02:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.16.143.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7659C1A7BF;
	Thu, 22 Aug 2024 14:02:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
In-Reply-To: <20240822172042.54065-1-CoelacanthusHex@gmail.com> (Celeste Liu's
	message of "Fri, 23 Aug 2024 01:20:41 +0800")
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
Date: Thu, 22 Aug 2024 11:02:09 -0700
Message-ID: <xmqqseuwqvvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A7A64060-60B0-11EF-A3F5-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Celeste Liu <coelacanthushex@gmail.com> writes:

> Commit 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
> introduced this typo.
>
> Fixes: 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
>  Documentation/git-config.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 65c645d461..79360328aa 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -130,7 +130,7 @@ OPTIONS
>  --all::
>  	With `get`, return all values for a multi-valued key.
>  
> ----regexp::
> +--regexp::
>  	With `get`, interpret the name as a regular expression. Regular
>  	expression matching is currently case-sensitive and done against a
>  	canonicalized version of the key in which section and variable names

Looks obviously correct.  Thanks.
