Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E4C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 00:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E732610C7
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 00:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJ1AIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:08:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64009 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1AIg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 20:08:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 139F8EC7D3;
        Wed, 27 Oct 2021 20:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C5XEo26kzfJJ
        fJSy+GrL4uyAS5pa0a/BpgxgtDK8CbI=; b=UKHZbU4hv46ieSuF7lcTlMJyxqTB
        G3kcofVMIgF23dRiE7T4vcRvbgQ7QOb91q72by0QXg225lymlRV1UMixsjKxgF/a
        X6YIEO3EZ1sePCzCR/kxaC+iWc5495Di4X5kg6nHZlH+gH+AfcBkRrnx3ZcojYmv
        eTcMLpMCV2aVV6Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09AE1EC7D1;
        Wed, 27 Oct 2021 20:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49D3BEC7D0;
        Wed, 27 Oct 2021 20:06:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
References: <xmqq5ytkzbt7.fsf@gitster.g>
        <CAN0heSoxxCR2S8uFuF_bGk8667=RP2=B+SeEDn2XoJanCtehxA@mail.gmail.com>
Date:   Wed, 27 Oct 2021 17:06:07 -0700
In-Reply-To: <CAN0heSoxxCR2S8uFuF_bGk8667=RP2=B+SeEDn2XoJanCtehxA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 27 Oct 2021 21:17:43
 +0200")
Message-ID: <xmqqh7d2t3m8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA86D594-3782-11EC-86CF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Tue, 26 Oct 2021 at 09:00, Junio C Hamano <gitster@pobox.com> wrote:
>> * ma/doc-git-version (2021-10-25) 1 commit
>>   (merged to 'next' on 2021-10-25 at 9f74afec0c)
>>  + git.txt: fix typo
>>
>>  Typofix.
>>
>>  Will merge to 'master'.
>
> I notice you didn't pick up [1] which was posted as part of the same
> mini-series as this one. Maybe you intended to place it on
> ab/unbundle-progress and got distracted. Or if you don't agree with the
> patch, that's also fine. :-) Just checking.

Ah, that is a good one.  Yes, I noticed that these two unrelated
changes were sent as if they belong to the same topic, and I meant
to later find out which branch that other one should go, but was
distracted.

Thanks.
