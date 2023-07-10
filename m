Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAED9EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 22:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjGJWjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 18:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjGJWjT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 18:39:19 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967A91
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 15:39:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C4D018E147;
        Mon, 10 Jul 2023 18:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FakoO/0RVz1I
        DfDmzjAJ/3AMIdrinOsdMJ7MDvaZ/Kc=; b=Pa4DK3xQfoCr6lQ3/YPyfyUrWXy0
        JyId/rHVfwcDPDHNxMMGRJqMTHWsuYa14ES4AIm/WgNezfhxVA7hashXOl6xAxjq
        UwSGXhRByUOm2c3RXenZkmwRxg7jWYbSjD/URVb2W+U6WLFqciyo4ImMzDnRXGur
        ew/5RaA2ZM/LTiw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52F9D18E145;
        Mon, 10 Jul 2023 18:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFFCB18E144;
        Mon, 10 Jul 2023 18:35:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 00/16] refs: implement jump lists for packed backend
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1689023520.git.me@ttaylorr.com>
Date:   Mon, 10 Jul 2023 15:35:52 -0700
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 10 Jul 2023 17:12:01 -0400")
Message-ID: <xmqq5y6r4con.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 21272CA0-1F72-11EE-9818-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is another reroll of my series to implement jump (n=C3=A9e skip) l=
ists
> for the packed refs backend, based on top of the current 'master'.

I've skimmed the whole set again and nothing jumped at me as an
unexpected change.  Let's wait for a few days to see if we have
others comment on the patches and then merge it down to 'next'
unless there is something spotted in there.

Thanks.
