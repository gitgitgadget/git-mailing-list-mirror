Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9711748F
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977616; cv=none; b=QhfRHIk9EZY314lS8EgrpJVLqYdBenFi7aR0aB8LYVE9TnL70zXR6iOOl/K+9gZXec3kQPjrf0+moOVXo5nDlWBU/HX9eIYP/znrukB0TQVi3opIQ6aFCd21AFqzL7ntuJn62rj/ghCTMyHugT2IYK7gRXjA1xkP/B0wekk7GKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977616; c=relaxed/simple;
	bh=VP1Vq5Ev9FlO0mHbroLsvNWaIxxSmjUks/x4vQYKmFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaEjGI1U0NWVOQNCqwtcJ8EdZGpAofoVJb6Vc5+q8WdwcxbC83pJ4tupDpaRbL8ZiBj/T9ZgCDeVqV3/tp9n9iq5Cxaq34SQVVOHhKLEibqZ+TdEVms/4VJJ0zBYET95AajWAcq7fLAs3LuiiGtIsSQ8ihF1KbpnkoTOYChdW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=H4VLUOii; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="H4VLUOii"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id MWvEu4Wy7MhRjMWvFu42xF; Tue, 03 Jun 2025 20:03:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1748977422; bh=GmSHf4Is8Ftep9JLs5fvR2GdAYMOh1Dca8S5ASo+LH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H4VLUOiiIzkoyTEQms7bLBaCvohvP7PM7XNrNCyeT6Q7W3S6ov7B99p0sxljT53ef
	 GDTwpAsrxG0f7NQlQqUGfldbReihGT9ET1ra0HeNMuSos8LaN1kOwX6RJDxGBypiGB
	 TI1t3JjVBKGJJY6dimDSrU08NkOSi9JW59oqadpFqg8BH1vXnWP4X8ecZbGAoIJIjd
	 T3XDFu5xCrBf/R0LGsoeLQ/jn3nb7dZkqcVEeNrfQLVfWdLrna7RsM14XlK9pb/pCI
	 nMNsaRplTlVINSsKYOWwVMrR2/xDq4w69yb/+bd5rsxRdw4CQkSIZfqujO3cgGkju1
	 kVTEp14zwviIw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Xq9ZOkF9 c=1 sm=1 tr=0 ts=683f470e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=RXLLBx8KIxhDRXYulpEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <780f09cb-5399-4256-91ca-d93a553540c0@ramsayjones.plus.com>
Date: Tue, 3 Jun 2025 20:03:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v2.25.0-rc0 test failure on cygwin
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Adam Dinwoodie
 <git@dinwoodie.org>, Patrick Steinhardt <ps@pks.im>
References: <771677b1-2ce5-40ce-a704-752ff57ba0d3@ramsayjones.plus.com>
 <xmqq5xhcpzyp.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq5xhcpzyp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfB3KfRb9ih+2UN7UuN4LKDbowhlo2zDuCfpLt3g72/4iKp1x1mBRn9mAwErtLhl4mnnLd5yODCzsNfqrqzA8uzvWLRylXP3FyFkVB86BheHBd5IoveWE
 /FU5Ouk1JNcpES64gp2cXl75E9OjCYcHSTSvetuu9X6faXxrf5HuuYXDPWQWf5LPQocbYPhT9ai64zB3XKmEgk1HVKU88PmQ2m8=



On 03/06/2025 17:11, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
[snip]
>> A quick squint at the failing tests made it clear that the failure was
>> caused by the cygwin build treating a quoted glob character sequence
>> (e.g. '\*') as a directory separator char followed by a glob character.
> 
> Should we revert ec727e18 (dir.c: literal match with wildcard in
> pathspec should still glob, 2025-05-03) before deciding to how to
> proceed, as we will be deep in prerelease freeze?

Heh, that decision is above my pay grade! :)

BTW, I realized earlier today why we had not seen any CI failures
on windows (yes I'm a bit slow on the uptake!); the test has this
conditional at the top:

  test_have_prereq FUNNYNAMES || {
         skip_all='skipping: needs FUNNYNAMES (non-Windows only)'
         test_done
  }

And FUNNYNAMES (as indicated) is set on MINGW/Gfw, but not cygwin.
(cygwin can cope with many 'funny' filenames, but it can't change
the use of '\' as a win32 directory separator).

> It's not a "fix" for something that is gravely wrong but a glitch
> people have lived with almost forever, so it can be reattempted in
> the next cycle without hurting much.

The POSIX/win32 pathname syntax 'issue' is not going away anytime
soon, so I suspect that just skipping these tests (or the entire
test file ala Gfw) is probably the best it gets. ;)

[see Patrick's commit 5f8af25ff9 (t5500, t5601: skip tests which
exercise paths with '[::1]' on Cygwin, 2024-10-16), which had been
failing from v2.25.0-rc0 (25 Dec 2019) to v2.48.0-rc0 (16 Dec 2024),
which was actually caused by a commit which started allowing a win32
drive 'letter' to be an multi-byte UTF8 Unicode char! :) ]

Thanks.

ATB,
Ramsay Jones


