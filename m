Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_HEX
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5460C20281
	for <e@80x24.org>; Tue, 26 Sep 2017 20:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967769AbdIZUTW (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 16:19:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47650 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937099AbdIZUTV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 16:19:21 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Sep 2017 16:19:21 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D4C0720281;
        Tue, 26 Sep 2017 20:11:12 +0000 (UTC)
Date:   Tue, 26 Sep 2017 20:11:12 +0000
From:   Eric Wong <e@80x24.org>
To:     Marc Herbert <Marc.Herbert@intel.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andy Lowry <andy.work@nglowry.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>,
        Christian Kujau <lists@nerdbynature.de>, josh@joshtriplett.org,
        michael.w.mason@intel.com, linux-kernel@vger.kernel.org
Subject: Re: BUG in git diff-index
Message-ID: <20170926201112.GA26968@whir>
References: <loom.20160331T143733-916@post.gmane.org>
 <20160331140515.GA31116@sigill.intra.peff.net>
 <CAJxkE8SVF_ikHqDCh6eHExq=seitHPVpxW2GmPo40jtqWvz1JQ@mail.gmail.com>
 <20160331142704.GC31116@sigill.intra.peff.net>
 <56FD7AE8.4090905@nglowry.com>
 <xmqqwpoil6vt.fsf@gitster.mtv.corp.google.com>
 <d9b4725b-3204-03af-1bc2-6469bb815c63@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9b4725b-3204-03af-1bc2-6469bb815c63@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Herbert <Marc.Herbert@intel.com> wrote:
> PS: I used NNTP and http://dir.gmane.org/gmane.comp.version-control.git
> to quickly find this old thread (what could we do without NNTP?). Then
> I googled for a web archive of this thread and Google could only find
> this one: http://git.661346.n2.nabble.com/BUG-in-git-diff-index-tt7652105.html#none
> Is there a robots.txt to block indexing on
> https://public-inbox.org/git/1459432667.2124.2.camel@dwim.me ?

There's no blocks on public-inbox.org and I'm completely against
any sort of blocking/throttling.  Maybe there's too many pages
to index?  Or the Message-IDs in URLs are too ugly/scary?  Not
sure what to do about that...

Anyways, I just put up a robots.txt with Crawl-Delay: 1, since I
seem to recall crawlers use a more conservative delay by default:

==> https://public-inbox.org/robots.txt <==
User-Agent: *
Crawl-Delay: 1


I don't know much about SEO other than keeping a site up and
responsive; so perhaps there's more to be done about getting
things indexed...
