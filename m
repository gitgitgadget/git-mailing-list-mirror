Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C663C433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665F760E54
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhJaSKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 14:10:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60566 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhJaSKd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 14:10:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DF3316BC34;
        Sun, 31 Oct 2021 14:08:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pYliltYOCzCPTkYKF5quyAU9Rov54vbWRc8N7F
        JppH8=; b=c2sKBv/hFqdKfmSTONtPwC59WDfGIvREQywKhYL7ZhvdFWTB36O0r4
        RLTIrUWBlZHgjRM1pJEfjttkEfBzczIojs0TPO2Nx8OYQ65RcDuGDs/Zuhk+XhZi
        3ksshtOfPWeqj3yDLoxpEaNc2EIZczgQ+5bD7mfPslE0A67y4uYL0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4791016BC33;
        Sun, 31 Oct 2021 14:08:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C36E16BC31;
        Sun, 31 Oct 2021 14:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Schwartz <eschwartz@archlinux.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v4 2/3] pretty: add tag option to %(describe)
References: <20211029184512.1568017-1-eschwartz@archlinux.org>
        <20211031171510.1646396-1-eschwartz@archlinux.org>
        <20211031171510.1646396-3-eschwartz@archlinux.org>
Date:   Sun, 31 Oct 2021 11:07:55 -0700
In-Reply-To: <20211031171510.1646396-3-eschwartz@archlinux.org> (Eli
        Schwartz's message of "Sun, 31 Oct 2021 13:15:09 -0400")
Message-ID: <xmqqh7cxdq4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79E9EEF6-3A75-11EC-BAF6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Schwartz <eschwartz@archlinux.org> writes:

> The %(describe) placeholder by default, like `git describe`, only
> supports annotated tags. However, some people do use lightweight tags
> for releases, and would like to describe those anyway. The command line
> tool has an option to support this.
>
> Teach the placeholder to support this as well.
>
> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
> ---
>
> I use lowercase "bool" here not "boolean-value" because I don't see
> utility in the word "value" here.

Such a comment is much more useful if it is sent as a review to the
patch that touches the same area as your patch does, namely,

https://lore.kernel.org/git/984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com/

not here.

Thanks.

[jc: added a few folks involved in the other patch to the addressee
lists]
