Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DB61B4C44
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739805; cv=none; b=mpkHgUWis2qwO5Ba/n3NeZuyngQ7cUOl4Ziir03TDEoPinhO7WyZTdkAw2Vhl/TZ3MuwRhhoUBBzlWUIi+DnvewAYDUdavJtM09NOkzAZwA5/OeyDgLz/B4Cw/BQFihJdsTpHi307GCk1U/af0fzjcvhqMk5qadAtmxX/O6dMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739805; c=relaxed/simple;
	bh=WBnUr2HmbLeA1lUVRs4RZe0aUokePSYFUA5lWKtRiNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S6pRk0i9kgCIYKnAPovDl6ZPpHXqQM7Wu0tudq8NvmNsTlnKzDq540LiTOggU1F/vuczXpw6shZbPgy33AxHpHfwcwOwYkyQ3Y8X9pldoOQRaUondUdlZFAnXvTlM/JvXK4VLb8vEUxMCfYqShKJHpRoZTnyYsNeEXIwoAWnmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fIGZnfjm; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fIGZnfjm"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C6362233EE;
	Thu, 15 Aug 2024 12:36:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WBnUr2HmbLeA1lUVRs4RZe0aUokePSYFUA5lWK
	tRiNA=; b=fIGZnfjmmDNy54gpLO9BvQZTR62tC/Ts/7W+jVR6qB93Hfl7c2RgbE
	39kWPJffPVb1e/WUIx67P3LArJjGKfg7cgXj4WwdAH8+WrKymxs7Z81sOSbYr9Io
	/YwTqX4tu+ZOQrilv/4SHJmeCYiJWMIQwr8hg8m2tIq9PC/jQ/Quw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BDCCE233ED;
	Thu, 15 Aug 2024 12:36:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34EA7233EB;
	Thu, 15 Aug 2024 12:36:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH v2 5/8] git-prompt: add some missing quotes
In-Reply-To: <4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1723727653.git.gitgitgadget@gmail.com>
	(Avi Halachmi via GitGitGadget's message of "Thu, 15 Aug 2024 13:14:10
	+0000")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1723727653.git.gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 09:36:41 -0700
Message-ID: <xmqqmsldu4iu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D7A2C4C-5B24-11EF-9C47-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In _command-arguments_, expanded/substituted values must be quoted:
>   Good: [ "$mode" = yes ]; local s="*" x="$y" e="$?" z="$(cmd ...)"
>   Bad:  [ $mode = yes ];   local s=*   x=$y   e=$?   z=$(cmd...)
>
> Still in _agumemts_, no need to quote non-expandable values:

arguments.

> -	local bad_color=$c_red
> -	local ok_color=$c_green
> +	local bad_color="$c_red"
> +	local ok_color="$c_green"
>  	local flags_color="$c_lblue"

Good.  I think we in the past was burned by some shells that want to
see these assignments with "local" always quoted.

>  	# preserve exit status
> -	local exit=$?
> +	local exit="$?"
>  	local pcmode=no

Well no matter what value $? has, it by definition has a few digits
without any $IFS funnies.  Does this really matter?  I'd imagine
that we would prefer to treat "$?" exactly the same way as "no".

> @@ -379,7 +379,7 @@ __git_ps1 ()
>  		;;
>  		0|1)	printf_format="${1:-$printf_format}"
>  		;;
> -		*)	return $exit
> +		*)	return "$exit"
>  		;;

Likewise.
