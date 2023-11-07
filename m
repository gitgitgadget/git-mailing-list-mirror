Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5E259D
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KVAVwTFN"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178DB115
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 18:20:59 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 824E11CF876;
	Mon,  6 Nov 2023 21:20:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IdG6Gh8soalWQSTd4UGQW0DSz395w4DSXtOoF5
	LbTG0=; b=KVAVwTFNauwz/MSXaj03E38JGoh7XMjpt7IVlje9RTVWcBU+uQJsgG
	AUpZDNKZ9P8epvXewaeV+IBtVEKOVHW6TZrM334hDM/7wJ5zcE/sfypdOIPXnQxS
	fCxpRk+WTeF/plDiBQd8fH8WUUr8t9J779BVKj8Vip2g5bSYJE4qs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A2AD1CF875;
	Mon,  6 Nov 2023 21:20:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D149C1CF872;
	Mon,  6 Nov 2023 21:20:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] Memory leak fixes
In-Reply-To: <20231106173205.GD10414@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 6 Nov 2023 12:32:05 -0500")
References: <cover.1699267422.git.ps@pks.im>
	<20231106173205.GD10414@coredump.intra.peff.net>
Date: Tue, 07 Nov 2023 11:20:56 +0900
Message-ID: <xmqqedh2b8xj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 495CF1AA-7D14-11EE-9B68-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Mon, Nov 06, 2023 at 11:45:48AM +0100, Patrick Steinhardt wrote:
>
>> this patch series fixes some memory leaks. All of these leaks have been
>> found while working on the reftable backend.
>
> All four look good to me (and the refactoring in 3/4 is very cleanly
> done).

Thanks, both.
