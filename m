Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF70C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 20:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhLUUvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 15:51:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54936 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLUUvF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 15:51:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E92D3158305;
        Tue, 21 Dec 2021 15:51:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qGz5yvGf8L5DFZl7QwedeexNAscikJrg2YtHPu
        vPuw8=; b=uE5InTs1P6SLD1kwfbCkrGI0PL317QkXWskEW/JvXE0v3FlDu2N39E
        To+iiHtcMuPiDpqhtZd0I6OqT1d+PRJL4VV0xzfDjPgug/S0NZ7NuBldLCTsfxBD
        ECcNv41zeG4D8nhexpAuMj9ME9dxj7S7e9H4dk9xbgWo+kGr8N88c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2D56158304;
        Tue, 21 Dec 2021 15:51:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 52B541582D5;
        Tue, 21 Dec 2021 15:51:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH v3] fast-export: fix surprising behavior with
 --first-parent
References: <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
        <pull.1084.v3.git.1639671789279.gitgitgadget@gmail.com>
        <CABPp-BF7Rg3NH3UBnyzD6c1vuFh+FNrNc8eRvUffqmaLppUPkw@mail.gmail.com>
Date:   Tue, 21 Dec 2021 12:50:59 -0800
In-Reply-To: <CABPp-BF7Rg3NH3UBnyzD6c1vuFh+FNrNc8eRvUffqmaLppUPkw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 21 Dec 2021 10:47:22 -0800")
Message-ID: <xmqq5yrhptqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4C1720E-629F-11EC-878F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>      * Changed commit message to include the detailed description of the
>>        problem area as suggested by Elijah. I went back and forth with my
>>        self about whether the message needs some "lead in", but it ended up
>>        getting long without adding much.
>
> If it feels weird quoting someone else so extensively and just using
> their words for the commit message, we've used a "Commit-message-by:"
> trailer in the past; that could be useful here.

I do not mind tweaking the copy I already have with "Helped-by"
myself, while ...

> This version looks good to me:
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

... adding this one before merging the result to 'next'.

Thanks, both.
