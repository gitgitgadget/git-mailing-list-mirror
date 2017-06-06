Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E2A20D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 01:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdFFBWC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 21:22:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:35179 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdFFBWB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 21:22:01 -0400
Received: (qmail 22346 invoked by uid 109); 6 Jun 2017 01:22:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 01:22:01 +0000
Received: (qmail 21028 invoked by uid 111); 6 Jun 2017 01:22:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 21:22:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jun 2017 21:22:00 -0400
Date:   Mon, 5 Jun 2017 21:22:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Hector Santos <winserver.support@winserver.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git "Keeping Original Dates"
Message-ID: <20170606012159.yqypreouvmmrfifd@sigill.intra.peff.net>
References: <5935C999.5060801@winserver.com>
 <CACBZZX4t+dJA-G9r+LuskmkpR5oR7+YMUSCZgL3GCgPcKkda2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4t+dJA-G9r+LuskmkpR5oR7+YMUSCZgL3GCgPcKkda2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 11:27:45PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Jun 5, 2017 at 11:14 PM, Hector Santos
> <winserver.support@winserver.com> wrote:
> > I'm implementing GIT.  If there an option or compile/version that "keep"
> > file timestamps?
> 
> The git datamodel stores files as a list of names and whether or not
> they have the executable bit.
> 
> If you need to set the ctime/mtime/whatever on the other side you'd do
> that via some script you'd ship with your repository.

There are existing scripts which implement this approach, like
metastore:

  https://github.com/przemoc/metastore

I haven't used it, but I think it's fairly mature, as it has been around
since the early days of Git.

-Peff
