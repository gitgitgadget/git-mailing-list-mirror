Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FBAC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0A7613A5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 15:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbhI2P5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 11:57:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53901 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344189AbhI2P5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 11:57:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E51A8E11F9;
        Wed, 29 Sep 2021 11:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7cdVCLgWZiqB8grA4titFtSgcm57W3H4ZKebM9
        ZhquM=; b=X6ix5NBGfryjuxpkc7536gAdZYZsQLncXSLTwBEqnpP8vIBt4Cip6R
        Opli9lOnnSR6fwri+7+QXm6o1NmqCaZdCKK2wCTgD7JtNKINSQhAQbfOUrasnt+N
        ENFhp+NIVFk5+fGOqtSWWfOZl9zUMT+kydIyt9WpmrOlMkVmLBnJY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC98AE11F8;
        Wed, 29 Sep 2021 11:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49655E11F7;
        Wed, 29 Sep 2021 11:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
References: <xmqq35polhye.fsf@gitster.g>
        <20210928201613.1110573-1-jonathantanmy@google.com>
        <CAPUEsphVJBCPLSfOyH2bqTCpcDvtPuOVGQsD3XaWVuZbFiVUeA@mail.gmail.com>
Date:   Wed, 29 Sep 2021 08:55:34 -0700
In-Reply-To: <CAPUEsphVJBCPLSfOyH2bqTCpcDvtPuOVGQsD3XaWVuZbFiVUeA@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 28 Sep 2021 18:00:36 -0700")
Message-ID: <xmqq35pnfkax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEEDED7E-213D-11EC-B176-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Either way, a v4 has been posted[1] (sorry, forgot to CC you), and
> hopefully that is now ready for next ;)

Thanks, both.
