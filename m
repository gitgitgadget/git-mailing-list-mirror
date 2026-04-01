Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08813BC69B
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038302; cv=none; b=ZwGLL5IvFFZb0UYK9ur7WDEYYUqlMe5KiYvo9MirUVo0vLn+kxFcrBC3haHIZ9x9tSA+cY1vVPiQAvDfvPy44ymO20dakj9aEYmHqmSG+Ga3FHhoPKrZ79+TbGHVCJq5yvGtuthiVMQ/Yj5nxCC8dzLpLX23CcsWbADsfNaXvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038302; c=relaxed/simple;
	bh=PKwvF8ZnJBJjIZVfHOMstpcauuSo+BmfehlQWEpAM8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvAq2TM4laaCWk16Tp4PB4QGs5sp3CXYlzcys/tLLpY/6K73JKdfHA7ZGu13TmY+Ok1+7UQQfHWDnNPpa+FRIJDidxDR7BqO8EdChfuMWkk2+dN1YSBayoOe3EjiKWUqpqnFwtZ2fqkwBAhuzSBuPNIHT0obzjwFspNrCuckkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Yjvx9Wbf; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Yjvx9Wbf"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 23A1A42997D
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 12:11:35 +0200 (CEST)
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id C5F7F780368;
	Wed,  1 Apr 2026 12:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1775038287;
	bh=PKwvF8ZnJBJjIZVfHOMstpcauuSo+BmfehlQWEpAM8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yjvx9WbfthQoxXk9eFAOM0nk/lwCvO+2nT5vBQo3JufVHGQZVxb9MhGoCaW73eAOa
	 +X0/x7fdBu1IY+l7kO4E4n4guo1aLfQEP5KRi2L9RJ75j0WJ84onJuZIu6BB1y/7aE
	 Iw5t70AKQfaELlo+7wjdh5965Wv9fbONGrz7g4UsXLzz0y28bAJpSlJjRuft/ocMwb
	 v9Gag9oXe+e7L3UAQGUsFd6eA5aKKc3gFg1yNGBPeWsstWMKuQeXofRy4lHL9RoXda
	 43fuHGhYlUhlHXtcm0G0tM3xwy6/eJDssniripA6hMHft5IeoZluH+KNxXLGEHE9MH
	 ITWvLdtu+WFaw==
Message-ID: <025bbab6-0731-4df7-bc1f-a4969cb5ae13@free.fr>
Date: Wed, 1 Apr 2026 12:11:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to
 --batch-command
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Siddharth Asthana <siddharthasthana31@gmail.com>,
 karthik.188@gmail.com, christian.couder@gmail.com, ps@pks.im, toon@iotcl.com
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-2-siddharthasthana31@gmail.com>
 <2060629.PYKUYFuaPT@piment-oiseau> <xmqqjyur28kn.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: es-ES
In-Reply-To: <xmqqjyur28kn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/31/26 19:49, Junio C Hamano wrote:
> Jean-Noël AVILA <jn.avila@free.fr> writes:
> 
>> On Sunday, 29 March 2026 10:28:08 CEST Siddharth Asthana wrote:
>>> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
>>> but this option needs to be set when the process is created. This means
>>> we cannot change this option mid-operation.
>>>
>>> At GitLab, Gitaly caches git-cat-file processes and it would be useful
>>> if --batch-command supported toggling mailmap dynamically with existing
>>> processes.
>>>
>>> Add a `mailmap` subcommand to --batch-command that takes a single
>>> argument: `yes` to enable mailmap and `no` to disable it. When enabled,
>>> mailmap data is loaded from disk on first use and kept in memory so that
>>> toggling back on does not require reloading.
>>>
>>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>>> ---
>>> CI: https://gitlab.com/gitlab-org/git/-/pipelines/2416081861
>>>
>>>  Documentation/git-cat-file.adoc |  7 +++++
>>>  builtin/cat-file.c              | 30 ++++++++++++++++++---
>>>  t/t4203-mailmap.sh              | 48 +++++++++++++++++++++++++++++++++
>>>  3 files changed, 81 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-
>> file.adoc
>>> index c139f55a16..af32e929a8 100644
>>> --- a/Documentation/git-cat-file.adoc
>>> +++ b/Documentation/git-cat-file.adoc
>>> @@ -174,6 +174,13 @@ flush::
>>>  	since the beginning or since the last flush was issued. When `--
>> buffer`
>>>  	is used, no output will come until a `flush` is issued. When `--
>> buffer`
>>>  	is not used, commands are flushed each time without issuing `flush`.
>>> +
>>> +mailmap <yes|no>::
>>
>> `yes` and `no` are keywords, and you want to express an alternative, do it 
>> like this: `mailmap (yes|no)::`.
> 
> Not 
> 
>     `mailmap (yes|no)`::
> 
> IOW, shouldn't the closing quote come before the double-colon?

Oops, you're completely right!


