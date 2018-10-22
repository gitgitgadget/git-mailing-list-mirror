Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711771F453
	for <e@80x24.org>; Mon, 22 Oct 2018 08:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJVQW0 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 22 Oct 2018 12:22:26 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:55772 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeJVQW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 12:22:26 -0400
Received: from [10.101.245.29] (public-gprs383685.centertel.pl [37.47.130.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 60019335D0E;
        Mon, 22 Oct 2018 08:04:58 +0000 (UTC)
Date:   Mon, 22 Oct 2018 08:04:48 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqin1wyxvz.fsf@gitster-ct.c.googlers.com>
References: <20181020193020.28517-1-mgorny@gentoo.org> <xmqqin1wyxvz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Autocrypt: addr=mgorny@gentoo.org; keydata=
 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
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple signatures on commits
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
Message-ID: <7C705597-7AA9-4C4E-904B-CE8C4F01AD24@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dnia October 20, 2018 11:57:36 PM UTC, Junio C Hamano <gitster@pobox.com> napisał(a):
>Michał Górny <mgorny@gentoo.org> writes:
>
>> GnuPG supports creating signatures consisting of multiple signature
>> packets.  If such a signature is verified, it outputs all the status
>> messages for each signature separately.  However, git currently does
>not
>> account for such scenario and gets terribly confused over getting
>> multiple *SIG statuses.
>>
>> For example, if a malicious party alters a signed commit and appends
>> a new untrusted signature, git is going to ignore the original bad
>> signature and report untrusted commit instead.  However, %GK and %GS
>> format strings may still expand to the data corresponding
>> to the original signature, potentially tricking the scripts into
>> trusting the malicious commit.
>>
>> Given that the use of multiple signatures is quite rare, git does not
>> support creating them without jumping through a few hoops, and
>finally
>> supporting them properly would require extensive API improvement, it
>> seems reasonable to just reject them at the moment.
>>
>> Signed-off-by: Michał Górny <mgorny@gentoo.org>
>> ---
>>  gpg-interface.c          | 90
>+++++++++++++++++++++++++++-------------
>>  t/t7510-signed-commit.sh | 26 ++++++++++++
>>  2 files changed, 87 insertions(+), 29 deletions(-)
>>
>> Changes in v4:
>> * switched to using skip_prefix(),
>> * renamed the variable to seen_exclusive_status,
>> * made the loop terminate early on first duplicate status seen.
>
>Thanks for sticking to the topic and polishing it further.  Looks
>very good.  
>
>Will replace.
>
>> +	int seen_exclusive_status = 0;
>> +
>> +	/* Iterate over all lines */
>> +	for (line = buf; *line; line = strchrnul(line+1, '\n')) {
>> +		while (*line == '\n')
>> +			line++;
>> +		/* Skip lines that don't start with GNUPG status */
>> +		if (!skip_prefix(line, "[GNUPG:] ", &line))
>> +			continue;
>> +
>> +		/* Iterate over all search strings */
>> +		for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>> +			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
>> +				if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE) {
>> +					if (++seen_exclusive_status > 1)
>> +						goto found_duplicate_status;
>
>Very minor point but by not using pre-increment, i.e.
>
>		if (seen_exclusive_status++)
>			goto found_duplicate_status;
>
>you can use the expression as a "have we already seen?" boolean,
>whic may probably be more idiomatic.
>
>The patch is good in the way written as-is, and this is so minor
>that it is not worth rerolling to only update this part.

Please don't merge it yet. I gave it some more thought and I think the loop refactoring may cause TRUST_* to override BADSIG (i.e. upgrade from 'bad' to 'untrusted'). I'm going to verify this when I get home.

>
>Thanks.


--
Best regards, 
Michał Górny
