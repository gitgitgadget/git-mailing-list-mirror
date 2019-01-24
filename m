Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A18211B5
	for <e@80x24.org>; Thu, 24 Jan 2019 04:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAXEfi (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 23:35:38 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55260 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfAXEfi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 23:35:38 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C32131F453;
        Thu, 24 Jan 2019 04:35:37 +0000 (UTC)
Date:   Thu, 24 Jan 2019 04:35:37 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: testing some changes to a public-inbox .onion
Message-ID: <20190124043537.ckuwxgn66enqyzsv@dcvr>
References: <20190121210024.7ywfhke2rwxzjx77@dcvr>
 <nycvar.QRO.7.76.6.1901231137040.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1901231137040.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 21 Jan 2019, Eric Wong wrote:
> >        http://hjrcffqmbrq6wope.onion/git/
> > 
> > Tested with Netsurf and dillo.
> 
> Nice.
> 
> Do you also plan on taking care of the regular thread view? I still find
> it *very* hard to navigate it, and I have to admit that I am spoiled by
> the web UIs I use regularly: an aesthetically pleasing interface does
> contribute to my joy.

Hi Johannes,

Do you have suggestions which work with non-JS browsers such as
dillo and Netsurf?

I'm not sure how much free time I can dedicate to UI issues,
which tend to be a very personal choice...  MY idea of a
pleasing UI is: fast on a small, old laptop (where 24-bit
color is unusably slow), using GIGANTIC fonts on a black
background 8-)

The thread skeleton could probably use tables to make
line-wrapping more readable when wrapped on small screens
(w3m couldn't wrap <pre>, but dillo does)

Otherwise, perhaps having a larger set of supported + stable CSS
class/id names to enable user-side customizations would be
possible.

Fwiw, the $MESSAGE_ID/t.atom endpoint also supports Atom threading:

	https://tools.ietf.org/html/rfc4685

So I imagine it would be easy for a UI expert to build on
top of that.

The current thread view also works nicely when my connection
drops, since all the articles get linked to anchors on the
same page.

> > And there's a big fairness problem with the current
> > implementation of bl^H^Ha "new feature" :>

Did you notice the unique new feature?  It's not something I've
seen anywhere else, and it might not be obvious regardless of
browser you use.  The thing I'm referring to has a "debug log"
at the bottom of the page :)

So I think my (limited) time would be better spent making sure
performance is top notch so others can build fast UIs on top of
it; and there might be something else along those lines in the
pipeline...
