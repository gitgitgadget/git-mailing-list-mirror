Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9E01FD99
	for <e@80x24.org>; Sat,  6 Aug 2016 23:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbcHFXl3 (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 19:41:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60998 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbcHFXl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 19:41:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3591F859;
	Sat,  6 Aug 2016 23:41:28 +0000 (UTC)
Date:	Sat, 6 Aug 2016 23:41:27 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] more archives of this list
Message-ID: <20160806234127.GA23580@starla>
References: <20160710004813.GA20210@dcvr.yhbt.net>
 <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
 <20160805093544.scvl4yshkfg2l26p@sigill.intra.peff.net>
 <20160805181957.GA24535@dcvr>
 <20160805202250.d23na5xdkmtnjgey@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160805202250.d23na5xdkmtnjgey@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> Thanks. That's definitely an improvement. I still think the styling
> could go further, but I don't expect you to do it. It's something I may
> look into, but I should probably try to clear out my backlog of
> "to-review" patches before I go off spending time on it. :)

Heh, and I've nearly been sidetracked into hacking w3m to
iframes, persistent connections, color-mapping, etc, too :x
Right now, I'm just happy w3m supports piping buffers to
arbitrary programs (so one could run "git am" on the /raw
endpoint).

It'll be tough to beat a good local mail setup some of us have
with mutt/gnus.  Being able to mark messages as read/unread
would either be intrusive (cookies/tracking users) or
cause accessibility problems (frames), I think...

...which is why the mbox.gz endpoints exist in public-inbox :>

So I think I'll try to do POP3 support, first...
