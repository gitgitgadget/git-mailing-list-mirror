Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AC9C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA3D60F56
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 23:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhJ1XNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 19:13:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57631 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhJ1XNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 19:13:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FFCFF51D8;
        Thu, 28 Oct 2021 19:11:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dQIU1jZDa6RVqE/DY1HDpW1eeQhq5r/wfr3yw0
        aMc6U=; b=DtdbgQwKyZV+KPiobEQnEFvMgpcaWbV6G4onp6AmDILvALgutAuc/F
        fNP8CI5CEsCVO1WgRvNxFkWUrdAOD3hy7ZKDEMnCQxIdUpsAYDLoqQpb5uzx2MB9
        TaVxYCzPb0iQnG7ufsCOTaqJf5hT1I2zNIhZi5SSWj2uoJqe+/KZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18B00F51D7;
        Thu, 28 Oct 2021 19:11:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77F9BF51D6;
        Thu, 28 Oct 2021 19:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicholas Bransby-Williams <nbransby@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: conflict markers in markdown files
References: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
        <xmqq5ytgrkku.fsf@gitster.g>
        <CAGyLXMA93qQw_h97bMd14O26hSxn4xn+AzemVyrf6pn53qO3UQ@mail.gmail.com>
        <xmqqilxgpywf.fsf@gitster.g>
        <CAGyLXMBe2qj8mT+gA2skQr=+bteV9E0nKZ=u-5akCQtTU7AfKA@mail.gmail.com>
Date:   Thu, 28 Oct 2021 16:11:17 -0700
In-Reply-To: <CAGyLXMBe2qj8mT+gA2skQr=+bteV9E0nKZ=u-5akCQtTU7AfKA@mail.gmail.com>
        (Nicholas Bransby-Williams's message of "Thu, 28 Oct 2021 23:49:23
        +0100")
Message-ID: <xmqqilxgoicq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B76BAD6-3844-11EC-AD29-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicholas Bransby-Williams <nbransby@gmail.com> writes:

> Thanks, I didn't miss that.
>
> I have no control over the content in the file so I don't know what an
> appropriate number is.

Those who are editing the file would be able to adjust the
attributes themselves, no?
