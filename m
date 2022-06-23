Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AE7C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 16:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiFWQde (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiFWQdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 12:33:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D9387A8
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 09:33:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBF34141443;
        Thu, 23 Jun 2022 12:33:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ip9UYoIy+RwGvbb9QUI+fNXob9aOP8oCFp6dXj
        YYgqA=; b=ixyfmHOmPoTVpW2DB7qs2+3/xr84Kgs2SWXC2BA19ycjDeePv2aPwN
        MhHmlcnnRAlOahocXnQRUk2tuElTTqfL8H2m8jvC2NwIQvBN9pUx33Fua4kU535m
        joQ5YQZg0sdqOsMTDDa5Sgy02lqMsUKLHl8x6gTy9Xr5M2DvcpGEs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4922141442;
        Thu, 23 Jun 2022 12:33:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 297F3141441;
        Thu, 23 Jun 2022 12:33:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t3701: two subtests are fixed
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
        <nycvar.QRO.7.76.6.2206151649030.349@tvgsbejvaqbjf.bet>
        <165537087609.19905.821171947957640468.git@grubix.eu>
        <nycvar.QRO.7.76.6.2206181342200.349@tvgsbejvaqbjf.bet>
        <xmqq8rpqja0v.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2206231747220.349@tvgsbejvaqbjf.bet>
Date:   Thu, 23 Jun 2022 09:33:27 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2206231747220.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 23 Jun 2022 17:55:44 +0200 (CEST)")
Message-ID: <xmqqilor1grs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 368D6F60-F312-11EC-AEFE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But a more complicated solution for the same problem was applied directly
> to the main branch, so I'd like to shift my attention to problems where my
> input has a chance of mattering.

Any reasonable input makes difference.  You can even improve incrementally
with follow-up patches.

Thanks.
