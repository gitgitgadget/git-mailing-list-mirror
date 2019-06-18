Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274941F462
	for <e@80x24.org>; Tue, 18 Jun 2019 01:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfFRBZa (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 21:25:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56924 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 21:25:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B804276062;
        Mon, 17 Jun 2019 21:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0EggMDeoyS8ZBRqv/8aYDlp/xdI=; b=rxLexq
        Ioce52TegyY+ms4Tk5Zx08jBGtUiXc25GU9+kZityQq3HXvKmH7sWiZHo1FTMweb
        1obQV5SVBuJP07ZUDr5KUkJaMdhlsymhvpdpex6NLmD5x7TvR9cQahbLFE5E1MZN
        euzqNGzHXjHf3XdgvAT1xh5GNqQXQ3Oi3wnOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eE+JsptG8FsIidgOi5wpeAVeKvdaTkNs
        myXR1Hx6qRkjSG/OYPNxOZ+34habAp9HTo+PJ4WbTl4pjO1/4BQXXXHjd01jbiRw
        mvhXsXyP86jTyctckOhfsyr5JIGTAAsoIlv7jMLGhr3y14Hp5zGnOHrK37Gtj+0Q
        m+wBzAx/9/M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFF9676061;
        Mon, 17 Jun 2019 21:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF2077605C;
        Mon, 17 Jun 2019 21:25:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com,
        matvore@comcast.net
Subject: Re: [PATCH v4 00/10] Filter combination
References: <20190601003603.90794-1-matvore@google.com>
        <cover.1560558910.git.matvore@google.com>
Date:   Mon, 17 Jun 2019 18:25:22 -0700
In-Reply-To: <cover.1560558910.git.matvore@google.com> (Matthew DeVore's
        message of "Fri, 14 Jun 2019 17:40:06 -0700")
Message-ID: <xmqqblyvsn0d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2998014-9167-11E9-8ACB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> I had to rebase this onto the latest master rev. master now has the patch which
> disables the sparse:path filter, and v3 of this patch set has conflicts with it.
> This version does not so it can be patched in and tried out by others.
>
> I have re-run the test suite on each commit. Sorry for the spamminess.

Thanks.  Will queue.
