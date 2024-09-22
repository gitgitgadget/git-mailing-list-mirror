Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F9B64A
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034281; cv=none; b=LuhktwqY8+KW8QcHH4Apa06s0ut1kIgmp7mxhIKovRfrruisxV2H9wvBGl+dZ1D1Fw/+POqOmqgx3OmF5lSFtkmsHq7NXF0UEV4aM5ROHweIc6YXZW/t2CiwgnEHDNNQTAiUfmF+dF4ayVlE3v9aAdA1Y7+f9Rpw92SGR6ELQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034281; c=relaxed/simple;
	bh=p557h7bZ7LSx+xXLMCH7D5m7Lm0Eat0ELldkUTDhDdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENZ31EZjeGF6OmuqGlr+n5gURK1/wAiBIepHR5rRf0Isq/+JJx1mPeuwP+IeNqKuA6OCOJvNbHp6pVIs+TCMTOKVcArspWFil7V/nBmld8VIZ4t00dfT9bT1Us67OSSdHEtJssGG4kqkyVYTMzxfU6sEo7EHG4BhJBWkIMvShEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q0IRFKzH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q0IRFKzH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6144C3A14C;
	Sun, 22 Sep 2024 15:44:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=p557h7bZ7LSx+xXLMCH7D5m7Lm0Eat0ELldkUT
	DhDdY=; b=q0IRFKzHBTzg5yt0iAFCG6BAEKN4KviOieBYftWa6swWwBx7QQAiQX
	fp2okC0Gp9nmAcSFz0dbJQvF8XrQx7rRf0DuLJfB8bbuqNnMEF9Lr6VK+HgN+ogr
	WIkeOKYv7AOO9ZLy+fTSvBU1lAV5Xwmh2FUyUQMFcN+/o5f2I/PDQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5991D3A14B;
	Sun, 22 Sep 2024 15:44:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD9853A14A;
	Sun, 22 Sep 2024 15:44:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
In-Reply-To: <xmqqsetr5wl1.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	22 Sep 2024 12:15:22 -0700")
References: <Zu78E+0Uk5fMSeQv@five231003> <xmqqsetr5wl1.fsf@gitster.g>
Date: Sun, 22 Sep 2024 12:44:36 -0700
Message-ID: <xmqqikun5v8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 19EE9280-791B-11EF-8ECF-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>  * "#leftoverbits" is just that---a direction we could explore in
>    the future, and the journey that goes in the direction is limited
>    to a short and trivial one.

Correction.  "is limited" -> "is not limited".

> Quite honestly, I sometimes failed to find much value in the review
> these meetings produced, and I suspect it was not due to lack of
> preparation on participants' side, but was largely due to the fact
> that the face-to-face meetings cannot go to sufficient depth in
> technical conversion in a single sitting.

Correction.  "conversion" -> "conversation".

> There however was a lot of value in the mere fact that people had a
> face-to-face discussion on something, anything, that was related to
> the project.
>
> Thanks.
