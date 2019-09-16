Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406161F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbfIPU5S (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 16:57:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55548 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIPU5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:57:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EC9F29011;
        Mon, 16 Sep 2019 16:57:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=yoAAGthy6AwFqZ93lDbBa306b+Q=; b=RsCnHc
        lAmH2ioLbyXnylNqBonrWkh49LOrhyge0iBIPO0oDrxauND/nz9H+SMPh3JWMDoc
        KeiYmivd070Rrn6XWU77VE9oeKb0SnnftCgLKiyikvmfGW9pZr4U9IpRVq4rr3jB
        ng6rUDNUlUmx9p5wmlg8ZWxgT9ctBARlR9AmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xWE3JLl4eagmcD/P1W2HQtDOBEfVvWXl
        rX+FGRcELUqZbG5iaX50F/McPuEUeD2NbQTw3b9azQrYeKuZ8L3eBuEzmCMV7Cco
        wqXW6ZRQRUMARiEUMlDUc1vMczge2NRyQqShjbb0AliuzqDqN89L2lMBOFBIHsun
        IK91ey3uf4A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33B2B2900F;
        Mon, 16 Sep 2019 16:57:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77DB02900E;
        Mon, 16 Sep 2019 16:57:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Makefile: run coccicheck on all non-upstream sources
In-Reply-To: <cover.1568661443.git.liu.denton@gmail.com> (Denton Liu's message
        of "Mon, 16 Sep 2019 12:23:03 -0700")
References: <cover.1568309119.git.liu.denton@gmail.com>
        <cover.1568661443.git.liu.denton@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date:   Mon, 16 Sep 2019 13:57:14 -0700
Message-ID: <xmqqh85c9cyd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9025BB56-D8C4-11E9-A426-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Queued; thanks.
