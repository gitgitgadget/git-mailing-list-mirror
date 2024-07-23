Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25A13B287
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753313; cv=none; b=jMJnadE2Dl9NuQoq18Fu2AJV+/uR3Jngg5DSqtY3ljcSO8cvUecKRXeOfFmjY4T8Dp6KwRkGfA7eiZ1JxnkAFYyyHKs+tFiqVTGrzslE8BLWZ2cXwsWx3F9BEFZY3cE7u7X8c6SHbaG8C+i8m4YvgZtu3qZKzQH40Dg/40IbSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753313; c=relaxed/simple;
	bh=mWxhyJes3hVEUkDjIVWW2TF8gkdY0mWwi8O4akc38Hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oc97ehFEdkyOrkEy0EzjJNUQlcBUcdMUBDFYXq+zoXaZ6LBTB+s4bzbb3oauCUGpZXaj09NsRSZJPw583XM6BWS9Laz4cEk2H8gpL8hwIMjxbDggnBV/m4gUSy7Fpdrwn306Hv5Lp6wPt0y+Rf6To91LDeOklmjThpabdeaHXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZfPglgAT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZfPglgAT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F23752D2DF;
	Tue, 23 Jul 2024 12:48:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mWxhyJes3hVEUkDjIVWW2TF8gkdY0mWwi8O4ak
	c38Hs=; b=ZfPglgATts2qIMxQuFqNEtJvL5b0lvBZl/YkNP/3mr24MhGYeikI/S
	Sh0P9ifTyLa5byYoiA1sK4PhY6JwD2tkc6aOufcBiHzqEA5l+qxdRfNILLtwwfKy
	m2A4CCfHaAMKxCyVA7nERfKyUxDyDuxhcBTcws0uMbaEMPu0QMMxg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9B9A2D2DE;
	Tue, 23 Jul 2024 12:48:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55E112D2DD;
	Tue, 23 Jul 2024 12:48:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tomas Nordin <tomasn@posteo.net>
Cc: git@vger.kernel.org,  charvi077@gmail.com
Subject: Re: [PATCH 1/1] doc: remove dangling closing parenthesis
In-Reply-To: <87h6cgwcwl.fsf@posteo.net> (Tomas Nordin's message of "Tue, 23
	Jul 2024 11:44:42 +0000")
References: <20240722225302.124356-1-tomasn@posteo.net>
	<xmqqy15t824l.fsf@gitster.g> <xmqqo76p54ib.fsf@gitster.g>
	<87h6cgwcwl.fsf@posteo.net>
Date: Tue, 23 Jul 2024 09:48:21 -0700
Message-ID: <xmqqikww2gx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5F4ABE90-4913-11EF-9925-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Tomas Nordin <tomasn@posteo.net> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Wonderful.  Thanks.
>>>
>>> Will queue.
>>
>> Spoke too early.  We need a matching change to in-code help,
>> otherwise t0450 would break.
>
> Good test suit (which I didn't run)...

It skips a large number of commands that have mismatch in "git cmd
-h" output and "git cmd --help | head" output.  I am not sure what
our longer term plans are.  Perhaps make it a #leftoverbit item to
shrink the t/t0450/txt-help-mismatches file?  I dunno.

Thanks.
