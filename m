Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CE1EA87
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757790; cv=none; b=mWbIgoia+cdoBYoOP5qUn/zg4Z7wJBiKsTcIgJBEGo3xBVSuyejEwlAEtXiOkin5TaeMmMOF2nNBH2idH0QAdWGtNEAI7JHgbRJDpPzDhnyzcnzqWkF/eExup3b+D3Cd2FnXACgvu1dq5Zj+e1gJQ25ID0QTnNZK7NjGHs3Jcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757790; c=relaxed/simple;
	bh=97JQqPXbqy9Kl0rA7Xe2cxarJQ5V1UUSTrFqO+suBM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RxZU7aSCyd6bwwwE5m0h0ptzMs/20WzESZNHEFu44dfDqdNt3y5Hy9dRgQmpw1zS2mYp2q1ItttlWOxlPBUuH4bHOoUnKaJStQBNDMD/ClqH33N8DZkjYMS6HUlL8s4HvHPsSSQk+PU+u1+xd53ownaLzRxpsbKNqrwgNNSBBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fMfxvxBG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fMfxvxBG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8656026982;
	Fri,  3 May 2024 13:36:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=97JQqPXbqy9Kl0rA7Xe2cxarJQ5V1UUSTrFqO+
	suBM0=; b=fMfxvxBGDchwPQp0WhTw1WHvd09snFTvXSvIZ1F/6qpwpQfSfYJS9P
	1tJtLittgzI+rd3yT41nyE6xugc5ulESmhJT7s/39EmIfrrcDbXVxQf1hyOLMn0P
	or9xMoJ5rleG8veg9NamjI1DqMPF2M0opkGT4E8DvgvW3kFf70ue0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E46026981;
	Fri,  3 May 2024 13:36:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6F8026980;
	Fri,  3 May 2024 13:36:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: James Liu <james@jamesliu.io>,  git@vger.kernel.org
Subject: Re: [PATCH v4 2/3] doc: add spacing around paginate options
In-Reply-To: <CAOLa=ZTTHhh0xVzhU7WPCOm7oE8s=hQRRLztVR3_=71euRcSLA@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 3 May 2024 07:32:40 -0700")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<20240503071706.78109-3-james@jamesliu.io>
	<CAOLa=ZTTHhh0xVzhU7WPCOm7oE8s=hQRRLztVR3_=71euRcSLA@mail.gmail.com>
Date: Fri, 03 May 2024 10:36:25 -0700
Message-ID: <xmqq5xvu94rq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AB2F1AB6-0973-11EF-B8A6-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> James Liu <james@jamesliu.io> writes:
>
>> Make the documentation page consistent with the usage string printed by
>> git.c
>>
>
> Nit: missing full-stop here.

Yes, but "printed by git.c" is an unsatisfying way to say this.  We
can easily illustrate what the end user does to get it, for example:

    ... usage string given by "git help git".

It also makes it internally consistent with "[-v | --version]" that
exists in the same document, which is even better reason to do this
change.

Thanks, both.

>
>> Signed-off-by: James Liu <james@jamesliu.io>
>> ---
>>  Documentation/git.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index 7fa75350b2..d11d3d0c86 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -11,7 +11,7 @@ SYNOPSIS
>>  [verse]
>>  'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
>>      [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
>> -    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--no-lazy-fetch]
>> +    [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
>>      [--no-optional-locks] [--bare] [--git-dir=<path>] [--work-tree=<path>]
>>      [--namespace=<name>] [--config-env=<name>=<envvar>] <command> [<args>]
>>
>> --
>> 2.44.0
