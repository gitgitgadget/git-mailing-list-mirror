Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D45520193
	for <e@80x24.org>; Sat, 29 Oct 2016 09:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbcJ2JoP (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 05:44:15 -0400
Received: from mout.web.de ([212.227.17.12]:49862 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753179AbcJ2JoO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 05:44:14 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MZUWH-1cJJPY445d-00LBfb; Sat, 29 Oct 2016 11:44:10
 +0200
Subject: Re: [PATCH] valgrind: support test helpers
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <71c3d13a-fa29-75d3-50ac-81978c08f552@web.de>
 <alpine.DEB.2.20.1610281050220.3264@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <da3542a1-f7c5-b480-16ca-fb20ef4a4fdd@web.de>
Date:   Sat, 29 Oct 2016 11:44:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1610281050220.3264@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:aBWeeZJbo2Amb8Xv6qxhnKcFgCovk8ohAE1uHMwO1VMxBlR9ryh
 vzobbI8wmu2lok8fkKw9xkynV0vJHUYo+Dq2SrV2KlyoToLkUWFJ3DlgFx7JvvawdJBwXeb
 lpnDnz+v9jxi+b+PIZFDdaR6Y91f66oOjAv1273LeT9gAhy0Q0dVwMkxAkyZXXcP6RcRpQX
 kqPOfkswJqlPXeNkBQ6+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i9k61IDmYzQ=:iLLutdAXs2+bskRtFE9c4r
 r+qXsBQ5p8X62ZuNbb2EsxaIKyJHvajb8Yy7x8pUPC+Y8DWHuUKjUEGvQpJZG2DahtLsOsGl6
 8oFdHO1QFuURzEouNiW8SqRRQO/+vWGC4mwLC+P1adtmYo9u3PBG0dvCiYEfNEwdgekSccTrL
 BGUxflu3J5+cj3Q3pc6uH3X2dS1t35RFWw1wO8c+Ha3svDWXUUhdKxsqRkPesQk1jF/TMxSux
 h3vi2BEP0CmtlhQ5LVKU/CVxgwLfjh8zGKnrMyJxAggg5lBum17bOyNmFx5rveUDGwJTP1318
 75sUBpCo6fBhwxvGDx/YnWh9CYzdFHpqIukGTdtXhK69N2MsMiId4lYfJPB3j1rojXCggYdO5
 2aEEM9/lreIdYEkuVPzNSUmbgxEFM3XD08XpEBYyO52zTz46s1QmpwzM0vnQewj2KhevK7TPD
 4kP8Kkz3o5No/+lbjnpLGZTxeS5KayGVEyL+slJBsPEiqMzFPLZC6uEYR7ZahNalQAl+GGIFY
 G5/n2n3tIEu0P/gn+XHXTODXHaoh+BPtx9NsR3hhK2NUPxu7csnZzMGEpF0Gjr/OFP+cyfkBw
 D1zDho+mF0A2guuachEcwI0JUuNMnYOzGumW4K6dM75Y/ScPGsLti+ys1cNhYIYC4b3RSlBKL
 8h8FE+zHu2NwwVNbZeX8HGB8KjQ4czkCLWJbcirYC1JNWCQdOA9mMz2EDZfl2IANyhC34GPyg
 NGfREKSV4Hed9oZ1ZPPXS4IzS6igsCE0r9dM8gC0xRlaXv8DsmDd+2mKBA4G94cPnCNjWnBWN
 5QxgzVC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.2016 um 10:51 schrieb Johannes Schindelin:
> On Fri, 28 Oct 2016, René Scharfe wrote:
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>
> Apart from the missing accent ("é") in your SOB: ACK.

I sign off without accent out of habit, to avoid display problems -- 
better have a plain "e" than something like "<C3><A9>" or worse.

But only now I realized that I can fix at least my end by using an UTF-8 
locale (e.g. LANG=C.UTF-8 instead of LANG=C) -- together with PuTTY and 
its settings Window, Translation, Remote character set: UTF-8 and 
Connection, Data, Terminal-type-string: linux, which I already had.  My 
terminal just got boosted into the 21st century, woohoo! ;)

René
