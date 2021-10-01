Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6571C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B239761AD1
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353802AbhJARHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:07:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61726 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhJARHA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 13:07:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FA72162D4C;
        Fri,  1 Oct 2021 13:05:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6okmcXN8JGgLNqv/8e2Wyl7pSVozwP9ee/tsIy
        8KZGw=; b=P/rUjiGf/RGn0gOLMnnm2HxvmBWS45yJBM9VK2sVYSW3wH3zlIhYNZ
        xP96OBl9Sec/xHiVgLswJXmTPW8tNJSqsO0X0hDY7dTIRCrVASJQy0OizbGZrITO
        f5LmvZxHZHFRIstGpww7+U0QnkZmzcPMQV1qYwEWKuDxHCQj4ZSRk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 481C3162D4B;
        Fri,  1 Oct 2021 13:05:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE065162D4A;
        Fri,  1 Oct 2021 13:05:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: en/removing-untracked-fixes [
References: <xmqqh7e18soj.fsf@gitster.g>
        <CABPp-BHKOt+x+B3DGh3BJV_voP64pvTrL5B-w4hWqHNKfr2K3w@mail.gmail.com>
Date:   Fri, 01 Oct 2021 10:05:12 -0700
In-Reply-To: <CABPp-BHKOt+x+B3DGh3BJV_voP64pvTrL5B-w4hWqHNKfr2K3w@mail.gmail.com>
        (Elijah Newren's message of "Thu, 30 Sep 2021 23:20:02 -0700")
Message-ID: <xmqq35pk8ylz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE5C2742-22D9-11EC-9155-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I think such a change, if others want it, could and likely should be
> submitted separately from this series.

Let's take these as we have them right now.  Any incremental
improvements can be done after the dust settled.

Thanks.
