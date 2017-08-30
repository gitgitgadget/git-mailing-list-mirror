Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767AD208E3
	for <e@80x24.org>; Wed, 30 Aug 2017 22:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdH3WiQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 18:38:16 -0400
Received: from infnt2.nsinfo.co.rs ([94.247.200.3]:38928 "EHLO
        infnt2.nsinfo.co.rs" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdH3WiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 18:38:16 -0400
X-Greylist: delayed 4381 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Aug 2017 18:38:15 EDT
Received: from localhost ([127.0.0.1])
        by infnt2.nsinfo.co.rs with esmtp (Exim 4.63)
        (envelope-from <pavic.aleksandar@nsinfo.co.rs>)
        id 1dnAU4-00008F-PI
        for git@vger.kernel.org; Wed, 30 Aug 2017 23:25:12 +0200
X-Virus-Scanned: amavisd-new at nsinfo.co.yu
Received: from [10.20.3.229]
        by infnt2.nsinfo.co.rs with esmtp (Exim 4.63)
        (envelope-from <pavic.aleksandar@nsinfo.co.rs>)
        id 1dnATt-00006Y-6V
        for git@vger.kernel.org; Wed, 30 Aug 2017 23:25:01 +0200
To:     git@vger.kernel.org
From:   Aleksandar Pavic <pavic.aleksandar@nsinfo.co.rs>
Subject: Bug report
Message-ID: <db0580dc-3ce0-47ba-b82a-b1e50b9d0a3a@nsinfo.co.rs>
Date:   Wed, 30 Aug 2017 23:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  I have a file

  app/Controller/CustomerCardVerificationController.php

And when I take a look at changes log, I get this (no matter which tool 
I use):

2017-07-31 19:41 dule             o membership renew payment email
2017-06-07 08:59 Dusan Tatic      o cc refund clean
2017-04-15 00:16 Miodrag Dragić   o refound admin payment
2017-03-20 12:02 Dusan Tatic      o CardVerification card connect
2017-03-16 15:59 Aleksandar Pavic o paypal
2017-03-10 13:34 Aleksandar Pavic o Production branch
2017-03-10 13:01 Aleksandar Pavic I Migrating dev

However if I manually browse thru revisions and open revision from 
03/27/2017 07:05 PM

I can see the change in that file which is unlisted above, at revision 
ff9f4946e109bd234d438e4db1d319b1f6cb6580

And I'm at master branch all the time...

We wouldn't have noticed that if it weren't one important feature...

