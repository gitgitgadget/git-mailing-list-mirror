Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AABC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65AF206DB
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cqUGDnR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgIPVFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 17:05:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55251 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIPVFk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 17:05:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CA8F7F1FB;
        Wed, 16 Sep 2020 17:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/r8hp73iSVdm13GCCTjo8FsOT6k=; b=cqUGDn
        R8zC6VcL9VCH7P30Fc/BUHlgow/D1OftOi/3MTL3ifeVormsV0XuZIiIKZQUinTp
        fPC/134xjPAkoTO7fIZL/0/usWMWY+Knrs0MgdAwO5FMdeGST0ZSf1Y7ocMUq9tx
        a8YsHVyi4O9uPvXpO+BofggyM7wQOavtSJYyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lNycCzTReAg5i9t99uBycTQqofMP6Icr
        N9wXfkzB5kiV2EK6GezDqO7V+Zo5M8xr3c91bajt8cq2srnDNf3ctR99aHmIg6KW
        cCmFFfmGIaZc3NCSxuJK7SBABxfpmIOOH23+RA4KBLQk2juPWSwGm7052Tu8fTxW
        a1EPYgD6oiU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84C1C7F1FA;
        Wed, 16 Sep 2020 17:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BDC47F1F9;
        Wed, 16 Sep 2020 17:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] t/test-terminal: avoid non-inclusive language
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <3b4ae48d4a3a7e2d6aae259ead19b6643d2533e8.1600279853.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 14:05:30 -0700
In-Reply-To: <3b4ae48d4a3a7e2d6aae259ead19b6643d2533e8.1600279853.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 16 Sep 2020
        18:10:50 +0000")
Message-ID: <xmqqft7hwhyd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DB17A40-F860-11EA-9C0D-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the ongoing effort to make the Git project a more inclusive place,
> let's try to avoid names like "master" where possible.

The two sides of a PTY are called 'master' and 'slave', and I
understand there is a push to move away from these words, but
calling one side with an invented name that is used by nobody else
in the context of talking about PTY, while keeping the word used to
call the other side, would lead to confusion.

A better change is to drop "master_" altogether without replacing
the word with anything, and call them just "input", "output" and
"error".  For those who implement the PTY, calling both ends of the
pipe 'master' vs 'slave' may be useful for them, as they are terms
of art they are used to think with.  But as end-users of PTY, the
fact that we are holding the 'master' end, and access to the 'slave'
end is done by asking the 'master' end we hold for the corresponding
'slave', is not that important.  What each of these three PTYs is
used for is much more important.

If $input, $output, and $error are too terse, spell them out as
$term_input, $term_output and $term_error or something like that,
perhaps.

Thanks.
