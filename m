Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAE20296E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960473; cv=none; b=G+6wx0XuyDDh17qjZidp3mymEk4DfcdwF4qDBp1kMi9yvkxuwcnhOL499b0n7RZS8qu9xJ7QbS3dal+y90ykW4SxVf0201Rx+BRSEpwHe8A1/v81YXEv1pE2z53GsI05ry09lusn56Irr5czhbiI/QMaUOGw+oC3RztKyRCHA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960473; c=relaxed/simple;
	bh=mmFFOoetNZrYFekrmeRDn4LqobsCFWALStHFa3u1ZA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7aP8w/APvMEIv0hiTdKmUoK4ooMNz5WgJLWasanHZj03MgSqSQBccSgEvux0KPCQWo9wEGjWCzptwUTwGbZee1KxXbdBgRaOKclgfSrSyyu2cPEPhSdO1Ib4pus8zwZrQaLxFjoiprVBifF2hv5PRUS29udVhq9QdMcFtdtCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=FdIeOmOz; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="FdIeOmOz"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 6c77vhdyxIjCT6c79v9GwO; Wed, 08 Oct 2025 22:54:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759960467; bh=vXUi55Pi8SyycGWS5KBipJHF/eh2/iPLagq3izy31J0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FdIeOmOzul8eRNp7bnIJm0GHdIBXF3LXHVPFLS+Ltax7qJLsF0mW7jg1zK/4zphB3
	 sMKwaLq/nrqeBgyyu/TpBttbW2UQskyovgGeUyUStkg2ASDB1jctbv0ELPn/QO3Wsy
	 2oXgTaTKmIb4unYOgwTYQwZKlCb5gEU3VkbcvovbB0cp6y62tyLkWc9iK5dAx1KdhQ
	 L+12fBCudzxzAgmTe0RK7tkIy6+7pNJmjbknTY0VEKDEmOdplIsKmfWPGb54/Df+KN
	 wBfWxxxfHp3FFn0773hrXYDKtUIh81Qav3AGxVfntvBWLwOIgVgfUHALWXGDu+1eTD
	 3gdj6TPoFE5Yg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VvaAAP2n c=1 sm=1 tr=0 ts=68e6dd93
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=nZHIMToMzsYtcapFUtYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=xCCXb8F32M99e-LmnmA6:22
X-AUTH: ramsayjones@:2500
Message-ID: <05bc7369-af6a-45db-a792-a452d2442dbb@ramsayjones.plus.com>
Date: Wed, 8 Oct 2025 22:54:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] doc: sparse-checkout.adoc: fix asciidoc warnings
To: Elijah Newren <newren@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
 <20251002221233.541844-4-ramsay@ramsayjones.plus.com>
 <CABPp-BEYF6MdcaXU1qAYctRBAt754j7PGkE3Tgjmm03bBkBjNQ@mail.gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <CABPp-BEYF6MdcaXU1qAYctRBAt754j7PGkE3Tgjmm03bBkBjNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDgP9bkHK0nvC4ZIxIE3vxG25EOY92fg29r0vdi3ZO88zBXzZscIUgBOx8yNBOc+h29sJEOT8NJliABO6QElZY0tpfX+oQWntTACYpbkf+BapvOZz+Po
 B/hPfZtCr3kZSbEFPkHoO4ckZabRyIXIg/wvIr5d1e7cYFctjF3fbEHoO4Msd4XAW3F4YQJOm4vJjOKvwRbr08eF+F5YnJ3l9Xo=



On 08/10/2025 4:57 am, Elijah Newren wrote:
> On Thu, Oct 2, 2025 at 3:13 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>>
>> Both asciidoc and asciidoctor issue warnings about 'list item index:
>> expected n got n-1' for n=1->7 on lines 928, 931, 951, 974, 980, 1033
>> and 1049. In asciidoc, numbered lists must start at one, whereas this
>> file has a list starting at zero. Also, asciidoc and asciidoctor warn
>> about 'section title out of sequence: expected level 1, got level 2'
>> on line 17. (asciidoc only complains about the first instance of this,
>> while asciidoctor complains about them all, on lines 95, 258, 303, 316,
>> 545, 612, 752, 824, 895, 923 and 1053). These warnings stem from the
>> section titles not being correctly nested within a document/chapter
>> title.
>>
>> In order to address the first set of warnings, simply renumber the list
>> from one to severn, rather than zero to six. Fortunately, this does not
>> require altering additional text, since the enumeration of 'Known Bugs'
>> is not referred to anywhere else in the document.
>>
>> In order to address the second set of warnings, change the section title
>> syntax from '=== title ===' to '== title ==', effectively reducing the
>> nesting level of the title by one. Also, some apparent (sub-)titles are
>> not marked up with sub-title syntax, so add some '=== ' prefix(s) to the
>> relevant headings.
> 
> Kinda surprising; if it's complaining about lack of title nesting, I'd
> think you'd need a '= title =' somewhere before using '== title =='.
> Maybe jumping skipping one nesting level it's fine with, but skipping
> two is where the problem starts?  No idea.

I have no idea either! see previous email.

> 
>> In addition to the warnings, address some other formatting issues:
>>
>>   - the use of heavily nested unordered lists is not reflected in the
>>     output (making the file totally unreadable) because each level of
>>     nesting requires a different syntax. (i.e. replace '*' with '**'
>>     for the second level, '*' with '***' for the third level, etc.)
>>   - make use of literal blocks and manual indentation to get asciidoc
>>     and asciidoctor to display even remotely similar output.
>>   - make use of labelled lists, in some places, to get a similar looking
>>     output to the input, for both asciidoc and asciidoctor.
>>   - replace the trailing space in: `git grep ${SEARCH_TERM} OLDREV `
>>     otherwise the entire line in which that appears is removed from
>>     the output.
> 
> Again, sorry for putting you through all this; I had assumed
> Documentation/technical/ was stuff meant for other Git developers to
> see and didn't need to be typeset with asciidoc or asciidoctor and had
> never attempted to run the documents I added there under either.
> Someone else renamed them to .adoc...

No problem. I already floated the idea of renaming these files to .txt
and removing them from the meson build (in my cover letter), but I had
to assume that it was now the policy for these docs to be formatted.

I was very conscious of me butchering your documents (and Derrick's) to
make an attempt to fix-up the formatting. It was quite frustrating to
find that asciidoc and asciidoctor don't agree on how that should be
done ... (frequently). :(

[I was hopeful that an asciidoc guru would help me fix the two remaining
problems (that I know about) - fingers crossed!]

> I skimmed through the document, and it all looked like typesetting
> changes which don't impair the readability of the source text, so
> seems fine to me.  (Same with the previous patch)

I hoped that would be the case, but I must say that I think you are
being very generous! ;)

Thanks.

ATB,
Ramsay Jones



