Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EFFC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2E121D90
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ioulUYE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgIPWEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:04:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54299 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIPWEF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:04:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C83AEE6E4B;
        Wed, 16 Sep 2020 17:25:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZQt/vKL18kdokN87gsYUmIGPyEY=; b=ioulUY
        E23rwWj3eArJF5ONYnhUGzuVZJFA5Ve4yZ4aw580Fa+zKUmsGuuibSx0zreZUAra
        Fj1ua2Q9dPe1jJxXeARHLxlXUt/9iP8njf1565DEO7BTfw+EM4pGGrhmFStkwf/U
        dIYmlW6qaIGjwMSvJwZthJNDwmtqv4U91aMfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MPukhR8Svpm5VzTJFwFA9YUl8ttzCmv7
        OzHQk1hsgWEJeY1yf8Err1e874oe+CA2DQLG9bP4PmuX2X3sEIpW4btbsPHFuc1Y
        9L7sjQ1pbbgAyfe+IrhcZgV80J41DBqPrASS67F2Y1Cyg4ddc9/0S4YPzK/jjM3G
        cm3Ss0wJMEc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEB7BE6E4A;
        Wed, 16 Sep 2020 17:25:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4A1FE6E49;
        Wed, 16 Sep 2020 17:25:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] t/test-terminal: avoid non-inclusive language
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <3b4ae48d4a3a7e2d6aae259ead19b6643d2533e8.1600279853.git.gitgitgadget@gmail.com>
        <xmqqft7hwhyd.fsf@gitster.c.googlers.com>
Date:   Wed, 16 Sep 2020 14:25:42 -0700
In-Reply-To: <xmqqft7hwhyd.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 16 Sep 2020 14:05:30 -0700")
Message-ID: <xmqqo8m5v2g9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D87ACE2-F863-11EA-A98C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> In the ongoing effort to make the Git project a more inclusive place,
>> let's try to avoid names like "master" where possible.
>
> The two sides of a PTY are called 'master' and 'slave', and I
> understand there is a push to move away from these words, but
> calling one side with an invented name that is used by nobody else
> in the context of talking about PTY, while keeping the word used to
> call the other side, would lead to confusion.
>
> A better change is to drop "master_" altogether without replacing
> the word with anything, and call them just "input", "output" and
> "error".

If we really want to use a replacement word for 'master' instead of
just dropping, I may be inclined to suggest 'parent', in the hope
that PTY implementors will start following what Python folks are
doing, at which time they will give us a synonym for 'slave' method
called 'child' we can use.

