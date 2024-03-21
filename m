Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B15474D
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026730; cv=none; b=XdL1Jm7TwsbzQT1ZRtvmF/C8ehX1DbeD1c3J2JHoHmrP8qzrnz1isUxYkI63albfkBmzXBl3glT37UmBNC4y2TW8tuonQYrK0/T0fHjRoQcPU63fI02zkpvTInBLgVV1dFQXAy9TsBD+vpxfxxKR4O9WzL/eQs3Ef1KrHOR+dE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026730; c=relaxed/simple;
	bh=Zb5Hzo6Kr1m8yjB+xYfxWbOuD4xgr1dk+MGrlTYUp3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oUuT8454cXyRYlwiubvwgTf4BWsPPPMaznzgFmp8zBZ90hp4TmMkV0aHqJteqar6j1D87Pfms8Vv8aRJZhPZyQY3UirTSWxsnHaVvPLmZFdjUjPyo2o4Mw8hYnyCER+DUyWFCOcI/h8foatjDXt+GBFCSBofgg670f6rDKQcvbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cKCttyJu; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cKCttyJu"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D0AD72A9E2;
	Thu, 21 Mar 2024 09:12:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Zb5Hzo6Kr1m8yjB+xYfxWbOuD4xgr1dk+MGrlT
	YUp3I=; b=cKCttyJuzgj6zQOjAbR6QRTdxs66ukoaWoHegxSPmed95/urxo/ibx
	mDSZslWhX9axgNGqVv5Q9uT3IWHI61Ddjp2ACqTwwF1eDxN8dbFuumoc8mt7ZlYq
	k70O8oNEnbbQrBhi2V8d/OZYcmdP54kSljsjujpPGsv7xBMj15YxY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C33FE2A9E1;
	Thu, 21 Mar 2024 09:12:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC17A2A9DC;
	Thu, 21 Mar 2024 09:12:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: A note from the maintainer
In-Reply-To: <17bea3e3320609ca.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Thu, 21 Mar 2024 01:38:24 +0000")
References: <17bea3e3320609ca.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 21 Mar 2024 06:12:03 -0700
Message-ID: <xmqqwmpvbufw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9CE72522-E784-11EE-A695-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

>> I actually meant what I wrote.
>> 
>> It is possible that the reason why your patch did not receive any
>> response was because it was uninspiring, looked useless, and did not
>> deserve anybody's attention.  But it is also possible that it was
>> lost in the noise.
>> ...
> Thanks for the clarification. I do still think that a change in the
> wording and tone of this section could help make the project appear more
> friendly to new contributors. Phrases like "totally uninteresting",
> "uninspiring", "looked useless", and "did not deserve anybody's
> attention" are all fairly harsh sounding, even if sometimes true.

You completely lost me.  How much harsh words are used before "But
it is also possible" would not make the project sound less friendly
at all.

Let me try again.

You see your patch was sent but did not receive any reaction.  You
might start thinking: "hmm, perhaps my patch was so horrible" and
you might think all the bad and harsh things about the quality of
your patch.

But do not let such thought stop you from pinging the thread again,
because the quality of your patch may not at all be the reason why
you did not receive any reaction.  It could be just people were
swamped and your patch fell into cracks, and there was nothing wrong
with it.
