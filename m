Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1B5680
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GJxFyJeQ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E3C2
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:48:58 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FE631CB9BC;
	Wed,  1 Nov 2023 19:48:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R76SD21pGsnaDhVqKP1w8upgl7CoZGVChIusSZ
	vijUw=; b=GJxFyJeQA30gXcsVrNtAQe+x2ltC7gMKoaMRbiUf0EQHUjqc3Ow1F7
	L6t1RbQ/aLrQz4uMHY6wW1Cop+Avbb0Jrde/iVI3aKlFiNM9lob9TqC9GIRRNRvj
	vCdmORhUW2oDrAVTj82NckJc0akA/Lib22xQmrhNCIFrdDqESLoF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 465E71CB9BB;
	Wed,  1 Nov 2023 19:48:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E78B1CB9B8;
	Wed,  1 Nov 2023 19:48:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  calvinwan@google.com,
  git@vger.kernel.org,  linusa@google.com,  rsbecker@nexbridge.com
Subject: Re: [PATCH v8 2.5/3] fixup! unit tests: add TAP unit test framework
In-Reply-To: <ZUKQ8xtFSYbSBPXb@google.com> (Josh Steadmon's message of "Wed, 1
	Nov 2023 10:54:59 -0700")
References: <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
	<20231016134421.21659-1-phillip.wood123@gmail.com>
	<xmqq1qduo6yr.fsf@gitster.g> <ZUKQ8xtFSYbSBPXb@google.com>
Date: Thu, 02 Nov 2023 08:48:55 +0900
Message-ID: <xmqqmsvxox08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 38A361F2-7911-11EE-A0DC-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2023.10.16 09:41, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
>> >
>> > Here are a couple of cleanups for the unit test framework that I
>> > noticed.
>> 
>> Thanks.  I trust that this will be squashed into the next update,
>> but in the meantime, I'll include it in the copy of the series I
>> have (without squashing).  Here is another one I noticed.
>> 
>> ----- >8 --------- >8 --------- >8 -----
>> Subject: [PATCH] fixup! ci: run unit tests in CI
>> 
>> A CI job failed due to contrib/coccinelle/equals-null.cocci
>> and suggested this change, which seems sensible.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  t/unit-tests/t-strbuf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Applied in v9, thanks!

Thanks for working well together.
