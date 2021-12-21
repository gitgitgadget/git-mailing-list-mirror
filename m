Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E0AC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 17:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbhLURSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 12:18:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56360 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLURSE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 12:18:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDA70176DBF;
        Tue, 21 Dec 2021 12:18:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bjLc0vgglKz9Bt8gIBt52ddM0f44J6Glhktgw8
        mQpEg=; b=wsJqfDAFO3Lw1XBxxBzqe1UEta1oO37BF3PFVTmU09nI92LCHOzn6L
        hFlu/senVNWmUg0Jp1eByLoMs83xZxznEWNsG9rgrKJGz2keiBpwlPS/ZLmGwW4D
        4b5ca9aLAN5P46wV8wllkvtQNTvISy36O0P8Qt+pd1tGb4NG7Up1Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D67A5176DBE;
        Tue, 21 Dec 2021 12:18:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 36CAE176DBA;
        Tue, 21 Dec 2021 12:18:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     l.s.r@web.de, avarab@gmail.com, git@vger.kernel.org,
        hanxin.hx@alibaba-inc.com, peff@peff.net, philipoakley@iee.email,
        stolee@gmail.com, zhiyou.jx@alibaba-inc.com
Subject: Re: [PATCH v6 5/6] unpack-objects.c: add dry_run mode for get_data()
References: <CAO0brD1f+w_J1jVzsBb0ewc7Ndwiz5pLC2QOG11r5-H0XetOAQ@mail.gmail.com>
Date:   Tue, 21 Dec 2021 09:17:58 -0800
In-Reply-To: <CAO0brD1f+w_J1jVzsBb0ewc7Ndwiz5pLC2QOG11r5-H0XetOAQ@mail.gmail.com>
        (Han Xin's message of "Tue, 21 Dec 2021 19:40:17 +0800")
Message-ID: <xmqqh7b1q3ll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F29E9D36-6281-11EC-9B26-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

>> Clever.  Looks good to me.
>>
>> For some reason I was expecting this patch to have some connection to
>> one of the earlier ones (perhaps because get_data() was mentioned),
>> but it is technically independent.
>
> I think I should adjust the order of this patch to move it forward.

Or just eject it from the series and send it in as an independent
single patch?
