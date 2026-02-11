Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C738F9C
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770794073; cv=none; b=T3BH8b44MKUTHK995h9UjLJ/1gZZJQ2LyaU1pCgf2S/h6BNb4KtjRiIKo5FrKc1jDF0ri38N8F01ICtBBMrEZ/7lMTkBIhxdG4lZ4ObOxYEIR306aZHLRc64K+hUE1ex3RyCBQZXgnfAYQh536ve67vJdU40W6QXabRtfqbDg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770794073; c=relaxed/simple;
	bh=/5FSwzsjaCJVINurkEnUFP3O2Dpsr3p6mOux8SoDMyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5lTfqtb8W1NEQMVnYvatWJg4so9UUfZlIgrWHyEp3zUO2nHOQRLgwzSFdJKMUk062Cij3LHJKAtjcOt+bYSAe4W5yhOIU2cYkFG4ZZAiGSW2dw/cB2tJomM+v1tm9oLeLYwnONKxKdFG4nvrghuthxmKUlx3k0Hj3m4TqLjTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=dKx6lyS0; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="dKx6lyS0"
Received: from [172.168.17.249] (unknown [103.51.116.155])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id B297120039C;
	Wed, 11 Feb 2026 08:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1770794062;
	bh=/5FSwzsjaCJVINurkEnUFP3O2Dpsr3p6mOux8SoDMyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKx6lyS03WAM6UUjnzIDGltCLOQTV69DMtO/5LNhldR7Kkbrc8DIb/fZBdIYk72iO
	 wnNfKTar1ffBTgsxWo848V3wHbCXBa49xfI2zwIYWe440herttJvvm0nKIWY9Mojg8
	 EfWdujgcTtMkcWZWMEdyMIJHHXzXm5sNw3nUmukKR/OjiEdRSroxVEtTz3tEiVs72Q
	 aocDsgbrqj7nJv/PUhl4OoqJOnZ/79feQofIsc0N2wSvtLx5pRn3DaxlTdTUk0jQtm
	 1ylYo6ENUG3GVx9GAZOdu2yqdKtHwBm8bj6Om2CCuQN3e8d0+ctBdYjNpw2P9wHvGy
	 VkuRfgbUHEnVw==
Message-ID: <1a4060f1-6607-4b50-859d-927642eb34df@free.fr>
Date: Wed, 11 Feb 2026 08:14:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: rerere-options.adoc: link to git-rerere(1)
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <doc_link_rerere.328@msgid.xyz>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <doc_link_rerere.328@msgid.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/02/2026 à 19:13, kristofferhaugsbakk@fastmail.com a écrit :
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Five commands include these options. Let’s link to the command so that
> the curious user can learn more about what “rerere” is about.
> 
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> 
> Notes (series):
>     Topic name: kh/doc-link-rerere
> 
>  Documentation/rerere-options.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-options.adoc
> index b0b920144a6..115882edab1 100644
> --- a/Documentation/rerere-options.adoc
> +++ b/Documentation/rerere-options.adoc
> @@ -4,6 +4,6 @@
>  	the current conflict to update the files in the working
>  	tree, allow it to also update the index with the result of
>  	resolution.  `--no-rerere-autoupdate` is a good way to
> -	double-check what `rerere` did and catch potential
> +	double-check what linkgit:git-rerere[1] did and catch potential
>  	mismerges, before committing the result to the index with a
>  	separate `git add`.
> 
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f

I'm not fond of introducing linkgit macro that can create auto-reference
in manual pages. At the moment, we need to use conditional inclusion in
the manual pages source, but I wonder if we could simply filter out the
links in the macro itself.
