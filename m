Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4557FC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB2682237B
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rxElU3x2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbgJSWRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:17:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51024 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgJSWRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:17:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7176F9BA02;
        Mon, 19 Oct 2020 18:17:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A3EYMXLJHUZiPrdgc8vdizWs6xM=; b=rxElU3
        x2PQ7ByLYFOkfZRM5IacWMnwly7txeAhQVhJ4MEMcjxzM84mXH5PS1Dd5/0JmCjV
        n1N1I698WFjOnQmtcaLKgumjXAEk+Gav6a9iK2tOsOAn3cIveVoDsMSxwmryTgT3
        tFE6/fWcHcUnfuvXF112V4QGGva9iZi1rbBj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J6a1XRKpZXnEtQ2j0Ze7Qo5N4TtMWNmV
        gBZpiMWgseSXZVvzA9DSx6Sg2hKCHdZDCf9Ag6N5HarctSykuReYmffZUt1mfvTg
        whinVg+6N+NodQzRTDbrcbbaeLYHajEEakkBYbsLW7ivHy5opfeGVmHAOYp4WYsB
        T+sQM0LD/kc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 635709BA01;
        Mon, 19 Oct 2020 18:17:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 113B69BA00;
        Mon, 19 Oct 2020 18:17:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Documentation: stylistically normalize
 references to Signed-off-by:
References: <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
        <cover.1603142543.git.bkuhn@sfconservancy.org>
        <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
        <20201019220214.GB49623@nand.local>
Date:   Mon, 19 Oct 2020 15:17:02 -0700
In-Reply-To: <20201019220214.GB49623@nand.local> (Taylor Blau's message of
        "Mon, 19 Oct 2020 18:02:14 -0400")
Message-ID: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D096E5A6-1258-11EB-8112-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I think that the 3-patch series that Junio was talking about in [1] is
> actually this one [2].
> ...
> [1]: https://lore.kernel.org/git/xmqqmu0it6ls.fsf@gitster.c.googlers.com/
> [2]: https://lore.kernel.org/git/20201018194912.2716372-1-gitster@pobox.com/

True.

I actually think it is a bad idea to add ":" after every mention of
"Signed-off-by"; it only looks clarifying because we use a boring
and generic word "line" to refer to where that three-word token
appears.

We can say "a 'Signed-off-by' trailer" and it becomes plenty clear
that we are not talking about any random line in the log message,
and we do not need ":" everywhere, I suspect.

Thanks.
