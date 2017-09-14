Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9690720281
	for <e@80x24.org>; Thu, 14 Sep 2017 08:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbdININk (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 04:13:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:64211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdININj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 04:13:39 -0400
Received: from UltraSam.fritz.box ([178.11.154.32]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0LyeIB-1dOamH1BFn-0163eZ; Thu, 14 Sep 2017 10:13:26 +0200
Subject: Re: [PATCH] test-lib: don't use ulimit in test prerequisites on
 cygwin
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <b57731ed-4640-d27f-f7b2-6c70af8dd400@ramsayjones.plus.com>
 <20170913192038.GH27425@aiede.mtv.corp.google.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <6a413ecf-47d6-e562-7cdd-e4c3a1d666e6@grubix.eu>
Date:   Thu, 14 Sep 2017 10:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170913192038.GH27425@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:o5FLD1DXDSYcQtaRir7gG/+i5vcTYym1gV5eBymKdsd9xXTy5eX
 UKbW/qm3ovtwAbYcc6xRi++rAc4vdxZWTZSYlWwEAXcWl+QrVg/Cvxm6vfjb8PgiMk8X9Jx
 eZrRfkMs0E2yk39BxG/4NZR72t9A40gyhyaXbmS460byCUKAgKqznJsqt7x+ryfveBYfI9X
 DDLFmF74bhuCFIDHctHww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bIBZ/ob/+SI=:UiCgGA5kNrVBW8EJQedZ2O
 i8CySpS6qdpsxkyhWj63GWEhZ9sdfbRmG8nc+i2y5+Mo2jUZim1SiJ7iHSLzYwdzZx2ErMKY/
 ZZjehVvypNXhsTvia5rYYwhgrEsEhVb99ehM72i3vt/2I2ekmOITzC5LbccjtY1Zg5PUjUCuw
 M8ehKaNqqc0N4ZITeZXbu/jbmF2k0Hgw4zIlJ1HszySFzBbPJC3VzwWx3JjJ5Tnt/6tGZKNMd
 tchOV7VH/s96SC0W5gpVcC5PmJOLOEd4OlUXyqtz/l66gesWKmw7fdUGfi/z3sc2TEveUI7t9
 GSTBUM6WceMg3O15AxH7vYy5m/xdqcDhfTtqQ9xdQEIyZdiYQ/E9oV4mmKRMlDa1J/119XuvV
 hdzfC6mmSd2tSHN91kkOC5QXPDmgJQbh6Jw5hvddTEFaz++Yy25Z6WAlUivn9N01dfqCTJTuZ
 Dyyy3mYzEomQ2HOqGqCt6w/B4l+v1X5RLbJsq22fCAR/3NFgzOxw2GE0rQ4q46aXMwGhIpLv5
 gE4wy9kznwz7MSZRmSr7deXtY5DKFV6sbo0fRXou9pdgB6kdz85y3eaYmjyL7cOvBAsEG4GxB
 HER/W6Wgug3EgXXgoN2aYG4ts2zOknJyDNzJFMyw7AUH8kJe4t+/+FqGQlXlzm2Gywg0dP0hw
 ulCxChpWeVRcaysP3l28SJapESb03qlgYUVCzvaOUakvnJ4WQH8w7H5cQ7pP6kdxKQuq4eac5
 oy74BI+5y0Y5oOAkgtuaoRXC8rvmFdDVnAPTkqvLwysYu0afRiDSZ7YYGtc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder venit, vidit, dixit 13.09.2017 21:20:
> Ramsay Jones wrote:
> 
>> On cygwin (and MinGW), the 'ulimit' built-in bash command does not have
>> the desired effect of limiting the resources of new processes, at least
>> for the stack and file descriptors. However, it always returns success
>> and leads to several test prerequisites being erroneously set to true.
>>
>> Add a check for cygwin and MinGW to the prerequisite expressions, using
>> 'uname -s', and return false instead of (indirectly) using 'ulimit'.
>> This affects the prerequisite expressions for the ULIMIT_STACK_SIZE,
>> CMDLINE_LIMIT and ULIMIT_FILE_DESCRIPTORS prerequisites.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>  t/t1400-update-ref.sh | 11 ++++++++++-
>>  t/t6120-describe.sh   |  1 -
>>  t/t7004-tag.sh        |  1 -
>>  t/test-lib.sh         | 22 ++++++++++++++++++++--
>>  4 files changed, 30 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks.
> 
> An alternative would be to do some more explicit feature-based test
> like using "ulimit" to set a limit and then reading back the limit in
> a separate process, but that feels like overkill.

It's still not clear whether these limits would be in effect or just
reported.

Rather than checking uname -s in several places, I think we should just
define ulimit to be false in one place, or rather set the prerequisite
there.

Michael
