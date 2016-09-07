Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C3A1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 23:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbcIGXZY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:25:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53171 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750877AbcIGXZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:25:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6C063D288;
        Wed,  7 Sep 2016 19:25:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TA5MYwDOyqTveToAqesndalaEbE=; b=o5Upr4
        z2Y78lnErJEnjAOh/homO1fQh2GcNod0ptcj4wVME9ZaG9E9vYUT8GQABEUT61Z4
        iny4zayhJghid7LIDXfDTRZkNksIP/YWXXgUfb8mW+kl14BXSNa4YZqS+jU6JI8T
        l3cu1fHg4JBqmubIQFJvWyBiJOs04sxrQ+D9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ITi7l9oYUxvJn2zSTT9E3fFwRoOle4up
        zklXnV4yKeVr7RKR3iEgCYWZ4OHjgP1oEJS7tVBorTM76gQPff5kMrvamdcskd1p
        cI9TI/eLc5chs2MOlYaAOVN1aAc1M6rjP2m5PYaJEpBFDUUQ26flHnj7JB2CSlN9
        26/lyAsWhNQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90C0D3D287;
        Wed,  7 Sep 2016 19:25:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE64A3D285;
        Wed,  7 Sep 2016 19:25:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 0/8] Better heuristics make prettier diffs
References: <cover.1473068229.git.mhagger@alum.mit.edu>
Date:   Wed, 07 Sep 2016 16:25:19 -0700
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Mon, 5 Sep 2016 11:44:45 +0200")
Message-ID: <xmqqr38vjns0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58E57510-7552-11E6-A034-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

>   * Add test t4059 as part of this commit, not as part of its
>     successor.

Which needs to be moved to somewhere else, as another topics that
has already been in 'next' uses t4059.

I'd move it temporarily to t4061 with a separate SQUASH??? at the
tip for now, as I am running out of time today.



