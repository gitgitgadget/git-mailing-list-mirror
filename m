Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17845C433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 00:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA6060C49
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 00:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhJWAGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 20:06:09 -0400
Received: from a2nlsmtp01-01.prod.iad2.secureserver.net ([198.71.224.24]:60006
        "EHLO a2nlsmtp01-01.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231624AbhJWAGI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Oct 2021 20:06:08 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 20:06:08 EDT
Received: from a2plcpnl0855.prod.iad2.secureserver.net ([107.180.109.50])
        by : HOSTING RELAY : with ESMTP
        id e4NbmJDpyeE3Me4NbmgnuZ; Fri, 22 Oct 2021 16:55:19 -0700
X-CMAE-Analysis: v=2.4 cv=NvgUz+RJ c=1 sm=1 tr=0 ts=61734f67
 a=TnFZWvihntyBY5k9PECvpg==:117 a=gu6bcJMwsK5EayZrpSXjig==:17
 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10
 a=HtDQqM0_iSRWIHNblDkA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: justus@opentransactions.org
Received: from [156.96.151.132] (port=32804 helo=mailserver)
        by a2plcpnl0855.prod.iad2.secureserver.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <justus@opentransactions.org>)
        id 1me4Na-004feR-Vh; Fri, 22 Oct 2021 16:55:19 -0700
Received: from [10.137.0.14] (helium.fuckthenavy.net [192.168.199.2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mailserver (Postfix) with ESMTPSA id 2CE318608B7;
        Fri, 22 Oct 2021 18:55:17 -0500 (CDT)
Message-ID: <fa4b28b1-9b5e-0201-5afe-2e8f294fa9b4@opentransactions.org>
Date:   Fri, 22 Oct 2021 15:55:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: gitignore as symbolic link
Content-Language: en-US
To:     Matheus Tavares <matheus.bernardino@usp.br>,
        Rene Kita <mail@rkta.de>
Cc:     git <git@vger.kernel.org>
References: <fcf288fc-72b7-964c-e462-496066528c7b@opentransactions.org>
 <YXLro/8c1Feg6TcN@kitchen>
 <CAHd-oW50puNCrYTQhR4qffgtP6-wJerWLhmhCV+nYcLVNu+CBg@mail.gmail.com>
From:   Justus Ranvier <justus@opentransactions.org>
Organization: Open-Transactions
In-Reply-To: <CAHd-oW50puNCrYTQhR4qffgtP6-wJerWLhmhCV+nYcLVNu+CBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2plcpnl0855.prod.iad2.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - opentransactions.org
X-Get-Message-Sender-Via: a2plcpnl0855.prod.iad2.secureserver.net: authenticated_id: justus@opentransactions.org
X-Authenticated-Sender: a2plcpnl0855.prod.iad2.secureserver.net: justus@opentransactions.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4xfKctkOerXEhrBYxK7CdN7AlrLpqtQhzz9Aca7g1889YgteqQ6JkGj2DuQNATv7Bixl5dls18Nmfz9JWY24nojRum6wOOV8NkWXropB/9g2GZtMnKIxxE
 pHxUvlyGfG72NF8AQOTwESiD+tXNG9jwH25P3vzNUpRDAXNq69VFIQNORJ43ccsVMSZqcA28LrpUz++x9vVHdM8Y2QLX1WD4FIR6nK14/P584RWQmnetYvVe
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose a person is managing N repositories. Would that person prefer to 
maintain the list of files to ignore for every random IDE that anybody 
who joins the team might want to use in:

a: One place
b: N places


On 10/22/21 14:40, Matheus Tavares wrote:
> Note that "core.excludesFile" and "$GIT_DIR/info/exclude" are still
> allowed to be symlinks.

These are settings that are specific to each developer, right?

If I have N repositories with M developers and I need to add a new 
ignore pattern that's either and O(M) or an O(N) job, neither of which 
is significantly better than the other and both of which suck compared 
to the O(1) functionality that we had before when we could put the list 
on a shared submodule.

