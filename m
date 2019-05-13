Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC4B1F461
	for <e@80x24.org>; Mon, 13 May 2019 21:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEMVzt (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 17:55:49 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:18256 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEMVzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 17:55:49 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QIvDhxYtqniZTQIvDhqptv; Mon, 13 May 2019 22:55:47 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=ThujBkUneqCIAknskawA:9 a=QEXdDO2ut3YA:10
Subject: Re: git --help not actually showing the git(1) help page..
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <0d37203a-e738-bad3-41e1-05204abc138b@iee.org>
 <20190513205301.GA22745@sigill.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <a0afd3c4-93ff-31e6-a622-5751c6b5a549@iee.org>
Date:   Mon, 13 May 2019 22:55:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513205301.GA22745@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfELioyWC5HJrvRIoutb8RMjLKGE/hkFxwiGj3OJSM8gkLFMpvFQQ99DRfhTirIMXyYnw+z7WTiB/zJwELHikLx+PLLUqGQAC/GU9h1CLkj/KF3POJ1FS
 dLl4QaqB3FaUcQZ9qZRO1Vep9VD3Ch3BS3g0ZsiXsdKKmj/HFJ00Cb9NpqHtc23WiDYYTb1eJF87box8bOW6mm/8d0WIEJqCR0dQGIMweCX4j60+IcvA45Ho
 GsqjPClaJEqRTXR2nUPH3Ugh0ffZMUuIxmgZxmrhkYY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff
On 13/05/2019 21:53, Jeff King wrote:
> On Mon, May 13, 2019 at 09:47:27PM +0100, Philip Oakley wrote:
>
>> Is there a cli way, especially on Git for Windows bash, to get the html man
>> page of git(1)? I have it on my system, so can go via another page but..
>>
>> All the `git <cmd> --help` appear to work, but I can't determine the correct
>> invocation for bringing up the stupid content tracker's page in the browser.
>> Previously I'd have expected either `git --help` or `git git --help` to work
>> (can't remember which). The former only produces the short form -h help in
>> the bash window, the latter says 'git' isn't a command.
> Try "git help git".
Ahh, that's the one. I'd totally forgot about that method.
>
> It might be worth mentioning it in the paragraph at the end of "git
> help".
True. I'll stick on my todo list, along with adding to the general usage 
message. Possibly "Or `git help git`."

On GfW I commonly use the `git <cmd> --help` when things go wrong, so 
making the response to that give the right advice would be good. (It's 
almost the same isue as `git --version`).

> --
Philip
