Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A867D1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 18:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbcJESrf (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 14:47:35 -0400
Received: from mout.web.de ([217.72.192.78]:50926 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752015AbcJESrf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 14:47:35 -0400
Received: from [192.168.178.36] ([79.213.121.94]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M25B9-1b3auy1f91-00tyFN; Wed, 05 Oct 2016 20:47:27
 +0200
Subject: Re: [PATCH 0/18] alternate object database cleanups
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <62a7966c-fe98-f987-db10-3fc3b5f4b7e6@web.de>
Date:   Wed, 5 Oct 2016 20:47:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:impEKtfLq8GAq0td37t/1/Sodin34HHHAMyRpVbOCT05jAxqkOl
 E4fIsnSsMpHLlMIuyjMcWIuATOdkYQIYv0HSOaQ/DScRFW5lzmwx+XdTT6+d/BTofkkqexl
 IlOqT6HqaTtWl8kFwRkPjHHbWI1sGQHA8h4BaRXDMRPfZiEbiQ3QV2VNpsyr28D2r2HbUBK
 beY5SdzfsE5zHBgPUK4Eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PUkhVvllW/o=:yuI81nloYTs62I1mmpzUTq
 BnNdh4l7CnL8OpkmS8rPMa8pQLCemcWu+z5ILmqwVuouQoJO2jWMuB+jpuDr7soS/fA8//b1l
 VsqVOUr5jQR8n1LJ8aJ0J4OsbhMBvzF23FuIAzJSWQAo+tLE87v9AMtTXCoNjI/FPlIm3fIQu
 0sTyhmk1+S2Y0L4dxTMLBCPdDHdxZl0bFw9E7BRV9JAOE6aA2JLGxRvGDRMb+oXqfoW3a5mBp
 z/EcVf0jmaxQsG/v+J1hbqpGQwURm/ziPlDuJ2zbtFrEJqcCQwZJBhfUwk/JVVRjFpY5hNbx3
 ++GdUmyPR9pOgUqW022CAdmTuCec1gZPlaT59XMGpXOFzaxeNcrvFWLK+p8uUXs73DkGi+sy2
 9xCOaLiH+uQ3mS0bUlG9bylhucg0Z8KvyR/3BtMleptdYF+ztmhpoXM+LS2GtiVOKWOcycjrl
 ldEXTwv1fYcxM3bpobBNVBPjPMm06n1tDH/zicRIeORoeTjgsohb86NmFFeNUKe04gWmJ6un1
 dxzrHtzEaxj+X5zOteLv6G+YO4W79OX9t4LD7YgChR5RfoBs0l8eZnEBuUzdj3g/5IC2a/XtU
 VdlIW/aRzv9Gkcvk4T1TBuhPrg8+ISu0MaIz4DqF9iXWMNc6/y+ZlEhj5e0TkD/v+nCzYMr6m
 jq9sQ7ojmEVzJmuHiquQvi5IJg1FRLrxRoZ7Q3eixrJycvej239YAsk27Vb51bUt0NnOb/y8R
 SikDGIaHQS1fiIQth6giutouSnH7Gt/hacLoRRdVMIt9rL7V65o25zuX/oLZRAPMPT6BhZ5wV
 +5WDsb6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.2016 um 22:33 schrieb Jeff King:
> This series is the result of René nerd-sniping me with the claim that we
> could "easily" teach count-objects to print out the list of alternates
> in:
>
>   http://public-inbox.org/git/c27dc1a4-3c7a-2866-d9d8-f5d3eb161650@web.de/

1. Send crappy patch
2. ????
3. PROFIT!!!

Sometimes it works. :)

Thank you!
René
