Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0028373
	for <git@vger.kernel.org>; Thu,  8 May 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746745469; cv=none; b=pikkcyewUzfLmkZy/xuGc+lbmiSwHEXVzjM8ye6kD85mKG8y3EEVFk04cZyaona8yf6laeElBiB/cQD9vGHiVMTyNheorxUAD1oDXYbOBuByZV1urPilx+v+hzNWyOefpZ39YVapHeQDcwSqo/SRCJe3e/KPHPd36cgVNxS1Jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746745469; c=relaxed/simple;
	bh=iixe2qvSqPx7u7RCv6J+xy5rIHqeqV6EIdNmBo6I55U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRs2Te0EAYG1gthpCascvUYxV19yg/A2XzaNH/rSkwVFODOIG8TcV6N6A3xtiHZEExHSrortUGviD0LSFL+fEuKmTarTqIXXu9OY7odNTWafIvZ7FSg4vrzNPw0K5fxn3AspgaImaZlb6h5RqyHjaoORVGd7E0QZIpIyRV9DaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=LreiVLLq; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="LreiVLLq"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id DAEsu0gX9Crh0DAEuuzu8e; Fri, 09 May 2025 00:01:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746745277; bh=nrDQOV18liLmDsUgyU+RvbHQWtcLpwtqTsmWwI0iBF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LreiVLLqh/x0FIzEma5eLOE38BRfVd5SK5xHnaDElMNPCtw5ebsAFIj2CcSDBoRxd
	 WDr1HphttM9oOENnmqP4McbsZQuZbSofJQpgZ5EqsfUfLAIn2FRB8tnpe2k/h+OyEm
	 o/DUN7vi4ArZQFugwLFMZ6if+eFK2OSiabkDSGmmptvoI/A2gZd4sYe+TKrluquw3d
	 hG+d7TZ3jL6dzsuJaKFlTPkvxZk5Ju+VPYK6wpWNbTGriH7yw3REkj1G99JF+88SXP
	 UShTICQ6kXZGWja0E2FyqoNLJgNMaJoVa9xN5MgGY21VLDfXu9nmdkNMqckqVn3XPu
	 3DMAYjC5jmBRQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frB/Z04f c=1 sm=1 tr=0 ts=681d37bd
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=YfPZEZ28wHLemy_V5IUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <56706ad8-93c6-48cd-ad16-9d8b00a669c9@ramsayjones.plus.com>
Date: Fri, 9 May 2025 00:01:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] configure.ac: upgrade to a compilation check for
 sysinfo
To: Eli Schwartz <eschwartz@gentoo.org>,
 GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-5-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-6-ramsay@ramsayjones.plus.com>
 <9baad29d-a5bf-443d-98a1-36d7020e5835@gentoo.org>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <9baad29d-a5bf-443d-98a1-36d7020e5835@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLZdV5w+Ze53MrMl1pzvjgg1DyBfnhZ0ymkUOg1MeEpCFd38J1rUklGVjqXteM29hAVRxIiy4vT9dEdzdrt8b+TYvXBUf1zcGcJ/7iuHeU3jR0nd96su
 DPJZndpOtu4JgH1IXLzsjVVNiu67wIXGb/zHpPz6xQMMY4BiBuMwo6wQjpylnplkUDGkV7pYnbv9d0M/C0MUSshTYBhPNd+7NyQ=



On 08/05/2025 22:07, Eli Schwartz wrote:
> On 5/8/25 12:44 PM, Ramsay Jones wrote:
[snip]
>> In order to correctly identify the 'sysinfo()' function we require as
>> part of 'git-gc' (used in the 'total_ram() function), we also upgrade
>> to a compilation check, in a similar way to the meson commit. Note that
>> since commit c9a51775a3 ("builtin/gc.c: correct RAM calculation when
>> using sysinfo", 2025-04-17) both the 'totalram' and 'mem_unit' fields
>> of the 'struct sysinfo' are used, so the new check includes both of
>> those fields in the compile check.
> 
> and
> 
>> Note that I cannot test the new autoconf check in patch #5 (I don't have
>> access to a Solaris system). I _think_ it will correctly unset HAVE_SYSINFO
>> on Solaris, but I cannot confirm that. (I can only test on Linux and cygwin).
> 
> 
> Well, I can confirm this results in the detection being correctly
> changed on Solaris 11.3 and stop reporting sysinfo as available during
> ./configure, so this has my ACK on technical grounds.

Thank you very much for testing this patch, much appreciated!

[snip]

> 
> So you are indeed teaching autoconf to check for this function, but
> should we also ask whether it's worth continued maintenance of autoconf?
> It was/is not clear to me who the stakeholders are for the autoconf support.

Hmm, someone posted a list of people using autoconf somewhat recently
to the mailing-list ... I don't have it to hand, but cygwin was one
of the projects using it.

> On the one hand, it exists so maybe it should be fixed when we know it
> has issues.

Yes, exactly.

> On the other hand, it sounds like this patch (and commit 50dec7c566
> "config.mak.uname: add sysinfo() configuration for cygwin") only modify
> autoconf out of a sense of duty, rather than finding autoconf useful.

Hmm, I am not convinced (yet) that meson is all that useful either. ;)
 
> What does it say about the autoconf support if the people finding bugs
> in it don't even use it, but only discovered the bug while working on a
> different build system they do use and depend on (config.mak.uname, or
> meson.build, both count here).

I am trying very hard not to express a view on this debate. :)

[well, except that I find CMake to be absolutely awful!]

Thanks!

ATB,
Ramsay Jones




