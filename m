Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF1198A11
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693575; cv=none; b=dbLiD6H8Vud96iVjx6HcUpOCxTXs0tK8aq9kd/ct3uSJG3HZLzOQ7/T1+oWVXM4328L+7cguSN0OX3q6ZevcIqcyNZdEZf29B/i0R4WjIF2D8EAyPyJoc/ccMiuD61AuD4x/SDuJzO/X6J0m7VFTTMEm34T32bSbDwKg4aPdJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693575; c=relaxed/simple;
	bh=7WSl3lTTRdTn0FzICVwlNvTrtveIkPg9dZeVWrU/dwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KL3m7YgawoCkroaUh6/M9uz500MvARD8p6D+jHRmA5mOI/kEwNUWVFcwMRXbfKA5SzUoSJdLhaYNWtniVTGo4zGOLS8p7BngStwWpppU4KRgpEVGIrvrKIZZIb6YrTmPsw/NKPZhfmd9CHALyGbobBEUl/QG4QF5/fAjGRhIDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TEu9TadF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TEu9TadF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BE8BB1B898;
	Mon, 26 Aug 2024 13:32:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7WSl3lTTRdTn0FzICVwlNvTrtveIkPg9dZeVWr
	U/dwM=; b=TEu9TadFiuAcdqkCkBP1uXpFa8HYUursFymmQVpfU6MZHRidCuUxCJ
	9uD3QdLX8wMscu6jUi3QKyI38xwCykpUo+dg+kKSD4dfzlIDaDAfBmkJ6R7ADewW
	TzvfzFeOrTVwnypRYcNR/7kWqIkn8PY5eN+cufnLqPae4E5k/VeNo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B78891B897;
	Mon, 26 Aug 2024 13:32:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 435BB1B894;
	Mon, 26 Aug 2024 13:32:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Celeste Liu <coelacanthushex@gmail.com>
Subject: Re: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
In-Reply-To: <xmqq34mrkxre.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	26 Aug 2024 10:19:17 -0700")
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
	<Zsgh4LacdOt8N69o@tanuki>
	<6c9f666e-12ad-4b67-a44a-3111686454f3@gmail.com>
	<ZswfgYsZrzY6kc1E@tanuki> <xmqqa5gznwf9.fsf@gitster.g>
	<8c1c031b-4f36-4825-93ef-408c50b0ee2f@gmail.com>
	<xmqq34mrkxre.fsf@gitster.g>
Date: Mon, 26 Aug 2024 10:32:42 -0700
Message-ID: <xmqqle0jjikl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 33F729EE-63D1-11EF-995A-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Celeste Liu <coelacanthushex@gmail.com> writes:
>
>> And is there need a new patch to fix this? Or you will fix it directly?
>>> 
>>> The synopsis should lose "=<regexp>" part, as the option does not
>>> take any arguments.
>
> It is a separate documentation bug.  We can fix it separately.
>
> ----- >8 --------- >8 --------- >8 -----
> Subject: git-config.1: two random small fixes

Sorry but, this is a stale subject.

    Subject: git-config.1: fix --regexp description in synopsis

or something, probably.

> The synopsis says --regexp=<regexp> but the --regexp option is a
> Boolean that says "the name given is not literal, but a pattern to
> match the name".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> diff --git c/Documentation/git-config.txt w/Documentation/git-config.txt
> index 65c645d461..1ee5c89ba2 100644
> --- c/Documentation/git-config.txt
> +++ w/Documentation/git-config.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git config list' [<file-option>] [<display-option>] [--includes]
> -'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<value>] [--fixed-value] [--default=<default>] <name>
> +'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>
>  'git config set' [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>
>  'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>
>  'git config rename-section' [<file-option>] <old-name> <new-name>
