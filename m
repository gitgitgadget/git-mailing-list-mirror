Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8560EE4993
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 16:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbjHWQUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjHWQUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 12:20:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F6C1B0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 09:20:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 002601A41C;
        Wed, 23 Aug 2023 12:20:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t01yPl4NBd6J0l+9g534lHKms3d/WyfIG9ECuH
        YXYFg=; b=IfU71047BF1tuZLS7tjslJKjWBHn01CNjQMkWxEFfAtnUzUd0rvzT/
        SHGKQx48mpZPn4D3CpkxdjZXs2JxylDFJsjqgl0cioAHUzhvxVtyAKItSRMoUlq7
        QaSWPwjd2WZqhPfiva+e6JuhcX3huQm9JelLug9/wXYhGXFE5a7mM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED9DF1A41B;
        Wed, 23 Aug 2023 12:20:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88C3C1A41A;
        Wed, 23 Aug 2023 12:20:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.43 release date adjustment?
References: <ZOYdG8RtPIgymtBV@nand.local>
Date:   Wed, 23 Aug 2023 09:20:33 -0700
In-Reply-To: <ZOYdG8RtPIgymtBV@nand.local> (Taylor Blau's message of "Wed, 23
        Aug 2023 10:52:11 -0400")
Message-ID: <xmqqpm3dg27i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCD2D8A0-41D0-11EE-A676-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Now that we're on the other side of 2.42, it looks like the tentative
> release date for 2.43 has been scheduled for 2023-11-20.
>
> That week is a US holiday (Thanksgiving, on 2023-11-23). I figure that
> many US-based folks may take a good portion of if not the whole week
> off.

True.

> Should we consider pushing back the release to the week after
> Thanksgiving, say on 2023-11-27? This cycle is already somewhat long so
> we could move the release up to 2023-11-13, but I think it would be
> nice to have folks around in case of any brown paper-bag fixes.

I am not sure how it would help to place the release day immediately
after the off-week everybody has stayed off the keyboard, though.  I
would prefer to see fully working weeks during the pre-release
period so that people can work on last minute regression fixes, so I
hoped it would work much better to release before the holiday week
begins, rather than after it ends.

But of course I am open to inputs.  FYI, I plan to be offline _after_
the Thanksgiving week.

