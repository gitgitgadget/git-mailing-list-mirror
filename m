Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BF4C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1D4610CB
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhJ0VXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 17:23:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60151 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbhJ0VWW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 17:22:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BA30F1072;
        Wed, 27 Oct 2021 17:19:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oQBpLHKlhVKzR2uHAXTaUjBoVtpKw/+jSwOPXK
        vcDJ8=; b=OaFe9hxfllNJV5+Lfx4U5u7UZyFeDIh7Kcaf6KhT8zgXYvACLJUbyH
        cn6NnKrbt71zWMQPzrOly48HvRJEo98Db230eNOlYDrwP/ByZsoNAu07Ub7b8mdX
        VfcHbIsa5y7cuppwmEqWOpDqka48PnjJg9WAmpL9Pc8imPE3wQXN0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71025F1071;
        Wed, 27 Oct 2021 17:19:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE6A6F1070;
        Wed, 27 Oct 2021 17:19:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] stash: implement '--staged' option for 'push' and
 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <87fst2gwia.fsf_-_@osv.gnss.ru> <87pms2mi1p.fsf_-_@osv.gnss.ru>
        <87wnlya40k.fsf_-_@osv.gnss.ru>
Date:   Wed, 27 Oct 2021 14:19:53 -0700
In-Reply-To: <87wnlya40k.fsf_-_@osv.gnss.ru> (Sergey Organov's message of
        "Wed, 27 Oct 2021 18:20:11 +0300")
Message-ID: <xmqqfssmupvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A14A7A68-376B-11EC-AC36-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Stash only the changes that are staged.

As the topic already is in 'next', let's have this in a form of
incremental "the earlier one missed this, so let's fix it" patch to
be applied on top.

Thanks.
