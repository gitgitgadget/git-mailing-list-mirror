Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="agbXKRJL"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5BC9F
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 11:20:51 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DE59E2EA4C;
	Tue, 12 Dec 2023 14:20:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tWZvgcRotJ2xtTxlu3AhHu7e7gB8+kZ/pbgef3
	wW+zo=; b=agbXKRJLsmbrybG4oVQ5LyycipcIaJCBDOshtBxjoo8bnzVRvpHvyk
	8zricxuOESZNk1rG3adwR9SGgaj/yDUh+5C6GQb+tVKpXGPEZjL6pFtLAEyptJrC
	G76NE/eBnM9dBHMPTdVi58q3dr1b9zyX4/TAsaQTAMk/bdhjRA4BQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CAB162EA4B;
	Tue, 12 Dec 2023 14:20:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 669792EA4A;
	Tue, 12 Dec 2023 14:20:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] clone: fix init of refdb with wrong object format
In-Reply-To: <cover.1702361370.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 12 Dec 2023 08:00:37 +0100")
References: <cover.1701863960.git.ps@pks.im> <cover.1702361370.git.ps@pks.im>
Date: Tue, 12 Dec 2023 11:20:45 -0800
Message-ID: <xmqqfs07rzw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8DA50C28-9923-11EE-BA8F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series to make git-clone(1)
> initialize the reference database with the correct hash format. This is
> a preparatory step for the reftable backend, which encodes the hash
> format on-disk and thus requires us to get the hash format right at the
> time of initialization.
>
> Changes compared to v1:
>
>   - Patch 1: Extend the comment explaining why we always create the
>     "refs/" directory.
>
>   - Patch 3: Explain better why the patch is required in the first
>     place.
>
>   - Patch 4: Fix a typo.
>
>   - Patch 7: Adapt a failing test to now assert the new behaviour.
>
> Thanks for your reviews!

Everything I see in the range-diff looks very sensible.

Will replace.  Thanks.
