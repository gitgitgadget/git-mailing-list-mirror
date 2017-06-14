Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0206520401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbdFNKSN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:18:13 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:23684 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbdFNKSM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:18:12 -0400
Received: from [192.168.2.201] ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id L5NKdvC5b9tMzL5NKdjKOp; Wed, 14 Jun 2017 11:18:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497435491; bh=ZdElJDD/fS3049975BBxaNj9disIpHSDlHXUCphTp4o=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=elHMDGFRd1pCr/kDuLZqpTx3mS9F8ZwJwKus7UaVV/+YTVhYfSa96I3YQn4MuDOc4
         DADLzlSLhJnH+TWMdB1z2Q2Mo0kA6xqsJ5vVwpeUUM5cVE1PY0v+C/7goFNzHKxGnh
         spETY52DpxH8ksUc6asewW0zWSKQWf8CXgZVPOnM=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=WOE9ZTkR c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=9K8dpytg-LWxa6SWud4A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] rebase: Add tests for console output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <5309bbe7-edd8-0c34-82ff-c3162d7d9e66@talktalk.net>
 <xmqqr2yt5d4g.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <699c6d43-4c1b-d3c2-3b01-8925f5c21511@talktalk.net>
Date:   Wed, 14 Jun 2017 11:18:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqr2yt5d4g.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJt1P+VQNW+yONCmNFobwFmzf9hd+vXAkZTJpn4kEpc/jfLLqFBSr8MxsAvIM57Z8zr0RjzsD4lS5vHG6meuvG/xBlH/grIKh+djsuY0JtyxZoVk6Vdo
 yileww3Faj6jd1oaiwcC3k1UBUxIoV5mGArUnAKkU9PnKojFLubevldcDNL+ARcEdc4ZnEFhU/ha4YCotngsJi3+vhE5cuZCW8mlS4wQDqi8q4J30qTtntAJ
 LTP9zkF4GEe+8GYvwVmjtaGCvGqHOiEqWPtslhGPY7A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/17 17:39, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> I'm confused by this as my script does not use the escape sequence "\r"
>> out of portability concerns. It has a literal carriage return as you get
>> from typing Ctrl-Q Ctrl-M in emacs or Ctrl-V Ctrl-M in bash ...
> 
> I think the worry is that some implementations of sed may be unhappy
> to see these raw control characters in the sed script.
> 

Ah, I'd misunderstood the problem, thanks for taking the time to point
that out. I'll redo the tests as Johannes suggested

Thanks

Phillip
