Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46B1AB6C8
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661110; cv=none; b=daZIhkNFEf1jabuP8tXJh2zl+qf543XrK2uOfBMVnsy7RCLWcWK9C1vwLvD3hB6ppUgWoiF6XSGiL/ZPpebCWzuujBDtlexveYWhb6/h9sW9mr/LGS9ML8RRjOAJ8QIajClIqmkyY00pwryfPQ9FJbz1CfEKJ5N+E0znGZ/Imu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661110; c=relaxed/simple;
	bh=gDZCCXFe878LgezxYHv14MUD55hRg9Dj5Rn2xpN1wDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueKBXsKg9nBkxGRNIBJHlXRgU+cCeIaiYDGdLcj2v87Yfi9DUg+/mwpBsk8S9VFfMx4AHvIhkvRLUvIigH1sYl92jNapwmYKqLF0WdvIFkR/9VFhJbAsJyJ4/46eNOQiUkbJUQy0p9a/5EBsNgMKdNLjQPbIWMbe+f6RYE0q908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=LLfkV00o; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="LLfkV00o"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 4Q3DuHwlUjZe54Q3Eu7zY0; Mon, 14 Apr 2025 21:05:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744661105; bh=OStLJbUi+fEX0dDkwZJzjE0HEhydUcrIA12c92ZMEzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LLfkV00ogzjf5nbytfAd0HJXKuhBgaHcRppxeZJV2R5nZZ2ZVVygtd0YVHajlxvEC
	 xQG0RRV0LUQFfuN9xVJoL5anRG3yO78dBlGvJPZh5vQ7OMB+BysTMXU7MX3SBPqGJg
	 8UckXOHb8hwpbZhLnM+ECXnOS7+rr5T+F32268RDC+7ZAGgcsgr/cUcgUJB4licFM4
	 Kef3Dk8Jm2/BKPqxppTvwux3GbGT+3naKebf84/y1i8AWxiEcPC8/B0pdSo6Yx3Qax
	 1BZ63Iqar+/qY+uWog23OsfRof91/4iamZ/4lCHufm30ywVonm9ZZ1l5M5G070TpH1
	 8QXDwJ+bFxbMA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=67fd6a71
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=qGd4HPqhAgffcvnUpIkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <39bd9980-0009-4b2e-a8e8-b07b0013c2ec@ramsayjones.plus.com>
Date: Mon, 14 Apr 2025 21:05:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] Re: [PATCH v2 09/13] config.mak.uname: add
 clock_gettime() to the cygwin build
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Adam Dinwoodie <git@dinwoodie.org>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <3bd6e40cd23b07b86b5db146a00bfa01458f2e04.1743859985.git.ramsay@ramsayjones.plus.com>
 <Z_y_WbTyOXmR7ObU@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z_y_WbTyOXmR7ObU@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFp+oGEqaByL1Il5Rb7EOeRHcyIfNNklilLEA3Q4jP3MAn5hpA3uxh0J3V8pu2zszXMcnFhx7b/LNmS1OKW+LsC4uTMbbkNg+2AXHxgEXe075gtFxctI
 OqCQb/lX5ax3NTeKzmlHAiedQFc1HWwpxJVMZfMJXWoSG6IUx8CxSowWe2NFtk0l5JCGiMwjNSTu5qlK/cc8zm9wgf8tdtVH3Zg=



On 14/04/2025 08:55, Patrick Steinhardt wrote:
> On Sun, Apr 06, 2025 at 08:38:35PM +0100, Ramsay Jones wrote:
>> diff --git a/config.mak.uname b/config.mak.uname
>> index 1b3ba8a341..942550fb9e 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -251,6 +251,8 @@ ifeq ($(uname_O),Cygwin)
>>          endif
>>  	HAVE_DEV_TTY = YesPlease
>>  	HAVE_GETDELIM = YesPlease
>> +	HAVE_CLOCK_GETTIME=YesPlease
>> +	HAVE_CLOCK_MONOTONIC=YesPlease
> 
> Nit: let's also have spaces around the assignment operator.

Ah, yes, I forgot this one. If I need to re-roll, then I can
adjust this.

Thanks.

ATB,
Ramsay Jones

> 
>>  	HAVE_ALLOCA_H = YesPlease
>>  	NEEDS_LIBICONV = YesPlease
>>  	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
> 
> Patrick
> 

