Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C721F731
	for <e@80x24.org>; Fri,  2 Aug 2019 16:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390406AbfHBQQQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:16:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54898 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfHBQQP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:16:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E5FC15B93E;
        Fri,  2 Aug 2019 12:16:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9ZYe0m57vVPib2jj5XmmnPGCbno=; b=oIf1xK
        cz2OdqIMWZ5sYuxUIzq3JdHhtN6nuAClqAQQ/+0WwHbewNSGDD/DDMAZC6qWJu6t
        TPho2JMtdocFs5nl0T29/r4QY+vJxcOQNTd8ZDx4Ejk9O9HMLJTJVsW6ompZQeIk
        EXnCpR+Hr/FEynGaqPSNjZmyVbTtFhguc+T6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=axmjsh0/1JhKptYGFPtDySZdFQ0QS0/i
        I5dF8k5T7vI7CuvPxOWHh2HfbNwDeoIn5wF2trwoYbnAYC6zKMRDx2TcTlGo1aMh
        hvlfEnCsmYJrXTiNRN5sL0Wcw4u1qyvdwMh9u8zvnS9TPOscKV+Dys4Kt7ffzoYC
        VQpHGDZQ2iU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85AAC15B93D;
        Fri,  2 Aug 2019 12:16:13 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFF8C15B93B;
        Fri,  2 Aug 2019 12:16:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] restore: add test for deleted ita files
References: <20190726045645.2437-1-vcnaik94@gmail.com>
        <20190801160910.12652-1-vcnaik94@gmail.com>
Date:   Fri, 02 Aug 2019 09:16:11 -0700
In-Reply-To: <20190801160910.12652-1-vcnaik94@gmail.com> (Varun Naik's message
        of "Thu, 1 Aug 2019 09:09:10 -0700")
Message-ID: <xmqq1ry3mtkk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8AE36F2-B540-11E9-A753-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Naik <vcnaik94@gmail.com> writes:

> `git restore --staged` uses the same machinery as `git checkout HEAD`,
> so there should be a similar test case for "restore" as the existing
> test case for "checkout" with deleted ita files.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Varun Naik <vcnaik94@gmail.com>
> ---
> This is the "restore" patch based on the merge of the "checkout" patch
> into master.

Makes sense.  Thanks.
