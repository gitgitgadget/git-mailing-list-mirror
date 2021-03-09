Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E18EC433E6
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21DCD6525D
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhCIUxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:53:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61225 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhCIUx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:53:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91A9E1103AE;
        Tue,  9 Mar 2021 15:53:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FNZbiTvcZPpcG+FHhN1yJbHwLHM=; b=DZw3en
        N3ATxvKfDmfq+Q+2g2zcwwtnObtGxu9xdoUh/9jeb8ZOAOnKHXXjaXN4JiWesupQ
        zjqGDQuzvUM9fK4sILP+VaH8eCvBhD2g4Ic+YJGkYe4HNKROlM8KsSTMBFBCcoaV
        VQHTQFeuOJ8YP9leo+qTdYzPl35bZKeVP0MVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pAb3h5gnAsF1euTUop/v8cm65Ob8B4Ao
        ShzWxXU77LQ/zn5fZMKL0A0YDVkcUba8X9kygH8HNiFs86ztbRfRiZw44dA4t9Pa
        i8L7+mINVrvI2CQ7hbDTcuJr21pSZYFeyfGwjJoES8vjlP9qRPpbZ43q4VwBYdma
        PMojeaGlDmY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8AD1C1103AD;
        Tue,  9 Mar 2021 15:53:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C503B110384;
        Tue,  9 Mar 2021 15:53:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.31.0-rc2
References: <xmqqblbs19uf.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2103091537530.50@tvgsbejvaqbjf.bet>
Date:   Tue, 09 Mar 2021 12:53:22 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2103091537530.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 9 Mar 2021 15:40:40 +0100 (CET)")
Message-ID: <xmqqo8fsyrp9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D1E5690-8119-11EB-B8C5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 9 Mar 2021, Junio C Hamano wrote:
>
>> A release candidate Git v2.31.0-rc2 is now available for testing at
>> the usual places.
>
> For the record: I already have a PR up in the Git for Windows project with
> a tentative Git for Windows release candidate:
> https://github.com/git-for-windows/git/pull/3098
>
> For now, I need to take a break, and I plan on finishing this up tomorrow.

Thanks for all the work on the maintenance releases up to 2.30.2 and
below, which are a lot more urgent than any -rc.

