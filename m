Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD719D89B
	for <git@vger.kernel.org>; Tue, 13 May 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169907; cv=none; b=SFsAVBKMPTJysnmheGEyCCBeW3gFSKCdVuT2kz942/UdiKFCEpfGfVHnyby1SeevtRRS7e2H9kndoM9Rzx6BveHPjx//qu5uXdxD3KRFJ5MCtiYHIiGdWDrryJdgO5ahcoaqDur+byqJ4cDZw+/tVoJxoCRfjHfqczBSBCJOI00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169907; c=relaxed/simple;
	bh=wQj6Q8sgtDbW6iv5vMKCaykGwDnPqTg5khKfFqnyLBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJYEjUUCzNW41BTpMCFtMMOSFrvzRv4i73HO+4A9PsomLHqVqiChnZLG+WlIOb2Q3DAwNxeF0YjVrA9ylhfftIpibV/nUD5s1Bg7IXAGjZsHiy1DDJj/Qm3np42qXCPVS2fBkZGL4+YE29rvMj1E+oSeJu1/I0C7/kPqRCTTBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=jXbIW67S; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jXbIW67S"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id Eweeumrv3m8YhEwefuZszx; Tue, 13 May 2025 21:55:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747169715; bh=NIZ2LsHV9gmSKOY1w5BdQwMqP5ssuQ7hq0pg9N5X+X4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jXbIW67SxX3aTVPgzWFIxSNc1XqxhNTsW5I96iLu8IKSRnAtZ8bF55BLh/scYK7cr
	 JnKK8ix5gxifjs5rtxV9dJSdEmbRHWKQO+SCWjRkKoDEfj19YaUtgMht6v406p+T/6
	 4l/1Ro3J9EElBjM5qAt6/hUbL75vNTMt9crG0dNdHybi1BkvPUFVssbNtXo6/XA+TI
	 ZmVJfTqjjTFNVU8DrZNE4Ex5InF/h88cLnpMzRT5hBYzoMeTVoAN5YeIh9jfWdigTp
	 lAiVOc38xpMGuRn/hA7yuck+3VSkJ662/oZ6j6v6jVnj7vv4adRZn+8l6J4ff+3yky
	 Pv4roZ7o+lyHg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9Pe0vni c=1 sm=1 tr=0 ts=6823b1b3
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=X32zYYXpJhNIaN4RDpwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <4e55f005-f51f-4c3f-9ba3-8ff415e10b30@ramsayjones.plus.com>
Date: Tue, 13 May 2025 21:55:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] miscellaneous build mods (part 2)
To: Junio C Hamano <gitster@pobox.com>
Cc: 'GIT Mailing-list ' <git@vger.kernel.org>, Patrick Steinhardt
 <ps@pks.im>, Eli Schwartz <eschwartz@gentoo.org>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <xmqqr00sfeuy.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqr00sfeuy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDiEfUSNUhbvZQgSoWEfrAuiZWkAfvIBeiDDn8/JWA28fl/QofNuhnUJ/CaOwbVL3tP01+gE1/jOJakZ7/9D+FtdB8BOb2EARhxLA8Fn3K8Kkgj0pLwL
 QbxdWigST6q6PPVdO1LiZw2R/gCKOhla5CU6m0ynZDxTif2yHP6H4nBPCo+PC51Crd1WFGhCpuGiaQOiBkqGeFPJ8cDDkz3YwNA=



On 13/05/2025 21:13, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Changes in v2:
>>
>> Patch #3 is the only one changed (as a result of Patrick's review [0]):
>>
>>  - add some blank lines to make the option handling blocks
>>    easier to see.
>>  - add a comment to 'gitconfig' and 'gitattributes' options
>>    to indicate the default values.
>>
>> Note: The indicated defaults for the 'gitconfig' and 'gitattributes'
>> are only valid when the 'prefix' option is defaulted (or not /usr).
>> Indicating the 'correct' value when -Dprefix=/usr in the comment
>> would consume too much space. Is this acceptable, or is it too
>> confusing/misleading?
>>
>> Also, thanks to Eli for testing patch #5 on Solaris and confirming
>> that it fixes the regression [1].
> 
> Yeah, thanks, all.
> 
>> A range-diff against v1 is given below.
>> ...
>> 3:  fece809f11 ! 3:  a385bbed83 meson: correct path to system config/attribute files
>>     @@ meson.build: libgit_c_args = [
>> ...
>>         description: 'Environment used when spawning the pager')
>> 4:  d49afaedf3 = 4:  0d00951475 meson.build: correct setting of GIT_EXEC_PATH
>> 5:  69848e557f = 5:  150e4110d2 configure.ac: upgrade to a compilation check for sysinfo
> 
> Hmph, For #5 I am seeing this difference:
> 
>     @@ Commit message
>          Commit 50dec7c566 ("config.mak.uname: add sysinfo() configuration for
>          cygwin", 2025-04-17) added a similar 'sysinfo()' check to the autoconf
>          build. This check looked for the 'sysinfo()' function itself, rather
>     -    than just the header, but it will fail (incorrectly set HAVE_SYSINFO)
>     +    that just the header, but it will fail (incorrectly set HAVE_SYSINFO)
>          for the same reason.
>      
>          In order to correctly identify the 'sysinfo()' function we require as
> 
> The original comes from what was posted in the first iteration, and
> somehow the change is not showing in your range-diff, which is a bit
> disturbing.

Oops! yeah, I noticed the typo late in the last round and changed that
patch text directly. :)

I could have sworn that I made the same change to the commit message
as well, but ...

Sorry about that!

> I think for now I'll just amend the log message of #5 back to what
> was in the previous round locally.

Yes please! Thanks.

ATB,
Ramsay Jones


