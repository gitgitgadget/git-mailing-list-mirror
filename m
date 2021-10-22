Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA521C433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 23:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCCB60FBF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 23:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhJVXc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 19:32:29 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:48442
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231731AbhJVXc0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Oct 2021 19:32:26 -0400
Received: from a2plcpnl0855.prod.iad2.secureserver.net ([107.180.109.50])
        by : HOSTING RELAY : with ESMTP
        id e3yFmmGc0IXfLe3yFmUGrK; Fri, 22 Oct 2021 16:29:07 -0700
X-CMAE-Analysis: v=2.4 cv=C+osdSD+ c=1 sm=1 tr=0 ts=61734943
 a=TnFZWvihntyBY5k9PECvpg==:117 a=gu6bcJMwsK5EayZrpSXjig==:17
 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10
 a=okDzs61ykUbnorHZ-LcA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: justus@opentransactions.org
Received: from [156.96.151.132] (port=59144 helo=mailserver)
        by a2plcpnl0855.prod.iad2.secureserver.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <justus@opentransactions.org>)
        id 1me3yF-004GjD-6T; Fri, 22 Oct 2021 16:29:07 -0700
Received: from [10.137.0.14] (helium.fuckthenavy.net [192.168.199.2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mailserver (Postfix) with ESMTPSA id 6B08B8608B7;
        Fri, 22 Oct 2021 18:29:05 -0500 (CDT)
Message-ID: <bf0e854b-0018-460c-adc5-289108713f04@opentransactions.org>
Date:   Fri, 22 Oct 2021 15:29:04 -0800
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
X-CMAE-Envelope: MS4xfC8HE5SRY6Mi1RiSTvofMpEMmSPazbDWYJmjs/qHg1wFtOw+45sW81wfE/VSOA1t/VzRkFIbryt9ZFY7/j1T14UOTb4EVShU10Gt0tXnMQhq6lV481nU
 L2UDBclu7pzYzjMEKGgXR8PIe3JcdR43vKUq+ICtD3RSLngVs36Y1mghVYMNe16Bmf+f7+xfzLM178tUSeDxBNF0vM9sCt/9Jjde9qVsMBm+wrSwa56VMm+M
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/22/21 14:40, Matheus Tavares wrote:
> So the behavior you experienced is actually not a bug, but
> an intended change.

So it's a permanent loss of functionality that I just have to live with. 
Got it.
