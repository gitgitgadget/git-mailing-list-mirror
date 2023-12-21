Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68476DA6
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qNrh4Rqq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 90DA23858F;
	Thu, 21 Dec 2023 16:09:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uQfbqnbqJPyB2YMQDAmUgHyRff+pBvRiQtZIUe
	p4a68=; b=qNrh4RqqHRDVdpiUtXMyZToEvxockV8Ozp2lnpfp/8JzIVFvDWAs5z
	5WPa2TRXM9+/avDXp7hT+ZELhTIMmBFY8IV7r68gbSIQ1OponsKBVQMd3AxEYM8V
	moEW+WxHQ+R/GQaCnN8ZKYQHQrHAohgeqdx3MI4crWqEzFbCMKqqc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8985C3858E;
	Thu, 21 Dec 2023 16:09:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F2D23858D;
	Thu, 21 Dec 2023 16:09:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Phillip Wood <phillip.wood123@gmail.com>,  Josh Soref
 <jsoref@gmail.com>
Subject: Re: [PATCH v2 3/9] SubmittingPatches: drop ref to "What's in git.git"
In-Reply-To: <22d66c5b78a6930e195141df848266cac099ca08.1703176866.git.gitgitgadget@gmail.com>
	(Josh Soref via GitGitGadget's message of "Thu, 21 Dec 2023 16:40:59
	+0000")
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<22d66c5b78a6930e195141df848266cac099ca08.1703176866.git.gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 13:09:40 -0800
Message-ID: <xmqqa5q3l0tn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4263C5DC-A045-11EE-B48C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> "What's in git.git" was last seen in 2010:
>   https://lore.kernel.org/git/?q=%22what%27s+in+git.git%22
>   https://lore.kernel.org/git/7vaavikg72.fsf@alter.siamese.dyndns.org/
>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>  Documentation/SubmittingPatches | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  I stopped doing these long time ago, as there were certain
overlaps with "What's cooking" that lists the topics that have
graduated in a separate section.

>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index bce7f97815c..32e90238777 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -570,7 +570,7 @@ their trees themselves.
>    master).
>  
>  * Read the Git mailing list, the maintainer regularly posts messages
> -  entitled "What's cooking in git.git" and "What's in git.git" giving
> +  entitled "What's cooking in git.git" giving
>    the status of various proposed changes.
>  
>  == GitHub CI[[GHCI]]
