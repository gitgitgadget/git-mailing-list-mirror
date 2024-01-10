Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111D4A986
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XIfPPEnx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AAC92F46F;
	Wed, 10 Jan 2024 11:27:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sJ0b80yvGWvO5K0FtTg1Usfx1QFVCWHRA25X3t
	UKAr8=; b=XIfPPEnx91cSzAIJ3R5Lu+gY1IB/Zi4p+yCmSx5onWu1QYT7V0p4g5
	Sqwd01iTNNFYnHASRipgUJbKJFIsD5WlpR/wvcwK6OhsgFyz+rNkDZo9u2WAJOR+
	TC8NFAe034BdSZsBEvLZ4fxaIJX4/sU9pU/IQD09CMLqi4PAxNeU8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 434F22F46E;
	Wed, 10 Jan 2024 11:27:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 790E52F46D;
	Wed, 10 Jan 2024 11:27:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: [PATCH 4/6] t1419: mark test suite as files-backend specific
In-Reply-To: <ZZ5HrY76O1x8QABG@tanuki> (Patrick Steinhardt's message of "Wed,
	10 Jan 2024 08:30:53 +0100")
References: <cover.1704802213.git.ps@pks.im>
	<d7c6b8b2a7b3b4d776f06ce577bdbdbaff66f225.1704802213.git.ps@pks.im>
	<CAPig+cTAiEFu9p1nRe9LC3mxyPmfQ9m4r7aQUj_9OC8pSbwbig@mail.gmail.com>
	<ZZ5HrY76O1x8QABG@tanuki>
Date: Wed, 10 Jan 2024 08:27:29 -0800
Message-ID: <xmqqcyu9duha.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 272B301C-AFD5-11EE-8118-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

On just this (non-technical) part...

>> > file, but not for loose references. Consequentially, all callers must
>> > still filter emitted refs with those exclude patterns.
>> 
>> s/Consequentially/Consequently/
>
> Hum. I had the last time when you mentioned the in mind while writing
> the commit message, but seemingly misremembered the outcome. So I now
> looked things up in a dictionary, and both words seem to be used in
> equivalent ways. As a non-native speaker, could you maybe elaborate a
> bit to help me out? :)

As a non-native, I often find this

  https://trends.google.com/trends/explore?q=consequentially,consequently&hl=en

fairly useful.
