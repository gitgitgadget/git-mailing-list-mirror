Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651C9C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419D360E09
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhHQQkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 12:40:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57304 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHQQki (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 12:40:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26B5D155E4C;
        Tue, 17 Aug 2021 12:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oZWKrtd6YasNB/Nn7jI6wkB8kQxvCxvQOiHbct
        1kYcA=; b=A9myRD2sklVqt5p8psNZUGi9gwZcY/Q+/b4PoUOWMNVckMTCNg5orO
        JEfHtrDuYWCgRhWwmooKZR0D7ug6dKZEA168BCIJz4kUrTnbYF6iY01XkKHGbo+A
        W0+Z4ZBM7R7ix/DVB7bFM4+WFXYi5WE0ufoN+ypRGFXMYh9jNN1a8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FFDE155E4B;
        Tue, 17 Aug 2021 12:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA01F155E45;
        Tue, 17 Aug 2021 12:40:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Azeem Bande-Ali <me@azeemba.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
References: <xmqqv945ng61.fsf@gitster.g>
        <CABye914RbBQEhSmdT+9oC_AYBpn-sfGySXqhV7uamry1Bs0tpQ@mail.gmail.com>
Date:   Tue, 17 Aug 2021 09:39:59 -0700
In-Reply-To: <CABye914RbBQEhSmdT+9oC_AYBpn-sfGySXqhV7uamry1Bs0tpQ@mail.gmail.com>
        (Azeem Bande-Ali's message of "Mon, 16 Aug 2021 19:43:58 -0400")
Message-ID: <xmqqlf50nhy8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C489ED58-FF79-11EB-B953-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Azeem Bande-Ali <me@azeemba.com> writes:

> On Mon, Aug 16, 2021 at 7:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> * ab/help-autocorrect-prompt (2021-08-14) 1 commit
>>  - help.c: help.autocorrect=prompt waits for user action
>>
>>  The logic for auto-correction of misspelt subcommands learned to go
>>  interactive when the help.autocorrect configuration variable is set
>>  to true.
>
> Just a minor correction, the help.autocorrect configuration variable
> has to be set to "prompt" for this behavior.

Thanks for your sharp eyes---you're absolutely correct.  Will fix.
