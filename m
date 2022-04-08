Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19347C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 18:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiDHS26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiDHS25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 14:28:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1112214154
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 11:26:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CB3518C68F;
        Fri,  8 Apr 2022 14:26:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PG3okyeN5d7BUya49vDbb4ln9tv2K55yddo2qw
        3PIv0=; b=mMn5dVfIc4AM44X3qJ9CTb61PoSBAuvQ3yO2x80bNbLRYzjQcfkYyU
        SxV9D3GAKYuH8hEtO7KmqgP7s4uaHNppcZvRzkzLOKWUifrZUgvpqrE4b62r2a8e
        PSm88GQoSCCJzA45x7i5MWufZwgzhBSE3n+BA7lt3K+TEPggCL5Ko=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44EAA18C68E;
        Fri,  8 Apr 2022 14:26:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9C0C918C68D;
        Fri,  8 Apr 2022 14:26:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
        <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
        <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
        <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com>
        <220304.86a6e5g44z.gmgdl@evledraar.gmail.com>
        <1469e420-63e5-e2db-21d5-c70674ab04d5@github.com>
        <ddebc223-1e13-e758-f9b1-d3f23961e459@github.com>
        <1b63a8eb-9a6d-a07e-9070-9cdc0c4d5a1c@github.com>
        <220408.86zgkwaq2i.gmgdl@evledraar.gmail.com>
        <b4f85515-945b-51e1-285f-85345124e9b4@github.com>
Date:   Fri, 08 Apr 2022 11:26:49 -0700
In-Reply-To: <b4f85515-945b-51e1-285f-85345124e9b4@github.com> (Derrick
        Stolee's message of "Fri, 8 Apr 2022 09:13:40 -0400")
Message-ID: <xmqqlewfmnx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7526F6FE-B769-11EC-8A76-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> We could err on the side of not distracting from the list. I tend to
> think the release phase can be a good time to talk about an RFC, since

Yes, I think that it is a good thing to do.  I'd need to be careful
not to miss updates and issues critical to the upcoming release but
a large topic that clearly marks itself as RFC would not get in the
way, I would think.

> Junio can ignore the thread until it is actually ready for full review.

It is true for both during -rc freeze and outside ;-)
