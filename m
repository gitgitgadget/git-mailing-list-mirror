Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135EFC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E515B61246
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhJAVlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:41:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62097 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhJAVlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:41:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E09561539B6;
        Fri,  1 Oct 2021 17:39:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QYkR9nh9+Qnn
        nJg9uHhQgI88lkTl85ujlIa7VLTPHB0=; b=Q0xMDq6DJpCGepI9giejNm0UxKYX
        RiKD37g3G+RwoCAqyB5Bcw/4Qht1Kv5CHodwYISqg3A1zvwhNVuIgKiNGmeIR5fE
        A7ys78HEEOSce3DNa7tQZcYeZVbcl92NNBa3FFdSHWzgNGy6rQHcRqP9cXR5anr7
        Q0M8IM5d5LM8Zhk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA6BA1539B5;
        Fri,  1 Oct 2021 17:39:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 632321539B0;
        Fri,  1 Oct 2021 17:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] *.h: remove dead function declarations
References: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
Date:   Fri, 01 Oct 2021 14:39:30 -0700
In-Reply-To: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 1 Oct
 2021 12:37:39 +0200")
Message-ID: <xmqqfstk4e7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0FD486FC-2300-11EC-B38A-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A trivial series to remove some long-dead code, the oldest is
> something we've been carrying since 2006!

Nice.  Thanks.
