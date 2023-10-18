Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B51EB46
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ka3lSboD"
Received: from pb-smtp2.pobox.com (unknown [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E44FA4
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 13:21:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98C5F1B1867;
	Wed, 18 Oct 2023 16:21:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tjijX2GE3Oi3
	Yv2rnnn00gkUZslyQbWGW7GHMVA4NAw=; b=Ka3lSboDF4E+SjfacmjJ3YqDeIEe
	iL7Hy5WqHrJpcXg6Jh4a0Qw02lB6he1ngSUeOmeIt5fkrFY8NTTW8pPZTDX/3X9x
	JlF5SkYRl33vtOzRYbQHgbPN97jOq2r6gEVma/9SpjLgFexfNIgVGk/+pNTnaVB8
	ZTPI3BQSBlfVAsg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F5291B1866;
	Wed, 18 Oct 2023 16:21:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 016B01B1864;
	Wed, 18 Oct 2023 16:21:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] doc: fix some typos, grammar and wording issues
In-Reply-To: <xmqqcyxsj02f.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	05 Oct 2023 13:17:44 -0700")
References: <20231003082107.3002173-1-stepnem@smrk.net>
	<20231005090055.3097783-1-stepnem@smrk.net>
	<xmqqcyxsj02f.fsf@gitster.g>
Date: Wed, 18 Oct 2023 13:21:29 -0700
Message-ID: <xmqqedhrsmuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 ECABC460-6DF3-11EE-ABCC-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:
>
>> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
>> ---
>> v2: Feedback from Eric and Junio, implement most of Eric's suggestions=
.
>> Range-diff with two inline comments follows:
>
> Looking good.
>
> The above comment was meant to apply to the whole series, but
> because you lack the [0/5] cover letter, I am replying to [1/5].
> You may want to run git-format-patch with --cover-letter when
> sending a series with multiple patches.
>
> Will queue.  Thanks.

I wanted to see an independent review from others before deciding to
merge this to 'next', but unfortunately we seem to lack review
bandwidth.  I've given another scan of the whole thing and did not
spot anything glaringly wrong (which is not surprising), so let's
merge it down to 'next' and if anybody finds a bad rewrite in these
changes later, let's let them update on top.

Thanks.
