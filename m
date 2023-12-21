Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3287691A
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RSyfVy3k"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E753A1C7596;
	Thu, 21 Dec 2023 16:03:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hgo6jU+TD8MT4CC7n/oNGlQDvzWiV04HHntWv2
	Rk6Z0=; b=RSyfVy3kHjVlpYNcFiJGN0a/32OY4TeNLn0q+/PbTRBRozSO0VIdqr
	3FmD14kzF+5nGisXhFepGovxS2AfXwYT/J2mPBWSg1Y45vP7rjg5p7rx2qpGryjV
	OZ82KbCEmeIPjB0oY26HuQSHSzhRCFATojnSS5dSLEOIKrJnsqLxc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D77F41C7595;
	Thu, 21 Dec 2023 16:03:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D1E21C7593;
	Thu, 21 Dec 2023 16:03:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Phillip Wood <phillip.wood123@gmail.com>,  Josh Soref
 <jsoref@gmail.com>
Subject: Re: [PATCH v2 1/9] CodingGuidelines: move period inside parentheses
In-Reply-To: <b9a8eb6aa4e87cd96fbf2b5d514350508076d756.1703176866.git.gitgitgadget@gmail.com>
	(Josh Soref via GitGitGadget's message of "Thu, 21 Dec 2023 16:40:57
	+0000")
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<b9a8eb6aa4e87cd96fbf2b5d514350508076d756.1703176866.git.gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 13:03:36 -0800
Message-ID: <xmqqedffl13r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 68E88CAC-A044-11EE-84A8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> The contents within parenthesis should be omittable without resulting
> in broken text.
>
> Eliding the parenthesis left a period to end a run without any content.

Nobody seems to have commented on this one in the previous round,
but quite honestly, for this particular instance, I suspect that it
may become easier to read if we just lost these parentheses, as the
next sentence "You do not have to include more than ..." is just a
bit of extra material to support the first sentence like the one we
see in the parentheses.  Alternatively, moving that "You do not have
to" also inside the same parentheses might work slightly better.

It might be even easier to follow if we moved the list of "approved
headers" (and the "You do not have to ... more than one" note that
supports the "currently approved list") totally out of line by
making it a side note.

> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>  Documentation/CodingGuidelines | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 8ed517a5ca0..af94ed3a75d 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -450,7 +450,7 @@ For C programs:
>     one of the approved headers that includes it first for you.  (The
>     approved headers currently include "builtin.h",
>     "t/helper/test-tool.h", "xdiff/xinclude.h", or
> -   "reftable/system.h").  You do not have to include more than one of
> +   "reftable/system.h".)  You do not have to include more than one of
>     these.
>  
>   - A C file must directly include the header files that declare the
