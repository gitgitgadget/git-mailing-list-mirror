Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80ECC1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 22:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfFQWfg (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 18:35:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51330 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfFQWfg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 18:35:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29831159C51;
        Mon, 17 Jun 2019 18:35:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mA7AG2F+dKto4U4GCZkS8VO6y1g=; b=W1sKp0
        CGwjI5ZwCBz0Ouh8z8GwgFcZie3bycyeR6hzVWdRazthS+2g3Rc1w6TkOiBPzkT1
        l2eK5XXI4uOfGIdA3F8Xwk2cRY/p6r6q0PsFX0r5jQCJU9xKsDNGh6m049slX0WR
        dssg0GW2gSx1LLC6EuDmYLxBoFrSkBtzmYNSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SAAkk040jLQPmBQUdoYbAtpViza0NzWl
        MnDvaT/iI+0YZ+N719cTDaE2UcgGLAu/amlg6j5ieZ+itsFrQse5sF+g8SIOjuXh
        PGpn/pjsxbD0abVDUjYAUSGfSxs0O33He2OnA8Yta1vXfRgoAKiZdHLGJEqpmM3Z
        kPzDiVYraVI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 221B2159C50;
        Mon, 17 Jun 2019 18:35:34 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8938C159C4F;
        Mon, 17 Jun 2019 18:35:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] show --continue/skip etc. consistently in synopsis
References: <20190616132457.19413-1-phillip.wood123@gmail.com>
        <xmqq36k9tb30.fsf@gitster-ct.c.googlers.com>
        <991b0908-4ec5-2d19-4df3-df3eb28632c2@gmail.com>
Date:   Mon, 17 Jun 2019 15:35:32 -0700
In-Reply-To: <991b0908-4ec5-2d19-4df3-df3eb28632c2@gmail.com> (Phillip Wood's
        message of "Mon, 17 Jun 2019 10:15:25 +0100")
Message-ID: <xmqqfto7suvf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3813DA80-9150-11E9-ABA8-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm not sure I'd argue too hard one way or the other, but I do think the
> documentation for the various commands should try to be consistent and
> the am, cherry-pick, rebase and revert man pages all use a single line
> for these options (although rebase is missing the parentheses).

Good.  Then please write these names in the proposed log message;
the version I commented on looked a bit strange to single out "am",
as if we are siding on a minority, but writing the names of its
friends that share the convention would not give that wrong
impression to the readers.

Thanks.
