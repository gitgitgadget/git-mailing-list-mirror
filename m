Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38655C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124DB61207
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbhIPWzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:55:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63559 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241276AbhIPWzD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:55:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3194715A641;
        Thu, 16 Sep 2021 18:53:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GPH0Sw5XkBIAjYDauThiYkcYEKhtCoq0LRadAk
        3DwSs=; b=SYBm7J5i5yxZ3bfj20Pe1gKJje4ZjXmbl5aixrP46gEYBjKY9TQugu
        Dn6tYkxlna4u61lHgsrJfnqrNNKoRsPB43gGu0pfPeVU0zguWRLkAPfOKjFrcelE
        sDOme/yFBNJQD7REe/F7ebjgS1URRU6H4DpTrXDDOb6TwF6caNNrA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A66A15A63F;
        Thu, 16 Sep 2021 18:53:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7227815A63E;
        Thu, 16 Sep 2021 18:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesley@schwengle.net>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH] Document `rebase.forkpoint` in rebase man page
References: <xmqqtuikrzca.fsf@gitster.g>
        <20210916223528.2910292-1-wesley@schwengle.net>
        <20210916223528.2910292-2-wesley@schwengle.net>
        <xmqq4kakrvdc.fsf@gitster.g>
        <287f826e-8fde-2c9a-ba66-a0a96e488b9c@schwengle.net>
Date:   Thu, 16 Sep 2021 15:53:37 -0700
In-Reply-To: <287f826e-8fde-2c9a-ba66-a0a96e488b9c@schwengle.net> (Wesley
        Schwengle's message of "Thu, 16 Sep 2021 18:50:58 -0400")
Message-ID: <xmqqv930qgi6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEE2E4C2-1740-11EC-BE7D-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Schwengle <wesley@schwengle.net> writes:

> I made a booboo. I did not run format-patch with the updated commit
> message and commit. I saw it too late. You should have a new one by

That is OK.  Mistakes happen.

I'll slow down to avoid further confusion from mails crossing, but I
have a feeling that you either forgot to read, or sent an updated
patch before reading, the latter half of the message you are
responding to.

Thanks.
