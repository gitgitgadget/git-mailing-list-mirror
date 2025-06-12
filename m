Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0A197A8E
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749699997; cv=none; b=rNvW1LlJ4D6EYHmnVe07GKCT5VU1c4DDwXXrLaZ3znlFBlGlNrSEaLzF0jrtydUjphy+nU30hQp6Yzxpw85eKNFOkwoyS5QuKaXW4g+20e5vgr3BK5UczKik69SA4dPl+m5OUVQoo+ICJm80ykGplYY0EsvpB/6M3uYf0+Dj33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749699997; c=relaxed/simple;
	bh=nTq25ajO3QLz7gjpRWTEKGlMTqRd7a8iIAnTvGwSd/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7313m7xcMH6MsMQtx0xQ0J77eDx5ignmUi9GaxmV5ff1FtCoM540JfO3x68UmQjRsKKX5uV3+a/YQP1hCTdWnrCZl2rxWOLHvE6YVT+w6qenZG3Cp4RrFnILQmhnarsfJcsL1O+Zw3rxwG8uGjJvhGZWkgZDWCTgUFAJm36g0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=hvRsD+aO; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="hvRsD+aO"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bHpNn1RRGz8PbP;
	Wed, 11 Jun 2025 23:46:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=nTq25ajO3QLz7gjpRWTEKGlMTqRd7a8iIAnTvGwSd/U=; b=hvRsD+aO0jKC
	+4kOBwl1puzRHOKKEfbCGnPUcYZS/lUrasxJc90UjpYXL5LB33cyUMOTBw/L0YHs
	7H3ZVaKpFJg0JfT1DM5WWxf15f99J8A1J3J6nxg2FegwhSSWYsnnB24LIrA7PMd8
	D0S4VtzlG+OZySw3ylFg6Cqpk5PxH3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=M2s
	Ngqc/mxLVtRdG/gNyOhjy/IMC+FyzfFkIhmLWrgWZinRlJAe4nJH6BhWDJbUpk78
	STjqi6XnTuVu4ebnJe1hg9/4nC9gjK+Ya7IDDUMvMYGlbjJP6gDuuGJaDVpx36hd
	HE1nqtHo8epLWJpFGKMmUOe0JARx6x3nVA0BM840=
Received: from [IPV6:2001:470:b050:6:142d:4b81:8fea:90b2] (unknown [IPv6:2001:470:b050:6:142d:4b81:8fea:90b2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bHpNm5p7qz8PbN;
	Wed, 11 Jun 2025 23:46:32 -0400 (EDT)
Message-ID: <cca64148-3f55-4ec7-9684-f475bfadeded@comstyle.com>
Date: Wed, 11 Jun 2025 23:46:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: update settings for FreeBSD
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org
References: <aEpF3ZjNwkR8FssX@humpty.home.comstyle.com>
 <87ikl1eiuf.fsf@gmail.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <87ikl1eiuf.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-11 11:31 p.m., Collin Funk wrote:
> Hi Brad,
>
> Brad Smith <brad@comstyle.com> writes:
>
>> FreeBSD 6.0 has memmem().
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>>   config.mak.uname | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/config.mak.uname b/config.mak.uname
>> index b1c5c4d5e8..da592eeaa0 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -302,16 +302,10 @@ ifeq ($(uname_S),FreeBSD)
>>           ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
>>   		OLD_ICONV = YesPlease
>>           endif
>> -	NO_MEMMEM = YesPlease
> I don't have a FreeBSD machine that old to test it. But Gnulib's
> documentation says it was added in FreeBSD 5.2.1 [1].

Not that it matters for git, but that does not match the actual code.
The first man page I see is for 6 and looking at their source repo I
only see memmem() on the 6 branch.

https://svnweb.freebsd.org/base/stable/5/lib/libc/string/
https://svnweb.freebsd.org/base/stable/6/lib/libc/string/


> Reviewed-by: Collin Funk <collin.funk1@gmail.com>
>
>>   	BASIC_CFLAGS += -I/usr/local/include
>>   	BASIC_LDFLAGS += -L/usr/local/lib
>>   	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
>>   	USE_ST_TIMESPEC = YesPlease
>> -        ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
>> -		PTHREAD_LIBS = -pthread
>> -		NO_UINTMAX_T = YesPlease
>> -		NO_STRTOUMAX = YesPlease
>> -        endif
>>   	PYTHON_PATH = /usr/local/bin/python
>>   	PERL_PATH = /usr/local/bin/perl
>>   	HAVE_PATHS_H = YesPlease
> Curious about this change though. Are you basing it off a FreeBSD system
> you have? Or do we not care about that old version anymore? For
> reference, FreeBSD 4.2 was released in 2000.

I probably should have mentioned it in some manner in the commit message.
Since the minimum version is now 6.x after this changed I removed the 4.x
support. 6.0 is 19.5 years old.

> Collin
>
> [1] https://www.gnu.org/software/gnulib/manual/html_node/memmem.html
> [2] https://www.freebsd.org/releases/4.2R/announce/
>
