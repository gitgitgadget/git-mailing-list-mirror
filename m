Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55977C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24293619AA
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhC1GOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 02:14:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61639 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1GOG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 02:14:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0B69123AD8;
        Sun, 28 Mar 2021 02:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ozXmf3J1BRj/
        BT3/X4DgtFjiA7s=; b=weB1596HdsbGaKjTtX1nq4k1IsVfQOTB6Kn/L4g7aLoX
        P2cH8HAH/MYetivE/VlAGkhNFNNZUQkqsWjGi1/iR9XeFbI26sazi8Grw4NeHs1K
        +bSa6cmc9z62uZY2c6B3Km63rdRGsEwGP9NWu6mQ6BBiLBpRRanOgfnrjjWSvws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HtqyDk
        hwpI4hXvZPmpRyoS+I3n+4FjgDQ4Q3EhSUazHzYraIL73C4NqRDFqE8bZNhsvgZz
        XQkwdKZxwTmC14su6iLiO6pvU1Qq+NNkWQXwr4TW59Pq8Ay1PO9xA8Jj5QIwxABw
        S+8cvJrUAMxjBCkdZcWmWRxSh27h01T9UrA4k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA0FE123AD5;
        Sun, 28 Mar 2021 02:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1F1ED123AC9;
        Sun, 28 Mar 2021 02:14:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] Documentation/Makefile: make $(wildcard
 howto/*.txt) a var
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
        <patch-1.6-a5ec5fe4bdb-20210326T103454Z-avarab@gmail.com>
Date:   Sat, 27 Mar 2021 23:14:01 -0700
In-Reply-To: <patch-1.6-a5ec5fe4bdb-20210326T103454Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 26 Mar
 2021 11:36:46 +0100")
Message-ID: <xmqqczvjolee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB260596-8F8C-11EB-8F0A-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor occurrences of $(wildcard howto/*.txt) into a single
> HOWTO_TXT variable for readability and consistency.

OK.
