Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8749220899
	for <e@80x24.org>; Fri, 11 Aug 2017 21:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbdHKVSs (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 17:18:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:36610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753256AbdHKVSr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 17:18:47 -0400
Received: (qmail 31354 invoked by uid 109); 11 Aug 2017 21:18:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Aug 2017 21:18:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23199 invoked by uid 111); 11 Aug 2017 21:19:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Aug 2017 17:19:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Aug 2017 17:18:45 -0400
Date:   Fri, 11 Aug 2017 17:18:45 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170811211845.tpgmafenhahus77o@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
 <87y3qsg7ni.fsf@gmail.com>
 <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
 <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
 <20170811175237.GC59325@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170811175237.GC59325@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 10:52:37AM -0700, Brandon Williams wrote:

> On 08/09, Stefan Beller wrote:
> > On Wed, Aug 9, 2017 at 3:53 PM, Stefan Beller <sbeller@google.com> wrote:
> > 
> > > I would think based on these options, a pre commit hook can be
> > > written that formats precisely the touched lines of code of each file.
> > 
> > I did not search enough, "clang-tidy-diff.py --fix" should be all that is needed
> 
> I believe clang-tidy is different from clang-format am I mistaken?

Yeah, I just dug in the archive. The script I ran way back when was
actually clang-format-diff.

-Peff
