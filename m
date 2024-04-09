Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE524F881
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627376; cv=none; b=MtvIWAiGg3a5h/8hhEDZSPH0FKmaLjZX74vYRawr4kAStamJPGNAgZkej7Wz8qiEUFy/ZHDJ2gOU3tTD8UNLMUuNjV0nAsg7blr/2Qv0ewIa68iEwqsoqmtPnij1wtf2HU8jqmlEHbJe27tptqHmv4YoG+9Y5OTA3HcJI/t74Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627376; c=relaxed/simple;
	bh=MoXnKXzxkfUKuMvR2REL1qOyxBZQDA0dJTZu36iUm+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BWFA3niTHdUy7Im7htLAH4C1fjMtPaZWrda8dmW1ga2ot+cxnQlo0YeAOLJi5HlcuyMfZfAHGjhAumIFmg7MrQ6hm94Dl54CjES8hZ6XWCoJtnYMfYuVnYhkii7rZ3AW18Il9yClCi2D16WDe6lbwNfuXw8jzSx+9SOTEIzKtxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HseLgIP8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HseLgIP8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 136CD1F6B4E;
	Mon,  8 Apr 2024 21:49:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MoXnKXzxkfUKuMvR2REL1qOyxBZQDA0dJTZu36
	iUm+g=; b=HseLgIP8SNF2UfsmJZN/r2gmjbYQo+07mnhDznk6dNy+of1OTfYcw6
	yv2Hex2Pdd5TUZUkcmlgla5FvaJOzocxc1aUxKXjJEfNU/W3Almyv6ofQGdrOpaL
	7w/dbRby2pB4tPIGRh1tMZMW/c44I/og+E9oddDhDBd6jLLJfdIXQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A93F1F6B4D;
	Mon,  8 Apr 2024 21:49:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77EF61F6B4C;
	Mon,  8 Apr 2024 21:49:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>
Subject: Re: [PATCH v2 1/8] MyFirstContribution: mention
 contrib/contacts/git-contacts
In-Reply-To: <owlypluzs5qa.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Mon, 08 Apr 2024 18:08:13 -0700")
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<3817e7f3cd007fe26b8bfdec6babed1c17ec3795.1712366536.git.gitgitgadget@gmail.com>
	<xmqq8r1rqlgn.fsf@gitster.g> <owlypluzs5qa.fsf@fine.c.googlers.com>
Date: Mon, 08 Apr 2024 18:49:32 -0700
Message-ID: <xmqqv84r2tlf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 69CEFF00-F613-11EE-B2D2-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

>> As I prefer not to be too assertive, something like
>>
>>     The `contrib/contacts/git-contacts` script may help you coming
>>     up people you may want to ask to review your patch by adding
>>     them to the Cc: header.
>>
>> is as far as I would go, but for those who are not familiar enough
>> with the project, perhaps it would be OK to assume that the script
>> would do a much better job than these contributors would do
>> themselves, I guess.
>
> Yeah for newcomers the tool would probably do a better job. Perhaps
> wording it like "If you're not sure who to CC, use
> `contrib/contacts/git-contacts` to ..."  would be better?

Sounds reasonable.  Thanks.
