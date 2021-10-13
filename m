Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BA7C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA5C610CC
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhJMWhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:37:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58575 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJMWhu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:37:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B2CED9CD5;
        Wed, 13 Oct 2021 18:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0kBZQysQn9zBvKZ9POvAfoz3TTuHVpMtGwrqr9
        /2ez0=; b=BYFnaslNFDDS9JI/AKMHg58aJR45RdRusl3SUTjjOBRjZ6wEk4UAjh
        o41ZPyTB88y01N7m3xu0L62eYc08PGxP7LBxiVUU0U+2i+thyMDq71S8antuNB/0
        jn/jZIm70nIkySnWjU/T/u2uambvDF5YODK+jJZZ+xuol6Nmighc4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE00ED9CD4;
        Wed, 13 Oct 2021 18:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E9E0D9CCF;
        Wed, 13 Oct 2021 18:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Oct 2021, #03; Mon, 11)
References: <xmqqv9239k15.fsf@gitster.g>
Date:   Wed, 13 Oct 2021 15:35:44 -0700
In-Reply-To: <xmqqv9239k15.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        11 Oct 2021 17:14:14 -0700")
Message-ID: <xmqqwnmgeenz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7D6B0CE-2C75-11EC-9262-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * js/retire-preserve-merges (2021-09-07) 11 commits
>   (merged to 'next' on 2021-09-10 at f645ffd7a3)
>  + sequencer: restrict scope of a formerly public function
>  + rebase: remove a no-longer-used function
>  + rebase: stop mentioning the -p option in comments
>  + rebase: remove obsolete code comment
>  + rebase: drop the internal `rebase--interactive` command
>  + git-svn: drop support for `--preserve-merges`
>  + rebase: drop support for `--preserve-merges`
>  + pull: remove support for `--rebase=preserve`
>  + tests: stop testing `git rebase --preserve-merges`
>  + remote: warn about unhandled branch.<name>.rebase values
>  + t5520: do not use `pull.rebase=preserve`
>
>  The "--preserve-merges" option of "git rebase" has been removed.
>
>  Will cook in 'next'.

I am tempted to merge this down to 'master' soonish, in time for the
next feature release that is planned to happen mid November.

Opinions?
