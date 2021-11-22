Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7749AC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbhKVRJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:09:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52935 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbhKVRJD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:09:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 626E110753F;
        Mon, 22 Nov 2021 12:05:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E+P1XiQFF6QrsUpB1PTQVeS+gShtesLkXnBdHJ
        gqZ6E=; b=yf2sKbhqeCCi8Ycwuj+t+Mt32DqL5UVo0+AJ/p8Wf8NmbOqS4WSkgG
        8NFdFp6Nph3/qh3Zdfi+t/9z6tvhjS9fVBlz6r16jPT/eyJHYiS3LN8+FVmPKe6M
        4RIBLopQTRxKcA0WkH7bwpE2yLK3hZ6vFciWkpDbQJVT/cFcZc2lM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5554410753E;
        Mon, 22 Nov 2021 12:05:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6CC010753D;
        Mon, 22 Nov 2021 12:05:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
References: <20211120194048.12125-1-ematsumiya@suse.de>
        <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
        <xmqqfsrplz3z.fsf@gitster.g>
        <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
        <20211122145222.m2zrmtbaeu5kzbtt@cyberdelia>
Date:   Mon, 22 Nov 2021 09:05:54 -0800
In-Reply-To: <20211122145222.m2zrmtbaeu5kzbtt@cyberdelia> (Enzo Matsumiya's
        message of "Mon, 22 Nov 2021 11:52:22 -0300")
Message-ID: <xmqqczmsi0i5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74D17AAE-4BB6-11EC-BAEC-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enzo Matsumiya <ematsumiya@suse.de> writes:

> I'm preparing v3 with the above suggestions in mind.

Thanks for an update, and thanks for working on this one.


