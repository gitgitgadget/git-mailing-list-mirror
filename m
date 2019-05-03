Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_SUBJECT,
	PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352481F453
	for <e@80x24.org>; Fri,  3 May 2019 08:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfECIQH (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 04:16:07 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:46079 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECIQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 04:16:06 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id DCCBC3C00DD;
        Fri,  3 May 2019 10:16:04 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dClYdghxUJWh; Fri,  3 May 2019 10:15:58 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 74A163C0034;
        Fri,  3 May 2019 10:15:58 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 3 May 2019
 10:15:58 +0200
Date:   Fri, 3 May 2019 10:15:58 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Jeff King <peff@peff.net>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Message-ID: <20190503081558.GB4686@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bcc: 
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use
 with -G
Reply-To: 
In-Reply-To: <20190503031531.GA19436@sigill.intra.peff.net>

On Thu, May 02, 2019 at 11:15:31PM -0400, Jeff King wrote:
> On Thu, Apr 25, 2019 at 02:54:48AM +0200, Eugeniu Rosca wrote:
> 
> > > This is unrelated to --pickaxe-raw-diff, -U<n> just implies -p in
> > > general. See e.g. "git log -U1".
> > 
> > Oops. Since I use `-U<n>` mostly with `git show`, I missed the
> > implication. You are right. Then, my question is how users are
> > going to (quote from commit description):
> > 
> > > >> > [..] search [..] through an arbitrary amount of
> > > >> > context lines when combined with -U<n>.
> > 
> > and achieve a `git log --oneline` report, given that -U<n> unfolds
> > the commits?
> 
> You can use "-s" to suppress patch output; as long as it comes after -U
> on the command-line, it will countermand the patch-format part.

That's a handy trick. Now the feature is really usable. Thanks.

> 
> (Of course it doesn't matter until we have a raw-diff grep, since
> otherwise the context lines do not matter at all, and you should just
> omit -U entirely).

Yep. Agreed.

> 
> -Peff

-- 
Best Regards,
Eugeniu.
