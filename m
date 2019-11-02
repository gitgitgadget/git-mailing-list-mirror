Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E251F454
	for <e@80x24.org>; Sat,  2 Nov 2019 04:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKBESG (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 00:18:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60882 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKBESG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 00:18:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE00C9BC92;
        Sat,  2 Nov 2019 00:18:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DZCYI3lASTtdhyeoQdmMBkhDyZI=; b=YadTkF
        uoThJ3xVqSwbkdzjtUsOBo7yTORe5YcSu+BjvfGmn4BQqWlb4lo0P4tVMm8a3EFr
        cZ/LCssVUJ+lCM3GSdzDMIwt1Pia4BZ00bCon5sBRrbcaSnpB9BmAlePZcF7Z+3x
        tJJyGANoIFUzhgHnp6saG1xvNYL3rDzr8tRKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L97EdKsra1a0kB0mLIILcEavwkWf0ARW
        5CDX2DtqC/rCcXrFBMHUQTO+8M4Vq4G6bibxkZbDVqDi7g7dkNuVqoqi2428N9X4
        PyYCgB7bTXeX9vK0QDt0HyMvb7sna5FR5ILYXMa1Z5XCpfFCmNJiicxOP0tILVGK
        w1ckT/E3vZw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D84C79BC91;
        Sat,  2 Nov 2019 00:18:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 005B29BC7D;
        Sat,  2 Nov 2019 00:18:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] git-diff.txt: document return code of `--no-index`
References: <ed9f16c30a0f3852abaf0053d8c2b4a0ecd12f01.1572367897.git.liu.denton@gmail.com>
        <381b2ca134ffa2f370c3882631dbaf3d591530dc.1572458622.git.liu.denton@gmail.com>
Date:   Sat, 02 Nov 2019 13:17:59 +0900
In-Reply-To: <381b2ca134ffa2f370c3882631dbaf3d591530dc.1572458622.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 30 Oct 2019 11:06:07 -0700")
Message-ID: <xmqq4kzm6he0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C27FBCF0-FD27-11E9-BEE3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Add a note about how `--exit-code` is implied in the `--no-index`
> documentation to cover this documentation blindspot.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> Thanks for catching the typo, Phillip. I can't believe I missed that in
> such a simple patch.

Thanks all.  I can believe that I missed that while reading v2 ;-)
I'll try to do better next time.

Queued.
