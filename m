Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA4C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095886187E
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhF2BPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:15:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61102 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhF2BPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:15:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2497D394A;
        Mon, 28 Jun 2021 21:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=eYYA/YC66DrSWsWIU5QCtnNLl
        Lg2m2AG6Ub49BG11pM=; b=dDGUrzisE4yPSOZPC3hkxtgQvwCUObJZALd8L8JLg
        a7+Bby47RokCMj6Id+aNHDetCSgApz7PxZM85mh4CKSVkSSimElcroL9ZoaINApi
        xdJ+nDfn2cOFtWrN2yrEghvZ1gChRe50skCsjOOxJ+QLauSLrwIh3oYgB9Q421Fw
        dM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3F45D3947;
        Mon, 28 Jun 2021 21:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42534D3946;
        Mon, 28 Jun 2021 21:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Barret Rhoden <brho@google.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v3 3/3] git-worktree.txt: fix typo in example path
References: <20210619112912.76136-1-rybak.a.v@gmail.com>
        <20210625193851.2233114-1-rybak.a.v@gmail.com>
        <20210625193851.2233114-4-rybak.a.v@gmail.com>
        <YNbQGoMP+wYZS0CA@carlos-mbp.lan>
        <8da4cb97-eb46-1ce5-ee74-fb1286d230aa@gmail.com>
Date:   Mon, 28 Jun 2021 18:12:42 -0700
Message-ID: <xmqq5yxx4gol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B23A9B2-D877-11EB-9586-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> On 26/06/2021 08:58, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>> not sure if this patch really belongs in this specific patchset
>
> Yes, third patch is unrelated to the first two.
>
>>, but it
>> might be worth also fixing the same typo in grep as shown by :
>> --- >8 ---
>> Subject: grep: fix worktree mis spelling
>
> s/mis spelling/misspelling/
>
>> 1d1729caeb (grep: replace grep_read_mutex by internal obj read lock,
>>   2020-01-15) adds it as part of a comment
>> fix it to the right spelling without the extra trailing 'e'.
>> diff --git a/grep.c b/grep.c
>> index 8f91af1cb0..f40c734565 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -1510,7 +1510,7 @@ static int fill_textconv_grep(struct repository =
*r,
>>   	 *
>>   	 * TODO: allowing text conversion to run in parallel with object
>>   	 * reading operations might increase performance in the multithread=
ed
>> -	 * non-worktreee git-grep with --textconv.
>> +	 * non-worktree git-grep with --textconv.
>
> I deliberately skipped this typo, because it is in a TODO comment, whic=
h
> I thought isn't worth fixing. I probably should have mentioned that in
> the patch I've sent.

All sound sensible.  Will queue these three patches as-is.

Thanks.
