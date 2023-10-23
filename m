Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39015219F4
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZG8Y8rf1"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC9898
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:02:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 017AA3F81E;
	Mon, 23 Oct 2023 15:02:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a+LnVTNpcXvUgBYeS/F8Pjshpo9teNvBCOLuTs
	i0mxU=; b=ZG8Y8rf1BrxHrHXcIKq/EyJtlAoB93QgueVkEyW8ksgnblUpBeFEsi
	CYIH//39SrmS6KwDui7xk38R2x6PihFZgIQx2FpoyiMcEhCTUjLsryAJnV8bYcCr
	j0ogUI9ufVRgQR6Qjirb4zryPu+GyavbFuvHlt3OqLXaJlPZkHrm4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EE6433F81D;
	Mon, 23 Oct 2023 15:02:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6A4A43F81A;
	Mon, 23 Oct 2023 15:02:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] rebase refactoring
In-Reply-To: <4f8616d1-35f2-418d-9d28-b230ca45090d@gmail.com> (Phillip Wood's
	message of "Mon, 23 Oct 2023 16:43:32 +0100")
References: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
	<20231020093654.922890-1-oswald.buddenhagen@gmx.de>
	<xmqq5y31osmg.fsf@gitster.g>
	<4f8616d1-35f2-418d-9d28-b230ca45090d@gmail.com>
Date: Mon, 23 Oct 2023 12:02:10 -0700
Message-ID: <xmqqbkcpnowd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ABCF90DE-71D6-11EE-9400-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 20/10/2023 23:07, Junio C Hamano wrote:
>> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> 
>>> broken out of the bigger series, as the aggregation just unnecessarily holds it
>>> up.
>>>
>>> v3: removed "stray" footer. so more of a RESEND than an actual new version.
>>>
>>> Oswald Buddenhagen (3):
>>>    rebase: simplify code related to imply_merge()
>>>    rebase: handle --strategy via imply_merge() as well
>>>    rebase: move parse_opt_keep_empty() down
>>>
>>>   builtin/rebase.c | 44 ++++++++++++++------------------------------
>>>   1 file changed, 14 insertions(+), 30 deletions(-)
>> Looking quite straight-forward and I didn't see anythihng
>> potentially controversial.
>
> Yes they look good, thanks Oswald

Thanks, both.  The topic has already been merged to 'next'.
