Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9441F406
	for <e@80x24.org>; Thu,  4 Jan 2018 00:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeADAWm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 19:22:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50486 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751204AbeADAWm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 19:22:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2318D560F;
        Wed,  3 Jan 2018 19:22:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HrOiADFE88je6pDfsLo9vPUpG5Y=; b=Hk/aeh
        Al4F8iTA2Ov8ZI2YcWb/aOfXXZzg5MbVAmheor/S2SNsQ/5gi3wuT6ANVUs7mp1m
        DcMS3J/zgA4UI+vgqiZpB1FD8b73YOlj5W6iCX55ifWZ8eODUsT96qr6RiLCTk/z
        zR/Gnk+2Kn2PlgkYmmh8IFQ0KZXTFAWys1gzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L4kSGOg0xBKdv+ZyrjN13Tq4E1K4WFYQ
        gca9EpXmA1v6driLXUfHwWwOnp4ZMbvZLx6MpSWYjDcJkwNplg3eJCoS4M7rd5Kh
        6EhOuQVJVrfYGRYGp6yOM0r4F8qzys4S1ayAneGzrhnVsAeS1iJ0FJkFDG2OVZMI
        AGBxiKTro3Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA94ED560E;
        Wed,  3 Jan 2018 19:22:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DEC9D560D;
        Wed,  3 Jan 2018 19:22:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Several fixes for the test suite related to spaces in filenames
References: <cover.1514998470.git.johannes.schindelin@gmx.de>
        <20180103190844.GA30781@sigill.intra.peff.net>
Date:   Wed, 03 Jan 2018 16:22:39 -0800
In-Reply-To: <20180103190844.GA30781@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Jan 2018 14:08:45 -0500")
Message-ID: <xmqqr2r6fp68.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 604E4DE4-F0E5-11E7-9BED-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 03, 2018 at 05:54:44PM +0100, Johannes Schindelin wrote:
>
>> The second issue was found long ago, and the patch carried in Git for
>> Windows, although nothing about it is specific to Windows.
>> 
>> The first patch was developed today, when I tried to verify that Git's
>> test suite passes if Git is cloned to a directory called `with spaces/`.
>
> Heh, the whole point of the space in the trash directory was to find
> these issues early, but obviously it is not foolproof. :)

Exactly.

> The patches themselves look good to me from inspection. Thanks.

Yes, these changes look good.  Thanks both.
