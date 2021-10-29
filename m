Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054CBC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D187360FC3
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhJ2VtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:49:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52671 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJ2VtF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:49:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D353DE20D2;
        Fri, 29 Oct 2021 17:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=//s4x0OmKHq8JBkXGAmmikiRZlLNgxVBb99DID
        bm/DY=; b=diucuYMfgXS1RIPOxzjc8VKCXtWOmtNhH8fK5Ec0wo71i6LHoxUUY9
        lTaV4SkF2/JEIIRZiWbjf41PoZ8K2pABUVvf4zDdHt7Iu+v4yNzLXAHMwqPPBXs1
        PRo/a8DMa1DqqU1Nr1o1e456vutoGFxcBRkTQ+Bjpxd3baGavSIXg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CADD3E20D1;
        Fri, 29 Oct 2021 17:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39320E20D0;
        Fri, 29 Oct 2021 17:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] pretty: add tag option to %(describe)
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
        <20211029184512.1568017-1-eschwartz@archlinux.org>
        <20211029184512.1568017-3-eschwartz@archlinux.org>
        <xmqqy26bk2k9.fsf@gitster.g>
        <3cf891ea-58c8-b7d5-0b6e-eb23dff92bd5@archlinux.org>
Date:   Fri, 29 Oct 2021 14:46:34 -0700
In-Reply-To: <3cf891ea-58c8-b7d5-0b6e-eb23dff92bd5@archlinux.org> (Eli
        Schwartz's message of "Fri, 29 Oct 2021 17:14:15 -0400")
Message-ID: <xmqqsfwjijwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B004D0D4-3901-11EC-BE49-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Schwartz <eschwartz@archlinux.org> writes:

> I also assume that it's fine for my patches to be inconsistent with the
> base commit, as it's expected df34a41f or some revision of it will be
> merged around the same time?

Yes, such inconsistencies will be gone when the both topics get
merged.  You can just assume that the details of what you write may
not matter in the end result ;-)

Or perhaps the other topic would graduate first, in which case you
have a chance to rebase these patches on top of the 'master' that
already have the other topic.  Your patches would then be consistent
with the base commit, as the base would already be cleaned up.

Thanks.

