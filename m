Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1821F453
	for <e@80x24.org>; Fri,  3 May 2019 09:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfECJLG (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 05:11:06 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:46648 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfECJLG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 05:11:06 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 76B523C014D;
        Fri,  3 May 2019 11:11:03 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OPVuKJW4ml8g; Fri,  3 May 2019 11:10:56 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id B7F923C0034;
        Fri,  3 May 2019 11:10:52 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 3 May 2019
 11:10:52 +0200
Date:   Fri, 3 May 2019 11:10:49 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use
 with -G
Message-ID: <20190503091049.GA6438@vmlxhi-102.adit-jv.com>
References: <87o94vs9cp.fsf@evledraar.gmail.com>
 <20190424224539.GA23849@vmlxhi-102.adit-jv.com>
 <87mukfrnp3.fsf@evledraar.gmail.com>
 <xmqqsgu6zzev.fsf@gitster-ct.c.googlers.com>
 <87ftq6s252.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftq6s252.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 02:25:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
[..]
> Do you or anyone have a suggestion for a better CLI option name?
> 
> Maybe --pickaxe-patch or --pickaxe-patch-format (to go with git-diff's
> -u aka --patch (i.e. not --raw) default format)? Or
> --pickaxe-G-with-context or --pickaxe-with-context or
> --with-pickaxe-context or --pickaxe-context ? All of these suck, but I'm
> coming up blank on a better one :)

'--pickaxe-patch' is shorter than '--pickaxe-raw-diff', hence more
convenient to me. It looks like 'pickaxe-all' and 'pickaxe-regex' are
the only --pickaxe-* options currently implemented. Both of them are
two-worded only and easy to remember/type. I think '--pickaxe-patch'
is more user-friendly, but I leave git people to say the final word.

> 
> Probably the least shitty of those shitty options is --pickaxe-patch,
> since we have --patch which triggers the same format, and we can
> document that the default is a -G search through --no-pickaxe-patch, and
> you can just tweak the format.
> 
> It also leaves the door open (unlike having *-G-* in the option) to
> support this for -S if anyone cared...

-- 
Best Regards,
Eugeniu.
