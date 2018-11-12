Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532EE1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 08:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeKLRzt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 12:55:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61863 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeKLRzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 12:55:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B262F10B704;
        Mon, 12 Nov 2018 03:03:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8WeI6nRibNaS
        FMFYMEyzg3EVC+A=; b=rCnnnSRAq8ARYZOsyoKQJQ+9Bi6H3cRDiF+Qbmo2cTLS
        PUhlr/oYWRTnu4jREDHXOanB5uiVL1boAq2/1ebx4Qu1bNwIInCAJJd1FtdAD9LF
        gddSxa3fA8c21p+WEhDTkv3PkPntpCDN9asUKFOp4GDrBKYk7PrBvwHBVP0EHdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RkWxF6
        t9LAS4FlhPOMhWZ4qM5f2T7h0S8JDmGmWSt9FgLoGi2EZ1Sz6/qFLB/r8B6hXJ+K
        bI1/2Q0UP/2ly3/5zeqqZEiVpxXyQQ+BxbF5n1vfuNQA0Xckysb8oAQlpqKzU4my
        rBL4PpVUdr1vt9gBVJAqOIHCkbVsc1UeTuc2Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A94B210B703;
        Mon, 12 Nov 2018 03:03:43 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 209EE10B702;
        Mon, 12 Nov 2018 03:03:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] remote-curl.c: xcurl_off_t is not portable (on 32 bit platfoms)
References: <20181025161310.29249-1-tboegi@web.de>
        <20181109174110.27630-1-tboegi@web.de>
        <xmqqbm6v3qex.fsf@gitster-ct.c.googlers.com>
        <20181112052039.GA12275@tor.lan>
Date:   Mon, 12 Nov 2018 17:03:42 +0900
In-Reply-To: <20181112052039.GA12275@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Mon, 12 Nov 2018 06:20:39 +0100")
Message-ID: <xmqqy39y204h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 78FDE9FA-E651-11E8-BA10-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks, is there a chance to kill a typo here ?
> s/comopared/compared/
> - A temporally variable "size" is used, promoted int uintmax_t and the =
comopared

Done.  Thanks.
