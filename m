Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2C9454
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710381548; cv=none; b=IiT/aA81gc7hJmUJer421cUia18M6v9G8o4qx/El8QiiWUBDydJEcxCgRx7nXzuyMxiW/qdgL0sOpa/C5wTuSSxSb6UMI2ZLYjHX3kZcKCa4kzhL7sWRNTlr6XWrX6iI9g9LH8pxI9Tx4p2Dz0BmAzt1zLB2lfi+mQDXB34+xo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710381548; c=relaxed/simple;
	bh=VA3BZZ+zSRczE8pK3oNs5pnKzJZqgeP3/fwf11SNmQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FXBcH8C66Z80fKNTEhNJYghg8HAlUSJPjM0ATt7pR1HlYu6ZeClejFvllfFsVoxz0hEkW+BWvxC0COlZyeWdy7oqHlkAQt5FQqcAaN0pVXOIzsoIIsV+HtuOkVY3CSF17DmvQiK3naYbXUrydWHNrKKK1/mVyHF9ZK7YH5gLfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NO1y5pFi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NO1y5pFi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2E4E1E1341;
	Wed, 13 Mar 2024 21:58:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VA3BZZ+zSRczE8pK3oNs5pnKzJZqgeP3/fwf11
	SNmQU=; b=NO1y5pFi48fZOtwuDkrN+wSj1LxujtcyePYATV5g7baUulT9T5rmfq
	wggy/PbKui6T93b/Ctbs0AAdweZyo0kRsGVuD1DBitYOM2uDDpCvLiAXKS7V2bXL
	BnAXWMINIYMDtT9A9yN1HTq8VK4vxN3azjX+/zL4D9YoOZtoOvRMA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D95041E1340;
	Wed, 13 Mar 2024 21:58:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 484E21E133F;
	Wed, 13 Mar 2024 21:58:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH 2/3] config.txt: perform some minor reformatting
In-Reply-To: <d50c0f22c41ec36b574e1ff67e68485d9a6f2a84.1710258538.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Tue, 12 Mar 2024 16:55:45 +0100")
References: <cover.1710258538.git.dsimic@manjaro.org>
	<d50c0f22c41ec36b574e1ff67e68485d9a6f2a84.1710258538.git.dsimic@manjaro.org>
Date: Wed, 13 Mar 2024 18:58:58 -0700
Message-ID: <xmqqedcd1sm5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6C521518-E1A6-11EE-9941-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Reformat a few lines a bit, to utilize the available horizontal space better.
> There are no changes to the actual contents of the documentation.

I was a bit surprised to see such a "preliminary clean-up" step to
come before the main change, not after, but separating this from the
change to the next paragraph, which is the main change in this series,
is nevertheless a very good idea.

>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/config.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4480bb44203b..2fc4a52d8d76 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -58,11 +58,11 @@ compared case sensitively. These subsection names follow the same
>  restrictions as section names.
>  
>  All the other lines (and the remainder of the line after the section
> -header) are recognized as setting variables, in the form
> -'name = value' (or just 'name', which is a short-hand to say that
> -the variable is the boolean "true").
> -The variable names are case-insensitive, allow only alphanumeric characters
> -and `-`, and must start with an alphabetic character.
> +header) are recognized as setting variables, in the form 'name = value'
> +(or just 'name', which is a short-hand to say that the variable is the
> +boolean "true").  The variable names are case-insensitive, allow only
> +alphanumeric characters and `-`, and must start with an alphabetic
> +character.
>  
>  A line that defines a value can be continued to the next line by
>  ending it with a `\`; the backslash and the end-of-line are stripped.
