Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EEBF1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfFXSjW (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:39:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:48762 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbfFXSjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:39:22 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4BAFB3F412B;
        Mon, 24 Jun 2019 14:39:21 -0400 (EDT)
Received: from [192.168.1.6] (152.sub-174-229-150.myvzw.com [174.229.150.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8B0953F4047;
        Mon, 24 Jun 2019 14:39:20 -0400 (EDT)
Subject: Re: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index in
 json
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0367673b-aa5a-49de-87f6-d52beb1af4c4@jeffhostetler.com>
Date:   Mon, 24 Jun 2019 14:39:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/24/2019 2:00 PM, Johannes Schindelin wrote:
> Hi Duy,
> 
> On Mon, 24 Jun 2019, Nguyễn Thái Ngọc Duy wrote:
> 
>> - json field names now use '_' instead of '.' to be friendlier to some
>>    languages. I stick to underscore_name instead of camelCase because
>>    the former is closer to what we use
> 
> This is not a good reason. People who are used to read JSON will stumble
> over this all the time because it is so uncommon.

Getting rid of "." and "-" in field names is the important part.
These confuse some languages and make us drop into object["<field>"]
syntax in my experience.

As for "_" or camelCase (or PascalCase), I'm not sure it matters one
way or the other.  Personally, I'd vote for underscores.

Jeff
