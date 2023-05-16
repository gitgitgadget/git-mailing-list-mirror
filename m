Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5196EC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 23:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjEPXSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 19:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjEPXSn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 19:18:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A6183D3
        for <git@vger.kernel.org>; Tue, 16 May 2023 16:18:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0ED719EBBA;
        Tue, 16 May 2023 19:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jA9tLR1C7cmovjbZr3W+z3pBptBl3CfHWvmGgp
        jsdo0=; b=ekzWuNyARdnc4f6zkLb4GzbvD7hPZVZI/9Su1p2OFsBeILTdaW0K+h
        zwCjiWlnasBI7SHXdMevJmuykweqXsMJ5K6T3EwtKgmeNqAvzmkz6Agtgs2fQo0K
        WdMrHbEgwXH3YYZ2p5tTQTd1xSmqz5PEpB84j5hkxcmq53gnWX+mk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9F8919EBB9;
        Tue, 16 May 2023 19:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E95019EBB8;
        Tue, 16 May 2023 19:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/9] docs: interpret-trailers: reword and add examples
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <xmqqv8gxm8uj.fsf@gitster.g> <owlybkijnaug.fsf@fine.c.googlers.com>
Date:   Tue, 16 May 2023 16:18:14 -0700
In-Reply-To: <owlybkijnaug.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Tue, 16 May 2023 15:57:27 -0700")
Message-ID: <xmqqmt23sw5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF580C60-F43F-11ED-AA79-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> FYI: I am currently on vacation (in hindsight I should have mentioned
> this ahead of time) and won't be back until June 5. Still, I am highly
> interested in seeing how my topic branch evolves (along with the
> interactions with 'seen', 'next', etc) so I will at least have a look
> time to time before my official @work return date to see if I can rebase
> this topic on master when it (master) moves.

Thanks.

FYI, we will go into a pre-release feature freeze when no new
"features" or "fixes" will graduate to the 'master' branch, unless
it is a regression fix to the change that happened between 2.40 and
'master'.  As the next release is planned for the beginning of June,
your vacation would coincide well with back-burnering the topic ;-)

Have fun.
