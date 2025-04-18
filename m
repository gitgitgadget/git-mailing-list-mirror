Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3787545009
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745002334; cv=none; b=qAX6W11hJmQuB6ECCFdm4H1rgTy6t4PQklRGRBKwzXfWoWb5Ob+PZon85ApHoZxhvQOrgFQjuGf+EwhhRlE6qmMNvhvAMIE+8ww5Ayxy36cGmLHRl7+I74IcVuljS65qIsf8XhRb/voi9kzetbCujs7x5khCV1J1NHl9i6ogaLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745002334; c=relaxed/simple;
	bh=cYKZjEO52V2lC76LFtEblrVP5VhxrO6DpCM4BXsC2/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDjhZ+6CebaVbn6pT7WFl8p44E2wCROlDuHf8kSIx3zc19WlDYpXok1yVh9NozQmbaiO6xd8HIMVs0hVD6lJfbZowcOEd7v5aiZA76LXHP0y1JoZYjlN3cgmyTZBQwemxpXiiGPIjhfvPLIMWp2wqDKFrA8Dlxklxks/kPk4SAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=NPy/4BgS; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="NPy/4BgS"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 5qojuPXedjZe55qoku8fHg; Fri, 18 Apr 2025 19:52:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1745002323; bh=IgGMBKegoXC9LyW93iwyl2fSOkk1L89juBHZzvbxBIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NPy/4BgSGo2A+BrHfm5wnNeNnJvicwemjbjITJvZgqZyiwt37dG6E9Z5BIsI0JK8r
	 qnn4X3gqsE+pjxmoEbCmt4lxkEH9PZpg+SfDUlVfBXShdPiWINqpaqVWjC/RlTWm4q
	 mUGq0KX8G0BKf7PKvMObkm4oUrg9HZX1ezUuyyIt/VDdgP3htW/wTxKsZYSIqB3FLq
	 UlPlo9lhzZBYT4iBc5qPi8kUfESMXM7RTzaezq/Y39S7exi1fBiq2RHlMsutdHKfpt
	 rryCYnmAnrdUw64d2QVMmT0yPDheZooucXANvdZRKTcU4mutD2n8w9XiylR+vlyWIN
	 +GsfgabcLSCtg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68029f53
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=otWec7-Cf7HSPfzGVMAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <4b2fdfd0-72da-4c36-8b8a-4ef514873d39@ramsayjones.plus.com>
Date: Fri, 18 Apr 2025 19:52:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t/meson.build: remove deleted performance test script
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
References: <67c50fde-d29c-404b-a296-9f0e482acaf3@ramsayjones.plus.com>
 <xmqqmscdbc6g.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqmscdbc6g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCvwr5Mdoo8svhzW/FACRvbpqfuvDw3GqEA28oIT9x7ZzAbPZu5192SXb3Kef/Uonh/e7L4bQ8Xo41mafCZlR/72tD684tg/17uFCirIjLCdX14lx8ml
 G+YH9C/Y043o1/2sEb0YY3BZoRTdfXdFgowgRU3b16j0dnFReqOY+dI2OoLrAKLTCRoJvRaSEFwnfDAmDIOmaThBlh3Ogz4gUPk=



On 18/04/2025 18:40, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Commit 8b0b5c7046 (p5312: removed duplicate performance test script,
>> 2025-04-17) removed the 't/perf/p5312-pack-bitmaps-revs.sh' script, but
>> forgot to remove it from 't/meson.build', resulting in a broken build.
>>
>> In order to fix the build, remove the script from 't/meson.build'.
> 
> Thanks.
> 
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Taylor, Junio,
>>
>> If you need to re-roll the 'tb/pack-bitmap-lookup-tables' branch, could
>> you please squash this into commit 8b0b5c7046. (the meson build on the
>> current 'seen' branch is broken otherwise).
> 
> Unless the topic by Tayor gets rebased on top of what contains
> ps/meson-build-perf-bench, which is not even in 'next' (hence I
> wouldn't recommend doing such a rebase), this needs to be dealt with
> as an evil-merge semantic conflict fix-up, which I did this morning
> and pushed the result out.

Ah, yes, I just fetched and found your fixup (which you did hours ago!).
Sorry for the noise.

Thanks.

ATB,
Ramsay Jones



