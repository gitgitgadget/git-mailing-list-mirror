Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256BE1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeAXVAW (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:00:22 -0500
Received: from siwi.pair.com ([209.68.5.199]:14840 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932114AbeAXVAW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:00:22 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id ADCA7844D7;
        Wed, 24 Jan 2018 16:00:21 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 784D9844D5;
        Wed, 24 Jan 2018 16:00:21 -0500 (EST)
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Isaac Hier <isaachier@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180123001648.24260-1-isaachier@gmail.com>
 <675fa58d-bff3-d7e4-5fac-ecf1401932f4@jeffhostetler.com>
 <CAG6xkCbe+pLwTCButZGdPucHoRCq-a8mWfifd6z2bzGZNseE9A@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ee5185b1-7820-b2ac-1bde-da1c761fa594@jeffhostetler.com>
Date:   Wed, 24 Jan 2018 16:00:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAG6xkCbe+pLwTCButZGdPucHoRCq-a8mWfifd6z2bzGZNseE9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/24/2018 2:59 PM, Isaac Hier wrote:
> Jeff, no worries, fair enough. I know https://github.com/grpc/grpc
> uses a shared file to generate code for several build systems instead
> of maintaining them individually. I plan on doing the work anyway just
> because I have my own reasons to use CMake in Git (for packaging in
> https://github.com/ruslo/hunter is my main motive here). Whether or
> not it is maintained upstream is not a real concern for me at the
> moment.
[...]
> I'll see how the Windows build currently works and if that makes
> sense, maybe I'll try using that build generator here too.
> 
> Thanks for the feedback,
> 
> Isaac

Look at the "vcxproj:" target in config.mak.uname (in the GfW repo).

Jeff
