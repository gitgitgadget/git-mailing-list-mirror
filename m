Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D7F41F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 09:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeKMTSa (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 14:18:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:55371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeKMTSa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 14:18:30 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lh7M3-1fjb2b2VYF-00oY9q; Tue, 13
 Nov 2018 10:21:14 +0100
Date:   Tue, 13 Nov 2018 10:21:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: Regression: rebase -C1 fails in master
In-Reply-To: <7c0f0b57-d303-d1fe-e551-c8783b5dbc17@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1811131019530.39@tvgsbejvaqbjf.bet>
References: <7c0f0b57-d303-d1fe-e551-c8783b5dbc17@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Utg383TGCAwdwsv9m/LsTbRUmQyPy8D2THN6KN4QBGlgqotZ58h
 6fih6tFRUUDGeSGq17p5xA/xu9SBX7qwKAU93SvrKoJxfvNNGB4mvVlgMvCK11yE1FIURzk
 xqcIg9qiagdqeDDojxZzjThOeQNEGHRHBBDX8bOCdKUXYrzZdN9rl2T9aF0j7J+RyjOniz4
 9vkjiswqfsiVx+SfrWDDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sU91h9uCHTM=:TDu2dyA/lMJXoDPyC8NwI6
 nIhWVGBXQUaA/zYtGQ9rEU/5OtmNW0Z4pokMoyDYaly2jsp51CZRommlsV7dt22+mGzbMv80t
 0vDPVnZ9snnUu3zVRQuJC0V+1wKbmQqUYYpsAbv/GmOySTegeOXq6I/L6Xw4bu80qQmOs7PZn
 gB2CloQPJsf3KOywQHA4YFQljvFT2k1YizgUQ371xETdsOrhZuAUOa3+lLzHrSSI2hMKDz/lJ
 dGO2S9/hPygpWMyhThlTqM/x2agZgpepy83TOqsC2lbgvS23gGQW+HKZFirFaweJQlTuJ7gDI
 8+uKOX7mMfd04E5uz5dFgNo8rbhmkZ/gUeEa2RYjvCjzAHzYfdg+iefEdQctzL/MkxzX8EFej
 CXMrIswqEXtcVDEMWEArYJGyBL2DHkdcauZDmL0M7YkC01gY4Ge9omgrnUYStMUhCKHg0fAZv
 M5g0rDVpk73erh7d7hWk8q4TumGMQB+3/SkHYONrWgQy+NBYsDo2VNOznbojshMxn1DnfDFz+
 Y3wUdT9k9kO7VzP7aeAcDgB2ZVQ6JFdPcIg3W8IMwwpabo47eVrfxUfzUfR5onlBpSCQOk3pr
 VMriQ8YA/2H/741gzGDCYE3XwEMcxHuuXbEXtIUG0PnzEVxwPIb1vVSZk5ys5K7UCMjdngncb
 uxW//pTK72HRbBEHgaai8aBtqxe2xpbZBnJ+9Txz9IxHlp01rcxHj2nOUORm/gM+0CaJ6G51y
 sbiTq9MAuA9BOzRtw/OvxAkxY1OKM1hhsb70J6+TnJv3l1yYqyL9x14h7CceraUYz7aLrEIJd
 Quhhrse8h8o2Xf/G8A1zjwMvWBW8Va9EzmixcxyMYHhp7c3GrELKZOiGcTNETgOtYiGrFgkmC
 L1s/EbESJccsXtFaeQlyXI7+qtEOSjiJxTL0wGTtebSKyNPC4n0wp3e+U48BaCes6KwlmSPB6
 Jqs+1q3PGUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 12 Nov 2018, Phillip Wood wrote:

> I've just tried running
> 
> bin-wrappers/git rebase -C1 @^
> 
> and I get
> 
> error: unknown switch `1'

Darn. I think this is the same problem as the `-S` switch problem, but in
reverse: the built-in rebase used to require an argument for `-S` (it
should be optional, fixed in the meantime), but `-C` also has an optional
argument.

Let me see whether I can fix this quickly.

Ciao,
Dscho

> usage: git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>]
> [<upstream>] [<branch>]
>    or: git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>]
> --root [<branch>]
>    or: git rebase --continue | --abort | --skip | --edit-todo
> ...
> 
> bin-wrappers/git --version gives
> git version 2.19.1.856.g8858448bb4
> 
> Unfortunately I've not got time it investigate properly at the moment.
> 
> Best Wishes
> 
> Phillip
> 
