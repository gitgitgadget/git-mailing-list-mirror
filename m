Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B712C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 18:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbhLOSsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 13:48:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56073 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343974AbhLOSrz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 13:47:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2008310C358;
        Wed, 15 Dec 2021 13:47:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+XpTREI63UbXnR8bo0e7mCseEif3s0tIZ89zUX
        t2u6I=; b=apxieUGH+xfMXq3HedwygycX/4X8PkMnWgTX4HaG7rx9OU0t10lX/q
        pte7jAikaePtH++jMh+3BWAoYLyiqxc9mKf62qY5vY1YCmwos5MK77Y1RyCAMbYy
        YGnQNV4aQyyPQYHqkioeWkkRvcTgnJLaPduh1TeRZSpIvbZW2kydw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 180A310C357;
        Wed, 15 Dec 2021 13:47:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7763A10C356;
        Wed, 15 Dec 2021 13:47:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: tb/midx-bitmap-corruption-fix
References: <xmqqilvvluoa.fsf@gitster.g> <YbUhp2OnD7gVEGJm@nand.local>
Date:   Wed, 15 Dec 2021 10:47:53 -0800
In-Reply-To: <YbUhp2OnD7gVEGJm@nand.local> (Taylor Blau's message of "Sat, 11
        Dec 2021 17:09:43 -0500")
Message-ID: <xmqqmtl17lie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 835F43B6-5DD7-11EC-8C72-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Dec 10, 2021 at 06:52:37PM -0800, Junio C Hamano wrote:
>> * tb/midx-bitmap-corruption-fix (2021-12-08) 2 commits
>>  - midx.c: make changing the preferred pack safe
>>  - t5326: demonstrate bitmap corruption after permutation
>>
>>  A bug that made multi-pack bitmap and the object order out-of-sync
>>  (hence the .midx data gets corrupted) has been fixed.
>>
>>  Will merge to 'next'?
>>  source: <cover.1638991570.git.me@ttaylorr.com>
>
> Let's wait. The patch does fix the bug, but somewhat accidentally. I
> have a few proposed directions in the discussion beginning at:
>
>   https://lore.kernel.org/git/YbOeEjNic5ETGcdy@nand.local/
>
> but I want to hear from others before deciding on a direction.

Thanks.
