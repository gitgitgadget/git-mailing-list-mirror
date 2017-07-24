Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23AB02047F
	for <e@80x24.org>; Mon, 24 Jul 2017 04:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdGXEUA (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 00:20:00 -0400
Received: from lang.hm ([66.167.227.134]:50571 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbdGXET7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 00:19:59 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jul 2017 00:19:58 EDT
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v6O4Jvfb023412;
        Sun, 23 Jul 2017 21:19:57 -0700
Date:   Sun, 23 Jul 2017 21:19:57 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Farshid Zavareh <fhzavareh@gmail.com>
cc:     Andrew Ardill <andrew.ardill@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Should I store large text files on Git LFS?
In-Reply-To: <CANENsPpdQzBqStGjq4jUsAB0-7U8_SQq+=kjmJe6pJtiXxnYFg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1707232119210.20418@qynat-yncgbc>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com> <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com> <FF08CB42-35AC-4B97-BB02-2473BEDE66A1@gmail.com> <nycvar.QRO.7.76.6.1707232109480.20418@qynat-yncgbc>
 <CANENsPpdQzBqStGjq4jUsAB0-7U8_SQq+=kjmJe6pJtiXxnYFg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 24 Jul 2017, Farshid Zavareh wrote:

> I see your point. So I guess it really comes down to how the file is
> anticipated to change. If only one or two line are going to change every
> now and then, then LFS is not really necessary. But, as you mentioned, text
> files that change drastically will affect the repository in the same way
> that binaries do.

Not quite the same way that binaries do, because text files compress well. but 
close.

David Lang
