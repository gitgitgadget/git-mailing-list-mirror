Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6E6C43460
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BB361458
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhEHG5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 02:57:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58622 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhEHG5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 02:57:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8232213700D;
        Sat,  8 May 2021 02:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dohj08S8ZEmEh8+8GOu3xbBbu8WEiOxhQsRRn1
        5Dnyo=; b=iZL38tlE1JDu5LG6sWg/ZXJ7/PrxfwXGtkBtdm/om6usYxvuycPSnD
        nQgD9zxi/IG5YWBcpN3RrolsgOlS++5RxVDoDYDZQT9k4QA4o/6Fbg7I2/tf6bdu
        ZbatKmuQ2KhJOFm9rs4jv8K1r3DTe4s47+zfWWggV4i45NMZ2gBrk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E08A13700C;
        Sat,  8 May 2021 02:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98B8013700B;
        Sat,  8 May 2021 02:56:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     dwh@linuxprogrammer.org, git <git@vger.kernel.org>
Subject: Re: Preserving the ability to have both SHA1 and SHA256 signatures
References: <20210508022225.GH3986@localhost>
        <CAP8UFD0vp-zZv=Q1+KWv8PHnxTuspTw2aSCUp8QUic0HOSyq4w@mail.gmail.com>
Date:   Sat, 08 May 2021 15:56:32 +0900
In-Reply-To: <CAP8UFD0vp-zZv=Q1+KWv8PHnxTuspTw2aSCUp8QUic0HOSyq4w@mail.gmail.com>
        (Christian Couder's message of "Sat, 8 May 2021 08:39:28 +0200")
Message-ID: <xmqqim3tvhlr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86E5B760-AFCA-11EB-9817-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Hi,
>
> (Not sure why, but, when using "Reply to all" in Gmail, it doesn't
> actually reply to you (or Cc you), only to the mailing list. I had to
> manually add your email back.)

I am sure why.  DWH, please do not use mail-follow-up-to when
working with this list.  It is rude and wastes people's time (like
the practice just did by stealing time from Christian).

Also cf.
https://lore.kernel.org/git/7v63l6f1mc.fsf@gitster.siamese.dyndns.org/
https://lore.kernel.org/git/7vk3zig92n.fsf@alter.siamese.dyndns.org/


