Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326531F461
	for <e@80x24.org>; Sat, 31 Aug 2019 07:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfHaHR2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 03:17:28 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:44815 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHaHR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 03:17:28 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 90329807B738; Sat, 31 Aug 2019 09:17:26 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id D45AE807B72C;
        Sat, 31 Aug 2019 09:17:23 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:45356 helo=[192.168.1.10])
        by ferret.domein-it.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i3xdN-0000rY-LB; Sat, 31 Aug 2019 09:17:17 +0200
Subject: Re: [PATCH v6 2/2] builtin/rebase.c: Remove pointless message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Szeder_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190829164757.7301-1-ben@wijen.net>
 <20190830151607.4208-1-ben@wijen.net> <20190830151607.4208-3-ben@wijen.net>
 <xmqqimqewgrd.fsf@gitster-ct.c.googlers.com>
From:   Ben <ben@wijen.net>
Message-ID: <d5a70a17-9b4c-f060-5b4c-1e0bdb594390@wijen.net>
Date:   Sat, 31 Aug 2019 09:17:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqimqewgrd.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i3xdN-0000rY-LB
X-Domein-IT-MailScanner: Found to be clean
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 30-08-2019 22:16, Junio C Hamano wrote:
> Ben Wijen <ben@wijen.net> writes:
> 
>> -			struct object_id head_oid;
>> -			if (get_oid("HEAD", &head_oid)) {
>> -				ret = error(_("could not determine HEAD revision"));
> 
> I think we saw die() in the previous one.  This patch would not
> apply on top of the result of applying 1/2.

Yes, my fault, sorry about that...

> 
> I'll tentatively queue this instead on top of the corrected 1/2.

Your patch is indeed correct.

Thank you!

> 
> Thanks.
> 
