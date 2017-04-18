Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68DED1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 03:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755270AbdDRDRj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 23:17:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61546 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754392AbdDRDRi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 23:17:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D97F758DD;
        Mon, 17 Apr 2017 23:17:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FZzbw+X101jFbrDGMgAQed0F4R0=; b=Ev0Ykj
        3MESOyttvpSgZpue4VP4zg4js5AtFQH/Qal5IpVeRxj37uutDMGuchYE+OcG9Da9
        ZcDpiDezvpcIrAkcHx1rRDqzTxslydcbr6R3XsdER1mq4M6+VlNoH/q6W5Y/yQZk
        rbgxPL6iU+SjnUk8Onkcwu3Yhg22vvW745fdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qjFiFkmApQZdNKNDXdFnJMD6GTFmufV6
        jScacKF+u8wiSl12bmKyQiTnfzH36Qmc085sHYSasPNawriYw5ZWkQxisLiCls8d
        W+jUQse9rR83f+k9plRQ5J6TkSY1wHw3eyO0N3lmbxdVoXUZ25JYsfLB/Y4j+UMH
        x+Lsa8g7zfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 061CB758DC;
        Mon, 17 Apr 2017 23:17:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 711B0758DB;
        Mon, 17 Apr 2017 23:17:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] config: handle conditional include when $GIT_DIR is not set up
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
        <20170416104125.15300-1-pclouds@gmail.com>
        <20170416104125.15300-2-pclouds@gmail.com>
        <20170416155131.ppp5iakohiiphzmk@sigill.intra.peff.net>
        <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
Date:   Mon, 17 Apr 2017 20:17:35 -0700
In-Reply-To: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 17 Apr 2017 17:07:52 +0700")
Message-ID: <xmqqvaq2flps.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9229872A-23E5-11E7-8FEF-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> (To Junio, this series conflicts slightly with
> nd/conditional-config-include, let me know if you want me to rebase
> this on top of that)

I think I can manage---having to resolve inter-topic conflict every
once in a while is a good sanity check for me anyway ;-).  Please
holler if my resolution is faulty when I push things out tonight my
time (note: I'll be operating in GMT+9 for coming weeks).

Thanks.
