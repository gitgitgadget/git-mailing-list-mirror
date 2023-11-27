Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eG6QFjin"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF162123
	for <git@vger.kernel.org>; Sun, 26 Nov 2023 16:49:26 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F42736D6C;
	Sun, 26 Nov 2023 19:49:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FfcekrOfCUUgJkxQiI59EWPSFpZ3JS0VmpoiGN
	f9ezE=; b=eG6QFjinI2SammIPdFprRPHrD4Ovi6iNT8MGwopuGwYhA/3TGwI0mH
	cXUwkKv0a0N9JHq3QpGviRUDJmQnqf6c3Kw9RdM1GMWlk0VaqIz3DP9pitxDNd7z
	bxmQ6eGwHvBUpz5WyOqqgieP1bT/qV57lulg6Gb+RsW5hhIOlC3nw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9895036D6B;
	Sun, 26 Nov 2023 19:49:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3F9B136D69;
	Sun, 26 Nov 2023 19:49:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Soref <jsoref@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  Josh Soref via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/4] Switch links to https
In-Reply-To: <CACZqfqAq0ijtYO9-1q6h2KQMyxHgLpFOg--d4c9F4xT0nMkvUg@mail.gmail.com>
	(Josh Soref's message of "Fri, 24 Nov 2023 11:03:10 -0500")
References: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
	<pull.1589.v3.git.1700796916.gitgitgadget@gmail.com>
	<CABPp-BGhHivx9_R6fwL--K5nTvz1sh67JDMtWG7WajxmX=56Fg@mail.gmail.com>
	<CACZqfqAq0ijtYO9-1q6h2KQMyxHgLpFOg--d4c9F4xT0nMkvUg@mail.gmail.com>
Date: Mon, 27 Nov 2023 09:49:20 +0900
Message-ID: <xmqqedgc58bz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CDFE8E5A-8CBE-11EE-B270-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Soref <jsoref@gmail.com> writes:

> Elijah Newren wrote:
>> As stated elsewhere, I'd be fine with using the archived link if the
>> justification presented in the series for using archived links was
>> consistent and mentioned both reasons for changes.  But, I think this
>> series is fine to merge down as-is if you don't want to go through the
>> trouble.  Especially given how long you've waited.
>
> I'm clearly still contributing, so I can come back later and cross
> that bridge...
>
>> Anyway, I checked through every link in this series; it all looks good to me.
>
> Let's take this as-is. Thanks for taking the time to re-check every
> link, I know exactly how tedious that is :).

Thanks, both.  Will queue.

