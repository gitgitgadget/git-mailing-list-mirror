Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91D21F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbdARSg6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:36:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752519AbdARSg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:36:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17DD65F961;
        Wed, 18 Jan 2017 13:32:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3ygCJ4uVgH1D2wxTf784RXlnKXk=; b=XMEDKy
        h8J3vllBj/G18rjy42MVE3FVccqMZMG/6F9FavF+CDG05Pze6fA79KpM1kAfuxqX
        aqCxqlwJ5GXKvjVOl3qPkThp9vN5EfsjwB2M6bpkhZy+oZPwuRRSlWqzQ0idphNo
        wV5+gfivyKZcC0lO1vffJGaqorQNhx8yQ/T8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VYbEC4tFOFu5o+NHbEdmAxTP+EirneJT
        9zmHE0gXsQsOKMFPqUnjC3Ptu1NIHCOgeC/j930yeubiajapri8mmm4pGszAT4qO
        kYBcUVo88rAAqqZJepS8n11xPbK3r/lT6lwjA8T48SOzdu2C7g5xcizLUsbJt7nD
        uTBibokarLI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01C5C5F960;
        Wed, 18 Jan 2017 13:32:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 563AA5F95B;
        Wed, 18 Jan 2017 13:32:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael Gooch <goochmi@gmail.com>, git@vger.kernel.org
Subject: Re: problem with insider build for windows and git
References: <1bddbd50-86ea-6c38-6ab8-08336de2ba72@gmail.com>
        <alpine.DEB.2.20.1701131300390.3469@virtualbox>
        <alpine.DEB.2.20.1701181738490.3469@virtualbox>
Date:   Wed, 18 Jan 2017 10:32:44 -0800
In-Reply-To: <alpine.DEB.2.20.1701181738490.3469@virtualbox> (Johannes
        Schindelin's message of "Wed, 18 Jan 2017 17:41:42 +0100 (CET)")
Message-ID: <xmqq8tq8b4mr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 813C2604-DDAC-11E6-8259-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And just to prove me wrong, today I got the first update to `maint` in six
> weeks, with a message "Almost ready for 2.11.1" at its tip, featuring a
> whopping 141 commits (95 of which are not merge commits).
>
> So it seems that v2.11.1 may happen soon, after all.

Sorry for being late.  I had a short travel around the year boundary,
got sick and have been slow.

Aside from the "ouch, one topic has merged earlier iteration, that
was merged to 'master', also now merged to 'maint', and we need to
follow up on both" you sent out earlier, are there any other topic
that are already in 'master' that should go to 2.11.x track?

Thanks.
