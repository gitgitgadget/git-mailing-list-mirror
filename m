Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F41EBA0C
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167651; cv=none; b=LvW18oU1odImqEgLn0yhwNbqqhvJSwZzCwDKnt4e5RkGzEFEyy1JIbNqlF020MK9uA4ih5v+wtWScM9E5kMEK7wuFn5murE7Su9o8aEUkbjKzVZtKAJscREutUcrHwRld4kY+x+u7ubnTNONOWWCmxSwLP1qipvbpjibnftsUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167651; c=relaxed/simple;
	bh=ECiJ9LViaUyRg6/DRexYDnr/N6OyHq2klFolvcljYdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asUW0kA2UfhGNLIWD1hXwZ7tKeF3S4rWtOm5+atrZZHAtywDdgzza1O0mgEalzn5zZJzJfU+U2UJhE/SsIqY9hLEOoHusxmUS+MJze4L1OTLYk9Nmp+77ayItQl/RMnkRccSWE2Ez1iCaSooYhy+nwD8nJhnYHGv9VNJJQHTPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=SpwvGJRt; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="SpwvGJRt"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id lZ31t0KS5bpaNlZ32tepN5; Fri, 21 Feb 2025 19:50:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1740167459; bh=12lW7BkIVG4JdUWBA6QQWnga2kxZ7lB0sD48ozJW1us=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SpwvGJRtXpnWzREsHl67wAsuN7utos+GEhNONHK1zTqlhfU2owchTkyvgwXZTJVh9
	 wL4LGenGH2Kta+2b4k+ataSObcjfiJ4praXDSDypKjQkHMhTG4Q++N8ap6tEZHAc5c
	 wL6jbNIDMepDBaohf8yunOaXt3VRhXWqayj6lvkjjTg7FpsvMiaoOGd9jj4KeaPi28
	 VnwCG1TfA9o9vgSWFs8LwKDRoXlyPLVwJkUuMV1gnl//rwbM0WJT9pBWK818JQljMc
	 beu1lKfB7E/yfZMoIQ2PUYDl3P6TbnVZ7RvdLwGUBjSdFcRCbQY3/L4OCirFt4UQ/+
	 uzvnHAwW3H/MQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67b8d923
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=E_71VtQZ_9eeOmPi4_sA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <8bfd177a-8f31-4331-bb84-b60e3461adb3@ramsayjones.plus.com>
Date: Fri, 21 Feb 2025 19:50:55 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] [PATCH v2 00/10] meson: wire up bits and pieces from
 "contrib/"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
 <390a138a-fc0d-4011-93d6-71efcb19e863@ramsayjones.plus.com>
 <Z7bK8jDhJT4qRxvI@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z7bK8jDhJT4qRxvI@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMWtfxAj1RNLYDrCeEiyWELuO4GMMaHSOHgGxuLb9lYAF6+zzhsmQe/FdKH3na1OwN5O/tf+OqPg3aScu2wumsujv0cwhWgoflTZ/2muajcVy8v6rTC8
 P4028LeBxWS23YCL0Wp9HpHVZLFdr7Rgoa7ndfB03OUUmHwmLdXTfOtbsqmTCbX98GvvnEPfK8Y1xFHS+Z+KKKmHhktmWS5xK3g=



On 20/02/2025 06:25, Patrick Steinhardt wrote:
[snip]
> Coverage reports are something that Meson already does natively:
> 
>     meson setup build -Db_coverage=true
>     meson compile -C build
>     meson test -C build
>     ninja -C build coverage-html

I just tried this (I had to install 'gcovr' first) and the results
look pretty good:

  ...

  $ ninja -C build coverage-html
  ninja: Entering directory `build'
  [1/1] Generates HTML coverage report
  Ubuntu LLVM version 18.1.3
    Optimized build.
  (INFO) Reading coverage data...
  (INFO) Writing coverage report...
  lines: 85.2% (144103 out of 169233)
  functions: 93.3% (10404 out of 11151)
  branches: 76.0% (78627 out of 103419)

  Html coverage report can be found at file:///home/ramsay/git/build/meson-logs/coveragereport/index.html
  $ 

:)

[Although I have worked on projects where some of those numbers would have
been considered too low! :( ]


ATB,
Ramsay Jones


