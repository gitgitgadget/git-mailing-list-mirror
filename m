Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0799920196
	for <e@80x24.org>; Thu, 11 May 2017 09:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754780AbdEKJJK (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:09:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:49237 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbdEKJJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:09:09 -0400
Received: (qmail 1098 invoked by uid 109); 11 May 2017 09:09:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 09:09:07 +0000
Received: (qmail 10149 invoked by uid 111); 11 May 2017 09:09:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 05:09:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 05:09:05 -0400
Date:   Thu, 11 May 2017 05:09:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 0/4] doc improvements for config includes
Message-ID: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
 <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
 <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
 <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net>
 <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
 <CACBZZX4ob04fG9ZZtvbdcqrYOKijoZohVdUCNyeayHZtdtNyxQ@mail.gmail.com>
 <20170511074257.xueofze3dv3xwrql@sigill.intra.peff.net>
 <CACBZZX6hpL0=Zw0kvB-Ww95uGvuJ8129MTwkmv7DOEE1i66a_Q@mail.gmail.com>
 <20170511075437.yjxs6oit7ibe7rkq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511075437.yjxs6oit7ibe7rkq@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 03:54:37AM -0400, Jeff King wrote:

> On Thu, May 11, 2017 at 09:49:09AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > > I don't like this because it copies the rules for _one_ property to the
> > > conditional section. What happens when you're looking for some other
> > > property of include.path?
> > 
> > Yeah, as I said once I wrote it up I found it wasn't really any
> > better, but just wanted to send an explanation for why I didn't find
> > it while I remembered, as a sort of case study.
> > [...]
> > > I suspect that whole paragraph under Includes could be reworded to make
> > > it clear that anything it is saying applies equally to include.$key and
> > > includeIf.*.$key, and then that would future-proof us for other
> > > modifications.
> 
> What about this:

I think this is the right path, but I actually ended up with an
introductory paragraph about the two sections. I hope it makes the same
point but is a bit less clunky.

Here's a series that I think covers all the bits discussed here, and a
few others.

  [1/4]: docs/config: clarify include/includeIf relationship
  [2/4]: docs/config: give a relative includeIf example
  [3/4]: docs/config: avoid the term "expand" for includes
  [4/4]: docs/config: consistify include.path examples

 Documentation/config.txt | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-Peff
