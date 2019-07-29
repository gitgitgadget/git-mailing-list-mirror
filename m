Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A8B1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 21:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbfG2V47 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 17:56:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59342 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387534AbfG2V47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 17:56:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 508C56BF07;
        Mon, 29 Jul 2019 17:56:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qukFK0FNovdAn7P+H4dzxJyjTTo=; b=DoYZGt
        tOyCTO6j6pkVylkKTXBMYMqrDbnOiewLYTgN/zTDwu28VJkqPu25kyPmo17dseJt
        xKczOOPJ0BAjWbE7oU0XnsEtqGhO9ZG9w1fh/VH1arHW4Jw7p4Z97ljt5Ei5tHni
        F9B9HBKs445lQUqMWSuyl7pLMMVjqazTliRU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kH9KcCl8/WLVOyq+UJBz/sD9fr29Ur7i
        gxycdjIi0/cQr8kG5b6BzucUG4p1rDlGRjPrrxPhhXghEFecC+CdLsd3gSAEggY4
        yy+c5pEgS2mDo7gDoRCmPIRT7la5wyw4lJSqs0j36TwVa4WK28Kaz8xXq8HGEUw+
        9jx2tO03omE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 481CF6BF06;
        Mon, 29 Jul 2019 17:56:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D18B6BF05;
        Mon, 29 Jul 2019 17:56:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/23] Reinstate support for Visual Studio
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Jul 2019 14:56:52 -0700
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Mon, 29 Jul 2019 13:08:00 -0700 (PDT)")
Message-ID: <xmqqd0hstsgr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C71697BA-B24B-11E9-97D4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> A long time ago, we added support to build .sln and .vcproj files for use
> within Visual Studio, so that Git could be built in that popular IDE.
> ...
> Changes since v1:
>
>  * The empty directory templates/blt/branches/ is now created as part of the
>    build.

This did not cut today's pushout, but replacing the topic branch and
rebuilding 'pu' was quite straight-forward with just a single liner
change ;-)

It will appear in 'next' sometime tomorrow.

Thanks.
