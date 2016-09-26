Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79E32207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162066AbcIZRhD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:37:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61248 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1161395AbcIZRhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:37:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BA984127F;
        Mon, 26 Sep 2016 13:37:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OGzANnrzqFoxSp19YNkMl3nKS5U=; b=GAfWeP
        iStFOsp3+lZyYtMP3AQ5W2JSOrLgnwScEc3AlYqB1Ex0tIkHb0IUO+zybodKKbVl
        GuKRWFFN5qXHsHGYuGdtcpIhzR9Zu5RgxHw8spzT+A2HSAxqDp7zlHyGh3958+73
        y5gka98DoaiYGveqkefJwlast9c4PZ5oiiHkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ARyY06XBJHDVq9JzBSheWNpBTayNTUir
        R+sq2atLiAtTLgLplfvqPzzmwVCAb9U8uZxqVunnq7Sh42zSOxlz6P0tuY10SAuQ
        Teo8Y4wDT4mgr+rzVJ/TLCApHmxSZ3Nhy3ao5mmtjNhvE2Y+cYaImYm8yuGRTtSf
        NkgF+ww4xmw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71C284127D;
        Mon, 26 Sep 2016 13:37:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C87664127B;
        Mon, 26 Sep 2016 13:37:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 06/10] get_short_sha1: NUL-terminate hex prefix
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
        <20160926120007.eswpfrzs2ed66d2o@sigill.intra.peff.net>
        <xmqq37kmvb6x.fsf@gitster.mtv.corp.google.com>
        <20160926172516.frftagyt6aycp75q@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 10:36:58 -0700
In-Reply-To: <20160926172516.frftagyt6aycp75q@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 26 Sep 2016 13:25:16 -0400")
Message-ID: <xmqqk2dytvet.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4A58E1C-840F-11E6-A61A-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I left the second one in to make the intention more explicit, and so
> readers did not have to worry that the NULs were overwritten in the
> loop. I'd be OK with it either way, though.

Yes, I agree with that it is a good thing to make our intention more
explicit and I am perfectly fine with leaving it as-is.

Thanks.

