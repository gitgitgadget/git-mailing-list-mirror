Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CD3C433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81CB60FE3
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJWPoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 11:44:17 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:45072
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229901AbhJWPoQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Oct 2021 11:44:16 -0400
Received: from a2plcpnl0855.prod.iad2.secureserver.net ([107.180.109.50])
        by : HOSTING RELAY : with ESMTP
        id eJ8imaq1fD8S5eJ8imH5WR; Sat, 23 Oct 2021 08:40:56 -0700
X-CMAE-Analysis: v=2.4 cv=Ks2IZUaN c=1 sm=1 tr=0 ts=61742d08
 a=TnFZWvihntyBY5k9PECvpg==:117 a=gu6bcJMwsK5EayZrpSXjig==:17
 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10
 a=_sIrjDtJnPOESWS0g28A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: justus@opentransactions.org
Received: from [156.96.151.132] (port=47690 helo=mailserver)
        by a2plcpnl0855.prod.iad2.secureserver.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <justus@opentransactions.org>)
        id 1meJ8h-003dMh-SX; Sat, 23 Oct 2021 08:40:56 -0700
Received: from [10.137.0.14] (helium.fuckthenavy.net [192.168.199.2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mailserver (Postfix) with ESMTPSA id 196718608B7;
        Sat, 23 Oct 2021 10:40:54 -0500 (CDT)
Message-ID: <e5a6dfa5-617f-5b5b-6803-45d36b3de53e@opentransactions.org>
Date:   Sat, 23 Oct 2021 07:40:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: gitignore as symbolic link
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Rene Kita <mail@rkta.de>, git <git@vger.kernel.org>
References: <fcf288fc-72b7-964c-e462-496066528c7b@opentransactions.org>
 <YXLro/8c1Feg6TcN@kitchen>
 <CAHd-oW50puNCrYTQhR4qffgtP6-wJerWLhmhCV+nYcLVNu+CBg@mail.gmail.com>
 <fa4b28b1-9b5e-0201-5afe-2e8f294fa9b4@opentransactions.org>
 <YXP5rZT5IgFcMZs0@camp.crustytoothpaste.net>
From:   Justus Ranvier <justus@opentransactions.org>
Organization: Open-Transactions
In-Reply-To: <YXP5rZT5IgFcMZs0@camp.crustytoothpaste.net>
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
X-CMAE-Envelope: MS4xfITI82z4MThXgVrrxomqrhdYIayIWuKs6G1zZxfyOCmFg6Vw2Q6SFgYzSUexv77CoW2+j0Bl4ariU5Gkqo6WUNhL1Xxv8eA2D3SVXzDJtU1ERy9UMlY9
 ZPXirmLbXTqjyGjjoMGI/1mQg8owyK+MyIGFO93Mvia3oGaFWjoG+MkhVCOEwnTFVoCY6owt+n75aGUMH6ZORQlUhsYTtFtbIaQkkeyruSbbG53YT8S8vQjJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23/21 04:01, brian m. carlson wrote:
> For example, I

I'm glad that works for you and whatever organizations you happen to be 
involved in. I'm sure you're happy that git taking away this capability 
did not impact your workflow.

Other people have different use cases and operate under different sets 
of constraints and are considerably inconvenienced when functionality 
that has worked for many years is suddenly removed from a core piece of 
software like git.
