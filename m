Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0CE1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756165AbcLSSRj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:17:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52104 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755298AbcLSSRi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:17:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7201857D21;
        Mon, 19 Dec 2016 13:17:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2hu2JCjXTFck58aPHMXE1WvrmS0=; b=S6WVJC
        B+bz2lMo5ImeltTBo7AjOI2N4r5fDk4jW1AoMp5En94uLe6Cq89AvG2A5lLlItlA
        5GBBMlj7dhlcwip+dfmW2pjoz3d9lZzEGrIIkNTLiXDGTqD4V16og6cploFROxXj
        GCuS5U+9D9GQ0Cdl5tA5Fj51P6WcxtE2SJBls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FqbBqIxygGp5IlDvaG2MRMpPoFF49sqg
        bA4rbyPYEOvLlpHTjJiWVIth9KvJ78Kfxh7VgF6jOWjnzqC+txv3jd0UsFwM7c2S
        zv8jeYltoTotBAaqUHg+yH+lf96pU23FP8taOaE9o3SmAo2c+KJ3oEE5W4IcHdui
        ymx2beVHG4M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A06A57D20;
        Mon, 19 Dec 2016 13:17:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C305F57D1F;
        Mon, 19 Dec 2016 13:17:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #02; Mon, 12)
References: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612131641291.23160@virtualbox>
        <xmqqinqn6c41.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612191145080.54750@virtualbox>
Date:   Mon, 19 Dec 2016 10:17:35 -0800
In-Reply-To: <alpine.DEB.2.20.1612191145080.54750@virtualbox> (Johannes
        Schindelin's message of "Mon, 19 Dec 2016 11:49:25 +0100 (CET)")
Message-ID: <xmqqpoknpyv4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B4D64AE-C617-11E6-B59D-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Otherwise I'd prefer to drop it---at this point, the series is merely
>> "just because we can", not "because we need it to further improve this
>> or that".
>
> Oh, I thought that this was meant as a starting point for anybody
> interested in playing with resumable clones or with easing server loads.

It started as such, but the effort stalled and nobody seems to be
taking it further.  I do not know it is clear it would be a good
starting point at this point.  Perhaps it is.
