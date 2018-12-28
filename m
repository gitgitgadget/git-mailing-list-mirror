Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26491F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbeL1Uhd (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:37:33 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:28755 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeL1Uhd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:37:33 -0500
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Dec 2018 15:37:32 EST
Received: from [192.168.1.12] ([92.29.14.72])
        by smtp.talktalk.net with SMTP
        id cyqTgPGq7oI6LcyqTgBu1g; Fri, 28 Dec 2018 20:35:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1546029301;
        bh=2ahyFfYDY0ohPdR3dj7dofdCxufci9P+ly+5RI0TqZE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aOnOvZCfbFz3W3nSHeXpYNo88W/ApIWKBQOYVG0Ojdf6TbF2GBkR3xcUjA1dj/LV0
         FJwMuqmriOe+GNnZfpBU99e+mxYAYx91Jj/9lXj1WBWMRKw4S66yrpDxfA/soqLRUT
         HxvujtT6rPdKp14wAsoy3NnuSHVbEPDAPVlLH6pw=
X-Originating-IP: [92.29.14.72]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=U7W/PrDwRYoztbkIcndy/g==:117
 a=U7W/PrDwRYoztbkIcndy/g==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=AeudKg5abl_RDBKY_OwA:9 a=QEXdDO2ut3YA:10 a=u09W0hvIdLUA:10
 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: [PATCH 0/2] Improve documentation on UTF-16
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
 <87lg4adoo5.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <5c2ba2da-6bfc-bbbb-30e8-4eb86dd7136c@talktalk.net>
Date:   Fri, 28 Dec 2018 20:35:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <87lg4adoo5.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFjrf9rrmtsHlKxirWQcPJnxvlO3OUO6Mn/90kG1poFeei5vuKnc4V0ing8NwI3PpvUyeC1Np/xthyW3OQdX4qU2LCltvtaMqSJt1YK7fV3JLJU2sKLL
 Fl0I867xigF4U0E+QNsXGwhMEHoGnUymgZiXE9WbOluS0dE68C+7BC+dqpziXrEYrd0E2KnRV9Pi1qBmmFlSl4WE69GUhYRz9pQiSavXUybWctoAG7LU6+v6
 iw4cUIOt7NG/VRaOe8OW6YYsFEBZnzxMFzDolfMFbKwaPxXZIMvU8rcFFCSOFC2BTkI+iJ/H5ejISv0bwQsDEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/12/2018 08:46, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Dec 27 2018, brian m. carlson wrote:
>
>> We've recently fielded several reports from unhappy Windows users about
>> our handling of UTF-16, UTF-16LE, and UTF-16BE, none of which seem to be
>> suitable for certain Windows programs.
> Just for context, is "we" here $DAYJOB or a reference to some previous
> ML thread(s) on this list, or something else?


I think 
https://public-inbox.org/git/CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com/ 
was the most recent on the Git list.

-- 

Philip

