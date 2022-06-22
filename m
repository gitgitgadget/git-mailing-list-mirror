Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF00C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 23:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358749AbiFVXNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 19:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358619AbiFVXNp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 19:13:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA1F419B5
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 16:13:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A76E11D761;
        Wed, 22 Jun 2022 19:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Ri9TKPYVmgJ6U9RfWxQQDFaVsbg6y01mn3HX6S
        8XJHc=; b=rkn4rUvqotpGID3BxGK4UMBGj/Uo0Npy+ie8EQrIQoXA5YvIIdegV3
        3AX1QoshNO26PxjaUyc7QLnJaU5jUfwd463mwSfK/XctVKAL1IKFKYeymiwgfn4h
        aWnCWSTYBr+X7pB5SEU4fnp2+myhyZwzaieIVYjX2uBaUDtlJYp/0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40D2111D760;
        Wed, 22 Jun 2022 19:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 574A911D75D;
        Wed, 22 Jun 2022 19:13:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: en/merge-tree
In-Reply-To: <CABPp-BGGDvZ40TY939fFM0xPZuaogPS+ymfEpc+hv-sJnO8Jcg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 22 Jun 2022 14:16:28 -0700")
References: <xmqq7d584hqb.fsf@gitster.g>
        <CABPp-BGGDvZ40TY939fFM0xPZuaogPS+ymfEpc+hv-sJnO8Jcg@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 22 Jun 2022 16:13:41 -0700
Message-ID: <xmqqk0982swq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F51DA4AA-F280-11EC-A132-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Jun 22, 2022 at 12:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>> [Stalled]
>>
>> * en/merge-tree (2022-02-23) 13 commits
>> ...
> Can you update from "On hold" to "new patchset exists" (new source:
> <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>) and move it out
> from the stalled section?

As I diverted my attention to the topic for that anyway, it will not
stop at "new patchset exists" but actually would have to be replaced
before getting described in a new issue of the "What's cooking"
report.  "Will merge to 'next'?" would be the least the topic would
receive even during the pre-release freeze.

Thanks.


