Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15991C2A9
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vWYalp5s"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3784E2B0D2;
	Wed,  3 Jan 2024 13:08:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gSz1UnmybCJk
	1YXAjNA3AhsHjiE96++KvVdf3x8Lwgs=; b=vWYalp5stFVu3/j6bNYlPgDk7elX
	oApDgeEhnv+hSdfMRCmKZcbUu3cEUSDJfRtvB5/2EEGi+r6QJDpjF2LaWEY5ZPjS
	kre5tZhxaF4uaeNk78vvPvCGcLLzXHMhamQEzUOakPbf3EKvmenjGteP+O7ppqpd
	nudfwmlgLcr4eBA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 306E62B0D1;
	Wed,  3 Jan 2024 13:08:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBAC82B0D0;
	Wed,  3 Jan 2024 13:08:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
In-Reply-To: <ZZWOtnP2IHNldcy6@nand.local> (Taylor Blau's message of "Wed, 3
	Jan 2024 11:43:34 -0500")
References: <xmqq5y0bcjpw.fsf@gitster.g> <ZZWOtnP2IHNldcy6@nand.local>
Date: Wed, 03 Jan 2024 10:08:18 -0800
Message-ID: <xmqqa5pm9tnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 135E82AE-AA63-11EE-91E4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Taylor Blau <me@ttaylorr.com> writes:

>> * tb/path-filter-fix (2023-10-18) 17 commits
>>  - bloom: introduce `deinit_bloom_filters()`
>>  ...
>>  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
>>
>>  The Bloom filter used for path limited history traversal was broken
>>  on systems whose "char" is unsigned; update the implementation and
>>  bump the format version to 2.
>>
>>  Expecting a reroll.
>>  cf. <20231023202212.GA5470@szeder.dev>
>>  source: <cover.1697653929.git.me@ttaylorr.com>
>
> I was confused by this one, since I couldn't figure out which tests
> G=C3=A1bor was referring to here. I responded in [1], but haven't heard=
 back
> since the end of October.
> ...
> [1]: https://lore.kernel.org/git/ZUARCJ1MmqgXfS4i@nand.local/

OK, let's ping just once then.

Thanks.
