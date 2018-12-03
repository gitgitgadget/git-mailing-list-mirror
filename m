Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1F4211B4
	for <e@80x24.org>; Mon,  3 Dec 2018 21:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLCVyi (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 16:54:38 -0500
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:49948 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbeLCVyi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Dec 2018 16:54:38 -0500
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-11v.sys.comcast.net with ESMTP
        id TrtdgpaA06Xm0TwAngf06U; Mon, 03 Dec 2018 21:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1543874077;
        bh=Qc8XwpIEiaf/v21w3EMxVE0rEMsYTj+C3wRhJSHdOXs=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=F21dgAvmHmVECjRuquZ5eAUzbZY7sBQ3FPDvt1YUxHB265zY4DWRtz2j5fb7rO4gi
         ZQMiNUBQFMznz6nLA+ofmYz2dXnO6zeXwt9k3awat1/ZJBPfxymsvx8GDHU5+nShKj
         T2tqL2NZ4vPDEujEtjYaQ+KJrwpUDWPKUkkXxqqs7K0GRUyZFu92frw7n5fxwRAvMm
         C8diJyd6CzS4tNF47wwBsFZO5q1/pPUmLMU1l0/zsKfZtZAMGY+zJkwzgmHN60dznO
         g9u7lpL7hVZ125ZXXPt+uYETSU0iXTVFhYJ0mRltS7q/nxJlPjmMJIsRfZphqMC5qb
         FPbGm7xoO5CLQ==
Received: from maqtu.svl.corp.google.com ([IPv6:2620:0:100e:913:aa8d:64ee:3bb6:179])
        by resomta-ch2-01v.sys.comcast.net with ESMTPSA
        id TwAPgvqIFHzYDTwAUgjgSk; Mon, 03 Dec 2018 21:54:35 +0000
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is
 allowed
To:     Jeff King <peff@peff.net>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com
References: <cover.1540256910.git.matvore@google.com>
 <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
 <20181121164019.GA24621@sigill.intra.peff.net>
 <19c82fb0-e0d6-0b15-06ab-cfba4d699d94@comcast.net>
 <20181201194424.GB28918@sigill.intra.peff.net>
 <80a08b99-14cb-e398-e6c2-2aa94a5fdda3@comcast.net>
 <20181203211555.GA8700@sigill.intra.peff.net>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <4c32ed9f-0882-c454-f136-bf98840a44da@comcast.net>
Date:   Mon, 3 Dec 2018 13:54:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181203211555.GA8700@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOE6spv5VHgrDvwwlI58ho5JcILB30JY0xw4r55n1PQvdEukVQnbnN5vHpTOCXdHWJIFyAdx4KTZqWJX3/mKypHzgTEOC8AOBDhigTqlm9eEJJ9bGT7W
 +FabpckRe5QGoSYvnbeFZ3uv2FZt3DIlUYigtiVz5/Mggv2+QlbzpKqNYrkNQTk3/2IRjMCZGZZ4horY25PU6tdcanVlzCzJKp5CMHAXrrQfRBbQvRuwyuPX
 nzLnBnc5Y1azlRDAyPJjsRF4IQwZwZg99tP4s7Ca8/Zv2TZwlK77dGbDiWmgzGDzX0RgVMVetwugqSm9uGG5vD/9SjhHCM5NeypN/ufDZcNnt/OK4RdMPAs7
 XRayepRthbxkK1UCZ1xJIxGYVSvDp7800mni8n5JfDWRqaRa13Bu5DQ7NAC9Q2sppv7yzCzF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/2018 01:15 PM, Jeff King wrote:
> That said, our C99 designated initializer weather-balloons haven't
> gotten any complaints yet. So I think you could actually do:
> 
>    struct setup_revision_opt s_r_opt = {
> 	.allow_exclude_promisor_objects = 1,
>    };

I like this way best, so I'll use it. Thank you.
