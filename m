Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC372DDCF
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242216; cv=none; b=avJTlReQnErwAZtcFKnj8CvoeuDMgCqNVr6k1v3W+AGbSxKPMH9p/u8vJf+VDNsBqpb0q5r4lwEH5dUb+7z/B5s8Q0fzmiNUfrpU0adKWLaOpS3dadK8HK+LEpuj/D+CtM8+fuoKvwVOWzG6DcT+8Gvbi4RMqcXfGWPAoewvaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242216; c=relaxed/simple;
	bh=KM7vEZfIrbAGIKOaXW2FS+eG6PpUGHTnxOCFNFxSrP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l8omL2KBtXixjlUQP40W14338ETBKe1MI6ZLyMbf1Pmk5buBBAEt80YaCFySnFQDQiGVZNs411UO+tg3nDYt8IoH1YF2MCdL9pQekTRxkkZP+8r2+cCpt1ci0UYDnpZ7FnnDd0crS+AqC8kDh5nLxIQgzWXdQhL4L2RBdOllScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aF53r4sK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aF53r4sK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EC1E820E58;
	Tue,  6 Feb 2024 12:56:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KM7vEZfIrbAGIKOaXW2FS+eG6PpUGHTnxOCFNF
	xSrP0=; b=aF53r4sKQ1+gawCe+u2kQhWH0GYyPu5BWTwR9QLDZ6S7DSUe5VjcXP
	x6qZiiFQq+Rp0p1e1G8m68hCC1kkHWbC1rYslqo18Kw3ANTJpa08i8Sr5+xgA0c5
	Gyg3aQTEv02iUo481IxHIBcBEHv15ybepkGUBFzXhJkdoR3FqNdjs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E4ED020E57;
	Tue,  6 Feb 2024 12:56:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95F5720E56;
	Tue,  6 Feb 2024 12:56:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] .github/PULL_REQUEST_TEMPLATE.md: add a note about
 single-commit PRs
In-Reply-To: <b7789242-5eee-3b1b-54e7-cafce96f2340@gmail.com> (Philippe
	Blain's message of "Tue, 6 Feb 2024 08:17:10 -0500")
References: <pull.1665.git.git.1707069808205.gitgitgadget@gmail.com>
	<xmqqsf28oufw.fsf@gitster.g>
	<b7789242-5eee-3b1b-54e7-cafce96f2340@gmail.com>
Date: Tue, 06 Feb 2024 09:56:49 -0800
Message-ID: <xmqqttmliihq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A9B03D2-C519-11EE-B844-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Yes, it probably is possible, and Dscho suggested the same in [1] and [2].

Ah, great minds think alike, and Dscho's suggestion was made a few
years ago already.

> I'll maybe get a crack at it eventually, but I hope in the meantime this
> simple addition to the PR template will help a bit.

Perhaps.
