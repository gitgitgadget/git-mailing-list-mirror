Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2B1EB36
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727127075; cv=none; b=jQ9QvLpOzqqF8NsWbHA81/DrmpGExJ48QXMt5FlxsIPwajD9TMO7KYFAOxL+QamgQyEbdk/W0HfzbArUWAECGCIEInzT2Bh/spIIP5XxYZjObvINO3MBvuWV5fwGaO7HIPQbUSLAz2hIewdgCVQFILGsm0U//dK/doFDaiXmidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727127075; c=relaxed/simple;
	bh=6rsCaoonXn5fM/nZFJIfCKNoh8dfofUaxTwHiBfqX6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iBCmkMBrPmld4D+v2uoD+qWN+PWiPXM+gEyVVHmqqcjnoS5tGfsvvzV14Qpi6NKV1eK7TDI1Y+x+LUxmjG5zffF5rlogA+Av7M+vNdyVArnQ7OYoWEj9MCqVt2FjXUTmgnns1DX7PFdr8dcu6cXyy27L1c6ZmqnuNoU7Z/W0cH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=COc4Irgg; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="COc4Irgg"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2FE22649B;
	Mon, 23 Sep 2024 17:31:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6rsCaoonXn5fM/nZFJIfCKNoh8dfofUaxTwHiB
	fqX6g=; b=COc4IrggH8B3nt/ZSiRlTnJvCarQluk3XNXUgvFh6l59BFcQFl20bH
	2UxDAMQSM4HDz/4lUrcT1mpWbxhv1ZDChcJccE4qw+1jnirYxCiB1dBS4i8tzvxZ
	uzWEF1Pr2COZymMjFGq0oO5dH22taAHY6gwvmG09bBn0yJmkPT+0I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82D7B26499;
	Mon, 23 Sep 2024 17:31:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF4F926496;
	Mon, 23 Sep 2024 17:31:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
In-Reply-To: <20240923-spirited-lime-lyrebird-fe90d5@lemur> (Konstantin
	Ryabitsev's message of "Mon, 23 Sep 2024 09:51:49 -0400")
References: <Zu78E+0Uk5fMSeQv@five231003> <xmqqsetr5wl1.fsf@gitster.g>
	<20240923-spirited-lime-lyrebird-fe90d5@lemur>
Date: Mon, 23 Sep 2024 14:31:07 -0700
Message-ID: <xmqqbk0exdk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 263D983C-79F3-11EF-A8DD-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> I can chime up and offer bugspray bot integration for the list. This is a new
> tool I've been developing for integrating the mailing list with bugzilla. I've
> been using it on the tools mailing list over the past year with reasonable
> success.

Intriguing.  Everybody loves to hate bugzilla, but would bugzilla
become less smelly with bugspray enough to make it palatable to all
of us?

> Bugs can, of course, be easily queried, assigned, and tagged with keywords
> that can be filtered.
>
> Bugspray is still in early development, but I plan to continue expanding its
> set of features, because we hope to make bugzilla actually useful for kernel
> bug reports.

;-)
