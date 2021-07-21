Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A54C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AE0608FE
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhGUAbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 20:31:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59334 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhGUAbN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 20:31:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D46DEA294;
        Tue, 20 Jul 2021 21:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kueI7fBQtZYGgrXSV0bDdWcipQbZxEBMWriiqd
        ODqY0=; b=AaEpU08Do7qM1uFZ/8LHuOCYTWgM+vGk5YUXN/wYdWK9Q9jc2iNNPf
        4TVU4OfNN7suqMCGo/G8jYOf1DoqK6Hpsnh8M6yqd6Rn/KyJ+27l1eYZ0DOYpZwo
        vWRqGQrCcM4kCi/KHz0Ggk6BIK3VTjHdjnum48mrefT5iseIXFXR8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34D9DEA293;
        Tue, 20 Jul 2021 21:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D05FEA292;
        Tue, 20 Jul 2021 21:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #04; Mon, 19)
References: <xmqq4kcqko6g.fsf@gitster.g>
        <57342460-e85d-17c2-f882-373d03f63cd1@jeffhostetler.com>
Date:   Tue, 20 Jul 2021 18:11:48 -0700
In-Reply-To: <57342460-e85d-17c2-f882-373d03f63cd1@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 20 Jul 2021 11:43:59 -0400")
Message-ID: <xmqqy2a0eai3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0419F1E-E9C0-11EB-A41F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'm responding to comments on my V3 version and from dogfooders
> of our downstream experimental releases.  Hoping to submit a V4
> next week.

Thanks.
