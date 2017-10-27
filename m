Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5321FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbdJ0PNJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:13:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:53574 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbdJ0PNH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 11:13:07 -0400
Received: from virtualbox ([2.247.243.12]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIhDo-1eAIB71GBc-002IVP; Fri, 27
 Oct 2017 17:13:05 +0200
Date:   Fri, 27 Oct 2017 17:13:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] fsmonitor: Don't bother pretty-printing JSON from
 watchman
In-Reply-To: <alpine.DEB.2.10.1710251722310.9817@alexmv-linux>
Message-ID: <alpine.DEB.2.21.1.1710271712020.6482@virtualbox>
References: <20171020011136.14170-1-alexmv@dropbox.com> <6887851348e177728849964cc95ae783b0feb971.1508461850.git.alexmv@dropbox.com> <alpine.DEB.2.21.1.1710201459020.40514@virtualbox> <c43315f3-4155-6b07-bde2-5855dceacf80@gmail.com>
 <alpine.DEB.2.10.1710251722310.9817@alexmv-linux>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KxGcvHunHfITa3mID24XsJDgbFmqanAG/jvgZfl3o45VxooB+Sq
 ILiL7n+5mSG81YHA0Md7bLXVVG4nVwLP4Iph9cDws/S1baMlLK0WI7UCdaHoxKt4ITZ806L
 5NLtFn5rwfCcnSDPal4PFllcb85QNd9Z7/bHbZg4WlCv8CLRv0NSv18pISWN0AGttd7T+XX
 qtcr8z7o8psKTki/SOrHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8vrgUhS4yS4=:zSMhJMSQiBnhhxK2L43bqY
 ukZEdNOO9QMqh7kh/R8Tu1Yh02CgYEPI9CDdNKEN9C1yyme3b9kdkGt12hCRWpZfPUH8vZWbc
 V7RrZP1oTKTcfwcbRuUkbZMFYTvLNB4jdHgxRIKrr9YFI13lAmDtDdwDkTlmSU/Da+wKTMdTE
 H5NQATFUMsqQbyiMqB7xpIJTOTboQfM4YXu9a/TwMNFZrdFILTweNnzfKnFWWS8Q6qlVRjL7G
 SoioMtuH7zrA4PLJiCBJ4csidK1JehPUDGNuIC7TtRKB3ZxHR+adbmtLt2cQ7SMbjrpyGxfRz
 lGu/omONv/PFvy5fx67ZhyEj1quawTxLslE1+EaFY4kLhBB4RUCqQYLeVdKKQcN7ywxBNfKhq
 rtf/sXaWlDQOf0a1ZVmfkPp+tOV6OC8ms+qVSc53AjWRDjLZZk2BEB3La0F8siqUtvwlqNKyB
 dalmvDyEMrQ13j/exzN8c2zLuxnMQnOcKA9bj4NwW6lHTotd1WLdgJcnl2YEOQOAZHuHxDSOG
 FeMGKw8wuC3ucOp3LqPySK6d8DHNLpHdne2S36/7GHgYqCosD0petLPz+4kLIIB+zQjOTEg7F
 v4wlmT79rqZ3R0skyfsld4wQKXDyyyzkiGft5/Gtw+lS8LjzCoRb0vac4xK9v2vtMZjuqNFAg
 DTOK7yI9d8IuIXCHIRRqAOCCfqf3J4eVwUrqm3HqpVcWBtvvHpOgU+iA+BVNgoRJtkHmTft5m
 eKIzhBDTPKX2d54VzMFVElMSf4PeGxpSndBA1edhKwX9KSMPIEyQgKt9aYY0Nb+S8S7o80jfp
 dnWDTDjmgWbot3cJjlZjzWeTjCYrCMRx2ax+S+J+7tmpxy9vnc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Wed, 25 Oct 2017, Alex Vandiver wrote:

> [Johannes asked about the speedup when using --no-pretty]
>
> ...so a modest 8% speedup.  I note that those numbers are for a perl
> with JSON::XS installed; without it installed, the runtime is so long
> that I gave up waiting for it.

Very nice! AFAIR Git for Windows does *not* come with JSON::XS.

> Anyways, I'll put that in the commit message in the re-roll.

Thank you,
Johannes
