Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1604AC54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiISRkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiISRkt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:40:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BD0220FE
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:40:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9630714E925;
        Mon, 19 Sep 2022 13:40:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PY9v7i9nHxuK
        xRu6qYsvg+F4GInMZZgjO9wq1XXGFBM=; b=AqIOH4wCzML6mU+n17kK9OY+L5wX
        LzyjjMuHSnT/U3M1ejizOeWI3j77uMrfmw3Yu352JlNfMDgd8bWPguVc4e3rZkUy
        hPQCwHvRnGJofSJqj0sohEiPypIxUstkpYxDGChN5Geq9GXFs3flGq6nLisI8ynt
        FpQtMH+UZKteedQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BA5414E924;
        Mon, 19 Sep 2022 13:40:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2F2B14E923;
        Mon, 19 Sep 2022 13:40:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Skrab Sah <skrab.sah@gmail.com>, git@vger.kernel.org
Subject: Re: what if i use makeheader tool to generate c header file, it
 would be accepted.
References: <CA+J78MWhp3qmbBhhSoioJP+d5eh-iEd_vHZdTNB69o7EvvXWYQ@mail.gmail.com>
        <220919.86zgev635z.gmgdl@evledraar.gmail.com>
Date:   Mon, 19 Sep 2022 10:40:45 -0700
In-Reply-To: <220919.86zgev635z.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 19 Sep 2022 12:45:06 +0200")
Message-ID: <xmqqbkrbb6ua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31A2F9A0-3842-11ED-9557-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Sep 19 2022, Skrab Sah wrote:
>
> Just sending a $subject is rather light on details, so I'm having to do
> a lot of guessing, but here goes.
> ...
> In case this is a genuine "prep question" that you're asking in
> wonderining if you should even waste time on coming up with a patch to
> do $subject I want to say that:
> ...
> Now, this does *not* mean that we're not interested, but just that we'r=
e
> very big on a "show your work" approach to things.

Perhaps this should be made into a FAQ entry?

In general, we do not give promises or guidance, but something a
contributor finds it rewarding to work on, whether we would leter
accept in the upstream, will spread among users and developers, and
eventually we would come begging to the contributor for upstreaming.

On the other hand, a new thing that the contributor who thought of
does not feel it is worth investing their work in, if only to use
for themselves, is unlikely to be of interest to us.

So saying "if this will be accepted, I'll work on it" is counter
productive, as it is easily (mis)taken as a sign that it is the
latter case.

In other words, make it so good that we would come to you.

Thanks.

