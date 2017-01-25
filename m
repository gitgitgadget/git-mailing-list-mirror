Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D0E1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbdAYWvP (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:51:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51370 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751683AbdAYWvO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:51:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F68264231;
        Wed, 25 Jan 2017 17:51:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vLhkJhD74ZEpcDN8+6unz6aOISw=; b=c5nOgN
        cc9txof+cjxr+HB8w2iYNGwVX2rhJdSzOkGXMvkyYDswrTy+x7/+ZSIh6Bkut5eH
        9zRv6aFTCGy+WdOInfLHIPhXsXC6Y4Eun8Rv4OJNzmDU2qzhmS4BV6nCKtH36Vu1
        UlzbIE+C6mvlBlQyg6zRPZ79EsIzWVGByiJio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SYC3/H1EB70ASvoPm/F5lDaPil5DlM0/
        y1uCo35Z2ZONElUAiUZBM5YlV7dRaB1ZYfQ8VKcsF7SKBU0o0Pi6uhsKUvX1KN2p
        BqiT4VytKcy5Ddr6mvbUDFONqy4vMtt6E8Var4gqjwg0rh0oUBC76P4vbwBGaN3I
        wmwrPmt9OzA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95A0E64230;
        Wed, 25 Jan 2017 17:51:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E67BD6422F;
        Wed, 25 Jan 2017 17:51:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
        <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com>
        <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701251800120.3469@virtualbox>
        <20170125173958.pg546a6w33dirp5k@sigill.intra.peff.net>
        <xmqq4m0nc8dz.fsf@gitster.mtv.corp.google.com>
        <20170125183924.6yclcjl4ggcu42yp@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 14:51:11 -0800
In-Reply-To: <20170125183924.6yclcjl4ggcu42yp@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 25 Jan 2017 13:39:24 -0500")
Message-ID: <xmqq7f5i92jk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C55F52C6-E350-11E6-A89D-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I guess the way to dig would be to add a test that looks at the output
> of "type mv" or something, push it to a Travis-hooked branch, and then
> wait for the output

Sounds tempting ;-)
