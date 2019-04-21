Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1045720248
	for <e@80x24.org>; Sun, 21 Apr 2019 12:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDUM7x (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 08:59:53 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:21990 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfDUM7x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 08:59:53 -0400
Received: from [192.168.1.12] ([92.21.144.249])
        by smtp.talktalk.net with SMTP
        id IC4ThWXkrnuQZIC4Thsu0r; Sun, 21 Apr 2019 13:59:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1555851590;
        bh=VggZSeUSHTgI0I+YdKYmHHTTRuNmzunIs8z9+1KrIng=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ikkPPGLUnIQTHOaVqkl2RYg52ndCiHtTHqL9cyuQdpuJoDfJwicjkLQEqo24W2ZbI
         QF5dNXnVxm1O//y1jhbgifsEconQKf84kOtdtAF7B+RuMUUxaTalE3Z5ci1ZnWHRLj
         nEPR2M4Kr1AoprPsMl+cFM1gxZt6aapHm5sY+dcI=
X-Originating-IP: [92.21.144.249]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=Dgn57AdRJ25t4HaDIyq3iQ==:117
 a=Dgn57AdRJ25t4HaDIyq3iQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=5a-1AXuaAAAA:8 a=5Q5CwvjKAAAA:20
 a=pGLkceISAAAA:8 a=1AEPuxCWPGrWkL7HYGcA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=WFVlYr1VzdVvABZhjiIM:22
Subject: Re: gettext, multiple Preferred languages, and English
To:     Andrew Janke <floss@apjanke.net>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>
References: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <bd5ee770-a213-b663-208c-c9980a738fe9@talktalk.net>
Date:   Sun, 21 Apr 2019 13:59:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfAuK3Gqu/HWM+mglhJpS1wSrG1HJA5F8ICw/D1SNo2b7hOS4Rj9hSTUriUFT+tdF1hmRzC7qDIYuO12gQA30E3SVSUaaHIGHZMkNK/QIR1XkxSetzK5H
 9+si14HlMAcTQPB1WOKEha2tp3J9n+mahbWeQmLDy4W7KrxCj+sIXI4m543X0AN/M6p1tcvKcMACV/zyjaoHcUypNIMfBBZEgSPt0sJrjKV/anJfQ3/ZW1NM
 rMRB5hSjlzJIjADF0r/5GQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrew,

On 21/04/2019 12:08, Andrew Janke wrote:
https://public-inbox.org/git/d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net/
> I don't think it would even have
> to be actively maintained, because for new message strings that aren't
> included in the .po file, it would fall back to the non-translated input
> strings, which are in English anyway, which is the desired behavior.
Given the above comment, could the en.po file 
(https://github.com/apjanke/git/blob/english-dummy-translation/po/en.po) 
be some very very short version with only one 'translated' string? This 
may be a way-off comment, but if it could be such a simple maintenance 
free file then that sounds sensible.

also adding in Jiang Xin <worldhello.net@gmail.com>, the coordinator for 
extra comment.

Philip
