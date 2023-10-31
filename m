Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B721110
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TzChc08i"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27497DA
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 16:40:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C9B01D5A9F;
	Tue, 31 Oct 2023 19:40:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gKJHTn5EO8ezACQotczBkS0fvS7vrdxF/B22qH
	2+D/k=; b=TzChc08isjxHgbbFVJHHgKKwQHMbMl47Wh0DVFkZdb1ZCArezuQP/S
	SQn61YDQ1ovLUZQj7oA579PrN0T9CtzYLNUq8L9ZpJUXA2nhYhb0Dd3MjpJOqM9E
	MIVlbLzQsn/3Am/td6Qy0MKzQvXWATpCIhHoNHTHvZDt/JueTZur8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2503D1D5A9E;
	Tue, 31 Oct 2023 19:40:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 948821D5A9D;
	Tue, 31 Oct 2023 19:40:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Aditya Neelamraju via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Aditya Neelamraju <adityanv97@gmail.com>
Subject: Re: [PATCH] chore: fix typo in .clang-format comment
In-Reply-To: <ZUFQzFcgGdJsPJ8G@nand.local> (Taylor Blau's message of "Tue, 31
	Oct 2023 15:09:00 -0400")
References: <pull.1602.git.git.1698610987926.gitgitgadget@gmail.com>
	<ZT/gQZlVKfgn/+BZ@nand.local> <xmqqpm0v5vtg.fsf@gitster.g>
	<ZUFQzFcgGdJsPJ8G@nand.local>
Date: Wed, 01 Nov 2023 08:40:36 +0900
Message-ID: <xmqqbkce1hu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4C58ED6-7846-11EE-BD6C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>> As a comment for a new contributor, it is a bit unhelpful not to
>> suggest what the "subject area" string we would use if we were
>> working on this patch, I think.
>
> Good suggestion. I would have suggested "clang-format", which is
> exactly Aditya ended up choosing, anyway. Thanks, Aditya!

Thanks.  I was being lazy when I said the above ;-)

Teaching how to fish instead of giving fish, the way I would have
done is

   $ git log --no-merges --stat --full-diff .clang-format

and inspect what they use.  The ones that used "clang-format:" are
indeed very similar in spirit to what this one does, I would say.

Thanks.

