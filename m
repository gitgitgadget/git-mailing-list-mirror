Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F1B1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbdAYVVw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 25 Jan 2017 16:21:52 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:55112 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdAYVVw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:21:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id CF3861E2FA5;
        Wed, 25 Jan 2017 22:21:48 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id d7Ff0F6ZFNkf; Wed, 25 Jan 2017 22:21:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 8866E1E3817;
        Wed, 25 Jan 2017 22:21:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zWGj0jwKo-Ut; Wed, 25 Jan 2017 22:21:48 +0100 (CET)
Received: from [192.168.178.28] (aftr-185-17-206-216.dynamic.mnet-online.de [185.17.206.216])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 362AB1E2FA5;
        Wed, 25 Jan 2017 22:21:48 +0100 (CET)
Subject: Re: [PATCH] tag: add tag.createReflog option
To:     Jeff King <peff@peff.net>
References: <20170125001906.13916-1-cornelius.weig@tngtech.com>
 <20170125180054.7mioop2o6uvqloyt@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, novalis@novalis.org, pclouds@gmail.com
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <00712f81-e0ba-52e6-77bc-095a2ed706c4@tngtech.com>
Date:   Wed, 25 Jan 2017 22:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170125180054.7mioop2o6uvqloyt@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/25/2017 07:00 PM, Jeff King wrote:

>   - Is that the end of it, or is the desire really "I want reflogs for
>     _everything_"? That seems like a sane thing to want.
> 
>     If so, then the update to core.logallrefupdates should turn it into
>     a tri-state:
> 
>       - false; no reflogs
> 
>       - true; reflogs for branches, remotes, notes, as now
> 
>       - always; reflogs for all refs under "refs/"
> 

I think you nailed it. This is much more useful than what I suggested.
I'll see if I can code it up.
