Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3532C7D
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jjGbFHQW"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A9211D
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 11:01:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F52A29348;
	Thu, 19 Oct 2023 14:01:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iMC+WdHVMe4KW0f5uYFEReDwTIS3maCoyMJurh
	xvSq0=; b=jjGbFHQWOhw+bEnikFWkKHsI/l9YYNco2xeHYM6Rjlq9clnMAu6X+K
	XyXbJh34p9iqPAkA+kA4qvv8BTzU8YVzJ1xcfhLRbnaReehmHsyLGhNBt6e2U+I9
	HbqzaBXi5G18Ba7tEuBr4ZgcZ64Hp15yfavlQF7UkNLwhLLhvDYY8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 77B2229347;
	Thu, 19 Oct 2023 14:01:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B20A29343;
	Thu, 19 Oct 2023 14:01:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: update list archive reference to use lore.kernel.org
In-Reply-To: <199df43378febcc746c78029c5f90d04@manjaro.org> (Dragan Simic's
	message of "Thu, 19 Oct 2023 02:24:13 +0200")
References: <xmqq7cnz741s.fsf@gitster.g>
	<199df43378febcc746c78029c5f90d04@manjaro.org>
Date: Thu, 19 Oct 2023 11:01:04 -0700
Message-ID: <xmqqv8b2wkyn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 79A66CF2-6EA9-11EE-9F89-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> You asked for this patch to be reviewed, so I did it.  It looks
> perfectly fine to me.
>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---

Thanks.
