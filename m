Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34028C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 19:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhLWTJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 14:09:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57409 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLWTJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 14:09:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4ACD51095BA;
        Thu, 23 Dec 2021 14:09:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UaefJLp0hRmkoIQ4YYV7eH43wVRZOESOEdOlI9
        lLW9k=; b=dKCf1/lMNmfrjKvowPpvvUrxDXDhQnspWr7U4D18kpQKXElYAwGsu+
        ygCJD0BDcn2hWlQGRWXGLYZ7fN3T2kYWbS5M1cD92AipNnDWRof+x8Fud09WdyBT
        v+pDTaBN36nhFDgCP2zHD7RRO7d7r+Qqh5gsbvjcv6nZ9cKdbkEis=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 412171095B9;
        Thu, 23 Dec 2021 14:09:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A75801095B8;
        Thu, 23 Dec 2021 14:09:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 07/10] sparse-checkout: enable reapply to take
 --[no-]{cone,sparse-index}
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
        <09b13280c2619e9dcbf33422c5dcfba84f0e52be.1639454952.git.gitgitgadget@gmail.com>
        <CANYiYbE+1o-8KxY2UGaCMdZJEPtnbTWgBrcFf7E-_ra76=kWmQ@mail.gmail.com>
        <CABPp-BED-3TzbMwm-XFqB_rVp_yOef+koeXmEbb6gTHd0LjXQQ@mail.gmail.com>
Date:   Thu, 23 Dec 2021 11:09:46 -0800
In-Reply-To: <CABPp-BED-3TzbMwm-XFqB_rVp_yOef+koeXmEbb6gTHd0LjXQQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 23 Dec 2021 09:09:08 -0800")
Message-ID: <xmqq5yrfb0jp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5670C0E-6423-11EC-894E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Dec 22, 2021 at 4:48 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>>
>> On Tue, Dec 14, 2021 at 3:24 PM Elijah Newren via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>> >
> ...
>> >  static char const * const builtin_sparse_checkout_reapply_usage[] = {
>> > -       N_("git sparse-checkout reapply"),
>> > +       N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index] "),
>>
>> Found a trailing space in [1], which came from this commit.
>>
>> [1]: https://github.com/git-l10n/git-po/blob/pot/next/2021-12-22.diff#L19
>
> Sorry about that.  This series has already hit next, so I submitted a
> new patch to correct this
> (https://lore.kernel.org/git/pull.1106.git.1640279223893.gitgitgadget@gmail.com/).

Thanks, both.  Will take a look.
