Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269A91F45F
	for <e@80x24.org>; Tue,  7 May 2019 09:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEGJlQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 05:41:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62086 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEGJlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 05:41:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17C795024F;
        Tue,  7 May 2019 05:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W1FeqC16cFGf/ah9XkzprNBT/TA=; b=Fwf/2C
        /83S0jCliBI/e8UAbca9GMxgrdzYKeBB1DlkgjxspHs1KPHhl+o7OhSAW0DcOSck
        OV7V2f7JwN6ls4nXj+frW0MLTg163pR1knc9bCHdNRunVXpChiLSQm1eAOQRKlud
        qFf8FyAvl02orBYCeknfZ/jDI7rF6Ph/p3HX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DuUP+aabfZXQJejmpxkN2Ot0BxEn8IVG
        4LzGiBuu/VsbwirHBemGUKm+umRMCWQOvzctVFkXNdtK0n0mxHlpS60Gy2m9QqAk
        b1CcAVg5qVW5OIjEwD1uLQpAz5IhIkrWYMsTgc/tMKlNy3pt8zQCLXxvzP3n7J2s
        vca3aQCOdBA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E36715024E;
        Tue,  7 May 2019 05:41:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1E5E5024D;
        Tue,  7 May 2019 05:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/1] t5580: verify that alternates can be UNC paths
References: <pull.140.git.gitgitgadget@gmail.com>
        <2c3c559da0a5e9b397f4dc80be233c66b8597678.1551104263.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1904291851280.45@tvgsbejvaqbjf.bet>
Date:   Tue, 07 May 2019 18:41:10 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1904291851280.45@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 29 Apr 2019 18:52:19 -0400 (DST)")
Message-ID: <xmqqpnoulhzd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 407BE088-70AC-11E9-8F7D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> gentle ping: this patch was not picked up yet, although it should be
> pretty uncontroversial.

Thanks.  It does look it fell through the cracks without sound.
Will pick it up.
