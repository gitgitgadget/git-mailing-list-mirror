Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5391F461
	for <e@80x24.org>; Tue, 23 Jul 2019 15:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfGWPv1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 11:51:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61355 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbfGWPv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 11:51:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B4B51590C2;
        Tue, 23 Jul 2019 11:51:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6B1V16tN2yk9V+58r2WoU0ad3rs=; b=lg59qN
        M7i+e3Duhjyl3moUJS0Str0vgBiQ5DFM+tMIvPc282rkkZynSygyMrQxJSeMctZK
        FXSLn8Mg1w0Rc599XNKCb+DOZvJxZxl2vaL1cgxYj/vQ3XGRCNGoK7NhkQ34eTwt
        3Xiw0H4aElGdUqWDkzDb6WC17tmKmHgM7noRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OAeG5+ia3EficXdF9X1PRDBM9rJ9w9Cr
        OfGrwD7lkvCdm4uJ4SDiJ3T3kNGdTV0ee6avRsjqFYb0KkIwaqEExsTkuVJZb2T2
        YVqlC6On4Rq2gGbhvqhCT2jpMlwFmquTI6yPlGTEH81s6HZztwl6C7p42yFp1AlC
        m5Ma7nq/Pco=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63B501590C1;
        Tue, 23 Jul 2019 11:51:26 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA4DD1590C0;
        Tue, 23 Jul 2019 11:51:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #04; Thu, 18)
References: <xmqqtvbjvull.fsf@gitster-ct.c.googlers.com>
        <20190722193535.GA11274@comcast.net>
Date:   Tue, 23 Jul 2019 08:51:24 -0700
In-Reply-To: <20190722193535.GA11274@comcast.net> (Matthew DeVore's message of
        "Mon, 22 Jul 2019 12:35:35 -0700")
Message-ID: <xmqqo91ku4ub.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA2D0A64-AD61-11E9-A36D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

> I gave some
> input earlier in this message:
>
> https://public-inbox.org/git/20190714231558.GA24609@comcast.net/

Thanks, that helped a lot and I think what we have is good now.
