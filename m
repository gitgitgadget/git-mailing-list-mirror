Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7784E2092F
	for <e@80x24.org>; Tue, 24 Jan 2017 08:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbdAXIVG (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 03:21:06 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:18657 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbdAXIVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 03:21:04 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jan 2017 03:21:03 EST
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 8DD661E2CD4;
        Tue, 24 Jan 2017 09:14:25 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tQ7KuYzDA4Cv; Tue, 24 Jan 2017 09:14:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 3C6CA1E37F4;
        Tue, 24 Jan 2017 09:14:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2CpXOYUrWOHS; Tue, 24 Jan 2017 09:14:25 +0100 (CET)
Received: from [192.168.178.31] (aftr-185-17-206-157.dynamic.mnet-online.de [185.17.206.157])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id CDE2B1E2CD4;
        Tue, 24 Jan 2017 09:14:24 +0100 (CET)
Subject: Re: [PATCH 7/7] completion: recognize more long-options
To:     Johannes Sixt <j6t@kdbg.org>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
 <20170122225724.19360-8-cornelius.weig@tngtech.com>
 <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
Cc:     bitte.keine.werbung.einwerfen@googlemail.com, git@vger.kernel.org,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <967937ff-e5ff-2515-2f50-80a96683c068@tngtech.com>
Date:   Tue, 24 Jan 2017 09:14:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/24/2017 08:15 AM, Johannes Sixt wrote:
> If at all possible, please use your real email address as the From
> address. It is pointless to hide behind a fake address because as Git
> contributor you will have to reveal your identity anyway.

These are both real addresses, but for send-mail I would not want to use
my work account. I hope this is not a problem.

> Please study item (5) "Sign your work" in
> Documentation/SubmittingPatches and sign off your work.

I followed the recommendations to submitting work, and in the first
round signing is discouraged.

> AFAIR, it was a deliberate decision that potentially destructive command
> line options are not included in command completions. In the list given,
> I find these:
>
>>  - reset: --merge --mixed --hard --soft --patch --keep

My bad, I only added --keep, which should be fine. As to these options

>>  - apply: --unsafe-paths
>>  - rm: --force

let's wait for further comments, but I won't cling to it.

> Additionally, these options are only for internal purposes, but I may be
> wrong:
>
>>  - archive: --remote= --exec=

These may in fact be too exotic and just clutter the command line. Best
they are removed.

-- Cornelius
