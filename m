Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB31F1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 19:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbcGTTaE (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 15:30:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:23884 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbcGTTaC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 15:30:02 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 6B6A3845DC;
	Wed, 20 Jul 2016 15:30:01 -0400 (EDT)
Subject: Re: [PATCH v1 0/6] Porcelain Status V2
To:	Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <20160720161543.GD24902@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, gitster@pobox.com
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <578FD0B1.9030709@jeffhostetler.com>
Date:	Wed, 20 Jul 2016 15:27:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160720161543.GD24902@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 12:15 PM, Jeff King wrote:
> One final bit of food for thought.
>
> Just yesterday somebody asked me about renewing the old idea of using a
> more standardized format for machine-readable output, like --json.
> That's obviously something that would exist alongside the existing
> formats for compatibility, and it doesn't fundamentally change anything
> about adding a new format as your patches do (it just becomes yet
> another format).
>
> However I wanted to mention it in case you are intrigued by the idea,
> and would be interested in skipping porcelain-v2 entirely in favor of
> moving to something like json.
>
> A totally reasonable response is "haha no. Please stop moving the
> goalposts". I just wanted to throw it out there as an option (and in
> case you are interested, to let you think about it before any more work
> goes into this direction).

haha no.... :-)

Short term, I'd rather nail down what I have now (both content-wise
and format-wise) and see how we like it.  And have a follow-up task
to look at the --state header we spoke of earlier.  And save the JSON
version as an independent task for later.

I understand the motivation for a JSON option (and have thought
about it before) but I think it ought to be kept separate.
At a higher-level, it seems like a JSON option would be an
opportunity to start a project-wide conversation about formats,
consistency, plumbing, and etc.  A top-down conversation if you
will about which commands will/won't get enhanced, legacy cruft
that would not need to be converted, JSON style and naming and
consistency issues, current best practices in the node/whatever
community, and etc.  I could be wrong, but this feels like a
top-down feature conversation in a wider audience.

Jeff


