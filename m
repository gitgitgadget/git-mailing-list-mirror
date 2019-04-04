Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082CE20248
	for <e@80x24.org>; Thu,  4 Apr 2019 09:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfDDJ1P (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 05:27:15 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:57109 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733187AbfDDJ1N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 05:27:13 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 0915444001B;
        Thu,  4 Apr 2019 12:27:12 +0300 (IDT)
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il> <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk> <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com> <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com> <874l7ekynt.fsf@tarshish> <xmqqk1gaf7oe.fsf@gitster-ct.c.googlers.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
In-reply-to: <xmqqk1gaf7oe.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 04 Apr 2019 12:27:11 +0300
Message-ID: <87zhp6jf2o.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Apr 04 2019, Junio C. Hamano wrote:
> Baruch Siach <baruch@tkos.co.il> writes:
>
>>> Independently, I think it makes sense to do something like
>>>
>>> 	/^([a-z][a-z-]*-by|Cc): (.*)/i
>>>
>>> to tighten the match to exclude a non-trailer; that would have been
>>> sufficient for the original case that triggered this thread.
>>
>> Is there anything I need to do more to get this fix applied for the next
>> git release?
>
> Get "this" fix applied?  I think we should tighten the regexp to
> exclude a non-trailer, which would have been sufficient for the
> original case without anything else in "this" fix.  So in short, I
> do not think "this" fix won't be applied without further tweaking
> ;-)

This is exactly what "this" patch (referenced in the title of "this"
thread) is doing:

  https://public-inbox.org/git/eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il/

Am I missing something?

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
