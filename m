Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940FFC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623CA6102A
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhFQREl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:04:41 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:18767 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhFQREh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 13:04:37 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ltvPQ-0000G3-4c; Thu, 17 Jun 2021 18:02:28 +0100
Subject: Re: [PATCH] doc: warn people against --max-pack-size
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
 <YL8RfGijMY95miHI@coredump.intra.peff.net> <xmqqfsxsq1l4.fsf@gitster.g>
 <YL8bQMOAHxApjVVe@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <d73194b2-2fc9-80d3-d13c-fb5db3757e01@iee.email>
Date:   Thu, 17 Jun 2021 18:02:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL8bQMOAHxApjVVe@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/06/2021 08:24, Jeff King wrote:
> +The minimum size allowed is limited to 1 MiB. The default is unlimited.
> +Common unit suffixes of 'k', 'm', or 'g' are supported.

Do we want to include the workaround of scaling in kibibytes (as
originally mentioned by Bagas) for the default as 1024k? This also
avoids the easy mistake that the size is in multiples MiB.

Philip
