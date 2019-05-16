Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46961F461
	for <e@80x24.org>; Thu, 16 May 2019 11:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfEPLZt (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 07:25:49 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:6445 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPLZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 07:25:49 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id REW9h0w5OdraxREW9h0yBh; Thu, 16 May 2019 12:25:46 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=anyJmfQTAAAA:8
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=hZl4FlbxAAAA:8 a=A1X0JdhQAAAA:8 a=AMgbiCRiAAAA:8 a=mV9VRH-2AAAA:8
 a=9VVUIlGeQNTH-g2OEV8A:9 a=QEXdDO2ut3YA:10 a=YHcIV1kcuJAA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22 a=xts0dhWdiJbonKbuqhAr:22 a=zNGlSMxTWkni11D5GzKz:22
 a=Df3jFdWbhGDLdZNm0fyq:22 a=cU_FsQMbVzznvpCqsfaC:22
Subject: Re: [PATCH v3 2/2] Doc: git.txt: remove backticks from link and add
 git-scm.com/docs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <CAPig+cQ4FZeOxbVU-5qTrQm8Q-khwHuCwekAr-aGtbLKAVzY0Q@mail.gmail.com>
 <20190515224709.2936-1-philipoakley@iee.org>
 <20190515224709.2936-3-philipoakley@iee.org>
 <xmqqbm035fhx.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <d79d5e70-ec3a-c6ca-b23d-a44edf2579d2@iee.org>
Date:   Thu, 16 May 2019 12:25:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqbm035fhx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfBQcZZiHsRMXJMg1ZKjbiibyGG+MRbFIv0Rit6jXUYKtCWESlC8ktraKnQ7mpjmux46Hg0LbyMvC44YsuVvHJ/TrYH2D+HGApLozhxDOnLp6s9puK8/L
 FAmm/yVEYED7WVzBrDbuj7vkcswPpttWY0vFw4xgBy/XG3b5R22kz4ChbY+TJGnbHgWUzOv/Nc1x0eMzytPj8L45rztGYOylNR/ln71aKhVYItZOrirrZ79r
 bGyKx3wbbqQiBKu7+aWLmyq+u1LwXdmr2gw6u0fDOJ/0vKKfRUXYdfg46JMl8GCL4yq1JTvMFlQ/LxlhcbKRwLXKZ0yMhiaHZHVnA+rsjyC3FwTEy90TSkEN
 auC4C3ZF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/05/2019 02:56, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> While checking the html formatted git(1) manual page, it was noted
>> that the link to https://git.github.io/htmldocs/git.html was formatted
>> as code. Remove the backticks.
> Good.  I just ran
>
> 	$ git grep '`https*://' Documentation/
>
> to see if any hits I see are for the real URL the user may want to
> click on.  There are some that are pointing at real sites, but I do
> not think users would want to clickon  many of them while reading the
> documentation.
I'd had a quick brows and mainly found example.com ;-) Any other excepts 
were at the other end of the doc relative to git(1)...
>
> Except perhaps for these to see what's there:
>
> Documentation/git-archimport.txt:	Attempt to auto-register archives at `http://mirrors.sourcecontrol.net`
That domain is gone. Whole line should probably be removed.

> Documentation/git-cvsimport.txt:* cvs2git (part of cvs2svn), `http://subversion.apache.org/`
>
Still there. Still updated - last news 2019-04-24. Could remove backticks.

Philip
