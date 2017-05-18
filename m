Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAAFF201CF
	for <e@80x24.org>; Thu, 18 May 2017 14:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbdEROxt (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 10:53:49 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:5649 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756589AbdEROxs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 10:53:48 -0400
Received: from [192.168.2.240] ([92.22.40.87])
        by smtp.talktalk.net with SMTP
        id BMoEdelR146SJBMoEdzdlX; Thu, 18 May 2017 15:53:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1495119227; bh=RrAiD1T/uIRTfMtjpaqW5vBYwXTDdQbQN0O5Q3myVdg=;
        h=Reply-To:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=jwd/Ewt+iUW7P8vS5zEiMR3/VzAseJampu2ZZQM9sOpZvD9Iwos9gCieJ6LHNJtCR
         PHOZ/hNrw7d+sgqS39Cq5wu/YEU/U5Wl5XSxlOrgeFO0FbBV36AYxLIEsnr8uaLse6
         MX2/4ahRXTRb1hbTXyPvvD3ChbK/B673xgDQCxJY=
X-Originating-IP: [92.22.40.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=Uk7VDCfhaeB8IHNEy8al/Q==:117
 a=Uk7VDCfhaeB8IHNEy8al/Q==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=PC8SsYojZYLZTCmxwKcA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: Add missing newline to end of message
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170518134154.12771-1-phillip.wood@talktalk.net>
 <CACBZZX4hbe+bDbxQKy92ruD8=4V7pqnOi9WyBqhunG-F8=wXRw@mail.gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <3e4ad130-0932-f465-281d-20acfe3125a2@talktalk.net>
Date:   Thu, 18 May 2017 15:53:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX4hbe+bDbxQKy92ruD8=4V7pqnOi9WyBqhunG-F8=wXRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHcI7lWpbpJDvsLFykmFVkoAqPe5d0HT4DH0bzkIGEuf8JRtTOm7/zWoylQVO9zHSyFweLhMKT2aMoTpxPmqMCiIlTIFJfp8yY4bd3lQDuIMYMfJvJHc
 uL2MwQxomvEltRG9JMw6VKE4lTypMSkWzunMf7L77tEgVKiyiLtkPnpKiTG4bTc9XyoV0M5KFryJo1kcSOk6CW+tL/4h2ClCvBv8LwQrRRIG6FZMbOdXc3uc
 X7/Ts+vtuhD3Cx34m/yHag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/05/17 14:48, Ævar Arnfjörð Bjarmason wrote:
> On Thu, May 18, 2017 at 3:41 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The message that's printed when auto-stashed changes are successfully
>> restored was missing '\n' at the end.
> 
> Both this and your reflog message really seem like the sort of tricky
> edge cases we should have tests for.
> 
Yes I agree, I'll try and put something together when I have time

Best Wishes

Phillip
