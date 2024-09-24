Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E201ACDF6
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205322; cv=none; b=m0/T9vcdaY7mXMsozI2Ei3T7KHG7a8zYqDlqhiTGMtyjV+v3w+tI7W86fW+62eWd02JYpgMc+hfeheqDH5kz+Zv4OIT2847oFkAE9uibN9P1JsogOe/7SqFqrPmBoXo+Rkr1uxWB3TeMLHni38Ve4nJJu+PCKNtXTxi7gG8GmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205322; c=relaxed/simple;
	bh=5rq0Qe6c7QmDmTiKjGIOxSe8HlLcHMxmZvAN2PZMTzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vAlxuk2qlxc/cSR3EDVnai03cx7b8g3C8GTmX4M9outYfDY3/RxMAkFMuBkYhl4rPDj9buPcCbs3PKVbCOwsUXb3Ap7N5T/N7dSuoq41pj6XVdiemWw4aeG8AbPoirVLjP+j7JrHFcUsLfr44jJVH2StVhzOdRKg8LBJ8YiUa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LFKhVIRu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LFKhVIRu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6140D1C315;
	Tue, 24 Sep 2024 15:15:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5rq0Qe6c7QmDmTiKjGIOxSe8HlLcHMxmZvAN2P
	ZMTzE=; b=LFKhVIRuXHix9kLIzOkxW/YydnkuSu3XsBadSuOs7eDcwwQY6kThuu
	ga4bPIyNV/XiCURUfMFf/yZb4stosuc29yi04PUynMrHZkrW6l14XJ+b4dH575i7
	t/qKJXXschYfz3JwBSIp0N2i92rTylKHqXZJZ6xxjTOu/StL4oHM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5794B1C314;
	Tue, 24 Sep 2024 15:15:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C2E91C313;
	Tue, 24 Sep 2024 15:15:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
In-Reply-To: <20240924-sawfish-of-exotic-fantasy-b6abdb@meerkat> (Konstantin
	Ryabitsev's message of "Tue, 24 Sep 2024 14:06:07 -0400")
References: <Zu78E+0Uk5fMSeQv@five231003> <xmqqsetr5wl1.fsf@gitster.g>
	<20240923-spirited-lime-lyrebird-fe90d5@lemur>
	<xmqqbk0exdk4.fsf@gitster.g>
	<20240924-sawfish-of-exotic-fantasy-b6abdb@meerkat>
Date: Tue, 24 Sep 2024 12:15:13 -0700
Message-ID: <xmqqmsjwsw1q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 53D1454E-7AA9-11EF-A158-9B0F950A682E-77302942!pb-smtp2.pobox.com

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Mon, Sep 23, 2024 at 02:31:07PM GMT, Junio C Hamano wrote:
>> > I can chime up and offer bugspray bot integration for the list. This is a new
>> > tool I've been developing for integrating the mailing list with bugzilla. I've
>> > been using it on the tools mailing list over the past year with reasonable
>> > success.
>> 
>> Intriguing.  Everybody loves to hate bugzilla, but would bugzilla
>> become less smelly with bugspray enough to make it palatable to all
>> of us?
>
> I'm happy to enable it for this list if you'd like to try this out. It doesn't
> really create any obligation to use it, but it may end up being something
> useful.
>
> To enable it, I only need a list of people who are allowed to trigger bugspray
> via the "bugspray track" trigger phrase. I assume it's going to be more than
> just you?

Now we'll have to come up with and maintain an official list of
trusted contributors.  Which at first may sound like such a list may
alianate those who did not make the list, but when deciding which
topics are ready to hit 'next', such a "selection" is implicitly
made to choose whose opinion weigh more anyway.

It might make the process more transparent to formalize the "more
trusted contributors" list.

I suspect that the list of folks who can operator bugspray do not
necessarily have to be with deep technical knowledge of the innards
of Git.  They have to be able to dedicate the time to read and
understand what was said in the discussion threads, recognise when a
problem is identified ("bugspray track"), have been long enough to
know or able to use "git blame / git log" to see who likely has
useful insight into the issue than others ("bugspray tag"?), and
have good enough taste to recognise irrelevant "bugs" that are
opened by those with worse taste.  In a sense, it is very different
from the earlier "list of those whose opinion weigh more in
assessing topic's doneness".  Competent "project secretaries" are
the kinds of people we want.

If I misunderstood the nature of "allow-list" for trigger phrase,
please correct me.  Also it would be very welcome to hear from those
listening in from the sidelines who want to see different kinds of
people to be on the trigger phrase list.

Thanks.





