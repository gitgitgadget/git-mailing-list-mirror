Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E01B1F461
	for <e@80x24.org>; Sun,  1 Sep 2019 16:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfIAQ1g (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 12:27:36 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:39532 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfIAQ1f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 12:27:35 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 6E6D780A51AC; Sun,  1 Sep 2019 18:27:33 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id D444080A51A0;
        Sun,  1 Sep 2019 18:27:30 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:34934 helo=[192.168.1.10])
        by ferret.domein-it.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i4ShN-00016y-QI; Sun, 01 Sep 2019 18:27:29 +0200
Subject: Re: [PATCH v6 1/2] builtin/rebase.c: make sure the active branch
 isn't moved when autostashing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Szeder_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190829164757.7301-1-ben@wijen.net>
 <20190830151607.4208-1-ben@wijen.net> <20190830151607.4208-2-ben@wijen.net>
 <xmqqsgpiwgts.fsf@gitster-ct.c.googlers.com>
 <bf659b1d-b9a4-cb9e-e660-fa743b4db84c@wijen.net>
 <xmqqr250uhtr.fsf@gitster-ct.c.googlers.com>
From:   Ben <ben@wijen.net>
Message-ID: <57de794a-52a7-2d00-8267-127317ac9bee@wijen.net>
Date:   Sun, 1 Sep 2019 18:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr250uhtr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i4ShN-00016y-QI
X-Domein-IT-MailScanner: Found to be clean
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01-09-2019 18:01, Junio C Hamano wrote:
> Ben <ben@wijen.net> writes:
> 
>>
>> Would you like me to send in another patch or leave it like this?
> 
> As long as you make it clear that you are 100% happy with the
> fixed-up result that appeared in 'pu', there is no need to resend
> (if you want to make any other changes, I do want to avoid me
> screwing up by listening to you and hand applying those changes; I'd
> rather want updated patch(es) be sent in such a case).
> 

Hi Junio,

I am 100% happy with with your fixed-up result.
I have no (planned) updates ATM.


Thank you all for the thorough reviews.

Ben...

> Thanks.
> 
