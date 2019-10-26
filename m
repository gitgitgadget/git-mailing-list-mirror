Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A792B1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 08:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfJZICE (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 04:02:04 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:5512 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJZICE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 04:02:04 -0400
Received: from [84.131.35.253] (helo=[192.168.2.6])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iOH1L-0002YV-8x; Sat, 26 Oct 2019 10:01:59 +0200
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com>
 <pull.407.v2.git.1571755538.gitgitgadget@gmail.com>
 <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com>
 <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet>
 <20191025221118.GA29213@sigill.intra.peff.net>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <da6420c7-205e-c73c-8397-ab5d4b1a6663@syntevo.com>
Date:   Sat, 26 Oct 2019 10:02:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025221118.GA29213@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26.10.2019 0:11, Jeff King wrote:
> Yeah. As the person responsible for many of the "avoid truncation" works
> referenced in the original patch, I have come to the conclusion that it
> is not worth the complexity. Even when we do manage to produce a
> gigantic error message correctly, it's generally not very readable.
> 
> That's basically what I came here to say, and I was pleased to find that
> you had already argued for it quite well. So I'll just add my support
> for the direction you've taken the conversation.


Thanks! Truncation, then :)
