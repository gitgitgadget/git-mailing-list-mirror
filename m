Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CCF4EB5B
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="foJHBrgD"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 360AF1C8DE5;
	Wed, 10 Jan 2024 16:25:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ChifrKAlXnVX1MLegFi9Hf0AJ8JlEpiBaGCFCo
	a8+B0=; b=foJHBrgDK1tHaWpMVk76tN6gNzRJKkpmZH+qa9YA4FYC1oOX2Y6R9u
	zlZzwRo7IVDUv7P8G/IuauCsAJDOJ5PWOpL6e7noZ+ifaZSx4eKlIzKZLRYC+vQ/
	LOAIwMaXLLi3FzXNVOcLfiExSPIY0xArblD1AnIk39h5xtr18kI78=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E72A1C8DE4;
	Wed, 10 Jan 2024 16:25:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71F5E1C8DE3;
	Wed, 10 Jan 2024 16:25:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: ps/reftable-optimize-io
In-Reply-To: <ZZ5AJL4di1TAC-up@tanuki> (Patrick Steinhardt's message of "Wed,
	10 Jan 2024 07:58:44 +0100")
References: <xmqqsf36dotl.fsf@gitster.g> <ZZ5AJL4di1TAC-up@tanuki>
Date: Wed, 10 Jan 2024 13:25:25 -0800
Message-ID: <xmqq1qaoanju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C57B2208-AFFE-11EE-A563-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Let's wait a few days for reviews. I don't expect there to be a ton of
> reviews from the usual contributors due to the still-limited knowledge
> around reftables in our community.

A successful nerd-sniping?
