Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AB208D0
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726872518; cv=none; b=To+jNpb4JoOXGw9yW0+UKq3t0Hmdu0/WT8eaODPIZAlrXqgRAz4uetO6q3qe3ivSsRavmZMwgBkALiVxs+I395UQ8cOozveuq2TSDLZr1M/uj6/OoY6yl0+BegmzCTPbMETeGh7TBeeUrw0PThAM5v4078JBkAwxNlBBrmHJauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726872518; c=relaxed/simple;
	bh=bTOu9TmWvNdcYZ5frAv2/1hPAsA306/lpxLKr84V31I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFeSEQWgGTIR+5LHdECD2cQOk99RI42Ny/f0NOeBMr39biWMXT506r7ek4m12cCtwgRlq/hpa9YlofUDwHSq/nJ8b7TTE+MeH/2ojuuHEEBrO8HYF6+Cs+6bnOXTDTbwi3sQEVR6aVT32KfLtnRhAp/0iOAnNccOnWkY+5QNd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e6XHPWFL; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e6XHPWFL"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F2B420B71;
	Fri, 20 Sep 2024 18:48:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bTOu9TmWvNdcYZ5frAv2/1hPAsA306/lpxLKr8
	4V31I=; b=e6XHPWFLsI4gcMMmmoLnBi8FaZCH2UmpNv1Mj8vPE2cPiXjPpNf0/U
	974HPqFKCawFjbI3y+IIDi2lkwF16djJ+9GJxl3DRt7jcq2ObZcqUFih2RzFIvOG
	QOqIgG6vAHzBzyRretE3iXTFVSfHidHhPsBMdZ5Q0kRAi/KC4/k0Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 76D1C20B70;
	Fri, 20 Sep 2024 18:48:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96B8F20B6F;
	Fri, 20 Sep 2024 18:48:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
In-Reply-To: <Zu2Eup+vjI3dALYu@nand.local> (Taylor Blau's message of "Fri, 20
	Sep 2024 10:20:42 -0400")
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2Eup+vjI3dALYu@nand.local>
Date: Fri, 20 Sep 2024 15:48:27 -0700
Message-ID: <xmqqjzf6c56s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73FFA31A-77A2-11EF-B0EA-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> * and our current contributor base doesn't reflect exactly the skills
>   needed to improve git - like interface design is not our strong suit.
>   how to attract people who are better at our weak spots?
>    * taylor: this weakness is an existential problem for Git. jj,
>      gitbutler, gitkraken, etc
>    * mark: +1
>    * peff: one size doesn't fit all, us deciding not to include a GUI is
>      understandable, but workflow improvements like jj's are pretty
>      interesting
>    * jonathan: ex. in hg there's someone very involved in UX review. we
>      don't have someone like that
> * missing other disciplines - tech writing, product management, UX
>   research, etc.
>    * common problem in open source but would be cool if we could get
>      good at attracting/retaining these people - and cool for the
>      not-eng-discipline people
>    * patrick: we could adopt a style guide or guideline but we still
>      wouldn't be good at enforcement
>    * john: people need to know what they can contribute to - cf. project
>      tracking discussion later on

Would money solve these, e.g., by hiring somebody?

The issue would be how to find somebody good ("known to be good with
past track record" would be a bonus) and ensure that the community
trusts the choice they make and the output they produce, in the
areas like UI design or tech writing, that we know are not our
strong points.  Would we be able to give them enough freedom to
produce their best product, yet be able to stop them if needed when
their output turns out not so good as we hoped initially?  Are we
equipped to fairly evaluate their output?

> * jonathan: instead of trying to guess - can we think generally, how do
>   we make work easier to approach? how can we lower the barrier to
>   entry?
> ...
> * moderation on discord is an issue - having an unmoderated discord will
>   actually drive away contributors. that means actual dedicated
>   moderation

It is not "discord" per-se, but lowering the barrier to entry would
mean you'll get more people with different background and different
idea of what is normal to deal with.

> * patrick: new contributors sending changes but the changes being
>   ignored

Paraphrase.  More patches written, not enough are reviewed.

> * jonathan: the localization example is a good one - the translation
>   layer is in github, uses a very typical dev workflow, and that's
>   working well. there's a strong community there. are there other places
>   we can do something similar?
> * peff: can we do that with documentation?
>    * jonathan: can we have a documentation maintainer? hypothetically:
>      we hire a tech writer, and that tech writer acts as the
>      documentation maintainer only. curating existing docs, making sure
>      docs changes get good reviews, how to attract new tech writer
>      contributors, etc
>    * peff: can we manage documentation as a subproject that doesn't use
>      the mailing list, and make tech writers' lives easier?
>       * how to negotiate that with code changes that require doc changes
>         is trickier, we'd have to figure out how to do it, but doable
>       * jonathan: readthedocs

There needs to be a mechanism to ensure the technical correctness of
the result to replace the public reviewing on the mailing list for
the above model to work.

>    * nasamuffin: Gerrit has a community meeting once/month, should we
>      use discord for f2f video meetups?
>    * peff: if people want to do big group meetups great. we could also
>      use it for 1:1 meetups that way, and advertise that it's an option

Sounds like a good way to make it easier to link names with faces.


