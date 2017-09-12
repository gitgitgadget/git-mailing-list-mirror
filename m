Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1996720286
	for <e@80x24.org>; Tue, 12 Sep 2017 06:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbdILGqY (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 02:46:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65237 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751036AbdILGqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 02:46:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA8F7A7125;
        Tue, 12 Sep 2017 02:46:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uWiynFgGbgB3+rFuoivQJS8ysB0=; b=JsgBBr
        gA3GozKX5l01v9/rvZFSwPoQuX2b76pJYiQk0HZz+RyYDtQvjLoJM/mnST65rC8g
        l/YtEqSktpa8/I5k+OqrwrejrYhVZ2v5gjKuOarqLkl1+HY5zAnhFAdbX0OxbR6N
        gAHSS9VpN8II88aeNiq4tQCiLpZv+3HYTV2Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Px+itVvCozGMGr5oRbAOwvJxKpDD51T3
        FvXzr8cGfKmHjoqWbiPmB+NT4rhvcFn36N5ZY1yskPhQmdFPgj/ZrIXB8MRI85QD
        ayM8v1IIljMOtE9M3+jZF0K/xocPuQv1GVW3o8mZeofOQzLExk6KjRh/GTQ9Zbiu
        N9UX9S3+FeY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3D4BA7124;
        Tue, 12 Sep 2017 02:46:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26DC4A7123;
        Tue, 12 Sep 2017 02:46:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] imap-send: use curl by default
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
        <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
        <20170807200126.fnbz57qd44vj43c6@sigill.intra.peff.net>
Date:   Tue, 12 Sep 2017 15:46:20 +0900
In-Reply-To: <20170807200126.fnbz57qd44vj43c6@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 7 Aug 2017 16:01:26 -0400")
Message-ID: <xmqqy3pk1kjn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16C87D92-9786-11E7-877A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 07, 2017 at 04:04:05PM +0200, Nicolas Morey-Chaisemartin wrote:
>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>
> Thanks for moving forward with this.
>
> Can you please flesh out your commit messages with some of the reasoning
> and related discussion? I know from a nearby thread why we want to flip
> the default, but people reading `git log` much later will not have that
> context.
> ...

I was sweeping my mailbox to collect loose ends that haven't been
tied down, and noticed that this topic does not seem to reach a
conclusion.  Do we want to reboot the effort?  Or should we just
throw it in the #leftoverbits bin for now?

Thanks.

