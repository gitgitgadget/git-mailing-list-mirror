Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BFF1991D4
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959715; cv=none; b=R4ops5s4GdhUGHN21hYK1D5/zE/VW9nhMRnev9nvX6Jych65HFNOoL9fXJlkgPD2hzZR2Vqr68v0Xc8pPbgCiqBWbf6J/1b5/n45KQXU2q4Pv7Fjzd0nKEf++2HQrXK591CKGNPTuz8hWHbTPEIP6vS8yGjuHOg1H1hRomOVNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959715; c=relaxed/simple;
	bh=8gDxH23qSWNJigsk/5cxBpwm1O5acm0TrMnRTdsBFYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMejvispLL3Lck1lXjnnDqf9OI8bD/tfRNI3x262pmJtXP3o94f8/MHqFmejk4OZiTLxGGCzwulRRndUznfx7jQK8WJhIoThGpXqawCUeOdH9rmFm4pxEyRzGgm/clUiHjTWl+T0NIw1yx+t05nOq9oyKi41fYDLGi2UHUACmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=o+2RGlHU; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="o+2RGlHU"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 6brrvhcAyIjCT6brsv9GG8; Wed, 08 Oct 2025 22:38:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759959521; bh=+IkM8Kfc1nuIh/MZRvVI/fltQZZd1miu964GRNmmsnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=o+2RGlHUw+Q0mVnTE1w9qfgi8N99jowCSCbiuKn8gjwGdrmzEN2FuR2352sBD2vwb
	 qhNX0Y5vVumw37PVPLlNAdWpwndEAIO+p703lBOalgfGjxIuQyKmR5s38ARenEVJVc
	 5vZLitVn/vIajhfNMRtKLSmeCI6C93+5Ngua2xjXoEhCm98wNrJO0SPxInlSxFcblN
	 pyZW0LaD04sw+BiupYGgzZCXEPPlU63iMiX9z1NsI4dAamCy4axT33U+xovQSgNO1o
	 fx0E8pzYK2HbBbjbvehVx3M+TPxpuTpYnJcQq1SxcG4/INk+x6KOCwJvfkwD/Pnbsu
	 vDHKiP3xFiOeg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VvaAAP2n c=1 sm=1 tr=0 ts=68e6d9e1
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Skvfn56gvDWmcJKiUd0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <f75779d4-9a92-4681-ae91-83ca7724c655@ramsayjones.plus.com>
Date: Wed, 8 Oct 2025 22:38:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] doc: remembering-renames.adoc: fix asciidoc
 warnings
To: Elijah Newren <newren@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
 <20251002221233.541844-3-ramsay@ramsayjones.plus.com>
 <CABPp-BGiziz6-7zyq+Z-f0g+JDPMpGuXanmXNEM=0hV-7jKNsQ@mail.gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <CABPp-BGiziz6-7zyq+Z-f0g+JDPMpGuXanmXNEM=0hV-7jKNsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMfE1HAZFAnkyEdSUCkKP1pPmkMAknm0OlbL3/Y05d94ms5dAEYsxjGTMRjw+6bUkcDd/gpb5CWkg/iKFRbRFBtKnCGDlfic41UwKZYHDffUWku3vHqe
 A7OvTu3X2sBqxZSzxBD55NTDja6VlFFM/r7+MCJu+/3j6ImZ69csYQCVrxukUe7RTWtFL7CTiM9kgPhC3kSm8uiEd0j7BgFkTOE=



On 08/10/2025 4:51 am, Elijah Newren wrote:
> On Thu, Oct 2, 2025 at 3:13 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>>
>> Both asciidoc and ascidoctor issue warnings about 'list item index:
>> expected n got n-1' for n=1->9 on lines 13, 15, 17, 20, 23, 25, 29,
>> 31 and 33. In asciidoc, numbered lists must start at one, whereas this
>> file has a list starting at zero. Also, asciidoc and asciidoctor warn
>> about 'section title out of sequence: expected level 1, got level 2'
>> on line 38. (asciidoc only complains about the first instance of this,
>> while asciidoctor complains about them all, on lines 94, 141, 142,
>> 184, 185, 257, 288, 289, 290, 397, 424, 485, 486 and 487). These
>> warnings stem from the section titles not being correctly nested within
>> a document/chapter title.
>>
>> In order to address the first set of warnings, simply renumber the list
>> from one to nine, rather than zero to eight. This also requires altering
>> the text which refers to the section numbers, including other section
>> titles.
>>
>> In order to address the second set of warnings, change the section title
>> syntax from '=== title ===' to '== title ==', effectively reducing the
>> nesting level of the title by one. Also, some of the titles are given
>> over multiple lines (they are very long), with an title '===' prefix
>> on each line. This leads to them being treated as separate sections
>> with no body text (as you can see from the line numbers given for the
>> asciidoctor warnings, above). So, for these titles, turn them into a
>> single (long) line of text.
>>
>> In addition to the warnings, address some other formatting issues:
>>
>>   - the ascii branch diagrams didn't format correctly on asciidoctor
>>     so include them in a literal block.
>>   - several blocks of text were intended to be formatted 'as is' but
>>     were not included in a literal block.
>>   - in section 8, format the (A)->(D) in the text description as a
>>     literal with `` marks, since (C) is rendered as a copyright
>>     symbol in html otherwise.
>>   - in section 9, a sub-list of two items is not formatted as such.
>>     change the '*' introducer to '**' to correct the sub-list format.
> 
> Sorry to put you through all this work.  I had no idea the stuff under
> Documentation/technical/ was ever meant to be run through
> asciidoc/asciidoctor.  The .txt ending didn't hint at anything like
> this; I mean, sure lots of other files were put through those, but I
> assumed this directory was just stuff for other Git developers...

As I mentioned in my cover letter, I didn't think these documents were
ever meant to be submitted to asciidoc(tor) either, but had to assume
that the current policy required it; so, I had to show willing ... :)

If it was not already obvious, until this patch series I had managed to
completely avoid any knowledge of 'asciidoc standard markup' (which appears
to be anything but standard)!

>> -=== 0. Assumptions ===
>> +== 1. Assumptions ==
> 
> It doesn't like '===' but is fine with '=='?  I'm a bit surprised.  If
> it was about nesting, wouldn't '==' also complain since there is no
> '=' headers anywhere.
> 

Yep, '=' is a level 0 header, but the asciidoc message said 'expected
level 1, got level 2', so I just dropped it down one level and asciidoc(tor)
was happy!

Thanks.

ATB,
Ramsay Jones


