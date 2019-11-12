Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D615A1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 04:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLERe (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 23:17:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54362 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKLERe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 23:17:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E54E20E99;
        Mon, 11 Nov 2019 23:17:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xSXPzYznSJ3VG4eJRzSZo5qi8yI=; b=gCdu4D
        oqZ6aRpnNw8HK4E4rd13wK3MtpnDx9VW/V1an64s2U0g1QiE/kOYEQXYcWH/rPuI
        SgVvAeu3spKHGjhW1wHh/yuOs1VHCE+puft/+8vI3hmCho36B2bjs7fD+Ra+KCzJ
        UxfFg8fHUnA6+wGjTVBw9TIkSosjOT6Txo434=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uWLzq3bwn+mRLXI84DTQCoRlqIce1AvF
        6pUcMB9gewzoaz2cG/XZ6fpu/tRciryYWD3ByoNnRLAvEqdHii/7+6LAWgZOhlIJ
        Qbhnc9d2cuWyAkfHDd/5EW/01HqFZEgkQqAW/YpKUn99zaEzpZ1nsj9++TrMd/Hb
        N9tsRftLZnk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3569A20E98;
        Mon, 11 Nov 2019 23:17:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B3FA20E97;
        Mon, 11 Nov 2019 23:17:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v6 9/9] sequencer: fallback to sane label in making rebase todo list
References: <20191031092618.29073-1-congdanhqx@gmail.com>
        <cover.1573452046.git.congdanhqx@gmail.com>
        <78daf050de8c0cdc81fed4adc8fef92d1768c63a.1573452046.git.congdanhqx@gmail.com>
        <nycvar.QRO.7.76.6.1911111923060.46@tvgsbejvaqbjf.bet>
Date:   Tue, 12 Nov 2019 13:17:30 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911111923060.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 11 Nov 2019 19:26:39 +0100 (CET)")
Message-ID: <xmqq5zjphgo5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5887DEE8-0503-11EA-9E67-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Having said that, I think that the solution proposed over there is more
> complete, and maybe even more robust (nothing in your patch prevents
> `label-<hex-oid>` to _already_ having been taken by another label).

Good thinking.  Let me drop this last one from the series in the
meantime.

Thanks.
