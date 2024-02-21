Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48342A8B
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539513; cv=none; b=kZCCFWubwChOmb1nQXA5S3fQPqE/EvvopPd94LvRzoqu5P1olN71AA/IJXjSEMSjSqAP08JQYfrguAETsnt8epXHxNO5gWHI5HcKCvBkkDhEeCBE/pVEXzgRaomUhcFpvnwMeaPdzoaGxsbcTn1g3TO2/6Lz86A6Pk+8lrBes60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539513; c=relaxed/simple;
	bh=N205LOpMCaN2kMiSQHJyfm09+TRMlXDBNgoRZumluio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LAshSbMjV5DVpCl7L8KcD4jFoD4JTcS7a5jr+u1EtT7y+sQGJnGXP00lm0FIsGfwT5p3VMT93T2FwXfrFpHpHmgTtZBVQ2TRQCzg4a/wiA3VtUxtvGKidmSNURAEKcTMBqhhsWhlYD/YMwcs5d+6caeA+tYvSmpSVtwv6JazFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xhPn31We; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xhPn31We"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1CA71E56A4;
	Wed, 21 Feb 2024 13:18:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N205LOpMCaN2kMiSQHJyfm09+TRMlXDBNgoRZu
	mluio=; b=xhPn31WeaU4mXzbWcAXrqNpLENTF77yNxNnBzE+lXl70lv7Nkkrhzp
	BRnHyFVvgFbo7NvIW8a56q/3AUUBqvQSCqPkhgIO3uVZXFma0xyHsPoiggQix3Mc
	CsgLzBXoWNVN+oda48Ufjinf+p5i5V6Q1cq+xslAqimCbyo4VrjeA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 999D41E56A3;
	Wed, 21 Feb 2024 13:18:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 091DC1E56A2;
	Wed, 21 Feb 2024 13:18:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jakub Wilk <jwilk@jwilk.net>
Cc: <git@vger.kernel.org>,  Abhradeep Chakraborty
 <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH] git-remote.txt: fix typo
In-Reply-To: <20240221083554.5255-1-jwilk@jwilk.net> (Jakub Wilk's message of
	"Wed, 21 Feb 2024 09:35:54 +0100")
References: <20240221083554.5255-1-jwilk@jwilk.net>
Date: Wed, 21 Feb 2024 10:18:28 -0800
Message-ID: <xmqqfrxlof4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9D520294-D0E5-11EE-9789-25B3960A682E-77302942!pb-smtp2.pobox.com

Jakub Wilk <jwilk@jwilk.net> writes:

> Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
> ---
>  Documentation/git-remote.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 1dec314834..932a5c3ea4 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -35,7 +35,7 @@ OPTIONS
>  -v::
>  --verbose::
>  	Be a little more verbose and show remote url after name.
> -	For promisor remotes, also show which filter (`blob:none` etc.)
> +	For promisor remotes, also show which filters (`blob:none` etc.)
>  	are configured.
>  	NOTE: This must be placed between `remote` and subcommand.

When you give more than one filters to "git clone", they are used to
create a single "combined" filter, so strictly speaking, "also show
which filter is configured" is a grammatically valid that might be
more technically correct.  E.g. the user may see

    $ git clone --filter=blob:none --filter=tree:2 $there sample-repo
    $ git -C sample-repo remote -v show
    origin ... (fetch) [combine:blob:none+tree:2]
    origin ... (push)

in the output.  It may not be a bad idea to update the code to show
the filter information in a way that is more clear that we are
seeing a list of filters (perhaps showing the above as "[blob:none
tree:2]" might be a good starting point, as a totally separate topic
(#leftoverbits).

After taking your patch as-is, that is.  In user's mind, they
consider they gave two filters, and making a single combined filter
is something Git did without being asked for its own convenience,
so "which filters are configured" is, while it may be technically
less correct, much closer to what the end-user perceives.

Thanks.

