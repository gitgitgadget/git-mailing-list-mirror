Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2A202976
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758929447; cv=none; b=EVjr6RraNFg0+NhaNro0ZZjJwe0W3IL10Dcv9ZcJuxwLsl7DALLY+k3LfdxtTnfOUzBuh9vh2gg/5u/9Kwdt6xKY1gcgPcRFx5c+bWJXgh+UcHcLNgOrp++SotovNRX9ddUIqofPBld8hcxCZVIFWnLl0f8tnlmcxZCUkCBZJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758929447; c=relaxed/simple;
	bh=/WcGzbrB3yvIzW4oHn6AnEnzSLrLyfk6isxg9+67NXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7bcNP8IMntNVMwx53dcaVnS2pl3imXGIY4BA1HP0VDejgKSGd2qcv2mLP+XHY6+M4wOlO0FBwK6pblNisDluG4CvU3n5sPToYbcJEmmNoy05qdfZIjiv1oKggel8C+ZLV7+TefeI46zWETnbm/mmDYhUPiKJ90Zaq1qTiy/sgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=WwCQPhB+; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="WwCQPhB+"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 2HtXv5CpADzgq2HtYvBsvs; Sat, 27 Sep 2025 00:30:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758929436; bh=aJs1iZ6bQt/pgDNoEQdAu071IkSuLDAR/pHsNLzXI6U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WwCQPhB+u0qxqreXZglWrikSGT4JD4ABDv/lebKeTN1azXfU8Vg9/BAGFXLZ/pqig
	 2qGf78crN8LUAmAmWvwCSwlMoHyyZmsdpmam5PESoUvFHpBz6wZnr0qqJdjLuFv9lX
	 sCA3jzUTjtm0YLlT33kAXo8JBTxsd3YhkH5ISJy11qKqud1nNKy0FeBNjRsbaj/i/x
	 CT7G5Ul9sGYqfYS3dwA9MnqQApNXpBP5ypIn2XD7NW80Iu9rUUrgwe6WPxktuCp1oi
	 QR9wGM6VguEnpqlY46mnL5Pn6giQd7GJQFGGrLjI9/U4E/MmLGYqaJPiLlZx1X5Gwb
	 ZcFqeSq0byGew==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AvdN3/9P c=1 sm=1 tr=0 ts=68d7221c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=wJy7lBdzG0R4f5K9_p8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <3323ebff-f6ac-4065-8507-efd5a9e4a16d@ramsayjones.plus.com>
Date: Sat, 27 Sep 2025 00:30:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] doc: commit-graph.adoc: fix up some formatting
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee <stolee@gmail.com>
References: <875fb7a0-6dd9-412b-a34a-21758c339871@ramsayjones.plus.com>
 <xmqqfrc9citl.fsf@gitster.g>
 <c8e40336-0a16-4da9-b251-d166f80ffeb3@ramsayjones.plus.com>
 <xmqqwm5kap0r.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqwm5kap0r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfK616d15uBXZt1xDKRnC7kpo7QwF5Qm3EZnm/zSj+Utky7tD2BiOhWrcD4lTLgX8lbuxmLCqc8Piu46BwjkfB5z+4exaDZ8vKjdFC9rQfxdBoS/Z2hyi
 vEnwB/flGOMvdupJX5hL/k8qqlUhATp5PpB0cCuWDEsp2HJ13lURJmu57g4+uNPn0Cahr+Jc/jnHgeM6h1WtnqfKw1kmbLsV7LE=



On 26/09/2025 10:21 pm, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> I tried searching the web for the answer, without success, so went with
>> the 'prefix' style used here. However, when I read the above, it made me
>> look at out current docs and gitworkflows.adoc showed me I should have
>> used an '~' character instead.
>>
>> I just tried this and it works great (apart from having to \-quote the
>> '{' and '}' characters in one title), so a revised 'diff' is given below.
> 
> Oy.  It is one of the special things I am unsure about---would a
> character used for such quoting (e.g., backslash in this case) count
> as one display space to count the number of underlying characters?
> 
> That is, which one of these do AsciiDoc and Asciidoctor want?
> 
>     Deleting graph-\{hash\} files
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is what I did and, with asciidoc anyway, looked fine.

>     Deleting graph-\{hash\} files
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I just tried this, and it was fine also! :)

Hmm, let me just try asciidoctor ...

Well, with asciidoctor it requires the underlining to be exactly
the same size as the text (ie the second example above), otherwise
it mangles the heading (well it doesn't seem to recognize it as a
heading at all. It looks like:

Deleting graph-{hash} files ~~~~~~~~~

So, not the first time asciidoc and asciidoctor differ in the rendered
output. (yes, the number of ~ chars is not the same as the input).

So, I need to change the diff to extend the underlining on that
heading, so both asciidoc and asciidoctor both render it correctly.

BTW, the asciidoc version of this document has a date which appears after
the initial heading (but it is the day before the 'last date updated' one
at the end of the document) and I have no idea why it is there!

(To be clear, it does not appear in the asciidoctor rendering!)

ATB,
Ramsay Jones


