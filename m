Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97DC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A528A61179
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbhIHTVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:21:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62113 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhIHTVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46B95E7947;
        Wed,  8 Sep 2021 15:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v4grpblMn34KHEEo/KLwC56YxrG9NZd8iqC9l5
        FW3/o=; b=ttiMzCqdcinpv9BXYa3J6HB0lcuUVgRBvJfyGtEMboGR4dfki6tPdZ
        FFAwraftQrAuUDi6NZAAkDpVeUIhbainUjT8Qdgo6nTax/dWW2ByxQZ/5Y6RCK7O
        RLc2a/HedPVuk2HEWj8iPzBBR5m8ajwhIhDiL4FAzFHJYpgiZ5oDI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D95CE7946;
        Wed,  8 Sep 2021 15:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C526E7945;
        Wed,  8 Sep 2021 15:20:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Azeem Bande-Ali <me@azeemba.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
References: <xmqqsfyf5b74.fsf@gitster.g>
        <CABye917yakh8sfGAmuLRiBXmYwTMo-zxquoAJTmve8cZme+G-w@mail.gmail.com>
Date:   Wed, 08 Sep 2021 12:20:15 -0700
In-Reply-To: <CABye917yakh8sfGAmuLRiBXmYwTMo-zxquoAJTmve8cZme+G-w@mail.gmail.com>
        (Azeem Bande-Ali's message of "Wed, 8 Sep 2021 12:55:20 -0400")
Message-ID: <xmqqczpi3mds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBE84FF6-10D9-11EC-B474-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Azeem Bande-Ali <me@azeemba.com> writes:

> On Wed, Sep 8, 2021 at 11:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * ab/help-autocorrect-prompt (2021-08-14) 1 commit
>>  - help.c: help.autocorrect=prompt waits for user action
>>
>>  The logic for auto-correction of misspelt subcommands learned to go
>>  interactive when the help.autocorrect configuration variable is set
>>  to true.
>>
>>  Will merge to 'next'.
>
> Just a minor issue with the description: help.autocorrect will have to
> be set to "prompt" for this setting to work.

I think this was already pointed out in an earlier edition of the
What's cooking report, but I simply forgot to update it.

Sorry, and thanks.

