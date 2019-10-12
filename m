Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9E91F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 01:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfJLBgA (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 21:36:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58196 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfJLBgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 21:36:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EA1EA1025;
        Fri, 11 Oct 2019 21:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TQxd0tvuGNgAzmO7GCeNZkA0piw=; b=YGM2fd
        C0DMennYx09J6T9xTxsigWUWpusCNnvJtLMNTO+/gizlNHq1HXb6zdJgsCKLufbv
        kmYoS0/9A0v10+5KsRxY7sHSrBleOrOO1Mhl3ZDMY4UumY9KTT2Qe0YuYiGFcyiZ
        WMHzTCIFkry/VDWDkEIUdPUDDoBqaBX+zyV3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kk9CNhH4Huoc51LpiAPnl0mMLvv7svZI
        ruwQ/aSWaGHmTE/LZFYHJKr2oxAxvlJFPVK4QoJbPu+a+skPoehzIoVvflrDM72F
        NujatXXRt8ZzsrMYGg0Vw6c4YFaV1kuHdMLEjYmMU54qBBZyB+UoOTgOaWl03w2L
        szPXNHThUfw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2836BA1024;
        Fri, 11 Oct 2019 21:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 57F73A1023;
        Fri, 11 Oct 2019 21:35:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Maxim Belsky via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Max Belsky <public.belsky@gmail.com>
Subject: Re: [PATCH v2 1/1] doc: Change zsh git completion file name
References: <pull.367.git.gitgitgadget@gmail.com>
        <pull.367.v2.git.gitgitgadget@gmail.com>
        <3f994f3b9a49c42bb8b605459817e54479327dc7.1570816467.git.gitgitgadget@gmail.com>
Date:   Sat, 12 Oct 2019 10:35:53 +0900
In-Reply-To: <3f994f3b9a49c42bb8b605459817e54479327dc7.1570816467.git.gitgitgadget@gmail.com>
        (Maxim Belsky via GitGitGadget's message of "Fri, 11 Oct 2019 10:54:28
        -0700 (PDT)")
Message-ID: <xmqqwodaeoee.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A24A9E8E-EC90-11E9-9286-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Maxim Belsky via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>

No need to resend (as I'll fix it up locally while queuing), but
your sign-off comes last, as we keep these things chronological.
With help from others, you wrote the patch and finally signed it off
to be applied.

Thanks for working on this.
