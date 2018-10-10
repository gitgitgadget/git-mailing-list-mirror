Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1511F1F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 17:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJKBJi (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 21:09:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:35774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726562AbeJKBJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 21:09:38 -0400
Received: (qmail 32118 invoked by uid 109); 10 Oct 2018 17:46:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Oct 2018 17:46:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19888 invoked by uid 111); 10 Oct 2018 17:45:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 13:45:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 13:46:24 -0400
Date:   Wed, 10 Oct 2018 13:46:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git svn clone/fetch hits issues with gc --auto
Message-ID: <20181010174624.GC8786@sigill.intra.peff.net>
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
 <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
 <20181009234502.oxzfwirjcew2sxrm@dcvr>
 <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
 <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com>
 <878t36f3ed.fsf@evledraar.gmail.com>
 <CACPiFCKMF2di=waQ5reRtjUFEjuE6DkxxLcN-YnF-SqgE_m=_Q@mail.gmail.com>
 <875zyaf2f1.fsf@evledraar.gmail.com>
 <20181010165152.GA180779@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010165152.GA180779@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 09:51:52AM -0700, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
> 
> > I'm just saying it's hard in this case to remove one piece without the
> > whole Jenga tower collapsing, and it's probably a good idea in some of
> > these cases to pester the user about what he wants, but probably not via
> > gc --auto emitting the same warning every time, e.g. in one of these
> > threads I suggested maybe "git status" should emit this.
> 
> I have to say, I don't have a lot of sympathy for this.
> 
> I've been running with the patches I sent before for a while now, and
> the behavior that they create is great.  I think we can make further
> refinements on top.  To put it another way, I haven't actually
> experienced any bad knock-on effects, and I think other feature
> requests can be addressed separately.

I think there may be some miscommunication here. The Jenga tower above
is referring (I think) to Jonathan Tan's original patch to drop the
warning entirely, which does have some unwanted side effects.

Your patches are much less controversial, I think, and are in next and
marked as "will merge to master" in the last "what's cooking".

-Peff
