Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB738DE9
	for <git@vger.kernel.org>; Wed, 15 May 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792993; cv=none; b=fxzVyGlHiTdq3cMP2u0goEFRuU4L34N/G/mYEu532pjA31Y7pcGrIKo8WNsDtw8Aon8y+ZJMoPu6CDAHu2p8U2QAwUMPA3prTeZnNzDhbcluOv/m5qOnKeZWWNbQb6HP9HmOBbwT+ays1zSdWNvzfO7zDmuirAmt/4GRQBRqkXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792993; c=relaxed/simple;
	bh=jw8TAl3ohMwmQkNRS5iIS1OjH2rhpbjIeJ9GzT7gvC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JtTsqWCAJ+glxn97++sTPF3hsn3ICj+jQQkDbsXP1DCBNMnGDh5UIo+6z3iq42HZ+mgRtlQN4HxrFhcxoNxxHwyZR52b15apykBmYVYVDZ6P427o0bcD2dHddKhi2gIqNOyxOW0CC6VK0EG3EFxjPCdGV62fI+H60dnpkLJYXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QCVLeB0K; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QCVLeB0K"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B0241EACA;
	Wed, 15 May 2024 13:09:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jw8TAl3ohMwm
	QkNRS5iIS1OjH2rhpbjIeJ9GzT7gvC0=; b=QCVLeB0KbKZi3c6EhsRKdaZ5tRBQ
	qVfUzCuAuqF2OiS2fA9d0aEy4TO63nzhR9dxhUY2rtzjrktmlKFo5NGxPLOURed5
	KBTlFGfUtiBIWLzCx8+EmxqJ2oflGGTU6BXzcF6e63/LMSq1XtZgrINjw4L9NBDU
	+af2ZHoVgTdtqOU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 63DC11EAC9;
	Wed, 15 May 2024 13:09:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E04D71EAC6;
	Wed, 15 May 2024 13:09:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: Marcel Telka <marcel@telka.sk>,  git@vger.kernel.org,  Jeff Hostetler
 <jeffhostetler@github.com>
Subject: Re: t0211-trace2-perf.sh: typo patern -> pattern
In-Reply-To: <fe76b111-f080-5d1f-c51f-591e9381c116@jeffhostetler.com> (Jeff
	Hostetler's message of "Wed, 15 May 2024 12:59:10 -0400")
References: <ZkTIPlTS4jcQ-rHX@telcontar> <xmqqjzjvxbk0.fsf@gitster.g>
	<fe76b111-f080-5d1f-c51f-591e9381c116@jeffhostetler.com>
Date: Wed, 15 May 2024 10:09:46 -0700
Message-ID: <xmqqr0e3vw6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EF0B649C-12DD-11EF-9B82-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 5/15/24 12:52=E2=80=AFPM, Junio C Hamano wrote:
>> Marcel Telka <marcel@telka.sk> writes:
>>=20
>>> Hi,
>>>
>>> There seems to be apparent typo in the t/t0211-trace2-perf.sh file:
>>>
>>>
>>> --- a/t/t0211-trace2-perf.sh
>>> +++ b/t/t0211-trace2-perf.sh
>>> @@ -233,7 +233,7 @@ have_counter_event () {
>>>            pattern=3D"d0|${thread}|${event}||||${category}|name:${nam=
e}
>>> value:${value}" &&
>>>   -       grep "${patern}" ${file}
>>> +       grep "${pattern}" ${file}
>>>   }
>>>     test_expect_success 'global counter test/test1' '
>> Ah, indeed, there is no assignment to the variable $patern so this
>> grep matches by looking for all the empty strings in the file X-<.
>>=20
>
> OOPS.
>
> Thanks for the fix.

Nobody sent an applicable patch yet, though ;-)
