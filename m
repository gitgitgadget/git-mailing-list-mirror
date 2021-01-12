Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CBDC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 22:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAA92312F
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 22:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405310AbhALWe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 17:34:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52855 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbhALWez (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 17:34:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EB429E076;
        Tue, 12 Jan 2021 17:34:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=fgkpSEIAEsYT3PDToKXubWkT0
        xQ=; b=SBzS4U4ZahzEdJ9XPS1fzkWGUFYAVH+MVm9sRNj/O9uKa4OKZtpjPeD+8
        o5oiBnspMNtDs9oIjWzpvvUor6rWOvQ+mqKG+EBw0B6k2DCwa0Llu8jldyyhiR4O
        APT99s5oQ1+IPOTLQbCbO9OrDnRHsiwGfmSKnq/04pCzUqTMwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=ukwXh3dcg47yR8HSpCk
        wTD+0NEYazTD6wOY9KfpFxncHkb1QpJ8UnJvG37ZPSt749DVNuj/f0l+GnhautE/
        4LZl+vYyiNgAT4IegXZx+31vQn2mRm54SeyKS+BzXGx84dgOhWYtgRzYKq9Z61UG
        +S7khAl+E5g0QITmZgkGiXeY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55AD59E075;
        Tue, 12 Jan 2021 17:34:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D24639E074;
        Tue, 12 Jan 2021 17:34:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 00/22] mailmap: doc + test fixes
References: <20210105130359.21139-1-avarab@gmail.com>
        <20210112201806.13284-1-avarab@gmail.com>
Date:   Tue, 12 Jan 2021 14:34:12 -0800
Message-ID: <xmqqwnwh23a3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B812582-5526-11EB-AF2F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Just a "small" addition to v1, now with 21 extra patches. While this

Need reminder on what the v1 iteration was about here. =20

Thanks.

> is a large series, it should be relatively easy to read and
> non-contentious.

I've read this series through and didn't find anything glaringly
wrong or contentious.  Very cleanly done.

Will queue.
