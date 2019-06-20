Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57DD1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfFTHlS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:18 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:14665 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfFTHlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:17 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45Ttzb2D5Pz5tlC;
        Thu, 20 Jun 2019 09:41:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6F35A143;
        Thu, 20 Jun 2019 09:41:13 +0200 (CEST)
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
To:     Jeff King <peff@peff.net>
Cc:     Boxuan Li <liboxuan@connect.hku.hk>, git@vger.kernel.org,
        gitster@pobox.com
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
 <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
 <20190619034929.GA515@sigill.intra.peff.net>
 <1da78555-96eb-1206-679b-527911f6af29@kdbg.org>
 <20190619183931.GA28145@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1db4a03e-5bc2-673d-6d89-bf654b785129@kdbg.org>
Date:   Thu, 20 Jun 2019 09:41:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619183931.GA28145@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.19 um 20:39 schrieb Jeff King:
> But without that, I have to wonder what problem we are really solving.

You have a point here.

> Now it's baked into the binary. Later it will be baked into the
> distribution, but we still don't want anybody to touch it because their
> changes will be overwritten.

Having the patterns outside the binary reduces our mental barrier to
accept additional patterns or slightly modified patterns for new file
types, like we had recently for octave that are just a small extension
to the matlab patterns.

But we are not solving a technical problem or a problem our users have,
AFAICS.

> I guess it's a little easier for somebody
> to find .../share/git-core/userdiff and use it as a template than it is
> to find the definitions in the source. But it's not exactly easy.

Having a slightly easiser to discover database may count as an advantage. ;)

-- Hannes
