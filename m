Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9422C20437
	for <e@80x24.org>; Thu, 12 Oct 2017 09:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdJLJ6w (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 05:58:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52549 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751186AbdJLJ6v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 05:58:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDD9896802;
        Thu, 12 Oct 2017 05:58:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XwKGx9mNhscOUaAKK2Ct5LCYbU8=; b=jOTiZh
        ChpK0w3HcuyYI6GQ/f2isGYZ8eG7xBeN61IZg5QZNDGt1URcHZvYzD3imi2hlgFv
        KdgWX2rrVmV7REF/ecNFOxJAeBb0wSJQncSXKGVocRsLK5Gfb4DAGSvXJBy2Pkkb
        MfeNXh+5eD/YBekrAa+8cZ8E1UMso40JVQNwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UxmgErURY1683ZzHb/DLvczXj81zzUdj
        ggDDxlAhslA8xbYG331/brND6kUifLjp/sqKmcxhC3xdeBrFYciRuCyxoF9/p0Og
        lbOITZNqljETqCJQHS76Yu2wizKkXSIJ0U3gMvFVFUyWoZFgf1MP5zIlJ/Yso7FJ
        WtkheP5pmPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3A4696801;
        Thu, 12 Oct 2017 05:58:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E11396800;
        Thu, 12 Oct 2017 05:58:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 00/24] object_id part 10
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
        <9e44abcf-abcb-4868-d1cd-2326ea8df3ed@alum.mit.edu>
        <20171012084610.slrweolcgwnfgvu6@genre.crustytoothpaste.net>
Date:   Thu, 12 Oct 2017 18:58:49 +0900
In-Reply-To: <20171012084610.slrweolcgwnfgvu6@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Thu, 12 Oct 2017 08:46:11 +0000")
Message-ID: <xmqqo9pcznza.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F256A5EA-AF33-11E7-94B8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In the course of that, I'll rebase on top of master so that Junio can
> avoid as much conflict resolution as possible.

I actually do not mind either way, but by rebasing on top of a more
recent codebase you can lose a large part of 07/24 IIRC, which would
be a big plus ;-)
