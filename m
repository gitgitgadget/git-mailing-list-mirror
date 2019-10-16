Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEEE01F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 05:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbfJPFLC (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 01:11:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53055 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbfJPFLC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 01:11:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 184097DF07;
        Wed, 16 Oct 2019 01:11:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JsTfC69Ep2Sr9QX++Mlyu0gzcQE=; b=V6qo9T
        CCUdLD/D3IgUAvvAk3HISOh9wBicDkvyy+ksZZyMoL2B2bpgZQKoP0ZbHFw/0p7D
        VV47tbRZjBJ7+3otJtIo+Bx8kDORQFOepnulKza3WhiDDwgNktfX8GFojsXuqhdN
        PWeewpGhg3dZ0AvsLXRepJgiSXDK1p67wv894=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vFzYsxpZpHGWE35a4arvOX/xc/UOfITl
        7tt+owKcjQ5365tE6h+q9hAFAAPxoHnutWdz++W1cbYU83IB21xWsGS8XkG3Qn/7
        gGYrIrb64Gn7c0QQ3o+E/PUx76co/rSc9wR7vCNg2bHgneFizSjoagllruIHZ1k7
        nTfD/dSqlag=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 016977DF04;
        Wed, 16 Oct 2019 01:11:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C7657DF02;
        Wed, 16 Oct 2019 01:10:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH v3 01/13] graph: automatically track display width of graph lines
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
        <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
        <722ab8973ace92aeef8669eced2919a144240cc0.1571183279.git.gitgitgadget@gmail.com>
        <xmqq8spl9xcd.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 16 Oct 2019 14:10:56 +0900
In-Reply-To: <xmqq8spl9xcd.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 16 Oct 2019 12:35:14 +0900")
Message-ID: <xmqqo8yh8ecf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 572EFAD0-EFD3-11E9-9E84-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  int graph_next_line(struct git_graph *graph, struct strbuf *sb)
>
> I just noticed it but does this have to be extern?  Nobody outside
> graph.[ch] seems to have any reference to it.

I was stupid; strike this part out.

Thanks.

