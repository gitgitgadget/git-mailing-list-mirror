Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5491F576
	for <e@80x24.org>; Tue, 20 Feb 2018 11:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbeBTLyU (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 06:54:20 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37530 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTLyT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 06:54:19 -0500
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1KBsIAp032223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Feb 2018 12:54:18 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1KBsIjP032222;
        Tue, 20 Feb 2018 12:54:18 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1KBro1W019025;
        Tue, 20 Feb 2018 12:53:50 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1KBroTa019024;
        Tue, 20 Feb 2018 12:53:50 +0100
Date:   Tue, 20 Feb 2018 12:53:50 +0100
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180220115350.GA18760@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180219220819.GA10466@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802201127140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1802201127140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

On Tue, Feb 20, 2018 at 11:46:38AM +0100, Johannes Schindelin wrote:
> Oh, sorry. I understood your mail as if you had told the core Git
> developers that they should implement the feature you desire. I did not
> understand that you hinted at a discussion first, and that you would then
> go and implement the feature you asked for.

Well, sorry for being misunderstandable. It was my impression from the 
FAQ that the reason for why this feature doesn't exist was a strong 
opinion that it would cause technical problems. The FAQ doesn't mention 
anything like a lack of manpower. As I stated it was my 
impression that this feature would not be too hard to implement.

Because of this my email presupposed it was not manpower that prevented 
this feature.

My statement "Please provide options" was thus targeted at reviewing 
and discussing the perceived technical reasons for not implementing 
this feature at least as an option. It wasn't supposed to demand free 
lunch from anyone.

Of course I can offer to do some work to the best of my abilitites if 
that's the issue. That should go without saying for Free Software 
projects. Perhaps even my employer would be happy to pay me for 
implementing the feature during workign hours. This shouldn't be the 
issue. The issue is the seemingly dogmatic reply in the FAQ which makes 
me reluctant to put work into this in fear that a patch submission 
would be met with strong rejection.

> You will not be able to convince the core Git developers to make this the
> default, I don't think.

I have stressed very clearly in my mail that I am not asking the 
defaults about mtime restoring to be changed. I agree that those 
defaults are reasonable and in line with the principle of least 
astonishment.

What bugs me is my impression from the FAQ that even as an option, the 
feature might be unwelcome.

Best wishes
Peter
-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
