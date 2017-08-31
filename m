Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F89208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 14:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbdHaO4G (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 10:56:06 -0400
Received: from infnt2.nsinfo.co.rs ([94.247.200.3]:33865 "EHLO
        infnt2.nsinfo.co.rs" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdHaO4F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 10:56:05 -0400
Received: from localhost ([127.0.0.1])
        by infnt2.nsinfo.co.rs with esmtp (Exim 4.63)
        (envelope-from <pavic.aleksandar@nsinfo.co.rs>)
        id 1dnQt0-0004ni-AR; Thu, 31 Aug 2017 16:56:02 +0200
X-Virus-Scanned: amavisd-new at nsinfo.co.yu
Received: from [10.20.3.229]
        by infnt2.nsinfo.co.rs with esmtp (Exim 4.63)
        (envelope-from <pavic.aleksandar@nsinfo.co.rs>)
        id 1dnQso-0004nU-CO; Thu, 31 Aug 2017 16:55:50 +0200
Subject: Re: Bug report
To:     Dov Grobgeld <dov.grobgeld@gmail.com>, Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
References: <db0580dc-3ce0-47ba-b82a-b1e50b9d0a3a@nsinfo.co.rs>
 <20170831063614.GI3839@alpha.vpn.ikke.info>
 <CA++fsGHFwoLvwO121aDEgi1dZbwwfogdWbxxRx+ci7T1RDCAnw@mail.gmail.com>
From:   Aleksandar Pavic <pavic.aleksandar@nsinfo.co.rs>
Message-ID: <e334fd40-0bf2-21d8-e647-ef1195911e04@nsinfo.co.rs>
Date:   Thu, 31 Aug 2017 16:55:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA++fsGHFwoLvwO121aDEgi1dZbwwfogdWbxxRx+ci7T1RDCAnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hm, thanks, but the link was not helpful, there are no merge commits to 
master branch.

Those changes should have not been undone, that's how we caught it, 
because 1 line peace of code introduced new feature (+-10% tolerance on 
credit card verification  amount).

So most likeley they were undone, but our tree is pretty simple, we have 
master and production branches.



On 31.08.2017. 16:19, Dov Grobgeld wrote:
> The following answer that I got back in 2015 from Jeff King might be
> relevant to your problem:
>
> https://marc.info/?l=git&m=144178948506788&w=2
>
> Regards,
> Dov
>
> On Thu, Aug 31, 2017 at 9:36 AM, Kevin Daudt <me@ikke.info> wrote:
>> On Wed, Aug 30, 2017 at 11:25:00PM +0200, Aleksandar Pavic wrote:
>>>   I have a file
>>>
>>>   app/Controller/CustomerCardVerificationController.php
>>>
>>> And when I take a look at changes log, I get this (no matter which tool I
>>> use):
>>>
>>> 2017-07-31 19:41 dule             o membership renew payment email
>>> 2017-06-07 08:59 Dusan Tatic      o cc refund clean
>>> 2017-04-15 00:16 Miodrag Dragić   o refound admin payment
>>> 2017-03-20 12:02 Dusan Tatic      o CardVerification card connect
>>> 2017-03-16 15:59 Aleksandar Pavic o paypal
>>> 2017-03-10 13:34 Aleksandar Pavic o Production branch
>>> 2017-03-10 13:01 Aleksandar Pavic I Migrating dev
>>>
>>> However if I manually browse thru revisions and open revision from
>>> 03/27/2017 07:05 PM
>>>
>>> I can see the change in that file which is unlisted above, at revision
>>> ff9f4946e109bd234d438e4db1d319b1f6cb6580
>>>
>>> And I'm at master branch all the time...
>>>
>>> We wouldn't have noticed that if it weren't one important feature...
>>>
>> What does git branch --contains ff9f4946e109bd234d438e4db1d319b1f6cb6580
>> return?
>>
>> Where did you find this commit?

