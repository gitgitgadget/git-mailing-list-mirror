Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCA82018E
	for <e@80x24.org>; Thu, 11 Aug 2016 06:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbcHKGXq (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 02:23:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44422 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbcHKGXp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 02:23:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F93C2018E;
	Thu, 11 Aug 2016 06:23:44 +0000 (UTC)
Date:	Thu, 11 Aug 2016 06:23:44 +0000
From:	Eric Wong <e@80x24.org>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Richard Ipsum <richard.ipsum@codethink.co.uk>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160811062344.GA20280@starla>
References: <20160729064055.GB25331@x>
 <20160803191202.GA22881@salo>
 <20160804224058.po43kl7w26ockfie@x>
 <20160810093731.GA3404@salo>
 <13509A14-16CB-476C-B983-7001F3D0DA61@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13509A14-16CB-476C-B983-7001F3D0DA61@joshtriplett.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> wrote:
> On August 9, 2016 11:37:31 PM HST, Richard Ipsum <richard.ipsum@codethink.co.uk> wrote:
> 
> >Maybe there's a better solution to this problem than git-candidate
> >then,
> >maybe we can just invent some wonderful new subcommand that fetches
> >a mailing list archive into a git repo, for those that want that,
> >I don't know.
> 
> public-inbox seems to address that use case. I'd love to see a
> public-inbox version of LKML, with full history. I don't think
> that fully solves the review storage and interchange problem,
> but it seems like an *excellent* solution for email archiving,
> and for distribution of archives.

Thanks, I'd like to see an LKML version, too :)  First, I want
to ensure public-inbox can handle large repos better, first.
public-inbox.org/git has been doing well so far, even on a
low-end VM with 2 cores and 2GB RAM.

I don't have anything close to full history of LKML, and
download.gmane.org is down, right now :<  I'd use NNTP, but
news.gmane.org gets overloaded from slrnpull and I even got
temporarily banned there before discovering download.gmane
:x

Maybe I'll do what was done with linux.git in 2005 and just
ignore old mail for a while...
