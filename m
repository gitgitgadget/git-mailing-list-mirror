Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB2EC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDACB6198E
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCVKfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:35:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:17778 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhCVKfo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:35:44 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E67B43F4090;
        Mon, 22 Mar 2021 06:35:42 -0400 (EDT)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BD3953F404F;
        Mon, 22 Mar 2021 06:35:42 -0400 (EDT)
Subject: Re: What's cooking in git.git (Mar 2021, #06; Sat, 20)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqzgyxijy6.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5483d00b-cf54-05cd-0b40-8bc48f1868f4@jeffhostetler.com>
Date:   Mon, 22 Mar 2021 06:35:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgyxijy6.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/20/21 5:39 PM, Junio C Hamano wrote:
> 
> * jh/simple-ipc (2021-03-15) 13 commits
>   - SQUASH??? CALLOC_ARRAY()
>   - t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
>   - simple-ipc: add Unix domain socket implementation
>   - unix-stream-server: create unix domain socket under lock
>   - unix-socket: disallow chdir() when creating unix domain sockets
>   - unix-socket: add backlog size option to unix_stream_listen()
>   - unix-socket: eliminate static unix_stream_socket() helper function
>   - simple-ipc: add win32 implementation
>   - simple-ipc: design documentation for new IPC mechanism
>   - pkt-line: add options argument to read_packetized_to_strbuf()
>   - pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
>   - pkt-line: do not issue flush packets in write_packetized_*()
>   - pkt-line: eliminate the need for static buffer in packet_write_gently()
> 
>   A simple IPC interface gets introduced to build services like
>   fsmonitor on top.
> 
>   Expecting an update for SQUASH???
> 

I've squashed in the CALLOC_ARRAY change and resent the series as V7.

Thanks
Jeff
