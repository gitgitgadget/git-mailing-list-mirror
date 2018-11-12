Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BA21F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 03:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeKLNqC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 08:46:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51214 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeKLNqC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 08:46:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56476109FDE;
        Sun, 11 Nov 2018 22:54:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ldDJlCKyCl8ZUzivOI/aFKXOCy4=; b=wwYA1M
        9AKN0BZIpDCe2rUxiTFszgoUMpSpqyRFpnmo2Hh8pI/aZfqXLiAXOC5ycdmyNM26
        CC0urj6i6eDaaCqmcdTjXm68O703nxzebdw43nTozk/Vsu+9y8iw156ziq+3b+Pe
        n7ZkDLodh27UaJYorNDKUpeJBTmQ8Ui2P3gNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z3YNFOdDQZEZdAOe4XndJOzPr8ZEvZLF
        1aQKZ0c1rGd+JIZbLBCGDApbXoJ2kasO9wK2tTipSE8t6nbwGitA/9QkFdab33AZ
        YMRf2n6iYMydLiy10EuyLV0ZJQ4icMCNFMeaYm6l34+vXzJ3++aQZWquYqik+w8s
        DT2D20/Cusg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FAC9109FDD;
        Sun, 11 Nov 2018 22:54:44 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD69C109FDC;
        Sun, 11 Nov 2018 22:54:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] Update .mailmap
References: <pull.71.git.gitgitgadget@gmail.com>
        <pull.71.v2.git.gitgitgadget@gmail.com>
        <c121ebc47428077ec30fd6f0c724fd99f81387f6.1541763071.git.gitgitgadget@gmail.com>
Date:   Mon, 12 Nov 2018 12:54:42 +0900
In-Reply-To: <c121ebc47428077ec30fd6f0c724fd99f81387f6.1541763071.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 09 Nov 2018
        03:31:14 -0800 (PST)")
Message-ID: <xmqq7ehj3q7x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B070E608-E62E-11E8-A37B-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This patch makes the output of `git shortlog -nse v2.10.0..master`
> duplicate-free.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks, will queue.
