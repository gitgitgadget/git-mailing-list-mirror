Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E13EC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 22:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiGJW44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJW4y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 18:56:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09217644
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 15:56:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3693C19F5C0;
        Sun, 10 Jul 2022 18:56:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hLOso/HAFTJXm7yrqHl4JCsTeDbd4aStfU4c+P
        utbGY=; b=LBsqsn3ocD7smbrLCOfr7K11r2VeC/DaUi/ox3FB4YCqehrQySpigG
        PoCDB8CEUZZqBgrFG7WIoMxIogBdQLSHUQUvYygQjwLJPdw2HMxgaNtAUEQGMmLl
        rFlpSKrXp3PrNxTHWkK+s5RKzwFBf78Y8gSJrdmSWVM1H3FlHd4DE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F9E619F5BF;
        Sun, 10 Jul 2022 18:56:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D323E19F5BE;
        Sun, 10 Jul 2022 18:56:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2022, #02; Fri, 8)
References: <xmqq4jzquiok.fsf@gitster.g>
Date:   Sun, 10 Jul 2022 15:56:48 -0700
In-Reply-To: <xmqq4jzquiok.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        09 Jul 2022 13:36:59 -0700")
Message-ID: <xmqqk08kpoen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 950EC0FE-00A3-11ED-BA92-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen',
> and aren't considered "accepted" at all.

In this edition of the report, the topics that were kept on hold in
the 'next' branch were by mistake left with the "Will cook in 'next'"
label, but please consider them as "Will merge to 'master'" material.

Namely, the following 6 topics are already marked for 'master' in my
updated copy of the "What's cooking" report and will be merged down
accordingly.

> * cr/setup-bug-typo (2022-06-17) 1 commit
> * jk/optim-promisor-object-enumeration (2022-06-16) 1 commit
> * rs/archive-with-internal-gzip (2022-06-15) 6 commits
> * ds/branch-checked-out (2022-06-21) 7 commits
> * jc/resolve-undo (2022-06-09) 1 commit
> * ac/bitmap-format-doc (2022-06-16) 3 commits

Thanks.
