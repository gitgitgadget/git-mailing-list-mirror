Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C667DCD5BBF
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 13:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjISNeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjISNeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 09:34:15 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1AFEC
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 06:34:08 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CBFE4CA127F;
        Tue, 19 Sep 2023 09:34:07 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:fd89:af42:bea6:fd68] (unknown [IPv6:2600:1700:840:e768:fd89:af42:bea6:fd68])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 95F69CC8376;
        Tue, 19 Sep 2023 09:34:07 -0400 (EDT)
Message-ID: <7356bb25-12aa-dc6a-9b32-87d13c49994c@jeffhostetler.com>
Date:   Tue, 19 Sep 2023 09:34:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/8] fsmonitor unused parameter cleanups
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
References: <20230918222908.GA2659096@coredump.intra.peff.net>
Content-Language: en-US
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <20230918222908.GA2659096@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/18/23 6:29 PM, Jeff King wrote:
> Here are a few cleanups of the fsmonitor code to remove or annotate
> unused parameters (working towards my goal of making us compile clean
> with -Wunused-parameter). I think they should all be pretty
> non-controversial, but I'm cc-ing folks active in the area in case patch
> 2 steps on the toes of any unpublished works in progress.
> 
>    [1/8]: fsmonitor: prefer repo_git_path() to git_pathdup()
>    [2/8]: fsmonitor/win32: drop unused parameters
>    [3/8]: fsmonitor: mark some maybe-unused parameters
>    [4/8]: fsmonitor/win32: mark unused parameter in fsm_os__incompatible()
>    [5/8]: fsmonitor: mark unused parameters in stub functions
>    [6/8]: fsmonitor/darwin: mark unused parameters in system callback
>    [7/8]: fsmonitor: mark unused hashmap callback parameters
>    [8/8]: run-command: mark unused parameters in start_bg_wait callbacks
> 
>   builtin/fsmonitor--daemon.c             | 10 ++++++----
>   compat/fsmonitor/fsm-health-darwin.c    |  8 ++++----
>   compat/fsmonitor/fsm-ipc-win32.c        |  2 +-
>   compat/fsmonitor/fsm-listen-darwin.c    |  4 ++--
>   compat/fsmonitor/fsm-listen-win32.c     | 24 ++++++++++--------------
>   compat/fsmonitor/fsm-path-utils-win32.c |  7 ++++---
>   compat/fsmonitor/fsm-settings-win32.c   |  2 +-
>   fsmonitor-ipc.c                         | 10 +++++-----
>   fsmonitor-settings.c                    |  3 ++-
>   t/helper/test-simple-ipc.c              |  3 ++-
>   10 files changed, 37 insertions(+), 36 deletions(-)
> 
> -Peff

LGTM

Thanks,
Jeff
