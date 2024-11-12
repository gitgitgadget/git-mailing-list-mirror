Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E5C20B7FA
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401393; cv=none; b=ZlG5b7h0fn3bTGc5IqXsxcbTeBagpGtcW2IG6m0li1Y7EDmOMZYlGL4TWFTiIDSGq+shhfN1XempIem9Z2WCzszbY1epM/Fn4/2YMJKIP3lFg+HbZ5bvN8jrKyBKPf7aRvmoiCBKBTb5JIO0zojLfqntGVykgGxhfoJGM+QXwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401393; c=relaxed/simple;
	bh=vrfDckJbzd9uu378xAoeFW0Y8bZjwWhlyLydI99AhgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkY9u9ger4EIztwowtCiLN6+4pHZoxufqdN/4qAbjEboXegRg2uM9zQMp9not8Ii5cbfW+k2Xix+npJrpZIanaC3hVghB72h/D4KBqC/yD4iuSFiUSvDKY1b6PpyJdLIo7j4y4IgiamDD/0itECSAbLGEBvuIUYI3wxzDHFq1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=bPOWXgbg; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="bPOWXgbg"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 4AFA74C39F
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 09:40:25 +0100 (CET)
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id D0BB460128;
	Tue, 12 Nov 2024 09:40:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1731400818;
	bh=vrfDckJbzd9uu378xAoeFW0Y8bZjwWhlyLydI99AhgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bPOWXgbgv4eGzvxppvpLNACK8IoNqEZOgm8S3qgO9c25a0NLq0IPJ6/z+76IrsTLv
	 MQGJ5pgIqlzdK/q9KBk/gXlQMeQ1a4Q4OOdIcJTa2qJeGqFoi0QdoUkfhf5T/yYLKy
	 yc5UPdDFBwgWJWvUL+yral0RmCZlr9ZC5a/xr0a5g+HC76qsPGoAKHAUfj7eSgcrLK
	 fNeo0sft2Ib1sXA4Eaiv4znCU2szdDRsoaUiQbAqZIi1+UIrBq64oUZjpTccASXwJm
	 amT34s/IMCMn7QxuKNMTnr99uwazWnUAdWl7vvngjDU+NcpPYizUqivRvr2u09ujV/
	 /eWp5bCZf/2jQ==
Message-ID: <7b42828a-2cbe-47c6-b21e-b8c1e3a2ad01@free.fr>
Date: Tue, 12 Nov 2024 09:40:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] doc: git-diff: apply new documentation guidelines
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
 Patrick Steinhardt <ps@pks.im>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <c104bd50b646646e980905a9294209f381b9e61c.1731343985.git.gitgitgadget@gmail.com>
 <xmqqo72l8egu.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr, en-US
In-Reply-To: <xmqqo72l8egu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/11/2024 à 01:48, Junio C Hamano a écrit :
> "Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> 
> You may already have explained the rules elsewhere, but please
> help me refresh my memory with some explanation.
> 
>> -'git diff' [<options>] [--] [<path>...]::
>> +`git diff [<options>] [--] [<path>...]`::
> 
> Here, we just say `everything in literal, including placeholders`,
> which is very pleasant for us writers.


With the new document processor extension, the back tick quotes have
become smarter and they behave basically like an inline synopsis
section. Here, this means that the line will be formatted roughly as
follows:

`git diff` [_<options>_] [`--`] [_<path>_...]

All the keywords are literal, the placeholders are emphasized, and the
syntactic signs ('[', ']', '...') are left without formatting.

The general rule of thumb for the writer is: if it's a singled
placeholder then quote it with underscores, otherwise use back ticks
elsewhere.

> 
>> --1 --base::
>> --2 --ours::
>> --3 --theirs::
>> +`-1` `--base`::
>> +`-2` `--ours`::
>> +`-3` `--theirs`::
> 
> Why aren't these `-1 --base` and instead mark up individual tokens?
> 

Here, it is quite awkward, because we are mixing alternate spellings of
the same option (`-1` and `--base` have the same meaning) with the fact
that these options are meant to be alternatives. The latter meaning is
not what is usually conveyed in the lists of options, which blurs the
following explanation.

To clarify, from what I understand, it would be better to fully spell
out the way these options are used by using the synopsis syntax:

`(-1|--base) | (-2|--ours) | (-3|--theirs)`::

Is it how it works?

>> -<path>...::
>> -	The <paths> parameters, when given, are used to limit
>> +_<path>_...::
> 
> This has to do the _italics_ for placeholders, unlike the full
> command line examples we saw earlier?
> 
> Where does this difference come from?

Well, according to the rule of thumb above, the whole segment should
have been quoted in back ticks. This is a mistake and must be fixed for
consistency.


