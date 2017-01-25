Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5EE1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbdAYXkt convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 25 Jan 2017 18:40:49 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:5780 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbdAYXkt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:40:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 1464F1E3830;
        Thu, 26 Jan 2017 00:40:46 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id t6nQ9wt9Q1Ba; Thu, 26 Jan 2017 00:40:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id C91C01E3838;
        Thu, 26 Jan 2017 00:40:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3PALHTXyjDJ1; Thu, 26 Jan 2017 00:40:45 +0100 (CET)
Received: from [192.168.178.28] (aftr-185-17-206-216.dynamic.mnet-online.de [185.17.206.216])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 6A21A1E3830;
        Thu, 26 Jan 2017 00:40:45 +0100 (CET)
Subject: Re: [PATCH] tag: add tag.createReflog option
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20170125001906.13916-1-cornelius.weig@tngtech.com>
 <20170125180054.7mioop2o6uvqloyt@sigill.intra.peff.net>
 <00712f81-e0ba-52e6-77bc-095a2ed706c4@tngtech.com>
 <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net>
 <xmqqpoja95o5.fsf@gitster.mtv.corp.google.com>
 <xmqqy3xy7nq0.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, novalis@novalis.org, pclouds@gmail.com
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <5553094d-db87-4a04-cf02-5405b92a6224@tngtech.com>
Date:   Thu, 26 Jan 2017 00:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3xy7nq0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> It may have been obvious, but to be explicit for somebody new,
> !prefixcmp() corresponds to starts_with().  IOW, we changed the
> meaning of the return value when moving from cmp-lookalike (where 0
> means "equal") to "does it start with this string?" bool (where 1
> means "yes").
> 

I see. It reads much better that way!

I re-did all the changes from Jeff's patch, but some tests are breaking
now. I will have to mend that tomorrow, because it's already too late in
my timezone.

Thanks a lot for your support m(_ _)m

