Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0FBC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 22:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346644AbiFOWl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiFOWl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 18:41:57 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C55622F
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 15:41:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71C9B1B7C0A;
        Wed, 15 Jun 2022 18:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=89CpZxy7NYnPPIxxJfNrHIuUhN1w+aUJ41eGvN
        UUoqE=; b=IRuc12QDV39mvOJMNMBSnn+hr4lySmXMazdEcYxX0SOw+KpWcMCudR
        62UpJjZpvgAFZFNT3HVh5UtRSoixFThDc0hq2WiZFyRK98G9SXZdnwsQudLdIbCx
        4Ac2bv2RkycG1c0Jn+DK/s3N0/+4bEuJTFOdfoVFAgow/eCq67mhY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69B2D1B7C09;
        Wed, 15 Jun 2022 18:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 174DF1B7C03;
        Wed, 15 Jun 2022 18:41:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 0/3] bitmap-format.txt: fix some formatting issues
 and include checksum info
References: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
        <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
        <xmqq8rq4fo6p.fsf@gitster.g> <YqlD2qtwqmIKG9lo@nand.local>
Date:   Wed, 15 Jun 2022 15:41:51 -0700
In-Reply-To: <YqlD2qtwqmIKG9lo@nand.local> (Taylor Blau's message of "Tue, 14
        Jun 2022 22:28:42 -0400")
Message-ID: <xmqqtu8ly2fk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A36A10A-ECFC-11EC-A499-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This version of the series significantly improves the readability of the
> generated HTML, and I only had a minor comment or two.

Yeah, I looked at the output and it is improved so much to the point
that the remaining paragraph or two that are still typeset in the fixed
font incorrectly start to look even irritating ;-)

I've tentatively queued it in my tree.  I doubt that the topic is
ultra-urgent so if the remaining mark-up issues can be fixed before
the topic hits 'next', that would be great.

Thanks, both.
