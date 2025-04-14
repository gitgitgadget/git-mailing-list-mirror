Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F11AB6C8
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661018; cv=none; b=R6iyWr3mEAyT8E0g58B+vCNULnDJe4tGQMVXlHsQdNIBAEPdy/F81oZOW8qlzapaAygoXOdnOMxNRSERtughlJFbNRXkNETAJ5KeOKZljVZfTVxzOoCkSfO2aRmzWKrEy+8eCK2/vnhcsB29DkS8y0aTQ4lGQH6hGkd6malk/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661018; c=relaxed/simple;
	bh=BohZApbN/oE6gZfpojK2PvTp4I4yIJtikKj050oHpq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7dQPvthrs7PRYjL4Sk+tyJYK1OG60LGvCpIXgB6IWEhe92wrpgzRJmijnAyW0HUiDUYPldqhlqbHAotkzDA7Zi0//Nqw4k/0e2XFMSeNgHha6sZPiD9KAhFGuPLxSF3uYFVv7hmYKT4icU1EXkA224uS3ZomyXof9X2C/AojzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=gqVrjvwT; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="gqVrjvwT"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 4Q1iuHwcEjZe54Q1ju7zXn; Mon, 14 Apr 2025 21:03:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744661012; bh=64d9AgbqDjVJaKV47W0TzO2iFc7hDvy/SncL+lJWFfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gqVrjvwTmjLrGyeqd6uMys9+78Wl0f+vEP35mbFmOQqs185fxjNm1Vp6kq1oMxJWG
	 yakGeznfzyPvPRvmB/9MlYahFGafixs7YsvJJdp0RjLt9I06oU6muOfMzHeyBuD7OE
	 MdGLtqCP04lXGhqb3ur31mPoxJhMZuxL/6i7l/no6w6rt7hU6SpXbEpmIoAKUFoO64
	 kY3s7dfJk4/vrz/T+AOukV0ZaDUTOspp9vv/hHfyt/l1+eAxi4ad+vx33o8oHpIf17
	 LeqgadYjKlxIA7HKwnZgNY3Z7CKBCsjwSPX10Spmsm+8dQukNO33qYNS3I2bjPH7/B
	 tgECkwEHCtgFg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=67fd6a14
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=psKHxAMCaqIl7HxH_skA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <db92840f-ed4a-46b7-aba0-b556ed33af6f@ramsayjones.plus.com>
Date: Mon, 14 Apr 2025 21:03:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] Re: [PATCH v2 07/13] config.mak.uname: only set NO_REGEX
 on cygwin for v1.7
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Adam Dinwoodie <git@dinwoodie.org>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <324bb213426ffc9c1f9cd155de309bd0b63cdbc4.1743859985.git.ramsay@ramsayjones.plus.com>
 <Z_y_VeJzT82by8wg@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z_y_VeJzT82by8wg@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH7e2tUFI0OHW7YiZbA0nG2FY/b7upM0+MplkwS167AqFmgHMxlwHiILctxmQa3B1hS0UzXcDmHquAe/iCRqNVeo5HTROjOvw6j9WwO/JFCcn61rmAdP
 6YnzdpQj6zbu9iaC8Cy+AzyTpQCf5UMc7ZZNJgM7mK2bcVQr9r3sLJcZAsV4Qf04H0Y8IMzWSsST8iBmhTFSwENTp0X1I3kCyUs=



On 14/04/2025 08:55, Patrick Steinhardt wrote:
> On Sun, Apr 06, 2025 at 08:38:33PM +0100, Ramsay Jones wrote:
>> Commit 92f63d2b05 ("Cygwin 1.7 needs compat/regex", 2013-07-19) set
>> the NO_REGEX build variable because the platform regex library failed
>> some of the tests (t4018 and t4034), which passed just fine with the
>> compat library.
>>
>> After some time (maybe a year or two), the platform library had been
>> updated (with an import from FreeBSD, I believe) and now passed the full
>> test-suite. This would be about the time of the v1.7 -> v2.0 transition
>> in 2015. I had a patch ready to send, but just didn't get around to
>> submitting it to the list. At some point in the interim, the official
>> cygwin git package used the autoconf build system, which sets the
>> NO_REGEX variable to use the platform regex library functions. The new
>> meson build system does likewise.
>>
>> The cygwin platform regex library, in addition to now passing the tests
>> which formerly failed, now passes an 'test_expect_failure' test in the
>> t7815-grep-binary test file. In particular, test #12 'git grep .fi a'
>> which determines that the regex pattern '.' matches a NUL character.
>> The commit f96e56733a ("grep: use REG_STARTEND for all matching if
>> available", 2010-05-22) added the test in question, but it does not
>> give any indication as to why the test was framed as an expected fail,
>> rather than a 'positive' test that the 'git grep' command fails to
>> match a NUL. Note that the previous test #11 was also originally
>> marked in that commit as a 'test_expect_failure', but was flipped to
>> an 'success' test in commit 7e36de5859 ("t/t7008-grep-binary.sh: un-TODO
>> a test that needs REG_STARTEND", 2010-08-17).
>>
>> In order to produce the same NO_REGEX configuration from autoconf, meson
>> and make, modify config.mak.uname to only set NO_REGEX for cygwin v1.7.
>> In addition, skip test t7815.12 on cygwin, by adding the !CYGWIN pre-
>> requisite to the test header, which (among other things) removes an
>> '...; please update test(s)' comment.
> 
> Out of curiosity, because I really don't know any better: why do we have
> to even care about such oldish Cygwin installations from more than 10
> years ago? Wouldn't people generally update Cygwin every once in a while
> to have recent packages? Or is there a good reason why we should
> continue to support it?

Heh, as I said in response to Junio, I have a patch that removes all
of the config in the conditional, so that we would no longer support
any 'pre-v2.x' versions of cygwin[*]. I think that would be an entirely
reasonable thing to do, particularly as cygwin thinks of itself as
a 'rolling release' type distribution. ;)

However, I don't think it is my place to make that kind of decision
and I was leaving that patch until last. Hopefully, Adam will make
that call. :)

Thanks.

ATB,
Ramsay Jones

[*] Note, even *with* that config in place, I have no idea if pre-v2.x
versions would even compile!



