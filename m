Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D8E1F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 07:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCWHze (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 03:55:34 -0400
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:42170 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751395AbeCWHze (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Mar 2018 03:55:34 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Mar 2018 03:55:34 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 2AB67800491F
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 07:50:01 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D8489837F243;
        Fri, 23 Mar 2018 07:49:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rule08_3a01d3567765c
X-Filterd-Recvd-Size: 2456
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Mar 2018 07:49:58 +0000 (UTC)
Message-ID: <1521791397.24655.7.camel@perches.com>
Subject: Re: git send-email and sending the cover-letter to all cc addresses
 found in a patch series
From:   Joe Perches <joe@perches.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>, gitster@pobox.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Mar 2018 00:49:57 -0700
In-Reply-To: <20180323073858.GA12077@light.dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
         <20180322090059.19361-24-linux@dominikbrodowski.net>
         <20180322172959.GX4043@hirez.programming.kicks-ass.net>
         <CA+55aFwM8mMyZZ9wH2ExAkTKg9Mwie1hOtXz87ivi0nhsZ49Ug@mail.gmail.com>
         <20180323073858.GA12077@light.dominikbrodowski.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2018-03-23 at 08:38 +0100, Dominik Brodowski wrote:
> On Thu, Mar 22, 2018 at 10:44:54AM -0700, Linus Torvalds wrote:
> > On Thu, Mar 22, 2018 at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > But why !? Either Cc me on more of the series such that the whole makes
> > > sense, or better yet, write a proper Changelog.
> > 
> > This is a common issue. We should encourage people to always send at
> > least the cover-page to everybody who gets cc'd, even if they don't
> > get the whole series.
> 
> Will try to do that in future. Does git send-email have such an option? Or
> do I have to specify all cc addresses in the cover letter manually? I found
> some reference to an unresolved discussion on git@ of that topic in 2016, so
> I might not be the only one who could make use of that feature...

The main problem might be the quantity of recipients.

Many spam filters look at how many recipients on an email
to eliminate likely spam.

kernel.org mailing lists have a maximum email header size.
Too many recipients aren't delivered to the lists.

Using BCC could work, but replies then don't go to all
of the recipients.

Generally, I send only to listed the 0/n patch only
to lists and individual patches to maintainers.

