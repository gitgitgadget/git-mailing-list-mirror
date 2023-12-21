Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F815634F9
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VkgEwRvi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DA5D1C74E4;
	Thu, 21 Dec 2023 15:57:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XMZNWtJXjOazBMfv3lcRs0T8O4sSXzhZ48tJL/
	INwKc=; b=VkgEwRviyLx/6NgBc0wm8DFrReQQohJx2Vzc0aCJi6LshD4Xjld5bI
	btMYsQJBMx148bGV25ocPoUoc0/5NESm5B1yG9Xca4WPOlb9efZjg0MHAQOUFXTQ
	tKCBKZkBkQRp2QfzjybRsT3+xGji5hOW4qmCLggw0JaemKftvut10=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 745081C74E3;
	Thu, 21 Dec 2023 15:57:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E02CA1C74E2;
	Thu, 21 Dec 2023 15:57:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Phillip Wood <phillip.wood123@gmail.com>,  Josh Soref
 <jsoref@gmail.com>
Subject: Re: [PATCH v2 2/9] CodingGuidelines: write punctuation marks
In-Reply-To: <c0db8336e519cb43767effbe842dc8b97f914a4b.1703176866.git.gitgitgadget@gmail.com>
	(Josh Soref via GitGitGadget's message of "Thu, 21 Dec 2023 16:40:58
	+0000")
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<pull.1623.v2.git.1703176865.gitgitgadget@gmail.com>
	<c0db8336e519cb43767effbe842dc8b97f914a4b.1703176866.git.gitgitgadget@gmail.com>
Date: Thu, 21 Dec 2023 12:57:19 -0800
Message-ID: <xmqqplyzl1e8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 888E5434-A043-11EE-A370-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

Nobody seems to have commented on this step in the previous round,
but I do not understand what you mean by ...

> From: Josh Soref <jsoref@gmail.com>
>
> - Match style in Release Notes

... at all.  The patch text is fine, though.

> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>  Documentation/CodingGuidelines | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index af94ed3a75d..578587a4715 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -578,7 +578,7 @@ Externally Visible Names
>     . The variable name describes the effect of tweaking this knob.
>  
>     The section and variable names that consist of multiple words are
> -   formed by concatenating the words without punctuations (e.g. `-`),
> +   formed by concatenating the words without punctuation marks (e.g. `-`),
>     and are broken using bumpyCaps in documentation as a hint to the
>     reader.
