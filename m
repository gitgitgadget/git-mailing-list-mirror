Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5FAC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 16:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiGMQm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 12:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGMQm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 12:42:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55D2E9EB
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 09:42:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 131FF1446DC;
        Wed, 13 Jul 2022 12:42:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aCALIzSVpIIc9992Mp8TvZ2+s0ef9hERXCwSLw
        44DOE=; b=ObvXzO7Kx8zMDhK/5lL0A/+GnaIeAxRuzx/aMAFVW2JFiPfLRJIsbC
        d7ffrUQLyVn30ekKRTi6DR10zXJEDSGk+7db1GWq2vWNQJCSzSr1lioiYT89BcdQ
        bSdQxtmyGJwPBg6MGCYlQBb6ZlniCzvsXzTREoP0RXe3H8X3aRDBk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A8A81446DB;
        Wed, 13 Jul 2022 12:42:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 657551446DA;
        Wed, 13 Jul 2022 12:42:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: ac/bitmap-lookup-table
References: <xmqqo7xufee7.fsf@gitster.g> <Ys4DjW9JjQFx5Bhb@nand.local>
Date:   Wed, 13 Jul 2022 09:42:55 -0700
In-Reply-To: <Ys4DjW9JjQFx5Bhb@nand.local> (Taylor Blau's message of "Tue, 12
        Jul 2022 19:28:13 -0400")
Message-ID: <xmqqzghdc6b4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8EB7942-02CA-11ED-BDCC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Junio,
>
> On Tue, Jul 12, 2022 at 10:07:44AM -0700, Junio C Hamano wrote:
>> * ac/bitmap-lookup-table (2022-07-06) 6 commits
>>  - p5310-pack-bitmaps.sh: remove pack.writeReverseIndex
>>  - bitmap-lookup-table: add performance tests for lookup table
>>  - pack-bitmap: prepare to read lookup table extension
>>  - pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
>>  - pack-bitmap-write.c: write lookup table extension
>>  - Documentation/technical: describe bitmap lookup table extension
>>
>>  The pack bitmap file gained a bitmap-lookup table to speed up
>>  locating the necessary bitmap for a given commit.
>>
>>  Will merge to 'next'?
>>  source: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
>
> I think that this version is pretty close to being ready, but I haven't
> had a chance to look it over carefully yet since getting back from my
> time off last week.
>
> I should have time to review this in the next day or two, if neither of
> you mind waiting.

Thanks!
