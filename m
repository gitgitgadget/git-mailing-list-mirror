Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E3C20248
	for <e@80x24.org>; Wed,  6 Mar 2019 08:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCFIHR (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 03:07:17 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:43211 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfCFIHR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 03:07:17 -0500
Received: from [192.168.3.76] (unknown [146.247.95.34])
        (Authenticated sender: jn.avila)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id C842C20042E;
        Wed,  6 Mar 2019 09:07:10 +0100 (CET)
Subject: Re: [PATCH] Doc: fix misleading asciidoc formating
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20190305214423.27820-1-jn.avila@free.fr>
 <20190305223655.GA27535@sigill.intra.peff.net>
 <xmqq4l8hszj7.fsf@gitster-ct.c.googlers.com>
 <20190305230227.GA22901@sigill.intra.peff.net>
 <20190305231142.GA359@sigill.intra.peff.net>
 <xmqqy35ssx7v.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <43445278-ec9f-f3f4-89bf-cf99906fc617@free.fr>
Date:   Wed, 6 Mar 2019 09:07:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqy35ssx7v.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-03-06, Junio Hamano, Jeff King wrote:> Jeff King <peff@peff.net>
writes
> 
>> TBH, I still have mixed feelings on rendering these technical docs with
>> asciidoc at all. It seems like few enough people bother to render them
>> that bugs persist for a long time. It kind of seems like make-work
>> getting them to format correctly.
> 
> I thought about resisting when some people started pushing for
> rendering everything under the Sun, but went with the flow as I
> lacked the energy to fight every battle in sight.
> 
> Good to see somebody shares a similar sense of trade-off, better
> late than never ;-).
> 

TBH, I discovered this while diving into the rendering on manpages for
the localized version because asciidoctor issued a warning, and pushed
this patch for "cultural" knowledge (sometimes, automatic linefeed
triggers unintended behaviors). But, as Peff noted, this may not be a
good idea to render these documents at all on git-scm.com.

In this case, there's no point in tracking rendering issues outside
genuine manpages.


