Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39BB91F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 06:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKSGQr (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 01:16:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52617 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKSGQq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 01:16:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1C1F99AF0;
        Tue, 19 Nov 2019 01:16:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UplhBIjKocIWxTZJcGJCDc0uiN0=; b=jcp2Jp
        5c3wmn5DTo/bgq1vr0S6Afae2h+fZYe1wGQi3+LUSdYEyc1uevbwFKb1Xw+RKLIT
        AkUDGrnaqn3XgfSGn3hwNvobD2ONWEFskeqrLZfwy2eFHm5qALBtdxP7ywkgJTC9
        mJvwxOy0UFkw7LkrZy1VS+SPc6AXEWkOR1mB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xQaIpfKbSN7Ya4JyeCOBbdxaWL/c95KW
        g09uNl4yPMVXWYNkbYVxNtBMYooj16/SWQKEEOy071PO6l4J6PqM2nwaMnzHOWX+
        nRmIEpvjLCUOasHhKJQw71QQsj1lJH17uo3rqW9Exs+HLBOpVfiRkrTrqfrVBIul
        prprqwLxFhI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8FD399AEE;
        Tue, 19 Nov 2019 01:16:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 20D7199AED;
        Tue, 19 Nov 2019 01:16:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 5/6] doc: commit: unify <pathspec> description
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <20c4495fd31110c56cca84385bee6d1ab4a6f33e.1573055478.git.gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 15:16:40 +0900
In-Reply-To: <20c4495fd31110c56cca84385bee6d1ab4a6f33e.1573055478.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Wed, 06 Nov 2019
        15:51:17 +0000")
Message-ID: <xmqqk17wxuev.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2773042C-0A94-11EA-9096-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:
> +<pathspec>...::
> +	When pathspec is given on the command line, commit the contents of
> +	the files that match the pathspec without recording the changes
> +	already added to the index. The contents of these files are also
> +	staged for the next commit on top of what have been staged before.
> ++
> +For more details about the <pathspec> syntax, see the 'pathspec' entry
> +in linkgit:gitglossary[7].

What you added in [PATCH 3/6] (git reset doc) sends a slightly
different message, i.e.

    The <pathspec> is used to limit the paths affected by the operation
    (see the entry for 'pathspec' in linkgit:gitglossary[7] for more details).

and I think that was more appropriate than what we see here.  You
are referring your readers to the glossary entry not just for the
syntax but also the entire concept of <pathspec>.

IOW, it would be needed to drop "syntax" from "about the <pathspec>
syntax" from here to match the update to "git reset" documentation.

Thanks.
