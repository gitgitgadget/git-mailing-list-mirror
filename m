Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45914C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EB76103B
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbhIPWSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:18:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64578 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbhIPWSB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:18:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69A5C150A79;
        Thu, 16 Sep 2021 18:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gmyouv7XGPcJjgOQ6UUk23+le2XuGdB6ZgjNzL
        LMFeg=; b=JIJ/jkrjp3EOzvcEIN9t/DBrIr3FlrsyegKQxdw3W2ZUjy7FBjNZNg
        ng7sEooGHszg/CmXJbCDajOC9exuTl5Ggy0ybQG/J6XOkNXymvbVENECOMQM0RDC
        kOQ7RU2KMh8pTKHeeM+dVvsKmyuRQIsBWUjriAqCSqRczdAOEY6Ak=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6165E150A78;
        Thu, 16 Sep 2021 18:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61C0B150A76;
        Thu, 16 Sep 2021 18:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v2 0/8] repack: introduce `--write-midx`
References: <cover.1631331139.git.me@ttaylorr.com>
        <cover.1631730270.git.me@ttaylorr.com> <xmqqmtodwsnz.fsf@gitster.g>
        <xmqqilz1wsbz.fsf@gitster.g> <YUJjUIEmIFTH0+jq@nand.local>
Date:   Thu, 16 Sep 2021 15:16:35 -0700
In-Reply-To: <YUJjUIEmIFTH0+jq@nand.local> (Taylor Blau's message of "Wed, 15
        Sep 2021 17:19:12 -0400")
Message-ID: <xmqq8rzwrwsc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C26E2B54-173B-11EC-BE95-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I think all of this is non-obvious enough that it warrants being written
> down in a comment. Here's a replacement for that first patch that should
> apply without conflict. But if you'd rather have a reroll or anything
> else, I'm happy to do that, too.

Thanks; will replace.  The comment reads well.

