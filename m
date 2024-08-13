Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F21A38F3
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574640; cv=none; b=bbo1cEJHARMjTRQd8ZMjePHj1Pc5Vs6HOgBVzVXweRGyOTGHyUEpwz+uBxpONS9fOc1IQU0CaSJI/O+d9+L4dzFQE4aeKDcXJLGfQBxjadsQjr3XQYDMWYKHaKSr6XJza60FIaM2v7a0HPN579VKAFoCdPpFU/qdtMM27Zs+UAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574640; c=relaxed/simple;
	bh=FuPMt/i045rjJKuFYpBGuUzOvlkPRWAlyJxU2gm/2DI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VO7V8tevdaaoMDUgFnBaiDNx7ksjIMG6fYqFTI+HmRtbVYcNPKgL9QvLUHSk2mCthfK3Lc+q/s2H4TGaAzEGvPENzdVZXyilhe5FXYoVYxxY1fy9nDd3V+Txhle41nOJwtjvsuapR2SCEHjvhAwzz30emcyYS76ndZSqaryPO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ebeS8M9T; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebeS8M9T"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E278C369FB;
	Tue, 13 Aug 2024 14:43:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FuPMt/i045rjJKuFYpBGuUzOvlkPRWAlyJxU2g
	m/2DI=; b=ebeS8M9ToIoA94whw15UvyC/epFrfY/QadDC1hwg8CN5yecSqDw2f5
	ejmg1DjgMRsVLEIbBh+0UJ4jD5oCgoLFtGb5oPD9ScMVrcA2xmjZnUaoUTuab+36
	pfIHupHBZ5pBt61/Kn7rSskWVDpI59ICv1VnTMg/GHlGrz89vfH7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DB678369FA;
	Tue, 13 Aug 2024 14:43:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 44C5A369F9;
	Tue, 13 Aug 2024 14:43:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>,  <git@vger.kernel.org>,
  =?utf-8?Q?'Ren=C3=A9_Scharfe'?= <l.s.r@web.de>,  "'Kyle Lippincott'"
 <spectral@google.com>,
  "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,  "'Josh Steadmon'"
 <steadmon@google.com>,  "'Edward Thomson'" <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v3 3/7] t/clar: fix whitespace errors
In-Reply-To: <03d601daed95$d10a63c0$731f2b40$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 13 Aug 2024 11:31:01
	-0400")
References: <cover.1722415748.git.ps@pks.im> <cover.1723095269.git.ps@pks.im>
	<35682b7686e570a96a8432f6b8af1996ab8d748e.1723095269.git.ps@pks.im>
	<xmqqv8048mx2.fsf@gitster.g>
	<03d601daed95$d10a63c0$731f2b40$@nexbridge.com>
Date: Tue, 13 Aug 2024 11:43:53 -0700
Message-ID: <xmqqzfpg461i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE503D8A-59A3-11EF-8AE3-BF444491E1BC-77302942!pb-smtp20.pobox.com

<rsbecker@nexbridge.com> writes:

> On Tuesday, August 13, 2024 11:26 AM, Junio C Hamano wrote:
>>Patrick Steinhardt <ps@pks.im> writes:
>>
>>> Fix whitespace errors in the clar that make git-apply(1) unhappy. This
>>> has been cherry-picked from the upstream pull request at [1].
>>>
>>> [1]: https://github.com/clar-test/clar/pull/97
>>>
>>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>>> ---
>>>  t/unit-tests/clar/clar/sandbox.h  | 5 ++---
>>>  t/unit-tests/clar/generate.py     | 1 -
>>>  t/unit-tests/clar/test/.gitignore | 1 -
>>>  3 files changed, 2 insertions(+), 5 deletions(-)
>>
>>A funny thing about this step is that the copy I carried for the past few days was an
>>empty patch, because out of habit I use the "--whitespace=fix" option while running
>>"git am".  As that fixes the whitespace breakage this step addresses while applying
>>the previous step, this one becomes empty.
>>
>>I'll requeue these patches with --whitespace=warn instead.
>
> Please forgive the third ask, but I really want to test the build early. Suggestions?

Sorry, but I do not follow.  If you have "git am" and "git clone"
working, and if you have enough C toolchain to build the rest of
Git, wouldn't it be sufficient to also build this addition?  I think
the 7 patches cleanly apply to any recent tip of 'master'.

