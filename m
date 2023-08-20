Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102B7EE4993
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 08:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjHTIgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 04:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjHTIgB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 04:36:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F109D3
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:31:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 972F01AF994;
        Sun, 20 Aug 2023 04:31:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Pe8H0mOPSleo/y3tJOHn5CYDj5OtvF3l54YD/2FX+Hw=; b=S8tS
        kx+BUQnZfUmO80LwXcGop6ywTWuVpk1HGqXQG2U2PeIlTxKs+XBsrVZhbYTv5Q9m
        nls5qFjRJzXDarvaaybp8MMIklb95sb2OEQ6CRa9w4ymKYt75ei3lNP02BI/MRRb
        9L1WGLSWb1sRwNrLSIBUSdYYHFJi/0br0IOhNYk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EAA01AF993;
        Sun, 20 Aug 2023 04:31:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C7F81AF992;
        Sun, 20 Aug 2023 04:31:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] fixing a few function pointer mismatches
References: <20230819235123.GA600613@coredump.intra.peff.net>
Date:   Sun, 20 Aug 2023 01:31:08 -0700
Message-ID: <xmqqwmxqru7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA3A86BA-3F33-11EE-8D22-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I saw that clang-18 hit Debian unstable, so I did my usual "build and
> see if it finds anything new to complain about". Here's the result. :)
>
> Note that that first one is a regression in the upcoming v2.42, though I
> suspect the fallout would not be very widespread (see comments in the
> commit message).

Both changes do look innocuous.  Queued.

Thanks.
