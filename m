Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15723C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7814613A9
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbhI1XgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:36:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58024 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbhI1XgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:36:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3392BF4087;
        Tue, 28 Sep 2021 19:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wOcsObznpnpi2IPZD8cVg13pGB+x8CJESlKHPz
        yV27s=; b=TPme6vEbF9OLCi8nFDXm+QcZVkkpCkmKvMjfxt1Xh3bOyKQOyH3+gQ
        RKRIgtb4VjUiiK4AFM+cp7pGSVDaAny7JQqhhbGOG//w8gfaweg6FdOmbiccxNPQ
        q4pDWJPNCjtsnv6/rvAGvbITgUX8pllUBih0/UYGGh+FU8CojBCSo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29DCBF4086;
        Tue, 28 Sep 2021 19:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 890DDF4085;
        Tue, 28 Sep 2021 19:34:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
        <87v92lxhh4.fsf@evledraar.gmail.com> <xmqqilykliiz.fsf@gitster.g>
        <20210928210059.vy5isvmcj75vufdu@neerajsi-x1.localdomain>
Date:   Tue, 28 Sep 2021 16:34:40 -0700
In-Reply-To: <20210928210059.vy5isvmcj75vufdu@neerajsi-x1.localdomain> (Neeraj
        Singh's message of "Tue, 28 Sep 2021 14:00:59 -0700")
Message-ID: <xmqq8rzgi8a7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A75EB6D0-20B4-11EC-99F6-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> Both Elijah and I needed the same functionality of having a writable
> ODB in the current process, which wasn't previously provided by tmp-objdir.
>
> I'm making a new patch which is an amalgamation of Elijah's version and mine.
> I'll rebase and resend my patch series with that version and I'll also make
> a modified version of Elijah's branch available on github.

Sounds good.  Thanks.
