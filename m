Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6936D
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NZgLaEW3"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89828C1
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:49:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7E501CD95D;
	Mon, 30 Oct 2023 20:49:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mpp1UOhhGWhFuCePWwoV5e8D0HnrnQCJVB6I9R
	MGB6k=; b=NZgLaEW3EjgluIO1CmAiyD0wLF6/owAVtMOXxxol4kwk6bKmVJeRWh
	gxBVRsWLFoZWHtim0D3cjAUIFZYfGQFR+TbIqtZAVCPZJM14fNQ98fIXGlQ89UBt
	M1ZrODJILBpOYqTUZLeXPOzy/0K8p6Iyo1JVTYaLoR3yefHVH9DHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C04D81CD95C;
	Mon, 30 Oct 2023 20:49:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3809B1CD95B;
	Mon, 30 Oct 2023 20:49:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Erik Cervin Edin <erik@cervined.in>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Bug: Git grep -f reads the filename relative to the repository
 root
In-Reply-To: <ZUAnEVk65VQQE263@nand.local> (Taylor Blau's message of "Mon, 30
	Oct 2023 17:58:41 -0400")
References: <CA+JQ7M_htKUv5=GRQEUqWmJrQmFQNfZkPjr8n12CU6x0Khr4dw@mail.gmail.com>
	<xmqqedhzg37z.fsf@gitster.g> <ZUAnEVk65VQQE263@nand.local>
Date: Tue, 31 Oct 2023 09:49:10 +0900
Message-ID: <xmqq4ji77h15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4E447FD6-7787-11EE-83EE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Just going through old mail that I didn't have a chance to respond to,
> the proposed patch that you included here does compile and pass t7810
> for me, and the fix looks reasonable as-is. I don't think I see this
> patch on master, but would have no objections to you merging it down.

Thanks.
