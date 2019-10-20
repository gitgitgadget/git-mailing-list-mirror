Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D671F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 19:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfJTTyk (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 15:54:40 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:35332 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfJTTyk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 15:54:40 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46x9TQ5YJZz5tlB;
        Sun, 20 Oct 2019 21:54:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 69C581CFC;
        Sun, 20 Oct 2019 21:54:33 +0200 (CEST)
Subject: Re: [PATCH v3] userdiff: Fix some corner cases in dts regex
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     git@vger.kernel.org, Adrian Johnson <ajohnson@redneon.com>,
        Junio C Hamano <gitster@pobox.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20191020185230.212875-1-sboyd@kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <21271a81-5273-ad8e-be06-7a2242aa57cf@kdbg.org>
Date:   Sun, 20 Oct 2019 21:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020185230.212875-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.10.19 um 20:52 schrieb Stephen Boyd:
> --- /dev/null
> +++ b/t/t4018/dts-nodes-multiline-prop
> @@ -0,0 +1,13 @@
> +/ {
> +	label_1: node1@ff00 {
> +		RIGHT@deadf00,4000 {
> +			multilineprop = <3>,
> +					<4>,
> +					<5>,
> +					<6>,
> +					<7>;

There is little variation in the lines, but if that is what occurs in
real life, so be it.

This patch is good. Thanks!

Reviewed-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
