Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8090D1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756592AbcH2Vhu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:37:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50181 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756026AbcH2Vhu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:37:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0D5C3826C;
        Mon, 29 Aug 2016 17:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rjQh2gKMUELfxBQpe4JqwnQg1sU=; b=KjzqB8
        JGOP4H3eCwTZnuoBoExmohjbwAE+8Ij+TUJ0SAwAe9oFNtr5Xua0UZV3hCkqvEGg
        BpGUFudJYLk945G/45DCh8b+CKxvlVwkbWSc7eEOWwR6RRwr33kF7VOrwB61kXaf
        mZ6ENdAIbw0nJkVbfrMGptAXqZBqm4DEH5QpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bm2Q6fIitaxr3FavU3ZAP6KTavYmTY+8
        v9ZNHUPfYB+9KB+bP/s3xWhMW82z3OGslytaKZNSjvQdFKUyWH3HkCrWJFbmQ9td
        wPgg50NFsQ1WG5yBNXLYlJYEIgaV9bCu3+tPoM6oPQs3cwn2PiNrcH1tS8QH8EC1
        xiVCKaC1haY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 996EC3826B;
        Mon, 29 Aug 2016 17:37:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22D1238269;
        Mon, 29 Aug 2016 17:37:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org
Subject: Re: [PATCH v4 0/3] diff-highlight: add support for --graph option
References: <20160823041252.53ldwacgdey2euxt@sigill.intra.peff.net>
        <20160829173347.454-1-henderson.bj@gmail.com>
Date:   Mon, 29 Aug 2016 14:37:46 -0700
In-Reply-To: <20160829173347.454-1-henderson.bj@gmail.com> (Brian Henderson's
        message of "Mon, 29 Aug 2016 10:33:44 -0700")
Message-ID: <xmqq4m638ded.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D45AFD6A-6E30-11E6-9475-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> writes:

> How does this look?
>
> Drawing the graph helped me a lot in figuring out what I was
> actually testing. thanks!

Yeah, I also am pleased to see the picture of what is being tested
in the test script.

With your sign-off, they would have been almost perfect ;-).

> Brian Henderson (3):
>   diff-highlight: add some tests.
>   diff-highlight: add failing test for handling --graph output.
>   diff-highlight: add support for --graph output.
>
>  contrib/diff-highlight/Makefile                  |   5 +
>  contrib/diff-highlight/diff-highlight            |  19 +-
>  contrib/diff-highlight/t/Makefile                |  22 +++
>  contrib/diff-highlight/t/t9400-diff-highlight.sh | 223 +++++++++++++++++++++++
>  4 files changed, 263 insertions(+), 6 deletions(-)
>  create mode 100644 contrib/diff-highlight/Makefile
>  create mode 100644 contrib/diff-highlight/t/Makefile
>  create mode 100755 contrib/diff-highlight/t/t9400-diff-highlight.sh
