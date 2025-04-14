Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CB2DFA22
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661677; cv=none; b=ZHWEaQLAEOthoHLjmlsKl40UcxJ1wJe4PUt2WPb4a1yPhVQK7eOccTdtuSk1nUH8s9FnKITsaI8+LfQSG13Tz5Evdbpls7ZqHPsY1FQ9hz46ZD9gtO4kESLA+DDwNhhNR7Hxx0jOi8B9pc9s8Ty+Ol9/XNz51MtwWykfxJURcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661677; c=relaxed/simple;
	bh=l8MMnA9WwD5GpiXZCjxLf5MecwO4MacejaglyYv1YWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZU1qnuPl0JKnYbxmLdnufXWk6k6+wYrWNB6V/VLr7kehLECJEIdNG0YvLJg+mLukHNBa2t/Da6wlAAmkrl+Fm9b5hHnAbIeAHD1S8sgWo/JN7uUMhqSMCiG17VRlyonoutvyOzMO0XudehEMrTOUSBWlfCoCdQSaYsAQPd+e5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=guOecPU9; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="guOecPU9"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 4QCNuHxhjjZe54QCOu7zbk; Mon, 14 Apr 2025 21:14:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744661672; bh=otIJuxnidylknnvipshSlRB1CzgKXJHlS1cV+53LoOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=guOecPU9A5ID/J3ks4vT3byXqyYWbQ83E+cCB6HDxZGd6wc/83eA4rmz3Lg25s6+H
	 rsSbX0r1tJY5DnC4T/i2SweTr+ayiHGGFJPOFUg45Ewff0wXNPXE7HOsQ+kipJsJg8
	 RG10MShv3GUobfwfMCGZg6sYddwh+evuju+yZMMbpeB/gGUDe+dZQ2d/jr73/sPyAp
	 O//yp92irO6s0mu8UalgwEgu6CdS5TynsOg/ydOtWlH+Nd4/Nlo5XCCv2Vt3tIVUP1
	 bf3CWwlJcv79UQn+d7+rC+J4/P2NhgGAuJpxG7aSEnyjXCNTC68vqt32GgiTecMOM9
	 fxOa5BimfyzNQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=67fd6ca8
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7gKXur2pkUFzAZ19ne4A:9 a=QEXdDO2ut3YA:10
 a=cy9xlXaSOgP9DQWEFk3I:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <5457c43c-3796-4e0b-9f1a-7c88b1d9b184@ramsayjones.plus.com>
Date: Mon, 14 Apr 2025 21:14:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] Re: What's cooking in git.git (Apr 2025, #03; Fri, 11)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqmscml2zq.fsf@gitster.g> <Z_zDposxyFf3xPZD@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z_zDposxyFf3xPZD@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfG6DHE/Sb8dBl7nKiIoNEZyCNSzzEQFIxUvGN3K+fzmGyxLK/hksJiv0M8fQQs1Q8TdQALPobjMMirmVCMqplrIadVM+BrfYadlHRnbYO8PBKvUhQmzR
 NL6kAE8cLpEihtEFHQ8Hw2KZY/VV53vGTEJOu5OTl6/6o1FOtyYVDjcmkZ9M9JZS1OamCYLFr3n/tInZvE5nRkStYmdiut4AwzA=



On 14/04/2025 09:13, Patrick Steinhardt wrote:
> On Fri, Apr 11, 2025 at 03:58:33PM -0700, Junio C Hamano wrote:
>> * ps/object-file-cleanup (2025-04-11) 10 commits
>>  - object-store: merge "object-store-ll.h" and "object-store.h"
>>  - object-store: remove global array of cached objects
>>  - object: split out functions relating to object store subsystem
>>  - object-file: split out functions relating to index subsystem
>>  - object-file: split up concerns of `HASH_*` flags
>>  - object-file: split out functions relating to object store subsystem
>>  - object-file: move `xmmap()` into "wrapper.c"
>>  - object-file: move `git_open_cloexec()` to "compat/open.c"
>>  - object-file: move `safe_create_leading_directories()` into "dir.c"
>>  - Merge branch 'ps/object-wo-the-repository' into ps/object-file-cleanup
>>  (this branch uses ps/object-wo-the-repository.)
>>
>>  Code clean-up.
>>
>>  Will merge to 'next'.
>>  source: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
> 
> Let's wait a bit with this one. There's been a couple more review
> comments that I want to address before this is ready for next.
> 
>> * rj/build-tweaks (2025-04-09) 13 commits
>>  - config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
>>  - config.mak.uname: add arc4random to the cygwin build
>>  - config.mak.uname: add sysinfo() configuration for cygwin
>>  - builtin/gc.c: correct RAM calculation when using sysinfo
>>  - config.mak.uname: add clock_gettime() to the cygwin build
>>  - config.mak.uname: add HAVE_GETDELIM to the cygwin section
>>  - config.mak.uname: only set NO_REGEX on cygwin for v1.7
>>  - config.mak.uname: add a note about NO_STRLCPY for Linux
>>  - Makefile: remove NEEDS_LIBRT build variable
>>  - meson.build: set default help format to html on windows
>>  - meson.build: only set build variables for non-default values
>>  - Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
>>  - meson.build: remove -DCURL_DISABLE_TYPECHECK
>>
>>  Various build tweaks, including CSPRNG selection on some platforms.
>>
>>  Comments?
>>  source: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
> 
> I just reviewed this series. It looks mostly fine to me, but I do have
> one question regarding one of the Meson patches.

Thanks again for the review. Hopefully, I have addressed your comment on
that meson patch (even if I can't provide the fix!).

Thanks!

ATB,
Ramsay Jones


