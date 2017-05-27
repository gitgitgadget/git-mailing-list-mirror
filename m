Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69DB20D09
	for <e@80x24.org>; Sat, 27 May 2017 16:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750743AbdE0QZs (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 12:25:48 -0400
Received: from mout.web.de ([212.227.15.14]:56254 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbdE0QZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 12:25:46 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfRyz-1dgoX53773-00p8Mo; Sat, 27
 May 2017 18:25:22 +0200
Subject: Re: [PATCH v4 00/10] The final building block for a faster rebase -i
To:     Liam Beguin <liambeguin@gmail.com>, johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
References: <cover.1493414945.git.johannes.schindelin@gmx.de>
 <20170526031508.24838-1-liambeguin@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6f0e176b-e638-c13c-6a6d-aa5b62297879@web.de>
Date:   Sat, 27 May 2017 18:23:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170526031508.24838-1-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:q4jQ3C0HLEsOcybjxwSDV8T8UXNoTjE2RZHacpLwNAj+MMNmC4y
 eeBQTo2BLBaJ/T2fra4hmkapApm7lrJZyEvxkvgBfsRzJms3uXYmLNNdWvWWWzrRQlmpvLI
 pEwpSR6NK7DhReYofgGvt2i78eYD+mgZVcH5bwIYWZSczRBG3ZgSfpaGFifH9IdsPPaxFX+
 eg78lwx6eDSwGDJpHqJ8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JxPbKfJkl5g=:/i1Jo4/j7UL9d0mWkowPUr
 uXQNX+fU7GTXieVVaY6J5lkuLzZH6JeLemtbTLHYc6SGC13PLCGQvZSbIsPzQYNSszOpZJIBj
 a0zQ8fxWcxeXaXjN3mtMgf23JnE2qbuME9sKQFBsxmuLZDukzHOrLaXOwsptb3H99aaEGgRnM
 lRK83DPYLS0BhUx4Bjv5wtJWx9bO3d9+r4NoAn2pU6a2hADwpqazypfEMOx3JwN+QwjouGkRn
 0kKjhy53QlIFTeTyU6NIgTCG7hIiMTPeGtJOmmoYV8LRHQgDoEG+pD/3s7pgxocPp6VQaY2Ae
 1XXlxGBIRv0lqQbX1qsmh8bQP/653Ur5/9LxsPF/OqFGiW5usgqy8wopHFFBmDD+SsWrbctLM
 iVa5QvtODpfaVcfhhsFafZ5l2dIzh+BnnSHrIQU5r7l1zYVkVFTlOixF7uYKmXZuHFLdbc8PU
 FvxEUYR58EunWdxQ37m1FL+JTXSrYTrgUNMoka9VrX6nsw5qSmky29Xtrc4ZyTOGHTN1MNJZc
 HDL1Qr0Wl9rqZ/E73MXKet9pfdSxRQXq6rFLQKgFuqfG+x6Dwe54h3ATCPVfQ0hbhuRsAIUIS
 9WR1iDuR4okcgec2oLDDJx03Y6kQiCuj7LV8dBOG1oh/d0EZk/epe7RwwnsN7gY7zzohTwEcj
 zkpy/YOCoflMiIe46BOTv5bl8Oq85Bu4tPggXSDWhL2UMfHnLPKgAh81cocTkJRyf3LPoQfuv
 P57/Q1NRPiPpECfBjMk49JSr3wGJhz475ONk18ChuNdznAWl0JwO+UtKB2Ce/ho17/Fd/yFzf
 bs+WWBG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.05.2017 um 05:15 schrieb Liam Beguin:
> I tried to time the execution on an interactive rebase (on Linux) but
> I did not notice a significant change in speed.
> Do we have a way to measure performance / speed changes between version?

Well, there's performance test script p3404-rebase-interactive.sh.  You
could run it e.g. like this:

	$ (cd t/perf && ./run origin/master HEAD ./p3404*.sh)

This would compare the performance of master with the current branch
you're on.  The results of p3404 are quite noisy for me on master,
though (saw 15% difference between runs without any code changes), so
take them with a bag of salt.

There's more info on performance tests in general in t/perf/README.

René
