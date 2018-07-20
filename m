Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074491F597
	for <e@80x24.org>; Fri, 20 Jul 2018 08:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeGTJQF (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 05:16:05 -0400
Received: from goliath.siemens.de ([192.35.17.28]:58228 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbeGTJQF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 05:16:05 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w6K8SbKh022641
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 10:28:37 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6K8SaCk020174;
        Fri, 20 Jul 2018 10:28:36 +0200
Date:   Fri, 20 Jul 2018 10:28:40 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t/t5534: do not unset GIT_COMMITTER_EMAIL for other
 tests
Message-ID: <20180720102840.37f28d17@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqqzhymdfo3.fsf@gitster-ct.c.googlers.com>
References: <xmqqbmb4lbhh.fsf@gitster-ct.c.googlers.com>
        <20180719121409.6143-1-henning.schild@siemens.com>
        <20180719141545.48358a26@md1pvb1c.ad001.siemens.net>
        <xmqqzhymdfo3.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Thu, 19 Jul 2018 15:27:56 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Henning Schild <henning.schild@siemens.com> writes:
> 
> > Looking at "what is cooking" i assume i should not add/fold this
> > to/in the serien anymore. So it comes as a separate patch on top.  
> 
> Thanks.  I only said:
> 
>      I think this round is mostly ready, except for a minor nit in the
>      last step.  I do not mind merging this to 'next' and leave fixing
>      of the test to a later clean-up.
> 
> meaing that I _do not mind_ merging the slightly broken one to
> 'next' and fixing it with a follow-up (i.e. this patch), but fixing
> with a replacement patch so that we pretend we never made a mistake
> that needs fixing from the beginning is of course preferrable ;-)
> 
> Let's squash this patch into the last one in the series.

Ok, just sent a v6 of 7/7.

Henning
