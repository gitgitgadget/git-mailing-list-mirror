Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA69F20286
	for <e@80x24.org>; Wed, 13 Sep 2017 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdIMO4q (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 10:56:46 -0400
Received: from mout.web.de ([212.227.15.14]:49435 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751460AbdIMO4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 10:56:45 -0400
Received: from [192.168.178.36] ([91.20.62.83]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJZLX-1dqE4s1gUd-0037o1; Wed, 13
 Sep 2017 16:56:29 +0200
Subject: Re: [PATCH 4/4] archive: queue directories for all types of pathspecs
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
 <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
 <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
 <20170820090629.tumvqwzkromcykjf@sigill.intra.peff.net>
 <837ff6fe-a645-97fe-4b21-ec36f662ce19@web.de>
 <20170913125312.awtlbndv5j6kkcmz@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <03efb857-ed92-8815-3730-767cd5d6896a@web.de>
Date:   Wed, 13 Sep 2017 16:56:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170913125312.awtlbndv5j6kkcmz@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:GPwrz57SGfuWqThePfCnMERElajgosMuashV0hIka1gbYvjHbjc
 nrxQLUGagBvF4YBrS+TG6QbuebTenI+49IUq8tL75lUmO4xHpk0Mj8aO7QTlXuXdWd4GlmL
 1+RMgdyU2cCS5bixQfw2leSQr7NTXYl43SB/3yt289EFZkwh0I+YactT1SJM02hNDARJp0y
 CklrstTRBiZffHCjjk5Vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hihSA3kB2AU=:jjPnNNqUfl1WxCd5NSN0lr
 Ea1IBUk2WMz5zcZ6ZLK6RZNB5WqPGVezLO91ToAzlxrAr4PU9qzFzNkEp92lJDpoSVh8PIwEw
 o8QhKRD7TMPOX5ExvWZ6CYYzE/YNe4F7OxvkOVxfvh7FIuueSSshXAvlxrlzC+w4nc7XJ2n6t
 AtZBmKC+VOW70TnhAJexo1syM4bkSHT1+BSjJjqDmAXxjXfxtgjA/VBD5w7l22RmEelFC/0JJ
 vDUdgN23YL0IQBL1rLESz5ZFD8A/WkOJvpYZP6sNSVkRfzxWAxQhXIxS9wRdOw2t+fdGVFaMv
 YEZP2zXoChLdtTmDddXdf8ibNB8awp+ixP9fEtwsyx69TMFjKppS3RlrUoH4QPnZESOZNJRch
 gazyoqNEBk1h3IyWeRZBUatlHzSOyAPYsR7F5GUAKYrzEbk5xp/SG5KL7Mjc8la9PsT1sz/aE
 ez1dgUOCC1drurBnTPodm+jeEU4J7rVoBGesRtAYvAf1ycLqkni4fF+0JX4g5XRgHrk4a+CiN
 Zp9p8u/1HMYLZUk6IVPNNzB1Qn0PJIWaTw2t+s06r9o3JJMzghZSLPgIPnUXV6e2Xye4O2R9A
 vg52LQR8EbnvEnCvuJScly66Cyl+Y9fhPytZJyYIiXsfw1ZaPO0c3SAjoNKbQzpNJK8UCEDg6
 8RUGCyVLv9m3uoUyk5T1r0bWJw6NMnVAx/Ob89C7StLCZL7GGwAaUvMEbdybTrELhM/+X/pvW
 5EFgSSLrxsJ/H6QlJ3vaEiwbqrb5ajiBDGYjmVPCp7AyEI1EnkHyAhhCZlum8M9hmB/17ZJoP
 Ti5F/FtWCfgCAtSZ3isnwvKdzn3EmxXB+NqtvQtkV5/lHH9LSc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.09.2017 um 14:53 schrieb Jeff King:
> On Wed, Sep 13, 2017 at 12:43:57AM +0200, René Scharfe wrote:
>> Yet another way is have a few levels of nested subdirectories (e.g.
>> d1/d2/d3/file1) and ignoring the entries at the leaved (e.g. file1).
> 
> s/leaved/leaves/ ?

Indeed.

René
