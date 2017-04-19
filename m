Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7CA1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 13:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763786AbdDSNos (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 09:44:48 -0400
Received: from mout.web.de ([212.227.17.11]:57399 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763761AbdDSNor (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 09:44:47 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtnzN-1bzu053lgL-011BGp; Wed, 19
 Apr 2017 15:44:41 +0200
Subject: Re: [PATCH] various: disallow --no-no-OPT for --no-opt options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20170418170914.9701-1-avarab@gmail.com>
 <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
 <CACBZZX6XWXjvDKeR+a1Ymb4csXgOKLiF==VkKLp5S9TRVQhgoA@mail.gmail.com>
 <b4eef4c1-cd5a-aa71-fc79-8af89dbe365d@web.de>
 <CACBZZX7Y2cqabLMkx35ZU88Y3+8zffP5hxa8haThMaErbfhcfA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6d9cedc4-3d3d-61a8-080c-98126c555e1b@web.de>
Date:   Wed, 19 Apr 2017 15:44:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX7Y2cqabLMkx35ZU88Y3+8zffP5hxa8haThMaErbfhcfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/v82CHKUSm+bc4JrTgZKxpLSNrldmX2xvBjFWNg000b/W/gp8Iu
 JgMPNgysObP+vllHRusabiXYJb5g0xlGjHk5us7uQIJR+xpd19/3FP20hQNe6m0kR3evDmw
 7tmVD85QshpJHWL0XZxevCKiWDXImYpk9hG8v2xAH4TlSv2axg5LXJcCwNOkoBDvFL0Ra1x
 Lv+KxrTZrOxcoB1DMzvnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VBTtWBMgzdU=:BYOflDdZ+h86aOZ8BR9BJ9
 wKPmkFO9yr6yFXT2p+4gUJRSKSidv+kQRDfPd4WjJCx8h+9GVe/P6mLCbYsTWE71aLmyYeAVi
 H6F44mfZz4QL9eNWLXJJPbH1flZ2Mb5tmRctrNZ6rT3FqIHLBiE3KinEkAk5xwQwPW5y1Twlv
 00/xL8L2AjjG6BSHugmbOd81Hz6lO8ggfTAzkVV+ODCCqGfpv6XoitMlYs91sswhHCU/SsL1I
 VGbBeCPWu3QY7lHSS4zIZyAt2c6asKEdEpoCnDhACzO4qkhDCJLKDsm+57ggJC6FPuBiS2RW+
 JO/XkTcSDaD4Tp528fG/fSsZT0c2lyt3if/O/FVi8K04SDRr5nOunTwChAX7WkykyR7YvY7yb
 Fh/KbqN/hCC3YJtfuzADH/blnBj72BCbuUOnQSDt1OHrA/gmIcAGYKRsI42CNIgIYAFSacszT
 DEN4L/RGfTymRJa1I/zjBxuUuQ9X5YYU9QFk6q0QB8dXg6+QUk9SUk3BNMWu6RRPtIbyFKjoU
 yGWHKYYkx/Z1uif315UjNzMwI6/l2JCsgP4CCKV2Q6HtP42hxvUJEanSugx53n6ZJPVyX8jWb
 5y1KrE2GZXYtk0pnhdF2SWgGClP+V8oprMR2sFzI0l+BES9SJgGcng3Zi9lpcLvg1DRX62Tys
 QJB2QwL3Whp2CweXiLPvSttK4OPQpqvUsI8Y93TvkLG8auobgXxxrQWjqzYLRsdYNK51Q5U7P
 EiEk+E5dkcTW23xyhlyv6+4lpc2zxqI173JhlEnm0c8+vtVDe5/pddNGyzseyfPYg4r6XNt/Y
 PNugEb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 15:19 schrieb Ævar Arnfjörð Bjarmason:
> I mean a bug in my patch, i.e. I meant to remove --no-no-OPT in cases
> of --no-OPT but also removed --OPT unintentionally, but anyway, let's
> drop this one, Jacob's patch is better.

Ah, OK.

You also wondered why no tests complained.  Good question.  Would it 
make sense to test every option *and* its negation?  That would double 
the number of tests in order to check a parseopt feature.  Hmm, not 
sure.  More test coverage would be good, but I doubt we'd ever arrive at 
100% for this.

If you had converted --no-doubt in t/helper/test-parse-options.c to 
OPT_BOOL_NONEG instead of or in addition to adding the new flag --no-neg 
then you'd seen the effect in t0040.

René
