Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C4E2092F
	for <e@80x24.org>; Tue, 24 Jan 2017 07:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750764AbdAXHQA (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 02:16:00 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:52729 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750704AbdAXHQA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 02:16:00 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3v6zx95qtqz5tlH;
        Tue, 24 Jan 2017 08:15:57 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 177EA1D00;
        Tue, 24 Jan 2017 08:15:57 +0100 (CET)
Subject: Re: [PATCH 7/7] completion: recognize more long-options
To:     Cornelius Weig <cornelius.weig@tngtech.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
 <20170122225724.19360-8-cornelius.weig@tngtech.com>
Cc:     bitte.keine.werbung.einwerfen@googlemail.com, git@vger.kernel.org,
        thomas.braun@virtuell-zuhause.de, szeder@ira.uka.de,
        john@keeping.me.uk
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
Date:   Tue, 24 Jan 2017 08:15:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170122225724.19360-8-cornelius.weig@tngtech.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If at all possible, please use your real email address as the From 
address. It is pointless to hide behind a fake address because as Git 
contributor you will have to reveal your identity anyway.

Please study item (5) "Sign your work" in 
Documentation/SubmittingPatches and sign off your work.

I'm by no means a bash completion expert, but I have a comment on this 
patch.

Am 22.01.2017 um 23:57 schrieb bitte.keine.werbung.einwerfen@googlemail.com:
> Recognize several new long-options for bash completion in the following
> commands:

AFAIR, it was a deliberate decision that potentially destructive command 
line options are not included in command completions. In the list given, 
I find these:

>  - apply: --unsafe-paths
>  - reset: --merge --mixed --hard --soft --patch --keep
>  - rm: --force

Additionally, these options are only for internal purposes, but I may be 
wrong:

>  - archive: --remote= --exec=

-- Hannes

