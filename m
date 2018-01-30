Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69F21FAE3
	for <e@80x24.org>; Tue, 30 Jan 2018 20:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeA3Uyg (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:54:36 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:1032 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752175AbeA3Uyg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:54:36 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zWJXT4gJgz5tl9;
        Tue, 30 Jan 2018 21:54:33 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E9110143;
        Tue, 30 Jan 2018 21:54:32 +0100 (CET)
Subject: Re: [PATCH 00/37] removal of some c++ keywords
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
References: <20180129223728.30569-1-bmwill@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <cd708bfc-6f92-18d8-9121-ed413748f14a@kdbg.org>
Date:   Tue, 30 Jan 2018 21:54:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.01.2018 um 23:36 schrieb Brandon Williams:
> A while back there was some discussion of getting our codebase into a state
> where we could use a c++ compiler if we wanted to (for various reason like
> leveraging c++ only analysis tools, etc.).  Johannes Sixt had a very large
> patch that achieved this but it wasn't in a state where it could be upstreamed.
> I took that idea and did some removals of c++ keywords (new, template, try,
> this, etc) but broke it up into several (well maybe more than several) patches.
> I don't believe I've captured all of them in this series but this is at least
> moving a step closer to being able to compile using a c++ compiler.

Cool! The patches all look reasonable. Some keywords remain: 'delete', 
'private', 'thread_local', 'not', 'xor', 'explicit', 'export'.

> I don't know if this is something the community still wants to move towards,
> but if this is something people are still interested in, and this series is
> wanted, then we can keep doing these sort of conversions in chunks slowly.

I've rebased my patches on top of this series. They are available from

   https://github.com/j6t/git.git c-plus-plus

-- Hannes
