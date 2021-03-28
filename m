Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC368C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 22:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806306192F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 22:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhC1Wfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 18:35:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64530 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC1WfT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 18:35:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7A63AFE4E;
        Sun, 28 Mar 2021 18:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zrEOqovih3hmAoZUwmLzZlVE5JE=; b=p2NirD
        sFwTrcUWHeSzOBPvyHEYAOn3e/gaaB533nqn31LogY2MrMEsgf6IL80SHr6bZWpa
        csXXfs3rgt9LxJTkdv9qw9zY2NfqK/BvHlE0YSN5sJHtKyzpF1hW9njmx4sCrudp
        QS4DY5U+2Cc60nIdb+SPR4FW0jTiUx06Ka6gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dl1/UJt1GaLqkSuYbZvv18AEGWb5UF+d
        YIL6fxh6BZ6rauvdlBE5ldQgnq6u17t9ReyLkRAiNfv8P4XxMtcdyE0+oB5AF6jk
        DgtLIIEurrnkoelQ5cB5Fv0PH4VXXnuBsZsz8b47yXmqNmosrE+S1uT3SdeZkI0J
        RUdiAIEQ7p4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF39AAFE4D;
        Sun, 28 Mar 2021 18:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C391AFE4C;
        Sun, 28 Mar 2021 18:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis" <geko1702+commits@99rst.org>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4] gitweb: redacted e-mail addresses feature.
References: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
        <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
        <xmqqlfaf6nu9.fsf@gitster.g>
        <6f656f62497fb7c9322432b5eb151b86.squirrel@mail.kodaksys.org>
        <xmqqczvkoxzx.fsf@gitster.g>
        <14ebc48b8b7bee23dbcf19942f1f9029.squirrel@mail.kodaksys.org>
Date:   Sun, 28 Mar 2021 15:35:17 -0700
In-Reply-To: <14ebc48b8b7bee23dbcf19942f1f9029.squirrel@mail.kodaksys.org>
        (Georgios Kontaxis's message of "Sun, 28 Mar 2021 21:43:16 -0000")
Message-ID: <xmqqft0elxei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF751DE6-9015-11EB-9418-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Georgios Kontaxis" <geko1702+commits@99rst.org> writes:

> It's not clear if you think it's overkill because we have to depend on an
> external module or because we don't need accurate parsing.

It is neither; what we need to parse is not exactly 'e-mail
addresses' as known to Mail::Address.

The thing is, unlike send-email that needs to interact with the
real-world MTAs and e-mail addresses, the codepaths we are talking
about are mostly about author/committer ident, where the definition
is quite narrower than the Mail::Address's "has to cover all the
possible ways to spell e-mail addresses under the sun" requirement.

Having said all that ...

> If we prefer accurate parsing but don't like depending on Mail::Address,
> it's easy to write complete expressions ourselves. (In a separate,
> internal, Perl module)

... I do not have strong opinions either way.  I won't have the
final say on the way things are done in Perl and what is done to
Gitweb.

It was just that what I saw earlier with the offsets and manual
parsing instead of s///g operator did not smell not like a Perl
program to me, and the message you are responding to was my reaction
to it.

Thanks.
