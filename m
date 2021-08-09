Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86F8C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 14:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9016F61004
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 14:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhHIOiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:38:23 -0400
Received: from siwi.pair.com ([209.68.5.199]:44313 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233992AbhHIOfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 10:35:21 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 908043F40E6;
        Mon,  9 Aug 2021 10:34:40 -0400 (EDT)
Received: from DC-2021.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 66EA33F40DA;
        Mon,  9 Aug 2021 10:34:40 -0400 (EDT)
Subject: Re: [PATCH 0/2] fsmonitor: fixup to avoid warnings from pedantic
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com
References: <20210809063004.73736-1-carenas@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <42dce285-9599-4c7c-d351-44c1e338337e@jeffhostetler.com>
Date:   Mon, 9 Aug 2021 10:34:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210809063004.73736-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/9/21 2:30 AM, Carlo Marcelo Arenas Belón wrote:
> seen with both clang 12 and gcc 11 in seen (including jh/builtin-fsmonitor)
> as of a5a42b9f76 (from Jul 1)
> 
> it should be squashed into the corresponding patch from the series as shown
> in the subject and reroll IMHO; notice Junio also has some bandaid sparse
> fixes for t/helper/test-touch.c that should be included.
> 
> a similar additional fix for C89 compatibility to be send as a reply later
> 
> Carlo Marcelo Arenas Belón (2):
>    fixup! fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>    fixup! fsmonitor--daemon: implement handle_client callback
> 
>   builtin/fsmonitor--daemon.c | 2 +-
>   fsmonitor-ipc.h             | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 

Thanks!
Jeff
