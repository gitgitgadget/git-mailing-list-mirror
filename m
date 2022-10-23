Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70734C04A95
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 01:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJWBtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 21:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJWBtF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 21:49:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62E6D9E9
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 18:49:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 234511BD831;
        Sat, 22 Oct 2022 21:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S0fGPS8xg+kzHCkJMwKHtsS7F8qGRNvVv5hlVR
        ctmjw=; b=RhJljse0uz5DZDOSVwinTWNrsDk+ykDwKGfXQL5w7CZenIQoY8hKLR
        2FiOlRiqbxW68MldGFhdUikbuj+OOGUZaSLEKkzHZUq+bzfpHcB7rGttXxkBiL3w
        BndCHZYDTHUv0VmIlfS0xr27Hf+8aM+sAc2TInUjodLpIeF923aEM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C1D71BD82E;
        Sat, 22 Oct 2022 21:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 51E331BD82B;
        Sat, 22 Oct 2022 21:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 0/3] Add some Glossary of terms information
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
        <20221022222539.2333-1-philipoakley@iee.email>
Date:   Sat, 22 Oct 2022 18:49:00 -0700
In-Reply-To: <20221022222539.2333-1-philipoakley@iee.email> (Philip Oakley's
        message of "Sat, 22 Oct 2022 23:25:36 +0100")
Message-ID: <xmqqpmejfgxf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE0E43D8-5274-11ED-ABFF-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> was GitGitGadget #1282,
> (in reply to <pull.1282.git.1657385781.gitgitgadget@gmail.com>)
>
> This short series looks to add the basics of the reachability bitmap
> and commit graph phrases to the glossary of terms. While these
> techniques are well known to their developers, for some, they are
> just magic phrases.

They all looked reasonable to me, but as you sensibly Cc'ed folks
who worked on the areas the concepts explained in these patches are
the most relevant, these patches would benefit from their inputs, so
let's hear them first and then advance the patches to 'next'.

Thanks.
