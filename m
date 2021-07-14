Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3167CC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108BF613BE
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhGNRbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:31:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64597 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhGNRbN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:31:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4541214B68F;
        Wed, 14 Jul 2021 13:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=csqEwth0I0yh499yQqr/8Vrm8YIjmvGhuORVzU
        +qVsU=; b=IO1UUvOINxAcwUtdd1H9f0hKsI7kwg1rqBe6JYUCpTkGoKPhhF/Jzk
        PcoeOccnf4elrwr3y2JnmyMgm0y3MDgu5WR6QJKpMpUiVA3zpnOn9mhcUCJ4hKBw
        gBaA/ACsioBbW8kiU/W8jkgedzcIWQQt0PY1wXk5wNrHuPblKH5CE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E13214B68E;
        Wed, 14 Jul 2021 13:28:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B975B14B68C;
        Wed, 14 Jul 2021 13:28:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
References: <xmqqmtqpzosf.fsf@gitster.g>
        <CAFQ2z_P=9Suh0kO6E44hUOyNFOAKcmcUg_x6AQFP9jhHrBA6RQ@mail.gmail.com>
Date:   Wed, 14 Jul 2021 10:28:17 -0700
In-Reply-To: <CAFQ2z_P=9Suh0kO6E44hUOyNFOAKcmcUg_x6AQFP9jhHrBA6RQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 14 Jul 2021 10:42:24 +0200")
Message-ID: <xmqq4kcwyfda.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E132D2EC-E4C8-11EB-8F08-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> AEvar posted the corrected patch as part of his follow-up series.
> (https://public-inbox.org/git/patch-04.17-270cda29c3a-20210711T162803Z-avarab@gmail.com/).
> Would that work for you?

In
<CAFQ2z_M7FzR6HEea2Xj-j=LiTsjQvpGJc+h+D+GgU=ZEkWm50A@mail.gmail.com>
you sounded that you are more-or-less OK with that version but with
some comments, so as long as you two can give a "final" version that
both clearly agree to, I'm OK.  It just is not clear if v7 is that
version to me (yet).
