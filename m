Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C51C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26EB6128A
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhFIEqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:46:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63710 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhFIEqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:46:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CA79133184;
        Wed,  9 Jun 2021 00:44:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tzw0NWgKkDbo7U2tKfqLJV6vHjdRuHWsT6UmMk
        VEPgg=; b=RE77OtM5LcW7G6RuzTuiohZkl2p6WDe7Iej9wNQ50kCqV7RCRHE0cQ
        rpJPXY2W+kknhaws/bDHqPRX9jcF5O0SjV3Z9DZeFHlbtXVU/8FA58R4MWxUhCwv
        pdL5I1/4KSauf23pcNLPf0KaMIWmAE8svzY6FarqJEy+tC0hLVWuk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 04C44133182;
        Wed,  9 Jun 2021 00:44:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 488D1133181;
        Wed,  9 Jun 2021 00:44:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
        <YL+rXqDMIPvA2a3+@google.com>
Date:   Wed, 09 Jun 2021 13:44:45 +0900
In-Reply-To: <YL+rXqDMIPvA2a3+@google.com> (Emily Shaffer's message of "Tue, 8
        Jun 2021 10:39:42 -0700")
Message-ID: <xmqqa6nzlk8y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AFBE3F4-C8DD-11EB-A4E3-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>> If we refer to a specific person, then using a gendered pronoun is
>> appropriate. Examples within the Git codebase include:
>> 
>> * References to real people (e.g. Linus Torvalds, "the Git maintainer").
>>   Do not misgender real people. If there is any doubt to the gender of a
>>   person, then use singular "they".
>> 
>> * References to fictional people with clear genders (e.g. Alice and
>>   Bob).
>> 
>> * Sample text used in test cases (e.g t3702, t6432).
>> 
>> * The official text of the GPL license contains uses of "he or she", but
>>   modifying the license this way is not within the scope of the Git
>>   project.
>> 
>> Other cases within the Git project were cleaned up by the previous
>> changes.
>> 
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
> Well said.
> Acked-by: Emily Shaffer <emilyshaffer@google.com>
>
>> ---
>>  Documentation/CodingGuidelines | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index e3af089ecf26..78cd399f7cf5 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -648,3 +648,8 @@ Writing Documentation:
>>   inline substituted text+ instead of `monospaced literal text`, and with
>>   the former, the part that should not get substituted must be
>>   quoted/escaped.
>> +
>> + When referring to an anonymous user, use singular "they/them" pronouns
>> + as opposed to choosing between "he/him" and "she/her". Do not use more
>> + complicated constructs such as "he or she" or "s/he". This recommendation
>> + also applies to code comments and commit messages.

I am not sure if this "here is the rule and you will follow it" is
helpful without hinting what the rule is trying to achieve.  It is
more so that the four-bullet-point list in the proposed log message
that says when not to blindly apply the singular they rule will not
be seen by intended readers---we who are reviewing this change in
the patch form may understand and embrace it, but the readers have
less than we have to go with.

Perhaps start the whole paragraph a bit differently, like this?

    Refer to an anonymous user in a gender neutral way.  Use
    singular "they/them" pronouns as opposed to ...

The added single phase will be a sufficient clue to readers that
this is about inclusion, and will tell readers that singular they is
not a hard and fast rule but one of the suggested ways to achieve
that goal.  To be even clearer, we may probably want to add "One way
to do so is to" before the second sentence.
