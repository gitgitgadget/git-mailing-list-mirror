Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1414C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A0E60F42
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhH3RSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:18:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51474 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhH3RSX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:18:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 071FCD2DC6;
        Mon, 30 Aug 2021 13:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xu6GwlnU3xQVu1QzN7JddlAgAF0mBUGW7OQVok
        7u5RU=; b=ealyzFiJqKfc6NEPt6YM6bwcYbvYZMBLSOwrh6/R7eAEqHhaGyJD8S
        uTlbnE7zkpsEKFOkEEgO6iBj8dlwP074V/TWyZYD+ARs4iKCUPkyUzfoWgrELAYx
        15NnUirPCYwbwRLEmYAOen1QhNp/SGLmoQzQ8P5j6c7xZg33w7O3s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F253DD2DC5;
        Mon, 30 Aug 2021 13:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 811A3D2DC3;
        Mon, 30 Aug 2021 13:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] fetch: skip formatting updated refs with `--quiet`
References: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
        <e5ffa17753d4aca57d486d500a2d114290361ea7.1630320848.git.ps@pks.im>
Date:   Mon, 30 Aug 2021 10:17:27 -0700
In-Reply-To: <e5ffa17753d4aca57d486d500a2d114290361ea7.1630320848.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 30 Aug 2021 12:54:26 +0200")
Message-ID: <xmqqo89e4ztk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 270BFE58-09B6-11EC-B0FD-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When fetching, Git will by default print a list of all updated refs in a
> nicely formatted table. In order to come up with this table, Git needs
> to iterate refs twice: first to determine the maximum column width, and
> a second time to actually format these changed refs.
> ...
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

Will queue.  Looks sensible.

Thanks.
