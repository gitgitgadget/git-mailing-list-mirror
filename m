Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270F41F4BE
	for <e@80x24.org>; Fri,  4 Oct 2019 05:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfJDFwl (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 01:52:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53591 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfJDFwl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 01:52:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E069A266A0;
        Fri,  4 Oct 2019 01:52:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oGzV00WolDBR/oe/jjkTegSOYHA=; b=Mb6/8e
        vfeeYFjzIT59cAvedAKTG0SfuoZwLmOR5ye2XDwn3rhWgYYyIjKZFNzXPvHcROW9
        05LYCysxtd7Ml3x11Jt7h2449Rlw778ieozpBobjo6F64EwJp5upOv0IMOA/tZUN
        fqlyAGfdjBNxMugYqICbWiS2buMZrdQZDCHGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AD9XAdOyohcGf9ePuQEWzFS+kVoVxMi8
        XJ7Te/jqkFYtqzTz5oJJRKBvQ2sPJRQ6jC4GBWhh4RNjKqGnbI3oXZEM1k7VFMn8
        RXo1f63FmchZjZKWSowIfpiM9nk9oPc2IhPLD3Ffzm+idfjtOzKgM+oienwR+NPO
        fWo4NOpF6+0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8F5B2669F;
        Fri,  4 Oct 2019 01:52:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BE102669E;
        Fri,  4 Oct 2019 01:52:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kunal Tyagi <tyagi.kunal@live.com>
Subject: Re: [PATCH v3 1/1] add -i: Show progress counter in the prompt
References: <pull.349.v2.git.gitgitgadget@gmail.com>
        <pull.349.v3.git.gitgitgadget@gmail.com>
        <b351c74a3fc5787e8a41c12342b592d38ef0dede.1569820977.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Oct 2019 14:52:38 +0900
In-Reply-To: <b351c74a3fc5787e8a41c12342b592d38ef0dede.1569820977.git.gitgitgadget@gmail.com>
        (Kunal Tyagi via GitGitGadget's message of "Sun, 29 Sep 2019 22:22:59
        -0700 (PDT)")
Message-ID: <xmqqzhih6ord.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C753028-E66B-11E9-AA0B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kunal Tyagi <tyagi.kunal@live.com>
>
> Report the current hunk count and total number of hunks for the current
> file in the prompt
> Adjust the expected output in some tests to account for new data on the prompt
>
> Signed-off-by: Kunal Tyagi <tyagi.kunal@live.com>
> ---
>  git-add--interactive.perl  | 2 +-
>  t/t3701-add-interactive.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks; queued.
