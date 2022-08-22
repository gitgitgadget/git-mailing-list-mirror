Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A9C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiHVQMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiHVQMg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 12:12:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4676B4BF
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 09:12:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E4301AB662;
        Mon, 22 Aug 2022 12:12:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OCQsEMfVu/mJ
        5y1gKuKKDg5eMmPFa7DQGCv2UgbK7rA=; b=o8HxILtmTp3CsT/RIzophBefGSWo
        0WiqxiVglzgI35yazE4l17UBisT0NRA+0/APqXqdigikMeBXaUVMghKX+3lEPblx
        0zHrI26VCrqIgXYPwlcaOcOFomqyI4R0XQZL6+yc4/O/k0K/nmZVU048xHxJ/Yj7
        7XOfrnOFRWvjPoI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57A5A1AB660;
        Mon, 22 Aug 2022 12:12:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB5B61AB65E;
        Mon, 22 Aug 2022 12:12:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/4] sequencer: do not translate parameters to
 error_resolve_conflict()
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
        <cover.1660828108.git.git@grubix.eu>
        <4684d54aeb3e00c96ba581c824a04e47b7236db7.1660828108.git.git@grubix.eu>
        <220818.86v8qp8uid.gmgdl@evledraar.gmail.com>
        <06s6r3s7-27nn-1o9s-1n7p-5413284r8740@tzk.qr>
        <xmqqfshsm8z1.fsf@gitster.g>
        <oqq42q11-3031-91or-no50-p68q85po1492@tzk.qr>
Date:   Mon, 22 Aug 2022 09:12:29 -0700
In-Reply-To: <oqq42q11-3031-91or-no50-p68q85po1492@tzk.qr> (Johannes
        Schindelin's message of "Mon, 22 Aug 2022 15:53:56 +0200 (CEST)")
Message-ID: <xmqqv8qkdzpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 394596E0-2235-11ED-86EF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... We want code contribution to have a high quality, and the
> code reviews should meet at least the same bar.

I like that one.  =C3=86var is not alone, but many of us often throw an
unrelated "observation" into a review thread that is a total
tangent.  While I do not think it is necessarily a bad thing,
because these tangential discussions often turn into separate idea
that lead to improvements, we should learn to (1) mark a tangent
clearly as such and (2) keep the quality of the tangent reasonably
high.

Thanks.
