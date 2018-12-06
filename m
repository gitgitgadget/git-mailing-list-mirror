Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5ECB211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 15:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbeLFPIL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 10:08:11 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:38226 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFPIL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 10:08:11 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 10:08:10 EST
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 4265F28220F; Thu,  6 Dec 2018 16:02:12 +0100 (CET)
Date:   Thu, 6 Dec 2018 16:02:12 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: gitweb: local configuration not found
Message-ID: <mj+md-20181206.150151.76906.nikam@ucw.cz>
References: <154401401074.29584.11169979442731329694.reportbug@gimli.ms.mff.cuni.cz>
 <20181205184404.GC246451@google.com>
 <87bm5zzt4a.fsf@evledraar.gmail.com>
 <xmqq5zw7bhgv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zw7bhgv.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

> Yeah, it does look indirect.  Despite what you said, it also would
> support users giving an absolute path via GITWEB_CONFIG.
> 
> With "use File::Spec", perhaps something like this?

Yes, this looks right.

				Martin
