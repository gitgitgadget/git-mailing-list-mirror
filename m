Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1B01F403
	for <e@80x24.org>; Thu, 14 Jun 2018 09:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbeFNJxP (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 05:53:15 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:15710 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754709AbeFNJxN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 05:53:13 -0400
Received: from [192.168.2.201] ([92.22.47.8])
        by smtp.talktalk.net with SMTP
        id TOwIf6E64whzSTOwIfmbdB; Thu, 14 Jun 2018 10:53:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528969991;
        bh=i9bQr1/ln3O4rBwOKL74GFOF17I9+a/bRBXaCPUx6t8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VpDEh32cFW5606uqFxnJYKbnVMbUZZq/OtF9NF7ZKzIUDaNZ1jVNvVRKzgiF8YSzv
         dGzAAZw04qZvYp/tBVmkwrfNT5ZbWxTJgpFuV8vmAP5m/G/yuCkN9ZrKJBrfAIPL/5
         TKIcFtw0t6cvesUAhxYVu3vTQh4mxie/Wrqy5JFU=
X-Originating-IP: [92.22.47.8]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=E9mO5tQq/K2OXQL62Xt/1Q==:117
 a=E9mO5tQq/K2OXQL62Xt/1Q==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=nN7BH9HXAAAA:8 a=-KEEEuBjD9C8nwwiKnEA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 0/2] rebase -i: rewrite the edit-todo
 functionality in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
 <20180613152211.12580-1-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6db916e7-0c02-785f-cbf9-3f80b6452755@talktalk.net>
Date:   Thu, 14 Jun 2018 10:53:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613152211.12580-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOg6j8F/cnJdxrCbLk/loK0HFFpnsTJQ03U5BIR6QDpbj2yDpdTW1aHZVjN+A6h0keEXe4Ck+P1s4iO1Hx5L9UEqATnB4WGL8FDT8APgpwmr3478RfaN
 FZQmKPzcWQXxeb8PU+fU2HaaN9Qh7Xd7ddvSOWv1uC2NsWM9FEQHT6CeFumOfzy1nxavlLTGc0I/MgfS3nAMz+2MUJebQUDMH0OnySEp1E2+VtMxuDVCfjIb
 JE7KTg4t6O/K48wYovheAzrHh9euv77wKNFdtzL+schXSQEwozOCUSLLsy/RNm6IgVgbydwAA1Dm1/kqeF2DV8pruREI6OFQjjLEE8QYQMXCasRxvcnpTIKq
 a/nLj03wRe2Lp5ERsbwXQTXmcagZ+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 13/06/18 16:22, Alban Gruin wrote:
> This patch rewrites the edit-todo functionality from shell to C. This is
> part of the effort to rewrite interactive rebase in C.
> 
> Changes since v1:
> 
>  - Add a new function to launch the sequence editor, as advised by
>    Phillip Wood[0]

That's great, I think these look fine now

Best Wishes

Phillip

> [0] https://public-inbox.org/git/3bfd3470-4482-fe6a-2cd9-08311a0bbaac@talktalk.net/
> 
> Alban Gruin (2):
>   editor: add a function to launch the sequence editor
>   rebase--interactive: rewrite the edit-todo functionality in C
> 
>  builtin/rebase--helper.c   | 13 ++++++++-----
>  cache.h                    |  1 +
>  editor.c                   | 27 +++++++++++++++++++++++++--
>  git-rebase--interactive.sh | 11 +----------
>  sequencer.c                | 31 +++++++++++++++++++++++++++++++
>  sequencer.h                |  1 +
>  strbuf.h                   |  2 ++
>  7 files changed, 69 insertions(+), 17 deletions(-)
> 

