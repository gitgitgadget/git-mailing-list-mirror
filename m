Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DD01F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 07:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeCWHng (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 03:43:36 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35754 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCWHnf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 03:43:35 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 09779200901;
        Fri, 23 Mar 2018 07:43:34 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 1A46D20182; Fri, 23 Mar 2018 08:38:58 +0100 (CET)
Date:   Fri, 23 Mar 2018 08:38:58 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     gitster@pobox.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: git send-email and sending the cover-letter to all cc addresses
 found in a patch series
Message-ID: <20180323073858.GA12077@light.dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-24-linux@dominikbrodowski.net>
 <20180322172959.GX4043@hirez.programming.kicks-ass.net>
 <CA+55aFwM8mMyZZ9wH2ExAkTKg9Mwie1hOtXz87ivi0nhsZ49Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwM8mMyZZ9wH2ExAkTKg9Mwie1hOtXz87ivi0nhsZ49Ug@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 10:44:54AM -0700, Linus Torvalds wrote:
> On Thu, Mar 22, 2018 at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > But why !? Either Cc me on more of the series such that the whole makes
> > sense, or better yet, write a proper Changelog.
> 
> This is a common issue. We should encourage people to always send at
> least the cover-page to everybody who gets cc'd, even if they don't
> get the whole series.

Will try to do that in future. Does git send-email have such an option? Or
do I have to specify all cc addresses in the cover letter manually? I found
some reference to an unresolved discussion on git@ of that topic in 2016, so
I might not be the only one who could make use of that feature...

Thanks,
	Dominik
