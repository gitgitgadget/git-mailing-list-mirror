Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6440B20756
	for <e@80x24.org>; Mon, 16 Jan 2017 08:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbdAPISU (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 03:18:20 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:59814 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdAPISO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 03:18:14 -0500
Received: from [91.113.179.170] (helo=[192.168.92.11])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.84)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1cT2UV-0004xW-ER; Mon, 16 Jan 2017 09:18:11 +0100
Subject: Re: [RFC] stash: support filename argument
To:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20170115142542.11999-1-t.gummerer@gmail.com>
 <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com>
 <c0d46a97-b1c0-d9c9-e475-28e0368ac61f@gmx.net>
Cc:     git@vger.kernel.org, kes-kes@yandex.ru
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <c8c5b5e1-b1f1-5b02-dc5f-0ec65f1a11a0@syntevo.com>
Date:   Mon, 16 Jan 2017 09:18:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <c0d46a97-b1c0-d9c9-e475-28e0368ac61f@gmx.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16.01.2017 01:41, Stephan Beyer wrote:
> Hi,
>
> On 01/16/2017 01:21 AM, Junio C Hamano wrote:
>> I haven't spent enough time to think if it even makes sense to
>> "stash" partially, leaving the working tree still dirty.  My initial
>> reaction was "then stashing away the dirty WIP state to get a spiffy
>> clean working environment becomes impossible", and I still need time
>> to recover from that ;-)  So as to the desirablity of this "feature",
>> I have no strong opinion for or against yet.
> I do remember that I simulated that feature a few times (either by
> adding the to-be-keep stuff (hunks, not only files) to the index and use
> --keep-index, and sometimes by making a temporary commit (to make sure
> to not lose anything) and then stash). So I think there is a valid
> desire of the feature.

I can confirm this from a GUI client perspective, for which this feature 
makes probably even more sense than for command line. It has been 
requested by our users quite often compared to other features and 
compared to "git stash -p" support.

-Marc



