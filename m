Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47448C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 05:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiHQFiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 01:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiHQFiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 01:38:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC71062AB8
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 22:37:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02E111287BB;
        Wed, 17 Aug 2022 01:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w9Yo6W52eEMORNMKkKV7wMf0oSnJm8g/JQLOQC
        8+k/Q=; b=gwvLowCiJ1zQdOSSSL6/sE3hdFCbOuDDqX9zhlSH6OkFkPSf56t9mM
        5cUSttucM2OHha5+8leTibRPVD+qABAWcRKdrY5AkOnAjmAnA85txR5LuIRXcjLs
        FNHtpqbWV4uyBzBng0PSnMyVJdb7rDYBFOs8JBuYvP1nI92FeC96c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF1D81287B9;
        Wed, 17 Aug 2022 01:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 419261287B8;
        Wed, 17 Aug 2022 01:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Fixups for cw/submodule-merge-messages
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 22:37:56 -0700
In-Reply-To: <pull.1325.git.1660696081.gitgitgadget@gmail.com> (Elijah Newren
        via GitGitGadget's message of "Wed, 17 Aug 2022 00:27:58 +0000")
Message-ID: <xmqqk0771lcb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFA20840-1DEE-11ED-B826-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> (Note that my first patch builds on Junio's patch-on-top, though it kind of
> obviates the need for his patch. Let me know if you want me to rebase
> directly on Calvin's patch and remove the need for your patch, Junio.)

It paid off that I didn't merge the leakfix to 'next' ;-)  Please
just tell me to drop the patch and build on top of what Calvin has
in 'next' directly.

Thanks.
