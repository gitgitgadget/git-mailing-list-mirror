Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3218E0B
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MaMKSWiO"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A3FB6
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:26:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 651CD225EB;
	Wed, 18 Oct 2023 19:26:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Kcbv/aymIoK8ghZPvUFKMg4J0nkbH7oFupozwF
	kWeRg=; b=MaMKSWiO+E5tqCb97CY6FLVCkobnOsvAZLRW44fMY8ks9P+jWKM7we
	UHtZCp9w5kYlQ5cu1Upx1vFrKgvTxrehODGTBnlvoz665ymLXF59FqdOW0wMY7Oa
	YJJbWlQ/Rl1GuYPBFACPa3ygTJlSI3qWbNv0bKeArVwK1tSWQOIvo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C317225EA;
	Wed, 18 Oct 2023 19:26:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 910E0225E9;
	Wed, 18 Oct 2023 19:26:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "Eric W.
 Biederman" <ebiederm@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 00/17] bloom: changed-path Bloom filters v2 (& sundries)
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com> (Taylor Blau's message of
	"Wed, 18 Oct 2023 14:32:22 -0400")
References: <cover.1696629697.git.me@ttaylorr.com>
	<cover.1697653929.git.me@ttaylorr.com>
Date: Wed, 18 Oct 2023 16:26:48 -0700
Message-ID: <xmqq34y71phj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D076480A-6E0D-11EE-A39C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> (Rebased onto the tip of 'master', which is 3a06386e31 (The fifteenth
> batch, 2023-10-04), at the time of writing).

Judging from 17/17 that has a free_commit_graph() call in
close_commit_graph(), that was merged in the eighteenth batch,
the above is probably untrue.  I'll apply to the current master and
see how it goes instead.

> Thanks to Jonathan, Peff, and SZEDER who have helped a great deal in
> assembling these patches. As usual, a range-diff is included below.
> Thanks in advance for your
> review!

Thanks.
