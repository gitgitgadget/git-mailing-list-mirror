Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A88E1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 12:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeJCTQ5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 15:16:57 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:40710 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbeJCTQ5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 Oct 2018 15:16:57 -0400
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1g7gGi-0003r6-PX; Wed, 03 Oct 2018 14:28:44 +0200
Subject: Re: Git for games working group
To:     Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc:     John Austin <john@astrangergravity.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <87bm8zlqrh.fsf@evledraar.gmail.com>
 <CA+AhR6d4p2N06t-w62A2=wTH0x1ipt3x3hN2mQKK-Cwj0rMX1g@mail.gmail.com>
 <20180915164217.GB88932@syl>
 <CA+AhR6fjtzWyRtcgRkedK=RWua8_rmiqkDR+my8u9BHLfjhRMA@mail.gmail.com>
 <20180916220548.GA154643@aiede.svl.corp.google.com>
 <20180917135846.GG71477@syl>
 <20180917155810.GA89942@aiede.svl.corp.google.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <5b3386b4-629b-9b33-840c-330b9926e88e@virtuell-zuhause.de>
Date:   Wed, 3 Oct 2018 14:28:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180917155810.GA89942@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1538569726;ca567bd9;
X-HE-SMSGID: 1g7gGi-0003r6-PX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.09.2018 um 17:58 schrieb Jonathan Nieder:

[...]

> Ah, thanks.  See git-config(1):
> 
> 	core.bigFileThreshold
> 		Files larger than this size are stored deflated,
> 		without attempting delta compression.
> 
> 		Default is 512 MiB on all platforms.
> 

In addition to config.bigFileThreshold you can also unset the delta
attribute for file extensions you don't want to get delta compressed.
See "git help attributes". And while you are at it, mark the files as
binary so that git diff/log don't have to guess.

