Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4F301717
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750609; cv=none; b=Nq813MTnhaTpl1YkH71l+ZJO4Bx2X3gxUr18raOZAphCPMFzkmwJfMlJ+LPiuOKh3xODBrPjI2GkXe+1LwXZyLys4iFZzhOW1f7fp7h4Olx5TEyb3WGABmipe1dC3Tgzbd0BU7WOu1rQlsMhJNV+62lsBr9IaDSBIt/8+0txLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750609; c=relaxed/simple;
	bh=RySzR4G5tRnIBHn2D/S19f+v9zvsLUVxbj2lQLf/y8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fg+QcDbBVy+Ry0Aig3h84HunJMI3l0NbZh7OfWD7juwZlnfb/7gRfzDH8iuV1h4PEqDku1bw1gNw4TOqac1xP9vvhH0jv4UorHE1rl0Btc4/2yP6DlzuT2aRlcWGxHhpxDTr9nl/Vju88DyvRz/pYbeZUepCiRcdjGqKIfTL8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=m+1UMFkc; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="m+1UMFkc"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id pt4ZvUbUq9Rfhpt4avJD72; Tue, 10 Feb 2026 19:06:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1770750417; bh=XPBPt/oZNhAUtlDSh+5MRD4qVCMnZHUfmY3NN3/iNUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m+1UMFkcqpMTmg6jITfFk1zyDGP01KlaHzW7ZoHPoGpYx2oyOvanpoCeWCtAzmfD2
	 DJfMDfJKByyn1oQOPAMUD9fwP4xO/sWcXaRUHWH1oSiGGXReA88ayN5HjufCg83jEQ
	 vkXXylYb6RbwqaTE+dBrp1a7LNrhhsbNFjNO0gd+d+dNR/au5DNnqqhlBjIYKE4izm
	 KzH71uUmDIEyxxNzLsqIE8ZaCYdAzHe3niVBxIG184PXFcm1uADfnF0fwDzlvT7KyQ
	 yaGAbyBmCOoqQtCZSrUJl8bd4pBrlnNhNyuPiG9KKZTaxZ9mT0slOuu2ANJuW0WWcN
	 /tYn+Zars70HQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=S5R6w5sP c=1 sm=1 tr=0 ts=698b81d1
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=746zZOYYsPCTJzl4cS0A:9 a=QEXdDO2ut3YA:10
 a=P9geR6_CPVCz1rZyWMZD:22
X-AUTH: ramsayjones@:2500
Message-ID: <60d1c37d-518a-47af-a823-6e6c173d84df@ramsayjones.plus.com>
Date: Tue, 10 Feb 2026 19:06:55 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Feb 2026, #03)
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7bsob0wo.fsf@gitster.g> <aYmleK3kGqzLXyJe@pks.im>
 <c29e0c1d-337c-4411-8d52-07c9155e8abe@ramsayjones.plus.com>
 <aYsyBPZfDHMnYy5s@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aYsyBPZfDHMnYy5s@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFA/JKVjzB7NN1y14tYxOONHyOtSDfAz5ENW5lLUfVmHWC2bnDptPrcsDlIwtQoqfEz1I4HghqbJIWL5MF0shC6LsCT0lhnW/M0wP27wfknN5B5mTQGU
 8do+QlbGwK67KkTyy8mJpTUMBTIttYM0eDKKOLMiKR9MTeR/lkAOKGzzvszaQ8cDioAuL2wpcaJwg8cYHXg6KsvWtNI4grscKO8=



On 10/02/2026 1:26 pm, Patrick Steinhardt wrote:
> On Mon, Feb 09, 2026 at 07:41:30PM +0000, Ramsay Jones wrote:
>> On 09/02/2026 9:14 am, Patrick Steinhardt wrote:
>>> On Sat, Feb 07, 2026 at 03:15:51PM -0800, Junio C Hamano wrote:
>> [snip]

>>
>> Note that on cygwin I don't get the warning and the number of build targets
>> is 693, rather than 694 (I don't know if that's relevant). Also the version
>> of meson on linux is 1.3.2, but on cygwin is 1.5.2 (so, I would have thought
>> that the deprecation warning would also appear on cygwin! ;) ).
> 
> If I remember correctly this particular deprecation was rolled back
> eventually. *goes double checking* Yup, it's been deprecated in Meson
> 0.64.0, but that deprecation has been rolled back in 0c802d260 (remove
> deprecation warning for `configure_file` kwarg 'copy', 2024-05-24),
> released as part of Meson 1.5.0.

Ah, OK, that explains it. :)

> So I'm not sure whether this really needs addressing. We _could_ make
> this conditional and use `fs.copyfile()` on Meson newer or equal to
> 0.63.0 and older than 1.5.0. But whether that's worth it... dunno.
> Probably not.

Yep, this is not worth spending any more time on.

>> The make and meson builds appear very similar, although some paths and version
>> numbers differ:
>>
>>   $ diff build/subprojects/git-gui/git-gui git-gui/git-gui
>>   1c1
>>   < #!/usr/bin/sh
>>   ---
>>   > #!/bin/sh
>>   6c6
>>   < 	echo 'git-gui version 0.21.GITGUI'; \
>>   ---
>>   > 	echo 'git-gui version 0.21.0.257.g1a729'; \
>>   10c10
>>   <  exec '/usr/bin/wish' "$argv0" -- "$@"
>>   ---
>>   >  exec 'wish' "$argv0" -- "$@"
>>   12c12
>>   < set appvers {0.21.GITGUI}
>>   ---
>>   > set appvers {0.21.0.257.g1a729}
>>   378c378
>>   < set _shellpath {/usr/bin/sh}
>>   ---
>>   > set _shellpath {/bin/sh}
>>   $ 
> 
> I guess the /bin/sh thing is something I'll want to address so that we
> prefer "/bin/sh" over "/usr/bin/sh". We did the same fix in Git itself
> eventually. The wish shell feels sensible though, I don't think we need
> to fix that part.
> 
> The version thing is actually a bug. The problem is that we have started
> to set GIT_CEILING_DIRECTORIES, but we set it to the directory of
> git-gui itself. That of course works as long as git-gui is compiled
> standalone, but doesn't work anymore in case git-gui is embedded as a
> subproject.
> 
> So why does it work for our Makefile? That's because we define the
> SOURCE_DIR as ".", and as a result we define the ceiling directory as
> "./..". And that seems to not restrict our discovery process. I don't
> really know why that is, to be honest.
> 
> I have created [1] to address these issues. Thanks for testing!

OK, thanks for taking the time to look into this (and good to know that
it wasn't a waste of your time!).

Thanks.

ATB,
Ramsay Jones

> [1]: https://github.com/j6t/git-gui/pull/31


