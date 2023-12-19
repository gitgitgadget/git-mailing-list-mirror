Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6459931A62
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DYnXLs0F"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A17E1B1880;
	Tue, 19 Dec 2023 12:30:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KMrCyXf0Q1Wl
	o69qzCHwfZQj66qlzqJFZ279D+ysA5o=; b=DYnXLs0FpliLwyyO3LpujDDl6ihP
	uDcdiFnXIm9HpUjNdbHgAvxdd3TX3+4rodJTHjazM6b3GL/ywgv7zWnXrtlBwa9B
	AJ2RSKXd6Rwh++eQ1KAipvoAgtlCyLHl/DK8dbwmhDI3y3chqLe9HBBmrCGQJf7m
	uVvoQ/fRX73rQlE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 01B881B187F;
	Tue, 19 Dec 2023 12:30:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FAF71B187D;
	Tue, 19 Dec 2023 12:30:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2023, #03; Mon, 18)
In-Reply-To: <3e6c7e70-33c2-4607-b9a3-8d70d2a83ff5@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 19 Dec 2023 17:42:46 +0100")
References: <xmqqr0jjc86e.fsf@gitster.g>
	<3e6c7e70-33c2-4607-b9a3-8d70d2a83ff5@web.de>
Date: Tue, 19 Dec 2023 09:30:23 -0800
Message-ID: <xmqqfrzycd74.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4AE731D8-9E94-11EE-89FB-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 19.12.23 um 02:06 schrieb Junio C Hamano:
>> * rs/t6300-compressed-size-fix (2023-12-13) 2 commits
>>  - test-lib-functions: add object size functions
>>  - t6300: avoid hard-coding object sizes
>>
>>  Test fix.
>>
>>  Will merge to 'next'?
>>  source: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
>>  source: <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
>
> The first patch is good to go.  The seconds one isn't; please drop it.

Alright.  Thanks.  Will do.
