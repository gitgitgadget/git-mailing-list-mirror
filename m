Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D3C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935B76135F
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhESBpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 21:45:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64926 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESBpv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 21:45:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D93D3CA947;
        Tue, 18 May 2021 21:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3VsilZ4piQNySpINY1sdF5nuuDVZY46ey5V/+F
        Wf7bM=; b=QazHvGAyPQ0SJAUn9D0zX5BSv5mre0s6NBa6au7B/sSysFSHugdgON
        /ACYlWsDwOs6kjr7wf/zm2AMlmOHWloHIA/zqlHLxd1vswhL8doOvrtlWMTmdRkw
        dY2vvo2P3snaLH75OIbnUEYyPqJRy65BgKui07Cd+s/EzlnuEEdFA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D03D3CA945;
        Tue, 18 May 2021 21:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52816CA944;
        Tue, 18 May 2021 21:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v5 8/9] dir: update stale description of treat_directory()
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
        <179f992edc9254803252ae10e5d692f3755a40f3.1620840502.git.gitgitgadget@gmail.com>
        <bac325b9-8370-601b-a348-a7270df8b824@gmail.com>
        <xmqqa6ot6t7m.fsf@gitster.g>
        <CABPp-BH1MzWb-Xchm=DiUj+M73W9zzR6RUG91A7WO908MCt=6A@mail.gmail.com>
Date:   Wed, 19 May 2021 10:44:30 +0900
In-Reply-To: <CABPp-BH1MzWb-Xchm=DiUj+M73W9zzR6RUG91A7WO908MCt=6A@mail.gmail.com>
        (Elijah Newren's message of "Mon, 17 May 2021 20:32:09 -0700")
Message-ID: <xmqqtumzzedd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C17EEA96-B843-11EB-9497-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> We could revert the last two patches of the series out of next
> (allowing the first seven with the important fixes to merge down) and
> then I could resubmit just the last two patches.  Or we could just let
> them all merge down as-is.  Preferences?

The former, thanks.
